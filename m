Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1354B44B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiFNPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiFNPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:14:40 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4739167
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:14:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 6E9F524BD1DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1655219676;
        bh=XWOIRVk3z5AQ6ureUe+X7StGewlRNrG5efWvD2TbZNo=;
        h=From:To:Cc:Subject:Date;
        b=lSB2BH/jCkrOVPI8XwMxvHunktsxwziYoRn3c6yzzl1iwB/8pVL60k8Yo7Ioe0SBz
         IxsDG4Me+ZSCTihRDAWzmr6H+WDQ/Dfb6LvpLgFpayfGWy24KrmQP2zR0hFbzZhYp3
         q6gfod2erzIix6KUWxS/Gwdue493DlfqRSA/YV2E=
Received: from fx301 (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 1BC2424BD18D;
        Tue, 14 Jun 2022 17:14:36 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <e731.62a8a5db.87171.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx301.security-mail.net (Postfix) with ESMTPS id 879DF24BD127;
        Tue, 14 Jun 2022 17:14:35 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 6177E27E04E1;
        Tue, 14 Jun 2022 17:14:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4999E27E04E4;
        Tue, 14 Jun 2022 17:14:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 4999E27E04E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
        s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1655219675;
        bh=4RXBUPP9gE2oA17EFCo678ZU9BVLqoUuf2Yuh0dqC/s=;
        h=From:To:Date:Message-Id;
        b=mZL3TSpDmFyiLAioDimuSKRQ5npMte34kbYHay66/J1jfYiPqO2nGHe7etLGIZ83G
         DPfdpj+PNUI5wP+1h06ovgRXInt5LTZHodH0x0xlKInyE8l7ouLx+w+YCEjvEn1ogX
         WE9eqZpqb30gYaieLcJlnYRHjVXO/Wc6gVf9X8a9CbYV2u7DcuKHm6zs7qnUQRUDsq
         aH9YMpXoSmMpn2AO7qhxCAB7GaIlqJYriWqj9Flcn340wpMKRZza21TwFHbuv2UQPF
         qt/maByimmFEserUx88xyNtvnIFW3QJqLCN30ce2TYdhQCK5PzWhv3p7kXfkGII/He
         N1lDaeE7hSVTA==
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hcR2nCMFJ4SD; Tue, 14 Jun 2022 17:14:35 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 2DE1C27E04E1;
        Tue, 14 Jun 2022 17:14:35 +0200 (CEST)
From:   Julian Vetter <jvetter@kalrayinc.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, ysionneau@kalrayinc.com,
        jmaselbas@kalrayinc.com
Cc:     Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v2 1/2] msi: The MSI framework only supports 2048 platform MSIs
Date:   Tue, 14 Jun 2022 17:14:10 +0200
Message-Id: <20220614151411.32674-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
(no changes since v1)

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

