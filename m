Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522C754646A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348696AbiFJKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348798AbiFJKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:25 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A222235B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:43:49 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220610104348epoutp04823f29c5cc93410c9755e76de0bfdddd~3PG1SpPQk0352403524epoutp04O
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:43:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220610104348epoutp04823f29c5cc93410c9755e76de0bfdddd~3PG1SpPQk0352403524epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857828;
        bh=FC5Zvuqj+9I9IJqzAfeb16koBccPnJdOCKiB9rYr+kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaZpsAMTQeeeFzSCotI85ZV2GLNlWBzcSqiA/LGGwKd4PX0SQWihePsFs/Us1APRe
         2oyUsHAD3LYIxpC38Yq1h31guv/doKVtwSb/689SX29Wq+W9UqbUI2lSzXnqoQzFyO
         SA1rr+6wHX1Cn7Ov3qPrpnYiAlK+AcxExx8XvfHg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220610104347epcas5p29fe54d448eb59ceef54e85c3d3b66f37~3PG01dkcb1441714417epcas5p2E;
        Fri, 10 Jun 2022 10:43:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LKHcw3p6jz4x9Q1; Fri, 10 Jun
        2022 10:43:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.C8.09827.06023A26; Fri, 10 Jun 2022 19:43:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220610104343epcas5p3f9f61a6c66cf52c203b29c2af376dfc3~3PGwnPUfv2015320153epcas5p3E;
        Fri, 10 Jun 2022 10:43:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104343epsmtrp1247ecf2c7ed8749d2bc75ff56a9803bd~3PGwl-h941337313373epsmtrp1N;
        Fri, 10 Jun 2022 10:43:43 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-df-62a320600a84
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.4D.08924.F5023A26; Fri, 10 Jun 2022 19:43:43 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104341epsmtip1534a6230ba04c656f7b625cd7bd3530b~3PGuo8egm0758907589epsmtip1g;
        Fri, 10 Jun 2022 10:43:41 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v4 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Date:   Fri, 10 Jun 2022 16:11:14 +0530
Message-Id: <20220610104119.66401-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTSzdBYXGSwb9WCYsH87axWbz8eZXN
        4trLC+wW0z78ZLa4vF/bYv6Rc6wWfS8eMltsenyN1eLyrjlsFhNWfWOx6L6+g81i+fF/TBaL
        tn5ht2jde4TdYuedE8wO/B6Xr3h7bFrVyeZx59oeNo/NS+o9Pj69xeLRt2UVo8fnTXIe7Qe6
        mQI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ/yf0cJacIWtYuor3wbGG6xdjJwcEgImEgu7FzB1MXJxCAnsZpTYd+wtM4TziVHi88bJ
        UJnPjBL9T06wwbT0T/7NApHYxSix5PsCdginhUli57mPzCBVbALaEnenbwFrFxFoZpQ42LEL
        zGEW2MkkcfH3dKAqDg5hASeJb8sEQRpYBFQlPj+9AdbMK2AjsevVCqh18hKrNxwAi3MK2Eo8
        W3+ZFWSOhMBMDomT7z9DFblInOvdzwhhC0u8Or6FHcKWknjZ38YOsktCwENi0R8piHCGxNvl
        66HK7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3d0HD0
        kFh5qxkaKBMYJT5M72ebwCg7C2HqAkbGVYySqQXFuempxaYFRnmp5fCISs7P3cQITpFaXjsY
        Hz74oHeIkYmD8RCjBAezkghvwO1FSUK8KYmVValF+fFFpTmpxYcYTYFBNpFZSjQ5H5ik80ri
        DU0sDUzMzMxMLI3NDJXEeQX+NyYJCaQnlqRmp6YWpBbB9DFxcEo1MG3YsdWwZbpPW3TyfLXK
        jNg75pGp6TaTarWNYharzt8pWZrT81tAPcZ/y3u275nP9ZmFTs5tLPomJPl4k9zxK8Xi01ae
        tHqQbza99TqrW/EWw1s3z+fveOJ4fNffo9EVmysluD/Z/jnKb/rYScb3woGVogt/Gkxi33Ne
        1q2/vSPmeeBGZbEL/vNrZb8/rDj2aM/CGwtsyn+e2alZJPguw83rQ2Bz5OwZsvN+Lnx9c4NZ
        bOyFu1My9kydbXmXwcssxbyCxTpMf5ey1YldoSztkbuPCnnkzM5vmbeIZ966as1Vl8JWshzd
        /23Cx+zJu4/pHI+5xtqUtPRIdaJjsv2hxyGZF967lRmvdNETe6RQsEeJpTgj0VCLuag4EQAL
        A/dCGgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG68wuIkg49neCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DK+D+jhbXgClvF1Fe+DYw3WLsYOTkkBEwk+if/Zuli5OIQEtjB
        KPFg+zImiIS0xPWNE9ghbGGJlf+es0MUNTFJfLu8kBkkwSagLXF3+hawBhGBdkaJ+9vZQIqY
        BY4ySSw/dQyoiINDWMBJ4tsyQZAaFgFVic9Pb4D18grYSOx6tYINYoG8xOoNB8DinAK2Es/W
        Xwa7TgioZnHHOeYJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB7eW1g7G
        Pas+6B1iZOJgPMQowcGsJMIbcHtRkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNL
        UrNTUwtSi2CyTBycUg1Mmy8tNFppueys1EVm77C6O2vN5nDvnZuzL/p8Qf+1rDCVlrUaD0Wj
        8itn8rI8fswRvv4OX0zp7J5F79KiLxgXf/lxdsqGTqec5IWrHu1hvBX57biQn/Lh53dnr21Z
        tOrhnU9nbTNWyooxP1jccVXg9GbFeU98rlcHL41xvFJ3yp7pjLKl9rt7/54fWnbIJ5Ll9P+0
        85flb92+9/SW8dfHetyMvSeeGxWztxlWnZ1zdiH3ihOWwma+ZzJvbuhh60nNal9RlXuueo6w
        k+26VSxP97a990pbejzm/0ZzjQST9HQpLZZZJbx9gWKBC6TCTkWtnfZwfsPlZNe6bQwVKXN3
        X/wTvPmUiumZ2yeTLdMuOSuxFGckGmoxFxUnAgABfH9j3QIAAA==
X-CMS-MailID: 20220610104343epcas5p3f9f61a6c66cf52c203b29c2af376dfc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104343epcas5p3f9f61a6c66cf52c203b29c2af376dfc3
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104343epcas5p3f9f61a6c66cf52c203b29c2af376dfc3@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tesla,fsd-ufs-phy compatible for Tesla Full Self-Driving (FSD) SoC.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index 17897a3b5c9e..8da99461e817 100644
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

