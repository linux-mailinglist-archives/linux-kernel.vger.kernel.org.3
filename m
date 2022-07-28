Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D767E5847A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiG1VU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiG1VUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:20:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88B6E8B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:20:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3415652pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uuN6oV2GDxVgrMrqBmdFNwnkVyBPZkA4XskmYFR538M=;
        b=KNMypVL63c6J1kGWCcU1z+6rnrd5vdPhCfv4kiN5RGx4ubCIjZ1GxW9mJkr4vEl3QE
         wb/fYespIwj5zRps11p0Ql+jbfsowwu8z5M7IluoPiOKLwqgk+jrpiA/DvampHtFZTnC
         Stypnoqag7pqxhfKtMHzdTzNIFpiBSAIX96frENV7ZEEv2Vq12BnPw234C8qkHtW9Iry
         RXI1cviow6I4m9m6rdLPd034RnzOTwmO+8dX763q9XksNQLmkJTbEqLZkrhUXmTdDsMN
         xdrHBxJXoBaDwlZhZUz1Lelh+TB9pISZj+DFDwANAGNL7fROgtHM1IbUhI3vnqM19nyA
         X+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uuN6oV2GDxVgrMrqBmdFNwnkVyBPZkA4XskmYFR538M=;
        b=t5d0X7rCY0wO7yvraJ0tBr4SGSEPO4jSO7RzdOXCyUutJ0v8JR8HwfelfxZ1EMkQ+4
         i2qMUxBud1hrES0U023rKPl6ZrXEg7Gsn3NecU2OaFhzRdE4LxUB4IHL+76oOMmW0lKS
         pnU0tNlhNJEx0B/GeYkMm0Eg/+n1k3c7KYQCYmx6Ho3u1xXSg4UdmpzwYkcVZ06Kuzz3
         J5mXu2jQNgNuPouApxM1EjlHHP/OAJfZ8H9QJVpHZ3PNNXuoCTxqzaCtBNP8haIPOX5p
         wECJzhyxgvTz5+FlTPtG1SKavdmc30A4ibLiFHRbbZHYQIROp+dyT65u+dYP/awXOWQM
         enQQ==
X-Gm-Message-State: ACgBeo3pxt5FZzmvUx+X3dfNQqUKDRyZ/VsYiDESZ3B4jC2cZ+gBCf64
        yexCSWcZTtm8dlLU3xcEh8LOJg==
X-Google-Smtp-Source: AA6agR5tmWMEJ2tsryUZTuqYhWdo/6KZgZs5pr3I1SGn4yIBa/QGPUT2iCS4TUg40upw5pijthGhiA==
X-Received: by 2002:a17:90a:6fe1:b0:1f3:19f7:2e2d with SMTP id e88-20020a17090a6fe100b001f319f72e2dmr675184pjk.28.1659043252422;
        Thu, 28 Jul 2022 14:20:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090332c500b0016a091eb88esm1812015plr.126.2022.07.28.14.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:20:51 -0700 (PDT)
Date:   Thu, 28 Jul 2022 21:20:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 0/6] KVM: x86: Apply NX mitigation more precisely
Message-ID: <YuL9sB8ux88TJ9o0@google.com>
References: <20220723012325.1715714-1-seanjc@google.com>
 <08c9e2ed-29a2-14ea-c872-1a353a70d3e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c9e2ed-29a2-14ea-c872-1a353a70d3e5@redhat.com>
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

On Thu, Jul 28, 2022, Paolo Bonzini wrote:
> On 7/23/22 03:23, Sean Christopherson wrote:
> > Patch 6 from Mingwei is the end goal of the series.  KVM incorrectly
> > assumes that the NX huge page mitigation is the only scenario where KVM
> > will create a non-leaf page instead of a huge page.   Precisely track
> > (via kvm_mmu_page) if a non-huge page is being forced and use that info
> > to avoid unnecessarily forcing smaller page sizes in
> > disallowed_hugepage_adjust().
> > 
> > v2: Rebase, tweak a changelog accordingly.
> > 
> > v1:https://lore.kernel.org/all/20220409003847.819686-1-seanjc@google.com
> > 
> > Mingwei Zhang (1):
> >    KVM: x86/mmu: explicitly check nx_hugepage in
> >      disallowed_hugepage_adjust()
> > 
> > Sean Christopherson (5):
> >    KVM: x86/mmu: Tag disallowed NX huge pages even if they're not tracked
> >    KVM: x86/mmu: Properly account NX huge page workaround for nonpaging
> >      MMUs
> >    KVM: x86/mmu: Set disallowed_nx_huge_page in TDP MMU before setting
> >      SPTE
> >    KVM: x86/mmu: Track the number of TDP MMU pages, but not the actual
> >      pages
> >    KVM: x86/mmu: Add helper to convert SPTE value to its shadow page
> 
> Some of the benefits are cool, such as not having to track the pages for the
> TDP MMU, and patch 2 is a borderline bugfix, but there's quite a lot of new
> non-obvious complexity here.

100% agree on the complexity.

> So the obligatory question is: is it worth a hundred lines of new code?

Assuming I understanding the bug Mingwei's patch fixes, yes.  Though after
re-reading that changelog, it should more explicitly call out the scenario we
actually care about.

Anyways, the bug we really care about is that by not precisely checking if a
huge page is disallowed, KVM would refuse to create huge page after disabling
dirty logging, which is a very noticeable performance issue for large VMs if
a migration is canceled.  That particular bug has since been unintentionally
fixed in the TDP MMU by zapping the non-leaf SPTE, but there are other paths
that could similarly be affected, e.g. I believe zapping leaf SPTEs in response
to a host page migration (mmu_notifier invalidation) to create a huge page would
yield a similar result; KVM would see the shadow-present non-leaf SPTE and assume
a huge page is disallowed.
