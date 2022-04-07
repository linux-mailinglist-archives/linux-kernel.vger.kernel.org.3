Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7F4F74EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbiDGEpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiDGEov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:44:51 -0400
X-Greylist: delayed 929 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 21:42:47 PDT
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5717CAA028;
        Wed,  6 Apr 2022 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EfIKsaYvyjyauPGrMP
        2ATwQhkAeB9k1V30Eckhc73WU=; b=QVvV7HlffafRhLjS6UzAS5PDgFj0i7qGpL
        UPFo1p7UhSkojB7VTinJ82SltZDmmEbYziEbvYA7f0kRunqUELLOuUW3ebEIpkFg
        JXL8afOpdqU5TE97QVJ4HVHDjVGoM4mC81uwyUWvw/uUrsaNmFdYIyCxaxHYmVpH
        kWpYqL7Zw=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgCHNL0ZaE5iFqljAA--.8487S4;
        Thu, 07 Apr 2022 12:27:15 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mips: cpc: Fix refcount leak in mips_cpc_default_phys_base
Date:   Thu,  7 Apr 2022 12:26:57 +0800
Message-Id: <20220407042657.28614-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GtxpCgCHNL0ZaE5iFqljAA--.8487S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw45tw15Zr4xtw1xKw45KFg_yoW3ArcEgF
        1Iv34xArW5CF1vvFZ7Zw4Sgrn8Cw1rWrWSyw1v9FWUt3yYyr45Jan3Cr93Zws5uryakrs8
        Gr4Yvasrta1xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_yxR3UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbB0APb5WEsp2TMPAAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gong Yuanjun <ruc_gongyuanjun@163.com>

Add the missing of_node_put() to release the refcount incremented
by of_find_compatible_node().

Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
---
 arch/mips/kernel/mips-cpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 17aff13cd7ce..3e386f7e1545 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -28,6 +28,7 @@ phys_addr_t __weak mips_cpc_default_phys_base(void)
 	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
 	if (cpc_node) {
 		err = of_address_to_resource(cpc_node, 0, &res);
+		of_node_put(cpc_node);
 		if (!err)
 			return res.start;
 	}
-- 
2.17.1

