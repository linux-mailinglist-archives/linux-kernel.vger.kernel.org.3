Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43A51A451
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352581AbiEDPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiEDPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:45:40 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86621BB6;
        Wed,  4 May 2022 08:42:03 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C93640012;
        Wed,  4 May 2022 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651678921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2uwE18lvQXGT+MV4DaiAsxn2e6wCWwqahOsIaa5OmaM=;
        b=dpXoNiNnHoTEgi2anyHIOlRxTKdUdoCcBE4AOUNKSbZ7q4lmtUqAcbev/Hn2l0PkyBslQy
        K3dXSLM0m95kki4zL31F1DZLzLuFzgSPE1GotvHNbqLb+IJv0RQPB96+PF5NmFpXco8Hjg
        sHLALex2BxwPMY3KS/FHok0EBEyVhw3JUwxO/Y6GzlS24WJ3COpoHDNyFHidj+qvNdYbGg
        RJGJCJXcUvYZKT6aSW/57wGku2rLotH6CGwbLoTNrfUwKcPb6h0PgyrBKUXSWeNv6f4tlo
        c5VtSkchhavu64cUsgDcZ1xJVJJh3qINYafdcb5G+GrpPTE9B62W67+FeGJseA==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] of: add of_property_alloc/free() and of_node_alloc/free()
Date:   Wed,  4 May 2022 17:40:30 +0200
Message-Id: <20220504154033.750511-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to create new nodes and properties dynamically from
drivers, add of_property_alloc/free() and of_node_alloc/free(). These
functions can be used to create new nodes and properties flagged with
OF_DYNAMIC and to free them.

Some powerpc code was already doing such operations and thus, these
functions have been used to replace the manual creation of nodes and
properties.

Clément Léger (3):
  of: dynamic: add of_property_alloc() and of_property_free()
  of: dynamic: add of_node_alloc() and of_node_free()
  powerpc/pseries: use of_property_*() and of_node_*() functions

 arch/powerpc/platforms/pseries/dlpar.c        |  51 +-----
 .../platforms/pseries/hotplug-memory.c        |  27 +--
 arch/powerpc/platforms/pseries/reconfig.c     |  44 ++---
 drivers/of/dynamic.c                          | 160 +++++++++++++-----
 include/linux/of.h                            |  25 +++
 5 files changed, 166 insertions(+), 141 deletions(-)

-- 
2.34.1

