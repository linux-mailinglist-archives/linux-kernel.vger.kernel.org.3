Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC15A72D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiHaAiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiHaAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:37:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF4AE9C2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:36:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id k3-20020a170902c40300b001743aafd6c6so8982943plk.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=g3L7Nx3h3Wnl/8etnteeOlF7DoJAlFFq718LJDW6wr4=;
        b=kHswN3zBoCOnCESvdwJre0Gz76boSxHrEIE7McE2aLOB8cZBTx6/AOmoq/hpHwNehr
         9MLuP6xXxV4a6kEZQ3Pi1RJkh7q945nZFyA0X9XicVd/K3e0HY2qVaI6EYIgqw+naog/
         Gk7pV0I1xV1BX0elxQdq/of5qSDLSv5JqIem2idLS+gijibV2w9WVZbBk/ZseUk+7wiO
         BCIdFOyt1us80s1YhqIA4wJt8EJZTq9EspRP6s2j2zC9/5VDD0P6Ne7NveM4tnaPoW7G
         sxcNB6CprsftG1WKLyg6iwXkpXlAEOc5QVrGvFCDTMVyM2UXz0Mk8nlTsJneDFBWy3tQ
         ivOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=g3L7Nx3h3Wnl/8etnteeOlF7DoJAlFFq718LJDW6wr4=;
        b=TKq26HFqi4lNyltxzV8SG/PVU59er04/K22QvdPJjdgqTnm4bqgL4in11Cwq604AEA
         zfp4yFgS7Nf2xtxXAlXvlpN7G9wZnLka1SzrQeiepOSEMGfAsC1zgBSaQDjYjwIV1aH5
         1ihkDPGfTEhzRVgWAkozBPaB/COONk+6Ehoh89GM+qgCr3AVLicsQIRTutgyOnmkAlV5
         HCyo2OJbP2KWesIhs0fNA2+bUkEWuzCH0ZN+7zG1SzD5nlyEIZcIitKLiPrAT5WR9ViW
         ZFQa2xQVHbZDXxUHOcAu9XF++75Cic6pOR+pnWc+Frx4QGOvTOya3gZVUEyJWnMjcouO
         4Llw==
X-Gm-Message-State: ACgBeo3Ubyzdv/3YgoIVGE3UkYKXTt2g0dMz/MmtgRMDGGYAt84ZJCxc
        KmYIqn91e4IbaB4e5jpY+9hsO12lDJw=
X-Google-Smtp-Source: AA6agR6IN1LAnfH5bBLeBScqkCwKN870seY3uAaGKDqblKRdwC8ifgww1hgXKL+ypQuO4vOwOYo86F/EPu0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9308:b0:174:9dff:716b with SMTP id
 bc8-20020a170902930800b001749dff716bmr14644974plb.75.1661906141530; Tue, 30
 Aug 2022 17:35:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:35:06 +0000
In-Reply-To: <20220831003506.4117148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831003506.4117148-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831003506.4117148-20-seanjc@google.com>
Subject: [PATCH 19/19] Revert "KVM: SVM: Do not throw warning when calling
 avic_vcpu_load on a running vcpu"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that some warnings exist for good reasons.  Restore the warning
in avic_vcpu_load() that guards against calling avic_vcpu_load() on a
running vCPU now that KVM avoids doing so when switching between x2APIC
and xAPIC.  The entire point of the WARN is to highlight that KVM should
not be reloading an AVIC.

Opportunistically convert the WARN_ON() to WARN_ON_ONCE() to avoid
spamming the kernel if it does fire.

This reverts commit c0caeee65af3944b7b8abbf566e7cc1fae15c775.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b2033a56010c..3c300113d40b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1080,6 +1080,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		return;
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
-- 
2.37.2.672.g94769d06f0-goog

