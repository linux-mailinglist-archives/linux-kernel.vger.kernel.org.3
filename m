Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781124B2400
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349345AbiBKLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:10:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiBKLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:10:45 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D3E5E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:10:43 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220211111040epoutp04ba07b4931bd9f87afd4f6cd1b53c0c64~SttU_yIHC2332023320epoutp04P
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220211111040epoutp04ba07b4931bd9f87afd4f6cd1b53c0c64~SttU_yIHC2332023320epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644577840;
        bh=/QqAj4sBooVJtWFQuaex7gP6M60iq909aZ1ni0qhM34=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TmPHJjXOcDXAmkZtOEBpUXSQf8a0VavCwmwC3dRqeFl2zh3OjXjYQVHwLm0w1rCDK
         J6F5DfBy40gv/WcSUK7RIhne2lnxa9gynNkIWUdAd47ekJqfok7gmXgT6VNcMMOLSu
         C4eAn6JnixkpoW/FNf8XLdsBWq8AJLZZOOKe2P3w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220211111040epcas2p21ac27e4037466e7bddfd390edc5643df~SttUUWROv2496924969epcas2p2d;
        Fri, 11 Feb 2022 11:10:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jw9rr4PLvz4x9Pt; Fri, 11 Feb
        2022 11:10:36 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.98.51767.C2446026; Fri, 11 Feb 2022 20:10:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220211111036epcas2p49318d038042b4b56d374a11999cc1d64~SttQf4stM2585225852epcas2p4_;
        Fri, 11 Feb 2022 11:10:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220211111036epsmtrp2eb8b5781e25efffb96f272d99cd883f1~SttQe5O_Q2422524225epsmtrp2L;
        Fri, 11 Feb 2022 11:10:36 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-d5-6206442c1ba0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.33.29871.B2446026; Fri, 11 Feb 2022 20:10:35 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220211111035epsmtip1a2ef5627ab9f837a7c9d982048a2dfe6~SttQQFFXS0789707897epsmtip1a;
        Fri, 11 Feb 2022 11:10:35 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: exclude UECxx from SFR dump list
Date:   Fri, 11 Feb 2022 20:08:21 +0900
Message-Id: <1644577701-40884-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQlfHhS3JYMNHSYuTT9awWTyYt43N
        4uXPq2wWBx92slh8XfqM1eLT+mWsFqsXP2CxWHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gs
        uu7eYLRY+u8ti8Wd+x9ZHPg9Lvf1Mnks3vOSyWPCogOMHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q8
        2g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQw
        MDIFKkzIzujZfYGt4CZXxYPXMxgbGI9zdDFyckgImEjcntbG1MXIxSEksINR4uLpmSwgCSGB
        T4wSJy5YQyS+MUrc/rWEEaZjRvtrRojEXkaJW0saodp/MEqc+n+IFaSKTUBT4unNqUwgtojA
        dSaJedszQGxmAXWJXRNOgMWFBewljpz9zNbFyMHBIqAqcW1hGEiYV8BVovHUaXaIZXISN891
        MkPYjRwSV7eHQdguEnu2XGaBsIUlXh3fAlUvJfH53V6wkRICxRKb9smDnCYh0MAoseTTZqh6
        Y4lZz9oZQWqYgc5cv0sfolxZ4sgtFogj+SQ6Dv9lhwjzSnS0CUE0Kkv8mjQZGgqSEjNv3oFa
        6iEx59gmsIFCArESDyYoTGCUnYUwfgEj4ypGsdSC4tz01GKjAkN4BCXn525iBCdGLdcdjJPf
        ftA7xMjEwXiIUYKDWUmEd8UN1iQh3pTEyqrUovz4otKc1OJDjKbAsJrILCWanA9MzXkl8YYm
        lgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGphCo34v3WpUeuj4e95Dd96E
        8G7gdFSYN0sLmD0ucd3UKjUVm565YMF5tZsuj5JqQmZo5vMJPu9YwfuXkXe6pMsPpYOlR+y0
        9gVMfX2jk+nJnLpoY9eef+7Stx/UTZsmf9/cqaCxYu/BinWcMS2pH3Q3RPMy2B48PcHOZNft
        dZlKwoZbczb/rFeIaHFXtrjGsjcw0ogz2bHI8Ir154KTC04FT5v0+zgn6w6+XzJ2Hx49Xpbp
        /Nxocd9KbW2JtuNB4t1f5ITOTYmQOdHz6/ZDEXbetC7+k791g99H6J28wrCBLU3S/Z5t14V/
        BxfblrB9Y7w1YbLtiqbrUfWbjn2Z3iyi3y6s58HULPDv6YKH+5RYijMSDbWYi4oTAZg60/IV
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK62C1uSwZ7llhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiOKySUnNySxLLdK3S+DK6Nl9ga3gJlfFg9czGBsYj3N0MXJySAiYSMxof83YxcjF
        ISSwm1Hi/9HNjBAJSYkTO59D2cIS91uOsEIUfWOUuLXkMgtIgk1AU+LpzalMIAkRgZdMEi/m
        rGEDSTALqEvsmnCCCcQWFrCXOHL2M1Ccg4NFQFXi2sIwkDCvgKtE46nT7BAL5CRunutknsDI
        s4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDQamnuYNy+6oPeIUYmDsZDjBIc
        zEoivCtusCYJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnV
        wLRw0yadEwr+e4WM/kSre3pzCT5bYSP6883OuJXWt8UZVr34rjqRf8c3peKnN53lt1/kPZsR
        FDppkd4+A6u5ugd2RQQdtz0vuidB2fp94tO4/t/3fheKHDNx57auXR6372F2TchHu8+3bMxi
        38qlbA5dx1OnzGpsnsXCUv7ngHcQx/4lCkI3zh8W9VOvUqqoNtx45s7Ci2bu6oL5H1s/Cdp6
        CDCEbJtiYSq07M5U/USFiUE7JhhMTDdZtjYkinvpSr2k0qd5TbbL7fgWyD24GLfloV60wd/c
        tfn38yZd/Vai3c3yXs5wo0tS3Ee7V2fWfdBcc9i7YnL76bcdYrfkJjjHm28Tymjd+sFROfhV
        hhJLcUaioRZzUXEiAGNmB4fJAgAA
X-CMS-MailID: 20220211111036epcas2p49318d038042b4b56d374a11999cc1d64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220211111036epcas2p49318d038042b4b56d374a11999cc1d64
References: <CGME20220211111036epcas2p49318d038042b4b56d374a11999cc1d64@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/scsi/ufs/ufshcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b4..8b65c081 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -115,8 +115,12 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 	if (!regs)
 		return -ENOMEM;
 
-	for (pos = 0; pos < len; pos += 4)
+	for (pos = 0; pos < len; pos += 4) {
+		if (pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER	&&
+		    pos <= REG_UIC_ERROR_CODE_DME)
+			continue;
 		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
+	}
 
 	ufshcd_hex_dump(prefix, regs, len);
 	kfree(regs);
-- 
2.7.4

