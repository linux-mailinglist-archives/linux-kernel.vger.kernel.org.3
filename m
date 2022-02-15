Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1244B6BED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiBOMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiBOMUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADEC1074EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:20:02 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:20:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqsbS+6qFRgm67yHvTx/LxjGGguwMfqr1JV+PHUZMDc=;
        b=hgKvmk91qpVZj+vsqKVu+3dv230roo3Ew5wXMhxnvk9x7Ub97+YyvXQG+Kw21i354qRUMW
        RoQd05Dxmu2oGN4HOg7FQqf0AOm5b6CHLdqfMyRgWCnDnsmf5Z9woEz9m7CEFE6v6C7ikr
        EEF/LqvRAbSnNVdz1lEGLTsBWy1rRXOP/+iDBMDPkPUbf995e6nZVL9ON0OL9M8QhIAHfG
        tYSxJlL2HKIBI7cXVTr+RCyN9n3K9728ja7mR2F5/QAd5lV0BWuB0q552YpYEjxlOMC2uk
        M30mm6h4oV4fdE2VH9to6GhqA0vLNeaxoeqd8Ga+sstLxtZ8RRTVOC0gOfld0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqsbS+6qFRgm67yHvTx/LxjGGguwMfqr1JV+PHUZMDc=;
        b=kvAbFLb4jf3uWgrHiUJ9jKZZFdJZPWuOOMmKnrXszTJv95LFLyl6/C5mfURA5THMRyyAQQ
        vS1UNoZNjyY7IdAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/debugfs: Use irq_print_chip() when
 provided by irqchip
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220215112154.1360040-1-maz@kernel.org>
References: <20220215112154.1360040-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492760035.16921.16579224915079483418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0a25cb5544f4f01d2e7c06164555fd9cd6eb64fd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0a25cb5544f4f01d2e7c06164555fd9cd6eb64fd
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 10 Feb 2022 09:27:21 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:22:34 

genirq/debugfs: Use irq_print_chip() when provided by irqchip

Since irqchips have the option to implement irq_print_chip, use this
when available to output the irqchip name in debugfs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220215112154.1360040-1-maz@kernel.org
---
 kernel/irq/debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff35..2b43f5f 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -69,8 +69,12 @@ irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
 		seq_printf(m, "chip: None\n");
 		return;
 	}
-	seq_printf(m, "%*schip:    %s\n", ind, "", chip->name);
-	seq_printf(m, "%*sflags:   0x%lx\n", ind + 1, "", chip->flags);
+	seq_printf(m, "%*schip:    ", ind, "");
+	if (chip->irq_print_chip)
+		chip->irq_print_chip(data, m);
+	else
+		seq_printf(m, "%s", chip->name);
+	seq_printf(m, "\n%*sflags:   0x%lx\n", ind + 1, "", chip->flags);
 	irq_debug_show_bits(m, ind, chip->flags, irqchip_flags,
 			    ARRAY_SIZE(irqchip_flags));
 }
