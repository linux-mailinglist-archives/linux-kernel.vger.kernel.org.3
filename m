Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62EA4EAB54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiC2Kgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiC2Kg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:36:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A442CCAB;
        Tue, 29 Mar 2022 03:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9057CB80CC7;
        Tue, 29 Mar 2022 10:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F7C340F2;
        Tue, 29 Mar 2022 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648550080;
        bh=40vaXYujECRPq759yjf622O1qcpWEybCd8NmkHOSJaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snHq0s20x5wvipHdOhtp0coIZowOd8cxckpZcwBPooemfF0a58YAJa//9IVURfyOL
         FZE4qLb3hmMYbG7ZUky2YM7R9ZVTd/64eIV7uVms2jgtW3pOxJL6GmrwxM6TMo/s46
         +jy2ghow4EEOxzTY22OEXdPECL/oYjqEau3o2Toc=
Date:   Tue, 29 Mar 2022 12:34:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     QintaoShen <unSimple1993@163.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, yanaijie@huawei.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: ralink: rt2880: Check for return value of
 devm_kcalloc()
Message-ID: <YkLgvcHMKwxoOyP1@kroah.com>
References: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:50:12PM +0800, QintaoShen wrote:
> The memory allocation function devm_kcalloc() may return NULL pointer,
> so it is better to add a check for 'p->func[i]->pins' to avoid possible
> NULL pointer dereference.
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
>  drivers/pinctrl/ralink/pinctrl-rt2880.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
> index 96fc06d..308610e 100644
> --- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
> +++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
> @@ -266,6 +266,10 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
>  						p->func[i]->pin_count,
>  						sizeof(int),
>  						GFP_KERNEL);
> +        
> +        if (!p->func[i]->pins)
> +            continue;
> +
>  		for (j = 0; j < p->func[i]->pin_count; j++)
>  			p->func[i]->pins[j] = p->func[i]->pin_first + j;
>  
> -- 
> 2.7.4
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
