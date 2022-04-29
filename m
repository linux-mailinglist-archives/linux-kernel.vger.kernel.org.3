Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359F5156ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiD2Vec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiD2Ve3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:34:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B069F39C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:31:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k12so16171354lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOI+Zfm4eyoCedo75kZCVCaJekQRoZtv4NjCgnrCB2c=;
        b=XqScRIXHpkmGAFnWt/K1cKg+6Y34bYX9zMQ8jRY0h8tVE8q1Ytvj7q1A2WMwoIdhqa
         UUpCJJ28rM/yN2cDt6EGCxK5Q/UbPaWiU4XpiXAlrpCb9igynrPX2LE1g1hWkfF5N7ST
         6/2yqWXmiKNa4jA9y+L8Xe6hA3tpZPWcLunSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOI+Zfm4eyoCedo75kZCVCaJekQRoZtv4NjCgnrCB2c=;
        b=J8jYoj0eRNtZ0EPgKNjfqvNGGMhwhOtx3gHKSg4qqP3LGr4ZYU7pSBFOXk1zwIRpm9
         VI1CAUOkOraZUUcFrHBZ8619GXcYLHYR0TLO7N1rfUonK5C+iE3QbO7relJjq8Eo80QZ
         KBY9PhQHX4YDK+ha3WwL94bxSFLyzxGgxnnoGVtBkzJPu4PqLqx2UZ3XMkunOGWumr0z
         rqr0TB1ojeoRvnQdNIIRSh92aKSUHYfvCQ539BySW0+xQMPL7i8twLlX5xiZFf+LT8NK
         pkMP1a/W2pUOCDuLh9jdcSeL5PrM5E3tQwsMEQTXOnLzRwPqFIvh0J5ILXAzfn0fwkZg
         VaOg==
X-Gm-Message-State: AOAM530UmcR1auXikNX4LQjcBgOD1ow7Sqe2VbTRYzs3C7pvF+/qpN+e
        tJQqKGeIfBtiPpJ7tpXYRuh9YUM2rtpmDk9M
X-Google-Smtp-Source: ABdhPJwAhxhuac4L0i7elRHQj/28peZ1EEz/P70zxbHW/Xr1W+zNx80pzVQR+LCT8VXAhcXD792oCw==
X-Received: by 2002:a05:6512:118d:b0:472:22a2:4a12 with SMTP id g13-20020a056512118d00b0047222a24a12mr839093lfr.391.1651267863436;
        Fri, 29 Apr 2022 14:31:03 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p3-20020a19f003000000b0047255d211b7sm28561lfc.230.2022.04.29.14.31.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:31:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id t25so16188922lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:31:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr888549lfv.27.1651267861837; Fri, 29 Apr
 2022 14:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
 <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com> <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
In-Reply-To: <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Apr 2022 14:30:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1p87BAj3ebiugG9Q5YaKNUDpEWmjLKam69Ak3g__Aug@mail.gmail.com>
Message-ID: <CAHk-=wg1p87BAj3ebiugG9Q5YaKNUDpEWmjLKam69Ak3g__Aug@mail.gmail.com>
Subject: Re: [PATCH v3] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 2:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> (Linus, can I add your SoB to the thing?)

If you teste this with some actual old int80 compat syscalls, then absolutely:

   Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

> +       pushq   %rdi                    /* pt_regs->di */
>         pushq   %rsi                    /* pt_regs->si */
>         xorl    %esi, %esi              /* nospec   si */

It would probably make sense to add a comment about why %rdi isn't
cleared when pushed, like all the other registers are.

Even if that comment is just "%rdi will be overwritten as arg0 of the
call to C, so no need to clear it".

Maybe as part of the PUSH_AND_CLEAR_REGS changes?

            Linus
