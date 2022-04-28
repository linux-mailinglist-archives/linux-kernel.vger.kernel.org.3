Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0551290F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbiD1BtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiD1Bs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:48:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90403427DB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:45:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so6043168lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPwQIDuV4kr+Z3JfS80ukdJYoRtJwGRQLFz/8EXdtY8=;
        b=SCPzYsQnPWyQEhotMv9WnMsrFYGqhLzQhyJCSZmC2yd1aMhIzowrM7DocZOsyuBCND
         +LwiCROHEcaNzZDsvG4C5wkVi5MiKyGzYBTqe13MPpbmjjOEPGQ3P01/J/g7d0R8+Q03
         n3A3yDLjgffMlcrTHNN1O7ZvDG8Uk5nnzfpAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPwQIDuV4kr+Z3JfS80ukdJYoRtJwGRQLFz/8EXdtY8=;
        b=EmfZwX6tZMPY6LudGrfy6lDaqrTzU7ziT2s9nbPy4RhUSFD9fV/aYgSju5X8V42GGA
         3ZqsRcK8P+A8YwebvXIlxJNfBLZi4LgBldW/p0WnWOuOq2jEUtmSaEPryl+qpMP9VKbY
         H0r5pKeAmXYv+CMkZXEmGd3v6rhytrAm4TRS5RTGMvxUSWKFUT5KHULQqidtGyEXVPRz
         xFVapy64azwRq7HIhbrPRpDfIRCRWSvtjl87Lo2dIJYyImYjkpvaOpz0TGSDH0eZYlpa
         L6aIfv3JdYybsUJ8IyWqzDVg+6xUiKUoOyB6bTlqzw/0q2sYPsO/0eTL0quOtmrtkNGr
         i/fA==
X-Gm-Message-State: AOAM532LE4wpyJtq6DvguRtNp8IQm/QAp6JYKL4Tkpey3x4RoSbbCKRS
        IFIUekCLCu+YhKZ008B+G/lwHJkT2lHFxCNNP3A=
X-Google-Smtp-Source: ABdhPJytLLRhheaMb3AQLbSmU57vVb6Rx4jgrDcyVMHgO7JlwbXmr98YaDcTKLz0CDjATfr3qrapDg==
X-Received: by 2002:a05:6512:2a92:b0:472:ca3:5a with SMTP id dt18-20020a0565122a9200b004720ca3005amr11849205lfb.100.1651110344554;
        Wed, 27 Apr 2022 18:45:44 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v28-20020ac25b1c000000b0047201534505sm1417646lfn.282.2022.04.27.18.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 18:45:43 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l19so4859184ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:45:42 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr20046313ljj.358.1651110342350; Wed, 27
 Apr 2022 18:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220425203947.3311308-1-song@kernel.org> <FF2E0EC1-F9D6-4196-8887-919207BDC599@fb.com>
In-Reply-To: <FF2E0EC1-F9D6-4196-8887-919207BDC599@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 18:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA1Uku=ejwknv11ssNhz2pswhD=mJFBPEMQtCspz0YEQ@mail.gmail.com>
Message-ID: <CAHk-=wgA1Uku=ejwknv11ssNhz2pswhD=mJFBPEMQtCspz0YEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/3] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <song@kernel.org>
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

On Wed, Apr 27, 2022 at 3:24 PM Song Liu <songliubraving@fb.com> wrote:
>
> Could you please share your suggestions on this set? Shall we ship it
> with 5.18?

I'd personally prefer to just not do the prog_pack thing at all, since
I don't think it was actually in a "ready to ship" state for this
merge window, and the hugepage mapping protection games I'm still
leery of.

Yes, the hugepage protection things probably do work from what I saw
when I looked through them, but that x86 vmalloc hugepage code was
really designed for another use (non-refcounted device pages), so the
fact that it all actually seems surprisingly ok certainly wasn't
because the code was designed to do that new case.

Does the prog_pack thing work with small pages?

Yes. But that wasn't what it was designed for or its selling point, so
it all is a bit suspect to me.

And I'm looking at those set_memory_xyz() calls, and I'm going "yeah,
I think it works on x86, but on ppc I look at it and I see

  static inline int set_memory_ro(unsigned long addr, int numpages)
  {
        return change_memory_attr(addr, numpages, SET_MEMORY_RO);
  }

and then in change_memory_attr() it does

        if (WARN_ON_ONCE(is_vmalloc_or_module_addr((void *)addr) &&
                         is_vm_area_hugepages((void *)addr)))
                return -EINVAL;

and I'm "this is all supposedly generic code, but I'm not seeing how
it works cross-architecture".

I *think* it's actually because this is all basically x86-specific due
to x86 being the only architecture that implements
bpf_arch_text_copy(), and everybody else then ends up erroring out and
not using the prog_pack thing after all.

And then one of the two places that use bpf_arch_text_copy() doesn't
even check the returned error code.

So this all ends up just depending on "only x86 will actually succeed
in bpf_jit_binary_pack_finalize(), everybody else will fail after
having done all the common setup".

End result: it all seems a bit broken right now. The "generic" code
only works on x86, and on other architectures it goes through the
motions and then fails at the end. And even on x86 I worry about
actually enabling it fully.

I'm not having the warm and fuzzies about this all, in other words.

Maybe people can convince me otherwise, but I think you need to work at it.

And even for 5.19+ kind of timeframes, I'd actually like the x86
people who maintain arch/x86/mm/pat/set_memory.c also sign off on
using that code for hugepage vmalloc mappings too.

I *think* it does. But that code has various subtle things going on.

I see PeterZ is cc'd (presumably because of the text_poke() stuff, not
because of the whole "call set_memory_ro() on virtually mapped kernel
largepage memory".

Did people even talk to x86 people about this, or did the whole "it
works, except it turns out set_vm_flush_reset_perms() doesn't work"
mean that the authors of that code never got involved?

               Linus
