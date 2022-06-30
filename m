Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971EF560FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiF3EQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3EQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:16:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738963206B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:16:06 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220630041604epoutp0114ca6c4d83b9765fd5ab66ef7f2c7c36~9SuAaMHAw0716007160epoutp01o
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:16:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220630041604epoutp0114ca6c4d83b9765fd5ab66ef7f2c7c36~9SuAaMHAw0716007160epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656562564;
        bh=DZoUVfy5aUPNeZ5oLtZlbxhLYaJtK9AlkneUo9epumM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DUUZJlXPEfY0/sBya+VF/7YACKNHzzA3pX65kD5MJVuvP6bcdmKzkL1taGUH/obGZ
         fAm8pu7hfTAXjOcQRtwmO32FEKoMF+AsP4+Xm0k7QR0HArwVAmoisR4Xbe7V0t7owF
         4jkvzIpcA0NEuCVHOgdEIuy2BM/srPSzlQ4OyDKw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220630041603epcas1p39c428f856066d6282b0f1d7ad886f7a9~9St-z80E32840228402epcas1p3U;
        Thu, 30 Jun 2022 04:16:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LYQ4M4668z4x9Pw; Thu, 30 Jun
        2022 04:16:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.7E.09661.3832DB26; Thu, 30 Jun 2022 13:16:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603~9St-KPOyX2821528215epcas1p3M;
        Thu, 30 Jun 2022 04:16:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220630041602epsmtrp2d00ad6178ab1c937dbd9bd0017e43d75~9St-JWdM32097120971epsmtrp2x;
        Thu, 30 Jun 2022 04:16:02 +0000 (GMT)
X-AuditID: b6c32a37-2cfff700000025bd-58-62bd23836131
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.B7.08905.2832DB26; Thu, 30 Jun 2022 13:16:02 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220630041602epsmtip1b467428961970a7dd5abfc55eaa4f3fd~9St_43dAT1966919669epsmtip1B;
        Thu, 30 Jun 2022 04:16:02 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] scsi: ufs: no sw reset after last linkstartup fail
Date:   Thu, 30 Jun 2022 13:48:04 +0900
Message-Id: <20220630044804.6080-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmgW6z8t4kg+tz5CwezNvGZvHy51U2
        i2kffjJbzDjVxmqx79pJdotff9ezW3RsncxksejGNiaLHc/PsFvs+tvMZHF51xw2i+7rO9gs
        lh//x2TR9Gcfi8W1MydYLTZf+sbiIOBx+Yq3x4RFBxg9Pj69xeLRt2UVo8fnTXIe7Qe6mQLY
        orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZk
        Zxx7Zlpwgr3i6uZHTA2MvWxdjJwcEgImEu/vzAWyuTiEBHYwSnyfc5QdwvnEKLGx8SwrhPON
        UeLq04OsMC0nH51mArGFBPYyShxdZAdR9JlRYvnEFrAEm4CWxPRNW5hAEiICm4ASC2awgDjM
        Ah8YJX71rQSrEhZwllizeRnYJSwCqhJXDu0GKuLg4BWwlJgxtRZim7zEn/s9zCA2r4CgxMmZ
        T1hAbGagePPW2cwgMyUEZnJIrLs/Geo8F4mL889C2cISr45vYYewpSQ+v9sL9XWxRNu/f8wQ
        doXEwb4vULaxxKfPnxlBbmAW0JRYv0sfIqwosfP3XEaIvXwS7772sIKUSAjwSnS0CUGUKEu8
        fLSMCcKWlFjSfgtqoofEtlMXWSGBFStxdNk/lgmM8rOQfDMLyTezEBYvYGRexSiWWlCcm55a
        bFhgDI/U5PzcTYzgpKtlvoNx2tsPeocYmTgYDzFKcDArifAuPLMzSYg3JbGyKrUoP76oNCe1
        +BCjKTB4JzJLiSbnA9N+Xkm8oYmlgYmZkYmFsaWxmZI476pppxOFBNITS1KzU1MLUotg+pg4
        OKUamNhF2oIqrbeGLQ+KEDQzrvna37Vr86Qqp5jagDOv698tjuHub23tK7oysaVy36Xly1W4
        Nk4vVNznIMOyoLhEy9w1QqDjFtePvNotCQLbUhISpqTsmB0Q/3brzrCAKQqe3XsZDhy0zK18
        OUdG8NWPVfyL+ookAw+dXtjwalmuKW9R9NxyOwPutI3XG9v5m2qKJffmqRUcUlf+XXinTHxB
        wKJb6xkff7n5cH+4b+yBvt0u3pvCoxd/eDtl0zufKzq7f9+fvXvW6Rqx/b9CleKyuEQSXmk+
        NVFYyK74sKp8y9KZlYsTI5aY/JNXeblH+ke27trjeuzTtkaz/PeYKKgn+DN//yo15VWCe7Rf
        dAfqK7EUZyQaajEXFScCAL/Lj3RDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnG6T8t4kg6MrTCwezNvGZvHy51U2
        i2kffjJbzDjVxmqx79pJdotff9ezW3RsncxksejGNiaLHc/PsFvs+tvMZHF51xw2i+7rO9gs
        lh//x2TR9Gcfi8W1MydYLTZf+sbiIOBx+Yq3x4RFBxg9Pj69xeLRt2UVo8fnTXIe7Qe6mQLY
        orhsUlJzMstSi/TtErgyjj0zLTjBXnF18yOmBsZeti5GTg4JAROJk49OM3UxcnEICexmlLjY
        vJAdIiEpsfjRQ6AiDiBbWOLw4WKQsJDAR0aJlnnVIDabgJbE9E1bwHpFBHYxSsyY+JYRxGEW
        +MUosWPqMrANwgLOEms2Q9gsAqoSVw7tZgEZyitgKTFjai3ELnmJP/d7mEFsXgFBiZMzn7CA
        2MxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcBRo
        ae5g3L7qg94hRiYOxkOMEhzMSiK8C8/sTBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qByXf3bmGHq5dNMs9WcVbuUU/MV7/h5CUm9u1Og3Pv6eTd/RLL
        vk8+9T4k3PnVp0h+v9vfAtLu9rOUHtZ9M6VWpzBHOOf/ncybMpr74qWnf5//18b2UGgNb/RF
        Ho29v2TE4plPd2stvvxktepbob1xHlPfNG/+cky9YM5TlhPcH32jjjJNbS9rWTp5QWvKp2SZ
        syGKFrePO/RzBbh9/lQwf9L9m3/Lnn+0dFQ3mincayp7wi2+JuPRw5X7Jm5QvcSb4CY3zTfK
        KyN63+MJ0pI+Of8lnX1bFn0wtv99tjqoMn93wVH22LPPJs+9+7XyjPnyK7WfrfOzI27vvmC8
        1jFhReC9r1u9RELsXugpaM4oUWIpzkg01GIuKk4EAPi654TxAgAA
X-CMS-MailID: 20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603
References: <CGME20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host driver resets the host(ufshcd_hba_enable) after last linkstartup
command failed. All of the member or host dump after linkstartup fail are
reset value because of sw reset.

Signed-off-by: Junwoo Lee <junwoo80.lee@samsung.com>
Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7c1d7bb9c579..2cdc14675443 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4753,7 +4753,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 		 * but we can't be sure if the link is up until link startup
 		 * succeeds. So reset the local Uni-Pro and try again.
 		 */
-		if (ret && ufshcd_hba_enable(hba)) {
+		if (ret && retries && ufshcd_hba_enable(hba)) {
 			ufshcd_update_evt_hist(hba,
 					       UFS_EVT_LINK_STARTUP_FAIL,
 					       (u32)ret);
-- 
2.29.0

