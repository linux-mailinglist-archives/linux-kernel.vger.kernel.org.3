Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C9510531
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiDZRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiDZRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:23:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF14B871
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:20:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so18563102pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4FZja9WudcKens4azldCUmjh2etbVq0EGH84l7RjgU=;
        b=gcOCeXEtfA5bcZ/0OV4XMefXitjP6xuTILazvyaC+XU0gpaBiM0Dlgq0QSn5nnYeDu
         hhDibZtZpYTsaYC0GBYi9E4xYXa1QxVYXJPTKhW5jEogY9D7brvG/037iX8URKn16x/Y
         a45/RuOD/U5pb9Hj6+uANTPMZDlDhiPvLhJUfjpngUdOCiueITld9oB5KmFW6mJiK1+S
         N76z7OfUxd1I62SO1Fu0ejnC4zUVdviKqwRlQv0tkpyGOXmistKqH7Bnmmdly65qfeU7
         Gnq6Sbk7uyoGGHhUYla7OHHq8l+ncuWcUxttGrpEjVKb9jBI5znDmgB8HDYwHZMvbBfy
         +6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4FZja9WudcKens4azldCUmjh2etbVq0EGH84l7RjgU=;
        b=OBmWN09bTuKWnIIRLkKy8iaMWx2vJ6rAD/mJKxNLqfYguwK6CVu46iyUj0hpsWkiWf
         N9XJteTP09WVd5QRo8meel27PxA/JA4O6w8k2UDINmqmfjLcOxMjT+CfaqWHh5dfxjR+
         nslY78v3ZVyvxfZrVgeG97EPB60qx2wCZ6dNzyvc9JLJoOQ8njUSOBw8G6+rYw4z2yb+
         bpufGxHIgZmIv9XAnlG9Dxm1PC10SBawSq256jb8+Yv0AOhjJnH7c0yVxEfmJswRcTwy
         go/P4++gf2r/iG5XdAGJFXb7x94WLk4TM6D3c2fvM7n4Ql7zv88QKfbGwPcIlK961B5u
         7Q/g==
X-Gm-Message-State: AOAM533tiaXvXXpKUgAdJPHIpMkBrEAmngGUO3a7rNsENKrwjfWKXprz
        18aO9lN1/krTm3aL/b6PVxv7ZnWJSDYBFi7wJkmWsQ==
X-Google-Smtp-Source: ABdhPJw41MD54CZn3iFTHAqU/4zXInNZxrbaKEbgqHdskaF06GdYcfMFMso5Ak25IGKvB9HSfzmpK89B5hdyIBaBt1M=
X-Received: by 2002:a63:8ac7:0:b0:3aa:fa62:5a28 with SMTP id
 y190-20020a638ac7000000b003aafa625a28mr14854945pgd.400.1650993600084; Tue, 26
 Apr 2022 10:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220327205803.739336-1-mizhang@google.com> <YkHRYY6x1Ewez/g4@google.com>
 <CAL715WL7ejOBjzXy9vbS_M2LmvXcC-CxmNr+oQtCZW0kciozHA@mail.gmail.com> <YkH7KZbamhKpCidK@google.com>
In-Reply-To: <YkH7KZbamhKpCidK@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 26 Apr 2022 10:19:49 -0700
Message-ID: <CAL715W+6UwO2zgoSLUeTmBHRo1HMSGshA6YMhvBiqfJrejhwFQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: add lockdep check before lookup_address_in_mm()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:15 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Mar 28, 2022, Mingwei Zhang wrote:
> > With that, I start to feel this is a bug. The issue is just so rare
> > that it has never triggered a problem.
> >
> > lookup_address_in_mm() walks the host page table as if it is a
> > sequence of _static_ memory chunks. This is clearly dangerous.
>
> Yeah, it's broken.  The proper fix is do something like what perf uses, or maybe
> just genericize and reuse the code from commit 8af26be06272
> ("perf/core: Fix arch_perf_get_page_size()).

hmm, I am thinking about this. We clearly need an adaptor layer if we
choose to use this function, e.g., size -> layer change; using irq or
not. Alternatively, I am wondering if we can just modify
lookup_address_in_mm() to make the code compatible with "lockless"
walk?

On top of that, since kvm_mmu_max_mapping_level() is used in two
places: 1) ept violation and 2) disabling dirty logging. The former
does not require disable/enable irq since it is safe. So maybe add a
parameter in this function and plumb through towards
host_pfn_mapping_level()?
>
> > But right now,  kvm_mmu_max_mapping_level() are used in other places
> > as well: kvm_mmu_zap_collapsible_spte(), which does not satisfy the
> > strict requirement of walking the host page table.
>
> The host pfn size is used only as a hueristic, so false postives/negatives are
> ok, the only race that needs to be avoided is dereferencing freed page table
> memory.  lookup_address_in_pgd() is really broken because it doesn't even ensure
> a given PxE is READ_ONCE().  I suppose one could argue the caller is broken, but
> I doubt KVM is the only user that doesn't provide the necessary protections.

right. since lookup_address_in_pgd() is so broken. I am thinking about
just fix it in place instead of switching to a different function.
