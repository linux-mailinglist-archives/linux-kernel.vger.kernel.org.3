Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C857B89D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiGTO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiGTO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01018B16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:29:17 -0700 (PDT)
Date:   Wed, 20 Jul 2022 14:29:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658327355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8jls1N+igWJfRYQwQXaFcDfQ2vZJjHco4lHw1U8CQk=;
        b=nsoxc9JUEfPXSheA6vJAH5M0pZcvzSV6zBFGnTbuq44TOqeqvJM69ZmNywuy59kBzFtyjO
        b3HValtwJmxLgHvXO+W+gcjoFyRNU62mOaWWsbWw9cfFDk8zKEbn7/Vs01xwcXhInMZ66T
        40i58+oFe9bKD8qrlta+zhkeKPCPX0smcpvMHnbjBbF/zLLpVs9CF1LltC727JaAShOird
        mQlyyW5nL4sg9kgyhnL2G4o6D2xqPsghHElt6E8UzBZq4Z6xiYGAn+HkcHlu2O0jA+8uXV
        0YPu7pnq5hitfNk2d5vJhvt08K3FNKg+wHvFFWcbJb3BJichxgEcoPFnX/VhlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658327355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8jls1N+igWJfRYQwQXaFcDfQ2vZJjHco4lHw1U8CQk=;
        b=RbSY242HA5VDjLgcy5UwmHVdgxvYgCXUdIPNZvDiyNOaSPeljtnQ1JYfIP9PeAEg8RwF6X
        VThvPNIAVDIcYfDw==
From:   "irqchip-bot for Paran Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Use for_each_action_of_desc in
 actions_show()
Cc:     Paran Lee <p4ranlee@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220710112614.19410-1-p4ranlee@gmail.com>
References: <20220710112614.19410-1-p4ranlee@gmail.com>
MIME-Version: 1.0
Message-ID: <165832735386.15455.15368506218361253920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c904cda04482d5ab545e5a82cee6084078ef9543
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c904cda04482d5ab545e5a82cee6084078ef9543
Author:        Paran Lee <p4ranlee@gmail.com>
AuthorDate:    Sun, 10 Jul 2022 20:26:14 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 15:21:32 +01:00

genirq: Use for_each_action_of_desc in actions_show()

Refactor action_show() to use for_each_action_of_desc instead
of a similar open-coded loop.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
[maz: reword commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220710112614.19410-1-p4ranlee@gmail.com
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d323b18..5db0230 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -251,7 +251,7 @@ static ssize_t actions_show(struct kobject *kobj,
 	char *p = "";
 
 	raw_spin_lock_irq(&desc->lock);
-	for (action = desc->action; action != NULL; action = action->next) {
+	for_each_action_of_desc(desc, action) {
 		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
 				 p, action->name);
 		p = ",";
