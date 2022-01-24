Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A454749AC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiAYGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:25:17 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56095 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245605AbiAYGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:22:37 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220125062202epoutp01bbb1a95baa7113f09954f16d0c459a47~Nbzdf_4zK2280122801epoutp011
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:22:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220125062202epoutp01bbb1a95baa7113f09954f16d0c459a47~Nbzdf_4zK2280122801epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643091722;
        bh=VrIee84DnP2DnNrkSz8/gaQX5VYVPQUHCj0/qVe8RV0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QSax2+K/kL/GVKUtYaXpOIehEOuTsjjDYLEzbLwNZYGKUOTd/KgNLd71Mra0B423o
         XDgqbJdqi1E0Q3t7XFMKD72DbY5+nj8KpL01pPmM5rKVwL2z/WHHjIGBBv7zBFtchY
         BwZlxdRrDW3Jl+Oy2KEjKS5bXXp5URZjRRYsmMoQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220125062201epcas2p2b095d12b61be0f2747d7fb854e817027~NbzchzFEU0193201932epcas2p2U;
        Tue, 25 Jan 2022 06:22:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjcFd6qJ2z4x9Q1; Tue, 25 Jan
        2022 06:21:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.9D.12141.4079FE16; Tue, 25 Jan 2022 15:21:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b~NbzXC11Fw0864008640epcas2p15;
        Tue, 25 Jan 2022 06:21:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220125062155epsmtrp128439ceb2d5120a899276c7e10c1b5a5~NbzXB6ryj1143011430epsmtrp1C;
        Tue, 25 Jan 2022 06:21:55 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-8e-61ef9704d4c9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.8C.29871.3079FE16; Tue, 25 Jan 2022 15:21:55 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220125062155epsmtip2469de7d692f2cbb1364237bfe0143276~NbzWww-id2384623846epsmtip2N;
        Tue, 25 Jan 2022 06:21:55 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] scsi: ufs: disable auto hibern8 while entering suspend
Date:   Tue, 25 Jan 2022 03:06:37 +0900
Message-Id: <20220124180637.160524-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhS7L9PeJBtcfSVk8mLeNzWJv2wl2
        i5c/r7JZHHzYyWLxdekzVotpH34yW3xav4zVYvXiBywWi25sY7K4ueUoi8XlXXPYLLqv72Cz
        eNX8iM1i+fF/TA58HpeveHtc7utl8li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        ATpeSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCd0XzApmC+cMXRq8/YGhjXCnQxcnJICJhI9K/tZ+9i5OIQEtjBKHG8by8rhPOJUeL0
        rv9QmW+MEr+aTzJ2MXKAtfxYIQLSLSSwl1Fi9xMtiJofjBL3lh9gBEmwCWhIrDl2iAkkISKw
        gkmiZ9MnJpAEs4CnRMu56cwgtrCAl8TXvx9ZQWwWAVWJs5//gtXwClhJrFm9mQniPnmJRQ2/
        oeKCEidnPmGBmCMv0bx1NjPIAgmBuRwSH+feZIdocJE4MHk9K4QtLPHq+BaouJTEy/42doiG
        ZkaJ9TPnMEE4Uxgl5j57CtVhLDHrWTvYn8wCmhLrd+lDvKwsceQW1GI+iY7Df9khwrwSHW1C
        EI1KEmfm3oYKS0gcnJ0DEfaQWNewiwUSWLESVz7sZ53AKD8LyTezkHwzC2HtAkbmVYxiqQXF
        uempxUYFJvA4Tc7P3cQITr5aHjsYZ7/9oHeIkYmD8RCjBAezkgjvf+/3iUK8KYmVValF+fFF
        pTmpxYcYTYHhO5FZSjQ5H5j+80riDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB
        9DFxcEo1MHEd/NBqZxZj91N8m0nNH5aA6ENFOktsHsyZcI4/yNZlV+4aGf661mjdf2IKm/6/
        XJnYzSr++nXvywtffbY/Y8mO7fy7Z/7bGbxKxwX/7OXS6L2h8bayVdrzfkSDjrd1VL8m26x3
        IjP/ZL0Q1Ak3bS+Q89iYz7TyVd2yxrQbptHqxRwflvxzLvyatKLmYfazL5w/NSYmuovWsD37
        rnBY2zXWfd/DxphnUxYd7PNbPvHIbI+/B5UsWP3rkp/PO8MivPamhtICg09rJZKuPnASnrO3
        71qF7RG11q7+3vUFpUerTs0xL0mWkQvJWZbm9b53yva5fCkTGNc/WyhQ+G7n/2MPDjXn2Bus
        9xFffPXzViWW4oxEQy3mouJEABhizSpHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvC7z9PeJBlNOKFs8mLeNzWJv2wl2
        i5c/r7JZHHzYyWLxdekzVotpH34yW3xav4zVYvXiBywWi25sY7K4ueUoi8XlXXPYLLqv72Cz
        eNX8iM1i+fF/TA58HpeveHtc7utl8li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCM4rJJSc3JLEst0rdL4MpoPmBTMF+44ujVZ2wNjGsFuhg5OCQETCR+rBDpYuTiEBLY
        zShx7N0tti5GTqC4hMT/xU1MELawxP2WI6wQRd8YJQ5+ucoMkmAT0JBYc+wQE0hCRGAbk8Td
        DyfBupkFvCUuHLvMDmILC3hJfP37kRXEZhFQlTj7+S/YVF4BK4k1qzdDbZCXWNTwGyouKHFy
        5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M
        4IjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4/3u/TxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qBSfTZC6n+go8zujTObDzs/+OKgMPWrboJb3Qibj2OypB6
        e/6WBYPm4kuPpv258t2DwYbvkmnb+UuFR6Z/iZl9LeJ3yT8+Ca7z8+xdmrqzZeNMapobY6zu
        Gb/h/P/umZOp08Y3y7NdnzE5G4kVa0+UeHd4S4T5c9+wG3Y3OK7sZP967lO+iNYxh/BpH64w
        nWPRP5Nzbl/d3F4zz/SuyxHrIj3yhN5b6z0SPTiLWYj/X612tcnb7EuTxdoCF2xnXzs3V6H2
        XvDMecdurexZ5WOm1/l4ptT9kOgZdrZ8PPJJm8PtO9sc7OO05gTvuN6+JkfuqTqL4EIey5+N
        5vd/F/I9KDFaL9RyznjWrLVy0ax3lFiKMxINtZiLihMB0tOcM/cCAAA=
X-CMS-MailID: 20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1-> v2: fixed no previous prototype warning
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):
>> drivers/scsi/ufs/ufshcd.c:4207:6: warning: no previous prototype 
for 'ufshcd_auto_hibern8_disable' [-Wmissing-prototypes]
4207 | void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)

If using auto hibern8 mode, need to disable auto hibern8 while
entering suspend.
When using auto hibern8 mode, it does not seem right to send a uic command
for entry into hibern8 in the next line(ufshcd_lik_state_transition(..))
It seem right to send after disable auto hibern8.

In addition, if the auto hibern8 mode supported, it is enabled in resume.
So it seems that it will be paired only when auto hibern8 is disabled
while entering suspend.

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b440d2e..a6edbbd8ca2c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -254,6 +254,7 @@ static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
 static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
+static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba);
 
 static inline void ufshcd_enable_irq(struct ufs_hba *hba)
 {
@@ -4204,6 +4205,18 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 }
 EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
 
+static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
+{
+	unsigned long flags;
+
+	if (!ufshcd_is_auto_hibern8_supported(hba))
+		return;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+
 void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
 {
 	unsigned long flags;
@@ -8925,6 +8938,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	 * with the link off, so do not check for bkops.
 	 */
 	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
+	ufshcd_auto_hibern8_disable(hba);
 	ret = ufshcd_link_state_transition(hba, req_link_state, check_for_bkops);
 	if (ret)
 		goto set_dev_active;
-- 
2.26.0

