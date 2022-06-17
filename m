Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCD354EE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbiFQAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiFQAWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:22:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2B63397
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:22:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1620133wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=io8CZjDNsxDNt2a2JckWTmJznoi+vPqiO8J1er/GsfA=;
        b=dRFeizHBQdzMUQAVLvSN7yWFOENeCVNr+n1Gu2uySpzuJNTL1YzNNM8sP6Fm6Wr4iy
         zKXSdfyeo/0VUUdCx2g/2OKB39F/sl5+l/YaadCnmMb9gIhS8zJgalu3Yu4Xm5ZlvEJS
         csb6cuG4F+MKQosWjbmXViwmbBL/CdEOETkkIyI8zGlNSP7ixq14qLenivvvXnnsslMS
         AGtM4UbVbR1o6ZxOxZWYhh+ReXbFVP8EHITFqwImWVF7ZYdRa7qUs6CBhI0EZ81jP7aZ
         4IFSFwWni/+lgjBhbyJdfHYfZWiH6ZNVY7vrr+FeZI1bWc+zsLSfI1tcWLCr1IbmXrea
         By1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=io8CZjDNsxDNt2a2JckWTmJznoi+vPqiO8J1er/GsfA=;
        b=IaLXMd6Hq77cAWgfbARqeznMuYBfhmdl1/IbO+KuDBbTVC5/C/POG7FCVNmbeedRoV
         uLjZLOrOlqo3hYQlDVacK0GZ5Gw5Z9tozsfHXUx4a/2jJbykUWa8Vn8jhH32DClgB8Es
         ZYdruTr0mVfuENSKUNbVS33ntoW5qlpnNbxPAfvT5SdXAFEOqqgi8npHjVZG1rKwaEGo
         i0GvtxUVcRjifU1a18FLw64LKCB0sXu4TP90eYJdm91naoN4e3OMwiEx8+i7pD8FTckn
         gblPn0850SIJboMm3sWs6o0kiy6nGPxJLl1tO5N/S3piu9o6taEJmTDDJR569Mv0ms4V
         5eUA==
X-Gm-Message-State: AJIora/lof7qNjewKFkLdlyv1IoLd4Ftjf7HlemYsZrYsLeAcIGxwpaS
        CRywZ4uVPSBqVLC/qt2ekc1AbPQ8n+vYWqgqhyuaq64E
X-Google-Smtp-Source: AGRyM1tgplI94kpYCet8r4I5qz8Cd4bJETUZFDZcXmUdb1SvEpUJgdYJIGo2yrQBJXI+yVpUSGpog9AiKvHAOxs5wYg=
X-Received: by 2002:a1c:25c4:0:b0:39c:9a08:452f with SMTP id
 l187-20020a1c25c4000000b0039c9a08452fmr7349817wml.199.1655425326210; Thu, 16
 Jun 2022 17:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 17 Jun 2022 08:21:54 +0800
Message-ID: <CAJhGHyD73xjSTY6QL--S25Dj898vV=OC_0nijY8zbxzC03Ur9w@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] x86/entry: Convert error_entry() to C code
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 10:44 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Add some C equivalent functions of the ASM macros and implement the whole
> error_entry() as C code.
>
> The patches are picked and re-made from the huge patchset
> https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
> which converts a large chunk of ASM code to C code.
>
> The C version generally has better readability and easier to be
> updated/improved.
>
> This smaller patchset converts error_entry() only.
> The equivalent ASM macros are not removed because they are still used by
> the IST exceptions.
>
> No functional change intended and comments are also copied.
>
> The complier generates very similar code for the C code and the original
> ASM code except minor differences.
>
> The complier uses tail-call-optimization for calling sync_regs().  It
> uses "JMP sync_regs" while the ASM code uses "CALL+RET".
>
> The compiler generates "AND $0xe7,%ah" (3 bytes) for the code
> "cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK" while the ASM code in
> SWITCH_TO_KERNEL_CR3() results "AND $0xffffffffffffe7ff,%rax" (6 bytes).
>
> The compiler generates lengthier code for "cr3 |= X86_CR3_PCID_NOFLUSH"
> because it uses "MOVABS+OR" (13 bytes)  rather than a single
> "BTS" (5 bytes).
>
> ALTERNATIVE and static_cpu_has() are also different which depends on
> what alternative instructions for ALTERNATIVE are.
>
> [V2]: https://lore.kernel.org/lkml/20220516131739.521817-1-jiangshanlai@gmail.com/
> [V1]: https://lore.kernel.org/lkml/20220511072747.3960-1-jiangshanlai@gmail.com/
>
> Changed from V2:
>         Fix conflict in arch/x86/include/asm/proto.h in patch7
>
> Changed from V1:
>         remove unneeded cleanup in patch2
>
> Changed from the old huge patchset:
>         squash some patches
>

Hello, ALL,

Ping

Thanks,
Lai
