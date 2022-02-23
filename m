Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F14C0C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBWF1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiBWF0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:26:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B386C1C7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:23 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d306e372e5so163265737b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Kqez4sz2gXA92s/yKdI0Sadgd/VKyd58nC75f61sH3c=;
        b=kY6HPVZ5+V/4ADSj5gTm7IQPleGSUbrDBXkArXIMxRp8wv39Fiygf+bF+YqLodOTpp
         AZsLSr13DzroNgqyc8IDfXzcQUL9DyFnAH4zuxHj+73S9iVBPAI2bhK64r7+IZ9iPw2j
         l6U45p4hnLVXIe3HFpHe4qJp9mEpOsCgXDx6xEMFZlJGN4bxSQMLkshnkvHzcWhTYszS
         3RalZYOgTpQ3xR1RbA6oUKLNH9FzKB/Oq6geEXx6xglDHFlrVYGZZaZlqsNdHMvuOFaS
         qOuzTGhwZjX65TLhLW2uhuxlSD1GB251cNcp9nHh4Mb+0b/OHXDC3ll2brbPttKVPhId
         WuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kqez4sz2gXA92s/yKdI0Sadgd/VKyd58nC75f61sH3c=;
        b=KyQ1HssKgesP6p/a7EtwA0zD4ntUeLCtoub/BUFQgHwwJw0w0PryFcdzd+Z71XSuFo
         Fk2fbNr2bDS8WbeOclZeU1R3+fqyxJkeND3vaTwja/cSNULVbjYRKPYHWbHxhy79NPCv
         3wbmFvfBGDyI4Eri9FYcxLH1v7L3+WUCtjsF/o+eB+MHxgEiP9QZVgZx5r4MhBr8slop
         /5STA2xFrlQEg4BvRwnnaeP8wLT4E+o80PRAH1ev210aQeDzkbNv9hJSfowJWKjW6pVa
         ZP3gdwrNMdV4KS3KGW90D0dtOUEX+ZarY9UUe4jSaJejEnU+Hh5uX+kOhg99bAmGMAsC
         eQ+Q==
X-Gm-Message-State: AOAM533mu7bhLtmOx5mUW+up5hbDepYNSa10UUX0x8oIu/CD/H4zrHx6
        zmvf6KTiMSASaEPO6Tl8rNnyWEk5JVAD99OhJDoYx8uo/3Ja2HuwGeTxpN6S2Pearvthya1Wpyi
        JVUF9HP8UQkYsS7RbeK0/OUSc8Y9WPNn3TtkXQG/0iDT+eglcUuq/lpL1OtArOQjoZDvuD4Hb
X-Google-Smtp-Source: ABdhPJwRpDGu9uCaO7SUVy/qucopgnc8bRss4/HLiRU4Az2YJmA6Oz65Xuo4RY/0idM9yle+QHSTEPNKFl9M
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a25:34c9:0:b0:623:fc5f:b98 with SMTP id
 b192-20020a2534c9000000b00623fc5f0b98mr27190113yba.195.1645593912355; Tue, 22
 Feb 2022 21:25:12 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:22:15 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-40-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 39/47] mm: asi: Skip conventional L1TF/MDS mitigations
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Weisse <oweisse@google.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        alexandre.chartre@oracle.com, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Weisse <oweisse@google.com>

If ASI is enabled for an mm, then the L1D flushes and MDS mitigations
will be taken care of ASI. We check if asi is enabled by checking
current->mm->asi_enabled. To use ASI, a cgroup flag must be set before
the VM process is forked - causing a flag mm->asi_enabled to be set.

Signed-off-by: Ofir Weisse <oweisse@google.com>


---
 arch/x86/kvm/vmx/vmx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e0178b57be75..6549fef39f2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6609,7 +6609,11 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	kvm_guest_enter_irqoff();
 
-	vmx_flush_sensitive_cpu_state(vcpu);
+        /* If Address Space Isolation is enabled, it will take care of L1D
+         * flushes, and will also mitigate MDS. In other words, if no ASI -
+         * flush sensitive cpu state. */
+        if (!static_asi_enabled() || !mm_asi_enabled(current->mm))
+                vmx_flush_sensitive_cpu_state(vcpu);
 
 	asi_enter(vcpu->kvm->asi);
 
-- 
2.35.1.473.g83b2b277ed-goog

