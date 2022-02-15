Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD64B6A97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiBOLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiBOLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:22:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8CAB443
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:22:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714D3B8189E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE8C340EB;
        Tue, 15 Feb 2022 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644924125;
        bh=YM659guN7Ehu66dhhti1I+YQb0J114KDfyZoR/1vhJY=;
        h=From:To:Cc:Subject:Date:From;
        b=RNst1mMVJxEauL7rSHN+Tn1AlEK155HwfbJFADHoa6bOcMcTBqhFYgEC3nqOXPTlH
         /GZlRawuI4ZpbnKYKPVN9wVg+PbrK7n6VXMOtWrOsCU2J5196pWUTZw7CRvWaCzE3s
         CKKdZQcF+vsxwK6ieBX+c+eAJolWSO5bFTFmP2yNr4rTi9gAXKdxafvVUBI0mve3pI
         62wFfQuIgvn+/SrLkZA2NDNxDUErX6/aeNsZua6vvFp0Sg/2x48THg2H3YFBfCOCmV
         SdKRtqRdJl16UhVjb/K/T6E9W/8CoG9c88iGgGPbVgdMLJ8cdkx/1OkTaqh65V4Z1D
         1zqC4QrCilv9A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nJvuF-0081yk-2S; Tue, 15 Feb 2022 11:22:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq/debugfs: Use irq_print_chip() when provided by irqchip
Date:   Tue, 15 Feb 2022 11:21:54 +0000
Message-Id: <20220215112154.1360040-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since irqchips have the option to implement irq_print_chip, use this
when available to output the irqchip name in debugfs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---

Notes:
    I plan to take this into 5.18 as part of this[1] series.
    
    [1] https://lore.kernel.org/all/20220209162607.1118325-1-maz@kernel.org

 kernel/irq/debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437..2b43f5f5033d 100644
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
-- 
2.34.1

