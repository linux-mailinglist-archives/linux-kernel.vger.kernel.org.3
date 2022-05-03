Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AE518E43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiECUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiECUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:13:43 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C960B3FDB0;
        Tue,  3 May 2022 13:10:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CB77116DF;
        Tue,  3 May 2022 23:10:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru CB77116DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608641;
        bh=99+QgVY0zCV7jNTyccztfB8TN/d7Y8hNJt1G0Gv/SeE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=chDHaAfSPV1C+vQttZPpO3TgzNi4q0J79abS5TDkjluFhzhUCpZo8Lxo4KzQwaigC
         vGyjmrY51sDwNke686hQJzwWIGJuIcEWp4NhL1PllqGqDmvwnhdvrrLNexdjomqtST
         1bS4EuyhWeinzs4MzV4dSLX4H+VH0ekx/sY2f06A=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:07 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 09/23] ata: libahci_platform: Sanity check the DT child nodes number
Date:   Tue, 3 May 2022 23:09:24 +0300
Message-ID: <20220503200938.18027-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
critical from the further AHCI-platform initialization point of view since
exceeding the ports upper limit will cause allocating more resources than
will be used afterwards. But detecting too many child DT-nodes doesn't
seem right since it's very unlikely to have it on an ordinary platform. In
accordance with the AHCI specification there can't be more than 32 ports
implemented at least due to having the CAP.NP field of 4 bits wide and the
PI register of dword size. Thus if such situation is found the DTB must
have been corrupted and the data read from it shouldn't be reliable. Let's
consider that as an erroneous situation and halt further resources
allocation.

Note it's logically more correct to have the nports set only after the
initialization value is checked for being sane. So while at it let's make
sure nports is assigned with a correct value.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Drop the else word from the child_nodes value checking if-else-if
  statement (@Damien) and convert the after-else part into the ternary
  operator-based statement.
---
 drivers/ata/libahci_platform.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 7ff6626fd569..4e54e19f07b2 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -480,15 +480,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		}
 	}
 
-	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
+	/*
+	 * Too many sub-nodes most likely means having something wrong with
+	 * the firmware.
+	 */
+	child_nodes = of_get_child_count(dev->of_node);
+	if (child_nodes > AHCI_MAX_PORTS) {
+		rc = -EINVAL;
+		goto err_out;
+	}
 
 	/*
 	 * If no sub-node was found, we still need to set nports to
 	 * one in order to be able to use the
 	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
 	 */
-	if (!child_nodes)
-		hpriv->nports = 1;
+	hpriv->nports = child_nodes ?: 1;
 
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
-- 
2.35.1

