Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32C539F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbiFAITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350704AbiFAITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:19:37 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E38FFBE;
        Wed,  1 Jun 2022 01:19:34 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 97F79240009;
        Wed,  1 Jun 2022 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654071573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPI47XC9OtqT4bQ9DbJLoCocyaCj0Ouilt5roec+84k=;
        b=o6iTqo28Xqs6KtnHgCDjk5nBtVxArCq9giMQSB+f+HdYoa9gm/3y5cd6Kd4j0YAYwJs9KE
        jOK8bn07Z2l4TLjAvJdwbkf9RtN8ETVakOQm6rqBsC6RiFlT1cacBoOfrg1KzOWGB2m8z9
        UqvRV7Ewn6ffhzoAjEKlKbjZ/WTKZypZZldTIbTzTrgEF1Hdvnd+2OHEhuoGXycDR1YRJ0
        6yFGcd80dFg+guNHLh1+8fqowPuuzX2G5N9rnDHmA+QhxnjpqYTtY/2TP2W1g5Pz1md677
        4oe/4/Zg+QPXSHnKJbxfQG6XZN7FogKxvbUyxT9iV4OrQaCIYmnVg+7sjlwQSw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
Subject: [PATCH v2 1/4] of: constify of_property_check_flags() prop argument
Date:   Wed,  1 Jun 2022 10:17:58 +0200
Message-Id: <20220601081801.348571-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220601081801.348571-1-clement.leger@bootlin.com>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument is not modified and thus can be set as const.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 include/linux/of.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index f0a5d6b10c5a..d74fd82a6963 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -207,7 +207,7 @@ static inline void of_node_clear_flag(struct device_node *n, unsigned long flag)
 }
 
 #if defined(CONFIG_OF_DYNAMIC) || defined(CONFIG_SPARC)
-static inline int of_property_check_flag(struct property *p, unsigned long flag)
+static inline int of_property_check_flag(const struct property *p, unsigned long flag)
 {
 	return test_bit(flag, &p->_flags);
 }
@@ -814,7 +814,8 @@ static inline void of_node_clear_flag(struct device_node *n, unsigned long flag)
 {
 }
 
-static inline int of_property_check_flag(struct property *p, unsigned long flag)
+static inline int of_property_check_flag(const struct property *p,
+					 unsigned long flag)
 {
 	return 0;
 }
-- 
2.36.0

