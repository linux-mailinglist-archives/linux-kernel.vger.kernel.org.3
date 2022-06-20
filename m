Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C555161A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiFTKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:43:07 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63211174;
        Mon, 20 Jun 2022 03:43:04 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98C631C000D;
        Mon, 20 Jun 2022 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655721783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8HmuiD0Wo+tdZIhp+vs0Aw78V+tuRHzEd0BRSRg3hb4=;
        b=CW8ekHH70yp2UEX+lty3nRQ6qoZUUHMZTI1U2No9V7IL/svmi6QQJ/sHRHowZszQGjCCnm
        cjd6LjNohWfiQm6jNe+ahzKIVpUurR1lKSaJsYArLloWMsrFTMXGZDx1VSFS07QL2y0xLy
        kjDLz5EIRRO1vKdfOd0nR+6EUHPMYfS96ShrHY5BnIR+5pHymXC01UOIIMLB2u7z/I7ycP
        emM+j4fKyUXZkfe1L3bmcPUfI6cj04BsRrSFM2MY03EYZdujIigjYR4g1jTPbuiTmXmtbw
        gUdwW/hQIdmjSjjlW7GL496TRZ/T9ZxuzdvsjkqYr5Gqng3vKp7/hfwCnegYyQ==
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
Subject: [PATCH v3 0/5] of: add of_property_alloc/free() and of_node_alloc()
Date:   Mon, 20 Jun 2022 12:41:18 +0200
Message-Id: <20220620104123.341054-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
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

In order to be able to create new nodes and properties dynamically from
drivers, add of_property_alloc/free() and of_node_alloc(). These
functions can be used to create new nodes and properties flagged with
OF_DYNAMIC and to free them.

Some powerpc code was already doing such operations and thus, these
functions have been used to replace the manual creation of nodes and
properties. This code has been more than simply replaced to allow using
of_node_put() rather than a manual deletion of the properties.
Unfortunately, as I don't own a powerpc platform, it would need to be
tested.

---

Changes in V3:
- Remove gfpflag attribute from of_node_alloc() and of_property_alloc().
- Removed allocflags from __of_node_dup().
- Rework powerpc code to only use of_node_put().
- Fix properties free using of_node_property in OF unittests.

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

Clément Léger (5):
  of: constify of_property_check_flags() prop argument
  of: remove __of_node_dup() allocflags parameter
  of: dynamic: add of_property_alloc() and of_property_free()
  of: dynamic: add of_node_alloc()
  powerpc/pseries: use of_property_alloc/free() and of_node_alloc()

 arch/powerpc/platforms/pseries/dlpar.c        |  62 +-------
 .../platforms/pseries/hotplug-memory.c        |  21 +--
 arch/powerpc/platforms/pseries/reconfig.c     | 123 ++++++----------
 drivers/of/dynamic.c                          | 137 ++++++++++++------
 drivers/of/of_private.h                       |  19 ++-
 drivers/of/overlay.c                          |   2 +-
 drivers/of/unittest.c                         |  24 ++-
 include/linux/of.h                            |  24 ++-
 8 files changed, 191 insertions(+), 221 deletions(-)

-- 
2.36.1

