Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056D34B8EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiBPRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:18:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiBPRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:18:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF2C0506;
        Wed, 16 Feb 2022 09:18:38 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIToa072036;
        Wed, 16 Feb 2022 11:18:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645031909;
        bh=59K++broRl3t5nfZqa+TJal88YmCNHYSh22LBWeMyxQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ueQQ5TydIKxOA7FAC1kE8dK44+BKtyMXuR/pLLsndkQTY0HPIgEz1ZOn44eXj4r5Z
         oEf6LES5fj9qoAaJRKkL597irnDc0j9z8IEiYPpFYjA2bahBzuUewJAzKNTjM111eC
         XdMGUgvcXu9qpSKSYSprLgQYtUokFdC3DojOYEo0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GHITtb099789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 11:18:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 11:18:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 11:18:28 -0600
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIJjP056750;
        Wed, 16 Feb 2022 11:18:25 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] soc: ti: k3-socinfo: Add AM62x JTAG ID
Date:   Wed, 16 Feb 2022 22:48:11 +0530
Message-ID: <20220216171815.384377-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216171815.384377-1-vigneshr@ti.com>
References: <20220216171815.384377-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JTAG ID entry to help identify AM62x SoC in kernel.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index b6b2150aca4e4..91f441ee61752 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -42,6 +42,7 @@ static const struct k3_soc_id {
 	{ 0xBB6D, "J7200" },
 	{ 0xBB38, "AM64X" },
 	{ 0xBB75, "J721S2"},
+	{ 0xBB7E, "AM62X" },
 };
 
 static int
-- 
2.35.1

