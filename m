Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4752963F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiEQAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbiEQAzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497F369D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso958517pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oLADI5NiHsnQbc73WheH/PuvP/+QEln3IGTPYBBAzo=;
        b=V/+CTtdeJnUKuXDCGH6M/X0W1zvVeJof1JXCsrKIids9z9JZ0SgI935DIS00Y83oA+
         R3yny+ba7IvenXfqyNazXP5CC4Jd8WKgUa8iZmwPzNRN+I7bhT1OiMtWPRzaTgrogyrW
         LZvO688C9uYRdqu63tP1pscsxGUShlhNU3C811xEUwV44ydjjkkMRCkvxiytyIW2+hfP
         FRRj4HDrp0m2dS5skBKX+IeF9lcN/BYkhAmj5btvClQbZggmvmGlMLk3MDgO8ZBkNTvw
         2zGQxX5kecmDtmagEN+oXedLmt6Tl44L4R3xjwtSo9Dx7P6JDQoR58jKmbRVncpXZJMK
         ojSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oLADI5NiHsnQbc73WheH/PuvP/+QEln3IGTPYBBAzo=;
        b=o2dL5Ii1FnoAjM5igiKaAeDYXItVD7TBCozlD2SCfMKgmIuefE4PXqS9SmSARhr1R0
         djbEPbaMHPOyw0iTNUcW/ik61uE8crIpgC+1XHTf+IqW72ryA7tID/aWzeWl4E15JKHy
         qn+YvYC+GROqZj+zlf3l/Rfl7tjEPxMBI2oBqkGCGWW1ENW/LoxDucboPk4dilev3pKm
         tS/zjFquVWE5hJwvRJ3cpmZ85l1Mxdn0N758lSEYJeitp4/Zs/Sb47km5k+Y1ve2MU7v
         SvoKRm1lTrknr0fIi+O50HniL1jDXDNpJEf80WzGEwaDnVBcv/YGjJT1hLAAnAQ8XxL+
         pqIg==
X-Gm-Message-State: AOAM533pkE7joiiaNY6X7wte5y2RMmTEmGDHwmRvgp1fq67M+IChkri8
        cz6WNo/sdA4UBz/LpsKkzoEhcJHoRp8=
X-Google-Smtp-Source: ABdhPJyJvaNZcoAIqSz7o+nJGt4QTm8WYq1w1faSsAKwdTtUDvyeYa69U7QGc3rKO0+DKrxPtmlDSQ==
X-Received: by 2002:a17:903:2481:b0:15f:249c:2006 with SMTP id p1-20020a170903248100b0015f249c2006mr20168453plw.31.1652748935585;
        Mon, 16 May 2022 17:55:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0015e8d4eb28fsm7633165plg.217.2022.05.16.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:34 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 03/13] openrisc: Add support for liteuart emergency printing
Date:   Tue, 17 May 2022 09:55:00 +0900
Message-Id: <20220517005510.3500105-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

This patch adds support for sending emergency print output, such as
unhandled exception details, to a liteuart serial device.  This is the
default device available on litex platforms.

If a developer want to use this they should update UART_BASE_ADD
to the address of liteuart.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Update for patch 2/12 ifdef changes

 arch/openrisc/kernel/head.S | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 7bfa6e4b60c5..21db50563f97 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1555,7 +1555,18 @@ ENTRY(_emergency_putc)
 	l.movhi r4,hi(UART_BASE_ADD)
 	l.ori	r4,r4,lo(UART_BASE_ADD)
 
-#if defined(CONFIG_SERIAL_8250)
+#if defined(CONFIG_SERIAL_LITEUART)
+	/* Check OFF_TXFULL status */
+1:      l.lwz	r5,4(r4)
+	l.andi	r5,r5,0xff
+	l.sfnei	r5,0
+	l.bf	1b
+	 l.nop
+
+	/* Write character */
+	l.andi	r7,r7,0xff
+	l.sw	0(r4),r7
+#elif defined(CONFIG_SERIAL_8250)
 	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
 1:      l.lbz   r5,5(r4)
-- 
2.31.1

