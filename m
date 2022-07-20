Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C0957B354
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGTI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGTI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:57:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E656B26E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:57:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c131so30330705ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pCmF+7gOKupa+PsFrKqJcnPGIHHy1V9PA29ImLA4kE=;
        b=k1b0oNdyAPyKppu26soAvwI1DTLaUOuzVZL1OJUREWpzg99kCQHlJ3mGB9+fRSdKZ2
         WgGeggybcfpJ5PsclC9OLSHyK2Mi14seCCJCYwYfZ/u1KPOT8ce9WtFHpPCxDLEx6pI9
         Vxwz3xWWl//RNMDhU9pPggpBqUGAVUimQs1YzaDeGwiXEdotfA8mZx3k+0hyPeOHyVZb
         vNVcZnbsn9V+5bB7N9eEnmYEsxd1NLGVh67+0SmMELw0OSbuQQSu1leVLC+QVk8NuxlU
         tpmrh+pZlnKtk5miszbWS9lR9ycJYLLsVGuZ/tJ8CTyAZOOO5+IqLIPCMwHhSCZZ6ogf
         CdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pCmF+7gOKupa+PsFrKqJcnPGIHHy1V9PA29ImLA4kE=;
        b=No8kDZys/nqKTDJj7NhQEXYSntMU3p4TjTxsIteLIM0nw6bVqhFrXuly+6Ws+w60uC
         pVJIydPdCXMxRXW1NSJrCK/LRifdAPWW6w4cSJ6cUe7gYp38pjIPVfSpnlW+yNucyZD7
         CJhlPag/ifDJzhm1LJEONJINYg+KDhPhld3nb7h5PquG1O/lKCJw+bcJwSTyMCIoX4S2
         +XR2G6IEZ/8mMxNDDWu36iKG6tRwdORa5PJdM7uWYKDBSRKSt3EGkkLYjFfXvThaPEXV
         gmOBDVWb+IAD+voUp2pIlXwlFP1eMRsNgyt4wZeV5k4rSiovc5gddiXwzkt8lrs+zBui
         q08Q==
X-Gm-Message-State: AJIora/tFQIZ9wPDnODOS+Bi3ZO9aQffXRjev20d8SBaJJ7XVWu1vHh4
        v4mUfSv5bF+hp4HMY4MZh+xfVWNDU9RPWH3NkVMn89K51Sg=
X-Google-Smtp-Source: AGRyM1v+Q9OYjm34O3xxK2nJl712afZfGnQd156RF/2egoZC2mPPCZsW9ObspHJIA6fRWa3fzUnLH6ZabeYZQZHfH2E=
X-Received: by 2002:a25:6847:0:b0:66e:b676:834c with SMTP id
 d68-20020a256847000000b0066eb676834cmr35990047ybc.5.1658307457762; Wed, 20
 Jul 2022 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-6-kirill.shutemov@linux.intel.com> <20220713150200.17080-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220713150200.17080-1-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Jul 2022 10:57:01 +0200
Message-ID: <CAG_fn=VVBOe8cvbWSMLfJf577yirThABQOMmihNW4pg55Sfhfg@mail.gmail.com>
Subject: Re: [PATCHv5.1 04/13] x86/mm: Handle LAM on context switch
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

>         /*
> @@ -491,6 +493,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  {
>         struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>         u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +       unsigned long prev_lam = tlbstate_lam_cr3_mask();
Note: this variable is never used if CONFIG_DEBUG_VM is off.

>  #ifdef CONFIG_DEBUG_VM
> -       if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
> +       if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
>                 /*
>                  * If we were to BUG here, we'd be very likely to kill
>                  * the system so hard that we don't see the call trace.
