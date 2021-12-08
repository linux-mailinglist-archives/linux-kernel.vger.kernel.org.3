Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05146D73D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhLHPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbhLHPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:46:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:43:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 133so2358816pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEv3fu5jwrCboKynxcy7NVAeh4fPLUw9uHqsDZgd59A=;
        b=CtdqoIxfk9xdbrOMMQTD4+kUl5f0wJm/9Q7ajYAIKpoFqgboCwNALpHdDi6dcih/XF
         pIOizVnHfeGbkZN995/Vnw3y6v66pk+7VvbifUlyU2gEqpzcljAb7UW3/cWLDs6/ZA2f
         2vFnWVw9HG7av5Pjky7WAx7SsaGP0aU0V36FHhYQdYvRqf3DeNvWvemXiCgHF/LL160U
         zoyWfckZ+zt2092yUQIPiZ9NxQoRIKKYEXVtYpxLoU115JZBwo2M9hVmhyAZHqRW07vT
         UgXFVaaMx7XoDTy6IC6UotxC8N3O9ChO9l6hU7eyMMhCnva3OGeJ5B1QLPzspbKj3lII
         +z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEv3fu5jwrCboKynxcy7NVAeh4fPLUw9uHqsDZgd59A=;
        b=pyWCLKkHyfcEclIW8e9znAv5YVYBizbdqE28kZmYOkudO+sdUoEtWg00FiHPT6fE3K
         rHM9Fsms35cidKmAE5aCTTPtmsDE5Ux/hWo2Dzj6BYFeJE7pEct8AC6Rs3U4VSbRE453
         cuGW1Gwj5mtlyy1YQSeNLYav4K3hgLyPcVqID4eUC6zCNnF5ogLOGamnKBXt2Mh2akPJ
         8dJor+9GdWr6woSul7+/akYp+1ybBPYpYn9fDUaM9nW2nlvETxlGewdyyRMPPTs6dEqM
         KPEamMZKQm3k1Cwr7zjKhO+FfldEzhj+bxJDM3UV1lPyASf3VF2liAS1pWVqiMgU/KKW
         nZsw==
X-Gm-Message-State: AOAM532ZZshr3CxC7dZoYLxok7x3WbkOGqrG7OaKx/faEfqP1zieRhSR
        eXOyfPuamugVDZOaJjxV28b+ew==
X-Google-Smtp-Source: ABdhPJw9zpx1/5+E0bsz8TnTYB1U2ApcuigLTOlRjZUB9rdeC2fT6xcf6EVUIMLNcGB+XIl8GoETLw==
X-Received: by 2002:aa7:9249:0:b0:4a2:d1c5:c94b with SMTP id 9-20020aa79249000000b004a2d1c5c94bmr6426491pfp.45.1638978200789;
        Wed, 08 Dec 2021 07:43:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h26sm2940774pgm.68.2021.12.08.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 07:43:20 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:43:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 21/26] KVM: SVM: Drop AVIC's intermediate
 avic_set_running() helper
Message-ID: <YbDSlNsY8b2O8PtM@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <20211208015236.1616697-22-seanjc@google.com>
 <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021, Paolo Bonzini wrote:
> On 12/8/21 02:52, Sean Christopherson wrote:
> > +	/*
> > +	 * Unload the AVIC when the vCPU is about to block,_before_  the vCPU
> > +	 * actually blocks.  The vCPU needs to be marked IsRunning=0 before the
> > +	 * final pass over the vIRR via kvm_vcpu_check_block().  Any IRQs that
> > +	 * arrive before IsRunning=0 will not signal the doorbell, i.e. it's
> > +	 * KVM's responsibility to ensure there are no pending IRQs in the vIRR
> > +	 * after IsRunning is cleared, prior to scheduling out the vCPU.
> 
> I prefer to phrase this around paired memory barriers and the usual
> store/smp_mb/load lockless idiom:

I've no objection to that, my goal is/was purely to emphasize the need to manually
process the vIRR after clearing IsRunning.
 
> 	/*
> 	 * Unload the AVIC when the vCPU is about to block, _before_
> 	 * the vCPU actually blocks.
> 	 *
> 	 * Any IRQs that arrive before IsRunning=0 will not cause an
> 	 * incomplete IPI vmexit on the source,

It's not just IPIs, the GA log will also suffer the same fate.  That's why I
didn't mention incomplete VM-Exits.  I'm certainly not opposed to that clarification,
but I don't want readers to walk away thinking this is only a problem for IPIs.

> therefore vIRR will also

"s/vIRR will/the vIRR must" to make it abundantly clear that checking the vIRR
is effectively a hard requirement.

> 	 * be checked by kvm_vcpu_check_block() before blocking.  The
> 	 * memory barrier implicit in set_current_state orders writing

set_current_state()

> 	 * IsRunning=0 before reading the vIRR.  The processor needs a
> 	 * matching memory barrier on interrupt delivery between writing
> 	 * IRR and reading IsRunning; the lack of this barrier might be

Missing the opening paranthesis.

> 	 * the cause of errata #1235).
> 	 */
