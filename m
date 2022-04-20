Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B914A5085B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377592AbiDTKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbiDTKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:23:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3A1D0F3;
        Wed, 20 Apr 2022 03:20:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23KAKPWT008426;
        Wed, 20 Apr 2022 05:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650450025;
        bh=WQz1NXqH44zqQrsGYhOZZwpDPw6pIXS8bNm5c+6Gswg=;
        h=From:To:CC:Subject:Date;
        b=ERHtbJypMGZGDVRQh/XWzhjbTclYMIQU4Gpyidl6lY+v8OvjiySyT3+HXHXujtThY
         X/EIknPBxFig8l9xqh2Aw9NV6sva2+fu3in+OaXa4+Dyy4Ak3CoNoIkyMVwEwagzeL
         lU4JJ/Q1V91SkEhUXalp5sMldQhtblH9muVeY2lM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23KAKP10018050
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Apr 2022 05:20:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Apr 2022 05:20:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Apr 2022 05:20:25 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23KAKMq7033245;
        Wed, 20 Apr 2022 05:20:23 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: spi-mem: check if data buffers are on stack
Date:   Wed, 20 Apr 2022 15:50:22 +0530
Message-ID: <20220420102022.3310970-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffers passed in the data phase must be DMA-able. Programmers often
don't realise this requirement and pass in buffers that reside on the
stack. This can be hard to spot when reviewing code. Reject ops if their
data buffer is on the stack to avoid this.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v2:
- Include task_stack.h. It might not get included indirectly on some
  platforms and can cause build failures.
- Add a WARN_ON_ONCE() for debuggability.
- Add Mark's Ack.

 drivers/spi/spi-mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 7d7091aa0c22..e8de4f5017cd 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -10,6 +10,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/sched/task_stack.h>

 #include "internals.h"

@@ -211,6 +212,15 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 	    !spi_mem_buswidth_is_valid(op->data.buswidth))
 		return -EINVAL;

+	/* Buffers must be DMA-able. */
+	if (WARN_ON_ONCE(op->data.dir == SPI_MEM_DATA_IN &&
+			 object_is_on_stack(op->data.buf.in)))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(op->data.dir == SPI_MEM_DATA_OUT &&
+			 object_is_on_stack(op->data.buf.out)))
+		return -EINVAL;
+
 	return 0;
 }

--
2.34.1

