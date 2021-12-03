Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39510466FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378040AbhLCCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:21:02 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60464
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244477AbhLCCVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:21:01 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB5EB40013
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638497857;
        bh=qfyozt5gD9lEmxnli46SoyRwFPECwlTwdID8kel9iLs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cd5HzG/Ru3tS1l3ybGnKgVzV7WtBRQVyV8fY9xkSS7ZV9bOJIlz3UVm4+QiaHla3u
         qTTRTY6NmxgDFemYNqrTHRmgCZWGVV2QiGFKpokQzBS+VanYz7zdnNIrhe8zOpAfhL
         iq7M61HQPqi2H4UsRZRb8xXuX/vVCYB0u4VY+r7UUcLDqQ9l3Uvnjuq65kM4ZeG5gq
         327RSbTCyaK9WqD9x64bl11CmQFy15W8vATkbGf3UbezxTmrzMhMYx9WqzJn4nmbZ4
         Ri3hIcKYRQwiMJ0whZtIP7fDbbAlu2+tTjP4709qDM0PHiFp0K9SjrA0Dw5+gcznP5
         bFtsUM8b6tMdg==
Received: by mail-ot1-f69.google.com with SMTP id y19-20020a0568301d9300b0056396063834so941741oti.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfyozt5gD9lEmxnli46SoyRwFPECwlTwdID8kel9iLs=;
        b=6wtNjp2cDPRSvBx0G57cB0cllZ5PvjPFZMkM2V/1ULEpmi2F64+4ZEn+0sFYC7HTU2
         KvEDkF2EnRUj/GL0uODFMKLwSVFBGHDQ3IKfLnqRwvIMc9NW0xxzwf73ZdAW87ymbmbF
         oY85yEZsWo3feXtlbplULj+PsrAG+s1FzNXo4xDva/O6EhP+B95m+QW0+W82P/MDdO10
         qO9CVURaia9AKWVpA3P5Y6+nvH332OccEL32TNJQZ9xAc3I3OqRmj1SauU6EYrPY1xpF
         GqOU5M7Bw8alZSfO+wgJZa19/cH1dzg4o6qTlcF7GUM0dYKrTNg1ArvVY7Pbr+B5LbIe
         n1yA==
X-Gm-Message-State: AOAM530jDBmxlHzW86lL59yt92GmocN2FilHh5OBMBT3aHbKIbBAT/An
        gJRKj7jZhlEgDZ3aCS+qqE80shQtaQqEc4VYdcZcfiVjNXApq3R2q9HXxwN9sgzyJvSJUYCLjD7
        PtqXLLXGNY8jHv8Pqnc1HlJsPiAQ+p8DgvHoBCfW1BrDi5oqbxpRTMmNjMw==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr13928433oti.269.1638497856395;
        Thu, 02 Dec 2021 18:17:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0Y5KK/9L3X38Sru202AtXDZcQ4avMirFEyU7tJSwXzVnljxw7vYZv9QuNQBb2h/lQrsMYJQTvZmdYLtCjxxc=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr13928407oti.269.1638497856117;
 Thu, 02 Dec 2021 18:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20211126003246.1068770-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211126003246.1068770-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 3 Dec 2021 10:17:24 +0800
Message-ID: <CAAd53p6_6hCPSm5G02wC1TWHyT_cwK-6KQh9ex+QwyE_P-ErBQ@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Avoid mangling IRQ during runtime PM
To:     Ricky Wu <ricky_wu@realtek.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On Fri, Nov 26, 2021 at 8:33 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> After commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM"), when the
> rtsx controller is runtime suspended, bring CPUs offline and back online, the
> runtime resume of the controller will fail:
>
> [   47.319391] smpboot: CPU 1 is now offline
> [   47.414140] x86: Booting SMP configuration:
> [   47.414147] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   47.571334] smpboot: CPU 2 is now offline
> [   47.686055] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [   47.808174] smpboot: CPU 3 is now offline
> [   47.878146] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [   48.003679] smpboot: CPU 4 is now offline
> [   48.086187] smpboot: Booting Node 0 Processor 4 APIC 0x1
> [   48.239627] smpboot: CPU 5 is now offline
> [   48.326059] smpboot: Booting Node 0 Processor 5 APIC 0x3
> [   48.472193] smpboot: CPU 6 is now offline
> [   48.574181] smpboot: Booting Node 0 Processor 6 APIC 0x5
> [   48.743375] smpboot: CPU 7 is now offline
> [   48.838047] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [   48.965447] __common_interrupt: 1.35 No irq handler for vector
> [   51.174065] mmc0: error -110 doing runtime resume
> [   54.978088] I/O error, dev mmcblk0, sector 21479 op 0x1:(WRITE) flags 0x0 phys_seg 11 prio class 0
> [   54.978108] Buffer I/O error on dev mmcblk0p1, logical block 19431, lost async page write
> [   54.978129] Buffer I/O error on dev mmcblk0p1, logical block 19432, lost async page write
> [   54.978134] Buffer I/O error on dev mmcblk0p1, logical block 19433, lost async page write
> [   54.978137] Buffer I/O error on dev mmcblk0p1, logical block 19434, lost async page write
> [   54.978141] Buffer I/O error on dev mmcblk0p1, logical block 19435, lost async page write
> [   54.978145] Buffer I/O error on dev mmcblk0p1, logical block 19436, lost async page write
> [   54.978148] Buffer I/O error on dev mmcblk0p1, logical block 19437, lost async page write
> [   54.978152] Buffer I/O error on dev mmcblk0p1, logical block 19438, lost async page write
> [   54.978155] Buffer I/O error on dev mmcblk0p1, logical block 19439, lost async page write
> [   54.978160] Buffer I/O error on dev mmcblk0p1, logical block 19440, lost async page write
> [   54.978244] mmc0: card aaaa removed
> [   54.978452] FAT-fs (mmcblk0p1): FAT read failed (blocknr 4257)
>
> There's interrupt immediately raised on rtsx_pci_write_register() in
> runtime resume routine, but the IRQ handler hasn't registered yet.
>
> So we can either move rtsx_pci_write_register() after rtsx_pci_acquire_irq(),
> or just stop mangling IRQ on runtime PM. Choose the latter to save some
> CPU cycles.
>
> BugLink: https://bugs.launchpad.net/bugs/1951784
> Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

May I get an Ack from you?

Kai-Heng

> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 8c72eb590f79d..6ac509c1821c9 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1803,8 +1803,6 @@ static int rtsx_pci_runtime_suspend(struct device *device)
>         mutex_lock(&pcr->pcr_mutex);
>         rtsx_pci_power_off(pcr, HOST_ENTER_S3);
>
> -       free_irq(pcr->irq, (void *)pcr);
> -
>         mutex_unlock(&pcr->pcr_mutex);
>
>         pcr->is_runtime_suspended = true;
> @@ -1825,8 +1823,6 @@ static int rtsx_pci_runtime_resume(struct device *device)
>         mutex_lock(&pcr->pcr_mutex);
>
>         rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
> -       rtsx_pci_acquire_irq(pcr);
> -       synchronize_irq(pcr->irq);
>
>         if (pcr->ops->fetch_vendor_settings)
>                 pcr->ops->fetch_vendor_settings(pcr);
> --
> 2.32.0
>
