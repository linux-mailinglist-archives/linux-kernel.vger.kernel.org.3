Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A050ECED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiDYX47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiDYX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:56:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1F65D12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:53:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mm2-20020a17090b358200b001bf529127dfso264661pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QZV9K9pshxsZaFz07eLh3A0iu/mpSkO/sGN/L0MnWRg=;
        b=BGaHIHlNvrPvSybSjzu/EsScWWrF5JLyW44N9iVFpCsDI4RdR4s5jaapPfFEF051xW
         uEl4LqPlnkp/TPbtE9AfoBR2OdWBduFArF5HPtPGq5pheLGAnnSS5+TJsEG3ax6YQLwx
         P0TPB928oo6rvMj5jIBdctRMs49ipSURFvV/E3nDJp5V90u6hvooBa1Om8DpZMBl0S4+
         NX+Soe17zx7HmGHAEcWZddf4lXIveePE6XBo68a7E0rDwhmR70ISpml+9N0JgZDTfnDu
         wYXK49IqiRFEpyEx6EoYdf/DQhVkPfW0AgNYPYqMHLa3siDY+/k0AIEagxJQzOSK0jwa
         RYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QZV9K9pshxsZaFz07eLh3A0iu/mpSkO/sGN/L0MnWRg=;
        b=LxiG3NSSYQgJFZe3zLrLPrN4gvuO5SkZ6TdmtatES6ewm5aQVUMLxVn+PcRwYM4BxG
         lgrfHfrQSfg9OGqymeqfTvUNGgVURiQEsnceqDkXiP6eShb3n/cwo+F5uI92/Y15IE0u
         hQnV62hBkYsbuk1zxa8DVgxZfPbbEH3d1dHv3LvB8FtLxlBxHw4i0FKhXwfcjJzRcQ1U
         MqAK796TFHZBhPmUcKeDuL1nIQpHO1U5WoyPSXmjM7zpUho+cNICJU7E7AXydd2t1RsT
         HTqcGZ4x/8pzgI9RwoDJieMoohnzSTiOEKXFvsHE7sxBLI+LpYoeLkUGX1h16/z0BP05
         85CQ==
X-Gm-Message-State: AOAM531f68vi4OTlbQsw0nlZ10257dmDu4Zx4xDyaCsG6B+TxGA5P2H8
        RhmaqZau6MYjnG5SV2DiUUT8JtvBBsw=
X-Google-Smtp-Source: ABdhPJz3d1qm5YaR40k8hHxXiIU3PFGNzDxiDIEVI2CGNmaGlbR+i/rQymo4a2m1+vruLE2lWlAKZfM3Z2c=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a17:90b:2249:b0:1d9:859e:59ad with SMTP id
 hk9-20020a17090b224900b001d9859e59admr5995203pjb.16.1650930827793; Mon, 25
 Apr 2022 16:53:47 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:53:39 +0000
In-Reply-To: <20220425235342.3210912-1-oupton@google.com>
Message-Id: <20220425235342.3210912-3-oupton@google.com>
Mime-Version: 1.0
References: <20220425235342.3210912-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 2/5] KVM: arm64: Don't write to Rt unless sys_reg emulation succeeds
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        reijiw@google.com, ricarkol@google.com,
        Oliver Upton <oupton@google.com>
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

emulate_sys_reg() returns 1 unconditionally, even though a a system
register access can fail. Furthermore, kvm_handle_sys_reg() writes to Rt
for every register read, regardless of if it actually succeeded.

Though this pattern is safe (as params.regval is initialized with the
current value of Rt) it is a bit ugly. Indicate failure if the register
access could not be emulated and only write to Rt on success.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/sys_regs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 36895c163eae..f0a076e5cc1c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2401,7 +2401,14 @@ static bool is_imp_def_sys_reg(struct sys_reg_params *params)
 	return params->Op0 == 3 && (params->CRn & 0b1011) == 0b1011;
 }
 
-static int emulate_sys_reg(struct kvm_vcpu *vcpu,
+/**
+ * emulate_sys_reg - Emulate a guest access to an AArch64 system register
+ * @vcpu: The VCPU pointer
+ * @params: Decoded system register parameters
+ *
+ * Return: true if the system register access was successful, false otherwise.
+ */
+static bool emulate_sys_reg(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params)
 {
 	const struct sys_reg_desc *r;
@@ -2410,7 +2417,10 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
-	} else if (is_imp_def_sys_reg(params)) {
+		return true;
+	}
+
+	if (is_imp_def_sys_reg(params)) {
 		kvm_inject_undefined(vcpu);
 	} else {
 		print_sys_reg_msg(params,
@@ -2418,7 +2428,7 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 				  *vcpu_pc(vcpu), *vcpu_cpsr(vcpu));
 		kvm_inject_undefined(vcpu);
 	}
-	return 1;
+	return false;
 }
 
 /**
@@ -2446,18 +2456,18 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	struct sys_reg_params params;
 	unsigned long esr = kvm_vcpu_get_esr(vcpu);
 	int Rt = kvm_vcpu_sys_get_rt(vcpu);
-	int ret;
 
 	trace_kvm_handle_sys_reg(esr);
 
 	params = esr_sys64_to_params(esr);
 	params.regval = vcpu_get_reg(vcpu, Rt);
 
-	ret = emulate_sys_reg(vcpu, &params);
+	if (!emulate_sys_reg(vcpu, &params))
+		return 1;
 
 	if (!params.is_write)
 		vcpu_set_reg(vcpu, Rt, params.regval);
-	return ret;
+	return 1;
 }
 
 /******************************************************************************
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

