Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D94CEFC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiCGCph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiCGCpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:45:35 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1A5FE8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:44:42 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220307024440epoutp0307af616276f39b291c10667d4cef0761~Z_SYBOwnp3038430384epoutp037
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220307024440epoutp0307af616276f39b291c10667d4cef0761~Z_SYBOwnp3038430384epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646621080;
        bh=/QqAj4sBooVJtWFQuaex7gP6M60iq909aZ1ni0qhM34=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JiGxHoL4jXnkFfa4WSEMA9QKSRsAb9J4lvO2YdggRK2U/Y0V+1stXQXAcV3wuaXLY
         GUG8XjGJuI9Z3C/u1M7oOhTa7PbBy0EXaOwX1+/nt9dENrPKaUEGxYGJVgnsUi8Uxo
         oRGWeiAh1VwRqk+q+5oYuH1bkzZbLHTIeI2nrTt8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220307024439epcas2p1cc2a030f46258e7245e759a752e28a0e~Z_SXZEBBx3136731367epcas2p1U;
        Mon,  7 Mar 2022 02:44:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KBjTw3ZTpz4x9Pv; Mon,  7 Mar
        2022 02:44:36 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.92.51767.49175226; Mon,  7 Mar 2022 11:44:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea~Z_ST-baMc3137231372epcas2p1D;
        Mon,  7 Mar 2022 02:44:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307024436epsmtrp24254fc720f43e0ffb41b96df539026e2~Z_ST_jWXB0107901079epsmtrp2I;
        Mon,  7 Mar 2022 02:44:36 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-95-62257194e573
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.B7.29871.39175226; Mon,  7 Mar 2022 11:44:35 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220307024435epsmtip1566e26c09f85b0e6ea3de1a459ab92fc~Z_STyf5c12958629586epsmtip1R;
        Mon,  7 Mar 2022 02:44:35 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v1] scsi: ufs: exclude UECxx from SFR dump list
Date:   Mon,  7 Mar 2022 11:43:30 +0900
Message-Id: <1646621010-118886-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTXHdKoWqSwbzv0hYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQndGz+wJbwU2uigevZzA2MB7n6GLk5JAQMJH4dWc+WxcjF4eQwA5GiRk7bzODJIQE
        PjFKrJvtA5H4xihx4c1jRpiOf3M/MEIk9jJKPP/0khnC+cEocfLAOyaQKjYBTYmnN6eC2SIC
        15kk5m3PALGZBdQldk04ARYXFnCTuP2nnQXEZhFQlWhf+gRoEAcHL1D8whYfiGVyEjfPdTJD
        2K0cEnffiEDYLhKPez+yQtjCEq+Ob2GHsKUkPr/bywYyRkKgWGLTPnmQ0yQEGhgllnzazAJR
        Yywx61k7I0gNM9CZ63fpQ5QrSxy5xQJxJJ9Ex+G/7BBhXomONiGIRmWJX5MmQ0NBUmLmzTtQ
        Sz0kjqyczQgJtliJuQ1LmCcwys5CmL+AkXEVo1hqQXFuemqxUYEhPIaS83M3MYJTo5brDsbJ
        bz/oHWJk4mA8xCjBwawkwnv/vEqSEG9KYmVValF+fFFpTmrxIUZTYGBNZJYSTc4HJue8knhD
        E0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MC/I0z84ze/LEPW93w+a1
        yxX4zI4cXRP616gnSPfvoo0tKewhR65qy+uoC5w9ssShP3GxwrtZWXysjbc+Kz5/rXdI7ljv
        1sZ9L459WrG0UEcx88V3wSQW9/baS+YCLgsmtfWoOIqc1VA8uaT/64aZc3c+WhusyKLw5MNn
        PqXiJhemHzdfX5PW1n1vvnxpoXNdQ88+ptvmT26371x++uLuWWG7Api/iEqYlM4uy+tc2XdC
        MVm6wVN2k0pn/uR2xnnH9wXt2Hlk/q9lIcurJjjwTpfZOWn6w32Mk1+4VhzVCpZ+u3prv7d7
        77ZYoZVGol6NkfeXmD21/5+wt3ilf+Bx1dUXdHzrGpa59sU6LFkuocRSnJFoqMVcVJwIAEac
        Q2UWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO7kQtUkgzfXbCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotP65exWqxe/IDFYtGNbUwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uNzXy+SxeM9LJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5Lz
        aD/QzRTAEcVlk5Kak1mWWqRvl8CV0bP7AlvBTa6KB69nMDYwHufoYuTkkBAwkfg39wNjFyMX
        h5DAbkaJGd+6GCESkhIndj6HsoUl7rccYYUo+sYosfHcVGaQBJuApsTTm1OZQBIiAi+ZJF7M
        WcMGkmAWUJfYNeEEE4gtLOAmcftPOwuIzSKgKtG+9AlQMwcHL1D8whYfiAVyEjfPdTJPYORZ
        wMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOGi1NHcwbl/1Qe8QIxMH4yFGCQ5m
        JRHe++dVkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        qp6//ehT24NdO5p916ifPO5+Krgl/Y/L/qiAsrBzxduX392W/9J/yxfxug2Lwtf/vS4fUZld
        s0Hx3RdxL4/3Uns91iRuepXt8ezVBA399S2h+k/nyz22aLde+JL3+6N7077+U8xY57w+0Npx
        fsd1xfJvtlqHv741nSbx/7vEgTd/J7AGRm4pSVu88dnVrElTjuT+VQmTlTc29vu4ZMebv+nC
        fiZTthmE/tyxvfZMEd/pO5NVFsvN3eN3+dZ9TUVnrvpLqb0HdmopL8mPm7Dt4mGBf0rXS0+Y
        yDtv5JDplfxu0Ho1rKrx9bTtO0TtV+j/i49bbL9cYN+/hncF7LfvScRxyztvty9pD/5w8bTE
        E2MlluKMREMt5qLiRABJ1ZDZyQIAAA==
X-CMS-MailID: 20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea
References: <CGME20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea@epcas2p1.samsung.com>
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

