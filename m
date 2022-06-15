Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D154CBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbiFOOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbiFOOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:54:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C152FE66
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:54:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h23so19347904lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoMDtHtTQLo9Hcq1dT+XWeUHhZY2P5SZpdzuA1mTFwI=;
        b=mZaSSuMapl6ZdG640VcUpFw3YExNCMsY53STmUB0Q4FpEKMAjgqnBpLtkLKXRQtM8O
         Iazav9Ncviujq+pFGcNdcrTMbBwnfJoZB6QJ2kQNofoTtiNN4fOK6hQPI5tDnHcFiwwx
         5VGQIdQMn6HSb2HaEiMFnO6nSB1UtLq1BALXqVewg/s9uxIkTbdFpXe3LwEwWVgc90Y9
         cJ66J/SwV55xg//85NUUjFTFVM6Kwy8X/PGmH0T61WzGj2AhkP2RBbYwXl3ETZCX2O/e
         DgIt3x6vHILIok+ouydxTujxJORpRehqWxvB7t94SBYrxkXNfaskOQGbY/zfEw3piXe4
         CPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoMDtHtTQLo9Hcq1dT+XWeUHhZY2P5SZpdzuA1mTFwI=;
        b=XDbK9//KHFPiGPAiMnyL1vCwkUWirebsNTNUDbF1fYBXxnZp1Xh/Q6Nx7lJxmWIYUt
         hiOsfFSqgFKz3yUadC8SiRY76cW38LbdDWWc1r3twUvdhWFGhPKzScton3FHvC3crWXc
         6QHwwWaA4+LABZkC/csjWDg5VGDSIGOkueU5ebEV9ZfxicePYaMGzW2VDC9y8SCXfF2B
         MnCZer1hIixMROQhhVePmT5IGEWOpD00ld9mT67BB4Lq5s7fQcC9GC2SIhRRT1n+ZAIt
         PfVhLjH5lon9sXqOXi2ocTu5cMDSWYe9bYzMUBFZshHNjaPU/NQNmGEbPXhVdoYAxyOM
         lvLw==
X-Gm-Message-State: AJIora/WDLQ24TBPPdv1Lef7iGGHYiLQZAGuHx/P9UrD+KPYndpQTNQU
        9Rn5Z+ZuszUym47ISx1ymLCD6bByZCJSgByvxv49Cw==
X-Google-Smtp-Source: ABdhPJwBmMj0bnW0ZsZejTsoolvSYTgfqgbqhXjoDD1fQt6pLLYs8UcZCewi1iLyYw+UvuuGlJDrvN3cG28dwguycXM=
X-Received: by 2002:a19:5059:0:b0:479:4739:3768 with SMTP id
 z25-20020a195059000000b0047947393768mr6468219lfj.315.1655304860454; Wed, 15
 Jun 2022 07:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220614021141.1101486-1-sashal@kernel.org>
In-Reply-To: <20220614021141.1101486-1-sashal@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 15 Jun 2022 16:53:44 +0200
Message-ID: <CAG48ez1bRMCUzmkP2zpQ_4Jx0sqRw=b9-sDa-0QSqoGHpqZVJA@mail.gmail.com>
Subject: Re: [PATCH MANUALSEL 5.15 1/4] KVM: x86: do not report a vCPU as
 preempted outside instruction boundaries
To:     Sasha Levin <sashal@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, kvm@vger.kernel.org
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

On Tue, Jun 14, 2022 at 4:11 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> [ Upstream commit 6cd88243c7e03845a450795e134b488fc2afb736 ]
>
> If a vCPU is outside guest mode and is scheduled out, it might be in the
> process of making a memory access.  A problem occurs if another vCPU uses
> the PV TLB flush feature during the period when the vCPU is scheduled
> out, and a virtual address has already been translated but has not yet
> been accessed, because this is equivalent to using a stale TLB entry.
>
> To avoid this, only report a vCPU as preempted if sure that the guest
> is at an instruction boundary.  A rescheduling request will be delivered
> to the host physical CPU as an external interrupt, so for simplicity
> consider any vmexit *not* instruction boundary except for external
> interrupts.
>
> It would in principle be okay to report the vCPU as preempted also
> if it is sleeping in kvm_vcpu_block(): a TLB flush IPI will incur the
> vmentry/vmexit overhead unnecessarily, and optimistic spinning is
> also unlikely to succeed.  However, leave it for later because right
> now kvm_vcpu_check_block() is doing memory accesses.  Even
> though the TLB flush issue only applies to virtual memory address,
> it's very much preferrable to be conservative.
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This feature was introduced in commit f38a7b75267f1f (first in 4.16).
I think the fix has to be applied all the way back to there (so
additionally to what you already did, it'd have to be added to 4.19,
5.4 and 5.10)?

But it doesn't seem to apply cleanly to those older branches. Paolo,
are you going to send stable backports of this?
