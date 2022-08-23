Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458C59EC40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiHWTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiHWTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:25:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F1FB0DC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:09:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ca13so17754068ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=z1E8GnokuPUf7Vf8jyRFI0tVUIIyZ4+J29LO62NqtGs=;
        b=f7YWVinSY8ScIRzGU6IKFd1NVHvyN+OHFUCMQySl/7XI8jTIEO/r5Oc2amLrrPyIkb
         Yq9Lodmd2qHYkOGWQqVBFQjnzkuEXv8IPwvbOGA62FnA7BVt9ACIGyIOBNMA6u9tDI+A
         VgeBPNnVKcOJxRAdEckzFxiEJNdYLTy0qPiT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z1E8GnokuPUf7Vf8jyRFI0tVUIIyZ4+J29LO62NqtGs=;
        b=VmXgJHdoJ4Gwv8yLKBwxMvFgMCAwTScaZyNlEFcbjdlykt4+IWOt7NK3ShlgcgDCJF
         J/GZl+MxxCuRPLBnnr1LXA4EIsaxPQJYB2kisZBSdkgVaKY14CeaXc/vsN9v75KWd53k
         KNcQQIGLo3+L5WyK8MPzWiyEFXaGWYam8lTV2Y0IcS/GIQPmL/ftA9I+O2UXA9TH2Qmj
         9eQ1g7YGbMm1KyVUbZisYcOqe1PtUBy70NGWcODCSsiCD4AOTRP380FCPRygIDqVG+Qg
         t/5b9JTgSaAx251mHmJgPsKtjrhhvbBgyChWM6fgP1AyZagW1q7BwbhOAFo6ADCRrbLK
         tjfw==
X-Gm-Message-State: ACgBeo1xIGBf5s+zSCjGSMWhnJkvn5AoZDFxM7sMOWit8dujws1jHJ5R
        EQ6y6s5vM7U0prN3mfBEu4+noJMFO4OF9Cm6
X-Google-Smtp-Source: AA6agR5miQTDkwCl9vGUiVaavpTw2VRt7yzq887XcZkt4LFs9EOE5zuLQnEFYCmq5HRRfbCjGINmZw==
X-Received: by 2002:a17:907:270e:b0:73c:b0fd:f9a2 with SMTP id w14-20020a170907270e00b0073cb0fdf9a2mr500672ejk.411.1661278180791;
        Tue, 23 Aug 2022 11:09:40 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id q7-20020a056402032700b00445f8e0a86esm1771194edw.75.2022.08.23.11.09.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 11:09:39 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id h5so17145747wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:09:38 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr13812698wrd.281.1661278178479; Tue, 23
 Aug 2022 11:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <YwSRFzQQKAXP2ncp@debian>
In-Reply-To: <YwSRFzQQKAXP2ncp@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 11:09:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn1=Gyi3Jxw4V0A=fXpOu5e1StPoyu52A6DHmbT+auzA@mail.gmail.com>
Message-ID: <CAHk-=wjn1=Gyi3Jxw4V0A=fXpOu5e1StPoyu52A6DHmbT+auzA@mail.gmail.com>
Subject: Re: mainline build failure for loongarch allmodconfig with gcc-12
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 1:34 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> I have been trying to build loongarch as part of my nightly builds, and
> I can build loongson3_defconfig without any error. But allmodconfig fails
> with the error:
>
> In function '__cmpxchg',
>     inlined from 'ssh_seq_next' at drivers/platform/surface/aggregator/controller.c:61:9,

Looks like ssh_seq_next() wants to do an atomic cmpxchg() on a single
byte value, and the Loongarch implementation only does 4- and 8-byte
versions.

It looks like loongarch - from its MIPS heritage - inherited the "we
can't do atomics on byte variables", so that it needs the same strange
"do bytes as word accesses with mask-and-shifts".

For MIPS, the code is in __xchg_small() in arch/mips/kernel/cmpxchg.c.

Alpha has something similar, except it's all done in inline asm in
arch/alpha/include/asm/xchg.h (look for "____cmpxchg(_u8," in there.

Of course, we could just add a Kconfig variable like
"ARCH_LACKS_BYTE_ATOMICS" and make that driver depend on it not being
true, and just have Loongarch set it.

But I think loongarch should just implement the byte masking stuff.
Particularly since I suspect it can just copy the MIPS code as-is.

                  Linus
