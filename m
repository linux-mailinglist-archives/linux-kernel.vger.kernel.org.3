Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA11529FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbiEQKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbiEQKpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:45:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258232ED9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m62so10181588wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM5RWvyh6QKuoU3X77fGhLivSZmPpUopnFBI2UaPSjs=;
        b=Pletk8uN1upMYIKNyvE8fT6x9oXX6zwAKVAbwgCAd3WGicm3ledePiiOA5CvpU7QP3
         kzOiILDY17dYgt32foZUYZglLwIp5TymoxwAMaVW1Q8C5LZthjlbC9ydChlk4lmWsRLC
         nC6/Zjx25bh74u+Ya2x0gMkH71ly9QM0RPbdVC0cuAJxpXto4nSz2f2BwXRy1edPOZqP
         UFZY6MFRCo/qis9bRsIZVP1ao2GP0d+Hj0K840hrjTUoEzbgMNjI1atJ/GFrmE0e1VbO
         2IrQZKqgX5EG6vyYUOfq+uR3J8bUkCdf1vtgU8EGoj8EJNuRLgRUe9ytqgwWEVSA+nPj
         tGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM5RWvyh6QKuoU3X77fGhLivSZmPpUopnFBI2UaPSjs=;
        b=t2Me96tSlqNaNALQ/w4Vt6oplJpAvQKrkn1UJEvkBKnq+yUv1Jnb5U2FCszNUfPkSH
         wS4ZWUWBQZ2Ids53+rCdvBA1lCjjEp/1SbJ29pB2h8QkdE4YXbJULQDN9ivBXUqBqkEB
         s/3WUmvnngj6FmWHrcaJI2DhnOm4nlFEFct4GpOv5rZlJjLKp9pWgTJ+ECbz8kbPXjkw
         ZeS8T+U1+6fNtBSZgw0YNNLC8t23CSCWRZFNabAdHT+QLjLck96C6TyYwpOuPielLhng
         NGevUEao1BHq3ExoHVgO2wPj+gbLQawdjnCB6WTvgcxj8nsNYC2vZ8XvhtbTRZfl8o8v
         5nGw==
X-Gm-Message-State: AOAM533j0/T4sRPwKPbuBZ+EkKMjuwgCZk7udR+rv/tvS9GXrfHtoMHy
        YDedTEqJClyZMBcEnLnNRdjcuWm5CJU=
X-Google-Smtp-Source: ABdhPJyPoVqDQCLjm+TQPlDUQ3JSV8zj9nsPJZXxCpUCCzirlk23hNsXz37C2odsxGqCrSeq7Fmvew==
X-Received: by 2002:a05:600c:3d89:b0:397:104:b1c9 with SMTP id bi9-20020a05600c3d8900b003970104b1c9mr10768763wmb.84.1652784310841;
        Tue, 17 May 2022 03:45:10 -0700 (PDT)
Received: from octofox.metropolis ([178.134.210.144])
        by smtp.gmail.com with ESMTPSA id r5-20020adfbb05000000b0020d00174eabsm8612218wrg.94.2022.05.17.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:45:10 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 2/3] xtensa: support artificial division by 0 exception
Date:   Tue, 17 May 2022 03:44:57 -0700
Message-Id: <20220517104458.257799-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517104458.257799-1-jcmvbkbc@gmail.com>
References: <20220517104458.257799-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On xtensa cores wihout hardware division option division support
functions from libgcc react to division by 0 attempt by executing
illegal instruction followed by the characters 'DIV0'. Recognize this
pattern in illegal instruction exception handler and convert it to
division by 0.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:

- simplify check_div0 by dropping check for the specific illegal
  instruction and only verifying the 'DIV0' signature

Changes v1->v2:

- split ABI probing improvement from the artificial division by 0
- don't limit artificial division by 0 pattern detection to
  configurations without HW division opcodes, do it always

 arch/xtensa/kernel/traps.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 24d11b44fa57..2b75b252b626 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -293,12 +293,35 @@ static void do_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static bool check_div0(struct pt_regs *regs)
+{
+	static const u8 pattern[] = {'D', 'I', 'V', '0'};
+	const u8 *p;
+	u8 buf[5];
+
+	if (user_mode(regs)) {
+		if (copy_from_user(buf, (void __user *)regs->pc + 2, 5))
+			return 0;
+		p = buf;
+	} else {
+		p = (const u8 *)regs->pc + 2;
+	}
+
+	return memcmp(p, pattern, sizeof(pattern)) == 0 ||
+		memcmp(p + 1, pattern, sizeof(pattern)) == 0;
+}
+
 /*
  * Illegal instruction. Fatal if in kernel space.
  */
 
 static void do_illegal_instruction(struct pt_regs *regs)
 {
+	if (check_div0(regs)) {
+		do_div0(regs);
+		return;
+	}
+
 	__die_if_kernel("Illegal instruction in kernel", regs, SIGKILL);
 
 	/* If in user mode, send SIGILL signal to current process. */
-- 
2.30.2

