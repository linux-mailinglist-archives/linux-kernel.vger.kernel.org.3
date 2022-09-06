Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7CA5ADF42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiIFF6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIFF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:58:34 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927816B177
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:58:33 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1274ec87ad5so10927929fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HeBedukbKOmji1l3x9C67ZTQwt1/+R7TK0HpgBZO8/g=;
        b=HLIu1aXjSCJPfMxnLO1BIP4TKN/g1wfnjLoKixX2gL4+L64N5Uu4KM0fZTVYrin9Ys
         vizhDJhYPpx2MvJWWve2g3dp42cXMwNfJPe2/C88HUM8TX8Pvr7cZ9f66foqApzMEYF3
         DfYd89k5VyejFB/5CBMjZVxwaYWhirtWWpfScaWlUlGgg3zLrS3ukHrYR4wriDIwkJGU
         wrMlLf5w+t3zSQ/3dxRDaKq/JRvvg82QmYuWnyClKfLU5jaXHJsmp1QrnyOxG77oGYNB
         d9e74nckdLpi/xbJ5n01NJSfGH0JEAa7W/dR6mtDUOmJ3YMFsU7qcht375GUO3DoF3Ha
         x8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HeBedukbKOmji1l3x9C67ZTQwt1/+R7TK0HpgBZO8/g=;
        b=cfbjVO9Kig9L6LshmlRyz7unbvI4YIWP+8rQ/fFXF+ZHYqcSztqXwkplFmsIZRKHCQ
         yFfne/HN+8bGdC6XX2c1qPfWqGrQqT/qLdxSiDmCKGj7ggy5QsXTrEEkCkvnBYp480mj
         8mriqffwKS4wphqZ6p93gEeaYhuwvGWlQVBPM5RJ+fi3X/9VVMWfhhRb/KVY6tujcltW
         3eJa8W3oUwsHSSV7P/Yj0ffie3kbLmu5D+z5kh0eJUJdd/J9Ql8j9Uow0xkb1gWJIBrS
         KhewAm5/+0J6BUHRg2YMRHXZqiGVyHVXcHRAdrwltiPurZrXgXNfDg5WGwtKEk1F+zN6
         J1Eg==
X-Gm-Message-State: ACgBeo3nzUm2mQt+FdiLQ6VIu4H/ldvgODKS/L9b1e1xUX00QaDGOlGB
        3R5gMik6rcAXewDvqs47EfE=
X-Google-Smtp-Source: AA6agR6UIO+DAi1rk00dnO76SUp4Kxzb0yyf2H5r74kvqrcAK6nSeGW2Pnz/BGviH0mf18GJirvSUQ==
X-Received: by 2002:a05:6870:f219:b0:122:4182:94 with SMTP id t25-20020a056870f21900b0012241820094mr10781626oao.264.1662443912202;
        Mon, 05 Sep 2022 22:58:32 -0700 (PDT)
Received: from localhost ([104.183.150.195])
        by smtp.gmail.com with UTF8SMTPSA id r1-20020a9d7cc1000000b006369d5d6372sm5508968otn.50.2022.09.05.22.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 22:58:31 -0700 (PDT)
From:   Fangfei Yang <yangff1@gmail.com>
To:     luto@kernel.org
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        sroettger@google.com, x86@kernel.org, yangff1@gmail.com
Subject: Re: PKU usage improvements for threads
Date:   Tue,  6 Sep 2022 00:58:28 -0500
Message-Id: <20220906055828.10451-1-yangff1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <e1c67217-1143-4643-a7a3-ca3f34f28d30@www.fastmail.com>
References: <e1c67217-1143-4643-a7a3-ca3f34f28d30@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How is PKRU a “privilege” and what do you mean my “immediately”?  I can’t follow this.

If you use PKRU, then you add a layer of permissions controlled by the user 
to the existing memory management to determine whether a particular PKEY's 
memory can be read or written by the current context. 
Then, we don't want this PKRU to be accidentally modified. 

From this perspective, PKRU is a privilege in user space.

In addition to the restrictions on the user program itself, 
some system calls can also cause the PKRU to be modified. 
For the kernel, this user space is designed to be agnostic 
(and can be anything, having all kinds of guarantees), 
and only a few policies can be sent to the kernel via seccomp-bpf or other security apporches.

Examples of "immediately", e.g., sigreturn-oriented programming, 
can change the current PKRU value while achieving the effect of ROP, 
thus allowing an attacker to access memory that was not read or written in the original context.
This compared to attacks that takes time to work, sigaltstack once, and then wait the signal get triggered.

> Why would the entry point check a source?  Or change PKRU?  What would its PKRU logic be and why?

> As I see it, the handler can (awkwardly, perhaps) manage PKRU just fine for all purposes except kernel access to the signal stack.

Yes, it can be correct and safe, but it'd be better if kernel can just provide 
the PKRU desired by the user when sending signal to the user.

> Can you elaborate?  Of course WRPKRU can be abused to fully bypass PKRU protection. 

This is determined by the characteristics of MPK and signal.
First, currently, the kernel uses a default PKRU value of 0x55555554 when it signals, 
which means that only PKEY=0 is writable. 
However, the program that actually handles the signal may need other permissions, 
for example it may need to access PKEY=0,1,2 at the same time.
Then, I would need to write the following assembly code in the preamble of the handling function.
```
mov eax, 0x55555540
xor ecx, ecx
xor edx, edx
wrpkru
cmp eax, 0x55555540
jne fail
```
However, this leads to another problem, if, for example, 
I am an attacker (assuming you have gone through some method that prevents sigreturn-oriented programming), 
I can modify the RSP to jump to this signal handling function. 
Then, you will see that in the code afterwards, 
you have no way to tell if there is actually a signal currently being sent by the kernel to our handler function, 
or if this was jumped over by the attacker since the previous PKRU has gone.

Of course this is not insurmountable. 
For example, we can save a token to the memory that PKEY=0 before the very first `mov eax, 0x55555540`, 
thus ensuring that PKEY=0 is writable before executing wrpkru 
(assuming here that PKEY=0 indicates some higher privilege). 
However, in a multi-threaded environment, saving such a token also becomes more complicated.

If the kernel can give a correct PKRU according to the user's specific design needs, 
then there is no need for additional token here. 
Then, even if the attacker jumps here, its PKRU unchanged, 
and thus its privileges can be restricted by other methods 
(e.g., it has been proposed to add a function to read pkru in seccomp-bpf[1]).

> This isn’t logical at all to me. It makes some sense as an API simplification to avoid a new syscall, and it makes sense in a bizarre (to me) world in which user code can control access to PKRU but not to sigaltstack(), but why do we live in that world?

If we can control WRPKRU, of course sigaltstack can also be controlled, 
whether by seccomp or something else. 
My point is that doing so would reduce the exposure of risky syscalls 
by ensuring that no matter how the syscall is used, 
it does not expand the privileges of the caller. 
There is always a way to make the these system calls secure, 
as long as the availability of the signal is addressed.

> Do you mean in current kernels?

No, what I mean is that if you save the current PKRU, 
rather than allowing the caller to specify one at will. 
Then, in the future, when doing a signal deliver, 
if it tries to write to a stack address that is not allowed to be accessed by this saved PKRU, 
it will segfault. 
This is not necessary, as you can restrict access to sigaltstack, 
I'm just saying that it makes sigaltstack itself a little more secure.
(Because PKRU is also in effect in the kernel, in the vast majority of cases, system calls 
still follow the restrictions of the current context's PKRU when accessing user pointers. 
This assumption is not absolute, but it is not a bad thing 
if syscalls can satisfy this requirement)

> What do you mean “accurate”?

If the accessibility of the memory itself is only checked at the time of the system call, 
then there is a possibility that this address is unmap and mapped again, 
at which point the PKEY check based on is inaccurate.

> Sorry, what code does XSAVE here?

I simplified the process of signal delivery a bit.

For xsave here the process is: handle_signal->setup_rt_frame -> __setup_rt_frame->get_sigframe->copy_fpstate_to_sigframe->copy_fpregs_to_sigframe-> copy_xregs_to_user->xsave

It will be slightly different if other instructions are used.

Because this xsave will use the user's stack address directly, 
the PKRU must be changed to the PKRU value obtained 
by any of the methods discussed here before the xsave is made.

However, this results in the xsave saving the fpu registers with the new PKRU value,
but the xsave should save the old PKRU value (before the siganl).

So, we must backup the before write to it, and then after xsave, 
the old value is used to replace the value in the signal frame.

Something similar needs to be done at `rt_sigreturn`, 
because the restore_sigcontext will modify the PKRU register 
to the PKRU value in the frame, but the `restore_altstack` that 
follows will immediately access `&frame->uc.uc_stack`. 
If, however, the restored PKRU does not have access to the `&frame->uc.uc_stack`, 
it will cause a kernel panic. 

[1] https://lore.kernel.org/linux-api/20181029112343.27454-1-msammler@mpi-sws.org/
