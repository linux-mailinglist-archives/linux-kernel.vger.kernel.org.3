Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9A4945FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358287AbiATDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:15:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44888 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358274AbiATDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:15:03 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220120031502epoutp010a821c2f6f129e755c5c3b5bf8afc795~L3BwHPM_y0339903399epoutp01X
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220120031502epoutp010a821c2f6f129e755c5c3b5bf8afc795~L3BwHPM_y0339903399epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642648502;
        bh=n8b5oCAnKAEBwkflbch7/0jfrizlmn1DkP6+toSRWT0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jZ/eeldofwzev/vyB20LkHmiytGu3ZjqEdb1NzAXcdn8KB88TwnBBnaE3Czv9a+hf
         SOHQ9XWGSQ0QORQgITCW9rlXNsf0ksKmO17fXh+IuSHb6gcav6n6eL3Rxmh72oMaqY
         1X07zoNl8bhYSPE+OoL6c738tFn6SNkBMmrLWICk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220120031501epcas2p350c29dfb76ec4153ab379ba6c6ebe69d~L3BvSMfm60189301893epcas2p3d;
        Thu, 20 Jan 2022 03:15:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JfSLB1qS7z4x9Q8; Thu, 20 Jan
        2022 03:14:58 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.D1.12141.2B3D8E16; Thu, 20 Jan 2022 12:14:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220120031457epcas2p2ae55ef07581ed699a49b27391d7ab133~L3Br_LsuL2781327813epcas2p2y;
        Thu, 20 Jan 2022 03:14:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220120031457epsmtrp1872b1663c8117d7731ebf099a9c40b37~L3Br3H5cE1062210622epsmtrp1M;
        Thu, 20 Jan 2022 03:14:57 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-99-61e8d3b1dbab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.1B.08738.1B3D8E16; Thu, 20 Jan 2022 12:14:57 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220120031457epsmtip2d713d752fc1a4644e094e9159bfff4a5~L3BrsA6Nu0511505115epsmtip2g;
        Thu, 20 Jan 2022 03:14:57 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v2] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Date:   Thu, 20 Jan 2022 12:13:09 +0900
Message-Id: <1642648389-189554-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTXHfT5ReJBkuuM1ucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsbm45ymJxedccNovu6zvYLJYf/8dk
        0XX3BqPF0n9vWSzu3P/I4sDvcbmvl8lj8Z6XTB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn
        0X6gmymAIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoeiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGB
        gZEpUGFCdsaqqfcZC55wVUzYu4CtgfEyRxcjJ4eEgIlEy79vbF2MXBxCAjsYJaZ0fWYBSQgJ
        fGKU2HyJB8L+zCjxeGUhTMPHvbfZIRp2MUrcub2JGcL5wSjx9tc6VpAqNgFNiac3pzKB2CIC
        15kk5m3PALGZBdQldk04ARYXFoiReH18CjOIzSKgKjH54zewzbwCbhIL1s5mgdgmJ3HzXCfY
        AgmBRg6JtXshmiUEXCT2TZgJZQtLvDq+hR3ClpJ42d/GDtHQzCixc3cjVPcURokl+z9AVRlL
        zHrWztjFyAF0kqbE+l36IKaEgLLEkVssEIfySXQc/ssOEeaV6GgTgmhUlvg1aTIjhC0pMfPm
        HaiBHhKPnl9nhoRWrMSz43PZJzDKzkKYv4CRcRWjWGpBcW56arFRgQk8kpLzczcxghOklscO
        xtlvP+gdYmTiYDzEKMHBrCTCK1X/LFGINyWxsiq1KD++qDQntfgQoykwwCYyS4km5wNTdF5J
        vKGJpYGJmZmhuZGpgbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBqaNy9672Mxk+Tf/2KGo
        PZ8b3RPCpthxpfs+OvbDftanruOmfMkpJ29LXtjjsbVKIoX57aEztoeeM26pdNhto7+n8Ur1
        uyiH6iOxzumZv4wY+PT/GtY8Ufnd9u5+wJwgqSDO8yaXeF1X3TAMVlmvXPi6KmGWe/bGgy+L
        nAwitqzcL3vYf2OrYWIP99urCxaazJ6lLnDn+2++kD3lqzUnizz/e+pC4KfDf1jDbzjGK50W
        XfE2kIH7z7nFumnOjI+8Is9cYdZ5lN/gKGTvxsK1VEh7mf/B0Em2c7pPpBrPufn6zwLtKQ/7
        wzsSM142WEatLl54sWHD9zMzZrWHrtnrdvST3WzeK+aNvQIXX6hlqfAqsRRnJBpqMRcVJwIA
        vraqWhkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO7Gyy8SDe48kLA4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vF16XPWC0+rV/GarF68QMWi0U3tjFZ3NxylMXi8q45bBbd13ewWSw//o/J
        ouvuDUaLpf/esljcuf+RxYHf43JfL5PH4j0vmTwmLDrA6PF9fQebx8ent1g8+rasYvT4vEnO
        o/1AN1MARxSXTUpqTmZZapG+XQJXxqqp9xkLnnBVTNi7gK2B8TJHFyMnh4SAicTHvbfZQWwh
        gR2MErfee0HEJSVO7HzOCGELS9xvOcLaxcgFVPONUWLLp2Y2kASbgKbE05tTmUASIgIvmSRe
        zFkDlmAWUJfYNeEEE4gtLBAl0XNgB9gkFgFVickfv7GA2LwCbhIL1s5mgdggJ3HzXCfzBEae
        BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgoNWS2sH455VH/QOMTJxMB5ilOBg
        VhLhlap/lijEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD
        k1zY77XHLB9Z3OAzF68Rvvc8lUst8kiMv5K/2N/purOzXhr9Ugxd8XejyW7ro5PsctzFT1xK
        Dc/sW2eWp9c6+Uhgz2HDov691t+aXvQstJ+yafuRcynydY9cH82aXVw2iXP3+twOl+jD5y0f
        dcyMP1HSxcF8+344y8Qnotf/bnjba8mj9MydreDR0d9z3lzfZaX2Uznq1zKfpnyBCeqlOlW5
        tXGqVdwC7E05TWbivV3yj2PzN8gfvfrp+YK9l4QdXv+u+Wt+VOCKQda5E9LeC++cPrJmxoxP
        ZSJXKyZmG6i2t/m/0d9zw/50d+qsdXZNK6I/L159bdYTv1UBdu48Ep38Xyd+aKiZcHDza92t
        X5VYijMSDbWYi4oTAdEIrEXJAgAA
X-CMS-MailID: 20220120031457epcas2p2ae55ef07581ed699a49b27391d7ab133
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120031457epcas2p2ae55ef07581ed699a49b27391d7ab133
References: <CGME20220120031457epcas2p2ae55ef07581ed699a49b27391d7ab133@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: modify the comment of ufshcd_set_dev_pwr_mode

The return value of ufshcd_set_dev_pwr_mode is given to
device pm core. However, the function currently returns a result
in scsi command and the device pm core doesn't understand it.
It might lead to unexpected behaviors of user land. I found
the return value led to platform reset in Android.

This patch is to use an generic code for SSU failures.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1049e41..472c382 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8613,7 +8613,7 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
  * @pwr_mode: device power mode to set
  *
  * Returns 0 if requested power mode is set successfully
- * Returns non-zero if failed to set the requested power mode
+ * Returns < 0 if failed to set the requested power mode
  */
 static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 				     enum ufs_dev_pwr_mode pwr_mode)
@@ -8669,6 +8669,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 			    pwr_mode, ret);
 		if (ret > 0 && scsi_sense_valid(&sshdr))
 			scsi_print_sense_hdr(sdp, NULL, &sshdr);
+		ret = -EIO;
 	}
 
 	if (!ret)
-- 
2.7.4

