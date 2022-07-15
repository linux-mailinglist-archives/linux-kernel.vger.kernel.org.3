Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4026A57686E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiGOUob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiGOUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:43:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253828AB1D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u12-20020a170902e5cc00b0016c20d40ec1so2607763plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=b1+xk/Y7b8L14xDx8lu5Sp2toyFgT2PYmi9IKXMneac=;
        b=lk6o7V/cUP+Hg7L5UNLK0PIf2rxcTW8RlPtg1EjCwrRTtmRO5gdpjH1klE/QAn0BoV
         VWGAv8FRIcmGr+ZNHWtloV3O42Vcm7SAbf8ti/IgzHAI7+EcjiDGgMsN21IEWZspsOz4
         FTU0f0aKQacQoe4p/mWApwMS40uZ9FuYOsm3V7Tj9gK1AnVaucPPlflX++eVcOH75OZw
         yFpUBuKiW35/lux1y92mFsI/EgtUGlyHIrluO/ZoY+09kPZ4wAUChU2S4iTBUC0hTXI1
         JFx8zBEv/V9xBBe1mrZ3wGTvY+QxlcXt5kbar3DwI/WTWTA+Xe1pZkz8ckQ1EDK2/RX1
         tLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=b1+xk/Y7b8L14xDx8lu5Sp2toyFgT2PYmi9IKXMneac=;
        b=KadBgqpxgV5rBcS/XXwoqHQ73kY3u5vvXz6EYM+vJm9ukCC688nZQqYNBdpxHZ+utr
         MIKAbkenC8yF6J+pNKm+TEjk25bnivKejY/HkZtQKFpgG/ONLAQtd269YdSMewPByb4Z
         +t8vkGsz2Eqd7yozdO90kccU/wt2G2sAu4HgDiVgE+fn34Btg/qQMNfAbFIEftYwF0v2
         FUSdX33KpUBGOeUqzfxtoNFqtgaHuy2MtOIrwHtBvTk6Kl02kPLS6eJxSjmQTGIXHcqe
         h25pf0aE9o1CD0Z6VUJZZe6T+DHsmHTe8wWa65CI1Yj7rEHSL5sE4VvpE0+1NqAyMnL+
         iigQ==
X-Gm-Message-State: AJIora+kjVL80HbPYC+7XIU2jVBl2N4c9h0Q/YgoUaHABEZpWGuT6Y55
        ZBbjEXLKLbWtukIk2cQJqBbAxKbPW+Y=
X-Google-Smtp-Source: AGRyM1tqH6Ngc9Dctqv+GkOtKhVxWahi++xo+RkGolYzcUS4LRAdQ8J994VOKOzr7orRl3z2w4x3ObF75yY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:14d2:b0:52a:d2a1:5119 with SMTP id
 w18-20020a056a0014d200b0052ad2a15119mr15597341pfu.36.1657917781132; Fri, 15
 Jul 2022 13:43:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 20:42:18 +0000
In-Reply-To: <20220715204226.3655170-1-seanjc@google.com>
Message-Id: <20220715204226.3655170-17-seanjc@google.com>
Mime-Version: 1.0
References: <20220715204226.3655170-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 16/24] KVM: x86: Evaluate ability to inject SMI/NMI/IRQ
 after potential VM-Exit
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determine whether or not new events can be injected after checking nested
events.  If a VM-Exit occurred during nested event handling, any previous
event that needed re-injection is gone from's KVM perspective; the event
is captured in the vmc*12 VM-Exit information, but doesn't exist in terms
of what needs to be done for entry to L1.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e20d34d856d..795c799fc767 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9657,7 +9657,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 {
-	bool can_inject = !kvm_event_needs_reinjection(vcpu);
+	bool can_inject;
 	int r;
 
 	/*
@@ -9722,7 +9722,13 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 	if (r < 0)
 		goto out;
 
-	/* try to inject new event if pending */
+	/*
+	 * New events, other than exceptions, cannot be injected if KVM needs
+	 * to re-inject a previous event.  See above comments on re-injecting
+	 * for why pending exceptions get priority.
+	 */
+	can_inject = !kvm_event_needs_reinjection(vcpu);
+
 	if (vcpu->arch.exception.pending) {
 		/*
 		 * Fault-class exceptions, except #DBs, set RF=1 in the RFLAGS
-- 
2.37.0.170.g444d1eabd0-goog

