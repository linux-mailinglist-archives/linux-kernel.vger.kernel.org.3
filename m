Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941174739B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbhLNAlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:41:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhLNAlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:41:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 001B9B81729;
        Tue, 14 Dec 2021 00:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AB8C34603;
        Tue, 14 Dec 2021 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639442502;
        bh=FO7GgzjWU/qyhUV5Wjn+qT3hf7OTOQWpwBaqn+IhpT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMTcCD6HUdPg26enS6xT2YPMwwn8g1fC3+RLdva7+4EsZf5mCuQ6RhuG1VzM0PnyR
         xkwZ3oECRYK2ZGYHZKJSOZP7OlRo40U07N5NatKEQef9r6mMw3vDb1LrOh8s+/8B09
         b9Uzm5p0lhOQNEpEKfcsh0NoeGvyJIi/pmiVeH7Qwatqzbzq0IMnLntvTpGZMpd5RC
         3BW3RjB8gRKN0aQiJ5KvsuYFJSlHq52hUoV8tkgjX55qF3XZFrfmmKBl0A5F6R6m9W
         SDfxRuhWL0MSxeNmifuzLI6U78EGD3S/PBpfUDHEylijHLxJvZCVVXY37WOv7WtNYh
         E2llqsaR/qQ+Q==
Date:   Mon, 13 Dec 2021 18:47:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] rtc: Move variable into switch case statement
Message-ID: <20211214004721.GA74477@embeddedor>
References: <20211209043915.1378393-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209043915.1378393-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:39:15PM -0800, Kees Cook wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> drivers/rtc/dev.c: In function 'rtc_dev_ioctl':
> drivers/rtc/dev.c:394:30: warning: statement will never be executed [-Wswitch-unreachable]
>   394 |                         long offset;
>       |                              ^~~~~~
> 
> Fixes: 6a8af1b6568a ("rtc: add parameter ioctl")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/rtc/dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
> index e104972a28fd..69325aeede1a 100644
> --- a/drivers/rtc/dev.c
> +++ b/drivers/rtc/dev.c
> @@ -391,14 +391,14 @@ static long rtc_dev_ioctl(struct file *file,
>  		}
>  
>  		switch(param.param) {
> -			long offset;
>  		case RTC_PARAM_FEATURES:
>  			if (param.index != 0)
>  				err = -EINVAL;
>  			param.uvalue = rtc->features[0];
>  			break;
>  
> -		case RTC_PARAM_CORRECTION:
> +		case RTC_PARAM_CORRECTION: {
> +			long offset;
>  			mutex_unlock(&rtc->ops_lock);
>  			if (param.index != 0)
>  				return -EINVAL;
> @@ -407,7 +407,7 @@ static long rtc_dev_ioctl(struct file *file,
>  			if (err == 0)
>  				param.svalue = offset;
>  			break;
> -
> +		}
>  		default:
>  			if (rtc->ops->param_get)
>  				err = rtc->ops->param_get(rtc->dev.parent, &param);
> -- 
> 2.30.2
> 
> 
> 
> 
