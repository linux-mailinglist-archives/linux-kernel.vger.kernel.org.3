Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0656BF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiGHREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiGHREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:04:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845226DC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:04:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so12726815wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HBuSahyHNMvF03MJu9v5fOOMawQITXHXQRHirstyvY=;
        b=hwRE+J5UtH0ki5YLkiBGNPWWtNX6TKj+8IzXvu9zCaoC38fW/DT1+lJjWiUx5eizKv
         lwVmTj4/uY/I29LhR/3am0qkIuhVmwqyP/4ThIAPNCnxkZExoeTZd+UEVv3xrk/Sh9OV
         pVCdBxBtg2YGIY10+bv3d6/45j4y+vph7QUSMTgLtJFv8z+BbgJ0KfqfmXeIBNKs8AoI
         UJIFR3kVYfV3fuAKjXZmgJ2lem3n/KVNK6okvnt0B+/vigYBFAHLrdDKa/xqkf+7+gDR
         eM9JgP1KkOJcVcKdmHHLNO9Gl6T4kjanccRrUUgcYYrnv/ej4xrPKUiryeuUXAxmQ0ee
         yauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HBuSahyHNMvF03MJu9v5fOOMawQITXHXQRHirstyvY=;
        b=zZUhUAERrIPbwBuw3321H4/ar2QCaBYorUit4FcmovardjVEjx0CEyDO9bDEyxF4eU
         P6re44KhP5yM3AThk84cTp4ksQNn+yQIuiXNTAVJHuFjz7ntwHMofZ4LR8VIoc19uZcD
         +ZS/omImbFAahauLPsKLUWlC2UmnoTo/+jARqUdUTtugK+XZvpLshRB/7+VntwIkfGes
         zfqmIaYO7JLxGSO6FyiBbchZwL+CNQ7m9QCP8ay5qbnT6K2HcBwxZa5MNkUDyO/czkEp
         x1+xN0UpmLBsGRgr88SFWH3QNLLgMwL9xKAq33Cz62Jvua/T3QWY6GcUOhTZKBl9u4YF
         cROQ==
X-Gm-Message-State: AJIora9z10kvuTFimtIhHKjWOdh8/NGa1hzUKyx5JBmyqQfTlLpU3O7C
        8szGFhVhiaIk24IowUm4vDa2CQ==
X-Google-Smtp-Source: AGRyM1tZHhb1bv2++7AldaFjeq33dj7xyQovjRq+kPMM1e1IW3RGohQXv0i8r9DL4q+4dHdDx2coPA==
X-Received: by 2002:a05:600c:1f19:b0:3a1:8fbf:f75c with SMTP id bd25-20020a05600c1f1900b003a18fbff75cmr819680wmb.47.1657299845949;
        Fri, 08 Jul 2022 10:04:05 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c502300b003a2d0f0ccaesm2804821wmr.34.2022.07.08.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:04:05 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     devicetree@vger.kernel.org, frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] scripts/dtc: dma-ranges is a multiple of 3 cells
Date:   Fri,  8 Jul 2022 18:03:59 +0100
Message-Id: <20220708170359.270226-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma-ranges property is a set 3 cells of #address-size, so don't treat
it like the ranges property when generating warnings.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 scripts/dtc/checks.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 781ba1129a8e..791b93e8e02a 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -823,7 +823,36 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 	}
 }
 WARNING(ranges_format, check_ranges_format, "ranges", &addr_size_cells);
-WARNING(dma_ranges_format, check_ranges_format, "dma-ranges", &addr_size_cells);
+
+static void check_dma_ranges_format(struct check *c, struct dt_info *dti,
+				struct node *node)
+{
+	struct property *prop;
+	int c_size_cells, p_size_cells, entrylen;
+	const char *ranges = c->data;
+
+	prop = get_property(node, ranges);
+	if (!prop)
+		return;
+
+	if (!node->parent) {
+		FAIL_PROP(c, dti, node, prop, "Root node has a \"%s\" property",
+			  ranges);
+		return;
+	}
+
+	c_size_cells = node_size_cells(node);
+	p_size_cells = node_size_cells(node->parent);
+	entrylen = (p_size_cells + 2 * c_size_cells) * sizeof(cell_t);
+
+	if (!is_multiple_of(prop->val.len, entrylen)) {
+		FAIL_PROP(c, dti, node, prop, "\"%s\" property has invalid length (%d bytes) "
+			  "(parent #address-cells == %d, "
+			  "child #address-cells == %d)", ranges, prop->val.len,
+			  p_size_cells, c_size_cells);
+	}
+}
+WARNING(dma_ranges_format, check_dma_ranges_format, "dma-ranges", &addr_size_cells);
 
 static const struct bus_type pci_bus = {
 	.name = "PCI",
-- 
2.35.1

