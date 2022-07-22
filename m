Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54257DC04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiGVIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiGVINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2BC9E2A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658477618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFrJKjNNYU0491FNuTI8t6vKob0kktI0zA4xaCL8j/E=;
        b=bMbf+oBVlrk1twJb30ICPIS1DGfAnG1YtQ1QVSvqzxK2Vq9+qqVHsAf1LOcs711+icfxEd
        k0z8sbJD+IsLjav+hptHGGN6NUun5cLLpfSI2DKp5kwPWP4Nf8RoC8cNhAlcPmKsaGGrlh
        G8/Hib4Q22u/UyFmTHxYg9aR+PRkiTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-c4TO6L02OaKrvqahv0XTMg-1; Fri, 22 Jul 2022 04:13:36 -0400
X-MC-Unique: c4TO6L02OaKrvqahv0XTMg-1
Received: by mail-wm1-f71.google.com with SMTP id v67-20020a1cac46000000b003a2be9fa09cso2174114wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFrJKjNNYU0491FNuTI8t6vKob0kktI0zA4xaCL8j/E=;
        b=AlS5dzTts4DLpan39S5onZkhkJ1Rt9OiDHZ8dTWEwiRIC5BLZBzcOYHfnIrVzuN/VG
         zBsZLHZKtO/DyN7eOZiNfE+hE5vjQxVxQxOVaEDNGCZiLpIWU9WPO2+QIExL8Pz6iirb
         ABETNcUt/UaBMKMk3xhPoIcDsr8Va4Ga+GZhJKFJdQn0hfI+0X+b5GO3HCOtTmfQZBFj
         EWdE6C2Tr9WVoroWauAjtfK8qk9fH7Ul69Q9+xY90zQ0AA3T2+eSUMH3ee7uXwo2y8f3
         nygTj62Baf5+069KchggVSuUFmjyc5GLyPljpYWod3/vup1MAVj6LYCw5Ury1RusSZp9
         qWaQ==
X-Gm-Message-State: AJIora8DeE6+U2RY+LaxzsfkOzItds2W0pRpkvi7bAEGvQeUKhRrwubr
        GLgNCVTnq9vxqoRcIiOzfixtLWlLy42G4X5cZ9J2iWaxAS24/zrEu1AfXSxDL/MvehxfYXYCh7t
        sJqEXlnKwF7J+t2h9bDDrfMjRRpZMQNBzcNtsDH/f
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id 1-20020a1c1901000000b003a31be34df2mr1603459wmz.146.1658477615393;
        Fri, 22 Jul 2022 01:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVB+HIi9H23yr75K8PX/2qN+oLoitA0TnKRsCF5mFx9I8K+Vyw9ABD6g/5ZglB5xC20l6aZRQ/i9F1r2pHv/8=
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id
 1-20020a1c1901000000b003a31be34df2mr1603426wmz.146.1658477614949; Fri, 22 Jul
 2022 01:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 22 Jul 2022 16:13:23 +0800
Message-ID: <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
Subject: Re: [Crash-utility] [PATCH 0/5] Fixups to work with crash tool
To:     "Discussion list for crash utility usage, maintenance and development" 
        <crash-utility@redhat.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, huanyi.xj@alibaba-inc.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, heinrich.schuchardt@canonical.com,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Jul 2022 at 18:13, Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> I ever sent the patch 1,2 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> And patch 3,4 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>
> This patch series just put these patches together, and with a new patch 5.
> these five patches are the fixups for kexec, vmcore and improvements
> for vmcoreinfo and memory layout dump.
>
> The main changes in the five patchs as below,
> Patch 1: Add a fast call path of crash_kexec() as other Arch(x86, arm64) do.
> Patch 2: use __smp_processor_id() instead of smp_processor_id() to cleanup
>          the console prints.
> Patch 3: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>          the development of crash tool as ARM64 already did
>          (arch/arm64/kernel/crash_core.c).
> Patch 4: Add modules to virtual kernel memory layout dump.
> Patch 5: Fixup to get correct kernel mode PC for vmcore
>
> With these 5 patches(patch 3 is must), crash tool can work well to analyze
> a vmcore. The patches for crash tool for RISCV64 is in the link:
> https://lore.kernel.org/linux-riscv/20220717042929.370022-1-xianting.tian@linux.alibaba.com/
>
> Xianting Tian (5):
>   RISC-V: Fixup fast call of crash_kexec()
>   RISC-V: use __smp_processor_id() instead of smp_processor_id()
>   RISC-V: Add arch_crash_save_vmcoreinfo support

Vmcoreinfo changes need to be documented in
Documentation/admin-guide/kdump/vmcoreinfo.rst

Otherwise, I suggest to always cc kexec mail list (added in cc) for
kexec | kdump patches.


>   riscv: Add modules to virtual kernel memory layout dump
>   RISC-V: Fixup getting correct current pc
>
>  arch/riscv/kernel/Makefile          |  1 +
>  arch/riscv/kernel/crash_core.c      | 29 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/crash_save_regs.S |  2 +-
>  arch/riscv/kernel/machine_kexec.c   |  2 +-
>  arch/riscv/kernel/traps.c           |  4 ++++
>  arch/riscv/mm/init.c                |  4 ++++
>  6 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/crash_core.c
>
> --
> 2.17.1
>
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://listman.redhat.com/mailman/listinfo/crash-utility
> Contribution Guidelines: https://github.com/crash-utility/crash/wiki
>

Thanks
Dave

