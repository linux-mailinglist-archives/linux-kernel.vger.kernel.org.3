Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C665579143
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiGSDWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGSDWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:22:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892A1D33E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 20:22:47 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220719032245epoutp0367a3f4a91b74b8f11926e97bee1c148f~DHP4tElzD2652726527epoutp03h
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:22:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220719032245epoutp0367a3f4a91b74b8f11926e97bee1c148f~DHP4tElzD2652726527epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658200965;
        bh=IzTJpwJDmv27DqFGcnFFbEYZnoox6AVDGRsU60ndVjo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uG+RwI5Ah84UVp9qoABeqq89Rj8RILsW3mx+QJzCt/geiXOEfz3oLdax4PLuJUwTy
         jb29AFiZqsRnW+IbdYnnIw+lSELevo39YfaBjogpoQSq0i59JL6o0TZDL7fBeVCt2X
         2f44hw6BGziG90VK0sWBGPUsdLxq5m1NjkFCly5g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220719032245epcas2p3d8a3b56c6ab395ab60af935c568da7a8~DHP4KaA_v2625426254epcas2p3A;
        Tue, 19 Jul 2022 03:22:45 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ln4044cxXz4x9Py; Tue, 19 Jul
        2022 03:22:44 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.1D.09662.48326D26; Tue, 19 Jul 2022 12:22:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220719032244epcas2p4c19ed1bf1d319f29a022c8fd08ce0b89~DHP3DuZ051547815478epcas2p4e;
        Tue, 19 Jul 2022 03:22:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220719032244epsmtrp2cbc96c070150c188939ead30115b9fea~DHP3CrY1J0059800598epsmtrp2E;
        Tue, 19 Jul 2022 03:22:44 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-ef-62d62384f82c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.ED.08905.38326D26; Tue, 19 Jul 2022 12:22:43 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220719032243epsmtip2614be6c05668aff40dca0d513803ad7c~DHP21X6Y-1639716397epsmtip2e;
        Tue, 19 Jul 2022 03:22:43 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: enable link lost interrupt
Date:   Tue, 19 Jul 2022 12:19:38 +0900
Message-Id: <1658200778-90373-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmmW6L8rUkgxkrFC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3J4uaWoywWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsWB12PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYA9KtsmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xsbJnawFp9kr
        jl7YzdzAuJSti5GTQ0LARKLhwiZmEFtIYAejxK4TAV2MXED2J0aJi9fPs0I43xgljr6ZDtTB
        AdZx8nI1RHwvo8Thle0sEN0/gDq+84PYbAKaEk9vTmUCKRIRWMkkcePVMiaQBLOAusSuCSfA
        bGEBS4kLl46zgAxlEVCV2HnWCCTMK+AqcebPXEaI6+Qkbp7rZAaZIyHwkl3i/P1OqLNdJLav
        62CHsIUlXh3fAmVLSXx+txfq0GKJTfvkIXobGCWWfNrMAlFjLDHrWTsjSA0z0KHrd+lDlCtL
        HLnFAnEln0TH4b/sEGFeiY42IYhGZYlfkyZDXSYpMfPmHailHhIzJ59hhIRCrET33s9sExhl
        ZyHMX8DIuIpRLLWgODc9tdiowAQeQ8n5uZsYwclPy2MH4+y3H/QOMTJxMB5ilOBgVhLhFam9
        nCTEm5JYWZValB9fVJqTWnyI0RQYWhOZpUST84HpN68k3tDE0sDEzMzQ3MjUwFxJnNcrZUOi
        kEB6YklqdmpqQWoRTB8TB6dUAxN/hfSebuNGvbvLOcMX5WWE7gvpXTJrTcAl3bMr+UK43j97
        G1FblbK09YQkg9clSyad/3vMdW63z/1oMlM48Nb1d18299QWpKjNktyTq7d47or6sBWT9bvn
        1H7L887btaZ7v++87FNn5P84/2n1P/Z62XfZmXGvV80PNb/8kjH6BedT/l35taZ5BtO8JnbZ
        RdjOVVFWErr/fsfMntI87cMvj87jmCpz+FHWCVMXd+Fmo03dHxlb1yk/uhqb+Mh5+yK3WA9r
        oW/CxmKOVxaeV3VI2sMwt3M931qL1+1M/g+31E2TCrFOmF/BKlh1qfqvYvH65fPEolUUF5wJ
        u3foxxHv2aGxEwvSd64y0b98foUSS3FGoqEWc1FxIgB3Is1VBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvG6z8rUkgxnPLS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3J4uaWoywWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsWB12PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYA9issmJTUnsyy1
        SN8ugStj4+RO1oLT7BVHL+xmbmBcytbFyMEhIWAicfJydRcjF4eQwG5GidWHNjJ2MXICxSUl
        Tux8DmULS9xvOcIKUfSNUeLdlKnsIAk2AU2JpzenMoHYIgLbmSR+fUwDsZkF1CV2TTgBFhcW
        sJS4cOk4C8gyFgFViZ1njUDCvAKuEmf+zIWaLydx81wn8wRGngWMDKsYJVMLinPTc4sNCwzz
        Usv1ihNzi0vz0vWS83M3MYJDUktzB+P2VR/0DjEycTAeYpTgYFYS4RWpvZwkxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5PR+VB9xm2VLz85Tzd9LlOi
        5dKzZs36nhvuNe/8DplpGDhJHouQlrsceIL9bOPb1OiWeTqduz7EpQWz7hP/H6pxlcUqgE1M
        vSjN1ktlzk2WxKwZ+kGuQdorxXxS1oXxR9WsCj+QmVpzOu1r73f5vD+SLp//WDJn/70Yzy77
        WXrTX7bwwhbGbBMl+5bu2YVpt5v+9S1nnmVjc0J/cdPlb5or+D/2Jj56LySy6f8plg+/7IWy
        VJpX7lmnw3/r+paFU6a7nXgwcZWaZH/8xyULtM4dWOS25bJTu/AdgSOZB/V+mwdlz+LsWLZ/
        hUypemWlfrr9Tu7qXSGsM/dv9l1YHcmmvMzQmc14rfK6dau0lViKMxINtZiLihMBiqI4c7gC
        AAA=
X-CMS-MailID: 20220719032244epcas2p4c19ed1bf1d319f29a022c8fd08ce0b89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220719032244epcas2p4c19ed1bf1d319f29a022c8fd08ce0b89
References: <CGME20220719032244epcas2p4c19ed1bf1d319f29a022c8fd08ce0b89@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link lost is treated as fatal error with the following
patch, but its event isn't registered as interrupt source,
so I enable it.
--
scsi: ufs: Treat link loss as fatal error

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshci.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index a7ff0e5..0b627f4 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -133,11 +133,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 
 #define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
 
-#define UFSHCD_ERROR_MASK	(UIC_ERROR |\
-				DEVICE_FATAL_ERROR |\
-				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR |\
-				CRYPTO_ENGINE_FATAL_ERROR)
+#define UFSHCD_ERROR_MASK	(UIC_ERROR | INT_FATAL_ERRORS)
 
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-- 
2.7.4

