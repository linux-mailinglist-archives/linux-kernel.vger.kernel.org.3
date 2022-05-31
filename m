Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA9538992
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiEaBYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiEaBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:24:06 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67AB9398B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:24:00 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220531012358epoutp041a1285dcd17864d9369a32d4afa0aac4~0DBL7sAIj0079000790epoutp04W
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220531012358epoutp041a1285dcd17864d9369a32d4afa0aac4~0DBL7sAIj0079000790epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960238;
        bh=2xE16+poKZUpsERnDutvCfBuUjpwTHNWmE5VdXCEg4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqsROXNI+RCIGnVUHoWkoQv5pz1R8Uv6n4ZWHWf6zX3UXGkLz/gllDtklQksqsf4O
         FVbXkLGJEQzh5hDVeekRnyhfgNWt4H3jvYlN/3zWK1iulaGJ9QDbrSH+0jZkAc3/ZL
         ZkIPki7b8lXaJG2SPW12VUpWINTYXCx2ipjl2h1Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220531012358epcas5p3685e4729902082b5850852db10707d3f~0DBLRBq3z3040830408epcas5p3_;
        Tue, 31 May 2022 01:23:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LBvgY2SDGz4x9QF; Tue, 31 May
        2022 01:23:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.6B.10063.82E65926; Tue, 31 May 2022 10:23:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531012351epcas5p389e28e28a48f9bb14a52fc81c417296d~0DBFJ4O6n0646106461epcas5p3N;
        Tue, 31 May 2022 01:23:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531012351epsmtrp24a38883a0858a38a80ae8d04b9a3152e~0DBFICmsI2336523365epsmtrp27;
        Tue, 31 May 2022 01:23:51 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-ae-62956e28cd72
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.E7.08924.72E65926; Tue, 31 May 2022 10:23:51 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012349epsmtip2131f8e569927d4ac937c103a6681b312~0DBC4b_bT0656506565epsmtip2R;
        Tue, 31 May 2022 01:23:48 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH 4/6] dt-bindings: ufs: exynos-ufs: add fsd compatible
Date:   Tue, 31 May 2022 06:52:18 +0530
Message-Id: <20220531012220.80563-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmuq5G3tQkg4ntohYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XDV+EWl3fNYbOYsOobi0X39R1sFsuP
        /2OyWLT1C7tF694j7BY775xgdhDwuHzF22PTqk42jzvX9rB5bF5S7/Hx6S0Wj74tqxg9/jXN
        Zff4vEnOo/1AN1MAZ1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QD0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9
        vNQSK0MDAyNToMKE7Iyuni3sBevYKpYvOsXcwLiFtYuRk0NCwERiQscE5i5GLg4hgd2MEm3H
        5rJDOJ8YJZZd74JyPjNKrFtwlR2mZe2hs0wQiV2MEgt7fkBVtTBJnDt3kw2kik1AW+Lu9C1g
        VSICzYwSBzt2gTnMAueYJJ7t3cAEUiUs4Coxe+4jFhCbRUBVYurO+WBxXgEbiY1Hz0OdKC+x
        esMBZhCbU8BWonvjabBBEgILOSRO9T9mgShykbjwcTOULSzx6vgWqGOlJD6/2wt0EgeQ7SGx
        6I8URDhD4u3y9YwQtr3EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEmBFGtKtH87irU
        ImmJid3dUFd6SExc9IIVEhATGCW6n75gnMAoOwth6gJGxlWMkqkFxbnpqcWmBYZ5qeXwqErO
        z93ECE6cWp47GO8++KB3iJGJg/EQowQHs5IIr1XE1CQh3pTEyqrUovz4otKc1OJDjKbAIJvI
        LCWanA9M3Xkl8YYmlgYmZmZmJpbGZoZK4rwC/xuThATSE0tSs1NTC1KLYPqYODilGpiU66/0
        3oip+iOip24Tzla2qLDNp+HBnIajQv+ubp7l963pts2Jy+9lKpI2z07eW/Vv/+Md/czqEon/
        f//jntDySnJanJnHyrrN2r85brTXVZoI1U6Xsot6LGcxMyPku98pxhlbml1333hYfrxVuM7u
        3PLXG5wDGx/GbKr95HSxLmD52pwDDU5dLCEV1rdyFt00uej3w2jDVBuTlnWCldHK7HM1VY59
        aF//U7uWWSJbmflYZ9j+f92PN612KFx7599Uh1s3LgcwPPrc8eDnkrL5O69Ofzdf1a/rx4Pe
        6QbzdpSb17yLnbvMNOkPq4XEfa6lMc+8JypM/D7pbHiIpFDeRFGRNyt2VV9WsElyeOCtxFKc
        kWioxVxUnAgA6oa5ByUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvK563tQkg/1XpCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzigum5TUnMyy1CJ9uwSujK6eLewF69gqli86xdzAuIW1i5GTQ0LARGLt
        obNMXYxcHEICOxglVqyayQ6RkJa4vnEClC0ssfLfczBbSKCJSWLPCk0Qm01AW+Lu9C1MILaI
        QDujxP3tbCA2s8AdJolVPSIgtrCAq8TsuY9YQGwWAVWJqTvng9XzCthIbDx6HuoIeYnVGw4w
        g9icArYS3RtPM0HsspF4fP81ywRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3
        MYLDXUtrB+OeVR/0DjEycTAeYpTgYFYS4bWKmJokxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC
        18l4IYH0xJLU7NTUgtQimCwTB6dUA1NpgGWTtfzNL1d2BjJ2lgvHTjbWyllz//e++9NX5Mc+
        U9PM/BwyTYfniI8Md+y382t7XvwyubL4w8nJ86Mnvfp2rdtbdv2H57dZd3KVHC39YW78ZmI1
        f9D1oJmMh1Uzyr+vSue26fCXiDdrTuTp9npzzc/0oub3zSoH1MNeHldI3dS+6MWJzQuvpzxz
        ELz+ONP5tXLaLgFxkfao6B8bD8+Yd6VxZfHSqwenm6dNTy3Z06J+SFV1suKuoBlLtwuus2Bb
        oHjvYUxi2yuuHWtTxc++vngi5UNK4QRVvcijcmr7JMOuTJFdMH12gf6NWbfmdTqprQ+Zsd7R
        vWx72DzDd9nLln0u231x89UEn6B5ObapSizFGYmGWsxFxYkAePRM4uYCAAA=
X-CMS-MailID: 20220531012351epcas5p389e28e28a48f9bb14a52fc81c417296d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012351epcas5p389e28e28a48f9bb14a52fc81c417296d
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012351epcas5p389e28e28a48f9bb14a52fc81c417296d@epcas5p3.samsung.com>
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

Adds tesla,fsd-ufs compatible for Tesla FSD SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index c949eb617313..2c715eec48b8 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -21,6 +21,7 @@ properties:
       - samsung,exynos7-ufs
       - samsung,exynosautov9-ufs
       - samsung,exynosautov9-ufs-vh
+      - tesla,fsd-ufs
 
   reg:
     items:
-- 
2.25.1

