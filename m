Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADE59200B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbiHNONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiHNOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:12:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCCD9FCC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:12:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n4so6326622wrp.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xqc3VtPSBOAfpxrTQ3FQnbEScSjzijC2Ge9Qv+3BLFo=;
        b=KSSPXqdDvQ30jRp5ZEhGlfQ/aS0hz2oSUFeTar1lta3J4zdKDfpW/jUYA0/PiDxfDa
         7CaS1dovo6wdlqR6phEaSv5eUlvB0h4SZHh1+4WgiaWr9tMGHL3VrRJsE6ppzN8fow3i
         sRXlxbOajPCerCw1GcDlS2x8dobocGRI1cVsgcqeGnYtM1XDr5z1nMJPIvXFATv4ZA93
         ao69Y8ApqC0YOZL0ByltUGbCWAT1GUOx7eu27fPQFM4nExizuoS54M71vFUPoP8n2iPc
         McBTZn5q2UiGtoC4//f166GNAWF4vGRe7ySnMZp8phvvR0EOCoZZtTw14ts7untZY9li
         hS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xqc3VtPSBOAfpxrTQ3FQnbEScSjzijC2Ge9Qv+3BLFo=;
        b=0xV4zFg+Wsg2Zi4VJU/ZgAt9kwjZXRDT4SYjtuBCuSAn5BvgVOfNqZB9u5AesLMixQ
         CEBWF9daeQTAcsfFA6I0qD5xVDt6JLpTbV5rHEsdUp6t+H1PWPksMNf5dWODjRZqIWTq
         1LhMT8//HKYnvQM3AjjD5d9yPqc2Yp4szyO122DYyBZ48/tL7ctGuAFikeyA/ZmxT2vK
         IUV0UShT+RU6k/QYKiYu1bccl9D5zGTFF+HswuaMDB4ly1LVCnT45yjxvuvDeUmsbp+U
         jDXYY7AiWID2O8Os9uoZnmoKDFdGZXtuiw60DMZYAvKj12B5Po31mBztmN074X419FFu
         gwcQ==
X-Gm-Message-State: ACgBeo1f7bcZukFNPxxZAOuR6fC8ASWo8C+w80wpYvWoGd2sgj9m5phl
        hCDJtbTItqLto1uHD35w2mdmPQ==
X-Google-Smtp-Source: AA6agR7L6qLIdUlUFVOsEa6ZwXoag/PaFOX3IukupKFIqjjhVOE/vcErNmGNQSSR0BwuzhSCaRA2HQ==
X-Received: by 2002:adf:f708:0:b0:221:6cb7:8d52 with SMTP id r8-20020adff708000000b002216cb78d52mr6272145wrp.186.1660486371758;
        Sun, 14 Aug 2022 07:12:51 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id b8-20020adfde08000000b0021db7b0162esm4625419wrm.105.2022.08.14.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 07:12:51 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] riscv: kvm: vcpu_timer: fix unused variable warnings
Date:   Sun, 14 Aug 2022 15:12:35 +0100
Message-Id: <20220814141237.493457-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220814141237.493457-1-mail@conchuod.ie>
References: <20220814141237.493457-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

In two places, csr is set but never used:

arch/riscv/kvm/vcpu_timer.c:302:23: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
        struct kvm_vcpu_csr *csr;
                             ^
arch/riscv/kvm/vcpu_timer.c:327:23: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
        struct kvm_vcpu_csr *csr;
                             ^

Remove the variable.

Fixes: 8f5cb44b1bae ("RISC-V: KVM: Support sstc extension")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kvm/vcpu_timer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 16f50c46ba39..185f2386a747 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -299,7 +299,6 @@ static void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu)
 
 void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu_csr *csr;
 	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
 
 	kvm_riscv_vcpu_update_timedelta(vcpu);
@@ -307,7 +306,6 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 	if (!t->sstc_enabled)
 		return;
 
-	csr = &vcpu->arch.guest_csr;
 #if defined(CONFIG_32BIT)
 	csr_write(CSR_VSTIMECMP, (u32)t->next_cycles);
 	csr_write(CSR_VSTIMECMPH, (u32)(t->next_cycles >> 32));
@@ -324,13 +322,11 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 
 void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu_csr *csr;
 	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
 
 	if (!t->sstc_enabled)
 		return;
 
-	csr = &vcpu->arch.guest_csr;
 	t = &vcpu->arch.timer;
 #if defined(CONFIG_32BIT)
 	t->next_cycles = csr_read(CSR_VSTIMECMP);
-- 
2.37.1

