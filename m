Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9E54E618
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377929AbiFPPao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbiFPPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:30:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB13C4A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:30:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o17so1555344pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xyQA3i9LnHHRPtVIgpzT7gUhIahjzWNFcSvLeE3NzXM=;
        b=m8zeYkKW1u4euayYAVyXDBaR9zlZbRLD9hLN82f7yubbRQj413prV28w+UiWa+pdmO
         KfQU5sqy4lxAVxLWqvxNJ+R0X1Cg49NLh+9dqRacje4S+bLKHChZGLn5cCY9qVldylWv
         BThfklbuxOqytrmtLCTcgu6672q0ulAJh/DmRwjEMqmbseJmnzoSpyL3Re5y11oA/Pdf
         ene2w0/s2/w8UiMku30v+m6LUnIoyJEEw1zTmk4fXijS4O9ZxAzsgd8cwtwv5imNpYnA
         96g8TJtI50rX4BZPGwQ1loluMHVGomrK3kyaqqHN+iXQKU9L12RDbql4lPWX3FeB8+lo
         J93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xyQA3i9LnHHRPtVIgpzT7gUhIahjzWNFcSvLeE3NzXM=;
        b=zJOhqWyHh+J9lXncKtHSqimPXxs61qVcOS/hdVCu9zUtFtFkzjZ272NLjYa2lG+/A+
         lBShAP7GCgB9jSfgnvWIl0KK06vFmZZB9oqiFOJq5vJ+0TBMgrWvYGT6e6BeoWSr9rmS
         Gfbctj8FtqSRVB907plJLxrrU3l38EpHC0fRrhZpuohdQmrLXNawZU5NGzllbBotpkz+
         gcE6rFdhT1WtsJxXYCp02MvW81POsaE8XX9/qe5432Mxzn7w4/1rGo1XoIu2tqkP2lnR
         mOjUe50CT6+l8JWeC8obl6dqBWbbiPqHCDqGPCu1ZFFEV98rC7mKdqfubHG+pmJrmQxz
         SoDQ==
X-Gm-Message-State: AJIora+dlSfE0W8biDWqiYg1lFjVLKPDwrTfK4WX1HHciVq9AKR2cVvk
        8hQheBQl/+o8aQ1PwJhjtxeCOA==
X-Google-Smtp-Source: AGRyM1vJ6B9gtYuMINf2l7lRLtW7qllBMCm1snr4t0uqnQGiA2z/c3Ik3BuauG2Z1RHrpJXEIU4ngg==
X-Received: by 2002:a17:90b:4b02:b0:1e2:ff51:272a with SMTP id lx2-20020a17090b4b0200b001e2ff51272amr5616373pjb.56.1655393437532;
        Thu, 16 Jun 2022 08:30:37 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm179880plo.14.2022.06.16.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:30:36 -0700 (PDT)
Date:   Thu, 16 Jun 2022 15:30:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: vmx, pmu: accept 0 for absent MSRs when
 host-initiated
Message-ID: <YqtMmAiOvJbmHCaP@google.com>
References: <20220531175450.295552-1-pbonzini@redhat.com>
 <20220531175450.295552-2-pbonzini@redhat.com>
 <YpZgU+vfjkRuHZZR@google.com>
 <ce2b4fed-3d9e-a179-a907-5b8e09511b7d@gmail.com>
 <YpeWPAHNhQQ/lRKF@google.com>
 <cbb9a8b5-f31f-dd3b-3278-01f12d935ebe@gmail.com>
 <YqoqZjH+yjYJTxmT@google.com>
 <69fac460-ff29-ca76-d9a8-d2529cf02fa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fac460-ff29-ca76-d9a8-d2529cf02fa2@redhat.com>
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

On Thu, Jun 16, 2022, Paolo Bonzini wrote:
> On 6/15/22 20:52, Sean Christopherson wrote:
> > I completely agree on needing better transparency for the lifecycle of patches
> > going through the KVM tree.  First and foremost, there need to be formal, documented
> > rules for the "official" kvm/* branches, e.g. everything in kvm/queue passes ABC
> > tests, everything in kvm/next also passes XYZ tests.  That would also be a good
> > place to document expectations, how things works, etc...
> 
> Agreed.  I think this is a more general problem with Linux development and I
> will propose this for maintainer summit.

I believe the documentation side of things is an acknowledged gap, people just need
to actually write the documentation, e.g. Boris and Thomas documented the tip-tree
under Documentation/process/maintainer-tip.rst and stubbed in maintainer-handbooks.rst.

As for patch lifecycle, I would love to have something like tip-bot (can we just
steal whatever scripts they use?) that explicitly calls out the branch, commit,
committer, date, etc...  IMO that'd pair nicely with adding kvm/pending, as the
bot/script could provide updates when a patch is first added to kvm/pending, then
again when it got moved to kvm/queue or dropped because it was broken, etc...
