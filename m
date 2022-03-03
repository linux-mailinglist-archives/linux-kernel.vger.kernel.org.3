Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26584CBA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiCCJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCCJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:31:52 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145A16C4E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:31:07 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g26so8924821ybj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3iW8OgIGRJkwzf0fEpKvBUUqPlzMNEZGmdG3QGabg4=;
        b=URDf26+dNOI4zWZjXx4GWjlI4pZuP/MYcrhtyADZ9dTEPdKCNsoxBXS5WkZdP4DtgO
         +j0t5agvsO1Oe7MkM26noei61tmQvfeOR2A+2DUmd0muSEGvolKTFhtL/VFr0391jA6m
         jniyMZM4rk35SblfZTv3DtZY4fucvqIGl6+fYr11J2Nq7FJSiaM5vlkWeADBj2EWGDb1
         2ryEBwyA0qd5YUyDon7mzlhJMLO+FhBOWrsHZj+c+c1/Atgpf3LIbRfitjyZMXna2iHc
         sqbMSWQF0hg48zetjwTaHtTWlPaXDnhL90D2nDuJNJwy/FWqFYwQstftKDud11EaAITb
         qC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3iW8OgIGRJkwzf0fEpKvBUUqPlzMNEZGmdG3QGabg4=;
        b=8CBf2CPeLGi/X4GbbUca4Xtu0+TdTSENskNdPLb6ogYiVjM5D6r+PEDs5YI/Itduw6
         K1PlSFNyc8wU2n2fOMy7tzsOSATIggeeM8S4yrwhFY+Dg6NztxmUMr+i89Oa+D8MQoJ/
         OBuWRhKlZThd6ZLlp8/zXoU8m3d2yo8ipICwxmcALRDGmTQ1xCS53ObxPr4+h6yT0w9L
         Nz/bReKKTVWFkq8vrwxy0Wfxlsg355IAYHgc9i1jpC46w3XSMIv+rJhSZ4nIiFWTGx3x
         HBusUOWVujJ+ep/Bgvt8uNsbRVtM6423AyXgzJ6743NkdXkGF81LfOWtzY5sJGdLHFdC
         /ySw==
X-Gm-Message-State: AOAM531UEdmKdkTJ82icPc2vO7IDDPxMtS1Vandw5QNlY+WglA0dlS1t
        wUAGxS0Lm9jJwEA/FBRNxUXaamzyS27Tlc6Ckdd3FFaNZj+8aw==
X-Google-Smtp-Source: ABdhPJwydE0RMxCm9gwQXxiITojXHEgR91W45yVq0qi5hlhxGLYhhtzcXuK/rGpMLDEJtYwE/kYLODI0InSLgkv5plY=
X-Received: by 2002:a25:a4e8:0:b0:61e:1eb6:19bd with SMTP id
 g95-20020a25a4e8000000b0061e1eb619bdmr34271771ybi.168.1646299866132; Thu, 03
 Mar 2022 01:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com> <CAG_fn=Wd5GMFojbvdZkysBQ5Auy5YYRdmZfjSVMq8gpDMRZ_3w@mail.gmail.com>
In-Reply-To: <CAG_fn=Wd5GMFojbvdZkysBQ5Auy5YYRdmZfjSVMq8gpDMRZ_3w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 3 Mar 2022 10:30:30 +0100
Message-ID: <CANpmjNPBYgNMzQDKjNYFTkKnWwMe29gpXd2b9icFSnAwstW-jQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Alloc kfence_pool after system startup
To:     Alexander Potapenko <glider@google.com>
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 10:05, Alexander Potapenko <glider@google.com> wrote:

I share Alex's concerns.

> On Thu, Mar 3, 2022 at 4:15 AM Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>>
>> KFENCE aims at production environments, but it does not allow enabling
>> after system startup because kfence_pool only alloc pages from memblock.
>> Consider the following production scene:
>> At first, for performance considerations, production machines do not
>> enable KFENCE.
>
> What are the performance considerations you have in mind? Are you running KFENCE with a very aggressive sampling rate?

Indeed, what is wrong with simply starting up KFENCE with a sample
interval of 10000? However, I very much doubt that you'll notice any
performance issues above 500ms.

Do let us know what performance issues you have seen. It may be
related to an earlier version of KFENCE but has since been fixed (see
log).

>> However, after running for a while, the kernel is suspected to have
>> memory errors. (e.g., a sibling machine crashed.)
>
> I have doubts regarding this setup. It might be faster (although one can tune KFENCE to have nearly zero performance impact), but is harder to maintain.
> It will also catch fewer errors than if you just had KFENCE on from the very beginning:
>  - sibling machines may behave differently, and a certain bug may only occur once - in that case the secondary instances won't notice it, even with KFENCE;
>  - KFENCE also catches non-lethal corruptions (e.g. OOB reads), which may stay under radar for a very long time.
>
>>
>> So other production machines need to enable KFENCE, but it's hard for
>> them to reboot.
>>
>> The 1st patch allows re-enabling KFENCE if the pool is already
>> allocated from memblock.

Patch 1/2 might be ok by itself, but I still don't see the point
because you should just leave KFENCE enabled. There should be no
reason to have to turn it off. If anything, you can increase the
sample interval to something very large if needed.
