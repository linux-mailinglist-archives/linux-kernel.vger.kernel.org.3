Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C764E3303
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiCUWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCUWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:49:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F283DDCE2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:44:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so338150pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ry/V9YKDNiv2vz1hDLgo+eFR8ahO5mH8znmtscP7EmE=;
        b=WwG2u7IpZgea5H5GWN2LQKdFaBLk/jfiid/ciXEV7lby07wuiAKU6CWpErdYgWG7sP
         Lq9m3DglPE2OgHasPd0SOuZRh6xLkbOVphpN8n7QhTel+9/yHIWA/OF/h3k0RTWKvtK5
         LCmwhOoEcyWdhm7pIsyZNK1zFE48KkJ3cQ3iGs1kxoPhqrSltqaFF3ndiHec8jrw9rL7
         QQ3VC+90lgaePJAYPmsOQHCoNnvx0bWeXFxGMDPONKufR5xvjS0AicLVUpPTXzcPGCDP
         J6fb+pbaKjzLeRtijlSnOhYcKKAp7eIKHWTxaf3ubt3Fw73UqC1kOHgS3I+xHF1oxRPC
         BkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ry/V9YKDNiv2vz1hDLgo+eFR8ahO5mH8znmtscP7EmE=;
        b=wJo++jfKQeu6B4olnBQgY92V0iyo31gc/IaEQnqBQNXsjWQlOiGeiZ0w7aSDjvj08W
         lItjP5RY6J2TY+c0gCW4kIt7dXZ6Pzy3xwoyTfUKFUKYptVs5GnVMVNycu7BfGikIOSc
         pw6u0WrdZ0nwYKyZ9TljfbGnPOG474vA3WL+KaokQS8D3HwODchzq94+wbF40N697X6H
         O2BT6xoPWnBNlLEZEMoQ0MbPO9y1YpRfpQXnE0cY4gc9VWq4omQY9R2mpKbnkts9UuOP
         RZN/BS+RimN09x+flI8ZDgogLZx7ZKfg+3y4lnQLBFkjONCp1gPHiiDAKYsX68n62JkV
         T1HQ==
X-Gm-Message-State: AOAM530OLTOhufvj7ZJ3ZaFyvrfT7A/Aifo2AAU4CTuj8RS0OxkQj5j3
        Qsj+2zAxcj7E7Ymyv5OqOcuLCyTm5U6dyjjxe5/h7tlzoGlNkMeOeOfYIjpKY9aIDp4B1vAHvga
        TxpxWp4IV2iZxoq7wQF5oXfTNX8A/TkjmPx9ZYldOb9cicUJo9dKY/Cw6vcPKUX6NznaYr3i4
X-Google-Smtp-Source: ABdhPJzvtJaDirlNw2N/gfEsXwwJ07X/ORBgROWSzoIs87S3gs5eF48UAvimJequA6LLUN827xFgWpELHZ2N
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b76a:f152:cb5e:5cd2])
 (user=bgardon job=sendgmr) by 2002:a17:902:6b89:b0:154:623c:9517 with SMTP id
 p9-20020a1709026b8900b00154623c9517mr5803835plk.45.1647902654448; Mon, 21 Mar
 2022 15:44:14 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:43:54 -0700
In-Reply-To: <20220321224358.1305530-1-bgardon@google.com>
Message-Id: <20220321224358.1305530-6-bgardon@google.com>
Mime-Version: 1.0
References: <20220321224358.1305530-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2 5/9] KVM: x86/mmu: Factor out the meat of reset_tdp_shadow_zero_bits_mask
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

Factor out the implementation of reset_tdp_shadow_zero_bits_mask to a
helper function which does not require a vCPU pointer. The only element
of the struct kvm_mmu context used by the function is the shadow root
level, so pass that in too instead of the mmu context.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3b8da8b0745e..6f98111f8f8b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4487,16 +4487,14 @@ static inline bool boot_cpu_is_amd(void)
  * possible, however, kvm currently does not do execution-protection.
  */
 static void
-reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
+build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
+				int shadow_root_level)
 {
-	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
-	shadow_zero_check = &context->shadow_zero_check;
-
 	if (boot_cpu_is_amd())
 		__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
-					context->shadow_root_level, false,
+					shadow_root_level, false,
 					boot_cpu_has(X86_FEATURE_GBPAGES),
 					false, true);
 	else
@@ -4507,12 +4505,19 @@ reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
 	if (!shadow_me_mask)
 		return;
 
-	for (i = context->shadow_root_level; --i >= 0;) {
+	for (i = shadow_root_level; --i >= 0;) {
 		shadow_zero_check->rsvd_bits_mask[0][i] &= ~shadow_me_mask;
 		shadow_zero_check->rsvd_bits_mask[1][i] &= ~shadow_me_mask;
 	}
 }
 
+static void
+reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
+{
+	build_tdp_shadow_zero_bits_mask(&context->shadow_zero_check,
+					context->shadow_root_level);
+}
+
 /*
  * as the comments in reset_shadow_zero_bits_mask() except it
  * is the shadow page table for intel nested guest.
-- 
2.35.1.894.gb6a874cedc-goog

