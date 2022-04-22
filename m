Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE350ACF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442988AbiDVAwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442982AbiDVAwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:52:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563127A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:49:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w19so11545678lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cyff/BYI4BHHE42Yn0eFG23oOJzOlK0YmbtegqLYiEA=;
        b=e8s2jMFqv2bC+sQVxlpzwEDZh7oycaV9S+2wmssqFmvul0CDY0M5+RlJpkTTP7Z9QR
         qi9yPXjrrlRQyUgqlQaVvL3akjasMHpEFWtfDD/ePQ8hkfHJdbNSK+y2EjwrrzH/Sitb
         /ZrMeAG6mxUhL9QmT6M7P1gmlMuuvtG6NFBDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cyff/BYI4BHHE42Yn0eFG23oOJzOlK0YmbtegqLYiEA=;
        b=4cGzKy4kh+gC4BiZa8wbmaZW6CSfmmFRg7c8Xis2hFaean4qDZgVDrjKazotHO1HaP
         XWzjwMdpKQqjR5ZlrcMmXvp4yE+1JP/wv9T27Ev0XhK4pC9dkALUJJmJnDAVQL5aZuxR
         +NQHXOuMvlBnvsp58cqS6DNkK0O+bgVNRPBRIydZGF57AakRuDj4kqekqeu0P+qais5e
         VbbB7TsmiTVMmGUXdQrvUc8gtVwWsiHoUMIzkFeaJIrSCqSt5ppBJ4JxRY23Y2mHbYB0
         6fY/4qUJHCMtGYobm1+F1EAX6iwju577D0iOttiIKOiB7Rr8sHbC+qxxnT3zWS1HCxZ/
         TyjA==
X-Gm-Message-State: AOAM533z5qkSamVXA2VDM9dfRyUgkhVMG88TdtDb41wZ8mm3SIkWZYaG
        akYB8AGFDLptItrwS4L8zJWfpvvD2PyFsf7fXKI=
X-Google-Smtp-Source: ABdhPJwMvKxR7QruqyvnOnTK5oYvf9JBIU6wwMxmohlEhWlmVWI1E4ouaIworIFG3ypcb3CNuscpwA==
X-Received: by 2002:a19:2d59:0:b0:46d:40f9:6048 with SMTP id t25-20020a192d59000000b0046d40f96048mr1397093lft.404.1650588591489;
        Thu, 21 Apr 2022 17:49:51 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h15-20020a2e9ecf000000b0024b0f17f790sm45785ljk.21.2022.04.21.17.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 17:49:50 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f5so7714955ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:49:49 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr1288388ljj.358.1650588589383; Thu, 21
 Apr 2022 17:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none> <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
 <1650582120.hf4z0mkw8v.astroid@bobo.none>
In-Reply-To: <1650582120.hf4z0mkw8v.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 17:49:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_7npMESkkeJ0dZC=EDPhn8+iyg528rE_GjnKpsUkT=A@mail.gmail.com>
Message-ID: <CAHk-=wh_7npMESkkeJ0dZC=EDPhn8+iyg528rE_GjnKpsUkT=A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        Song Liu <songliubraving@fb.com>
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

On Thu, Apr 21, 2022 at 4:30 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> VM_FLUSH_RESET_PERMS was because bpf uses the arch module allocation
> code which was not capable of dealing with huge pages in the arch
> specific direct map manipulation stuff was unable to deal with it.
> An x86 bug.

.. and a power one? The only thing really special in  __module_alloc()
on power is that same VM_FLUSH_RESET_PERMS.

Why had you otherwise disabled it there on powerpc too?

> > And that bug was an issue on power too.
>
> I missed it, which bug was that?

See above. At least it's very strongly implied by how the powerpc
__module_alloc() function also used

                    VM_FLUSH_RESET_PERMS | VM_NO_HUGE_VMAP,

because there isn't much else going on.

> No I don't notice. More work to support huge allocations for
> executable mappings, sure. But the arch's implementation explicitly
> does not support that yet. That doesn't make huge vmalloc broken!
> Ridiculous. It works fine.

There are several other reports of problems that weren't related to
permissions (at least not obviously so).

You were pointed at one of them in this thread:

    https://lore.kernel.org/all/14444103-d51b-0fb3-ee63-c3f182f0b546@molgen.mpg.de/

and yes, it also happened on x86-64, but my point this whole time has
been that x86-64 gets A *LOT* MORE TEST COVERAGE.

See the difference? The fact that it has workedc for you on powerpc
doesn't mean that it's fine on powerpc.  It only means that powerpc
gets about one thousandth of the test coverage that x86-64 gets.

> You did just effectively disable it on x86 though.

I disabled it *EVERYWHERE*.

What is so hard to understand about that?

Why are you so convinced this is about x86?

It's not.

> There really aren't all these "issues" you're imagining. They
> aren't noticable now, on power or s390, because they have
> non-buggy HAVE_ARCH_HUGE_VMALLOC implementations.

So I really think you've not tested it.

How many of those powerpc or s390 machines do you think test drivers
that do vmalloc_to_page() and then do something with that 'struct page
*'?

Seriously. Why are you so convinced that "oh, any vmalloc() can be
converted to large pages"?

I really think the only reason you think that is because it ran on
machines that basically have almost no drivers in use, and are all
very homogenous, and just didn't happen to hit the bugs.

IOW, I think you are probably entirely right that x86 has its own set
of excitement (the bpf thread has this thing about how x86 does RO
differently from other architectures), and there are likely x86
specific bugs *TOO*.

But let's just pick a random driver that uses vmalloc (literally
random - I just grepped for it and started looking at it):

   drivers/infiniband/hw/qib/qib_file_ops.c

and it unquestionably does absolutely disgusting things, and if
looking at the code makes you go "nobody should do that", then I won't
disagree all that much.

But as an example of what it does, it basically does things like this:

        rcd->subctxt_uregbase = vmalloc_user(...);

and then you can mmap it in user space in mmap_kvaddr():

                addr = rcd->subctxt_uregbase;
                size = PAGE_SIZE * subctxt_cnt;
        ...
        vma->vm_pgoff = (unsigned long) addr >> PAGE_SHIFT;
        vma->vm_ops = &qib_file_vm_ops;

and then the page fault routine is:

    static const struct vm_operations_struct qib_file_vm_ops = {
            .fault = qib_file_vma_fault,
    };

and that function qib_file_vma_fault() does things like this:

        page = vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
        if (!page)
                return VM_FAULT_SIGBUS;

        get_page(page);
        vmf->page = page;

        return 0;

and let me just claim

 (a) I bet you have never EVER tested this kind of insane code on powerpc

 (b) do you think this will work great if vmalloc() allocates large pages?

Can you now see what I'm saying?

Can you now admit that the whole "nmake vmalloc() do large pages
without explicit opt-in" was a HORRIBLE MISTAKE.

> If you're really going to insist on this will you apply this to fix
> (some of) the performance regressions it introduced?

No.

That patch is disgusting and there is no excuse for applying something
crap like that.

What I applied was the first in a series of patches that do it sanely.
That whole "a sane way forward" thing.

See

    https://lore.kernel.org/all/20220415164413.2727220-3-song@kernel.org/

for [PATCH 2/4] in the series for this particular issue.

But I'm not applying anything else than the "disable this mess" before
we have more discussion and consensus.

And dammit, you had better just admit that this wasn't some x86-only thing.

Powerpc and s390 were BROKEN GARBAGE AND JUST DIDN'T HAVE THE TEST COVERAGE.

Seriously.

And the thing is, your opt-out approach was just POINTLESS. The actual
cases that are performance-critical are likely in the single digits.

It's probably just that big-hash case and maybe a *couple* of other
cases (ie the bpf jit really wants to use it).

So opt-in is clearly the correct thing to do.

Do you now understand why I applied that "users must opt-in" patch?

Do you now understand that this is not some "x86" thing?

                Linus
