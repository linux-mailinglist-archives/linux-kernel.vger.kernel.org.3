Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14A485EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbiAFCm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbiAFCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:42:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE5C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:42:51 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o185so3321314ybo.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUrh3Npgeap/8EiEtwRjncA+1oSJVR1QQxVGHBNvM04=;
        b=f6EQYO79bUXprc7mhn+5kkGk7QaNhdm6TSnLti6itS7mqSCQT6sQjiGOBku7WoX188
         vPdqu9VcHqayR/unWn8Q1ICELVnmKRotk6JQfhShEKTlwYXcQmP7i4wWQTx3chDRDI7A
         4kBgcl+GK+bigbshUapujhp4+UlbLV1/GOkiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUrh3Npgeap/8EiEtwRjncA+1oSJVR1QQxVGHBNvM04=;
        b=eyh3T3+cKjo9UzmRAfGex+XxI7as/UYyBQ9slmogf32xLFcxod4ktS7LDBxskxrLfR
         qdVvEeYHHRFNDq5cj0iTr5/3KMqXzkwE9AopljWpYMYl6aHpz/yb5XsrU9QgSWDD/dW2
         NtX4z7QnH9wOqOpDYYqbVnWvLEhxuoa4UV517iQRrOSuE5SkL/qed9VjcIYCalnl4f5p
         kz/bEJirWYmaSq0EZrZ2op1Auw0FxCSXFsXkjN6X0J97Izx/4wNUhslJPaqnTEuw4l6y
         6dRlK3sAj6zoYs/lcNIt3OHsR/nKcvKUoOqZ3Cp6RT9voTmWtQPCiGekQu1TXp5z6RBB
         6O5A==
X-Gm-Message-State: AOAM532JEY/hDsEZKLxL/Gdkyy61EDBTxOQhV4LWrGJF9him3sAvfJ5W
        oXl5lEOo22/ACogfcq+NrTvFc6o+Ji/GJVyhDK8KPA==
X-Google-Smtp-Source: ABdhPJySN8UQBiLK5ZELedz9aMDOihftjIfvLaugncGmaT2wHj67/GId/mm7KBCgharYeRmCbxfpR9IivB+Tgad8EI0=
X-Received: by 2002:a25:5ca:: with SMTP id 193mr64959101ybf.406.1641436971074;
 Wed, 05 Jan 2022 18:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20211129034317.2964790-1-stevensd@google.com> <20211129034317.2964790-5-stevensd@google.com>
 <Yc4G23rrSxS59br5@google.com> <CAD=HUj5Q6rW8UyxAXUa3o93T0LBqGQb7ScPj07kvuM3txHMMrQ@mail.gmail.com>
 <YdXrURHO/R82puD4@google.com> <YdXvUaBUvaRPsv6m@google.com>
In-Reply-To: <YdXvUaBUvaRPsv6m@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 6 Jan 2022 11:42:39 +0900
Message-ID: <CAD=HUj736L5oxkzeL2JoPV8g1S6Rugy_TquW=PRt73YmFzP6Jw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] KVM: mmu: remove over-aggressive warnings
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Chia-I Wu <olv@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:19 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Jan 05, 2022, Sean Christopherson wrote:
> > Ah, I got royally confused by ensure_pfn_ref()'s comment
> >
> >   * Certain IO or PFNMAP mappings can be backed with valid
> >   * struct pages, but be allocated without refcounting e.g.,
> >   * tail pages of non-compound higher order allocations, which
> >   * would then underflow the refcount when the caller does the
> >   * required put_page. Don't allow those pages here.
> >                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > that doesn't apply here because kvm_faultin_pfn() uses the low level
> > __gfn_to_pfn_page_memslot().
>
> On fifth thought, I think this is wrong and doomed to fail.  By mapping these pages
> into the guest, KVM is effectively saying it supports these pages.  But if the guest
> uses the corresponding gfns for an action that requires KVM to access the page,
> e.g. via kvm_vcpu_map(), ensure_pfn_ref() will reject the access and all sorts of
> bad things will happen to the guest.
>
> So, why not fully reject these types of pages?  If someone is relying on KVM to
> support these types of pages, then we'll fail fast and get a bug report letting us
> know we need to properly support these types of pages.  And if not, then we reduce
> KVM's complexity and I get to keep my precious WARN :-)

Our current use case here is virtio-gpu blob resources [1]. Blob
resources are useful because they avoid a guest shadow buffer and the
associated memcpys, and as I understand it they are also required for
virtualized vulkan.

One type of blob resources requires mapping dma-bufs allocated by the
host directly into the guest. This works on Intel platforms and the
ARM platforms I've tested. However, the amdgpu driver sometimes
allocates higher order, non-compound pages via ttm_pool_alloc_page.
These are the type of pages which KVM is currently rejecting. Is this
something that KVM can support?

+olv, who has done some of the blob resource work.

[1] https://patchwork.kernel.org/project/dri-devel/cover/20200814024000.2485-1-gurchetansingh@chromium.org/

-David
