Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9B590422
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiHKQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHKQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:44:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3FBC04DE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:17:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 24so1071534pgr.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=LqFU2f8KAu+do04+BY0xxELDBXMNilTFkQt1GBEIGfQ=;
        b=M5SXggdeqf0Sn+7PKP3FO4FHCkolQIZytuNY0IW7NgfUhG79K4Od/gB7Szl7KHQL+r
         kTCRgbFg95uEt8+VQKU8ifpiY1ZIAky3r70c5WTg3HLWYimywWKGCCn+A95AuGspzuQV
         qfsifv+llmMzI8thj3td00cNGT+SGje0tl2Se1dXm4CZ/kReQmcG2nRuuemdxi12tSSH
         HDsYkirsnxMdijIA8hr0QzDwt9nGwC1qGh65zuTzvnZc0WA2A/yLtHp1dxnevra9o0zC
         16k0kVcmgrPXcwm/MTIArxDUvbO+uBI7nZqJ+9LljkiQGnfz15iK3YHAuivCE3i1BAe1
         H1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=LqFU2f8KAu+do04+BY0xxELDBXMNilTFkQt1GBEIGfQ=;
        b=Lm1A6+3oCS+9dFqcegYK7LxqOQ4Me4TTUdONSg+vVQyy7j87BlJPtvOJZpDpEj9ZxP
         70YZC+ix+YLrQoocQsqf9XlWVAU9WGlJ+xROTjokKWoRlrfoHtCdPX38bz6d8bOOk9Ys
         1sBPY2/XkT30Twz4ojkvUjg7Xtl9rb6u0TK2SeeMZ/Gxv3ajBo+WnFrTDEzKIzFYNpph
         2BIFN3rZLBe4KTwnXFCT3Hpo0aHU5k3PgbBF6wiLe+p7pFusinfRihx+r9geWwGhys0/
         P8lvZJparuDPX8WtI97jAS1IX/omsK394q9ezehcjfnkCJcFtr/Ti29pfY31BaBM9/JE
         diVw==
X-Gm-Message-State: ACgBeo3VpEm47ZAx4lfZKSbiuatEgHgPaU/i9hyvVIreZl91Rp5KEldi
        da36yGzdsVW7egYtj0In0wnOvA==
X-Google-Smtp-Source: AA6agR4xlbNk9dH0j5rGK3Ka8Aw9IWX4A2wg8u1+lijEpKLCaXufEaSJjqRMp8RD42B6JjtYpF9QvQ==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr40627pfo.33.1660234624258;
        Thu, 11 Aug 2022 09:17:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016ed715d244sm15093049pln.300.2022.08.11.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:17:03 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:17:03 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 09:12:03 PDT (-0700)
Subject:     Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
In-Reply-To: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
        mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com,
        xianting.tian@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xianting.tian@linux.alibaba.com
Message-ID: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 00:41:44 PDT (-0700), xianting.tian@linux.alibaba.com wrote:
> I ever sent the patch 1 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> And patch 2,3 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>
> This patch set just put these patches together, and with three new patch 4, 5, 6.
> these six patches are the fixups for machine_kexec, kernel mode PC for vmcore
> and improvements for vmcoreinfo, memory layout dump and fixup schedule out issue
> in machine_crash_shutdown().
>
> The main changes in the six patchs as below,
> Patch 1: Fixup use of smp_processor_id() in preemptible context, to cleanup
>          the console prints.
> Patch 2: Fixup to get correct kernel mode PC for kernel mode regs for vmcore.
> Patch 3: Fixup schedule out issue in machine_crash_shutdown()
> Patch 4: Add modules to virtual kernel memory layout dump.
> Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>          the development of crash tool as ARM64 already did
>          (arch/arm64/kernel/crash_core.c).
> Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.
>
> With these six patches(patch 2 is must), crash tool can work well to analyze
> a vmcore. The patches for crash tool for RISCV64 is in the link:
> https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/
>
> ------
> Changes v1 -> v2:
>   1, remove the patch "Add a fast call path of crash_kexec()" from this series
>      of patches, as it already applied to riscv git.
>      https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>   2, add 'Reviewed-by' based on the comments of v1.
> Changes v2 -> v3:
>   use "riscv" instead of "riscv64" in patch 5 subject line.
> Changes v3 -> v4:
>   use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
> Changes v4 -> v5:
>   add a new patch "RISC-V: Fixup schedule out issue in machine_crash_shutdown()"
> Changes v5 -> v6:
>   1, move "fixup" patches to the start of the patch set.
>   2, change patch 1, 2, 6's subject to make it tell more what it's about.
>   3, add Fixes for patch 3.
>   4, adjuest the changes format for patch 6.
>
>
> Xianting Tian (6):
>   RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
>   RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>   RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>   RISC-V: Add modules to virtual kernel memory layout dump
>   RISC-V: Add arch_crash_save_vmcoreinfo support
>   Documentation: kdump: describe VMCOREINFO export for RISCV64
>
>  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>  arch/riscv/kernel/crash_save_regs.S           |  2 +-
>  arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
>  arch/riscv/mm/init.c                          |  4 +++
>  6 files changed, 89 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/kernel/crash_core.c

Thank.  I've taken the first 4 onto for-next, which is still targeted 
for 5.20, as they're fixes.  I'm not opposed to taking the documentation 
patch for this cycle as well, it just needs some going-over as the 
wording looks very odd (or at least it does to me right now, maybe I'm 
just still half asleep).  Patch 5 is a new feature, and given that it's 
being spun during the merge window it's too late.
