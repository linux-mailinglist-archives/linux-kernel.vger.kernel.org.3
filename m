Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10476572D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiGMFbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiGMFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:30:32 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4611C50737;
        Tue, 12 Jul 2022 22:29:36 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 16C9516AD;
        Wed, 13 Jul 2022 08:31:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 16C9516AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690284;
        bh=1w09WlHzsLJJ1Iix44RngaZfNGmBziRoxLwbJ26Cixk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CQtRv4QnqBMCNTXBGQgf4jlK2lu/kPhPPtuS2AFaArlyOqpSJ+NxAfTOVnjNFXyF3
         Tc1AnPJZR5oLsQHDBT29BqBi26eggWfoIsxfGb1Oohx3whTYTQKligcZQ1e8E6UgcD
         uIzT3ldSE9xnU7rBqA6F4WqWDGP8JHFXn8sr4v0I=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 08/23] ata: libahci_platform: Sanity check the DT child nodes number
Date:   Wed, 13 Jul 2022 08:29:01 +0300
Message-ID: <20220713052917.27036-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
from the further AHCI-platform initialization point of view since
exceeding the ports upper limit will cause allocating more resources than
will be used afterwards. But detecting too many child DT-nodes doesn't
seem right since it's very unlikely to have it on an ordinary platform. In
accordance with the AHCI specification there can't be more than 32 ports
implemented at least due to having the CAP.NP field of 5 bits wide and the
PI register of dword size. Thus if such situation is found the DTB must
have been corrupted and the data read from it shouldn't be reliable. Let's
consider that as an erroneous situation and halt further resources
allocation.

Note it's logically more correct to have the nports set only after the
initialization value is checked for being sane. So while at it let's make
sure nports is assigned with a correct value.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v2:
- Drop the else word from the child_nodes value checking if-else-if
  statement (@Damien) and convert the after-else part into the ternary
  operator-based statement.

Changelog v4:
- Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
- Replace "?:" operator with if-else statement. (@Damien)
---
 drivers/ata/libahci_platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 814804582d1d..579039956917 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -451,14 +451,24 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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
+	if (child_nodes)
+		hpriv->nports = child_nodes;
+	else
 		hpriv->nports = 1;
 
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
-- 
2.35.1

