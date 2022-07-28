Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D55847C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiG1VlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG1VlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:41:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1952DC5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:41:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y1so2973916pja.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqeABTxGQTDz6Qdm0FRzgWxnlTEHH6Ytj+e5WoKlX9o=;
        b=RRucGTqTTQzeQcuR07bz1WJ4pxTwsK7dR/AirbzU0cDMl1a4d/XPBmB4pzgWxFUWxo
         QiDihGbpO7ykiwej5rq/Ht+xV/3mrh2nbsnuInTPH9APjpJnQSRcKa/vz/BEF1LGbxGb
         l/CyW/LZ7uZZRd8SkCEXSxgWAhD6y6HP8IG4OTk/vfV/2mUq9DhgCJz983nMsd4tZzV3
         9xcYfVt7LIRa/pTWNUWqWBTy/6wVuc8O/5pTF4IWgUL3k3PTjEbiPI3NvDReNABeN4Ad
         wHhZIJYWm0EVv8LwU5u6s74KxnymKGHyDH1yyP8kbk9WkSGlj5osR5nzsbkVnrcgs+fh
         D8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqeABTxGQTDz6Qdm0FRzgWxnlTEHH6Ytj+e5WoKlX9o=;
        b=kt1rVUx15zo+6GeHl8DO313VLGEQ4bdEEeUNRvV4zz9Rg1kljvubCIgZWiAnEpbbYw
         GM2V28ztvwjukSNcjVrhl0JjxOwR81g9lXE+j+cIKaJy41AOOLh7TpnzImn42+336iaA
         ALD2p8QNjLZ9Ze/u/B990yIxcQg4RmK/uTWhjPBV6Ae4Te1cw8lo/FFdaFvm7Y81jSv+
         vNNIKBts7IX3fTCJNc8WgiMsOdSahh7h2MuVBiQAHuoxZoTvwXKhNi13YYwygtALcdGO
         jXdVGCdNLlsnYKcKvFl0ncl0LVcIryRxNqLlFK0V8c3ZuLTE0N2oZxcVkpjheJ1a/gGn
         B5aA==
X-Gm-Message-State: ACgBeo17JMOmjmRXDNaCOECWfUVgHdEedEokA0cLyj1Jq5IoXMR1pTa9
        DadOyd9wJoWBdtSGzdRxfYad/k3TtjdGm3K4gC2FWQ==
X-Google-Smtp-Source: AA6agR4z5qrgAr38neIx9KxOypAhLMErO+xBzP4aTQFVwzTTRHJ6ojXPeKBNQCx1cEX6gqAcqbuxe2LLKMQ9ruR5ac4=
X-Received: by 2002:a17:902:c40a:b0:16d:2dcb:9b8c with SMTP id
 k10-20020a170902c40a00b0016d2dcb9b8cmr741853plk.61.1659044480954; Thu, 28 Jul
 2022 14:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220723012325.1715714-1-seanjc@google.com> <08c9e2ed-29a2-14ea-c872-1a353a70d3e5@redhat.com>
 <YuL9sB8ux88TJ9o0@google.com>
In-Reply-To: <YuL9sB8ux88TJ9o0@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 28 Jul 2022 14:41:09 -0700
Message-ID: <CAL715WJ-joevnX+D2TDUmCA0bemJWpfimutxsQSjWZyk03Gsow@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] KVM: x86: Apply NX mitigation more precisely
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Ben Gardon <bgardon@google.com>
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

On Thu, Jul 28, 2022 at 2:20 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Jul 28, 2022, Paolo Bonzini wrote:
> > On 7/23/22 03:23, Sean Christopherson wrote:
> > > Patch 6 from Mingwei is the end goal of the series.  KVM incorrectly
> > > assumes that the NX huge page mitigation is the only scenario where KVM
> > > will create a non-leaf page instead of a huge page.   Precisely track
> > > (via kvm_mmu_page) if a non-huge page is being forced and use that info
> > > to avoid unnecessarily forcing smaller page sizes in
> > > disallowed_hugepage_adjust().
> > >
> > > v2: Rebase, tweak a changelog accordingly.
> > >
> > > v1:https://lore.kernel.org/all/20220409003847.819686-1-seanjc@google.com
> > >
> > > Mingwei Zhang (1):
> > >    KVM: x86/mmu: explicitly check nx_hugepage in
> > >      disallowed_hugepage_adjust()
> > >
> > > Sean Christopherson (5):
> > >    KVM: x86/mmu: Tag disallowed NX huge pages even if they're not tracked
> > >    KVM: x86/mmu: Properly account NX huge page workaround for nonpaging
> > >      MMUs
> > >    KVM: x86/mmu: Set disallowed_nx_huge_page in TDP MMU before setting
> > >      SPTE
> > >    KVM: x86/mmu: Track the number of TDP MMU pages, but not the actual
> > >      pages
> > >    KVM: x86/mmu: Add helper to convert SPTE value to its shadow page
> >
> > Some of the benefits are cool, such as not having to track the pages for the
> > TDP MMU, and patch 2 is a borderline bugfix, but there's quite a lot of new
> > non-obvious complexity here.
>
> 100% agree on the complexity.
>
> > So the obligatory question is: is it worth a hundred lines of new code?
>
> Assuming I understanding the bug Mingwei's patch fixes, yes.  Though after
> re-reading that changelog, it should more explicitly call out the scenario we
> actually care about.
>
> Anyways, the bug we really care about is that by not precisely checking if a
> huge page is disallowed, KVM would refuse to create huge page after disabling
> dirty logging, which is a very noticeable performance issue for large VMs if
> a migration is canceled.  That particular bug has since been unintentionally
> fixed in the TDP MMU by zapping the non-leaf SPTE, but there are other paths
> that could similarly be affected, e.g. I believe zapping leaf SPTEs in response
> to a host page migration (mmu_notifier invalidation) to create a huge page would
> yield a similar result; KVM would see the shadow-present non-leaf SPTE and assume
> a huge page is disallowed.

Just a quick update: the kernel crash has been resolved. It turns out
to be a bug introduced when I rebase the patch.

I see the patch set is working now.
