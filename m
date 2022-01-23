Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87472497E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiAXL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:56:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:20049 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiAXL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:56:13 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220124115611epoutp0117724b4589fe05c1571d008193cb02fd~NMt7ERg3X1221912219epoutp01Z
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220124115611epoutp0117724b4589fe05c1571d008193cb02fd~NMt7ERg3X1221912219epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643025371;
        bh=JDX1Dczu4B9oPwtbIXVsCazincwmi8QQ334lt4gSRv8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=B4Dxluiof+MUegSoPJOjOhQApdD3nXM53DJn7lpAV9QEVDxkA8azKXbLv5Xs/hieX
         1ZpUPDeJ+gPP1nlBSLa7I5HqFOaVg2HJnzzZpRfhpla6kM2TauH7Yc/laZhOA9xj2y
         +R7dd3PaKRqpC1aCUjdiooXlPNfzFl6aXVZqh3cQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220124115610epcas2p129b54abc2b550b936b341cb887fb06ae~NMt6WlCOA1887818878epcas2p13;
        Mon, 24 Jan 2022 11:56:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jj7jj07Mrz4x9Q2; Mon, 24 Jan
        2022 11:56:09 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.36.10014.5829EE16; Mon, 24 Jan 2022 20:50:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124115608epcas2p4a6af4460f353a320dcc57a359462f356~NMt4bDQVh0527005270epcas2p4Q;
        Mon, 24 Jan 2022 11:56:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124115608epsmtrp1832581c4535307475d3ee036b34c03ca~NMt4Z--5C0364403644epsmtrp10;
        Mon, 24 Jan 2022 11:56:08 +0000 (GMT)
X-AuditID: b6c32a47-473ff7000000271e-8c-61ee928582c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.64.29871.8D39EE16; Mon, 24 Jan 2022 20:56:08 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124115608epsmtip15e8bb58c9466e1c2c27879cdaf7732da~NMt4O62c32739127391epsmtip1B;
        Mon, 24 Jan 2022 11:56:08 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: disable auto hibern8 while entering suspend
Date:   Mon, 24 Jan 2022 08:40:44 +0900
Message-Id: <20220123234044.163394-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmmW7rpHeJBt9uyFk8mLeNzWJv2wl2
        i5c/r7JZHHzYyWIx7cNPZotP65exWqxe/IDFYtGNbUwWl3fNYbPovr6DzWL58X9MDtwel694
        e1zu62XymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izpq89wFKwiLfiyoRPjA2M
        07i7GDk5JARMJDb9eMbcxcjFISSwg1GiecEiNpCEkMAnRolfPREQiW+MEs8OPmSB6di6fCUr
        RNFeRolrlwIhin4wShxacJkZJMEmoCGx5tghJpCECEj34r8vmEASzAJqEp/vLgObJCzgJdGx
        7jU7iM0ioCqx7PVRxi5GDg5eASuJCTfTIZbJSyxq+A3WyisgKHFy5hMWiDHyEs1bZzND1LRy
        SJyb6wVhu0jM3r0XKi4s8er4FnYIW0riZX8bO8g9EgLNjBLrZ85hgnCmMErMffaUFaLKWGLW
        s3awI5gFNCXW79IHMSUElCWO3ILayyfRcfgvO0SYV6KjTQiiUUnizNzbUGEJiYOzcyDCHhLL
        Zt1hhARVrMTfdQ1sExjlZyF5ZhaSZ2YhrF3AyLyKUSy1oDg3PbXYqMAYHqXJ+bmbGMEpVct9
        B+OMtx/0DjEycTAeYpTgYFYS4a1KeZcoxJuSWFmVWpQfX1Sak1p8iNEUGLoTmaVEk/OBST2v
        JN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVANTpVm3zzsm5QPtVXfV
        356uXL/T71CE/UHuuFkTznl7M9x1VA709Atzswjiad7t0XnF71ho/UwVzon3EssStPf1R+7d
        2BTn6mCoPfunjkPcPrOYOe2HgyVW7D28wubsxNktm3K4f8y+eWi6WNP/lUbd/+13RHk/T/lz
        j2uCwPE3Nh8fnXNfVPP76IUf3++tvyv0+xDXSff0IvmDzA83bp7SvLfKND2kuaxpxcrm039W
        X7794ll5KDPjpz6Lji16L98t9ppx6rxQ9jn2FTbPtedW2dzYFfBJ6oJCg5ONDYuMkU1pgeA9
        UdZdMkox6//t4Z2QerDjh5p1p0rP5V0sSxsN2m8cKDEsX9fZkOl36rCGEktxRqKhFnNRcSIA
        w3KQWTIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO6Nye8SDd5ulLV4MG8bm8XethPs
        Fi9/XmWzOPiwk8Vi2oefzBaf1i9jtVi9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YHLg9Ll/x
        9rjc18vkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWjx+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDKm
        rz3AUrCIt+LKhE+MDYzTuLsYOTkkBEwkti5fydrFyMUhJLCbUeLokjcsEAkJif+Lm5ggbGGJ
        +y1HoIq+MUqcWdLPDJJgE9CQWHPsEBNIQkSgiUliw+f7YN3MAmoSn+8uA7OFBbwkOta9Zgex
        WQRUJZa9PsrYxcjBwStgJTHhZjrEAnmJRQ2/wZbxCghKnJz5BGqMvETz1tnMExj5ZiFJzUKS
        WsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjUtTR3MG5f9UHvECMTB+MhRgkO
        ZiUR3qqUd4lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1
        MJXFLIrabchZ06MeUZCzQzuA5f/7S5o2M/TzFt13COwWTE+R0c95qsqwNeHR1qs8FsteLPP3
        dPgmctyhb+cKv+/T9i2+4fv//U6reS90VnxcvTrtp+h12dL8rE1lCnlhygLqwcsFnWV3esRF
        eRx58/+gXfqHg5vvzjsifC4jJ2Pfka5dGs9Wp3rfty5/s6bx0WuX7cL3Vkmwq/j/fMhjeMVi
        lTW7r2LM/z5Dk923zwiLTlJWc+9hk9h/fubi39u5m7VsHp2vfqzMwy6+wpbzRPuVRxk/5SIk
        l2v9ez7j4lfLH7l9H4Rfzt3Ef5b75Afn+jTXYNZ7j2+7nv3zT/n1w/w/csvPBv9zqpf4bpYm
        kKfEUpyRaKjFXFScCABR0tZF5AIAAA==
X-CMS-MailID: 20220124115608epcas2p4a6af4460f353a320dcc57a359462f356
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124115608epcas2p4a6af4460f353a320dcc57a359462f356
References: <CGME20220124115608epcas2p4a6af4460f353a320dcc57a359462f356@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/scsi/ufs/ufshcd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b440d2e..f6b16e229ad3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4204,6 +4204,18 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 }
 EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
 
+void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
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
@@ -8925,6 +8937,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	 * with the link off, so do not check for bkops.
 	 */
 	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
+	ufshcd_auto_hibern8_disable(hba);
 	ret = ufshcd_link_state_transition(hba, req_link_state, check_for_bkops);
 	if (ret)
 		goto set_dev_active;
-- 
2.26.0

