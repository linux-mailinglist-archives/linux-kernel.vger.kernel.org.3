Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795434D4110
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiCJGUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbiCJGUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:20:41 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB112B754
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:19:40 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220310061935epoutp036e1bb06e1213b46a4d2316992f0d937f~a8J4gliB31619016190epoutp03v
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220310061935epoutp036e1bb06e1213b46a4d2316992f0d937f~a8J4gliB31619016190epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646893175;
        bh=guf5a+UyXn8Tu3/RRFV+ifGaLBDshbdYgxhEy4V5WMs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g4o5nkmAqWxLl0Iopbm3S6gxENbeoBbZdb/9OPHq1Tzfmskr9a+gYZRYWbpWAt8Dj
         4QTsKvqBFR9EYKAYL3dpus1CrFrqzouUAEWB7UVSH5xyStOyPx2yRDEw9t8a3CZZ7V
         n2iLRvBsGUhxr+yHoxkAJRcW5TvQ/OGChNfp0DKY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220310061934epcas2p4486b158734486aaa2a2b91dfcaf01157~a8J3zhsNK2336423364epcas2p4o;
        Thu, 10 Mar 2022 06:19:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KDf6V1tQHz4x9QL; Thu, 10 Mar
        2022 06:19:30 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.42.33036.07899226; Thu, 10 Mar 2022 15:19:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220310061928epcas2p4f8369b836f37ca7e9882617292dc983d~a8Jxrtgrh2410224102epcas2p4J;
        Thu, 10 Mar 2022 06:19:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220310061928epsmtrp25f52fb97bcf7a2deb873beeec151f2f8~a8JxqlrfI2149121491epsmtrp2e;
        Thu, 10 Mar 2022 06:19:28 +0000 (GMT)
X-AuditID: b6c32a48-511ff7000000810c-4d-622998706468
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.09.03370.07899226; Thu, 10 Mar 2022 15:19:28 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220310061928epsmtip205d072694d49b4fa9b891097de062d3f~a8JxdyRs10557005570epsmtip29;
        Thu, 10 Mar 2022 06:19:28 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Date:   Thu, 10 Mar 2022 15:18:18 +0900
Message-Id: <1646893098-98552-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTXLdghmaSwZSZhhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnTFp9kr2gjaeir835rE1MJ7h7GLk4JAQMJE4PDWui5GLQ0hgB6PE3Q1HWCGcT4wS
        V76vZoZwPjNKTN/fxNjFyAnW8exkF1RiF6NEz4k3jBDOD0aJdT2f2EGq2AQ0JZ7enMoEYosI
        XGeSmLc9A8RmFlCX2DXhBFhcWMBeom/tO1aQO1gEVCUOHwEr4RVwlTjYdoIVYpmcxM1znWDL
        JAQaOSQ+9PxlgUi4SDza+o4ZwhaWeHV8CzuELSXx+d1eNojfiiU27ZOH6G1glFjyaTNUr7HE
        rGftjCA1zEB3rt+lD1GuLHHkFgvElXwSHYf/skOEeSU62oQgGpUlfk2aDA0GSYmZN+9ALfWQ
        OLvqMpgtJBArMe9VB/MERtlZCPMXMDKuYhRLLSjOTU8tNiowgUdRcn7uJkZwctTy2ME4++0H
        vUOMTByMhxglOJiVRHibQjWShHhTEiurUovy44tKc1KLDzGaAkNrIrOUaHI+MD3nlcQbmlga
        mJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpg4p0R9WPvibD96rMPbjuoWLLy
        0n0elw0eT85IRpxYsvv25hDTq//Nnsd0ufTp9/9lr3455e9i9j9r9xup12UsfL+lRSRbw+ZW
        x2vmOT58x+u+LbWZsuKrSJ4IX1gLS97l80y7N87tkvBQuvV6s5C9gblqhWFwE1e6sVvWkZKd
        Lms3cu5SUa/9LR1QLvPk9A3evD3p4gfrPzz6NUHl+etXn+/F9kp71Dy6fGUZR46jsymPfYKJ
        trMPh+K3R384Nnx4/cjc8ebsObOnvunqN49XmBYxN+WEuvu1zwelPvuG/lEKnJWit+Hp1mKt
        GX0N/tZXL72fcrvi2O3U01+ZrVa9mVlwvOIB15PUm2HJRu/E9iqxFGckGmoxFxUnAgDkk3BY
        FwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvG7BDM0kgzWzBSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotP65exWqxe/IDFYtGNbUwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uNzXy+SxeM9LJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5Lz
        aD/QzRTAEcVlk5Kak1mWWqRvl8CVMWn2SvaCNp6KvzfmsTUwnuHsYuTkkBAwkXh2sou5i5GL
        Q0hgB6PE7qufmSASkhIndj5nhLCFJe63HGGFKPrGKPHtUys7SIJNQFPi6c2pTCAJEYGXTBIv
        5qxhA0kwC6hL7JpwAmySsIC9RN/ad0DdHBwsAqoSh49kgIR5BVwlDradYIVYICdx81wn8wRG
        ngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDVktrB+OeVR/0DjEycTAeYpTg
        YFYS4W0K1UgS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oq
        gankPIN7xcPEnpVl1WsOztuUtPPe07ubT/+6Zlmj+HJDumCtw5I2dlmf0m8L4n3Wex03k07y
        z3bK3yKrcMM6pMy8pbba/2z9z2nvMttNWrkbubOOrufJzv7MuyU3W5Rz0X7rO/ENIg3HFRs3
        X99+eEN24nPmD7af59z8EeKW/aDo1OFKZfGFzKfaPk59qhGSv85TrE4sQHJu7Zys7qadmr/f
        yt977dU1tbKIV3j57DP+1Xum9fwRrg+QMDE1CeVLyv79iv2mlZKNc/zpmAnyjifrzmz/uNhv
        hvxSiYTvX1f86uLhe7M+K8ba6qBl61+nac7HrVerJG+YkG6/afb586sc1hbybFx23816TvcW
        cSWW4oxEQy3mouJEAIzky5PJAgAA
X-CMS-MailID: 20220310061928epcas2p4f8369b836f37ca7e9882617292dc983d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220310061928epcas2p4f8369b836f37ca7e9882617292dc983d
References: <CGME20220310061928epcas2p4f8369b836f37ca7e9882617292dc983d@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3: add fixes
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

Fixes: d67247566450 ("scsi: ufs: Use explicit access size in ufshcd_dump_regs")
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

