Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9014E2D94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350936AbiCUQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350841AbiCUQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C476280
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=l2I0BePf9ZM5WC
        ohjOwT+ZnLo9RHE9f6dsUKU7/hA48=; b=cTDOrjf2MRXqyNrcZc5OpeKlDFBab2
        0bx472Rnpnc4m68sdECXS7DOWNbyoWWpilzmmb9fcZbVhs7kWzsQPPvYpsGn/9iQ
        ZfkY6gjddWusgf1AgLM5AHGeyByLm2Kjhf9jzS2tF/XRy3JtVZPY3KuYugKBIbzG
        SxfBCGPn+0u2w=
Received: (qmail 957829 invoked from network); 21 Mar 2022 17:12:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:31 +0100
X-UD-Smtp-Session: l3s3148p1@4dV3w7zaJtkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 07/15] mux: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:15 +0100
Message-Id: <20220321161223.2837-8-wsa+renesas@sang-engineering.com>
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

 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 22f4709768d1..4999f255b787 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -329,7 +329,7 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
 	delayend = ktime_add_us(mux->last_change, delay_us);
 	remaining = ktime_us_delta(delayend, ktime_get());
 	if (remaining > 0)
-		fsleep(remaining);
+		usleep_autoyield(remaining);
 }
 
 /**
-- 
2.34.1

