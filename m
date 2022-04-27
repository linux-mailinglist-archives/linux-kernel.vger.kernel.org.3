Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8335110D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357975AbiD0GHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbiD0GHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:07:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE994EDFA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:03:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so745258pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgyVUtrm6J1JCS5KUrNI0AjgYZTOPKh8MoOAOqbUWno=;
        b=dcKZiCo53AnBnpVn6Q50dm2dHX4ea4Sb47rLt8XQqk/cg/g+GyKkz2v9T3K0GBlg+b
         HKLWAiC+oglTs4iX9dfOW7KtmvO+4XiRyBKwq8NPDzQStBtLsNq7W34w3vgp8tm5I2Mv
         Wj9TdGzdsamLEHvp89dUgxqfyQpBTOauFNez1NtIbWVF1n9HFA9/npBy0n/AYsSRBRUK
         obFn+wDBQo5X+3Vjh+AseOP6Imt6bn81H+mQ0/2nSSIjjOTEqF2sVDuuIq+G+gwuCwGh
         IOwkQM50m/vd1CnQI3dP0w+ni1+xRqBlKcswXVnCQhA0lo+dNCH5z6KOo/jkxx8jjwaC
         JQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgyVUtrm6J1JCS5KUrNI0AjgYZTOPKh8MoOAOqbUWno=;
        b=ViFSosH0rZ36H1ezrBHs0wJIyIFvpkwo6xLGgha4lurJ4X3YYdi9DWXcqr7gkKweku
         XU8YUSEZu5U2gXu3ybZIxVa2mcXO8v2Y03tb92Y/S0EL95f06ZzFpzkDOor1kg+DC5fc
         MN81ELqluNtBCCVwDjgMNRtw/stj0IAl4Q4tXWKwoTse3NT3mapEEhVmjsnQ0w6DhgAC
         091SJQEiNhUEsYK6fOrIVYurR0SqPXNHRRfYjRl6xQ1iVnF0vOKfCY/EFS0Wm5moZb0a
         kFRr2Mq5B1xZAnC/6squbMChhnQnNa5CXA82W+WXRn/k9FWU2chbiTkaiTnSVgzVdXny
         rZEw==
X-Gm-Message-State: AOAM532qJ5C6scS3SsYNY5yapQbaEBLQnTLjeVZFEezF0Hzck+zfvbgy
        cbFPYgkqKHZdbahjHhWh7JNJ4A8JYg==
X-Google-Smtp-Source: ABdhPJyrP0MHL8zd1v1MukLIqJjeQEQ7SRiOeXEbShGzE4g/T3dX/0QWazCyEX3qETSaKhns1DVQkQ==
X-Received: by 2002:a63:b58:0:b0:399:522b:d92f with SMTP id a24-20020a630b58000000b00399522bd92fmr22622368pgl.141.1651039434635;
        Tue, 26 Apr 2022 23:03:54 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j16-20020a634a50000000b003a82190a495sm14798117pgl.62.2022.04.26.23.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:03:54 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCHv2] genirq/PM: Make for_each_irq_desc() safe of irq_desc release
Date:   Wed, 27 Apr 2022 14:03:38 +0800
Message-Id: <20220427060338.7276-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-7-kernelfans@gmail.com>
References: <20220420140521.45361-7-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, this is a suspicion of the code, not a really encountered bug.

*** The scenario ***

Two threads involved
  threadA "hibernate" runs suspend_device_irqs()
  threadB "rcu_cpu_kthread" runs rcu_core()->rcu_do_batch(), which releases
  object, let's say irq_desc

Zoom in:
  threadA                                               threadB
  for_each_irq_desc(irq, desc) {
      get irq_descA which is under freeing
                                                    --->preempted by rcu_core()->rcu_do_batch()  which releases irq_descA
      raw_spin_lock_irqsave(&desc->lock, flags);
      //Oops

And since in the involved code piece, suspend_device_irqs() runs in a
preemptible context, and there may be more than one thread at this
point. So the preemption can happen.

*** The fix ***

Since there is a blockable synchronize_irq() inside the code piece,
resorting to irq_lock_sparse() to protect the irq_desc from
disappearing.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-kernel@vger.kernel.org
---
v1 -> v2: improve commit log
 kernel/irq/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ca71123a6130..4b67a4c7de3c 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -133,6 +133,7 @@ void suspend_device_irqs(void)
 	struct irq_desc *desc;
 	int irq;
 
+	irq_lock_sparse();
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool sync;
@@ -146,6 +147,7 @@ void suspend_device_irqs(void)
 		if (sync)
 			synchronize_irq(irq);
 	}
+	irq_unlock_sparse();
 }
 EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
@@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
 	struct irq_desc *desc;
 	int irq;
 
+	/* The early resume stage is free of irq_desc release */
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool is_early = desc->action &&
-- 
2.31.1

