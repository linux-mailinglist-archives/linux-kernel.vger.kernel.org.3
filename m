Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5131F58BE8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHHAnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHAnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:43:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59386658C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:42:57 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220808004255epoutp0118e32cbf2cbb93999f3ebf4b8dcef99e~JN_CRxcd02253922539epoutp01V
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:42:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220808004255epoutp0118e32cbf2cbb93999f3ebf4b8dcef99e~JN_CRxcd02253922539epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659919375;
        bh=sunQ4SmkLR5K3Io954QPWJRtsZKOFHaGeJrTKKpgmYE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eSaBfreUkMHMqFIRYRDR1gN24QkwzIK0xABNSKqqtk7ezAUA2u6ce1mjMOiEMI8xg
         Dv9/71P1c4ZCgeAv2kx2XIa5nY3jEWvQ3C7CJTU6sexs/z2pCfBQAZ9wBRsV/OX+QJ
         0ejld+f5HyisoDt6UAth7ophSBWFaZfvvWT4V8HY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220808004254epcas2p2f68217532a87c088a73a13a9a9477939~JN_BrYt9G1309813098epcas2p2N;
        Mon,  8 Aug 2022 00:42:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4M1HVQ1GlXz4x9Pv; Mon,  8 Aug
        2022 00:42:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.68.56487.E0C50F26; Mon,  8 Aug 2022 09:42:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a~JN_A0TSLj2512025120epcas2p3I;
        Mon,  8 Aug 2022 00:42:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220808004253epsmtrp2ef1a624a97b854b923a18a5676fc107d~JN_Azi4vo2154421544epsmtrp2j;
        Mon,  8 Aug 2022 00:42:53 +0000 (GMT)
X-AuditID: b6c32a46-e43ff7000000dca7-70-62f05c0ef823
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.31.08905.D0C50F26; Mon,  8 Aug 2022 09:42:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220808004253epsmtip2ea54f85bfe16342e1ee0db0896b88975~JN_AmGE1A1435014350epsmtip2K;
        Mon,  8 Aug 2022 00:42:53 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Adithya K V <adithya.kv@samsung.com>,
        kernel test robot <lkp@intel.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] spi: s3c64xx: correct dma_chan pointer initialization
Date:   Mon,  8 Aug 2022 09:48:51 +0900
Message-Id: <20220808004851.25122-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmmS5fzIckg71P2CwOTHjFavFg3jY2
        i8U/njNZTH0IFLu8X9ti7+ut7BabHl9jtbi8aw6bxYzz+5gsGj/eZLd41fyIzYHb4/qST8we
        i/e8ZPLYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QiUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ix/E9uYC1ZyVrx4uZelgfEDexcjJ4eE
        gInEtrcPWbsYuTiEBHYwSrS/fMAG4XxilPj54RwThPONUeLbhveMMC1zXh5ghEjsZZRY2rgT
        yvnIKLF6xhIWkCo2AV2JLc9fgXWICFRJzHz+hhmkiFlgKZNEW+clNpCEsICbxK6fr5lBbBYB
        VYmpX5eD2bwCdhJNt5ezQKyTl7h+sw0qLihxcuYTsDgzULx562ywoRICX9klmq59Z4VocJHY
        OHkLlC0s8er4FqhXpSQ+v9vLBmEXSyyd9YkJormBUeLytl9QCWOJWc/agc7mANqgKbF+lz6I
        KSGgLHHkFtRePomOw3/ZIcK8Eh1tQhCN6hIHtk+HOllWonvOZ6gLPCQufrgHFhcSiJX42tbO
        OIFRfhaSb2Yh+WYWwt4FjMyrGMVSC4pz01OLjQqM4NGanJ+7iRGcTrXcdjBOeftB7xAjEwfj
        IUYJDmYlEd4ja98nCfGmJFZWpRblxxeV5qQWH2I0BYbvRGYp0eR8YELPK4k3NLE0MDEzMzQ3
        MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAxDeHU9IxW1Epa7vLvJSjrtZqTh83bP9S
        mGI6eQrvixO/uqY3Rs16teKezvGpMTndsxh8VTTk+iRyJk29u+nQ38YLeiq+Fy4WZCrdKjl6
        LeV3cVfnY60YN83WPLePLz9qvXRg/77P9FjTm617JBnM+4P7lctXLD1XUah04b4IS+XqJdUb
        D61nT0usYtj+sJ8rl+G0XA5jSQOjraGl/wy3tZGcu7K6mwyFJkfemayrUm18r2Cn1Wz/7KbW
        tLJUtQ3ihyNWKIdcLHXZmm84d/2dTR91ffcqrYj6JPNpovC1q5tmaUYJV97S/P3LmWl3/se4
        FepBzoq3VW7a+U9dWZP7XEr6hvkqfoPXuvzazBpKLMUZiYZazEXFiQAEBAjpMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvC5vzIckgxvnNSwOTHjFavFg3jY2
        i8U/njNZTH34hM3i8n5ti72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPd4lXzIzYHbo/rSz4x
        eyze85LJY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBn/JrYxF6zk
        rHjxci9LA+MH9i5GTg4JAROJOS8PMHYxcnEICexmlGg7tIsJIiEr8ezdDqgiYYn7LUdYIYre
        M0psX9bGDJJgE9CV2PL8FSOILSJQI3HmwlWwScwCq5kkLl1/wAaSEBZwk9j18zVYA4uAqsTU
        r8vBbF4BO4mm28tZIDbIS1y/2QYVF5Q4OfMJWJwZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0o
        zk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5wLc0djNtXfdA7xMjEwXiIUYKDWUmE98ja90lC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MBnH9XikvPA9
        3/B4S+ltmY4Sn1VcKc+vm9+ZMUer8WOqbrfIgv5PK58z/TH4XbRVcF5i2fKp68Uevzscc+Ai
        Q+Wv+4oiNU4/nx88cbBZ/Nedq+x9j32XXDnosTsqf9fq1KRtPjFX3z5ZlWMcPP0rR5/P7txD
        5w81uMpWf8lPT8s0VObgsjylExC78Niz/Md62j2rTY19BPRU2h4kXDWwcNNdH7PRq3fKpw5L
        zW9uXeK1UWXXeXJFO0JzQ+rzv3U3OSWcmLPk0CzBO/e7mRyrj7Zte+Cw1sWvNHdjMmvPlyy/
        LfPO6dr83bxu80n7b2+3ZFrddXZffHcKC6/h0ZyZ8zmmK6zyn+B8XKdJXqA0SImlOCPRUIu5
        qDgRAOWgJsDfAgAA
X-CMS-MailID: 20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a
References: <CGME20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a@epcas2p3.samsung.com>
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

Use NULL for dma channel pointer initialization instead of plain integer.

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain integer as NULL pointer
   drivers/spi/spi-s3c64xx.c:388:34: sparse: sparse: Using plain integer as NULL pointer

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 82295bc0d192 ("spi: s3c64xx: move dma_release_channel to unprepare")
Fixes: f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only during data transfer")
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f346866614a..651c35dd9124 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -389,8 +389,8 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		dma_release_channel(sdd->rx_dma.ch);
 		dma_release_channel(sdd->tx_dma.ch);
-		sdd->rx_dma.ch = 0;
-		sdd->tx_dma.ch = 0;
+		sdd->rx_dma.ch = NULL;
+		sdd->tx_dma.ch = NULL;
 	}
 
 	return 0;
-- 
2.37.1

