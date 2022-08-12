Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA72591586
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiHLSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiHLSfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:35:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132017D7B4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:35:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-32a8e40e2dcso13466147b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=UlTdzT2bx0chOWv9FqUt/dE8vlZ3og2Lke/cZeyX+qs=;
        b=koXLHaKUzQkEYo2iYmqdTgJu30nqzbtSY1D0ksWnP0AuVZ9RJ4GJuTiQgWczVB8gQI
         jbhxQfT2C07uF2ZqgFvYiYlJ1AKRT/nL0i8toy8B85i8F7RyKq3dTqVXv7lS0UmIo3FA
         Iwb/tD0NIgHbLDkKTqBJrWtnkEyKe0TUVr+lb8bowzpxtgR4vOpZH7KmQEHJzmFYbF3U
         ywWEz7ar+CDnSHRFWMJmKnnjn2wdJ745WMqIJ2FKJRXej1F3rNoYkd8W07cT2Pb7Axlc
         H+p3Ibqt14f0+2Y6scf+OLYFRmWk81JplNpzlwk4q86b9GF3Hk93sMvPFUn+rH6Mb625
         o8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=UlTdzT2bx0chOWv9FqUt/dE8vlZ3og2Lke/cZeyX+qs=;
        b=2QWN5/2cHgQTfz3YwbTWIFZqQQSyrpGATvoMSg+maehj9Mo2rkanM2wNtdhDBQTl23
         kWsksf2CwrS5xQgeZ/AzZYMUxw1jeFc9Yi9esGJqCK7bkypIyk3hZPMQvxhJuEXDMWU1
         2vpVSn4detNsnLd51Jm2PQhiSzBah9RdIad59132MDmZXH5umdZLfqbGmknIBfvtQXuh
         vuKhAjP9UZETbKhesL1MQX6XnRt59xFd1wjiYI/5J0XtDblLzT7BjSxguYkVg3K7C8yS
         ZM1KeNm4WpV+FpE8h9pKk7570MOD4F0BeuGiBJqTfKPMVdi80IeORaz1eQLrmpsqL7x1
         MLnw==
X-Gm-Message-State: ACgBeo1e36Wa+MFLvAgchPbcWmO17FvHmJYEeWK9PxpsDXj5iPJC7y36
        YWNfvTVu20bLDL2xrD8VZutnH50=
X-Google-Smtp-Source: AA6agR7nxZI/yeeTAOnlyrib2eDoMEH/VyQGZLdJYeS5XToyz/0tiarZnE/XVGpKxyxZeXAm8YViKaU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:def9:ef59:f5b5:f65b])
 (user=pcc job=sendgmr) by 2002:a81:4ccf:0:b0:32f:cccf:cef7 with SMTP id
 z198-20020a814ccf000000b0032fcccfcef7mr1479908ywa.191.1660329335377; Fri, 12
 Aug 2022 11:35:35 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:35:30 -0700
Message-Id: <20220812183530.2261795-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] arm64: translate register values to physical addresses in
 kernel panics
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

When debugging a kernel panic it is sometimes useful to know the physical
address of any virtual addresses stored in registers. Therefore, pass
all register values through AT S1E1R and print the resulting PAR_EL1
value next to the register.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I7c6be65f27052da57088ff58b463fdbe2394f43c
---
Not sure if this should land in this form (I imagine there could be
all kinds of parsers that are expecting the existing format) but
maybe behind an option. Let me know what you think.

 arch/arm64/kernel/process.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 92bcc1768f0b..8b5f8c2c8abf 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -197,6 +197,18 @@ static void print_pstate(struct pt_regs *regs)
 	}
 }
 
+static unsigned long at(unsigned long addr)
+{
+	unsigned long pa;
+
+	__asm__ __volatile__("at s1e1r, %1\n"
+			     "mrs %0, par_el1\n"
+			     : "=r"(pa)
+			     : "r"(addr)
+			     : "memory");
+	return pa;
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	int i, top_reg;
@@ -231,10 +243,10 @@ void __show_regs(struct pt_regs *regs)
 	i = top_reg;
 
 	while (i >= 0) {
-		printk("x%-2d: %016llx", i, regs->regs[i]);
+		printk("x%-2d: %016llx (%016llx)", i, regs->regs[i], at(regs->regs[i]));
 
 		while (i-- % 3)
-			pr_cont(" x%-2d: %016llx", i, regs->regs[i]);
+			pr_cont(" x%-2d: %016llx (%016llx)", i, regs->regs[i], at(regs->regs[i]));
 
 		pr_cont("\n");
 	}
-- 
2.37.1.595.g718a3a8f04-goog

