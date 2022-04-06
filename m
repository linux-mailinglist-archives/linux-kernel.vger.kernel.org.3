Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC24F5EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiDFM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiDFM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:56:44 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DE28A00C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ELstpb9CahSQ9h
        tMRBNgYlMBQaWFg7ebfWxfcaQnqjA=; b=3rhKnA424MyzX076mKTW3BMl5iJWuQ
        UcmQ1hXG6H1PbybF++LCGjk+vmKSJ/4RbKBQAVzsXUtHzaNgw143J5Vpn/WRxHPW
        TcaB/pJc2/nLT2HT6Ps2VcbxbXcbsEnjloW7g62Oh5k2DVRoe8hS0ZoguMMyd6k/
        PMrvz8RHDjKXs=
Received: (qmail 2651250 invoked from network); 6 Apr 2022 10:56:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Apr 2022 10:56:48 +0200
X-UD-Smtp-Session: l3s3148p1@E16iivjbjpQgAQnoAH8rAO83AtqmbDBd
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] delay: rename fsleep to usleep_autoyield
Date:   Wed,  6 Apr 2022 10:56:43 +0200
Message-Id: <20220406085643.33100-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406085643.33100-1-wsa+renesas@sang-engineering.com>
References: <20220406085643.33100-1-wsa+renesas@sang-engineering.com>
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

Rename fsleep because the current name breaks the pattern of the first
letter being a unit (and it is not 'femto' here). Let's add the proper
unit again and add a suffix to the function which will hopefully be a
bit more explanatory. To give some time until all users are converted,
introduce a fallback define which will go away later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/timers/timers-howto.rst | 2 +-
 include/linux/delay.h                 | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
index 5c169e3d29a8..d0a57ca5e18e 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -112,4 +112,4 @@ NON-ATOMIC CONTEXT:
 			you know you have a need for the interruptible variant.
 
 	FLEXIBLE SLEEPING (any delay, uninterruptible)
-		* Use fsleep
+		* Use usleep_autoyield
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 039e7e0c7378..d0919f52fec8 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -78,7 +78,7 @@ static inline void ssleep(unsigned int seconds)
 }
 
 /* see Documentation/timers/timers-howto.rst for the thresholds */
-static inline void fsleep(unsigned long usecs)
+static inline void usleep_autoyield(unsigned long usecs)
 {
 	if (usecs <= 10)
 		udelay(usecs);
@@ -88,4 +88,6 @@ static inline void fsleep(unsigned long usecs)
 		msleep(DIV_ROUND_UP(usecs, 1000));
 }
 
+#define fsleep usleep_autoyield
+
 #endif /* defined(_LINUX_DELAY_H) */
-- 
2.30.2

