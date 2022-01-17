Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79A490616
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiAQKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:39:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16158 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiAQKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:39:19 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220117103917epoutp02f79f508cafa7781c39a640f1d235f054~LCJyVHosw2110721107epoutp02p
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220117103917epoutp02f79f508cafa7781c39a640f1d235f054~LCJyVHosw2110721107epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642415957;
        bh=qAxRXAVOoR5rxjQDd6H+GW5zXL4yoyJW/bykpq4XSAc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GHlJ4ezbj9pMM8TrMgNlAq9IxNDSghu25xe4ouVFYwOamcw6BJqAPs3XNFf0Lsyxd
         utsEZ8cVMZCGYnVxQfmQqGB+9R4oJ0DSsBUx7yI+iKx1iS6+YNg8m6h/Wcb9SHhOKz
         1NMOraCU76/8VZPHKrFA0Yl3yrYxBdfNbTWF7ue4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220117103917epcas2p39348b04df96edce656259cc3f694c198~LCJxqnuJs1776617766epcas2p3R;
        Mon, 17 Jan 2022 10:39:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JcpL92DPDz4x9QF; Mon, 17 Jan
        2022 10:39:13 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.EA.10014.D2745E16; Mon, 17 Jan 2022 19:38:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220117103912epcas2p41c5d54a9242e46264c4e388a1db27f6b~LCJtEpawP0119501195epcas2p4D;
        Mon, 17 Jan 2022 10:39:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220117103912epsmtrp25ef658e6770ced49f2c6a7c7d0b26283~LCJtDecT42156421564epsmtrp2D;
        Mon, 17 Jan 2022 10:39:12 +0000 (GMT)
X-AuditID: b6c32a47-473ff7000000271e-60-61e5472dc65a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.91.08738.F4745E16; Mon, 17 Jan 2022 19:39:11 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220117103911epsmtip1dd3e04416bb200443fbb741fad9412a1~LCJsyYYhq2600326003epsmtip1K;
        Mon, 17 Jan 2022 10:39:11 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: see link lost as fatal
Date:   Mon, 17 Jan 2022 19:37:26 +0900
Message-Id: <1642415846-141110-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQlfX/WmiwaVlshYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnXHz/XT2gpVsFSc7DBoYp7J2MXJwSAiYSLy+pt/FyMUhJLCDUeLm9YWMXYycQM4n
        Rom1K4sgEp8ZJW6tuMwGkgBpeH57JRtEYhejxIpFDxghnB+MEvfOLwNrZxPQlHh6cyoTiC0i
        cJ1JYt72DBCbWUBdYteEE2BxYQFTiUkzD4PVswioSqxcv58ZxOYVcJPY0rCOCWKbnMTNc53M
        IAskBBo5JC7fgbhPQsBFYtq1/+wQtrDEq+NboGwpic/v9rJBNDQzSuzc3QjVPYVRYsn+D1BV
        xhKznrUzgkKAGejU9bv0IYGhLHHkFgvEoXwSHYf/skOEeSU62oQgGpUlfk2aDHWCpMTMm3eg
        SjwkXjS4QkIuVuJGz17GCYyysxDGL2BkXMUollpQnJueWmxUYAyPouT83E2M4OSo5b6Dccbb
        D3qHGJk4GA8xSnAwK4nwHuN+kijEm5JYWZValB9fVJqTWnyI0RQYXhOZpUST84HpOa8k3tDE
        0sDEzMzQ3MjUwFxJnNcrZUOikEB6YklqdmpqQWoRTB8TB6dUA1P17NcPvqjr7DVSncBgNCWQ
        6a6MWcsGuX98a+V0V3Gl3Z08W+t+kq7ljfY5qqyq59sOSrLVP39b/k/O6/XR7QGB34WFVwnf
        ObNtttOFqdfZ/1Rd2PW94Z6qsFMXv9jsl/Zrlj1VCJ6qyufifLDz2Mm7taGeCm2m5j/1L3Wc
        28Xc96gxMGJaW0+zRvIHV4lla2ddNdn2kX/x2b/9Czlu22y6tlLuzKcDb35IdC2dn3W+7+jP
        itnB36s2JXvNbfRwzdkW/kGdW7N1y/a33C2vvd2SQ/mWC59K7cv+tU3Tg0ly+zu7Kxa/nDev
        fHVI505L+Nea/Metq045fxB4tPWehf79B0khQizbLa5Ib/pWfH+rEktxRqKhFnNRcSIAfXYQ
        hRcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK6/+9NEg23PLC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotP65exWqxe/IDFYtGNbUwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uNzXy+SxeM9LJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5Lz
        aD/QzRTAEcVlk5Kak1mWWqRvl8CVcfP9dPaClWwVJzsMGhinsnYxcnJICJhIPL+9kq2LkYtD
        SGAHo8S7aY8ZIRKSEid2PoeyhSXutxxhhSj6xijx49ArdpAEm4CmxNObU5lAEiICL5kkXsxZ
        wwaSYBZQl9g14QQTiC0sYCoxaeZhsEksAqoSK9fvZwaxeQXcJLY0rGOC2CAncfNcJ/MERp4F
        jAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCg1ZLawfjnlUf9A4xMnEwHmKU4GBW
        EuE9xv0kUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm
        gVzWc2Hx+9s62V3+qqbO4g1N8N67a+3Czoidh+UFfaYluz8J6GzYfyiyewOfuaX/9L+X4wN1
        Jm+/XPJjQ/oMnj9PZqUsN7xaOoPRT3bTwc43r1sePn5+VNbQ6uUmKcOf/6t38s2J25CWfOlA
        au/SeguPjo39zXbZLeqdV59J3Ivvd9twqsVyf/WBZ/Fr/95Xyfld4BETpHJoucvy27/Mrzg/
        udesfVaykeNMVr3xWe8Pi+pmStx5sSqjgXvz8rs9yv87T/Exf+PYXVOcfsKJT33P9zz5PTVv
        mu8H7I8ymKnd4XVtZ4lKgNyy2KPTWg4F39i1l+Wrw+/cSz3tm5dwRt6+eTFC9Up/xdJLjxwu
        KrEUZyQaajEXFScCAG6dDMvJAgAA
X-CMS-MailID: 20220117103912epcas2p41c5d54a9242e46264c4e388a1db27f6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220117103912epcas2p41c5d54a9242e46264c4e388a1db27f6b
References: <CGME20220117103912epcas2p41c5d54a9242e46264c4e388a1db27f6b@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event is raised when link is lost as specified
in UFSHCI spec. At the time, initializing UFS interface
needs to be done.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6a295c8..a7ff0e5 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -142,7 +142,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
 				SYSTEM_BUS_FATAL_ERROR |\
-				CRYPTO_ENGINE_FATAL_ERROR)
+				CRYPTO_ENGINE_FATAL_ERROR |\
+				UIC_LINK_LOST)
 
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
-- 
2.7.4

