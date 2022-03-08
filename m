Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B64D11D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiCHION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiCHIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:14:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395352716E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:13:15 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220308081313epoutp046785bd44917008d8d9753654adc40c7f~aWaho6CV21141411414epoutp04v
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:13:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220308081313epoutp046785bd44917008d8d9753654adc40c7f~aWaho6CV21141411414epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646727193;
        bh=VGxcO7exWoJUhnWqv0D5xG+D7P3MSO1ED5tDa7t5n2I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tk/rTrii4OoOlDqFtwI8Dw0N6pSHKBVVxPb4XepeKkcuHHNoM1q2rFF1GfC6nXOZi
         yTcSVelYdjcZ3At8hK/4L/ZfZ/OGnRk+XYVl39HYWI5g+36Ot33i2FhJ29Al3Zqrhw
         5sFaZc1oTcvslm53et8gZtUxy+W4vmd+3aPdPjAM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220308081312epcas2p39d7d77065219159dc3c903871edf410d~aWahCjvRe2420624206epcas2p3u;
        Tue,  8 Mar 2022 08:13:12 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KCSkX4hcTz4x9Pt; Tue,  8 Mar
        2022 08:13:08 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.E1.35137.74D07226; Tue,  8 Mar 2022 17:01:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68~aWaZjjrAv0846008460epcas2p4D;
        Tue,  8 Mar 2022 08:13:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308081304epsmtrp1f369439752ef4a7ad7476e38b3496932~aWaZial8w2300323003epsmtrp1k;
        Tue,  8 Mar 2022 08:13:04 +0000 (GMT)
X-AuditID: b6c32a46-59d65a8000018941-f0-62270d47deea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.6B.03370.01017226; Tue,  8 Mar 2022 17:13:04 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220308081304epsmtip11de1f5f968f950a1ff8ce6a7ebdde2b8~aWaZXQ0td2954429544epsmtip1m;
        Tue,  8 Mar 2022 08:13:04 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2] scsi: ufs: exclude UECxx from SFR dump list
Date:   Tue,  8 Mar 2022 17:11:58 +0900
Message-Id: <1646727118-87159-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTQtedVz3JYNNbcYuTT9awWTyYt43N
        4uXPq2wWBx92slh8XfqM1eLT+mWsFqsXP2CxWHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gs
        uu7eYLRY+u8ti8Wd+x9ZHPg9Lvf1Mnks3vOSyWPCogOMHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q8
        2g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQw
        MDIFKkzIzph9sJ29YAF3xfmGPpYGxu8cXYycHBICJhL9p7eydzFycQgJ7GCU2NC7gwnC+cQo
        0TS7iQ3C+cwo8ftPPxNMy/0Hi1ghErsYJT6tvQLV8oNRonfuJkaQKjYBTYmnN6eCdYgIXGeS
        mLc9A8RmFlCX2DXhBFhcWMBe4uvZI2wgNouAqsTB7RtZQGxeAVeJzgf3mSG2yUncPNfJDLJA
        QuAvu8T+f+/ZIBIuEtvaJ7BD2MISr45vgbKlJF72twHZHEB2scSmffIQvQ2MEks+bWaBqDGW
        mPWsnRGkhhno0PW79CHKlSWO3GKBOJNPouPwX6gpvBIdbUIQjcoSvyZNZoSwJSVm3rwDtdRD
        Yvbq62AXCwnESjx7tohlAqPsLIT5CxgZVzGKpRYU56anFhsVGMEjKTk/dxMjOEFque1gnPL2
        g94hRiYOxkOMEhzMSiK898+rJAnxpiRWVqUW5ccXleakFh9iNAUG10RmKdHkfGCKziuJNzSx
        NDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE08fEwSnVwJT/JiZa//oS/ttR7qGHlNpO
        xVp35VuJnzhRp7q/QUBi/d2CZoF3YZ9Nfum3xHN2vHt27Onh3dM756313VG9z35J+Jt78cnb
        J+b5W6/8UMOZ+Yx1RS/Tad5TFrYa167JT4zeM5+Le90bbpUk7wZzn81LzjGycE5IqU8Kc+yo
        aV54lun1lUUxG/I3ZhvouOyN/Hrmw9PewtXv8yfuf9KodsJ1WlfEUakqlamXtqhOvTFtldm3
        ZUedjKy2qxzkvr5ENtryhvFPB/agqa0ld77Mn3X7omDPlZd29XmO+yo2xdzruSbO/kj3Z6b/
        2VvhF1PZbwfEPgx612Bz0GOu5yTRxs+qjNNvLV1yI6j8vEj1v0olluKMREMt5qLiRADWgexY
        GQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnK6AgHqSwYSlxhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiOKySUnNySxLLdK3S+DKmH2wnb1gAXfF+YY+lgbG7xxdjJwcEgImEvcfLGLtYuTi
        EBLYwSjR0rWZESIhKXFi53MoW1jifssRqKJvjBIdW/6BJdgENCWe3pzKBJIQEXjJJPFizho2
        kASzgLrErgknmEBsYQF7ia9nj4DFWQRUJQ5u38gCYvMKuEp0PrjPDLFBTuLmuU7mCYw8CxgZ
        VjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIetltYOxj2rPugdYmTiYDzEKMHBrCTC
        e/+8SpIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTLpr
        /sU+8Ti87WR0z7Rl65N+1m1LEJqwO9x/mxXX/zsGWb1XWFr+n3n9WYyvYeq+SZaLD1T7HpOL
        7NwlureuZJLXLvOfd1VTK7nWvl7Z/sc0X3pJwMunYdcOHP3u1i0U/cZf4cTW77M7/xR65pg4
        HEjiqr3CwcHIG3tCpuTgBMf70Q7zfs/Mrf3w+4aR55WItit5uV9Pzar0CvsQb2yiptcW7i31
        4kvW9QMazgwL+Rbs4JXfOcGYw+SvcP57+1IX6RdMiWz86y6EpvHuFykoFW+/uzHLk7Oia/cn
        boG+ZxOeLLr1a1bvhGbrnnzbq81hxbmtz9wuKwY9SVVbcFRqQmGS5mcL/nR7U+HzfGeTlFiK
        MxINtZiLihMBglqF48oCAAA=
X-CMS-MailID: 20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68
References: <CGME20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: does skipping only for zero offset

These are ROC type things that means their values
are cleared when the SFRs are read.
They are usually read in ISR when an UIC error occur.
Thus, their values would be zero at many cases. And
there might be a little bit risky when they are read to
be cleared before the ISR reads them, e.g. the case that
a command is timed-out, ufshcd_dump_regs is called in
ufshcd_abort and an UIC error occurs at the nearly
same time. In this case, ISR will be called but UFS error handler
will not be scheduled.
This patch is to make UFS driver not read those SFRs in the
dump function, i.e. ufshcd_dump_regs.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b4..7f2a1ed 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -115,8 +115,13 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 	if (!regs)
 		return -ENOMEM;
 
-	for (pos = 0; pos < len; pos += 4)
+	for (pos = 0; pos < len; pos += 4) {
+		if (offset == 0 &&
+		    pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER &&
+		    pos <= REG_UIC_ERROR_CODE_DME)
+			continue;
 		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
+	}
 
 	ufshcd_hex_dump(prefix, regs, len);
 	kfree(regs);
-- 
2.7.4

