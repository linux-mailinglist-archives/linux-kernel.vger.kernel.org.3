Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480053AEBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiFAVch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFAVcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:32:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF831CC605
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:32:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so6335254ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffstMNYdm6Th87DI/HOitfOIxMIMYv8ZytO6RbkzlZY=;
        b=Chq61GI/bV6pHfyp5YMa6KyQjPzc7zKS5We80jGfrk/LT7Q3gAlu8wQA2EmT1gB11/
         UwmUojlDPt66vJNZOVI/QrW/WHtqGDlIzQMk/Xk0SuWGmSxsZvCaFxAHBAg7tOEzrqBx
         HLz2+B9AhpoOrTHp6LIKy4aPgMDdYAbzPNR9MrAw1UOC/REl6NJC5/5Hd0bWjZ54krM1
         Uu9kXnNLpnXbdENBhauaASanEThJFiEeRzcHxXGTfZr+mT7N4hG3SSqwmstR/saeM7sZ
         uhCUBCd9AbPOfMfN8COObGFb43VI8HihYC5KAk6sicsuoIPC/dz0LJAmLSiN0TsfnqoT
         Mtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffstMNYdm6Th87DI/HOitfOIxMIMYv8ZytO6RbkzlZY=;
        b=MzlAJhQavOEWwrAipYucdnJfIEO1favmRkxhHGxlx2VXU+0RonzxOjCq7OORiPzu+Z
         4MeotzXRvhRwHTkH/mU20zOXQ4H2gW/IYC6jaOolCSubAKdtAw0mVtn6Id0intPAAt3F
         lGzn20WmBoqqKqRHpu04aPfEQHJxrsD/Q+d1ieFVlwnmxJCwfuVnKawOU1g1BCo1tw0f
         1kGMADjbKNZPda9E9ePjXWy60SH4iJstkiJVFEI7c0qyyPRXxWTRmVJwQ/RukgHw5mo9
         NS/ItSkIcbsCbIjpozO4kMAxcSoEDIbCRCKIAvrOini3RDwmE8dB4KDwg5uzRs9dPimm
         Ma7A==
X-Gm-Message-State: AOAM530AwoFfzIHdA9eXXBIuzynIM2srXhZwtO9qZjWNILnyz2wMIHWr
        jtFmL6ttoHR1qfQMfgRVRWRiZuRS8MifXw==
X-Google-Smtp-Source: ABdhPJxD28LOlEz1vdMYyMix/CAolgg0JgvrztVGwnIG3iYsL9uRbxMzUIQQE3vJ9iDZDR9hkhtz0g==
X-Received: by 2002:a17:907:3e09:b0:6ff:20f:9b1a with SMTP id hp9-20020a1709073e0900b006ff020f9b1amr1409342ejc.679.1654119153179;
        Wed, 01 Jun 2022 14:32:33 -0700 (PDT)
Received: from greyhound.fritz.box (p200300ca5f0f8200dd53629cdd1c59bf.dip0.t-ipconnect.de. [2003:ca:5f0f:8200:dd53:629c:dd1c:59bf])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b006f4c4330c49sm1115083ejb.57.2022.06.01.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:32:32 -0700 (PDT)
Received: from cc by greyhound.fritz.box with local (Exim 4.94.2)
        (envelope-from <cc@localhost>)
        id 1nwVx9-0040Hr-Lv; Wed, 01 Jun 2022 23:32:31 +0200
From:   Christian Ludwig <chrissicool@gmail.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] entry: KVM: Change override for arch_xfer_to_guest_mode_handle_work()
Date:   Wed,  1 Jun 2022 21:32:31 +0000
Message-Id: <20220601213231.954411-1-chrissicool@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way arch_xfer_to_guest_mode_handle_work() can be overridden
by architecture code. Use the function name as the preprocessor define.
This is better greppable. And it resembles the way many other overrides
are constructed in the tree.

Note that none of this matters at the moment. There is no architecture
overriding this function. This change is purely cosmetic.

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 include/linux/entry-kvm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..2d2ba13b3e75 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -31,15 +31,13 @@ struct kvm_vcpu;
  * Invoked from xfer_to_guest_mode_handle_work(). Defaults to NOOP. Can be
  * replaced by architecture specific code.
  */
-static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
-						      unsigned long ti_work);
-
-#ifndef arch_xfer_to_guest_mode_work
+#ifndef arch_xfer_to_guest_mode_handle_work
 static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
 						      unsigned long ti_work)
 {
 	return 0;
 }
+#define arch_xfer_to_guest_mode_handle_work arch_xfer_to_guest_mode_handle_work
 #endif
 
 /**
-- 
2.35.1

