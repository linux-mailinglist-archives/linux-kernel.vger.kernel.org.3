Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865EF495190
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346240AbiATPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376597AbiATPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:37:12 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F99C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:12 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m1so18937936ybo.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=benBYMoxl2IjLGX3aLWpdBFmHNqoAhtj/Izde371FoY=;
        b=rGryBx3vren0FD6AusA1Z+oP0Tpy1Yv7hYzLnhMNzuXAN7gebacnfe5EbYerti6xcN
         GieILVBlmUdl93RlOazApxh6v6WlvnyEViBXaG2HwYjzS1bKFS3RRuucmGFKL6GQhSiu
         94GqfAlUFI7XS5NC7SGxGVpma78wezjs4dVdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=benBYMoxl2IjLGX3aLWpdBFmHNqoAhtj/Izde371FoY=;
        b=bxBAxElogRSEZTuUUuWYkQ142O7SqG45r8rf7lwMJWmyMMXZ7aRykmfPkbORZL0ntU
         k7JoSmPKdGjWxKvJjiptBxlX+/3Tk+DJfb39ZU6m7X7myoL2V3MuD37FMK285HhvkjZb
         yqOufUKxxbr/8cn+eaHezzJHzDnyCFChWRPY5efXWnJg8qT8Dbu0MNuoz+dlynWAdvuJ
         h9kwE3OoEREWDwZSaQJvghrDnALRMniGWC0kPUzW4OI/m2GUK1cgEzxSP9sDE/6oisPX
         e4LQ+8VNHOjvyRW82dpVrDHF7mV5ZpnrlsGF0r+sR54nEE8smC6Diy53N6lhSXOEeN4D
         ilbw==
X-Gm-Message-State: AOAM533DjEw0k3sNCZwj88yOvAS0M+30nRYUH7d8+iEruNYUagc8Nwap
        znPPsgLNbx5nzGm4vZYuS64kImvQJ7yfl9CPXpHahoKxSMc=
X-Google-Smtp-Source: ABdhPJx2HqNHCErP0SUwdj2Z1T8Vj/J/PMhk2VH+lfME52ufBieeE0xLdK6sxbq8ha/DtDdJx1U69QLbOKV1hW1csVw=
X-Received: by 2002:a25:4b84:: with SMTP id y126mr44574295yba.487.1642693031719;
 Thu, 20 Jan 2022 07:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20220120152828.4089364-1-gatecat@ds0.me>
In-Reply-To: <20220120152828.4089364-1-gatecat@ds0.me>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 20 Jan 2022 16:37:00 +0100
Message-ID: <CAM4kBBJqHVX_Q2C0VO7qKNZywRiWbHK9t0G076ov6u+_gwO2=A@mail.gmail.com>
Subject: Re:
To:     Myrtle Shah <gatecat@ds0.me>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thu, Jan 20, 2022 at 4:30 PM Myrtle Shah <gatecat@ds0.me> wrote:
>
> These are some initial patches to bugs I found attempting to
> get a XIP kernel working on hardware:
>  - 32-bit VexRiscv processor
>  - kernel in SPI flash, at 0x00200000
>  - 16MB of RAM at 0x10000000
>  - MMU enabled
>
> I still have some more debugging to do, but these at least
> get the kernel as far as initialising the MMU, and I would
> appreciate feedback if anyone else is working on RISC-V XIP.

I'll try to support you as much as I can, unfortunately I don't have
any 32-bit RISC-V around so I was rather thinking of extending the
RISC-V XIP support to 64-bit non-MMU targets.
For now just please keep in mind that there might be some inherent
assumptions that a target is 64 bit.

Best regards,
Vitaly

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
