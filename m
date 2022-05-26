Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C134E53562A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiEZWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiEZWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:48:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0235DFF5E;
        Thu, 26 May 2022 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653605330; x=1685141330;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMSmSNpMBgJBftMMiWlLGoyAo8SvccO53xyFJ9I01X0=;
  b=gP4vfugy7kfkiFkheLegRaWHu/NVFNp9osj79L64RIDjAyYSz51yNxdn
   XNCXCCcr/VRNpbxun5nEptP61NWBM7f9e19uv/l7RAg094X8YIlF6HRHQ
   D7u8x4jsHoqCfXKxnZG5x1gXCJFrvkoR4cw0archkaRcA5Rf5Oi1rakSU
   RLq0qwg1/gPRnJs0SD+qr6P7S4Y59UlnqNrIvd6kXJ4rTiBlbEOIEJKw9
   yvGpoLx3fNow06Mbuj2TAXw/b590zp0A7BLOAo1gAVwpJjxQsbRGqzMKv
   JkY9E6bUvsPLMoCwM8RLIOOE0Hc7oS7ICyh9h8p6Lried+/JzkNQnpZwR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="334959913"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="334959913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 15:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="677700139"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2022 15:48:50 -0700
Received: from okio-mobl.amr.corp.intel.com (unknown [10.209.38.119])
        by linux.intel.com (Postfix) with ESMTP id CDD06580B54;
        Thu, 26 May 2022 15:48:49 -0700 (PDT)
Message-ID: <9df6d96f9672b16ca88f5d2c7dd43c87ae938ad3.camel@linux.intel.com>
Subject: Re: [PATCH] [PATCH] platform/x86/intel: Fix pmt_crashlog array
 reference
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     David Arcari <darcari@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 26 May 2022 15:48:49 -0700
In-Reply-To: <20220526203140.339120-1-darcari@redhat.com>
References: <20220526203140.339120-1-darcari@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-26 at 16:31 -0400, David Arcari wrote:
> The probe function pmt_crashlog_probe() may incorrectly reference
> the 'priv->entry array' as it uses 'i' to reference the array instead
> of 'priv->num_entries' as it should.  This is similar to the problem
> that was addressed in pmt_telemetry_probe via commit 2cdfa0c20d58
> ("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic").
> 
> Cc: "David E. Box" <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> ---
>  drivers/platform/x86/intel/pmt/crashlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c
> b/drivers/platform/x86/intel/pmt/crashlog.c
> index 34daf9df168b..ace1239bc0a0 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -282,7 +282,7 @@ static int pmt_crashlog_probe(struct auxiliary_device
> *auxdev,
>  	auxiliary_set_drvdata(auxdev, priv);
>  
>  	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> -		struct intel_pmt_entry *entry = &priv->entry[i].entry;
> +		struct intel_pmt_entry *entry = &priv->entry[priv-
> >num_entries].entry;
>  
>  		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns,
> intel_vsec_dev, i);
>  		if (ret < 0)

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

Thanks

