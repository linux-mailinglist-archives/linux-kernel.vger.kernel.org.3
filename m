Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6514529E40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiEQJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245104AbiEQJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:41:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4633D48F;
        Tue, 17 May 2022 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652780458; x=1684316458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4LPo/fqfv4brQeDZi/w/on11+gURa50LBTaOEz91bA0=;
  b=T0YJG1Vb8/2nPWxM5KFyElCRWD/4MGvGgDqeKK/iknHbEZIuE6un0IDw
   GZ0H3NWnv2jlwZvfgZqNYy1KK296ArKHyzj0cTdQ9Dwki4N0Gw9g/mbbP
   kTjHW4q7YWj0kc3ybXEH0KqN2eiTlYH8uyWMlc2CjfDtXHDYFsfth/7Aa
   bhBq2X5GOVSxj6PHDR7T735I8b4rmwZa6AXFqAEjWrd0GRlOupz71MowG
   DE4dyUnETuDsxY1WhBum8y0f0xsHHdU/VoohAPSBBbUyg50R9bgrbWMy3
   Wmce9sfmsMEcAXUTpkwsXlljS3Q47rGPjknJC2XN2oML+EyFcpT5gXhF3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="253179278"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="253179278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="713778250"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2022 02:40:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 May 2022 12:40:54 +0300
Date:   Tue, 17 May 2022 12:40:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] usb: typec: ucsi: fix return value check in
 ucsi_acpi_probe()
Message-ID: <YoNtppG+XCAP5LW6@kuha.fi.intel.com>
References: <20220516131527.999909-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516131527.999909-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 09:15:27PM +0800, Yang Yingliang wrote:
> If memremap() fails, it never returns NULL. Replace NULL check
> with IS_ERR().

There's already a fix pending for this:
https://patchwork.kernel.org/project/linux-usb/patch/YnjaDBXLmwouCB3M@kili/

thanks,

> Fixes: cdc3d2abf438 ("usb: typec: ucsi: acpi: Map the mailbox with memremap()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 7455e3aff2be..8873c1644a29 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -133,8 +133,8 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  	}
>  
>  	ua->base = devm_memremap(&pdev->dev, res->start, resource_size(res), MEMREMAP_WB);
> -	if (!ua->base)
> -		return -ENOMEM;
> +	if (IS_ERR(ua->base))
> +		return PTR_ERR(ua->base);
>  
>  	ret = guid_parse(UCSI_DSM_UUID, &ua->guid);
>  	if (ret)

-- 
heikki
