Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1934A4980
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiAaOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiAaOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:39:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D316C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:39:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u14so27228469lfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzKdvDWI9cfPi4ztVSGxYkBmrqKhHHJF23hXiByBnDU=;
        b=E/PA4Gz5Ivfh437Err49tSH/yazlUur3pqzJa27lvXl1M9+J/QDuV3toSkQnz+Jskl
         Jd3/qtkEZ6jzbb+VwEUuMWc6w6mgJ9kOKUaW6MtMoyYQeE07t9k8q3nxVYv8RzA558nC
         u+msb7MptubGrtAq5/Zihy+IQdWygGTUH7iXrzpRX8bk93/6B/2zkIjJ8lVTDf0miCb4
         ZblPe8ZooX7mhVKQqxQrTlbL/bg9xKVQMwUZylSNiTBpaBeZaHUAZaaHUXKO3od/9N+X
         pWUeHFzhIsN6j5WdhGMWxy+0xcY/VWV9f54siehUeyLQeJLHuorLjvUDmg+kQ/iespaq
         EDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzKdvDWI9cfPi4ztVSGxYkBmrqKhHHJF23hXiByBnDU=;
        b=nGxBUBT0APVoTQKkctWlh8grEmUn+xypL+Pkgc7re/PY3DChEclNV7o1BU1SQMGNYN
         wgjGLjKobWt1swhbCuq+4ZsUUVMKZ5fRNgjJMNF1q5IDVPcG7F+9xMMlehymh/yDtA3O
         LjFEmMrfka5i9fgLvEENRm3Iu1DfJ7hmAZsnXyoV9yyEdNMxs0GLOcjQ99D4FcaM7z7D
         oKCh3bNI1G7PXfBhVqcRy6yBC+tYfbi+RqskbXeZ43kgpFvMfKWCWLrF6IF+YS8Fe2sd
         PGZzqXNR7F8wYFHkfhA0QsIb0Y7DhBsfxHeFoASF19scFZp9xtbiyFnEuxEdN70X0BrB
         VGyg==
X-Gm-Message-State: AOAM532zfwdeJNciKYTDC8PFZ3Mbl09UcIewdJlALCVVcODssWkaZ2Yr
        DcrL6MFwDWY/DlAewAsU2m1WvUvmtdDiS4VhfqQD0w==
X-Google-Smtp-Source: ABdhPJzr4AKuGZb0oc8Yf7NlZTAeVKsk1H3sQ+ng+YzTmdG0pZdvebsY68Y4jem072HHkTrkeurPblMrSmZ1lgc5BZE=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr14254558lfv.71.1643639982851;
 Mon, 31 Jan 2022 06:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20220127071638.4057899-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220127071638.4057899-1-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 15:39:06 +0100
Message-ID: <CAPDyKFqt0aeLL1K3wRR1HF4Lf6t6UU94PmMxXys5Wc6fYjDBdA@mail.gmail.com>
Subject: Re: [PATCH v2] moxart: fix potential use-after-free on remove path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, stable <stable@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 at 08:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It was reported that the mmc host structure could be accessed after it
> was freed in moxart_remove(), so fix this by saving the base register of
> the device and using it instead of the pointer dereference.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: Xin Xiong <xiongx18@fudan.edu.cn>
> Cc: Xin Tan <tanxin.ctf@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable <stable@vger.kernel.org>
> Reported-by: whitehat002 <hackyzh002@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
> v2: changed to only move mmc_free_host() call as per Ulf's request
>
>  drivers/mmc/host/moxart-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 16d1c7a43d33..b6eb75f4bbfc 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -705,12 +705,12 @@ static int moxart_remove(struct platform_device *pdev)
>         if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>                 dma_release_channel(host->dma_chan_rx);
>         mmc_remove_host(mmc);
> -       mmc_free_host(mmc);
>
>         writel(0, host->base + REG_INTERRUPT_MASK);
>         writel(0, host->base + REG_POWER_CONTROL);
>         writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
>                host->base + REG_CLOCK_CONTROL);
> +       mmc_free_host(mmc);
>
>         return 0;
>  }
> --
> 2.35.0
>
