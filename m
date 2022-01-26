Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288DC49C223
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiAZDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiAZDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:30:14 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8DC06161C;
        Tue, 25 Jan 2022 19:30:13 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h2so27029254qkp.10;
        Tue, 25 Jan 2022 19:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7anDpLimRE6bYis5gbdpa/RPki6eh1XfOHxrRk/P/4=;
        b=SXRlHFjRWC2Mv38MUu2FfMqDEb49bJZfxYE559Kw+D0Pn2YltH77SpBW3HH0YW5AsE
         m8kzbCMD9MZIkkdaMBt1JMXzZvL87DNz+apl6ePX/TZd6D1vEa2xLP9paVzPlpB014h9
         6RZ8KymN/gMgkdABfFHWVpzVAjSf0rYQjS5yktG4rHR6VGF8OAEdq4nqpvvJE1pRreRm
         qEtmS903LkbFXgqIFXymoOB30fFzO7Q+H8PFLqPdEYHjfqzuqV+Z7QsD3pCwq/2lJ9gm
         h+TZI7RIh7QW5QG05fDEDYNnEhfg5DP4DhdGFoRo5ptPvIqzokYrOMe0xQ5f3KanUOae
         L9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7anDpLimRE6bYis5gbdpa/RPki6eh1XfOHxrRk/P/4=;
        b=W9b3muUZtQSM6z1Db2YJp1EIHjTSbauHnZjLptqs+BluknAo4kUDTIPzlOiTLtCeWm
         8cTroX5iLZ3ATLp2QsTtGn51RoIKLas4YOi+aF/10zugUO3zT8V3P1A4oyixYQghLrxW
         P0tM15Nn6uvN0Q7JUch1g5YX0gLmhRPA4JH5hEA1k6M17wtCk09p5PL2L8zTTi6bt6VI
         JrUd3YfDCsS0M64GFfBkHr+c07L847s+UtnDAi55CtjtiDi+qxsQZzq/ucyPtzOiogJ0
         fulSrnXZBBLJqpk0t5IUYDIkSopWFDrACFXubbybP5Q8uX3NZFhcQ5xBycgkwAjN7KJd
         AAdg==
X-Gm-Message-State: AOAM5309rFMrcHmOlWomzrc3lGkVchFm7g8tpErzstf0uqz6za6qh55g
        kILTOXUY5wo4+t4ZUVryu+iUpRXhORDNXqoITTI=
X-Google-Smtp-Source: ABdhPJzOxLW8ANKOJuqP39xeWiTHWhbAJym/4GNx7fbso6asTpJBhG97tat7EMYA2eWqagLzlBUDXMJW3yhDFcy0HzY=
X-Received: by 2002:a05:620a:d95:: with SMTP id q21mr16790410qkl.74.1643167812983;
 Tue, 25 Jan 2022 19:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20220125021353.GA29777@embeddedor>
In-Reply-To: <20220125021353.GA29777@embeddedor>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 26 Jan 2022 11:30:55 +0800
Message-ID: <CADBw62opvW1kdZbjxc0SBidjn0teYLsrfxTqfKoua6x9O84Neg@mail.gmail.com>
Subject: Re: [PATCH][next] hwspinlock: stm32: Use struct_size() helper in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:07 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
>
> Also, address the following sparse warnings:
> drivers/hwspinlock/stm32_hwspinlock.c:84:32: warning: using sizeof on a flexible structure
>
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/hwspinlock/stm32_hwspinlock.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> index 5bd11a7fab65..716ad4401249 100644
> --- a/drivers/hwspinlock/stm32_hwspinlock.c
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -73,15 +73,14 @@ static int stm32_hwspinlock_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct stm32_hwspinlock *hw;
>         void __iomem *io_base;
> -       size_t array_size;
>         int i, ret;
>
>         io_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(io_base))
>                 return PTR_ERR(io_base);
>
> -       array_size = STM32_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
> -       hw = devm_kzalloc(dev, sizeof(*hw) + array_size, GFP_KERNEL);
> +       hw = devm_kzalloc(dev, struct_size(hw, bank.lock, STM32_MUTEX_NUM_LOCKS),
> +                         GFP_KERNEL);
>         if (!hw)
>                 return -ENOMEM;
>
> --
> 2.27.0
>


-- 
Baolin Wang
