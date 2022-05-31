Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4927F53898D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbiEaBX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiEaBXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:23:51 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9765939B2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:23:49 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531012343epoutp0139e5c566e831bd16f8d4d1fbb012a28a~0DA91mhP60723707237epoutp01v
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:23:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531012343epoutp0139e5c566e831bd16f8d4d1fbb012a28a~0DA91mhP60723707237epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960223;
        bh=KRiBFoUJPi0jSgx+KIo5YuIoLsWXGu1S1vDlyCfLPMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnCqGwjrvpU/TWZURZRaqlwuIeqe9jT41i/3cnjMRBAOR8OiY+Oas6MeN6n/QoN1Y
         VVM6+nZuzXsLvNH0knmPUEUJNadrohWCZrNURtp5du7eMlwTgUVGvOngdenn7BfUs7
         chqQBrbujN2n22jW5VMGxPEoP+KoMncukrcvQUZo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220531012342epcas5p3bebb2857575ff25f06a659e44e6c8a3e~0DA9C1NNp3040830408epcas5p3J;
        Tue, 31 May 2022 01:23:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LBvgD5k6Bz4x9Pq; Tue, 31 May
        2022 01:23:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.F5.09762.81E65926; Tue, 31 May 2022 10:23:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437~0DA29WR-E3089130891epcas5p27;
        Tue, 31 May 2022 01:23:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531012336epsmtrp1cbdf33c2e8f1e6af9a1bd3613e43094b~0DA28YUZp1404214042epsmtrp1L;
        Tue, 31 May 2022 01:23:36 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-97-62956e18e258
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.D7.08924.81E65926; Tue, 31 May 2022 10:23:36 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012333epsmtip25b80ec45fbb45fdb9cc2f1be95f565f0~0DA0jejt01198911989epsmtip28;
        Tue, 31 May 2022 01:23:33 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Date:   Tue, 31 May 2022 06:52:15 +0530
Message-Id: <20220531012220.80563-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTS1cib2qSwdGlWhYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XDV+EWl3fNYbOYsOobi0X39R1sFsuP
        /2OyWLT1C7tF694j7BY775xgdhDwuHzF22PTqk42jzvX9rB5bF5S7/Hx6S0Wj74tqxg9/jXN
        Zff4vEnOo/1AN1MAZ1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QD0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9
        vNQSK0MDAyNToMKE7Iztc/YyFcxkq1h217eBcSFrFyMHh4SAicTdGapdjFwcQgK7GSWe/Gti
        7GLkBHI+MUosOGoJkfjMKPHvxhVWkARIw8qLaxkhErsYJd60/2KD6Ghhkth/LB/EZhPQlrg7
        fQsTSJGIQDOjxMGOXWAOs8A5JolnezcwgVQJC9hL7N31A6ybRUBVYsfZU2AreAVsJB696WaD
        WCcvsXrDAWYQm1PAVqJ742mwQRICCzkkru1ZyAjxhIvEh5nBEPXCEq+Ob2GHsKUkXva3sUOU
        eEgs+iMFEc6QeLt8PSOEbS9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJKdLQJQVSrSjS/
        u8oCYUtLTOzuhoaJh8SFd9eZIWEygVHi16NTzBMYZWchTF3AyLiKUTK1oDg3PbXYtMA4L7Uc
        HkvJ+bmbGMHpUst7B+OjBx/0DjEycTAeYpTgYFYS4bWKmJokxJuSWFmVWpQfX1Sak1p8iNEU
        GGITmaVEk/OBCTuvJN7QxNLAxMzMzMTS2MxQSZxX4H9jkpBAemJJanZqakFqEUwfEwenVAPT
        At8HrD2CwU/m7268VvNLLpE7IrS5s6Yg/r3nsyXOZVlPOZjPLMgQ/5JnnjndcZ7Ppvmawjde
        xju5hu1/tbFyjWTKR58jX6JkeDg1NksdCLxwvfxcY875Hc8yxNKzf/1JrF0s1rZc1cSlddGn
        xoKvQTy7DSU3FBeuWTRZ4PqtnyWL5vw/ycTTviGJTW/pwa8bAvbWL99cwXzuVYfJtT18UzwK
        HHxCmjl4u1602pSuuRmvwK7hcyGA1eOEqMi2Ly7TPjAUCrw14Dfav1qYOy7kJhPnBdYoqeiy
        Xct8Z95eFjZzJps+W619yGe2T1/X+97ujvy2I9D8VuWB8B9PLv9TKf9ruvnQiu2VJnaPXigr
        sRRnJBpqMRcVJwIAMgs46CAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvK5E3tQkg/9neS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzigum5TUnMyy1CJ9uwSujO1z9jIVzGSrWHbXt4FxIWsXIyeHhICJxMqL
        axm7GLk4hAR2MEp8u7OaCSIhLXF94wR2CFtYYuW/5+wQRU1MErdu/WEGSbAJaEvcnb4FrEFE
        oJ1R4v52NhCbWeAOk8SqHhEQW1jAXmLvrh9gcRYBVYkdZ0+BbeYVsJF49KabDWKBvMTqDQfA
        ZnIK2Ep0bzwNNlMIqObx/dcsExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93E
        CA53La0djHtWfdA7xMjEwXiIUYKDWUmE1ypiapIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
        J+OFBNITS1KzU1MLUotgskwcnFINTCLmM1UDVqcuf5M0yY3t/z2zaxVKh68n3FMtbuO6IX5d
        e7tCof3cFefueho9tKj6Jdlb/UBH6K0cN//HjX2L7B/eWr2mXvcPj7Tb3B37Xk1hq1l26mFp
        1E7himszW62mnPKxWMf89wp38L6bcjvXT9B9FSjI4/6w8gvHkW+ZW/wn69cc3xy4OSDn/vTQ
        AJXjPsy5QrfN0oQXzNU9+/itgMnJ4y8iXnDzt9fWFBzNmje5Lbm9yVC3zp5hBo/QIzOdzD3N
        v+43O/S2nXx0xljjz7Lm3eZ3/vr8SXrauMAqNbqgd47n6+B7xYkHCw5rzuVJiW5jXLh4xiG/
        LRHaG8L3zhcqYi5d0PzzUc2pNdOW/1JiKc5INNRiLipOBABXRorE5gIAAA==
X-CMS-MailID: 20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds tesla,fsd-ufs-phy compatible for Tesla FSD SoC

Cc: linux-fsd@tesla.com
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index f6ed1a005e7a..ee354bf37c64 100644
--- a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - samsung,exynos7-ufs-phy
       - samsung,exynosautov9-ufs-phy
+      - tesla,fsd-ufs-phy
 
   reg:
     maxItems: 1
-- 
2.25.1

