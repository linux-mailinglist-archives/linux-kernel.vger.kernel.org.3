Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B013450DF68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiDYLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiDYLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:53:07 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21A17062
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:50:02 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220425114959epoutp04c5ad3da05c09d8f5772cc21f49a943bf~pIVe6fLEW0546705467epoutp04f
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:49:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220425114959epoutp04c5ad3da05c09d8f5772cc21f49a943bf~pIVe6fLEW0546705467epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650887399;
        bh=sUiGPdboIm0n9JE+a5AknBqOxrxP+deT9IxAdCX8Ms4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NewuoZaNh4rDjj79o19IFGSQdhfoXOs77QOMFepOPJrONT2iqZ/5Et2hP/1aqc97w
         +oO4DCyOnKtp6gV1En64+kbsZal/HTu+pFr+ECdUp71ljmP+uDoMNYl2gkWEi7S6FV
         hiw73WD9qlFNWTO7HSFWjQw6xrTw0PJZYsUsZU5U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220425114957epcas2p21761ee232f813ced9bb3918adaabc32e~pIVdYSt1N2588525885epcas2p2T;
        Mon, 25 Apr 2022 11:49:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Kn3GX1FwQz4x9Pt; Mon, 25 Apr
        2022 11:49:56 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.2B.10069.3EA86626; Mon, 25 Apr 2022 20:49:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220425114955epcas2p331be3ef61616c06974e3e9c6448e6394~pIVbd-i0P1101611016epcas2p3J;
        Mon, 25 Apr 2022 11:49:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220425114955epsmtrp2da15d0a72edce5f4129a3c766c208650~pIVbdQK1O2638226382epsmtrp25;
        Mon, 25 Apr 2022 11:49:55 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-77-62668ae36052
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.EC.08853.3EA86626; Mon, 25 Apr 2022 20:49:55 +0900 (KST)
Received: from KORCO044084.dsn.sec.samsung.com (unknown [12.36.162.129]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220425114955epsmtip2c2d5a13b2848694da86a555403c60664~pIVbKrAql2780427804epsmtip2D;
        Mon, 25 Apr 2022 11:49:55 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jeongtae Park <jeongtae.park@gmail.com>,
        Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: cache: set max_register with reg_stride
Date:   Mon, 25 Apr 2022 20:46:11 +0900
Message-Id: <20220425114613.15934-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTXPdJV1qSwb+VzBZTHz5hs1h3bgaL
        RfPi9WwWZ86+ZLU4svYqk8XlXXPYLOZ+mcrswO6xc9Zddo9NqzrZPPbPXcPu8XLibzaPvi2r
        GD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVo
        YGBkClSYkJ2xduJPtoIZ7BXbXr9ibWDsYOti5OSQEDCROHHrNksXIxeHkMAORomuuxOgnE+M
        Es3z/0I53xglnv55Dtfyv2ETK0RiL6NE68pT7BDOX0aJC/37mUCq2AS0JKbPbGAFsUUElCWu
        ft8LNopZoJVJ4kvXRUaQhLCAg8STuRuZQWwWAVWJQ03HgZo5OHgFLCWOLvGC2CYvMfPSd3YQ
        m1dAUOLkzCcsIDYzULx562xmkJkSAtfYJU7NfwZ1novEvCWL2SFsYYlXx7dA2VISn9/tharJ
        l7jS/4YFormBUeL67ZlMEAljiS1zT4EdwSygKbF+lz6IKQH0wJFbUHv5JDoO/2WHCPNKdLQJ
        QTQqScxbOo8ZwpaQuDR3CzNEiYfEhfWaIGEhgViJncda2Scwys9C8swsJM/MQli7gJF5FaNY
        akFxbnpqsVGBITxSk/NzNzGCk6OW6w7GyW8/6B1iZOJgPMQowcGsJMI7VTUtSYg3JbGyKrUo
        P76oNCe1+BCjKTB0JzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC
        1CKYPiYOTqkGpqMC3+rmi6Z9M1FUVG6QXj93x1qRx/MeRjU//hQx+1mSypfMHZ1Vszn2qYd9
        1F0wJ1vxdlalTVy2In9rffqjTJ4Pgvdfp0TbPSksEXxTNSv5y+ZwE5aMpFBb08NVL2ybluy3
        +LrwjWPIpkQNvlDnsDbvM8Z3PxQFbpoSVDfn6PUaAZM5txxMvc2nPFh/zevt/7BfM5UbJQy0
        Xuce7pn4JL9174b9VcIHQhYUPk9bXPjir9eqBeUKZbYcPDO2CuSsK78fce30m7tx6kH3Mzk9
        Ev/w2V+xNt7+fGGP1Lx3L089DPzhkyJ4pfbwWxXRtisWT7UlVoT1P1k0zTrgykmP5tC+Ov5A
        i5dHdDPFdNr5lViKMxINtZiLihMBsqLwARcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO7jrrQkg4YzfBZTHz5hs1h3bgaL
        RfPi9WwWZ86+ZLU4svYqk8XlXXPYLOZ+mcrswO6xc9Zddo9NqzrZPPbPXcPu8XLibzaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgylg78SdbwQz2im2vX7E2MHawdTFyckgImEj8b9jECmIL
        CexmlFj4rAwiLiGxfMMLJghbWOJ+yxGgGi6gmt+MErNmnGQBSbAJaElMn9kA1iwioCxx9fte
        sDizQCeTxJXOKBBbWMBB4sncjcwgNouAqsShpuNAQzk4eAUsJY4u8YKYLy8x89J3dhCbV0BQ
        4uTMJ1Bj5CWat85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmb
        GMHBqqW5g3H7qg96hxiZOBgPMUpwMCuJ8E5VTUsS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh
        62S8kEB6YklqdmpqQWoRTJaJg1OqgUmNXSfoDl/VuQWGu0+8W28mm721cuWiYIuTTr+7Z/ae
        X6/35Gx27o8ZuUwipk4xv/yXLLJl7Fj4KWNaxs1VnJ9FtS1mFfg2RX/0PdXF4PRPbZ1s/a1/
        /BJttbNPR+8We7Gxtjjqee07kRk3FjtNF/PlShRyzX57V926zSTbTndv5nKT9d/Vk0r2T0ie
        J2FoFnCiszp8XVXsvKW7fj5enqHeEeEnKhbEzXrM78j8KW/5Z62w+fpu/cNN8T/P+eTah6Zk
        Pfu9NLiEa5PKR2PNx/+cJlt47WDeUH0lVaCmV2jGHtmzTG/ucj0vXd/Nm7FRMG0/64bPq7Qz
        trgva5u2b/OWlMm/VufX5M2OKvIoilJiKc5INNRiLipOBAAjFfRyxQIAAA==
X-CMS-MailID: 20220425114955epcas2p331be3ef61616c06974e3e9c6448e6394
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220425114955epcas2p331be3ef61616c06974e3e9c6448e6394
References: <CGME20220425114955epcas2p331be3ef61616c06974e3e9c6448e6394@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current logic does not consider multi-stride cases,
the max_register have to calculate with reg_stride
because it is a kind of address range.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/base/regmap/regcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index f2469d3435ca..d0f5bc827978 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -183,8 +183,8 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 			return 0;
 	}
 
-	if (!map->max_register)
-		map->max_register = map->num_reg_defaults_raw;
+	if (!map->max_register && map->num_reg_defaults_raw)
+		map->max_register = (map->num_reg_defaults_raw  - 1) * map->reg_stride;
 
 	if (map->cache_ops->init) {
 		dev_dbg(map->dev, "Initializing %s cache\n",
-- 
2.25.1

