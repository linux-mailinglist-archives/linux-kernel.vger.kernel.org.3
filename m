Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3A53D481
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbiFDBZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350378AbiFDBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:24:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0333137E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:22:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nn14-20020a17090b38ce00b001e00df82de8so8063384pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zvdMWaNQyj+1nBM7oAXW7KQ3veP+NMow+sZ2whewgkw=;
        b=nyLv+kLSFreAJTA00NX6HWxg0pjEOoRCO2HC5ufkIJPUJhf3fFpgtJtyBtv4Qt03+5
         u1FriqtXRqmJiVpZ41bJw4Avvmd0fUzCVxlslfZBGWUDWSuuTLuseV6QShb105jYCkFg
         Ur+cvuroKi1t9F8v51EBSlsoGexyGO/34Q2/Tfv3Jf0ZiaMEkG4yw5xLM4yU+Kqm53sw
         yCnaPRX7dCYboyHUMrppOqRmRXgaUF12mJOBHuMHkVkeGYaoaD1GzoxsWo46QMwzWMux
         CeGzQ4+rmDirxDR+ZPGr03T657iX9vHlM4dp32IFIL5RtSlSocDVarnlkFKgQPRERXAH
         F/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zvdMWaNQyj+1nBM7oAXW7KQ3veP+NMow+sZ2whewgkw=;
        b=ZKb3UXxDrRM4jKpA6zi4Jc3oR0g+wRfMYUOAkN/beuWwtP3BK1AZYs4pr9cl1b/qiL
         nOJmhKJGROeqBkqbQRSr9hpGkkiT+b2h9NfZTezQVrhCNKS722/qbnArxTWz2xSviUW2
         V/0LdMBAR4hVVk26MlkhFMQItoilTZBiyFHkKtzSXu0WIFgC1Fle5z++J7KA4oQ0MDpj
         mSXLqvK0FZSM1AMEwocgCs1PAXUYTZKmWlGzaFgyrP0B534EZCnsYfmc5I2qvS/rqvcH
         fQ5Ls6akEqG+n7MTR1M8hLIm5whLVwMzrdDzaSwOIBsDJpOZJwq2wOcR+MsaMYFGmGZZ
         KyLw==
X-Gm-Message-State: AOAM531ABRh5ii1/hlHzzCOhigg0iBc9awlylERiCrFkyAHEJy9PUrEi
        6xj24qMV/mEY6yO2JltKm8xXXqUCdmk=
X-Google-Smtp-Source: ABdhPJyC/2HAsAcHNEpSJJ4V8icJsGEtvYteBV/YCrRlDSO8VRpS4vFTEaPdyM6FyjkfbAZj51MrIgOLvRc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:41d1:b0:166:3c6:f055 with SMTP id
 u17-20020a17090341d100b0016603c6f055mr12689754ple.112.1654305733221; Fri, 03
 Jun 2022 18:22:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:57 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-42-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 41/42] KVM: selftests: Use the common cpuid() helper in cpu_vendor_string_is()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Use cpuid() to get CPUID.0x0 in cpu_vendor_string_is(), thus eliminating
the last open coded usage of CPUID (ignoring debug_regs.c, which emits
CPUID from the guest to trigger a VM-Exit and doesn't actually care about
the results of CPUID).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 6e8c8781996c..5cb73b2f9978 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1012,15 +1012,9 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
 static bool cpu_vendor_string_is(const char *vendor)
 {
 	const uint32_t *chunk = (const uint32_t *)vendor;
-	int eax, ebx, ecx, edx;
-	const int leaf = 0;
-
-	__asm__ __volatile__(
-		"cpuid"
-		: /* output */ "=a"(eax), "=b"(ebx),
-		  "=c"(ecx), "=d"(edx)
-		: /* input */ "0"(leaf), "2"(0));
+	uint32_t eax, ebx, ecx, edx;
 
+	cpuid(0, &eax, &ebx, &ecx, &edx);
 	return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
 }
 
-- 
2.36.1.255.ge46751e96f-goog

