Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919653DAA8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbiFEHHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbiFEHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:07:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAF1BEAD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:07:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w3so9839306plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXhtIIwrHhpC545+iRgGHYieqqcWvvqmIcwI7xt4Nsk=;
        b=iR5Gf7A2/kjLk8Exxps3G0dFRVC1OZjJzS+j2VngWMWquMTrT0tMlu+kwyY+F7EMMI
         lGoZzbndHfDZ4cObymGJCKclk4t2eUSMdCQReDhUxzX4pRTRhUECii4OdVqCZo7/MLRv
         syITFdMzOJw61554abpUPmNjaYgNN1bo4ZoAP1ymyoWSietZE/1pr3cfS252SQh558kG
         qEFZLPguUBe4DBV/fZx4ZTTdbY5aE4vCY3KgmuQJB+9LM1igdu3RLOoRkqSbocJiCNdC
         b7+HeRs4HzS5LATNdkmXyFN/8d0xEiEYUFaV1hSLyycfFxdH5gv+B3pf1d5C3OcMs9YS
         PU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXhtIIwrHhpC545+iRgGHYieqqcWvvqmIcwI7xt4Nsk=;
        b=dnypJ6mixn/0uPa+NTnlgoqZxdDfO2IdYAiedkzUexqnpBbU3hUTggbX33KZjbIVNT
         tc67bdGmWtG0XoOgfxEDuwwBu52m3iaV004hS++7c9IFj5R0r2q+cBcWtKsgwqHUSPku
         fMA4SNFAw/adH4sXeDzol62T8EPui1h1RsngseHkCxnsCRZKtoreMmejt/Jfdudl8+nq
         z/wOQsMf3BoElD2Vb5uMEBe1pg1GTArD8i2hGIG/RGAe1RMnTF3KfHMNVEGW+mBEw+bg
         lxOPL8+Ix8iaTk5tdgNcJ7DKQY/ueCrr4jYXqBs+BeKJImfYLUXFAUU4b7LsOcP652sa
         DXyw==
X-Gm-Message-State: AOAM532Z+TtCaxuVbzMyjyiiKfNFIaaiyjzykNUubhUTV5B4KAMcRwSk
        nROxH7tUfg/xFzIVejTm0wo=
X-Google-Smtp-Source: ABdhPJyMTGLeCNNm+FCrSgXi3l1iw0Qz5IzzU1+Oa/PBBWrms0PoJZlcnhW8wVTcnShhAvR8SNJp+Q==
X-Received: by 2002:a17:903:210a:b0:167:78c0:dd70 with SMTP id o10-20020a170903210a00b0016778c0dd70mr700900ple.157.1654412854448;
        Sun, 05 Jun 2022 00:07:34 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x28-20020aa78f1c000000b0050dc7628196sm442504pfr.112.2022.06.05.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 00:07:33 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: parsers: ofpart: Fix refcount leak in bcm4908_partitions_fw_offset
Date:   Sun,  5 Jun 2022 11:07:23 +0400
Message-Id: <20220605070726.5979-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: bb17230c61a6 ("mtd: parsers: ofpart: support BCM4908 fixed partitions")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/parsers/ofpart_bcm4908.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/parsers/ofpart_bcm4908.c b/drivers/mtd/parsers/ofpart_bcm4908.c
index 0eddef4c198e..bb072a0940e4 100644
--- a/drivers/mtd/parsers/ofpart_bcm4908.c
+++ b/drivers/mtd/parsers/ofpart_bcm4908.c
@@ -35,12 +35,15 @@ static long long bcm4908_partitions_fw_offset(void)
 		err = kstrtoul(s + len + 1, 0, &offset);
 		if (err) {
 			pr_err("failed to parse %s\n", s + len + 1);
+			of_node_put(root);
 			return err;
 		}
 
+		of_node_put(root);
 		return offset << 10;
 	}
 
+	of_node_put(root);
 	return -ENOENT;
 }
 
-- 
2.25.1

