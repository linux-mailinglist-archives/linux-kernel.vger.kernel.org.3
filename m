Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9A49D28D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbiAZThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:37:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiAZThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:37:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5CFB81FC2;
        Wed, 26 Jan 2022 19:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213B2C340EB;
        Wed, 26 Jan 2022 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643225818;
        bh=FX4ycAoQ1Kx85m2fAggwF/dB1ZrkI6hhsraoivrg4v4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8gbUXGPpJdJS8OapXAAZcQt2i3/3+PMvgDfJRpDX1OjSrB/hny0Pir35k+D1pIK/
         t5kV4j3NKaombI9TG1VzqViFb9WZvoBxeYULKInkMpsHwaDsEreXT1rz6q8VE/st53
         rtJt71BDkx6Z5Kleckul57cHE/fXOpOhXS0uTw7KnBXWAR0JNuLKSPFx1roLTSJTlV
         20BkHyKTgJ43fNfKCW8somfRYGo/DX4l/UG9qUBIKdPdFPspYgds7vu/aUJIjIUUue
         pqg8mFzeLC9qKajXh8VRm+lWKBKCbf4hj2Po4YVrtH0VRSVlyR7Y8cY73N+5DGw5T6
         S6mPpKhBa9/IA==
Received: by mail-ej1-f43.google.com with SMTP id k25so821187ejp.5;
        Wed, 26 Jan 2022 11:36:58 -0800 (PST)
X-Gm-Message-State: AOAM532q0oSsKBdp8gTEgY+7sphPsOFAi2cGdALGR4wiB53lCtggNYit
        hv7QcCl0TRMlbj6CQjY1FrO/Ssxj+TpnK5CFAQ==
X-Google-Smtp-Source: ABdhPJxCkKeplWRipuk7FYPCNtGWq3C0aDwhj+I3Yngm5B4DjN1t4ZcmJr+s62lzu5ahhDGTjWbImmlIaR86QPECXo8=
X-Received: by 2002:a17:906:4781:: with SMTP id cw1mr258583ejc.264.1643225816453;
 Wed, 26 Jan 2022 11:36:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639744468.git.geert@linux-m68k.org> <4f409ac939e260a4657a0e6e6518ef8736527822.1639744468.git.geert@linux-m68k.org>
 <CAAhSdy3g9WsBmQk7KOgdVNSw9qUouxF2i==q9M3WQq3iabXv7Q@mail.gmail.com>
In-Reply-To: <CAAhSdy3g9WsBmQk7KOgdVNSw9qUouxF2i==q9M3WQq3iabXv7Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jan 2022 13:36:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++-Sp45vna5-WhPsnrxp1_J1krrBUPgd2y3xkp5=sTSw@mail.gmail.com>
Message-ID: <CAL_Jsq++-Sp45vna5-WhPsnrxp1_J1krrBUPgd2y3xkp5=sTSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: sifive,clint: Fix number of interrupts
To:     Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 6:48 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Dec 17, 2021 at 6:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > The number of interrupts lacks an upper bound, thus assuming one,
> > causing properly grouped "interrupts-extended" properties to be flagged
> > as an error by "make dtbs_check".
> >
> > Fix this by adding the missing "maxItems".  As the architectural maximum
> > is 4095 interrupts, using that as the limit would be unpractical.  Hence
> > limit it to 10 interrupts (two interrupts for a system management core,
> > and two interrupts per core for other cores).  This should be sufficient
> > for now, and the limit can always be increased when the need arises.
>
> Same comment as the PLIC DT binding patch.
>
> The "maxItems" should represent CLINT spec constraints so
> please don't add any synthetic value here.

I agree.

Geert, are you going to respin these?

Rob
