Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AA547F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiFMFqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiFMFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D1192B0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE71F60BC0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA53C341C4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655099081;
        bh=70g/7M7E9P4sEW/N+16rq9stI2Il55a/CvsfR3Q+UXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZfnDSf147CzRKRQfx3b8bxpMJdLKRX3I7l1A3qaUsRXb4YxvOLd6h0tZvsEVV1nq
         /6ATAWMhrylOltTjVUebdUPnweUeOrixVIVf0fOYVqK5XuSt5SZnOLjFxGVoVtN7wq
         OADhSOpfcxDc+pa5c9D3KKXDhPXbwFliZ6Ipo+rDHBZEx5jwWAFmsd8Us1viN0V9B8
         Xl7jSlTU/MHQSYqNjv+uyQqfQSO6z8KArB/EL+9jsLu0KI2jbh0HbtnDORTlgNV8hN
         KkpiiGpl+yCD3S9Qr67ETnRkUabyfGb3fzDT47TlDH7es3p3HH+yxJOD+PxrYKzLk3
         c9ExWN1o7BQdg==
Received: by mail-vs1-f54.google.com with SMTP id r12so4878735vsg.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:44:41 -0700 (PDT)
X-Gm-Message-State: AOAM530K0PECtc23VijDJLz6WMdHp4l4ZgbNR5he3CDdiH8av6SLkjP3
        Yf3iB7uRdzBtR9LuvHVzkznmUqO0L698Eh+HYP8=
X-Google-Smtp-Source: ABdhPJxCp/wtzjVsx31yKJJjCVOmmnKZxkSlyKmTeNj9LTIY1WNb8RPcBhFeLWc3exKrFFkprr5UpZgcnburuvnjrlc=
X-Received: by 2002:a05:6102:22c2:b0:34b:9163:c6ab with SMTP id
 a2-20020a05610222c200b0034b9163c6abmr21818282vsh.8.1655099080281; Sun, 12 Jun
 2022 22:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Jun 2022 13:44:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjR_iqbH3ee1GYRnPCQdn79p+vK5-FiKZiTQNZFhPyeA@mail.gmail.com>
Message-ID: <CAJF2gTQjR_iqbH3ee1GYRnPCQdn79p+vK5-FiKZiTQNZFhPyeA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: don't allow write but not read page mapping
 request in mmap
To:     Celeste Liu <coelacanthus@outlook.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, xctan <xc-tan@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:20 PM Celeste Liu <coelacanthus@outlook.com> wrote:
>
> When xctan tries to run one of libaio's tests
> (https://pagure.io/libaio/blob/1b18bfafc6a2f7b9fa2c6be77a95afed8b7be448/f/harness/cases/5.t),
> it encounters a strange behavior: for the same PROT_WRITE only mapping,
> there was a discrepancy in whether it could be read before and after writing
> (readable before writing, unreadable after writing). After some investigation,
> I found that mmap allows write only mapping, an undefined behavior, on RISC-V.
>
> As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
> "20211203 Privileged Architecture v1.12, Ratified"[1], the PTE permission
> bit combination of "write+!read" is "Reserved for future use.". Hence, don't
> allow such mapping request in mmap call. In the current code[2], write+exec
> only is marked as invalid, but write only is not marked as invalid.
>
> This patch refines that judgment.
>
> [1]: https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf
> [2]: modified in commit e0d17c842c0f824fd4df9f4688709fc6907201e1
>      (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0d17c842c0f824fd4df9f4688709fc6907201e1)
>
> Reported-by: xctan <xc-tan@outlook.com>
> Co-developed-by: dram <dramforever@live.com>
> Signed-off-by: dram <dramforever@live.com>
> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Yash Shah <yash.shah@sifive.com>
> ---
> v2: This version adds a link to the referenced spec, and reference of the
> previous related modification.
>
>  arch/riscv/kernel/sys_riscv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 9c0194f176fc..571556bb9261 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -18,9 +18,8 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>         if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>                 return -EINVAL;
>
> -       if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
Yes, PROT_EXEC would prevent next PROT_READ check.

Looks good to me.

Reviewed-by: Guo Ren <guoren@kernel.org>

> -               if (unlikely(!(prot & PROT_READ)))
> -                       return -EINVAL;
Could we put your comment here?

/*
 * As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
 * "20211203 Privileged Architecture v1.12, Ratified"[1], the PTE permission
 * bit combination of "write+!read" is "Reserved for future use.". Hence, don't
 * allow such mapping request in mmap call. In the current code[2], write+exec
 * only is marked as invalid, but write only is not marked as invalid.
 */

> +       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> +               return -EINVAL;
>
>         return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>                                offset >> (PAGE_SHIFT - page_shift_offset));
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
