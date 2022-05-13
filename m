Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C252661E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382026AbiEMP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382042AbiEMP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:29:00 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A062A14
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:28:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e12so15839736ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qHkbDcmIgfu+PdFtLJ6QK27CjcqHMlIDYaRd7PVknp4=;
        b=AIYIk3dQe6uIwNjIx0OXaaI8vUlWzLlvm9qrR2Wqb4c3GkB/uYpPy6XUoTmIH+EUMZ
         ql9fShPHLXrNNzvr1TBHBrsXWJygTJf9onlKDfQDrjRvhjAxXGH3u2VSUEOLr7oiiTyU
         jj/dQg5E3yqsATm0AQR+lRdHuPmhg5ydY3edvzxmDiZspHVJMaVaXy56FDAAaIwAiiqA
         YTWBaaZrYp7rmqJHc4Vbau0jHXNsDfKD7Rd8E13iRnDtpdr1ACtXDt2cxQ/bFxxZB17B
         7QR8DBkyH6BHdY+MgH5uodm7KT65RUGSWKioSmGyqBq+S91ISBZw8rXGuCASjRyAzSfR
         PC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qHkbDcmIgfu+PdFtLJ6QK27CjcqHMlIDYaRd7PVknp4=;
        b=EpMNXrwKpcSYpZLDssNY0GzSPQvzger7Mlv4TolAM35mUIYRBMn0Kc6y/H/au2qkXw
         HZnsAeXxxhVbG+hz2B1S3Fdukn5/m1XUMSA1q7Ve1lNjgC243kwl7+6nr3Y/Ph141OlI
         ior8IL3ye5+SUhcd6fetLiwA9SI1qex4wgDV61Dm90Nhy7XF4tZiYpjOJLEKGB2YyUVz
         7oRvJqyhk+kdN4BUET6A5LhQdQDxjsJPJCX2i+yD4YPqhPH6kV9SxPBcjjIePtV46mhD
         IZzqRCxHJS9gU90eXsjhc/wf78vnvDrHwK1MJLeG3181kYKenejljMErLil13stsLPXh
         ivbQ==
X-Gm-Message-State: AOAM533IkDoE/ZQzQOpmV81PL+TygZWH4wcCIg6qvLNvuUBSWvPjoZeJ
        nSKR6u+H0jAlo/FGZDBxq/4Aib/em8MQpnKFChw94w==
X-Google-Smtp-Source: ABdhPJx3VhVGgZYu2bUk/YBm7CeVVJ+1f7Fyqquyp4xWb52htCkyiut92oml18xPBAcuBtHq7ZXV6TzLPo9RyCyNumQ=
X-Received: by 2002:a25:d44e:0:b0:648:3d5b:fbd5 with SMTP id
 m75-20020a25d44e000000b006483d5bfbd5mr5516615ybf.363.1652455728952; Fri, 13
 May 2022 08:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com> <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
 <8a47d0ee50b44520a6f26177e6fe7ec5@AcuMS.aculab.com> <CAG_fn=XUqzBWzuU0cmjUoSfHTv6pN=LCqGh7Ns8kgR6L169bPw@mail.gmail.com>
 <ea7faf6e961141c7848e7587d5e369eb@AcuMS.aculab.com>
In-Reply-To: <ea7faf6e961141c7848e7587d5e369eb@AcuMS.aculab.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 May 2022 17:28:12 +0200
Message-ID: <CAG_fn=URz4SFfsrMY=Gsfra5_7-2FQYLEqE7mkg7Q3BVXeM=Yg@mail.gmail.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
To:     David Laight <David.Laight@aculab.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 4:26 PM David Laight <David.Laight@aculab.com> wrot=
e:
>
> From: Alexander Potapenko
> > Sent: 13 May 2022 13:26
> >
> > On Fri, May 13, 2022 at 1:28 PM David Laight <David.Laight@aculab.com> =
wrote:
> > >
> > > ...
> > > > Once we have the possibility to store tags in the pointers, we don'=
t
> > > > need redzones for heap/stack objects anymore, which saves quite a b=
it
> > > > of memory.
> > >
> > > You still need redzones.
> > > The high bits are ignored for actual memory accesses.
> > >
> > > To do otherwise you'd need the high bits to be in the PTE,
> > > copied to the TLB and finally get into the cache tag.
> > >
> > > Then you'd have to use the correct tags for each page.
> >
> > Sorry, I don't understand how this is relevant to HWASan in the userspa=
ce.
> > Like in ASan, we have a custom allocator that assigns tags to heap
> > objects. The assigned tag is stored in both the shadow memory for the
> > object and the pointer returned by the allocator.
> > Instrumentation inserted by the compiler checks the pointer before
> > every memory access and ensures that its tag matches the tag of the
> > object in the shadow memory.
>
> Doesn't that add so much overhead that the system runs like a sick pig?
> I don't see any point adding overhead to a generic kernel to support
> such operation.
Let me ensure we are on the same page here. Right now we are talking
about LAM support for userspace addresses.
At this point nobody is going to add instrumentation to a generic
kernel - just a prctl (let aside how exactly it works) that makes the
CPU ignore certain address bits in a particular userspace process.
The whole system is not supposed to run slower because of that - even
if one or many processes choose to enable LAM.

Now let's consider ASan (https://clang.llvm.org/docs/AddressSanitizer.html)=
.
It is a powerful detector of memory corruptions in the userspace, but
it comes with a cost:
 - compiler instrumentation bloats the code (by roughly 50%) and slows
down the execution (by up to 2x);
 - redzones around stack and heap objects, memory quarantine and
shadow memory increase the memory consumption (by up to 4x).
In short, for each 8 bytes of app memory ASan stores one byte of the
metadata (shadow memory) indicating the addressability of those 8
bytes.
It then uses compiler instrumentation to verify that every memory
access in the program accesses only addressable memory.
ASan is widely used for testing and to some extent can be used in
production, but for big server-side apps the RAM overhead becomes
critical.

This is where HWASan
(https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html)
comes to the rescue.
Instead of storing addressability info in the shadow memory, it stores
a 1-byte tag for every 16 bytes of app memory (see
https://arxiv.org/pdf/1802.09517.pdf for other options).
As I mentioned before, the custom userspace memory allocator assigns
the tags to memory chunks and returns tagged pointers.
Like ASan, HWASan uses compiler instrumentation to verify that every
memory access is touching valid memory, but in this case it must
ensure that the pointer tag matches the tag stored in the shadow
memory.
Because of instrumentation, HWASan still has comparable code size and
execution overheads, but it uses way less memory (10-35% of the
original app memory consumption).
This lets us test beefy applications, e.g. feeding real-world queries
to production services. Even smaller applications benefit from it,
e.g. because of reduced cache pressure.
HWASan has been available for Android for a while now, and proved itself us=
eful.

> > A tag mismatch is reported as an out-of-bounds or a use-after-free,
> > depending on whether the accessed memory is still considered
> > allocated.
> > Because objects with different tags follow each other, there is no
> > need to add extra redzones to the objects to detect buffer overflows.
> > (We might need to increase the object alignment though, but that's a
> > different story).
>
> How does all that help if a system call (eg read()) is given
> an invalid length.
Neither ASan nor HWASan care about what happens in the kernel.
Instead, they wrap system calls (along with some important libc
functions) and check their arguments to ensure there are no buffer
overflows.

HTH,
Alex
--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
