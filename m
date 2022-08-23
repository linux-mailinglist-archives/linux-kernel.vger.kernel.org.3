Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607159D504
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiHWIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbiHWI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:27:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB074BA7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661242499; x=1692778499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7zmWejdZuev7ngTwo5eoEvHxIaRq/RdYNea6XiCCs4=;
  b=I9Y93gW750+ofaQRSHe26+o/BFXMDJrcgCGPIncpPfzsasTGEiIw7F/d
   j07GlvQuCWub4s8SO+5QLsGDqSp2/4Nk7O+AXy5h2Op6cmh39m2y91Krf
   IpyVVkvZflUIc6oZvLdgzUEkSShqK/CY8W5BeE+6h9z4pHhNxU+8qfiBC
   ThkwAu+tzeO02lzq6BjvEqAvyBrkav6lIA8GVKLFFksTrfpFiFOjnydPg
   CAj4WAR9KB7G/iWemIE5H5g5u9YYSF9esGmUoxL8tC53wwtrKGs4iRZVD
   Tb11r9VMhmXzLvulYXnk0ayL/NorS2LsZ6WYPxqaqemtX5i/TQ3HTWKfU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379914838"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="379914838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751605160"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2022 01:14:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 23 Aug 2022 11:14:25 +0300
Date:   Tue, 23 Aug 2022 11:14:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_typec: Correct alt mode
 index
Message-ID: <YwSMYb67PMAEkv8f@kuha.fi.intel.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-3-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 19, 2022 at 07:08:03PM +0000, Prashant Malani wrote:
> Alt mode indices used by USB PD (Power Delivery) start with 1, not 0.
> 
> Update the alt mdoe registration code to factor this in to the alt mode
> descriptor.
> 
> Fixes: de0f49487db3 ("platform/chrome: cros_ec_typec: Register partner altmodes")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Shouldn't this be applied also to the stable kernels?

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 4d81d8d45b73..dc5722db2066 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -698,7 +698,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  		for (j = 0; j < sop_disc->svids[i].mode_count; j++) {
>  			memset(&desc, 0, sizeof(desc));
>  			desc.svid = sop_disc->svids[i].svid;
> -			desc.mode = j;
> +			desc.mode = j + 1;
>  			desc.vdo = sop_disc->svids[i].mode_vdo[j];
>  
>  			if (is_partner)
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 
heikki
