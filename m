Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179C659740A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiHQQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiHQQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:20:08 -0400
X-Greylist: delayed 289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 09:20:05 PDT
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9009082A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:20:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id 137AC62774
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1660752938;
        bh=Nfz4O3rZnPPKm2vnC4D3Dpmn39qjKsEl/HuN840SU5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bHcJYCPkL6WJVaglHtVXaQi1FjqBV0c8ZMEpY/aXpcoimuHxh2soutatqce2jK2iv
         hnlnPs+ibsST7cBLjiut43v0uX7WNUcPl0ANFy3gGj7nGXUMrRIqM3QleDAZ6KIGkS
         fhMU67qIS33hKV4GETlZLvncBMqFoHa02W1WYVBo=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id BC60162781; Wed, 17 Aug 2022 18:15:24 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 37FC362788; Wed, 17 Aug
 2022 18:15:20 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D7E1327E034A; Wed, 17 Aug 2022
 18:15:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id C220927E0341; Wed, 17 Aug 2022 18:15:20 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 Dlfnv41dZpe2; Wed, 17 Aug 2022 18:15:20 +0200 (CEST)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id A959027E031E; Wed, 17 Aug 2022
 18:15:20 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <968a.62fd1418.f0f4c.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C220927E0341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1660752920;
 bh=r1bxgf6HQfZD7K8zieEJMWSU6cq5Zmj9C9KBCyLxkIY=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=CLubaUgqjR7PcuGBVG8WxilsmI9yIZ3GY+5VriZQDLeUKiWKUlJgI8aTFTJszjP0Y
 iAvSDkccqNCCgsYJWfUBnyLooKZ645aiyB55/M5f83rEq3mzwITF2ddC8N+pFGbqeP
 j15B91VMdEU4iXKhQ2rkWg4Ra/8+8inTpHSNKR+g=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>
Subject: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
Date:   Wed, 17 Aug 2022 18:14:38 +0200
Message-ID: <20220817161438.32039-2-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817161438.32039-1-ysionneau@kalray.eu>
References: <20220817161438.32039-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 include/linux/export-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index c2b1d4fd5987..d86bfbd7fa6d 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -12,6 +12,6 @@
 
 /* __used is needed to keep __crc_* for LTO */
 #define SYMBOL_CRC(sym, crc, sec)   \
-	u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
+	u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4) __crc_##sym = crc
 
 #endif /* __LINUX_EXPORT_INTERNAL_H__ */
-- 
2.37.2





