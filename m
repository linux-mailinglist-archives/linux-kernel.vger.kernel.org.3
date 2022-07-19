Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60157A1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbiGSOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiGSOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:38:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC46A469
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:33:35 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MVdYY-1o3sfh1eaK-00RYi9 for <linux-kernel@vger.kernel.org>; Tue, 19 Jul
 2022 16:33:33 +0200
Received: by mail-yb1-f178.google.com with SMTP id k85so24086141ybk.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:33:33 -0700 (PDT)
X-Gm-Message-State: AJIora81w/dpKQt2I8O+onZ2Fm71jTE+8nS+gcn9hPmbnkEL+X7s8WzC
        xP0XVpWHMBQ/O7avnVk+Az52ICA6FRTsytIC1qo=
X-Google-Smtp-Source: AGRyM1uxn5Ct1y8pNcrAY8pbwpJA1DRTgwVA9Fjcf7UpYb0+wJ1FTDhvKBklhSZzcwO2x3irLu2qg/UyYDCZDwAsvf8=
X-Received: by 2002:a25:d283:0:b0:670:5eb2:a128 with SMTP id
 j125-20020a25d283000000b006705eb2a128mr7049393ybg.480.1658241212155; Tue, 19
 Jul 2022 07:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 16:33:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2hd5KDBSH1=23_+Qz+t2LUC6kcc+9_Z_xc-Zdy7N-FAQ@mail.gmail.com>
Message-ID: <CAK8P3a2hd5KDBSH1=23_+Qz+t2LUC6kcc+9_Z_xc-Zdy7N-FAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arm: i.MX6 Cortex-A9: Fix memory ordering
 inconsistency by disabling prefetch instructions
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XGkmpM/a6RPUL2cltAWYavmz8K7nT85TsyGy7FQ54Yss83yYgTH
 hIBFsFZybHyNic1vGYQ0tt9tLcmaSD7x6zmlw3p07D6aXtAnFsTGUvTtGT3mN2vvOM1D74+
 7aq/RnZfCwqJLEj5otnPsj0WKC6v6OC/Y4UHGJGXye+IlH7SREA0npLwOfDyRf2eycrNZ8P
 TXA2gZ1qZqNzxBHBynVLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+A2aN9GlzLo=:5KWUxvhRPy3Ey7952bJ9JC
 epObEAQogDngMUK30zAqc9nzXBKdw1otUYNOliPkdAl3Vj4nmzPFI2aRrRswVgcJi2d8fyBh3
 zzEnrrTT+LFbOcdkc7UON+fxGTDaHDM1GP1Rc3rUz5uhDm0or6VNQ8dLqnH9iuwHnoAmWykfm
 CY23FvtV8p9dL33bThx7ZTkSXAJwtABnjDiz02EkbZcCeBI/wGLlnuesCO4Zjl1rMRzLkDFhc
 VNNVHpvVu1YSGau+rpawe2Hk8woMaPdMKwUGh0GqiGok2guikWmb8ZN5vlLmbPqXCoNAFMfuH
 BUSeFvLjvpao2JMrpBQNPhr63eNZTwOzsF55UvvvofxnKBvE49na0hGVaMJ5GPDVaW9EFZXLB
 kYQXMovOEYeM92Ad0sxzDOJAxMjGBry27ygXt0VHgphenJdeN6jsDW7MYD7d+t3XT50oYC9vt
 lV5bjsMawMppQ5sjZZRtgKdm2xp7p3Gak0Ibyy1/LVX8MA/oI8EO7UYC6ywFC8xuJqoxzmep3
 bpQbn6m8VCkC01t4HXEjklB/UErh/W/1RhhGfDg81EgqoHU7VQcC+mZG6fzOtualbn6uYEC0u
 OJ8+0PALKNBPxTF24fTz8V6sPw1yYmHubY1pDNDnH9blL1QiVTQcrX5RW1Z8Pndufitx8AEVA
 Gm4Q3S/OoL0XpqMFX+j9/HXevwY1YGpQFQVpaaswyRjEJ3D8ncTn0xj94WLzqMztszECrfwk8
 Ufg7nLS/7deKMlmqGaXXT42kdRW3KWmlSdM90LyeAEtAH1scwOBH/BHGp5V+kptnE81Iqcsnl
 Wr3iA26txnPfwIp4axT2zMkxIUcXF00fBFf1a4esxdQ0Jw/yUIX7SWr6dXzh/qmvoWMXSjb12
 deg7tlTQudaTnL0DHlyw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 4:51 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:

> Request for Feedback
> ====================
>
> This fix targets all i.MX configurations, but it is likely too broad (or
> too narrow). It would be great if people with access to different
> Freescale i.MX test boards, and test boards from other vendors, could try
> to reproduce the issue to figure out what would be the right scope for
> this fix.
>
> It would also be great if people with knowledge of the ARM CPU internals
> could help understanding whether this fix really fixes an issue between
> prefetch and memory barriers, or just happens to hide the issue. It
> would be good to understand whether this issue only affects PLDW or if
> it also affects the PLD instruction.

I don't have any relevant hardware at hand, but looked at this for a few
hours today, unfortunately without any notable success. Just documenting
what I did here:

- looked at the errata lists for cortex-a9 r2, for pl310 and for
imxq6q to see if
  anything stuck out. I assume you've already done the same, but I can confirm
  that the errata that would match the symptom are listed as fixed in r2p10
  or earlier.

- looked at objdump output from
  linux-image-5.18.0-0.bpo.1-armmp_5.18.2-1~bpo11+1_armhf.deb
  (not the same version, but hopefully be close enough), and compared that
  to v5.18.2 built with the same config using gcc-7.5 and gcc-10.3 to
  see if I could tell what is different. The output looks very similar, though
  my own gcc-10 apparently fails to inline arch_futex_atomic_op_inuser()
  and futex_atomic_op_inuser(). This looks like something we may want
  to force-inline in principle, but it seems unrelated to the bug you found
  since the debian vmlinux has these functions inlined and I don't think
  they are actually part of the broken code path.

- looked for other quad-core Cortex-A9 SoCs to find someone with a
  similar revision to check if they have the same bug. The closest I
  can  think of is the OMAP4 that uses an A9 r1p2.

- Looked at the disabled errata handling in arch/arm/Kconfig.
  Unfortunately a couple of the workarounds we have there are
  now always disabled because of a dependency on
  ARCH_MULTIPLATFORM. It's a long shot, but you could try
  removing the dependencies and enabling all the Cortex-A9
  fixes like ARM_ERRATA_742230, ARM_ERRATA_742231,
  ARM_ERRATA_743622, ARM_ERRATA_751472, and
  ARM_ERRATA_754327.

        Arnd
