Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4714E2D90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351001AbiCUQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350882AbiCUQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:05 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65076A005
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=5MrQJ81W3H7h1h
        lBoztx6HsQhX66IRi+nKSmYm1dJzo=; b=bvXH7IDmr9RE9lEbI2qCsyOOKylIuJ
        85wLll12YLhvc4hJNmBYuHrqHgTsEpkDm1DJegePsaz4/AtOeXLqg5U+gqy6Jb1f
        cE6ZSG6zELtD9Rw4CvUBz4mfCijhmzijqPhpFiyI76h8UyrMG+kQPO87wsj/hEKE
        e3bBEdkk9Bhpw=
Received: (qmail 958041 invoked from network); 21 Mar 2022 17:12:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:35 +0100
X-UD-Smtp-Session: l3s3148p1@tO6ww7zaNtkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 14/15] usb: chipidea: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:22 +0100
Message-Id: <20220321161223.2837-15-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/usb/chipidea/ci_hdrc_tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index a72a9474afea..767f13abfe91 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -189,13 +189,13 @@ static int tegra_usb_internal_port_reset(struct ehci_hcd *ehci,
 		temp = ehci_readl(ehci, portsc_reg);
 		temp |= PORT_RESET;
 		ehci_writel(ehci, temp, portsc_reg);
-		fsleep(10000);
+		usleep_autoyield(10000);
 		temp &= ~PORT_RESET;
 		ehci_writel(ehci, temp, portsc_reg);
-		fsleep(1000);
+		usleep_autoyield(1000);
 		tries = 100;
 		do {
-			fsleep(1000);
+			usleep_autoyield(1000);
 			/*
 			 * Up to this point, Port Enable bit is
 			 * expected to be set after 2 ms waiting.
-- 
2.34.1

