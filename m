Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6D586302
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiHADNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiHADNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:13:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CEBA461
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:13:05 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220801031302epoutp049b4e883c51b79efe60c247f1610cec02~HGgHXCFCL2598825988epoutp04d
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220801031302epoutp049b4e883c51b79efe60c247f1610cec02~HGgHXCFCL2598825988epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659323582;
        bh=IzTJpwJDmv27DqFGcnFFbEYZnoox6AVDGRsU60ndVjo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kbU3ZxM9cStWXW5Ggswg6sJgz+AjWq9hDd8thcCfM9SXjaq9UrRwZB6Of0LQ4itAb
         Sj7umqAqUNuLmtcxPSzBEXmpHXg4M/eBgdPac1eAW/Hj1Kidjd/PyACT1TqN+iyHiO
         SminOS4fsJInu/xHctuL4hdboNggj86ZBodhbSz0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220801031301epcas2p2f53b8f11b7f52761f5261b2a55d34dd2~HGgGbbOER0653206532epcas2p2_;
        Mon,  1 Aug 2022 03:13:01 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lx38s1syGz4x9Q1; Mon,  1 Aug
        2022 03:13:01 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.B4.09642.DB447E26; Mon,  1 Aug 2022 12:13:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155~HGgFWtDOs0771607716epcas2p23;
        Mon,  1 Aug 2022 03:13:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220801031300epsmtrp107beaf4b67106b98f0c2178662c1dc07~HGgFV88m_1998119981epsmtrp1m;
        Mon,  1 Aug 2022 03:13:00 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-8b-62e744bdc9ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.A1.08905.CB447E26; Mon,  1 Aug 2022 12:13:00 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220801031300epsmtip26a5d52c831d6a24302043c9d36e37293~HGgFHT5Bk0544405444epsmtip2_;
        Mon,  1 Aug 2022 03:13:00 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v1] scsi: ufs: enable link lost interrupt
Date:   Mon,  1 Aug 2022 12:09:40 +0900
Message-Id: <1659323380-161341-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmqe5el+dJBkeXclicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8fiPS+ZPCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7VLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtC5SgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjI2TO1kLTrNX
        HL2wm7mBcSlbFyMnh4SAicSKH08Zuxi5OIQEdjBKnLn4iRnC+cQocfLhSSjnG6NE485pcC0r
        5/ayQCT2Mkq8uLqPDcL5wShxaMZEZpAqNgFNiac3pzKBJEQEVjJJ3Hi1jAkkwSygLrFrwgkg
        m4NDWMBB4uHvfJAwi4CqxI1rB9hBbF4BN4nleyZDbZOTuHmuE+wMCYGX7BIda4+zQiRcJBY9
        aoSyhSVeHd/CDmFLSbzsb2MHmS8hUCyxaZ88RG8Do8SST5tZIGqMJWY9a2cEqWEGOnT9Ln2I
        cmWJI7dYIK7kk+g4/BdqCq9ER5sQRKOyxK9JkxkhbEmJmTfvQC31kNj7qBvMFhKIlei6+IVx
        AqPsLIT5CxgZVzGKpRYU56anFhsVGMMjKTk/dxMjOAVque9gnPH2g94hRiYOxkOMEhzMSiK8
        AgGPk4R4UxIrq1KL8uOLSnNSiw8xmgKDayKzlGhyPjAJ55XEG5pYGpiYmRmaG5kamCuJ83ql
        bEgUEkhPLEnNTk0tSC2C6WPi4JRqYIr7zvvumMu20NY1jp7vl15fx3T6RZz81W555ZtdZxoc
        BIXuPkk/tetmsbrXxuJT33Yesq+JX3o7+2v1N0/vN2XdtxhkX9o2H6lRk5tualK5beE3hdff
        E3eqLAjxfhgxSVrvPK/R1eC/s/Vzfn7/+HwSd3Ztez0D75RMDy39Q8d/qbU4NIZEnHq0YafT
        P8e1S2e8u7njiPzm/JbHF4XjVd9y7KorbAo+eoHntO3VMy2b7Aw61vx81XJLqz/p0ZY6+0OS
        SXPKkzJveP+wmLS8KsT58qUL5iftymyyFr/9pf9V4MfJTXe3fZuod+JlnWr74s06ZtoPuhQ7
        PuY6Borde+MXxv/9Ym6G4fv/rzMlAz4qsRRnJBpqMRcVJwIAULRY8QoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvO4el+dJBkvma1icfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8fiPS+ZPCYsOsDo8X19B5vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwB7FJdNSmpOZllq
        kb5dAlfGxsmdrAWn2SuOXtjN3MC4lK2LkZNDQsBEYuXcXhYQW0hgN6PEmW1MEHFJiRM7nzNC
        2MIS91uOsHYxcgHVfGOUeHDlFStIgk1AU+LpzalgDSIC25kkfn1MA7GZBdQldk04ARTn4BAW
        cJB4+DsfJMwioCpx49oBdhCbV8BNYvmeyVA3yEncPNfJPIGRZwEjwypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOCQ1NLcwbh91Qe9Q4xMHIyHGCU4mJVEeAUCHicJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwMTkqLzQJdVU52Gy+/ETPF0F
        ZufVmg7/Z73Vw6C1dqeL24bWjwmVYlyfBauO7cqc9lf5vO2ZQsmjTbpn63/x59vznm7jfvBW
        WHXysVM+6eryb2c8Mzquxm1sd1X+1Gnh2L7G06sn5n2NlzmwQfDEV63680UPneqP2v/0Mt3w
        c2+85vttvN5l27g/nPWYfLAn9E2TWWFD3j+fTNlnpz/z+369JjUtuq/bo9V34qMNz2a0z+Ny
        S4v1c9myiefixfey2Z0/n38U9Gtt4qyySBaM/vrtBee51Xxh0xuNMlQydT6YTmd39yj98k1Q
        70qzeOQCmzjG2B/VLXmlk08WFpyUOSJ+1npul5eWeXhk7lFvJZbijERDLeai4kQAxcbPALgC
        AAA=
X-CMS-MailID: 20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155
References: <CGME20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

