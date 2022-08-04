Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB515898C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiHDHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiHDHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:54:49 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516265563
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:54:47 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220804075446epoutp02d403dbf1f33c7cf03f9afd02913f33a1~IFR8p4AM00120201202epoutp02t
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:54:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220804075446epoutp02d403dbf1f33c7cf03f9afd02913f33a1~IFR8p4AM00120201202epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599686;
        bh=XtcvaO1W4P081UtJnWgJw6I/Hch0C2TTlWxmPi8S/Xk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=RWgP1TqKnWF6elriirVU5LZMenyZcEIq+valjRGjpktx3TTcPQTYsYEHbIGV5PeNT
         x9idTQV/Q66si6KJKjLQ7hzoLmXpwf4kRtjoGieDWPAmQBwfbkizNd24BPyM3YIf5p
         pa5VywcArpSyybQAg/yypjbgh/TRL+aGTpOn+PDA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220804075445epcas2p1a84995558f7bcb8cf7e0f3f711b9677a~IFR8R95840340303403epcas2p1u;
        Thu,  4 Aug 2022 07:54:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lz1GY2PV4z4x9QB; Thu,  4 Aug
        2022 07:54:45 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-84-62eb7b45b081
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.84.09642.54B7BE26; Thu,  4 Aug 2022 16:54:45 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 4/6] scsi: ufs: wb: Introduce
 ufshcd_is_wb_buf_flush_allowed() to improve readability
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804075444epcms2p4a0520880262281f02be65ce0fe50602d@epcms2p4>
Date:   Thu, 04 Aug 2022 16:54:44 +0900
X-CMS-MailID: 20220804075444epcms2p4a0520880262281f02be65ce0fe50602d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmma5r9eskg3nbeCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnfHn2We2gnsiFbfu
        FjQwfhTsYuTkkBAwkTjZdJG5i5GLQ0hgB6PEtY1r2boYOTh4BQQl/u4QBqkRFsiSuPq+gw3E
        FhJQkji3ZhYjSImwgIHErV5zkDCbgJ7EzyUzwEpEBNpYJNafZocYzysxo/0pC4QtLbF9+Vaw
        Vk4BP4n7h7MgwhoSP5b1MkPYohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKFDX8EO
        lhDIl9hwIBAiXCPxdvkBqBJ9iWsdG8Eu4BXwlZj85gXYGBYBVYnfR9azQdS4SDQ9PwQWZxaQ
        l9j+dg4zyEhmAU2J9bv0IaYrSxy5xQLzU8PG3+zobGYBPomOw3/h4jvmPWGCaFWTWNRkBBGW
        kfh6eD77BEalWYgwnoVk7SyEtQsYmVcxiqUWFOempxYbFRjDYzU5P3cTIzjBarnvYJzx9oPe
        IUYmDsZDjBIczEoivCssXycJ8aYkVlalFuXHF5XmpBYfYjQFengis5Rocj4wxeeVxBuaWBqY
        mJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCUamDKfxWt/yiddaXFzOUui8/HLNB7
        IM/iHtwcvmhR5EfLRda8wZkeUlFpM8rvGkw9lSfx0GH61raenqsf6zZIyjhMDC2N2Nmqf2Se
        12XlTWdzRCbNKFdguMW1OHbJhqU5OXqLzpmcivCZuXr3shd5T3vfl03LfPnruO20ORcW6bjd
        V0v56/dImimq8VbC+gXcl+OPsh44zfMgRC9RYq3BiXs9WxUSvrR8WyndeaWIfa/LtdOOu/Qm
        rDJbecRB406Ua8qv4kUTtr9vPZfC016u6nU5YNkaln8pJ969krY8HjgheqvnI7OGx4rdq6Mv
        LK6dWmFwsoaTy3ryJ6+uU5MkNGJtEmfdbHVqvlyYMas0Z7+MEktxRqKhFnNRcSIAs49IeTkE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The explicit flushing should check the following.
	- UFSHCD_CAP_WB_EN
	- UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

Changed to improve readability.

Acked-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c   | 3 +--
 drivers/ufs/core/ufshcd-priv.h | 6 ++++++
 drivers/ufs/core/ufshcd.c      | 5 +++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 8fe3d6e51cc8..5a571960c93a 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -271,8 +271,7 @@ static ssize_t enable_wb_buf_flush_store(struct device *dev,
 	unsigned int enable_wb_buf_flush;
 	ssize_t res;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+	if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
 		dev_warn(dev, "It is not allowed to configure WB buf flushing!\n");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 8f67db202d7b..d00dba17297d 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -26,6 +26,12 @@ static inline u8 ufshcd_wb_get_query_index(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline bool ufshcd_is_wb_buf_flush_allowed(struct ufs_hba *hba)
+{
+	return ufshcd_is_wb_allowed(hba) &&
+		!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
+}
+
 #ifdef CONFIG_SCSI_UFS_HWMON
 void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask);
 void ufs_hwmon_remove(struct ufs_hba *hba);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b7b8efd17659..5099d161f115 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -294,7 +294,8 @@ static void ufshcd_configure_wb(struct ufs_hba *hba)
 	ufshcd_wb_toggle(hba, true);
 
 	ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, true);
 }
 
@@ -5815,7 +5816,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, false);
 
 	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
-- 
2.25.1
