Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231953D488
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbiFDBVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiFDBVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:21:21 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36ED59950
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c4-20020a170902d48400b001640bfb2b4fso5023186plg.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=XW8X4yFH4HS4z3rUG15HQfdjk7kNLByZNrfMhtmxpRE=;
        b=e2VxzPqm17DRBcWDrjDQGwvn9Ur6tC1K+Hz6fpuitm+bhqnyDsG2O95bjfc4rnfuHy
         jMEMKypFP/Mp5Xev+IETFjOO/v6tmaU7KrbkeMt+1oSAsdFjBxhCR74icaueNrLLPF2b
         m/cT+s2yTX/KPrc4BsQmIA58X/J0VT4ZmL4G0WfQk67n7+OttGHfaIEREefevXN2SCCf
         GJYCZ4jGL9LMYVYwuqubyRFO5xwHXgOE6xO5oMAt9vt9pFesC98vJjulB1dL0x58dgm0
         xoVEqB9p3qfSE2hNRn0E25wIZPUwV7MUkyxy6yeC4c0Gw/I6qnmrmBqmxvagWwzAL66a
         Rz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=XW8X4yFH4HS4z3rUG15HQfdjk7kNLByZNrfMhtmxpRE=;
        b=5BZhwwfe4dxvhAi55UYY7y9UxYGlLoZV+tn/tuIOL1hdDONPQXWm3P8E1DQjIP66Oh
         OOTTai+e+DM3hL5NnyTsoJctclieSl+Q/Mdhx3fBYYVHK8J8IDc1xP81qtgtDEfLcJ7x
         s3iffQHPxTer2OgpsepEy8uaUKQ3I/z5ALzz/fNrc24DCpWt3iO/NuGqpu+a/cAltFBo
         lIomo7qMAooN0jN/uTucHkCYbfrBs639bwZbDTSOVtUJpHgysRaddxCqKVpMIFc+duOY
         VhgWifKfvpeDWiZeatvWGMGpl+U3Um5BWjSs0VGebF1qoM2CpkbEvSavIoeXHgkFJXSW
         K5pg==
X-Gm-Message-State: AOAM532iSaoT6of8PrR/4DoSgoW5bmFyYILftclAjuwSa4oKsckKCGDX
        fTBAgERvtslrE+MKIDxriFNKzcf1AiQ=
X-Google-Smtp-Source: ABdhPJwS6/Wc62GmdJJolayUMi2VNNRN0ZwS575KfBKS/8lb9cFXlunYK4TeD0ZyJQpI7ToITKfewO9y+Fw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:8d0f:0:b0:518:d867:bae8 with SMTP id
 j15-20020aa78d0f000000b00518d867bae8mr12417491pfe.13.1654305678379; Fri, 03
 Jun 2022 18:21:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:26 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-11-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 10/42] KVM: selftests: Check for _both_ XTILE data and cfg in
 AMX test
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

Check for _both_ XTILE data and cfg support in the AMX test instead of
checking for _either_ feature.  Practically speaking, no sane CPU or vCPU
will support one but not the other, but the effective "or" behavior is
subtle and technically incorrect.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 7127873bb0cb..dcad838953d0 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -335,7 +335,8 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_get_cpuid_max_basic() >= 0xd);
 
 	entry = kvm_get_supported_cpuid_index(0xd, 0);
-	TEST_REQUIRE(entry->eax & XFEATURE_MASK_XTILE);
+	TEST_REQUIRE(entry->eax & XFEATURE_MASK_XTILECFG);
+	TEST_REQUIRE(entry->eax & XFEATURE_MASK_XTILEDATA);
 
 	/* Get xsave/restore max size */
 	xsave_restore_size = entry->ecx;
-- 
2.36.1.255.ge46751e96f-goog

