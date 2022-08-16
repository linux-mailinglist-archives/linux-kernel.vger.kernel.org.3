Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CE59660C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiHPXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHPXeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:34:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18E792E2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:34:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so8347629plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=8ETP/Ktaqcv7tPYq7+lEOPfVoA9Z1uN0o+04/7SipRg=;
        b=VR/y9hXheTvaQXwpdmc6aIoOBdKkd4YAuLUXMf9R4KA4vHDLjusEqQJz2jVpUe9psh
         PCj+D1X3WyPodqWWl5JMTSBHn053EGaSqAIKVEau966Asj+QzEe5cKnpNDUadkAqgSNm
         WBykD2Dc1ff99h5mCMZBUEPAxzCrM5YM8kz3Nx1gR4gvVXa9oCRMLeOQzU8+GJf9Mtwe
         R48Mov/urVKjpceJa/BORjWhntwF6o0uU64rSeQFXPLPawYBeAx9mgZ8Oxwoz3twBVhz
         zimZJXu7ZbTqfflkVB4xF/UldXd/asNmqTEJmtRbIi3kkkStjpvLwVBbqw8X/Tb5mP4v
         8XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8ETP/Ktaqcv7tPYq7+lEOPfVoA9Z1uN0o+04/7SipRg=;
        b=T+YNaJ3QGkOvbwKN7wyAtllilprvwIGhyq9CLLpbov3UeEogJejvixfsf73wSanqCx
         lYrWro4GqdkO73qfmNmKFh4cxSTbf/hRccsXAphVheRCLi4ALEMmT/xuh+ay7qsgT4dN
         WfTJnO5L62/IP3vjJMhe0SVgcfG/lQ4ylVFeYtMBc0adgVZb5yYvABKeXspdfeX/T4R9
         a7YLIQ2/cXlFrCp5PfYL8TIGsNbXWJ2G9myi95bygqA+zK5CujmDh7DQ7T/qDf98jNxV
         u1K0D2hmEI6WdWR2mxKjr7pmlGDjt2AOSPzb0KjvP0hrxbna6jf3KVfysled2Yw0/3Ky
         NQDg==
X-Gm-Message-State: ACgBeo1pC25C3dPHYbTN0o/YS/+Bx8v43xZPVdVsWdBsVXgm5L54ajIU
        022ym3K6GTP5Z6L4+V1erDGfkA==
X-Google-Smtp-Source: AA6agR7jgmxaIyY03EYy5Qn5NGC4wF6e3tDTx+MU4UQynzo3qvL9KCegq5GO7LSGHIPOIQtgRMOksA==
X-Received: by 2002:a17:90a:c395:b0:1fa:b411:805a with SMTP id h21-20020a17090ac39500b001fab411805amr403844pjt.74.1660692851799;
        Tue, 16 Aug 2022 16:34:11 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r13-20020a65498d000000b0041bb35b9e80sm8242500pgs.53.2022.08.16.16.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:34:11 -0700 (PDT)
Date:   Tue, 16 Aug 2022 23:34:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH v2 2/9] KVM: x86: remove return value of kvm_vcpu_block
Message-ID: <Yvwpb6ofD1S+Rqk1@google.com>
References: <20220811210605.402337-1-pbonzini@redhat.com>
 <20220811210605.402337-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811210605.402337-3-pbonzini@redhat.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022, Paolo Bonzini wrote:
> The return value of kvm_vcpu_block will be repurposed soon to return

kvm_vcpu_block()

> the state of KVM_REQ_UNHALT.  In preparation for that, get rid of the
> current return value.  It is only used by kvm_vcpu_halt to decide whether

kvm_vcpu_halt()

> the call resulted in a wait, but the same effect can be obtained with
> a single round of polling.
> 
> No functional change intended, apart from practically indistinguishable
> changes to the polling behavior.

This "breaks" update_halt_poll_stats().  At the very least, it breaks the comment
that effectively says "waited" is set if and only if schedule() is called.

	/*
	 * Note, halt-polling is considered successful so long as the vCPU was
	 * never actually scheduled out, i.e. even if the wake event arrived
	 * after of the halt-polling loop itself, but before the full wait.
	 */
	if (do_halt_poll)
		update_halt_poll_stats(vcpu, start, poll_end, !waited);

> @@ -3493,35 +3489,32 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
>  {
>  	bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
>  	bool do_halt_poll = halt_poll_allowed && vcpu->halt_poll_ns;
> -	ktime_t start, cur, poll_end;
> +	ktime_t start, cur, poll_end, stop;
>  	bool waited = false;
>  	u64 halt_ns;
>  
>  	start = cur = poll_end = ktime_get();
> -	if (do_halt_poll) {
> -		ktime_t stop = ktime_add_ns(start, vcpu->halt_poll_ns);
> +	stop = do_halt_poll ? start : ktime_add_ns(start, vcpu->halt_poll_ns);

This is inverted, the loop should terminate after the first iteration (stop==start)
if halt-polling is _not_ allowed, i.e. do_halt_poll is false.

Overall, I don't like this patch.  I don't necessarily hate it, but I definitely
don't like it.

Isn't freeing up the return from kvm_vcpu_check_block() unnecessary?  Can't we
just do:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9f11b505cbee..ccb9f8bdeb18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10633,7 +10633,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
                if (hv_timer)
                        kvm_lapic_switch_to_hv_timer(vcpu);

-               if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
+               if (!kvm_arch_vcpu_runnable(vcpu))
                        return 1;
        }


which IMO is more intuitive and doesn't require reworking halt-polling (again).

I don't see why KVM cares if a vCPU becomes runnable after detecting that something
else caused kvm_vcpu_check_block() to bail.  E.g. a pending signal doesn't invalidate
a pending vCPU event, and either way KVM is bailing from the run loop.
