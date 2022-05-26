Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1B4534DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbiEZLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiEZLHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:07:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710DA15FEE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:07:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m1so1171680plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMgVyRNdqqfbP3WwHBRXWSmLvrhAi/fRvJMgjDc3EOs=;
        b=JUKixnG9osJLbrycPGbSnT+N81UGY6Om9yFrZkK298rRD+ziLyU5fBqF/tl5JjXrh3
         ujQZ1VYslTSoJ78snxNoP3DMgms5+6iyOX2SjwVycyvyHrMex1rddouJYR+NtK4gN4RR
         25yFQHpVU6eyS/S0vVtTaskvki/rqLz1mP9wdE9OPAAyJwD/n7/oTq/NT1zus/UcECmH
         Flvr5tCcVe8JKst5KCnQABSkysWfDNTxBAr+bqYQsK5fDiRjG0Qu3VzA7Dd92vDyI7Nh
         jwxP+hOtfLPJroIimVfQ0FdKUPROM2HoaLmJD5m44z15TMR11HuD8Bij8JQbAgx/nV+y
         NhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMgVyRNdqqfbP3WwHBRXWSmLvrhAi/fRvJMgjDc3EOs=;
        b=lgKVsQtVvsfUMlbJUl9WYPSzaIAC5vJzu+SRE+EwH+iF91xu7YPm0lvEHmVZKjqfA0
         APe/WIwR01y+LEu0mI8wML5pErQI0grCRX7PeRmp0C96Gw5OcMhy1fNBB1Ecpyn4Nl6g
         ViGOst4yxSVBZFp/vWFBzfPijSwcGPZVuOVj5ekRoz0DJgaT5+5ateaYYKtPm+hoDRzx
         sDkZ1XUIFNxGvD1AhdWvvBNKkxdekFBuX8yCjQTk2UMGyRKD17O1VxtECS11R4ZPSkMT
         rsdqGIpiBcsQWBnC71MCnbZ1eMS9GEgCSjg7lD1HjEyxSPMUkR5la7uWuf9CkQjyYTVm
         Z8VQ==
X-Gm-Message-State: AOAM532iK0BY9OXJZpI6XpSXSrrAj1xqJGEfEw8zsHoFvBAqccN72anu
        iSUAsukmyEHbcS57GM94O30=
X-Google-Smtp-Source: ABdhPJxq1svgl05DLs/x1l9IlKIfOMe4cFnuhjOgcTIzfFBewCLkZetUcsTBcTMyxWBlNMczcquHOg==
X-Received: by 2002:a17:90b:3849:b0:1dc:b686:34e2 with SMTP id nl9-20020a17090b384900b001dcb68634e2mr2086847pjb.164.1653563224928;
        Thu, 26 May 2022 04:07:04 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id j11-20020aa7928b000000b0050dc7628133sm1254993pfa.13.2022.05.26.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:07:04 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: partitions: Fix refcount leak in parse_redboot_of
Date:   Thu, 26 May 2022 15:06:49 +0400
Message-Id: <20220526110652.64849-1-linmq006@gmail.com>
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 237960880960 ("mtd: partitions: redboot: seek fis-index-block in the right node")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/parsers/redboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index feb44a573d44..a16b42a88581 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -58,6 +58,7 @@ static void parse_redboot_of(struct mtd_info *master)
 		return;
 
 	ret = of_property_read_u32(npart, "fis-index-block", &dirblock);
+	of_node_put(npart);
 	if (ret)
 		return;
 
-- 
2.25.1

