Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40A576A46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGOXA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGOXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:00:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1D49B42
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:00:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n2-20020a170902e54200b0016c16832828so2718223plf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4mRUe9k6N29Y8TY671ys1SOzt46CXKbNlnzYh7VBMGg=;
        b=BY+ofGKbdhxI2uO5Nyqd5dE57NYG6j6ZefdgDGiAMMy15vVMXVMCrAxkz/HmhpImK+
         Grv+x99LKg2/2a7c8R/phTxEvCikiuo0xcEF+jCO7cRYnO7Jz86w6MRWzcHiUpAcmpse
         0iTfrjC1O28pwL1VrBCVYAXfp8Eo9G1UJBI8jOC23NXXn0vDG7ZLCMOn05PaeAjhfClh
         wO0w2V7+MZ1Bl/hlLPcPW45z8QlYCjNcKvOAYamGbWsL9h7BLrpWxBRhmOYPC/bkhtLM
         qUA7RMiIQSituv4YUDa3XRxArvCtVaN2kUHvfSpAQ6HYdnbb4MjeiIsma9YMnf6/n2C4
         1sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4mRUe9k6N29Y8TY671ys1SOzt46CXKbNlnzYh7VBMGg=;
        b=bf85g6GsIyms0VG66SpJw2VXTdHnbKarxSY8LiiGxztlrdUOxbE9QKqCmvQjJ53y9v
         ulswkVQeYXWK9lxSOky3/XtjRPPeo1KK2HEsQn1BphyN+8sRyROc7gaYxxaxwSo7AgEK
         1MOFU+kHRcTjmgNQ9r1pObuB6z2VILOBtJVQKfmDoUU2CH1eTuADf/UxSWxJOv96MjN2
         o/UsQY19BA0I74BwgxMqRfihUGfTt5YXSVvLW7Nbr8BkaLPU4JEfbbKBmStNnwcXTP+6
         fcpCEe6QTCO93M3NhjLBpxenMGLybQo20qpebATYr3I7PgRhJ0RhDti6AkAyAhwTPu6V
         beYg==
X-Gm-Message-State: AJIora84Af7EnzBJiV7ZZlI/BPVnArKMavU6b9wGRiMS0bItshkfFOlF
        bjmWyeFl9V5kYiLPhJ5YOg5d2yabh9M=
X-Google-Smtp-Source: AGRyM1smbVwsZvafhg6YAk0nSxXgCOlfpSnfKN9p9HtlEhf/jQcGocWbnbcv1Ozn+bbDrtBXCdl//YT/YPo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d54b:b0:16b:eea4:77da with SMTP id
 z11-20020a170902d54b00b0016beea477damr15632782plf.45.1657926021275; Fri, 15
 Jul 2022 16:00:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 23:00:13 +0000
In-Reply-To: <20220715230016.3762909-1-seanjc@google.com>
Message-Id: <20220715230016.3762909-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220715230016.3762909-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH 1/4] KVM: x86: Reject loading KVM if host.PAT[0] != WB
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject KVM if entry '0' in the host's IA32_PAT MSR is not programmed to
writeback (WB) memtype.  KVM subtly relies on IA32_PAT entry '0' to be
programmed to WB by leaving the PAT bits in shadow paging and NPT SPTEs
as '0'.  If something other than WB is in PAT[0], at _best_ guests will
suffer very poor performance, and at worst KVM will crash the system by
breaking cache-coherency expecations (e.g. using WC for guest memory).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f389691d8c04..12199c40f2bc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9141,6 +9141,7 @@ static struct notifier_block pvclock_gtod_notifier = {
 int kvm_arch_init(void *opaque)
 {
 	struct kvm_x86_init_ops *ops = opaque;
+	u64 host_pat;
 	int r;
 
 	if (kvm_x86_ops.hardware_enable) {
@@ -9179,6 +9180,20 @@ int kvm_arch_init(void *opaque)
 		goto out;
 	}
 
+	/*
+	 * KVM assumes that PAT entry '0' encodes WB memtype and simply zeroes
+	 * the PAT bits in SPTEs.  Bail if PAT[0] is programmed to something
+	 * other than WB.  Note, EPT doesn't utilize the PAT, but don't bother
+	 * with an exception.  PAT[0] is set to WB on RESET and also by the
+	 * kernel, i.e. failure indicates a kernel bug or broken firmware.
+	 */
+	if (rdmsrl_safe(MSR_IA32_CR_PAT, &host_pat) ||
+	    (host_pat & GENMASK(2, 0)) != 6) {
+		pr_err("kvm: host PAT[0] is not WB\n");
+		r = -EIO;
+		goto out;
+	}
+
 	r = -ENOMEM;
 
 	x86_emulator_cache = kvm_alloc_emulator_cache();
-- 
2.37.0.170.g444d1eabd0-goog

