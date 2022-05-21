Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654352FF2B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiEUUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiEUUHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:07:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC0A5DA46
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:07:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p26so14547089eds.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eAal8RypfynzMAPCoGJz8xnvsI5t1hGAObOozarL8dc=;
        b=Gj7vtGyosWBOjpGjH+2mAKKt92df+sZ2vr9GQKrKNLGn0vH+OJ9TTwpOMYqN5yA5B9
         3/TzoarEMm3tmslGSZS0yBt4s0dtnRZer84Hvmc+y6fJolRsBPLk9Rd9eNbmlEuq54SV
         dC7jy0DUR8Ka/XX4ssIXehfEBD/KcKOqQyexduY46biZunc2YF5gqSV9Z3t3JfTs4WcK
         gEXGRH0oLTIkOsiNR9oWhGePDlvBpA17mU44DxCqZUMW2a7+cXENKSyJSth12HfNZH1H
         LevlgSGvephON60mapXva5O03sh96wKCNIrRXoD8Q6wIctzuy4lQSABN6KeguYTU8P01
         t9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eAal8RypfynzMAPCoGJz8xnvsI5t1hGAObOozarL8dc=;
        b=mrJaTplXFvKcGaEDldAKasvl7tGHNh1iM9OrXX5B+0G2vspj5qlsNmfJ7L9yE3XNPi
         GwidtlXW7Q3rPUc834F2mpRQSAvMfjOpSk49n3kNJ4XvszK2rL+C7cdJAgy/zD99Dxfw
         y0bicKDVLKY08hU/dFhaAM++GbZPaXli5D+yqwtD3Vfimr24xl1/cYnrKiq0+NQ/ZXys
         nUkjzN5xzk153rHp9j7+wcckaVTw/VcJcyufnqreccELq2G5r3PbWh8ZD3o1gy+1d8J7
         VIgiIvnKRaS4EFgoT0F4VU5+/9dUb4x8BK93zZgIFwSg4SlOJxiULouFqRDqRGBL7ApE
         G30A==
X-Gm-Message-State: AOAM530Oj3dbu95PHMZtwU0hETjoquM2KmFtghwwbhaUOn986qpQvJhZ
        YsfN4qp1NxE+CIpo91cv1lpLXyQ1wtB2Yz6pEAu4DtMnzdjCvg==
X-Google-Smtp-Source: ABdhPJw9RO2aD6yIUe0ciilXst2aikPV74g4OJRT0QRqpxTBjjK+R1cThZ5ZV8l/dQWFabZwC/jawCWU2yNFsWinV5o=
X-Received: by 2002:aa7:d38f:0:b0:42a:a2e6:90d9 with SMTP id
 x15-20020aa7d38f000000b0042aa2e690d9mr16828975edq.305.1653163650914; Sat, 21
 May 2022 13:07:30 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Sat, 21 May 2022 13:07:14 -0700
Message-ID: <CAP045ApiMSvP--f2E0=VdMbjE8oibvy921m8JASf4kaCCuU2RA@mail.gmail.com>
Subject: arm64 equivalents of PR_SET_TSC/ARCH_SET_CPUID
To:     open list <linux-kernel@vger.kernel.org>
Cc:     "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yyc1992@gmail.com, Keno Fischer <keno@juliacomputing.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is ongoing work by Yichao Yu to make rr, a userspace record and
replay debugger[0], production quality on arm64[1]. One of the bigger
remaining issues is the kernel's emulation of accesses to certain
system registers[2] that reflect timing and CPU capabilities and are
either non-deterministic or can vary from processor to processor. We
would like to add the ability to tell the kernel to decline to emulate
these instructions for a given task and pass that responsibility onto
the supervising rr ptracer. There are analogous processor features and
disabling mechanisms on x86. The RDTSC instruction is controlled by
prctl(PR_SET_TSC) and the CPUID instruction is controlled (when the
hardware allows) by arch_prctl(ARCH_SET_CPUID).

The questions I'd like to raise are:

1. Is it appropriate to reuse PR_SET_TSC for roughly equivalent
functionality on AArch64? (even if the AArch64 feature is not actually
named Time Stamp Counter).
2. Likewise for ARCH_SET_CPUID
3. Since arch_prctl is x86-only, does it make more sense to add
arch_prctl to arm64 or to duplicate ARCH_SET_CPUID into the prctl
world? (e.g. a PR_SET_CPUID that works on both x86/arm64)

- Kyle

[0] https://rr-project.org/
[1] https://github.com/rr-debugger/rr/issues/3234
[2] e.g. CNTVCT_EL0 and MIDR_EL1, among others
