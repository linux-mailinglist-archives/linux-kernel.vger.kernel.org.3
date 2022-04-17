Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF35E504776
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiDQKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiDQKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:01:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB46C03
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 02:59:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650189552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YkYt3Tcru6U/tvL6nk1qOZUP7dY9n3fkRkbnXJoebFE=;
        b=ZGQAGQCbew+ivI4I5SYfRkpWeFkhEUlCf9kvQd5nL1AOXkX1zMxoC0F0BdCaScB+IlNq3C
        RalHuiW2TmNwzM1RhxMtjed2WovGu7cFExCARcm4XoVCnUFwxUnjdEToDUza19JMFraV/n
        lXwXEJpAvrxxJFcmeKlBUuGd2bY7eh0bMlVtM7b0SyfL+Ktm8njy/YSmGJIMOjum1Rw6in
        px8YQLBV8vPynPl3ZYZibZQiKP/t2DCaXIzAfCQnh/dSTZXp7MJHGaXDkj1meGAO0Mg6Vx
        RW/Z6CcvmN/A0M974z2CxKRblKMRFv+4RjcXO3yXPYxSJ03wKp6vNHPDCzb8gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650189552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YkYt3Tcru6U/tvL6nk1qOZUP7dY9n3fkRkbnXJoebFE=;
        b=09CE+gZ5bDYCvErZDYgrjLS6AJjOhaS7KDz5xFPnYlfVlRcXHIjzP0mw/0LvDBvAc+GSwV
        liLsPXNyG7uDSjDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.18-rc3
Message-ID: <165018953450.44773.6382828227632028472.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 17 Apr 2022 11:59:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
04-17

up to:  08d835dff916: genirq/affinity: Consider that CPUs on nodes can be unb=
alanced


A single fix for the interrupt affinity spreading logic to take into
account that there can be an imbalance between present and possible CPUs,
which causes already assigned bits to be overwritten.

Thanks,

	tglx

------------------>
Rei Yamamoto (1):
      genirq/affinity: Consider that CPUs on nodes can be unbalanced


 kernel/irq/affinity.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..fdf170404650 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startv=
ec,
 	 */
 	if (numvecs <=3D nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
-				   node_to_cpumask[n]);
+			/* Ensure that only CPUs which are in both masks are set */
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+			cpumask_or(&masks[curvec].mask, &masks[curvec].mask, nmsk);
 			if (++curvec =3D=3D last_affv)
 				curvec =3D firstvec;
 		}

