Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381D4ACBA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbiBGVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbiBGVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:50:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1EAC06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:50:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x23so29708257lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ijq+SQEgOasCfrLHlBKCHwbcT+Y/IDNSQSnjTzRzSw=;
        b=jBN9y7BxHTFMA+5Hqs8ZS/igmyf6qQbVUnCCODRSEUwBrCSjqqILU4uh0PypgUtLG5
         O3bWTHyLGe7Ieqhbz9i1Xo+qNhh1Qm/jo9yFkRJvD/JCdrGdi9OpOqa23Pt5qs0rs+Qu
         cn4VhJQK6in+29yAAMojj2zm6a8nagBBoYCFbMRWxe7gGPuo7pUPPm2vJXdW6Pvh78Id
         D8ii/aNPzRzYxtROLqAlop6M4oW3n4+w99D9I08On+CJ2nM330kJWT+349yK4LVjmQfk
         HXNxCDZpTW98l2JBY4bzgGrMEZH3KBAmbaDZdTOhxYAcum8xSmbtJbyawind7qxDE+sh
         dujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ijq+SQEgOasCfrLHlBKCHwbcT+Y/IDNSQSnjTzRzSw=;
        b=W1idUBHLO58ft7mo3ZjyCY/3EGennJiferW88OryRtJCgAyXGS16SIzCED7TZXwfOp
         5XUPjEC5QwgAHvwwMC6qc6kOpxTbDoOAD0E+w4JvmvDw6u7At8xZlAIiM91NqgudABEc
         /jZgmELUxACqNky+a+m51BDDWucV0I0NaLKRquaP8PisiKtJpHHgOZRx682uKWWL9/YI
         FdyOf6EAm+oK25+sxlWxPaQ8ZeBqdw/k237rZBrU2PB3sExTlIHaNywHMEL5W4f/6fVF
         GD05TDYXj6C5Cxjw+tFYz6QfeOQJxFn0YV5RJveGCrZs3Out7vaAYBNR16elhEp6Gaal
         TIuQ==
X-Gm-Message-State: AOAM532TbOm1SXEdxZWv1pLQCEgHBmJNBKpFj8Kl8UxgYYs/lWfV0PMu
        MQeiQcuUS3dffmCTzx/H0tWlhWtn0Q6PMZCvKL8JvA==
X-Google-Smtp-Source: ABdhPJyyZyHGsx4zvOcYNokXStjUvR2p9IAVvxbSkLJKLHP62dNiRzw/RBz/mCHZp8HaItYXhfmeNONlNnlJXKM7rQ4=
X-Received: by 2002:ac2:58c7:: with SMTP id u7mr999449lfo.518.1644270649934;
 Mon, 07 Feb 2022 13:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20220204115718.14934-1-pbonzini@redhat.com> <20220204115718.14934-2-pbonzini@redhat.com>
 <Yf1pk1EEBXj0O0/p@google.com> <8081cbe5-6d12-9f99-9f0f-13c1d7617647@redhat.com>
 <YgFEVr9NM1vXdexg@google.com>
In-Reply-To: <YgFEVr9NM1vXdexg@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 7 Feb 2022 13:50:23 -0800
Message-ID: <CALzav=c9GzV3To=tjU2sdCmkzh7WLK+i+W5pUjtfZsnkcg1dcQ@mail.gmail.com>
Subject: Re: [PATCH 01/23] KVM: MMU: pass uses_nx directly to reset_shadow_zero_bits_mask
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 7, 2022 at 8:10 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sat, Feb 05, 2022, Paolo Bonzini wrote:
> > On 2/4/22 18:59, David Matlack wrote:
> > > > + reset_shadow_zero_bits_mask(vcpu, context, is_efer_nx(context));
> > >
> > > Out of curiousity, how does KVM mitigate iTLB multi-hit when shadowing
> > > NPT and the guest has not enabled EFER.NX?
> >
> > You got me worried for a second but iTLB multihit is Intel-only, isn't it?
>
> AFAIK, yes, big Core only.  arch/x86/kernel/cpu/common.c sets NO_ITLB_MULTIHIT
> for all AMD, Hygon, and Atom CPUs.

Ah that's right, it's Intel-only. Thanks!
