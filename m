Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F54C1414
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiBWNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiBWNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:25:18 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD678E1B9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:24:47 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fc19so8132095qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRq1ZmoZqz6vzgu6ZttwFLygmkaSZmytxXDN6dK2bJ8=;
        b=P8B5Nx7SMzuI2JWxjYA/3H4yEi2pLza+5tLU/ErpdiWPo2c0I6Nvrg9hgEbHPSAEhm
         T/cIcogG/aZWysQENT+sz3LdU7G+tCkqjbTylQUqdKlWLoQnjYFL8YftPrKlI/UA3hv7
         Ot972123Shb3HwwSvhaWbbv7PnZ56ZgbDZhiPZNpVGZyORHP7OCQgwgZEFzsCBOZFChc
         /sSnssQjNzto7dEfhrYZRsd+J+BBCfhC0/xWLGjRfWfEAqw5LVnIogd4oHg2mDkIRgD3
         lSgfxYOCgIavpMRy/gLNrfY9F03JUSIoBpJgHFcU6ZM6EVotpHRvi6uTPBucRUqtgqWd
         pS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRq1ZmoZqz6vzgu6ZttwFLygmkaSZmytxXDN6dK2bJ8=;
        b=Wm16TnzGMwm/cEQOJmzh2Q6y5JjVRdepmt7YFEhBaft86YX/AzascnDxTFbY5zB4eF
         yg1eW//YE4I5aloGhQxWJOGP0kvWslWslL4pOMA+OiZT2jCeIYJ8L51Fv0aBKs9H4ULs
         Mez6b2HWPaT+3mbqSs2nmh0mXUHCTsGT4BHMWqBqYo2Uyaq5z3XOQKexXhTDBOln66iV
         Ej/nS3z5kIe7NoTCRzxYTxenAR8bpvRPdSTuQ7eq7hpPilGxH3IzGH/Lb7X8pU3pCWJl
         Zx4IvSAWjtdjBTuKgeznXm2kWY+Tba0QggfGIelOuMDfYKiGY4fCTdYNhW2rYCwQUWa+
         /pxw==
X-Gm-Message-State: AOAM531mzLlE99ZYjzkb/SAqmNglqYJEKFmgBQ6ut2xE0EKrNQXNYKh7
        WVYm+o0z/3lp963uLxnUpdWjnDHOS1vgUUO6P/0qoQ==
X-Google-Smtp-Source: ABdhPJwPqNeqK3IPrRIB0Io70zp9BhEDRiGxqJiBXHyGHL0ZcxpwKsXw2VI0SOZbA7lVquhDD9nQ9ydYewZDSQPHMIY=
X-Received: by 2002:ac8:73cf:0:b0:2d2:cb26:21f6 with SMTP id
 v15-20020ac873cf000000b002d2cb2621f6mr26354751qtp.374.1645622686290; Wed, 23
 Feb 2022 05:24:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com> <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
In-Reply-To: <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
From:   Nathaniel McCallum <nathaniel@profian.com>
Date:   Wed, 23 Feb 2022 08:24:35 -0500
Message-ID: <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        tglx@linutronix.de, bp@alien8.de,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 5:39 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Nathaniel,
>
> On 2/22/2022 12:27 PM, Nathaniel McCallum wrote:
> > 1. This interface looks very odd to me. mmap() is the kernel interface
> > for changing user space memory maps. Why are we introducing a new
> > interface for this?
>
> mmap() is the kernel interface used to create new mappings in the
> virtual address space of the calling process. This is different from
> the permissions and properties of the underlying file/memory being mapped.
>
> A new interface is introduced because changes need to be made to the
> permissions and properties of the underlying enclave. A new virtual
> address space is not needed nor should existing VMAs be impacted.
>
> This is similar to how mmap() is not used to change file permissions.
>
> VMA permissions are separate from enclave page permissions as found in
> the EPCM (Enclave Page Cache Map). The current implementation (SGX1) already
> distinguishes between the VMA and EPCM permissions - for example, it is
> already possible to create a read-only VMA from enclave pages that have
> RW EPCM permissions. mmap() of a portion of EPC memory with a particular
> permission does not imply that the underlying EPCM permissions (should)have
> that permission.

Yes. BUT... unlike the file permissions, this leaks an implementation detail.

The user process is governed by VMA permissions. And during enclave
creation, it had to mmap() all the enclave regions to their final VMA
permissions. So during enclave creation you have to use mmap() but
after enclave creation you use custom APIs? That's inconsistent at
best.

Forcing userspace to worry about the (mostly undocumented!)
interactions between EPC, PTE and VMA permissions makes these APIs
hard to use and difficult to reason about.

When I call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS, do I also have to call
mmap() to update the VMA permissions to match? It isn't clear. Nor is
it really clear why I'm calling completely separate APIs.

> > You can just simply add a new mmap flag (i.e.
> > MAP_SGX_TCS*) and then figure out which SGX instructions to execute
> > based on the desired state of the memory maps. If you do this, none of
> > the following ioctls are needed:
> >
> > * SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> > * SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> > * SGX_IOC_ENCLAVE_REMOVE_PAGES
> > * SGX_IOC_ENCLAVE_MODIFY_TYPE
> >
> > It also means that languages don't have to grow support for all these
> > ioctls. Instead, they can just reuse the existing mmap() bindings with
> > the new flag. Also, multiple operations can be combined into a single
> > mmap() call, amortizing the changes over a single context switch.
> >
> > 2. Automatically adding pages with hard-coded permissions in a fault
> > handler seems like a really bad idea.
>
> Could you please elaborate why this is a bad idea?

Because implementations that miss this subtlety suddenly have pages
with magic permissions. Magic is bad. Explicit is good.

> > How do you distinguish between
> > accesses which should result in an updated mapping and accesses that
> > should result in a fault?
>
> Accesses that should result in an updated mapping have two requirements:
> (a) address accessed belongs to the enclave based on the address
>     range specified during enclave create
> (b) there is no backing enclave page for the address

What happens if the enclave is buggy? Or has been compromised. In both
of those cases, there should be a userspace visible fault and pages
should not be added.

> > IMHO, all unmapped page accesses should
> > result in a page fault. mmap() should be called first to identify the
> > correct permissions for these pages.
> > Then the page handler should be
> > updated to use the permissions from the mapping when backfilling
> > physical pages. If I understand correctly, this should also obviate
>
> Regular enclave pages can _only_ be dynamically added with RW permission.
>
> SGX2's support for adding regular pages to an enclave via the EAUG
> instruction is architecturally set at RW. The OS cannot change those permissions
> via the EAUG instruction nor can the OS do so with a different/additional
> instruction because:
> * the OS is not able to relax permissions since that can only be done from
> within the enclave with ENCLU[EMODPE], thus it is not possible for the OS to
> dynamically add pages via EAUG as RW and then relax permissions to RWX.
> * the OS is not able to EAUG a page and immediately attempt an EMODPR either
> as Jarkko also recently inquired about:
> https://lore.kernel.org/linux-sgx/80f3d7b9-e3d5-b2c0-7707-710bf6f5081e@intel.com/

This design looks... unfinished. EAUG takes a PAGEINFO in RBX, but
PAGEINFO.SECINFO must be zeroed and EAUG instead sets magic hard-coded
permissions. Why doesn't EAUG just respect the permissions in
PAGEINFO.SECINFO? We aren't told.

Further, if the enclave can do EMODPE, why does
SGX_IOC_ENCLAVE_RELAX_PERMISSIONS even exist? None of the
documentation explains what this ioctl even does. Does it update PTE
permissions? VMA permissions? Nobody knows without reading the source
code.

Userspace should not be bothered with the subtle details of the
interaction between EPC, PTE and VMA permissions. But this API does
everything it can do to expose all these details to userspace. And it
doesn't bother to document them (probably because it is hard). It
would be much better to avoid exposing these details to userspace.

IMHO, there should be a simple flow like this (if EAUG respects
PAGEINFO.SECINFO):

1. Non-enclave calls mmap()/munmap().
2. Enclave issues EACCEPT, if necessary.
3. Enclave issues EMODPE, if necessary.

Notice that in the second step above, during the mmap() call, the
kernel ensures that EPC, PTE and VMA are in sync and fails if they
cannot be made to be compatible. Also note that in the above flow EAUG
instructions can be efficiently batched.

Given the current poor state of the EAUG instruction, we might need to
do this flow instead:

1. Enclave issues EACCEPT, if necessary. (Add RW pages...)
2. Non-enclave calls mmap()/munmap().
3. Enclave issues EACCEPT, if necessary.
4. Enclave issues EMODPE, if necessary.

However, doing EAUG only via the page access handler means that there
is no way to batch EAUG instructions and this forces a context switch
for every page you want to add. This has to be terrible for
performance. Note specifically that the SDM calls out batching, which
is currently impossible under this patch set. 35.5.7 - "Page
allocation operations may be batched to improve efficiency."

As it stands today, if I want to add 256MiB of pages to an enclave,
I'll have to do 2^16 context switches. That doesn't seem scalable.

> > the need for the weird userspace callback to allow for execute
> > permissions.
>
> User policy integration would always be required to allow execute
> permissions on a writable page. This is not expected to be a userspace
> callback but instead integration with existing user policy subsystem(s).

Why? This isn't documented.

> > 3. Implementing as I've suggested also means that we can lock down an
> > enclave, for example - after code has been JITed, by closing the file
> > descriptor. Once the file descriptor used to create the enclave is
> > closed, no further mmap() can be performed on the enclave. Attempting
> > to do EACCEPT on an unmapped page will generate a page fault.
>
> This is not clear to me. If the file descriptor is closed and no further
> mmap() is allowed then how would a process be able to enter the enclave
> to execute code within it?

EENTER (or the vdso function) with the address of a TCS page, like
normal. In Enarx, we don't retain the enclave fd after the final
mmap() following EINIT. Everything works just fine.

> This series does indeed lock down the address range to ensure that it is
> not possible to map memory that does not belong to the enclave after the
> enclave is created. Please see:
> https://lore.kernel.org/linux-sgx/1b833dbce6c937f71523f4aaf4b2181b9673519f.1644274683.git.reinette.chatre@intel.com/

That's not what I'm talking about. I'm talking about a workflow like this:

1. Enclave initialization: ECREATE ... EINIT
2. EENTER
3. Enclave JITs some code (changes page permissions)
4. EEXIT
5. Close enclave fd.
6. EENTER
7. If an enclave attempts page modifications, a fault occurs.

Think of this similar to seccomp(). The enclave wants to do some
dynamic page table manipulation. But then it wants to lock down page
table modification so that, if compromised, attackers have no ability
to obtain RWX permissions.
