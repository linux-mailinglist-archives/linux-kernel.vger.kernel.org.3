Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F48539F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbiFAITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350640AbiFAITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:19:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE68BD15;
        Wed,  1 Jun 2022 01:19:32 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A0F424000B;
        Wed,  1 Jun 2022 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654071569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fsD9Gd/LrdMMpUsb1FdogmpNtsHzQmr4i3zjYQ36MUs=;
        b=fUPj3TY7zmMxazQ2HzFkAnlCRyUde259vYVb6JU37Fvsu4E5DYlpDl8wKxTRhnb8a1hNwo
        9UwJvRaW1oW+P+apXriPdlbK+WbJPSTo9/jxIjtui7GktC547wOFGtUnUhVh1iuQ68taOD
        QzYYQdZzE4dhe4gOWi87le1gJ6EN4UQWMZJMoDLY0LU2ozlMryGBmdRWxLK4pNdnRUwXIt
        90hvP4iR2tZbp7aoeGWfioKs6PmLaSFTyrdWWbQXWo0kKIc+jHukKcYuVJddUE0pEcE91c
        n4RQH/TAt46scQhwqLYt6utkQc/xVwqMN6q4f4WybMTiQUHdP+RqI1nep1LjYg==
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
Subject: [PATCH v2 0/4] of: add of_property_alloc/free() and of_node_alloc()
Date:   Wed,  1 Jun 2022 10:17:57 +0200
Message-Id: <20220601081801.348571-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.0
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

In order to be able to create new nodes and properties dynamically from
drivers, add of_property_alloc/free() and of_node_alloc(). These
functions can be used to create new nodes and properties flagged with
OF_DYNAMIC and to free them.

Some powerpc code was already doing such operations and thus, these
functions have been used to replace the manual creation of nodes and
properties.

---

Changes in V2:
- Remove of_node_free()
- Rework property allocation to allocate both property and value with
  1 allocation
- Rework node allocation to allocate name at the same time the node is
  allocated
- Remove extern from definitions
- Remove of_property_alloc() value_len parameter and add more
  explanation for the arguments
- Add a check in of_property_free to check OF_DYNAMIC flag
- Add a commit which constify the property argument of
  of_property_check_flags()

Clément Léger (4):
  of: constify of_property_check_flags() prop argument
  of: dynamic: add of_property_alloc() and of_property_free()
  of: dynamic: add of_node_alloc()
  powerpc/pseries: use of_property_alloc/free() and of_node_alloc()

 arch/powerpc/platforms/pseries/dlpar.c        |  51 +------
 .../platforms/pseries/hotplug-memory.c        |  21 +--
 arch/powerpc/platforms/pseries/reconfig.c     |  45 ++----
 drivers/of/dynamic.c                          | 134 ++++++++++++------
 drivers/of/of_private.h                       |  21 ++-
 include/linux/of.h                            |  25 +++-
 6 files changed, 153 insertions(+), 144 deletions(-)

-- 
2.36.0

