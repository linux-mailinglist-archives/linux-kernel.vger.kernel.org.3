Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26D458334C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiG0TQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiG0TPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:15:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B86D5C957
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:04:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x7so2927992pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nsmujacVytercybwEzTpO980C/0aSSMQ0B+3OnRKSQ0=;
        b=gdJhPtmUCwZmwlBzZ7mAbXflhOgEXZ6eNDtVjcumKvJjWlOPdN+SQptK0c8OogoJVL
         oAsqLe3SBrlIUStLB5mdx2RkKc17Bizexfsp0UNEtyZ6fmSDnxrIb3Jb2uzj1HBj9wCa
         TkcZPAseSbu9pxFaWGZXQRROJqcONQ/SDEMedqwYEkFNtfV7vEgiCuclrRj01iMXarIb
         OitGP1TduULw0yNiGl/JBj2w2N7Mj0QmLzonWrIZcytyuYEvIvLwlTGmQMYdEumyol0Q
         Ed5cwXUs/XQSFRyILPXOScInMTzhPALP71Zxnl3BTRw0VbGIULXDl4L861fHb4bRv70m
         L40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsmujacVytercybwEzTpO980C/0aSSMQ0B+3OnRKSQ0=;
        b=giRFjEJilpOC1zvQDRg5RRElXAN1m0IQ9MhUGj5d8XusAjRGu4GndgItLtSsgG37dh
         xEM8gnx5fWt86fY1ThlwswbpcC1m8/Q1dMlrwhUvjpmKSco7Vrh2BMM98m4LljyqEjwf
         +4VEpTqs0i6q2bsWgKzMcaUVg0uysxpHJa6/d4OR2Q0BWxNzCk3pURHOBLHmEd02M4yx
         8wYI3ZgnGMjsyHUKnHdee90OPwDwz8B4u4AqHqZXkvfbOSRlQTsxdCgOsTAcg52hZzBj
         SuIujfV0HtcqXgijJluVJbfH9j5aoToPaQKKh5RLZdlZLwWW+KzkA5EwMVSArBOR1X1N
         laCw==
X-Gm-Message-State: AJIora9o9KPgFgOF0jB+C3MFSWLTPyWeEdobfhX7CkUmcR74uUHms2KJ
        HFVkXNXb+KN5Mhy1yUkghz4Hf9GjGi3LpQ==
X-Google-Smtp-Source: AGRyM1v5jZAAYPCzTHY4R3UJnbQ1qTswvrQtXwoxO1hpUHUEC9cP5l/K0qZ9Co2B1258A01GzolK6A==
X-Received: by 2002:a17:903:2343:b0:16c:1efe:1fe0 with SMTP id c3-20020a170903234300b0016c1efe1fe0mr23912094plh.106.1658948679661;
        Wed, 27 Jul 2022 12:04:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0016dbe37cebdsm467135plg.246.2022.07.27.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 12:04:39 -0700 (PDT)
Date:   Wed, 27 Jul 2022 19:04:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 4/6] KVM: x86/mmu: Track the number of TDP MMU pages,
 but not the actual pages
Message-ID: <YuGMQ/JJjuWxaUSu@google.com>
References: <20220723012325.1715714-1-seanjc@google.com>
 <20220723012325.1715714-5-seanjc@google.com>
 <YuCl48wyA1XkqMan@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuCl48wyA1XkqMan@yzhao56-desk.sh.intel.com>
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

On Wed, Jul 27, 2022, Yan Zhao wrote:
> On Sat, Jul 23, 2022 at 01:23:23AM +0000, Sean Christopherson wrote:
> 
> <snip>
> 
> > @@ -386,16 +385,18 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
> >  static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp,
> >  			      bool shared)
> >  {
> > +	atomic64_dec(&kvm->arch.tdp_mmu_pages);
> > +
> > +	if (!sp->nx_huge_page_disallowed)
> > +		return;
> > +
> Does this read of sp->nx_huge_page_disallowed also need to be protected by
> tdp_mmu_pages_lock in shared path?


No, because only one CPU can call tdp_mmu_unlink_sp() for a shadow page.  E.g. in
a shared walk, the SPTE is zapped atomically and only the CPU that "wins" gets to
unlink the s[.  The extra lock is needed to prevent list corruption, but the
sp itself is thread safe.

FWIW, even if that guarantee didn't hold, checking the flag outside of tdp_mmu_pages_lock
is safe because false positives are ok.  untrack_possible_nx_huge_page() checks that
the shadow page is actually on the list, i.e. it's a nop if a different task unlinks
the page first.

False negatives need to be avoided, but nx_huge_page_disallowed is cleared only
when untrack_possible_nx_huge_page() is guaranteed to be called, i.e. true false
negatives can't occur.

Hmm, but I think there's a missing smp_rmb(), which is needed to ensure
nx_huge_page_disallowed is read after observing the shadow-present SPTE (that's
being unlinked).  I'll add that in the next version.
