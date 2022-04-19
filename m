Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB018506C19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352049AbiDSMRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiDSMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D21FA5D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B13A614E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51361C385A7;
        Tue, 19 Apr 2022 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650370503;
        bh=egk3NV7ZTPANDM1QUGV3BN2ZMc0MwzdTAMdoUxfarx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpm43+mezkvM6YP/nwkJWU6CBtHl+xZ4KAgQrH6K1vUjE/GyQA70B0fhT9keBk58y
         NvLd6s7NIbwO0Ofi0TRXxQDRzLeO91x26/8dYnfLweVVkCcHSN7Gzkrj7LqdhaWmrU
         m7zRgCASPhbodzPxWwKB8N864xdfxNoxC9RyzLrM=
Date:   Tue, 19 Apr 2022 14:14:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <Yl6nw6jbfVsVXG0c@kroah.com>
References: <20220418164356.3532969-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418164356.3532969-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:43:56PM -0400, Tom Rix wrote:
> Smatch reports this issue
> vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init'
>   was not declared. Should it be static?

Error messages can all go on one line.

> vchiq_platform_init is only used in vchiq_arm.c.  Single
> file variables should not be global so change
> vchiq_platform_init's storage-class specifier to static.

You have a full 72 columns, please use them.

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 0596ac61e286..7de98655e8ec 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -463,7 +463,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>  	cleanup_pagelistinfo(pagelistinfo);
>  }
>  
> -int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
> +static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
> -- 
> 2.27.0
> 
> 

Always test build your patches.  To not do so is a bit rude, don't you
think?

{sigh}
