Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809784873D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiAGIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:03:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31439 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiAGIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:03:41 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220107080339epoutp043d4f96082143b20e2b126dbab34d20a9~H7lC6Fz7f2798627986epoutp04X
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:03:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220107080339epoutp043d4f96082143b20e2b126dbab34d20a9~H7lC6Fz7f2798627986epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641542619;
        bh=gnQx+Skwvcz67HwZPZedRVNzu5VwA38Z33/H7k1Y1LQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RlnjnpjBfSd3WUqnBrpKBXKeWvc3p6RbLCALkDD9Og2K2Ncxv46eCfTP4RYB8tYHu
         RgfDPu8v57Sd8oaeJrGdYWIkVtQA3QBvRqFACZSkaUZYw+3oQBQDDtEi+6lfePVfsp
         FrINxSPgZTGE9blrBUi6s6S4Yk0WNOgqNog2/uu8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220107080338epcas2p4f3c86f595c063b869991fa6fff3c1ff3~H7lCQmJ2k1858718587epcas2p4g;
        Fri,  7 Jan 2022 08:03:38 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JVbMF1ytDz4x9QL; Fri,  7 Jan
        2022 08:03:37 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.D7.12141.4D3F7D16; Fri,  7 Jan 2022 17:03:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220107080332epcas2p216d8123df110623b4287ebf6879f745f~H7k8UWBRZ0040200402epcas2p26;
        Fri,  7 Jan 2022 08:03:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220107080332epsmtrp1b38096a14322a1eb5b97538ae09a1639~H7k8TE6ya1456714567epsmtrp1-;
        Fri,  7 Jan 2022 08:03:32 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-d0-61d7f3d42624
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.8F.08738.4D3F7D16; Fri,  7 Jan 2022 17:03:32 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220107080332epsmtip2a28c2edaa072593503d07b866de2f34c~H7k8BQFLe1978619786epsmtip2x;
        Fri,  7 Jan 2022 08:03:32 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwmad.kim@samsung.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        grant.jung@samsung.com, junwoo80.lee@samsung.com,
        bhoon95.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: modify Tactive time setting conditions
Date:   Fri,  7 Jan 2022 04:48:04 +0900
Message-Id: <20220106194804.23892-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmqe6Vz9cTDc6et7Z4MG8bm8XethPs
        Fi9/XmWzOPiwk8Xi69JnrBbTPvxktvi0fhmrxa+/69ktVi9+wGKx6MY2Jotdf5uZLG5uOcpi
        cXnXHDaL7us72CyWH//H5MDvcfmKt8flvl4mjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
        A3S8kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDA
        yBSoMCE7Y9rrjUwFszgq3m34z9TA+IGti5GDQ0LARGJvq1oXIxeHkMAORonjV+axQjifGCX2
        rzoB5XxmlGj+tZy9i5ETrGPH6nuMEIldjBJ7J5xnh3B+MErc61zJBFLFJqAhsebYISaQhIjA
        LSaJ/XfaWEESzAJqEp/vLmMBsYUFXCV+XTzBDGKzCKhKXFj0HSzOK2ApcejCFUaIdfISixp+
        M0HEBSVOznzCAjFHXqJ562xmkAUSAnM5JHb+/wt1n4vEj+Mn2SBsYYlXx7dAxaUkXva3sUM0
        NDNKrJ85hwnCmcIoMffZU1aIKmOJWc/aGUFhwyygKbF+lz4kmJQljtyCWswn0XEYZBdImFei
        o00IolFJ4szc21BhCYmDs3Mgwh4Ss7csB5snJBAr8fWe5gRG+VlInpmF5JlZCFsXMDKvYhRL
        LSjOTU8tNiowgUdqcn7uJkZw+tXy2ME4++0HvUOMTByMhxglOJiVRHin7r2WKMSbklhZlVqU
        H19UmpNafIjRFBi8E5mlRJPzgRkgryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQQHpiSWp2ampB
        ahFMHxMHp1QD06wjVxmzd7LV/3Dwkcq0qY9x6Jx5n1PT9i9zxLQg/oWXRRdvSOrpnFtxWWR9
        v5Dewu1xV1dV55o4q1dFvX96chJXTc396rg32edOb73F9kOTecobSa+VdmaGExatqWSs0Xy2
        0yjr1ms/Tv8dx9Te5m+NnnB0aeTSLX4F//Zc8ql5cl5//9XdVp4xBm/k3E0c3rf/VrNfs+rr
        xiNy5trrJKsfm2x9tbz5sFZ6fvPsve+Tnk74yCkc7l3oWCOmveGbx/nvV3rrmhWaX21iebzX
        /fiL3F2+h3pebVrssb74FNPp062FX1rMnf2nMNuUTbl/de+5f1zTsnn6atqX39t3pfpbjvea
        ST8UW4JrtIR/FyixFGckGmoxFxUnAgCtt0tUSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO6Vz9cTDfb/kbF4MG8bm8XethPs
        Fi9/XmWzOPiwk8Xi69JnrBbTPvxktvi0fhmrxa+/69ktVi9+wGKx6MY2Jotdf5uZLG5uOcpi
        cXnXHDaL7us72CyWH//H5MDvcfmKt8flvl4mjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJUx7fVGpoJZHBXvNvxnamD8wNbFyMkhIWAisWP1PcYuRi4O
        IYEdjBL9R+8wQSQkJP4vboKyhSXutxxhhSj6xihx9NAmVpAEm4CGxJpjh5hAEiICb5gkLu86
        wQySYBZQk/h8dxkLiC0s4Crx6yJEnEVAVeLCou9gcV4BS4lDF64wQmyQl1jU8JsJIi4ocXLm
        ExaIOfISzVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        qNDS2sG4Z9UHvUOMTByMhxglOJiVRHin7r2WKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTIr6rbxfE8T3PObbL0SHncPo0yWt39O/8emazlK3vvJ7c
        Ge91O3cYqUXLvvqj23iozJjjf+6jGtdDR9ekqitnbGV8z+m6z7jAMPTa174AEy7laR8bmwSK
        Y7bqXm+x9UwtqWavPLaOT6JUcpp/18Fww4fLyyd8bVw3w4PN2NdK17rgc5+ayBmn83o+AXIl
        a11vde9I5NJsKFxQvezDh333jXX+aobJdlzNqNOVqzPICNpw0nP1jkb3fdM93WI/fRStdJky
        z/nOnMZfu5riXPfqXtbsM9ta2+v3oyLIZeHuhDWzmvw0n107rlAeHr9cbdmFW0+2srzqmNW7
        uyX197PApKVifQ+4RJMigidO2K3EUpyRaKjFXFScCADYJSXj+QIAAA==
X-CMS-MailID: 20220107080332epcas2p216d8123df110623b4287ebf6879f745f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107080332epcas2p216d8123df110623b4287ebf6879f745f
References: <CGME20220107080332epcas2p216d8123df110623b4287ebf6879f745f@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tactive time determine the waiting time before burst
at hibern8 exit and is determined by H/W at linkup state
However, in the case of samsung devices, guided host's Tactive time +100us
for stability.
If the HCI's Tactive time is equal or greater than the device, +100us should be set.

Change-Id: Ie9b502c69264d3e5931ee8b515388094441fa065
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1049e41abd5b..460d2b440d2e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7815,7 +7815,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 	peer_pa_tactivate_us = peer_pa_tactivate *
 			     gran_to_us_table[peer_granularity - 1];
 
-	if (pa_tactivate_us > peer_pa_tactivate_us) {
+	if (pa_tactivate_us >= peer_pa_tactivate_us) {
 		u32 new_peer_pa_tactivate;
 
 		new_peer_pa_tactivate = pa_tactivate_us /
-- 
2.26.0

