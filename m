Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108356600E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiGEAR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiGEARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:17:24 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39AB7C4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:17:18 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220705001712epoutp0394b51610588a9013330696cef1dba504~_xr4ePypj2370323703epoutp03X
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:17:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220705001712epoutp0394b51610588a9013330696cef1dba504~_xr4ePypj2370323703epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656980232;
        bh=nXvJxR90Rt4/+tTG+sHkx/Q/nA1jXNywfZNn4ag0N3Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jn5EktiJPA52RWRcRJK9B8uBCqZKVkAZ+8eocAjgGdarY5ulekdnHivoMjWqbXCxi
         uWYdb8vZblTF0ckKU2K+Ss0YW962dJngpEfIc0Ws8ycGCVg3TnAaw4rffklpYgnS06
         RDdHfO6QF3yE+LwwmGwSOZ7otAPl1/w0H7s4bNlc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220705001711epcas1p19bff97cb752c14a26f52a5acb7d71eb2~_xr3oaJ5u2973829738epcas1p1X;
        Tue,  5 Jul 2022 00:17:11 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LcNXR3hwxz4x9Pp; Tue,  5 Jul
        2022 00:17:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.7D.09661.70383C26; Tue,  5 Jul 2022 09:17:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220705001710epcas1p40c6411bd768b39a9cff1d6ce09d445dd~_xr2ZeamZ1726517265epcas1p4w;
        Tue,  5 Jul 2022 00:17:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220705001710epsmtrp2a88d2827d98723d9d028f8b200c7eb43~_xr2YI7u22425024250epsmtrp2c;
        Tue,  5 Jul 2022 00:17:10 +0000 (GMT)
X-AuditID: b6c32a37-2b9ff700000025bd-01-62c3830774ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.ED.08905.60383C26; Tue,  5 Jul 2022 09:17:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220705001710epsmtip273847a6ad0af2ba75255a7b46aa05d37~_xr2HjXsh0648506485epsmtip2D;
        Tue,  5 Jul 2022 00:17:10 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ult.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net,
        alexandre.belloni@bootlin.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        seunghwan.hyun@samsung.com, Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] mmc: print clock frequency with recognization
Date:   Tue,  5 Jul 2022 09:49:29 +0900
Message-Id: <20220705004929.14143-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmni578+Ekg/aJMhbt75axW8w41cZq
        se/aSXaLX3/Xs1s0L17PZtGxdTKTxY7nZ9gtdv1tZrK4vGsOm8WR//2MFgtaPrBanDv5idWi
        6c8+FotrZ06wWtyeOJnRYtpCC4vNl76xOAh6zFtT7XFhJ7fHnWt72Dz2z13D7tH/18Cjb8sq
        Ro/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGesOn2VqWA9Z0V/61TWBsZj7F2MnBwSAiYS/97dY+xi5OIQEtjBKPHq910mkISQ
        wCdGiSn3AiES3xgl5j2HSIB0PD26lB0isZdR4lPnSyYI5zOjRP/H+SwgVWwCWhLTN20BS4gI
        XGCUuPbwMJjDLNDDJPH70ndWkCphATuJx1+esYHYLAKqEhuPngaL8wpYSTy4fogNYp+8xJ/7
        PcwQcUGJkzOfgG1gBoo3b53NDDJUQmAph8SMngWMEA0uEl/3wTQLS7w6vgXqVSmJz+/2QsWL
        Jdr+/WOGsCskDvZ9gbKNJT59/gw0hwNogabE+l36EGFFiZ2/5zJC7OWTePe1hxWkREKAV6Kj
        TQiiRFni5aNl0CCSlFjSfgtqoofEufZtYBOFBGIlDn7VnsAoPwvJM7OQPDMLYe8CRuZVjGKp
        BcW56anFhgXG8FhNzs/dxAhOwlrmOxinvf2gd4iRiYPxEKMEB7OSCO+qSQeThHhTEiurUovy
        44tKc1KLDzGaAoN3IrOUaHI+MA/klcQbmlgamJgZmVgYWxqbKYnzrpp2OlFIID2xJDU7NbUg
        tQimj4mDU6qByfD+tDNXhE5qPjtkfJNhRVeK4+q/DSvemRVdlHPZwrK/1mTdvcWLN92YO/NQ
        nEnUdx++o1u3sMZLv6yddMfM58ud0tmHDug/2/Ixi2GG/ppAsYjX8n82HXp5+8n9nYufNlir
        R4cVn/ZarqzdWr5Y4pF7YOWtAK8bSm3mKvm73j17HaQd8z/GxSPHQ7UlNSxx48KgJxXzcuPq
        ttvrdu3JW6tRd7d3O6NtYPKqGheux+1+fw9pyQiYHTw9eevD269rvpyL3fxMoJJd4+2Elat3
        fGQ6HLhT+odpm5qTUHLd9ckW4iHivMvF3vHqpQn9aKwPXupia7GC+/wc9mhBoW+ZzjsNV273
        +LlVUSpLaHaVuhJLcUaioRZzUXEiAPNrgU9LBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvC5b8+Ekg+mNUhbt75axW8w41cZq
        se/aSXaLX3/Xs1s0L17PZtGxdTKTxY7nZ9gtdv1tZrK4vGsOm8WR//2MFgtaPrBanDv5idWi
        6c8+FotrZ06wWtyeOJnRYtpCC4vNl76xOAh6zFtT7XFhJ7fHnWt72Dz2z13D7tH/18Cjb8sq
        Ro/Pm+QC2KO4bFJSczLLUov07RK4MladvspUsJ6zor91KmsD4zH2LkZODgkBE4mnR5cC2Vwc
        QgK7GSXe9LdCJSQlFj96yNbFyAFkC0scPlwMEhYS+MgoMf+1CIjNJqAlMX3TFiaQXhGBa4wS
        yx++ZQNxmAVmMEk8Wr6VEaRKWMBO4vGXZ2wgNouAqsTGo6dZQWxeASuJB9cPsUEsk5f4c7+H
        GSIuKHFy5hMWEJsZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI4LLc0djNtXfdA7xMjEwXiIUYKDWUmEd9Wkg0lCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MKlE8BxU1M/eyW5cqfMyMSq6a8abczJXOdZJ
        H9w6//+EajOJeN48i+Q3eksV1VNieGac3VBd9eGJzAz3lwlWn91tYjICn4ZLb5C3vpf4poxZ
        R8nGx2dq9McVa08+2Sabu95w26y//evs5MXtLX8kZmzT293+TlJy0arZTS8Cp/2zW7F02bzr
        vu8u/dKK2xxfwnFD1kSW9WZhssFJn8YJE973Ck9jz119fXvo/c/rTy52/Gi3591rLltnu2UK
        vSG/eWud+iokvF6dYbl+Yutl7qYKyV2LP4ZLeL8OcpdZz5ps/dbKQswr8MI5iVWOwq1sJw57
        77u1flPjv6SeaLt/jqeTX5u7X2lLqPFNjuu2UmIpzkg01GIuKk4EAAXZbUr6AgAA
X-CMS-MailID: 20220705001710epcas1p40c6411bd768b39a9cff1d6ce09d445dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705001710epcas1p40c6411bd768b39a9cff1d6ce09d445dd
References: <CGME20220705001710epcas1p40c6411bd768b39a9cff1d6ce09d445dd@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easy to figure out how fast frequency it has from the log.
e.g. mmc0: new ultra high speed SDR104 SDXC card
at address aaaa(clk 202000000)

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60afa650b..3623cc27a61c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -348,7 +348,7 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr52(card) ? "DDR " : "",
 			type);
 	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s%s%s card at address %04x(clk %u)\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_hs(card) ? "high speed " : ""),
@@ -356,7 +356,8 @@ int mmc_add_card(struct mmc_card *card)
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
 			mmc_card_ddr52(card) ? "DDR " : "",
-			uhs_bus_speed_mode, type, card->rca);
+			uhs_bus_speed_mode, type, card->rca,
+			card->host->ios.clock);
 	}
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.29.0

