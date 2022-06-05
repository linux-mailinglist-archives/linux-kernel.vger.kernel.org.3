Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC053DACA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350826AbiFEH6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349301AbiFEH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:58:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499B3818A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:58:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e66so10541601pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIaW2W3kciWaqF9Rr2LnHumkokFFkDuqQM4YiszKM2Y=;
        b=nJgso2Q6AIEclla/wuH8+42F+fzYyKTBXqQde2ubdOoLHm4kscNoo4aMedMkX5mMAp
         bV8/zPpDAQNzvIXL0FmzesKSNBZedxG5c/BPxou8t1KKKxr/xhWy0sLbu9UHnKEL7FjZ
         MUKY099immUppc2dns9cYFASfhPXvyCWn7vLiL1OAmip00wjVb4rmW84cUfPU5OwrQJx
         AlgpmfFNK0sDMTzBQ7tACDLKypOEArTECBhFqD1LALG7f4CMz/f9G6kBLzM3dI1kpaB/
         ltsgNCTez2+uSWf1c2DctfTCNO2u2fITwtR1SfS5aTZHM64kg2+XdZ68LB23/zFWaDgV
         tO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIaW2W3kciWaqF9Rr2LnHumkokFFkDuqQM4YiszKM2Y=;
        b=frIYIc+OLeDFf9JlEjJyJQZQ3n7kyZ6r7Q6qHgVjkHSg+K9JmWzLkjhHXWvelPYZUb
         wASPeNdGRRGIb8/2PGyH2r1MHBUdpgq8wGKuh65+ZY1owlvcf02xi4CV511IyCN53Zqt
         uzwpOp1BDmeAAUoR4pgRUmnutoPiPoKVySGMxOGui0A8zvtx+s8VC8nDjc48fStILmGF
         JuSyhgH43BtI8KaUgB+6bKsuzqj5gyQ65Mc0MnGp8BfxxNc0D5FuENs/v4BMZ+BTUjYj
         VSjDz5RCKQHckGPZY2lNDG2ud1fZgp1F6/GTt97WIuXNqKbd5ix1QrDdr2q0pSC1/rUW
         GF0Q==
X-Gm-Message-State: AOAM530GRDYgkds9Ss2SKtq55H6lPh7lON0pJfBMd7LnuV1sZMSD43eE
        FHlNrdCJ8XGhTl92FYDI7DzBySFF5mxNFH+n
X-Google-Smtp-Source: ABdhPJzY4AllDjrmX2fBbjfpvyFtvxSZFxKd9yd9eY6Pb7bv/UBqovBwq0AAXYIXMqZN/sK/DYNGfg==
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id l14-20020a637c4e000000b003808ae9c975mr16314985pgn.25.1654415929335;
        Sun, 05 Jun 2022 00:58:49 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s16-20020aa78bd0000000b0051bbd79fc9csm7182568pfd.57.2022.06.05.00.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 00:58:48 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: cns3xxx: Fix refcount leak in cns3xxx_init
Date:   Sun,  5 Jun 2022 11:58:41 +0400
Message-Id: <20220605075841.19929-1-linmq006@gmail.com>
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

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 415f59142d9d ("ARM: cns3xxx: initial DT support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-cns3xxx/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e4f4b20b83a2..3fc4ec830e3a 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -372,6 +372,7 @@ static void __init cns3xxx_init(void)
 		/* De-Asscer SATA Reset */
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
 	}
+	of_node_put(dn);
 
 	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
 	if (of_device_is_available(dn)) {
@@ -385,6 +386,7 @@ static void __init cns3xxx_init(void)
 		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
 	}
+	of_node_put(dn);
 
 	pm_power_off = cns3xxx_power_off;
 
-- 
2.25.1

