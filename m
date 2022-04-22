Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F250BE92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiDVR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiDVR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:29:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535ED5EA2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:26:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so10477308ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJYid1oDIz8BlusNfEFWMXGaZqmdNR6muh9voapRylw=;
        b=AtB9Znor7qBu+dy6JyI664aV539rkJ0X3gjGNPpVOeHFyCEP/I/Hsv4NfoT9i7Hzxn
         Nl6P6cq/S2hxwrDu/aRQUrnmu+cNn5TBofpy24Mmqb+Z2ByL1r6A/ZSvapmDfqQRkP1L
         ANb2GP8Mu3sRwgI8T4O7seKqxD0Du4+OIqpag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJYid1oDIz8BlusNfEFWMXGaZqmdNR6muh9voapRylw=;
        b=OmVIzJapFzMd+0o5gKZgtqEOAJEQoK3Gh8ioR/pn9Ic+BeU2qZFDqPTmOZxePenqkH
         XR97UcT0QjFIJnYnLWwcl3NuskG09aO4iPnyzCSJSSHwNcRvkqb+8RsT8IS0vpz2FmBu
         pMp7RNu42neNgPoCZ+SqkLH4C3t+TAXfY2CpPRkDS7Z61O8ePmxMP4CisD8hf3NJ/xM6
         k8maR+U/YDYY5hhtysryr9n97erw0pz/ZKBReVh8huV8tvQBU0p1/F35WaCWcEqT7UXf
         FP/C+YbHJ5jIDuUpGDaq8vDMoL2aXVGgjK7DikCQOJhoL6MBp998YU+443BeGZDPvrtw
         kwFA==
X-Gm-Message-State: AOAM533w8oEsDtZCuDLz5JK9BVlYbK+0TcqnVlwz5rMG3ycUuapKBiGv
        ldDqDjunqfXcDZyYuc57ivUDDXLXilujp+spkl4=
X-Google-Smtp-Source: ABdhPJxiW1DbSEQmnUPWKQTa8bR1T5IkOcmxe/nUv99KWYYFEqEED1sm0zC3eEvOBA739uTinAfCMg==
X-Received: by 2002:a2e:bd13:0:b0:244:da2f:ff4d with SMTP id n19-20020a2ebd13000000b00244da2fff4dmr3563694ljq.213.1650648235626;
        Fri, 22 Apr 2022 10:23:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id bj37-20020a2eaaa5000000b0024dd3537e93sm283376ljb.114.2022.04.22.10.23.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:23:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id bn33so10449978ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:23:53 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr3347370ljh.152.1650648232816; Fri, 22
 Apr 2022 10:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
 <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
 <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com> <CANaxB-zDKVtGTRrqh4SpPKS96Ux6s01BL3BdAe-ZY_9HWSX9dw@mail.gmail.com>
In-Reply-To: <CANaxB-zDKVtGTRrqh4SpPKS96Ux6s01BL3BdAe-ZY_9HWSX9dw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 10:23:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8OCHqYkB2hVQ2FG6n5g4R0H3eetzbo9NrHooY1-4pwg@mail.gmail.com>
Message-ID: <CAHk-=wj8OCHqYkB2hVQ2FG6n5g4R0H3eetzbo9NrHooY1-4pwg@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Andrei Vagin <avagin@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>
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

On Thu, Apr 21, 2022 at 10:23 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> The big advantage of vmsplice is that it can attach real user pages into
> a pipe and then any following changes of these pages by the process
> don't trigger any allocations and extra copies of data. vmsplice in this
> case is fast. After splicing pages to pipes, we resume a process and
> splice pages from pipes to a socket or a file.  The whole process of
> dumping process pages is zero-copy.

Hmm. What happens if you just use /proc/<pid>/mem?

That just takes a reference to the tsk->mm. No page copies at all.
After that you can do anything you want to that mm.

Well, anything a /proc/<pid>/mm fd allows, which is mainly read and
write. But it stays around for as long as you keep it open, and
fundamentally stays coherent with that mm, because it *is* that mm.

And it doesn't affect anything else, because all it literally has is
that mm_struct pointer.

            Linus
