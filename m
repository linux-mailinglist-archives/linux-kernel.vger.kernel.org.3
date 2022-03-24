Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9264E68A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352664AbiCXSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbiCXSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:30:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029E219C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 5so9541796lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOuQ7lQIk0yplNqi+jvymhgkrCl+mQzAfvkaP3v21Zg=;
        b=F1gmDRvgnekSE4xiUqkP50lxmnvVNWiafWHHde3XAkU3q/fNDqgcRUpd5oWvBCbEoL
         48maxcm9GEElSkyUX0v8eROht5pg1Se6HIfjgy3MW1wR7y38njcJmy1gmPjjNcPPeNOt
         vE6fhRDWaVVTEdPx/6jRugEC26VY8XIoChwvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOuQ7lQIk0yplNqi+jvymhgkrCl+mQzAfvkaP3v21Zg=;
        b=qWU0kLuPyrW39Q4KBA2V5YdCNx3Lu9aodHkIxSRTPCqaRnhL2VXxKPxMB4bZy9hHty
         0BjxA8a+orhz/Uz1vy/i3Wim24QbKyJEz1TooUl8eXYk9kFqYZH+mAVYM+28UB9fuesu
         9p5t6SZK8d7ebQGlxwYeCtuMPUvp5/5eU+ou0ePi8NPffibVFxb9p3t/B2o+5Ga5xH+Z
         VS/uTZKfYZ1lHkbLRXqL8i0OxLBj7dcorP/W1CZ4ITKcsjfUCCudLIowfCx6Yv1dxzn/
         1SFKEdKOeG/S4uWZSvAdUkDVWYb+Gxj+yctfr5DVcqti8VvkYXnBlFnt+5w7cgf8Jaxc
         GpoQ==
X-Gm-Message-State: AOAM530O0Wb9S3e1cAqAGV14PLHndSQBkOShgTHWfp3kYrljEG0sqS9G
        uX98kXILXq3x75/x+fAUGDvzU04B7HR0Jpbpu3g=
X-Google-Smtp-Source: ABdhPJwvcy0xFox0dnefmUVr6ffmTZkBWNyUTMdJjD3nHyR/lE/lp13RXQL3CR0APbiV+myORHoU3w==
X-Received: by 2002:a05:6512:1045:b0:44a:6422:4c8 with SMTP id c5-20020a056512104500b0044a642204c8mr2990870lfb.253.1648146514501;
        Thu, 24 Mar 2022 11:28:34 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y12-20020a2eb00c000000b00249b0547be5sm260995ljk.99.2022.03.24.11.28.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:28:32 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 17so7352236lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:28:32 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr5136345ljc.506.1648146512266; Thu, 24
 Mar 2022 11:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
 <20220324173927.2230447-1-bigeasy@linutronix.de>
In-Reply-To: <20220324173927.2230447-1-bigeasy@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 11:28:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
Message-ID: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove volatile from arch_raw_cpu_ptr() and revert
 the hacks.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
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

On Thu, Mar 24, 2022 at 10:39 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The following series does that. The assembly code looks okay. In a few
> simple test cases the this_cpu_ptr() usage is always created and is not
> moved passed preempt_enable() statement.

Hmm. I didn't think things through, and you're very correct in having
thought about preempt_enable/disable as needing barriers for that asm.

So the "volatile" does have that potential significance for that
arch_raw_cpu_ptr() in case it was what ordered it wrt preemption.

It turns out that it's all ok, because

 - even without the 'volatile', arch_raw_cpu_ptr() has an *input* that
is a memory location:

                     : "m" (this_cpu_off)

 - and prempt_{dis,en}able() fundamentally has a 'barrier()' in it

and as such it's not just random luck that the percpu thing is never
moved around preemption points. They are properly serialized even
without any 'volatile'.

But that "it's not just random luck" might be worth a comment.

So Ack on your series, but that additional comment might be worth it,
since I didn't even think of it until you mentioned it. Clearly much
too subtle.

Thanks,
              Linus
