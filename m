Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29652DA20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiESQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiESQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:24:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81743C6E72
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:24:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e189so7057156oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huL4ad89mf4O7l8f8h0yzElAD3kqJ0C3CWv/3lalNDU=;
        b=duCEFwPIvc1L+ivlgFPC4lYUWqwDe9TkpdTZUqJBM252M7DZuyFwRYr7tas0gramEy
         /VtxQL5nTJ/waME/XIQv6xjSmmxiwV7AExbVL4qLpS6+FRpvS0r0gmSegPaRo6By42cG
         /UQuyCOWJ3AIvOhMerZVqhqzJoeUgfTAk6GndpxflENSWIBXRnv0qMCu558+yC+x8MNi
         XUTlBgdoHjo4iNU9OKD4H43k02KxxTObc9cWUhEU66M+KejZvZ2b56v28Ua88H5IIt1Z
         2jOJEf7M4CPpeoyxYqSMKY+RvFajjZ5WE58C74VTotRmNVc8vA/Cp8lAhvvJUH8zIr4R
         lfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=huL4ad89mf4O7l8f8h0yzElAD3kqJ0C3CWv/3lalNDU=;
        b=nkdLIyDlFdIcZrL7wj3X8kH+PqhEsYYEbIuyns9Ix3zayqul4Y3FcCZcTKJVUe42OY
         DGKyUUymVvwBd+Gc4PiNCQ9TFxwXOpukg9PesrkqOaUrNAk5keKKRxs162Shzsiof4hZ
         aUVVcfj1Y2nXGlUiG34hGtRNH27Z5xWNaaV1W9IzwpyCZQlT6xu1iXOAbG7vAmwTRbcs
         h7hRy2jXd/V0WgSiulfCCbbuZRXiX+RCN4gRgmTe2R5IeHZGcoEa0509CvVlEPSYQ2Ya
         TApFzvbJf/YKe+rLFZufXF4hAvyTvZ6jvss2M9PmzKTi0yyLJJHxr4IkCXE8qPTFsVZs
         8VHg==
X-Gm-Message-State: AOAM530chPxeGrfy/QCmznfqaB5uzWG50KQAPGdb0CCkdGb6ZQrYOl3z
        KMUE2lk47m2YcqxowH/huOY=
X-Google-Smtp-Source: ABdhPJzPST+qVv7qyp7KxxGA+FbX7ECPSAtMq08UL/RLGicN0PMQrEcN0smy0Xn9RFmhv1l3fDUBaA==
X-Received: by 2002:a05:6808:1809:b0:326:4e31:9965 with SMTP id bh9-20020a056808180900b003264e319965mr3247268oib.223.1652977453843;
        Thu, 19 May 2022 09:24:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5-20020a05687044c500b000edda81f868sm22659oai.10.2022.05.19.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:24:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 May 2022 09:24:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220519162411.GA4095576@roeck-us.net>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506121631.293889636@infradead.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 02:14:34PM +0200, Peter Zijlstra wrote:
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.
> 
> This doesn't add any attack surface that would not already be
> available through INT80.
> 
> Notably:
> 
>  - 32bit SYSENTER: didn't clear si, dx, cx.
> 
>  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
>    take a second argument.
> 
>  - 64bit: didn't clear si since the C functions take a second
>    argument; except the error_entry path might have only one argument,
>    so clearing si was missing here.
> 
> 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> and selftests pass.
> 
> Unconditionally clear rsi since it simplifies code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Borislav Petkov <bp@suse.de>

linux-next (next-20220519) crashes due to this patch when booting
q35:EPYC-Rome in qemu.

[   20.716975] Run /sbin/init as init process
[   20.790596] init[1]: segfault at f7fd5ca0 ip 00000000f7f5bbc7 sp 00000000ffa06aa0 error 7 in libc.so[f7f51000+4e000]
[   20.793487] Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
[   20.796332] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   20.796621] CPU: 1 PID: 1 Comm: init Tainted: G        W         5.18.0-rc7-next-20220519 #1
[   20.796724] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   20.796724] Call Trace:
[   20.796724]  <TASK>
[   20.796724]  dump_stack_lvl+0x57/0x7d
[   20.796724]  panic+0x10f/0x28d
[   20.796724]  do_exit.cold+0x18/0x48
[   20.796724]  do_group_exit+0x2e/0xb0
[   20.796724]  get_signal+0xb6d/0xb80
[   20.796724]  arch_do_signal_or_restart+0x31/0x760
[   20.796724]  ? show_opcodes.cold+0x1c/0x21
[   20.796724]  ? force_sig_fault+0x49/0x70
[   20.796724]  exit_to_user_mode_prepare+0x131/0x1a0
[   20.796724]  irqentry_exit_to_user_mode+0x5/0x30
[   20.796724]  asm_exc_page_fault+0x27/0x30
[   20.796724] RIP: 0023:0xf7f5bbc7
[   20.796724] Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
[   20.796724] RSP: 002b:00000000ffa06aa0 EFLAGS: 00000217
[   20.796724] RAX: 00000000f7fd5ca0 RBX: 000000000000000c RCX: 0000000000001000
[   20.796724] RDX: 0000000000000001 RSI: 00000000f7fd5b60 RDI: 00000000f7fd5b60
[   20.796724] RBP: 00000000f7fd1c1c R08: 0000000000000000 R09: 0000000000000000
[   20.796724] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[   20.796724] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   20.796724]  </TASK>
[   20.796724] Kernel Offset: 0x33000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Bisect log attached. Reverting the patch fixes the problem.

Guenter

---
# bad: [21498d01d045c5b95b93e0a0625ae965b4330ebe] Add linux-next specific files for 20220519
# good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
git bisect start 'HEAD' 'v5.18-rc7'
# good: [00ad3ec718d0a85b8fe6b317f07e585650e05073] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 00ad3ec718d0a85b8fe6b317f07e585650e05073
# bad: [7bbdec75300e073a8fa14d19409af4b43bbaff17] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 7bbdec75300e073a8fa14d19409af4b43bbaff17
# good: [c298441f72cd14bbe74ac49a5c60ecf302cc2f97] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
git bisect good c298441f72cd14bbe74ac49a5c60ecf302cc2f97
# good: [e261ae308e94dc89db3f473db29662942a4dd532] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect good e261ae308e94dc89db3f473db29662942a4dd532
# good: [ba821c4223c38f4ec1cc2c7151c8abd4c70e3178] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect good ba821c4223c38f4ec1cc2c7151c8abd4c70e3178
# good: [2b0b069fc23047b66e1bf6ffd60e7ea5d4e2f484] Merge branch into tip/master: 'smp/core'
git bisect good 2b0b069fc23047b66e1bf6ffd60e7ea5d4e2f484
# bad: [7e2492890410e54a44b5cea9d34ecca45bf74890] Merge branch into tip/master: 'locking/core'
git bisect bad 7e2492890410e54a44b5cea9d34ecca45bf74890
# bad: [9e20f60bad4afb3e1f368e9a61d9813210ce6a29] Merge branch into tip/master: 'x86/cleanups'
git bisect bad 9e20f60bad4afb3e1f368e9a61d9813210ce6a29
# bad: [ab07ef45e638d9fdffbdd2f50521f73096acf2f1] Merge branch into tip/master: 'x86/asm'
git bisect bad ab07ef45e638d9fdffbdd2f50521f73096acf2f1
# good: [81893ca70cddbbce7cde243e0c70de6917b82956] Merge branch into tip/master: 'timers/core'
git bisect good 81893ca70cddbbce7cde243e0c70de6917b82956
# good: [d205222eb6a8e5e70c21200beb81c6e19ec211d6] x86/entry: Simplify entry_INT80_compat()
git bisect good d205222eb6a8e5e70c21200beb81c6e19ec211d6
# bad: [e2ef115813c34ea5380ac5b4879f515070150210] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
git bisect bad e2ef115813c34ea5380ac5b4879f515070150210
# bad: [1b331eeea7b8676fc5dbdf80d0a07e41be226177] x86/entry: Remove skip_r11rcx
git bisect bad 1b331eeea7b8676fc5dbdf80d0a07e41be226177
# bad: [8c42819b61b8340cff0643e65b5ce6a4144ab155] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
git bisect bad 8c42819b61b8340cff0643e65b5ce6a4144ab155
# first bad commit: [8c42819b61b8340cff0643e65b5ce6a4144ab155] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
