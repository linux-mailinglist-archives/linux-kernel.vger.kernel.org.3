Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A47566010
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGEASV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGEASU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:18:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F850B7C4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:18:18 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220705001816epoutp0213251dc2f52b5007f1822f932a79f408~_xsz3bVOc0225802258epoutp02J
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:18:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220705001816epoutp0213251dc2f52b5007f1822f932a79f408~_xsz3bVOc0225802258epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656980296;
        bh=nXvJxR90Rt4/+tTG+sHkx/Q/nA1jXNywfZNn4ag0N3Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K5jw+2Lg3WsZ7cAxMKCSVSoZsSvOj00OnyMKwim1Q7S4yOLLjTz40M1ODYww8P1hc
         KDYfvItCR05zqgyksZcNyQVABIc9qLVYWvp5NgtXvwTk9QlQUaP1Sh+EORPMLcK8r1
         fpdDSG8g+/UglRZz0IlCRIzf1xDqW4gn9FUlcINc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220705001815epcas1p3fcb0562e6c0c9856ce5bfb21b8169bfb~_xszHY5lk0586705867epcas1p38;
        Tue,  5 Jul 2022 00:18:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LcNYg2jjtz4x9Q7; Tue,  5 Jul
        2022 00:18:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.49.09657.74383C26; Tue,  5 Jul 2022 09:18:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310~_xsyW3e421272212722epcas1p4-;
        Tue,  5 Jul 2022 00:18:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705001814epsmtrp1b0b4e9c61824d267cc1e2186ef5fb2ce~_xsyVXYhE2344523445epsmtrp1k;
        Tue,  5 Jul 2022 00:18:14 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-41-62c383471cb5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.1B.08802.64383C26; Tue,  5 Jul 2022 09:18:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220705001814epsmtip27f827b29108ec939aca3f257405085fc~_xsyFoXX_0649106491epsmtip2T;
        Tue,  5 Jul 2022 00:18:14 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net,
        alexandre.belloni@bootlin.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        seunghwan.hyun@samsung.com, Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] mmc: print clock frequency with recognization
Date:   Tue,  5 Jul 2022 09:50:35 +0900
Message-Id: <20220705005035.14195-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmga578+Ekg4u7BC3a3y1jt5hxqo3V
        Yt+1k+wWv/6uZ7doXryezaJj62Qmix3Pz7Bb7PrbzGRxedccNosj//sZLRa0fGC1OHfyE6tF
        0599LBbXzpxgtbg9cTKjxfG14RabL31jcRD0mLem2uPCTm6PO9f2sHnsn7uG3aP/r4FH35ZV
        jB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM5YdfoqU8F6zor+1qmsDYzH2LsYOTkkBEwkLtzqBrK5OIQEdjBKzGn6zQaSEBL4
        xChxboUkROIzo8SEZy+YYDoaN4MUgSR2MUp8Or6ZEa7qVP9VFpAqNgEtiembtoB1iAhcYJS4
        9jwapIhZoIdJ4vel76wgCWEBO4nHX54BjeLgYBFQlTh2RwQkzCtgJXH753yo++Ql/tzvYYaI
        C0qcnPkEbD4zULx562xmkJkSAgs5JDrm90Gd5yLx7dJuVghbWOLV8S1Qg6QkXva3QdnFEm3/
        /jFD2BUSB/u+QNnGEp8+f2YEuYdZQFNi/S59iLCixM7fcxkh9vJJvPvawwpSIiHAK9HRJgRR
        oizx8tEyqAskJZa034Ka6CHRtH0xNERjJeYdPso0gVF+FpJvZiH5ZhbC4gWMzKsYxVILinPT
        U4sNCwzhkZqcn7uJEZyCtUx3ME58+0HvECMTB+MhRgkOZiUR3lWTDiYJ8aYkVlalFuXHF5Xm
        pBYfYjQFBu9EZinR5HxgFsgriTc0sTQwMTMysTC2NDZTEuddNe10opBAemJJanZqakFqEUwf
        EwenVAPTlJvrnh3X+KiuzSMX03zHXcdx+tTfzzWLb/HOzQjhDAzhXPnns1jnVgfb4FqmWda3
        eKZlphtMNLBxz50w4ddDRvedHwX25CYnnuhaFs5tzXHyoYKs21pDo9XTff+f3SHm0z65f1JJ
        lcmneW8Xx4clf5sjtd9spra5ZfScHg/mc8anLy5wj5V986RkyvePiWvPz7qVc1ZB2fS10+m3
        MzNN8/892HB3Y+3LFJ0bZvI/fu/I88pdt9X1wIycnPDLz6ewBtpqC0/L+l6d+3t+yS+pAyt2
        3Dl0614VyxePZKbp12fEHq1fnfZBIuDzXi21S8H7o3bKrFvxIe8H1yLpvJopZiu3hXpx6bwP
        /Tx13U/bAiWW4oxEQy3mouJEANJKKkRKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvK5b8+Ekg3MLDC3a3y1jt5hxqo3V
        Yt+1k+wWv/6uZ7doXryezaJj62Qmix3Pz7Bb7PrbzGRxedccNosj//sZLRa0fGC1OHfyE6tF
        0599LBbXzpxgtbg9cTKjxfG14RabL31jcRD0mLem2uPCTm6PO9f2sHnsn7uG3aP/r4FH35ZV
        jB6fN8kFsEdx2aSk5mSWpRbp2yVwZaw6fZWpYD1nRX/rVNYGxmPsXYycHBICJhKNm3+zdTFy
        cQgJ7GCU6J90gwkiISmx+NFDoAQHkC0scfhwMUTNR0aJM6dPgTWzCWhJTN+0hQkkISJwjVGi
        9WEn2CRmgRlMEo+Wb2UEqRIWsJN4/OUZ2CQWAVWJY3dEQMK8AlYSt3/Oh7pCXuLP/R5miLig
        xMmZT1hAbGagePPW2cwTGPlmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
        dxMjOC60tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeVZMOJgnxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXANI8pIV16pz17ncsmXa4jKRt+bl6q2GK1L1NCw+Lo
        UanzU7mOeDcn1k8Tja0MNTyQ/1XOmeNS04Mie5f/87S4zzlvr1fbtnlDqHmht8L6858uTrzb
        mVpUv8c4eo6e7v/qbzMfPZ9x51Ra/KRsTU1234wIoQqrwG+qs8o9bSOMH339+jJYSuXMvb0n
        vSYkzHpr9s4qlnuJb/dcyRPZi47aRS5c9/3mZ8cXR/SOPn7KmaF4kWuh2NvtGbs320tNuCCz
        mPW+a096Vezrsh37TQqSJIKWl5oecM+YmVvt7Lpd/khJwwqHUKZ5X9LOLjtz91JE9vxNBcy3
        FfLOHb0YWWLtea8sLy98QbZNy0x5Jv5HSizFGYmGWsxFxYkA0a46lPoCAAA=
X-CMS-MailID: 20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310
References: <CGME20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

