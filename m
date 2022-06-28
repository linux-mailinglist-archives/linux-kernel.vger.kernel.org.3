Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1655DDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiF1B3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiF1B3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:29:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDACB851
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:29:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so10704713pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8E+gxTAN8rG2WVxuHrJcDTa+6kpi17eTJQwDbUSCKcU=;
        b=R9593Yh/ziRj+PhSTZGNljtUYtRZ7KBVQKtqvdeZLDtVXwQxmJezp36t50uMBy2Fue
         OAZ8d7yx/Q0WiuCTlblLoLk3ecQIFZRO8frKruDuNlKPHQuYNSWp2xyWEObU8I7+JFgI
         9ercAgwDqi2xZKpblouEWR+LMA/5t/2vbM7AUEo8XmAj1FEb62Fa8pjg1mFFwprsqd/r
         oalvbNOgEQrg92Pyr/he4kQE7xVG6feGS8vqdTagaEmZlFnuDsEiKKjdPk6CFxaLP9aR
         z3FuUjTiB2GJWQ/oj+QkEXWwP8WxPGVo+6XejS4SWK861G0vwzysi2pIUkw7Hb1z8qB3
         v3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8E+gxTAN8rG2WVxuHrJcDTa+6kpi17eTJQwDbUSCKcU=;
        b=iWN5ZenK7Yi//uSnT+mQ0VH9NPFaIX3RLsroZh3RjSkRowmIGpWOGqcVqfbtIPFNqq
         Hb6b3YrzKWBZf+6Uqo0GmLGlURq7xk1GB3kUSpE0LMPB/YE0+j4sN6VgGddVVWFw4Qi4
         19iA96wmAhjDVrDkQ4UDwfbAJ78oyzwK4ckEhV94kJQCu69CXxgDqQC7DR6pPPcM+1K2
         wr1uDIyxuoZRuvlc1uH1Ef+f+jk2ioAWjSRqTbKKz9KBR9VpyhVJndtpWlzOb/xqFdMT
         Pf6wfFVTldCsx3szIGndkKrVD6Q8033fqqgtUNZvsf0oTixH3L+V6iUlmHlxtoIRTyK5
         0edA==
X-Gm-Message-State: AJIora+w4IlwDQaCYT3nY8NLTTpbrzoTsPYus/P1C4TULiG+2ArBGE8+
        1S01O/Tx6wDT8Q5rdYcGf1FsJblvGHc=
X-Google-Smtp-Source: AGRyM1ua6NTQPrcwr20mLPjho7uV/TLlVfmN+1LnA/K+O1jHWhkJ5PMJPqzE6EuzG0El+n8W3Ez4wQ==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr15473379pgq.231.1656379741940;
        Mon, 27 Jun 2022 18:29:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b0052517150777sm7960560pfi.41.2022.06.27.18.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 18:29:01 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip: or1k-pic: Undefine mask_ack for level triggered hardware
Date:   Tue, 28 Jun 2022 10:28:54 +0900
Message-Id: <20220628012854.681220-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The mask_ack operation clears the interrupt by writing to the PICSR
register.  This we don't want for level triggered interrupt because
it does not actually clear the interrupt on the source hardware.

This was causing issues in qemu with multi core setups where
interrupts would continue to fire even though they had been cleared in
PICSR.

Just remove the mask_ack operation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Note,

I currently have this queued with openrisc fixes for 5.19-rcX.  If this is ok
with the IRQ maintainers I would like to have this merged via the OpenRISC
queue.

 drivers/irqchip/irq-or1k-pic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index 49b47e787644..f289ccd95291 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -66,7 +66,6 @@ static struct or1k_pic_dev or1k_pic_level = {
 		.name = "or1k-PIC-level",
 		.irq_unmask = or1k_pic_unmask,
 		.irq_mask = or1k_pic_mask,
-		.irq_mask_ack = or1k_pic_mask_ack,
 	},
 	.handle = handle_level_irq,
 	.flags = IRQ_LEVEL | IRQ_NOPROBE,
-- 
2.36.1

