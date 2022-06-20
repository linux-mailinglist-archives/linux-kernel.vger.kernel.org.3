Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8255161F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiFTKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:43:10 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232411479;
        Mon, 20 Jun 2022 03:43:08 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DE50D1C000B;
        Mon, 20 Jun 2022 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655721787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXHVUeNmneDajw+ibD51KpGlnvzBH9kCBPP2HDS3q8I=;
        b=kypU7yXQ/FHnAbnNy+uO0irNGl56e/VaBhr5vCfPYqeQgWB87sR9f4AzcGFNYJzwdeqKDj
        ni1+AxV6u6bhZpMqIvrlCITEXOircgyRFMQfEH/n8z5batTGeXPKfctmkyTSuxVd8JdOUU
        XvgF3MCbeEmvfcKO8vlUiEipFZxN6NOIX70T6w2Jh+nTE5FGLdMs/BqmtvAC9Pt5RAH871
        /IDH2CJbe65iniX9xUscqS5fSk8ZGxhpEWflf0hKierDj5fUYL2aMdyY4SvEg+yzrstnA9
        hxglqyxDbLdn9xgbGks+B629Z9y05eQEujsByK6V89/b3fjYcpOE5lsXaCu+8Q==
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
Subject: [PATCH v3 1/5] of: constify of_property_check_flags() prop argument
Date:   Mon, 20 Jun 2022 12:41:19 +0200
Message-Id: <20220620104123.341054-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620104123.341054-1-clement.leger@bootlin.com>
References: <20220620104123.341054-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
2.36.1

