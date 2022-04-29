Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F25158BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381656AbiD2XAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2XAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECAA8CE10F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651273002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnjLe1sX/ByqokIV0KPRU+YsS6VSqJAMqOuKJz3yBzI=;
        b=EAtc9GciSeEILF3boJh/ylUBfxmzUtXUjy7EebtbQoM3hKrIXoeXh6WUnR0nYuaDrzerU3
        MZipKkdmc51r+hcFLkOy5Pu2FdjTO1WJ08DhXIb9X16IWHoBjmH9u+pfZx7ni1Gheg5vLc
        D1QFLdrK5mPTGG7wIYsv8spshLyk3rs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-5soh4y9wO-m3eZ-gj1RQcQ-1; Fri, 29 Apr 2022 18:56:40 -0400
X-MC-Unique: 5soh4y9wO-m3eZ-gj1RQcQ-1
Received: by mail-qk1-f199.google.com with SMTP id u129-20020a372e87000000b0069f8a79378eso6185990qkh.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnjLe1sX/ByqokIV0KPRU+YsS6VSqJAMqOuKJz3yBzI=;
        b=T1GctPkDhqys1I3GmLrm5uIlPAbo77OZKprXkJWK25nxKavYSIK+PBVYwJhyBbzSvt
         CvvnbiJjUpGSnaa/Tn/Bqwy9E3LPYd6SbPz1xV+kyjwKQPbedgfh/zo7ZBmX/k9QgGaQ
         yTJ9QAwId8u1xLUQrVDXonZj7EJMrpHtEflQJpl8QLpBhZzR/tyecKYrHI7Wd/wBWmMZ
         99AcjCSOfYpY5wY1C3Trz0h9JM1rb0BZvVwYau7sOtxss12DfLiWOXAS6CcodMhH7XbJ
         s9QiaRXZF8U0qn2sfZ6M5UH+awk6o6+WqQIKQqpSG4F5iTu0QVLUcjvRTPNWY0KcWGwi
         mNOQ==
X-Gm-Message-State: AOAM531qqSp4QuO3oOiFnUM9DEKYXgiNV8zhTsfLPMlIVBEU+ZwW+pNt
        d9OAJ9ezDKSzj5fe/TluYvqPn+pnqNF6PwasO+op1uCYd6vaPLdOrl8R3r9L237CZXwIRuc4NDE
        HuLMksvThFZDTgfqf87fqPYRt
X-Received: by 2002:ac8:598f:0:b0:2f2:2a4:361c with SMTP id e15-20020ac8598f000000b002f202a4361cmr1573794qte.456.1651273000087;
        Fri, 29 Apr 2022 15:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh0SUcjIdSWte/nmVAVG3wHSeaut/EuEA6HT2sCfY0MyJSvKIWfrdFb8kUzTquUCy3hQjGjw==
X-Received: by 2002:ac8:598f:0:b0:2f2:2a4:361c with SMTP id e15-20020ac8598f000000b002f202a4361cmr1573784qte.456.1651272999856;
        Fri, 29 Apr 2022 15:56:39 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l27-20020a05620a0c1b00b0069fc13ce234sm255908qki.101.2022.04.29.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:56:39 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:56:36 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220429225636.6qm2orq4uwnl33ii@treble>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
 <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:00:44PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 11:20:24AM +0200, Peter Zijlstra wrote:
> > 
> > STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> > depending on .c or .S usage:
> > 
> >   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
> >   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> >   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
> >   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
> >   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
> >   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
> >   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0
> 
> So that weird .rodata entry is optprobe_template_func.
> 
> It being in .rodata also means it's not validated and there is no ORC
> data generated, is that all intentional? The changelog for:
> 
>   877b145f0f47 ("x86/kprobes: Move trampoline code into RODATA")
> 
> doesn't really say anything useful about any of that :/
> 
> I also don't see any kprobe/optprobe hooks in unwind.h, so what happens
> if we hit an optprobe?

Same as for any other generated code, the unwinder will try to fall back
to frame pointers, and if that doesn't work, the unwind stops.

That commit didn't change anything since it was already not being
directly executed anyway, but rather used to generate code on the fly.

And before that commit it was being ignored by ORC anyway, thanks to
STACK_FRAME_NON_STANDARD.  Which can now be removed since this code is
now data and objtool will no longer try to understand it.

-- 
Josh

