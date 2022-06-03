Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8153CC9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbiFCPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbiFCPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:24 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1550B3F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:10 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220603154908epoutp047f3c073a6a138d1135f7e083e47df7e3~1JwbiMImj0048500485epoutp04O
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220603154908epoutp047f3c073a6a138d1135f7e083e47df7e3~1JwbiMImj0048500485epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271348;
        bh=wBz3WyDv6QKq3q350/xaW+hbym69+M1flHfWWIhawTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4v7qPt839toWdjDyMry46VV1DZ3vxPVUYb7frPmtqUjhjm6+etRWTr/nDB/Dmkuz
         2v5Gb2DGWPlk1L18hOwMS2RL8wiHnD+vhAMq5Bd1o3ksgCa58vMLBJMUoDzgGYFKJl
         AS1enzBHCCHAIGmP5Kizd6c+nsRc9XG8QrtGTwLQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220603154908epcas5p3417691c5148eb2f866666e56cff9f1c6~1JwbBGkc51875418754epcas5p3r;
        Fri,  3 Jun 2022 15:49:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LF6kT4kR5z4x9Pt; Fri,  3 Jun
        2022 15:49:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.B8.10063.17D2A926; Sat,  4 Jun 2022 00:49:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603154904epcas5p21615dfab6f57f563889230c81a717835~1JwXhOyiV1442914429epcas5p2W;
        Fri,  3 Jun 2022 15:49:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603154904epsmtrp14a825d285599b92f7570e8c37be5ed32~1JwXgZaEM2840728407epsmtrp1S;
        Fri,  3 Jun 2022 15:49:04 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-53-629a2d71d4aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.6C.11276.07D2A926; Sat,  4 Jun 2022 00:49:04 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154901epsmtip1e8aa68a0a95f4e58b580484f51bb73a1~1JwVV-0cp0345503455epsmtip1J;
        Fri,  3 Jun 2022 15:49:01 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 5/7] ufs: ufs-exynos:  add mphy apb clock mask
Date:   Fri,  3 Jun 2022 21:17:12 +0530
Message-Id: <20220603154714.30532-6-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTQ7dQd1aSwZQNKhYP5m1js3j58yqb
        xbQPP5ktLu/Xtph/5ByrRd+Lh8wWmx5fY7W4vGsOm8WEVd9YLLqv72CzWH78H5PFoq1f2C1a
        9x5ht9h55wSzA5/H5SveHptWdbJ53Lm2h81j85J6j49Pb7F49G1ZxejxeZOcR/uBbqYAjqhs
        m4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygq5UUyhJz
        SoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rnd
        W9ayFrxmr3i8aC5bA+MJti5GTg4JAROJLy92sHcxcnEICexmlPjx8BeU84lR4uyFtUwQzjdG
        iX1vlzHCtFy/tg+qai+jxMOJe1khnBYmiUlLPoANZhPQlrg7fQtYu4hAM6PEwY5dYA6zQB+T
        xJLbt1lBqoQFHCXOP/vIBGKzCKhKLJjzB2wHr4CNxOKFz9gh9slLrN5wgLmLkYODU8BWYupp
        PpA5EgITOSReTtrJAhKXEHCR2NopCVEuLPHq+BaoVimJl/1t7BAlHhKL/khBhDMk3i5fD/WN
        vcSBK3PApjALaEqs36UPEmYW4JPo/f2ECaKTV6KjTQiiWlWi+d1VFghbWmJidzcrzPDnp9xA
        wkICExglDr31n8AoOwth5gJGxlWMkqkFxbnpqcWmBYZ5qeXwaErOz93ECE6KWp47GO8++KB3
        iJGJg/EQowQHs5IIb9m8mUlCvCmJlVWpRfnxRaU5qcWHGE2BwTWRWUo0OR+YlvNK4g1NLA1M
        zMzMTCyNzQyVxHkF/jcmCQmkJ5akZqemFqQWwfQxcXBKNTA1FJ5JbCznnzqLyefH2oUi5x+b
        Om/eerlSTaT54v2FpXElTTFpbje877zuvHN4xY/ET1L/DQ/PXVnEe0b2xqKLcjN6Nxpxqp7X
        rJp6JOS8k+2bCYzm+dO8mT9X2U5KWnKqfr7ngYiWjEDH6pbHZxN2nGfkUvl4npGF+7Pf7Hi5
        ZKeYF5z8EakvFaU43YN8z6132/PrxzVRsyXvZByDPI/P2emW++l8QMma1bzbj/S4357PY2LR
        UnJFOWRHncNvAwv5zpuTJtbPNe0WP+nIe2nzd44rf+ZN3zkvpv/dsXphCcaUmJhpYddnTlTi
        1mS8rPC12mmO89R3wt48/1fIX3eomrU0RLvr2kSt7tneLy2UWIozEg21mIuKEwGP7adbEwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnG6B7qwkgzV9fBYP5m1js3j58yqb
        xbQPP5ktLu/Xtph/5ByrRd+Lh8wWmx5fY7W4vGsOm8WEVd9YLLqv72CzWH78H5PFoq1f2C1a
        9x5ht9h55wSzA5/H5SveHptWdbJ53Lm2h81j85J6j49Pb7F49G1ZxejxeZOcR/uBbqYAjigu
        m5TUnMyy1CJ9uwSujO4ta1kLXrNXPF40l62B8QRbFyMnh4SAicT1a/vYuxi5OIQEdjNKbLvT
        zAiRkJa4vnECO4QtLLHy33OooiYmie9P97KAJNgEtCXuTt/CBGKLCLQzStzfzgZSxCwwi0ni
        /aQnYJOEBRwlzj/7CFbEIqAqsWDOH7A4r4CNxOKFz6A2yEus3nCAuYuRg4NTwFZi6mk+kLAQ
        UMn38/dZJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzUWpo7GLev+qB3
        iJGJg/EQowQHs5IIb9m8mUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MIl9MwxYFhowXeQToztLawf7m7vGm34f8jA8ly8gbjzT8V/evr/i7ue9fjh9
        nFtqf7gwI//kbMm5bz2uXpmnEmsoKlLtUvZjzWfJKY1vn+52611xUHtimbeY1JJ5fYe0VF+t
        XfWZeV/QqwOJZ7rzuH81BJZPtTNIf8m/x1AheUrsm9oDOxk4onZ9ntxQNVNifzUnp75Xzyoe
        fcej604k7GswSDQ8+EDUvWFxONfHy3PfhxTb6z8SUK/ZW2PS/iDe0PnI5JhPJ8K2a4dYLVuX
        tchzreSf+U/rKvfH/7FR+Kr91rTq5aRSXq/zK/Ni33OIJxyZfnZ7gmrz+/4jivHTfy66eTWk
        b2rEysdLBERmtiuxFGckGmoxFxUnAgAenjyF2QIAAA==
X-CMS-MailID: 20220603154904epcas5p21615dfab6f57f563889230c81a717835
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154904epcas5p21615dfab6f57f563889230c81a717835
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154904epcas5p21615dfab6f57f563889230c81a717835@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit[3] of HCI_CLKSTOP_CTRL register is for enabling/disabling MPHY APB
clock. Lets add it to CLK_STOP_MASK, so that the same can be controlled
during clock masking/unmasking.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index a81d8cbd542f..cc128aff8871 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -52,11 +52,12 @@
 #define HCI_ERR_EN_DME_LAYER	0x88
 #define HCI_CLKSTOP_CTRL	0xB0
 #define REFCLKOUT_STOP		BIT(4)
+#define MPHY_APBCLK_STOP	BIT(3)
 #define REFCLK_STOP		BIT(2)
 #define UNIPRO_MCLK_STOP	BIT(1)
 #define UNIPRO_PCLK_STOP	BIT(0)
 #define CLK_STOP_MASK		(REFCLKOUT_STOP | REFCLK_STOP |\
-				 UNIPRO_MCLK_STOP |\
+				 UNIPRO_MCLK_STOP | MPHY_APBCLK_STOP|\
 				 UNIPRO_PCLK_STOP)
 #define HCI_MISC		0xB4
 #define REFCLK_CTRL_EN		BIT(7)
-- 
2.25.1

