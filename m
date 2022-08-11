Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BD58FB94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiHKLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHKLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:46:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D23C61DB4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:46:19 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220811114617epoutp0437147186639a6fb50921eda908a93bb7~KR9Fva6Xm1124911249epoutp04W
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:46:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220811114617epoutp0437147186639a6fb50921eda908a93bb7~KR9Fva6Xm1124911249epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660218377;
        bh=rB/gvBVWvLIu7HTWugyowvJ5OV0wFMrOhW9GykTAGio=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kFS0oCoD1ksZ0slYKJntqgqjCc0D0elmzTRCs8PEKamLaGvWm5JbJxUVrPvZz/Ul1
         uElMII5ghgsEPwxg0H0S1a8mdwWdfFiMRlPbScjOltm71Zq28xvCM7vZtRw5vutFxJ
         oGSMvMha37n3AWpePQ+reA/dvSGqDSOPA4vUruPI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220811114616epcas5p20e860f87a13af8c89701ec6adc6df663~KR9FGbST72919329193epcas5p25;
        Thu, 11 Aug 2022 11:46:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4M3Q4Q6zByz4x9Pq; Thu, 11 Aug
        2022 11:46:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.E0.09494.60CE4F26; Thu, 11 Aug 2022 20:46:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811114614epcas5p29046e326acc8d13824479504e80a0d49~KR9Ch5Z822876028760epcas5p27;
        Thu, 11 Aug 2022 11:46:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811114614epsmtrp21b83be63e967a1317ab7235713d4ab3b~KR9ChF2911552215522epsmtrp2a;
        Thu, 11 Aug 2022 11:46:14 +0000 (GMT)
X-AuditID: b6c32a4a-201ff70000012516-a8-62f4ec06ca77
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.EF.08905.50CE4F26; Thu, 11 Aug 2022 20:46:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220811114612epsmtip133ef77525e3f653d6a0b4fbbe5ff0d4b~KR9BFqO4C3069330693epsmtip1N;
        Thu, 11 Aug 2022 11:46:12 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        chanho61.park@samsung.com, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] scsi: ufs: host: ufs-exynos: staticize fsd_ufs_drvs
Date:   Thu, 11 Aug 2022 17:05:50 +0530
Message-Id: <20220811113550.31914-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7bCmhi7bmy9JBotuGlk8mLeNzeLlz6ts
        FtM+/GS2uLxf26LvxUNmi02Pr7FaXN41h81ixvl9TBbd13ewWSw//o/Jgcvj8hVvjzvX9rB5
        bF5S7/Hx6S0Wj74tqxg9Pm+S82g/0M0UwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
        qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
        p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj+7mNbAXrOSre9LSyNjB+YOti5OSQEDCReDPz
        FVMXIxeHkMBuRokVXdcZIZxPjBKnHjyCcr4xSrz9spQFpmXN9sXsEIm9jBLXJu1mg3CamSQa
        zlxgAqliE9CWuDt9C5gtIpAicXX/T7AlzAKXGSX2zbkOlhAWcJHYsvcA0A4ODhYBVYmWm6Ug
        YV4BG4kH13qhtslLrN5wgBmkV0LgHLvEjyk9jBAJF4llk65C2cISr45vYYewpSQ+v9vLBjJT
        QsBDYtEfKYhwhsTb5euhyu0lDlyZwwJSwiygKbF+lz5ImFmAT6L39xMmiE5eiY42IYhqVYnm
        d1ehrpGWmNjdzQphe0js/QARFxKIldj5eTbLBEaZWQhDFzAyrmKUTC0ozk1PLTYtMMpLLYfH
        TXJ+7iZGcDLT8trB+PDBB71DjEwcjIcYJTiYlUR4yxZ9ThLiTUmsrEotyo8vKs1JLT7EaAoM
        pInMUqLJ+cB0mlcSb2hiaWBiZmZmYmlsZqgkzut1dVOSkEB6YklqdmpqQWoRTB8TB6dUA9Pa
        kM/buzSElOVqliRuyNwVcXDLXv5Da/auf998wzHJWvYK8/7H734e+7Xrir5bxvVE9om83U9r
        /5YKLdlzP2/OuilPD3H/2P+G5eCJc0m2V8wiGvp8JjzPrri0759eWnLC9Q4rh29mE686rmDP
        iAqSK86UaBR+ef7ILhEWtrXpXAwJ8udeyj8wOhU6R3unXnbe31+v4u8te2+q5sG4ysvU0WHP
        yc+WqudZmHftDVoxibfuld373c3h1oJs+Ze0pfyb7e/Z5L2oWS3W8jF78jmFYzGdPBoCMyv3
        C/+6WH5smseTE73lLjbLflol3ZlsIT/lyKTLL82e1TM+futygu1s3J09JindjOuCb+d3Xdig
        xFKckWioxVxUnAgAGWTPOe8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnC7rmy9JBj9XWlg8mLeNzeLlz6ts
        FtM+/GS2uLxf26LvxUNmi02Pr7FaXN41h81ixvl9TBbd13ewWSw//o/Jgcvj8hVvjzvX9rB5
        bF5S7/Hx6S0Wj74tqxg9Pm+S82g/0M0UwB7FZZOSmpNZllqkb5fAlfH93Ea2gvUcFW96Wlkb
        GD+wdTFyckgImEis2b6YvYuRi0NIYDejxO6WK8wQCWmJ6xsnsEPYwhIr/z2HKmpkkli+eT0T
        SIJNQFvi7vQtQDYHh4hAmsS3kyogNcwCtxkl1n34BLZBWMBFYsveA4wgNSwCqhItN0tBwrwC
        NhIPrvWyQMyXl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxggNO
        S3MH4/ZVH/QOMTJxMB5ilOBgVhLhLVv0OUmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FC
        AumJJanZqakFqUUwWSYOTqkGpiZ5g2Ut/ns2vG3K8rqmsfeooOwJRRVlsetvX6kdf3CwQ3/X
        1QvTsy3fGCzmuOg9c5nwQwMGnwwXjz8zi+/+j7br628uZ14hvXiSkkdBo0TPYlkDYakIj+3/
        /bgveXeefbW4mJ17lsmkvjC7G3ePbOM7nfZM3mUbn1bVtNLrhpWCJ5UuzV++p5RTiftBB+dU
        38wF9ws/nt32c82023MVdh380HNER3ryYcapbb0dx6WeLWP1mbL7e0OLLnfEVbsGRk1LyyPH
        3S9nOspsnm+VHlbR6WfzaVmo4fWMFa5ex434vYW4Pzs/e2NkeOrY1VnTywIZZki1PfrXeurw
        5sx/hlM4lGvVNHef23hk3SPbY0osxRmJhlrMRcWJAFjAtuenAgAA
X-CMS-MailID: 20220811114614epcas5p29046e326acc8d13824479504e80a0d49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220811114614epcas5p29046e326acc8d13824479504e80a0d49
References: <CGME20220811114614epcas5p29046e326acc8d13824479504e80a0d49@epcas5p2.samsung.com>
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

struct fsd_ufs_drvs is not used outside this file, so made it static.
This fixes sparse warning:

drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse:
symbol 'fsd_ufs_drvs' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 216f74e8059a ("scsi: ufs: host: ufs-exynos: Add support for FSD UFS HCI")
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index eced97538082..6cef19118e07 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1711,7 +1711,7 @@ static struct exynos_ufs_uic_attr fsd_uic_attr = {
 	.pa_dbg_option_suite		= 0x2E820183,
 };
 
-struct exynos_ufs_drv_data fsd_ufs_drvs = {
+static struct exynos_ufs_drv_data fsd_ufs_drvs = {
 	.uic_attr               = &fsd_uic_attr,
 	.quirks                 = UFSHCD_QUIRK_PRDT_BYTE_GRAN |
 				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
-- 
2.25.1

