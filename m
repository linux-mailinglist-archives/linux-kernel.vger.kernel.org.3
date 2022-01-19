Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F6F493D04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355759AbiASPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355766AbiASPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:22:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EBFC06176D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:22:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v123so5695178wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usKOzHTqDlxMHaMrzpxLAl/X0LyI8/CbyeCUrjTWq9k=;
        b=ackHKEoZK3RCD5tfQsLKKL09VAzMa49DHmF4BgVjWukz1/DnbE5aOjfFSoYBSGe9E6
         FVmizbjhR5rmXyPdXC8TswIfvvWJq67nuaxKKaxNNCyD+LnmU9V7gidTtJ6/o/jXJ36/
         w4532Hdtr0RWZY1Ur+03BvQGfkoIY6Qv4D0fDU7a1X40SqSUgxgDpjxDwbCF5Y6TBQk4
         pEjp1iCOkXpA5esFqn5CjPy5kUfFh5tXoh04oLLFPhmgVr6z3gvZm67RZOS/I8jI5sDC
         wLyB8N1HcAM+Vwwq9NLWA/VcM9xb4P/OKXAGhjL/nI5EM+1/Rrccz9Ux5/hpTssiXLFD
         BO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usKOzHTqDlxMHaMrzpxLAl/X0LyI8/CbyeCUrjTWq9k=;
        b=lY/j6ftzuxtzdatzHl5LTff0wTkdPeUTlyxA7nyyYjhbjzMEVffuoql+DIdyYoS9Fr
         Ylva7KQ/ej7eTjc4HoFwYoed0oNA7ALaaShYaBFr7ppQZeSIal3anRZIOBxtroymLiVn
         H4kBnlww8Z8U1BoJ8ybnhKfbWq2ISomZvG5s+op4ychHciSbmSMW1cnk//WpnlcEkFsI
         ZlpUI5WJQ14P56yJLUln/Cbk3g9uC8BMG6Hg+I8BtMdU6cefg+EyuIakf1IcGoEKIkZz
         RHQt0Tua7drJfENGohV210dlAjeQPfwrZywOY8R7iSF5xUdXlyYXLEsMAtSc4LqblME+
         JIZA==
X-Gm-Message-State: AOAM532RDreWpanYz+i5NthJBAjrt/MzQJIM5ELYbg9jTbP5LS/r3GUJ
        2sERANVGa5ljYhky+wHBqhC5xdEAo8AnWBU/0J/8ZQ==
X-Google-Smtp-Source: ABdhPJwxrLEEFkkNXFaoF7sVZXJ04JNlpjOC76m88qV7aBTNHfuPX8FFAbqvmpWqNE0R8qFfpQ7l8U03n6xR7Ur5F0U=
X-Received: by 2002:a5d:588e:: with SMTP id n14mr11663891wrf.658.1642605748846;
 Wed, 19 Jan 2022 07:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20220114173254.1876151-1-james.clark@arm.com> <20220114173254.1876151-2-james.clark@arm.com>
In-Reply-To: <20220114173254.1876151-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 19 Jan 2022 15:22:17 +0000
Message-ID: <CAJ9a7VhedrLMKfXBqzD_9fFxzKTg63-9wUM38Tw6ukhmSR9aoA@mail.gmail.com>
Subject: Re: [PATCH 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
To:     James Clark <James.Clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Fri, 14 Jan 2022 at 17:33, James Clark <james.clark@arm.com> wrote:
>
> It's impossible to program a valid value for TRCCONFIGR.QE
> when TRCIDR0.QSUPP==0b10. In that case the following is true:
>
>   Q element support is implemented, and only supports Q elements without
>   instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.
>
> Currently the low bit of QSUPP is checked to see if the low bit of QE can
> be written to, but as you can see when QSUPP==0b10 the low bit is cleared
> making it impossible to ever write the only valid value of 0b11 to QE.
> 0b10 would be written instead, which is a reserved QE value even for all
> values of QSUPP.
>
> The fix is to allow writing the low bit of QE for any non zero value of
> QSUPP.
>
> This change doesn't go any further to validate if the user supplied value
> is valid, because none of the other parts this function do, but it does fix
> the case where it was impossible to ever set a valid value.
>

I concur that the input is not checked as valid, However all the other
fields are single bit - with no invalid values - other than the cond
field, which controls tracing of non-branch conditionals -
architecturally unsupported for A profile in ETMv4/.


> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a0640fa5c55b..a99bb537ea23 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -368,7 +368,7 @@ static ssize_t mode_store(struct device *dev,
>         /* start by clearing QE bits */
>         config->cfg &= ~(BIT(13) | BIT(14));
>         /* if supported, Q elements with instruction counts are enabled */
> -       if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
> +       if ((mode & BIT(0)) && drvdata->q_support)
>                 config->cfg |= BIT(13);

This can be trivially changed to

if ((mode)  && drvdata->q_support)
         config->cfg |= BIT(13);

to ensure that any input mode 2'b01, 2'b10, 2'b11 results in output
settings of 2'b01, 2'b11, 2'b11 respectively

With that

Reviewed-by: Mike Leach <mike.leach@linaro.org>

>         /*
>          * if supported, Q elements with and without instruction
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
