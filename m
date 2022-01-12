Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573B148CDED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiALVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:40:32 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:45193 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiALVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642023600;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=C9K3tsw1DVfAhcGDUvIMCIJJwfXNhxlv/0SrOmFPm/o=;
    b=jLREmipLG+n1fMmuQS5UQZRs14UIigNgWXU96Mknv4q3f3yqdCTbUjhCbCX2+g4oJv
    APnvI2q57IpsHWdgAb+94CJ6tGiHD1jJMeBG4ovUt0opPqwthTjAx1g7bBBZamsEA0N8
    1k3SLegZtCMHxm079QNlfreM3BiGaMPFu1MOFaTxU7CkoiktQ1SJWa0CYNCgUBoKxFTd
    cIOLAQxrSKgK0Ex0OsutkFnJXNeH+S0RjsBRkfNVrS8hT/C2zq36GS5yAGUfXr6uYR+A
    WTYw34/tHlxMXNl/Al/R7GRRHLB8ZW+NDZGUYYEPCnAKvNlxYKyL7egSvMUQ8m99HQx6
    Z8RQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id h68d06y0CLdxbrB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 12 Jan 2022 22:39:59 +0100 (CET)
Date:   Wed, 12 Jan 2022 22:39:53 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel
 creation
Message-ID: <Yd9KebiZUjTuHtIM@gerhold.net>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-10-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-10-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+Cc Srinivas

On Wed, Jan 12, 2022 at 08:40:58PM +0100, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> RPM Firmware on variety of newer SoCs such as MSM8917 (also likely
> MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices) doesn't
> initiate opening of the SMD channel if it was previously opened by
> bootloader. This doesn't allow probing of smd-rpm driver on such devices
> because there is a check that requires RPM this behaviour.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

This is effectively a "Revert "Revert "rpmsg: smd: Create device for all
channels""":

https://lore.kernel.org/linux-arm-msm/20171212235857.10432-3-bjorn.andersson@linaro.org/
https://lore.kernel.org/linux-arm-msm/20180315181244.8859-1-bjorn.andersson@linaro.org/

Won't this cause the same regression reported by Srinivas again?

Thanks,
Stephan

> ---
>  drivers/rpmsg/qcom_smd.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 8da1b5cb31b3..6a01ef932b01 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1280,19 +1280,13 @@ static void qcom_channel_state_worker(struct work_struct *work)
>  	unsigned long flags;
>  
>  	/*
> -	 * Register a device for any closed channel where the remote processor
> -	 * is showing interest in opening the channel.
> +	 * Register a device for any closed channel.
>  	 */
>  	spin_lock_irqsave(&edge->channels_lock, flags);
>  	list_for_each_entry(channel, &edge->channels, list) {
>  		if (channel->state != SMD_CHANNEL_CLOSED)
>  			continue;
>  
> -		remote_state = GET_RX_CHANNEL_INFO(channel, state);
> -		if (remote_state != SMD_CHANNEL_OPENING &&
> -		    remote_state != SMD_CHANNEL_OPENED)
> -			continue;
> -
>  		if (channel->registered)
>  			continue;
>  
> -- 
> 2.34.1
> 
