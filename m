Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152DB5A5679
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiH2VtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiH2VtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:49:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03549E8A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661809751; x=1693345751;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iFb7qo5wOiFrfJA6ZbVVrfEMUmHlZzqG1H/7tvlXzGE=;
  b=JORu4zcZIVXknlmqhs9BOVtCglWXtTFH4p9AB2itKiZnJ+zI2GLM7fF7
   A7uQFesb0fKLrhV8MppsPRw4LRDY/TTfNNYeJL8I1A/b14QVmJ9bi7zZY
   /0/p2d/PEGFayt90kx0MM4CsBA0Z1njmyn+a61nyc1nzlS9fAlfbxoBGR
   49eSPrKcKfHuRMsbNAbYWTuG+OLQuuZpKlbt3lHfg+aylrkTqTH0XPkZv
   Ya24CYrhQPuG6vKjTCfPQ7rA9YM0Tv3w5xD4pytZkdgGuijZqZ1zwqzzv
   Ilr9cs/2gGQF8YNtoT219v7DrQdAIj6qEliaf0IzOJH98XQuU2j3u9MYo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321131923"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="321131923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 14:49:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="787245164"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 14:49:10 -0700
Date:   Mon, 29 Aug 2022 14:49:11 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Russ Weight <russell.h.weight@intel.com>
cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] firmware_loader: Fix use-after-free during
 unregister
In-Reply-To: <20220829174557.437047-1-russell.h.weight@intel.com>
Message-ID: <alpine.DEB.2.22.394.2208291448450.2106446@rhweight-WRK1>
References: <20220829174557.437047-1-russell.h.weight@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2022, Russ Weight wrote:

> In the following code within firmware_upload_unregister(), the call to
> device_unregister() could result in the dev_release function freeing the
> fw_upload_priv structure before it is dereferenced for the call to
> module_put(). This bug was found by the kernel test robot using
> CONFIG_KASAN while running the firmware selftests.
>
>  device_unregister(&fw_sysfs->dev);
>  module_put(fw_upload_priv->module);
>
> The problem is fixed by copying fw_upload_priv->module to a local variable
> for use when calling device_unregister().
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Looks good to me.

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: Rebased to latest linux-next branch (next-20220829)
> ---
> drivers/base/firmware_loader/sysfs_upload.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 87044d52322a..63e15bddd80c 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -377,6 +377,7 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
> {
> 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
> 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
> +	struct module *module = fw_upload_priv->module;
>
> 	mutex_lock(&fw_upload_priv->lock);
> 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
> @@ -392,6 +393,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>
> unregister:
> 	device_unregister(&fw_sysfs->dev);
> -	module_put(fw_upload_priv->module);
> +	module_put(module);
> }
> EXPORT_SYMBOL_GPL(firmware_upload_unregister);
> -- 
> 2.25.1
>
>
