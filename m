Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00CD588761
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiHCGaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHCGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608160C8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93EA4614C8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E399C433D6;
        Wed,  3 Aug 2022 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659508236;
        bh=uRiFD4YkF3E1o4CEeQJKWDz+kcz0iU4N40GXcvKkJec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVLnA6aVgSIxEDyB653YdR2hEn2+osHv2mIR9xkaPNhXk+Au8W4iuxA1fgukQlMwJ
         G2s+8yWQXRtd7TmeMcRJvFFqxc4xc5OASyevz8Tu5XcHNfJRqM8iVmNgo93lJhhh1f
         vmjYO7pOFv3+ejbQ9l7hNAIRFNdbLVGHmmVPKOCk=
Date:   Wed, 3 Aug 2022 08:30:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] staging: greybus:using the
Message-ID: <YuoWCSQCnNU3DrUL@kroah.com>
References: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 06:22:58AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/greybus/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index e546c6431877..b9063e86534b 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -174,9 +174,8 @@ static int greybus_probe(struct device *dev)
>  	if (!id)
>  		return -ENODEV;
>  
> -	retval = pm_runtime_get_sync(&bundle->intf->dev);
> +	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
>  	if (retval < 0) {
> -		pm_runtime_put_noidle(&bundle->intf->dev);
>  		return retval;
>  	}
>  
> -- 
> 2.25.1

Now this is just being silly.  Consider all future emails also dropped.

greg k-h
