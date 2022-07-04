Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8899565D78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiGDSVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiGDSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:20:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E71116B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:20:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ay16so17991688ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5OTZ4uw8lP1p7LG9iv9MKnQLM3+c/cw5QVC+6xGSWr4=;
        b=EIwG31iT5+PmN9mt3edUWdfHdIL8NOAEM9Jo8GBzW5+Qv1+JKSdy/RVkI8thiRKHiJ
         YaXj/xCRlKnuov+wII/GE8lqaDm9iG7cKVYwQ0dDtHyPcWq5zmP4H5IgmHAZZXomtKkx
         whHobIw+uw2NzS8Wo94LklNq+PbYwkg9Domn8Y8hgdhYrCX1VMna7SMhoEMqth0YnxgY
         OD6m7Y5rreO3jc4F21SfiaW9aHdjeJFDYojEfGsMqswEGUh9YvC+ocpu4nLqBVJQN2FG
         aW2Jv15+LBe4RvBjNcDVFYBkI9rSRAhnY4y8klCK8ek0KNjtv5FypKo3A5sKapGT4Xsg
         B/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5OTZ4uw8lP1p7LG9iv9MKnQLM3+c/cw5QVC+6xGSWr4=;
        b=AOUylwsdwrH8PrQJ1Ltb1+uXWrOUkhgbDbvf3IVsoQbIJpFiUw55cdpQq+0XR2vTr3
         WF179y4btXQNgUSd77m56Rm68GhzIk9pFiiqgY//gFA56WkBHsKLbuvaB6w7MSQIijPt
         7eMw6wo5CuVLgXo9+y8KeIBW5aiGkAs8bvZ3nF1XKulWFX4aKFOuKtOt2rup9mKGG3IA
         VDjl4rezFMwfOhc2XdWUJgU2indyhsa5yTTKqWXEN/IyKTW4de4X7/NfmLOxOlJExhJt
         6qACXf3xTYpr4DJ/Q//w7CZVktW0+OhxIXASUgyrfjUOl0mnboxyeebfbdfr4NisgL2n
         WKIA==
X-Gm-Message-State: AJIora9zad1qLB6jzBKb1B90IsPNlZYdQTDh5URM4HzORPNv5BRMuomT
        hUx5KhuQgyIdohxM5P9cu1k=
X-Google-Smtp-Source: AGRyM1vSz8ftxEJHINMk3Wvu4/jLLDTv0l1zjbed1KO0VeWSNlIshc/w0z7KavBSQBTnugLblvj5jg==
X-Received: by 2002:a17:906:7790:b0:722:e6cf:126 with SMTP id s16-20020a170906779000b00722e6cf0126mr29245525ejm.244.1656958854768;
        Mon, 04 Jul 2022 11:20:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id zj4-20020a170907338400b00726ef422b80sm8428296ejb.177.2022.07.04.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:20:54 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: vt6655: Move two macros to file where those are
 used
Message-ID: <b4a04608b3900186d4941b3bfe9463bb79e261e8.1656835310.git.philipp.g.hortmann@gmail.com>
References: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move two multiline macros to file of only useage to
convert them later to static functions.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 24 ++++++++++++++++++++++++
 drivers/staging/vt6655/mac.h         | 24 ------------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index b9c57c661729..fdb653071918 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -186,6 +186,30 @@ device_set_options(struct vnt_private *priv)
 	pr_debug(" byBBType= %d\n", (int)priv->byBBType);
 }
 
+#define vt6655_mac_write_bssid_addr(iobase, mac_addr)		\
+do {								\
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
+	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);		\
+	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);	\
+	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);	\
+	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);	\
+	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);	\
+	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);	\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
+} while (0)
+
+#define vt6655_mac_read_ether_addr(iobase, mac_addr)		\
+do {								\
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
+	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);		\
+	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
+	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
+	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
+	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
+	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
+} while (0)
+
 /*
  * Initialisation of MAC & BBP registers
  */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index ba5575d63db0..5c14a76ed799 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -565,30 +565,6 @@ do {									\
 	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
 } while (0)
 
-#define vt6655_mac_write_bssid_addr(iobase, mac_addr)		\
-do {								\
-	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);		\
-	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);	\
-	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);	\
-	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);	\
-	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);	\
-	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);	\
-	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
-} while (0)
-
-#define vt6655_mac_read_ether_addr(iobase, mac_addr)		\
-do {								\
-	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);		\
-	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
-	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
-	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
-	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
-	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
-	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
-} while (0)
-
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-- 
2.36.1

