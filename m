Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89703545129
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbiFIPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbiFIPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:45:13 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B8DF4A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:45:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 6FCC01B7B1F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1654789161;
        bh=XVqdm7ghdAJoVW1oi7tuwg+70g8MZxvp39ZrCu0DV08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eMjZNVGIDlpoBAMweb5b9W3ThN6mGE6ueCzb0FyPyW0wWgf6jBJ9qmF7z6jNQikIg
         UPsLdwt8DyBGn6fxSU8XuoY44abCx0DPy4trBqNGawQAFeWZbVjxdIuWooDZFqmSgi
         OowdkCJiFG8jMZ0w8uB5BLGNr280Ur7kA1GDB0es=
Received: from fx408 (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 1C01D1B7B18E;
        Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <68c1.62a21428.9babd.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx408.security-mail.net (Postfix) with ESMTPS id 9C37D1B7B036;
        Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 835F927E04D2;
        Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6CE2E27E04B9;
        Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6CE2E27E04B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
        s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1654789160;
        bh=MKkMqbjShdmm9HekBRcDVgxUsQDdACqImBXsrKT6uyc=;
        h=From:To:Date:Message-Id;
        b=vQp2SwSgRcUVWu3Bitf470C51tUcB1w30Ll27tSc3SHbplCxWIyOZQ7ZXWJlVR/kn
         GLsG/w0u5bpB2oK4A56RzlNyrk+CFudhQI6ZmV37SDaraw+5YEjJF5+hq6qeYrEMGF
         xlUNto59r2Fu/zWIVdHCF9nps2Zjt/Qci8LdHIIRw53u+BGj4cpPumkcebFhsJUKon
         dPEww/GFdr5IMGmYQhfzl3Qip0QAlCLJAV4MYa1ulGXl6a41+DYA9qvXfxdq+k/Ip0
         d72qOWodJqTWLevCsduizdyT7k1gpNeN4NLGhoHOWl09IHqUl36FXYk9ZfTSKTBnfZ
         RgxyDjdQ5IsWA==
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cZjLf0N_Sq3a; Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 54C0E27E04B4;
        Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
From:   Julian Vetter <jvetter@kalrayinc.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com
Cc:     Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH 1/2] msi: The MSI framework only supports 2048 platform MSIs
Date:   Thu,  9 Jun 2022 17:38:42 +0200
Message-Id: <20220609153843.1991-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220609153843.1991-1-jvetter@kalrayinc.com>
References: <20220609153843.1991-1-jvetter@kalrayinc.com>
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices need more MSIs. To support this the number must be
increased.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
---
 drivers/base/platform-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 296ea673d661..4b0b2fe3a7ff 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -13,7 +13,7 @@
 #include <linux/msi.h>
 #include <linux/slab.h>
 
-#define DEV_ID_SHIFT	21
+#define DEV_ID_SHIFT	19
 #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
 
 /*
-- 
2.17.1

