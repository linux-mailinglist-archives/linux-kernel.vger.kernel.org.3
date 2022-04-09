Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0484FA518
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiDIFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiDIFYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:24:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1D26129
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:22:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so9688041plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cIdqjLCFAxoIp4Ta8Sa/kLWiG2xTZyv1wodCLDa8stg=;
        b=PQZgjAf4GQRLJ6M2/BS05ElPfRJXPffzAfjrrtKqoKnCHmeJRknvqOkL0J4VvwxyHw
         BaO5FCyTQkjhrVTUB95fcNO6g2yy+A0aMQnyH2p6id1CY7vsqDn2dT9OpwCizEbk85Cn
         T6UF6d3LD5eUsQUx+18lNYnOqycletll+YHMx6Pyl/tgteQIdpqIjNpsunk3SYk3hn+M
         n748KW643Lrh697qXNJGzuTUsG2PoKy1ZrvjfTeSEK8sKHfwcnIb6ufcbQNcXGJi/ZRV
         haxLtbOHIVgLLYi6G+fvtrmIjZVl9sJEOPNaVuvqpXkyoUHZnhNNSkBjBhMlC8IIPLd4
         FxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cIdqjLCFAxoIp4Ta8Sa/kLWiG2xTZyv1wodCLDa8stg=;
        b=W0Ev2RWPCYp2xVT4F+xzDbm9JLR7XDWjVkj0+KGwrAaH0m5ZUXNJpycIMYfo8cIDqd
         4IaIq6D1YQE/HRz/WEBJ61KHcYgDLb5uE2a0Dmc13HzISb0av42wAJ9Qonm28HYELCSM
         b/yNH2JHMPjY+gWRn0TMefXFwwsQaPjbnR+A4befUk+msmwqUaaYC9IPHEMZG+UAbvxt
         xp4qAEwpdEPStfpAYhbJaJxLfBiFe0xnyM9J6ZFWngGCOHpST19QsZuTi/glfzfoojTM
         YVirOsfqGzAgBwwMJ0aMtN8oz09HsOVdu2JiWcIfUHbUjm+TL89g3F834an0gMJDCmL/
         M8uQ==
X-Gm-Message-State: AOAM533kV4Xs3ChwykOiJuHMi3N0GgGbKQFdcLz1sIGXNqNhSxbfy0KW
        dT6xL9AZj9DeMtBQqGUOhMWDklReixOiE4gN
X-Google-Smtp-Source: ABdhPJzQgq8RmOhb/NBbi3TLFvH6U9CaNQA5403UTa8mrKRnOYGR9Gk87pzcZE9kwJbiKQ/2Jppceg==
X-Received: by 2002:a17:902:e5c6:b0:155:ceb9:3710 with SMTP id u6-20020a170902e5c600b00155ceb93710mr23274831plf.59.1649481735053;
        Fri, 08 Apr 2022 22:22:15 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id d8-20020a636808000000b00398e9c7049bsm21694446pgc.31.2022.04.08.22.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 22:22:14 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: nand: separate ecc-mxic from nandcore
Date:   Sat,  9 Apr 2022 13:21:48 +0800
Message-Id: <20220409052148.2159196-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
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

ecc-mxic contains its own MODULE_* macros. It should get a
separated obj- entry in Makefile instead of being built as
a part of nandcore.o

Fixes: 48e6633a9fa2 ("mtd: nand: mxic-ecc: Add Macronix external ECC engine support")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index a4e6b7ae0614..dbc62bc7b2f9 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -2,6 +2,7 @@
 
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
+obj-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
 
 obj-y	+= onenand/
 obj-y	+= raw/
@@ -10,4 +11,3 @@ obj-y	+= spi/
 nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
-nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
-- 
2.35.1

