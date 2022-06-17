Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F754F86E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381935AbiFQNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiFQNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:42:55 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BD32BE8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZzvMF
        tp7Vaaiq+z/HKPs92ctVLKtidQXsg1toqz/UCE=; b=NGOgFWZYYDnivmk4r+DRX
        W2KXkwsyT50KBd6Z0ygOTMj/UZ9BbQJ7SMlQ7BfauPNDTvwjtuAflyWtMCYB406b
        hBpn4k+ijupHBnVwFiGE4Hv+14MKdmk3oyom3hJ6EauoxAC+aXRmsXIPkm7hikdW
        nGImGa11Q2Ow/pOHTg3UK0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBn9oK2hKxio+VyFw--.39743S2;
        Fri, 17 Jun 2022 21:42:16 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-versatile: Fix refcount leak in v2m
Date:   Fri, 17 Jun 2022 21:42:13 +0800
Message-Id: <20220617134213.4049822-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBn9oK2hKxio+VyFw--.39743S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKryfWry3urg_yoWxCrc_K3
        Zaq3yxCr1rJF1FqrWDCw4rKrW2vw42grn5GFyfAr17ArWavr98Crs2q3s2y34UZr43KrW7
        WrZ7Ar1Yyw17AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUULZ2DUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RgjF1pEAOBOuQAAsI
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vexpress_flags_set(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-versatile/v2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/v2m.c b/arch/arm/mach-versatile/v2m.c
index 79afdf2a90b6..275f0628aa7e 100644
--- a/arch/arm/mach-versatile/v2m.c
+++ b/arch/arm/mach-versatile/v2m.c
@@ -17,6 +17,7 @@ void vexpress_flags_set(u32 data)
 				"arm,vexpress-sysreg");
 
 		base = of_iomap(node, 0);
+		of_node_put(node);
 	}
 
 	if (WARN_ON(!base))
-- 
2.25.1

