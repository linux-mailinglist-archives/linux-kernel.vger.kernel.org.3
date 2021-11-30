Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABACF464044
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbhK3VfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbhK3VfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:35:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B60C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:31:43 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x10so28089890ioj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIjUhHqT3I7yZhNSyjjqGWIqrlg0jw98kAJKFJqT2YE=;
        b=f6wqnQVLJ/QypuLiFKBo++Q/jnDWh5SE3YACOp/LVwre7fBIRnF7XivKVEkvV3izbS
         Pz8sEFp6zKpHK/mtiaH1eJezYlGcD1sb1MCKEjXB8IPmSYucTxmb0zdmRT2mR250MUsC
         WVXvNyv/S+bVXzjGATk3wAXm8zrXOAd4t0y8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIjUhHqT3I7yZhNSyjjqGWIqrlg0jw98kAJKFJqT2YE=;
        b=CzYlwGM2hvMx4QZ6wG+/VzoIpc6Pnp8/VDpMwHnrh9kVoxWrklCg0BFTQFj7YnzdxW
         VqRJNVGBLdwYKNRtXJTCbd3L/WQUgU+iaGAhJgLv3s4QWJhTR1I5Wr3Gf6nrkTAuHFsn
         o8qNdbYgAs2QOdURqDx1j1S0oG5J/3/kXUbx9LroqUtymiTQYmwffHjSFftrc8Ta6l2d
         OFHIOoR50WfBbM2/gyqoUTbOhABY7r2K2BX3vgJn5lfDL/He8T06h19OgZYNv+O3L0a+
         4GgID9H1dQohZdg9e2dn1RTK3lUfWHM86CPltPqIS1Q/aODwofiTU0qjRauVEGU3DHcN
         cKDg==
X-Gm-Message-State: AOAM533Vhf8HkVfFejSfZRPQoCBx4rtLbqdcMLHI8RR/dcrrhTx8O6Xp
        OLXtxZU1lBSHcF1l0cttabz0rRFJNmwm2A==
X-Google-Smtp-Source: ABdhPJxMCQSb5B2qCfV+VEyr8+JFq1eMfsdrq6YA4I7IKRZIjnZE/TCMOSnQQeQ07QVQzAhRIDGEpw==
X-Received: by 2002:a6b:7e49:: with SMTP id k9mr2744575ioq.212.1638307903001;
        Tue, 30 Nov 2021 13:31:43 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id j15sm7619004ile.68.2021.11.30.13.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 13:31:42 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id p65so4054864iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:31:41 -0800 (PST)
X-Received: by 2002:a05:6638:2590:: with SMTP id s16mr3336928jat.93.1638307901229;
 Tue, 30 Nov 2021 13:31:41 -0800 (PST)
MIME-Version: 1.0
References: <1637909640-32232-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1637909640-32232-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Nov 2021 13:31:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W_LAJDKgLf5mZKe9Ku=GSvV=m4Tg=5VLYZWvT8=Ds10Q@mail.gmail.com>
Message-ID: <CAD=FV=W_LAJDKgLf5mZKe9Ku=GSvV=m4Tg=5VLYZWvT8=Ds10Q@mail.gmail.com>
Subject: Re: [PATCH V1] mtd: spi-nor: winbond: Add support for winbond chip
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 25, 2021 at 10:56 PM Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add support for winbond W25Q512NW-IM chip.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 96573f6..cdfa2ee 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -100,6 +100,9 @@ static const struct flash_info winbond_parts[] = {
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> +       {"w25q512nw", INFO(0xef8020, 0, 64 * 1024, 1024,
> +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>         { "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

I have no comments on the contents of this patch, but your spacing is
off. The entry above and below you have a space between the "{" and
the string with the name of the flash part. You should match.

-Doug
