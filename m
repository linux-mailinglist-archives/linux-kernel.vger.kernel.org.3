Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDCE587524
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiHBBqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiHBBp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:45:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64C27CC7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:45:56 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802014555epoutp018d58fefe8c120ff1466d74c435d4d360~HY9U0FY7d2943429434epoutp01I
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802014555epoutp018d58fefe8c120ff1466d74c435d4d360~HY9U0FY7d2943429434epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659404755;
        bh=Q956tALq6kvKLNuJeQDGrC56P4MalXRdUlX1/LqVvak=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KA2BJdFdnoLMt9bbjwLUTPpFDnosmIre/nkOmhn/T1MC4Gs/BTxdeIJC1BaXqppd0
         T09HXX+7YgMwnYSDiqh7qNbt5Vs4hpBZbPeRlmuSkFDhM3+9EyqPi40kDuMe2fsMmE
         N9M/vsVI8DQGheCBHPm9RRKwdZl0Xc58hXu/Qr2c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220802014554epcas2p47d16d5368e5966106ba33ca66ee34592~HY9UE2u9Y1398513985epcas2p4X;
        Tue,  2 Aug 2022 01:45:54 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lxd9s2drKz4x9Q2; Tue,  2 Aug
        2022 01:45:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.95.09662.1D188E26; Tue,  2 Aug 2022 10:45:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220802014552epcas2p236519c03464ab32d9a877887710b1c10~HY9SxpeNi2956229562epcas2p2I;
        Tue,  2 Aug 2022 01:45:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220802014552epsmtrp25687b3c86d3a62cbba76d37917a81bdb~HY9SwrOih0405604056epsmtrp2m;
        Tue,  2 Aug 2022 01:45:52 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-78-62e881d1a865
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.94.08905.0D188E26; Tue,  2 Aug 2022 10:45:52 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220802014552epsmtip2b6e0a15be128dbf8bcbe0afe2596aea2~HY9ShJ_Sg2693826938epsmtip2B;
        Tue,  2 Aug 2022 01:45:52 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2] scsi: ufs: enable link lost interrupt
Date:   Tue,  2 Aug 2022 10:42:31 +0900
Message-Id: <1659404551-160958-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmhe7FxhdJBtOfCVicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8fiPS+ZPCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7VLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtC5SgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjB13HrIXfGWv
        WDvjBnsD41G2LkZODgkBE4kXDeeZuxi5OIQEdjBKvPx3jAkkISTwiVHiSH8whP2NUaJ3igJM
        w7HTixghGvYCNcxcwQTh/GCUeP56FVg3m4CmxNObU8ESIgIrmSRuvFoGlmAWUJfYNeEEmC0s
        YCmx7/EtFhCbRUBV4tOKmYwgNq+Am0Tr3gOMEOvkJG6e62SGsN+yS+x5Kwxhu0ic7jsCFReW
        eHV8CzuELSXx+d1eoN84gOxiiU375EFukBBoYJRY8mkzC0SNscSsZ+2MIDXMQIeu36UPUa4s
        cQTiGmYBPomOw3/ZIcK8Eh1tQhCNyhK/Jk2GOkxSYubNO1AlHhI9BxQgQRUr8WHvJuYJjLKz
        EMYvYGRcxSiWWlCcm55abFRgAo+h5PzcTYzg5KflsYNx9tsPeocYmTgYDzFKcDArifDecXme
        JMSbklhZlVqUH19UmpNafIjRFBhYE5mlRJPzgek3ryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQ
        QHpiSWp2ampBahFMHxMHp1QDU5z/KYl/bm6CcxYsDq1NWctQsJ3pfFfbfY+fqhmGn9KUFD2r
        NvRlJ265+SfN4fu3Hdnsrs+fOG1dtevHi2yxhDdrbtc7dnd6+P8T12JYVtkeOOeQs0PJ7l0y
        STYzzsalGO/5turkjOz6nav27Zl2dE9tQqGa79FcA9e0iKY9mW7z/uhsEP0w7eHF2LPrz0ws
        Z1uT9+Pg7WfP1nzaWnvb9/Xb7V9WpSQFrpjw3uTPwuqSfr3X9/t+7VW5uzljXifDp/Cc0p5f
        c0uCz6a2in1bx380s9Ymp9ki/8uaW2cSkpMO+d+U3W8Rk7+6fWNRx+YjQTeuP5Sp2Wkrsbxz
        QcQKO4kJHKfeRkVYfzny9fibrPdKLMUZiYZazEXFiQC5osuMBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvO6FxhdJBreP6lmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8fiPS+ZPCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7FJdNSmpOZllq
        kb5dAlfGjjsP2Qu+slesnXGDvYHxKFsXIyeHhICJxLHTixi7GLk4hAR2M0pMajvNBJGQlDix
        8zkjhC0scb/lCCuILSTwjVFi/k4xEJtNQFPi6c2pYPUiAtuZJH59TAOxmQXUJXZNOAEWFxaw
        lNj3+BYLiM0ioCrxacVMsJm8Am4SrXsPQM2Xk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFhnmp
        5XrFibnFpXnpesn5uZsYwUGppbmDcfuqD3qHGJk4GA8xSnAwK4nw3nF5niTEm5JYWZValB9f
        VJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU4Ps/pMnuq4IbrTyCdVJSnSX
        z5vwX9s244VQxrHjr1YdSGFvzvXb8LLN7th10SYX9+CZG3lFZOd6vFw9W3flVHa7/M0tDA+L
        VWI3v0sV6rv0Y9vKP0tVJr402CBVLPXg/8v7Vk8vvfz5YVFTs8e3teVtrDN4a4onSk393/Zd
        /Zdx1Q7zqPlTZ2wXy3i2TMyV/UGIIEPglxmMecynV7cy//xhnXXvYmCEzYQmriqR3UG1ux/6
        xU3ga+ufHLJuQvu024f2fd3ockvV+u0+rfqL6zbe1/OTdPvFfOCU+BS/7fO1lt4K27qi82jN
        94zE001uu3fuS/04v+P1PplbRV6/p1gftN2efMbt0ZEt29/8nrhbiaU4I9FQi7moOBEAnlgh
        NLkCAAA=
X-CMS-MailID: 20220802014552epcas2p236519c03464ab32d9a877887710b1c10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802014552epcas2p236519c03464ab32d9a877887710b1c10
References: <CGME20220802014552epcas2p236519c03464ab32d9a877887710b1c10@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: add a fixes tag

Link lost is treated as fatal error with the patch
c99b9b2, but its event isn't registered as interrupt source,
so I enable it.

Fixes: c99b9b2 ("scsi: ufs: Treat link loss as fatal error")
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

