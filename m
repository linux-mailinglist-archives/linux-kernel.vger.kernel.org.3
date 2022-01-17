Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB17B4905F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiAQKbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:31:15 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46980 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiAQKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:31:14 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220117103111epoutp04d5955a34e4730cfb73e0b07e0d0a7a28~LCCtYzSll1036110361epoutp04g
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220117103111epoutp04d5955a34e4730cfb73e0b07e0d0a7a28~LCCtYzSll1036110361epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642415471;
        bh=oOUoKZ4pBdpP3x9g04SzNvA59acLArOtLwiamwa5u8Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AbHYzrg01olZMFkbzgOM0Gsj2ypi0y0ioxPU2rkQwQrjyn9jxzE/fsAY4MVcLcl4p
         +DMh+R8n8Eq9z+xz1A27mjDh/6aeFvP2uqZVSCeIcosNrie/6YW4WtsPIYg5XtrOnq
         GJjRjC4A0VogpMpI23TzudYkx4t3KgT0ZqPBmg34=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220117103110epcas2p4560f82a9c2500bf27e23583ee619a0ea~LCCs1l4VG0461104611epcas2p4C;
        Mon, 17 Jan 2022 10:31:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jcp8r1ZWgz4x9QB; Mon, 17 Jan
        2022 10:31:08 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.02.51767.C6545E16; Mon, 17 Jan 2022 19:31:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220117103107epcas2p3d7223ff63f6cb575316695cc8fb155a4~LCCp1i35u1059510595epcas2p3w;
        Mon, 17 Jan 2022 10:31:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220117103107epsmtrp11f0ad2c19eb0d7e15dd4eb4be200dcc0~LCCp0lKq31325113251epsmtrp1D;
        Mon, 17 Jan 2022 10:31:07 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-f0-61e5456c6e47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.CF.29871.B6545E16; Mon, 17 Jan 2022 19:31:07 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220117103107epsmtip24a13e2628164eb1e8d0470e292916b88~LCCpkjdYe0105301053epsmtip2I;
        Mon, 17 Jan 2022 10:31:07 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Date:   Mon, 17 Jan 2022 19:29:21 +0900
Message-Id: <1642415361-140388-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTXDfH9WmiwfRbHBYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnfF6Uhd7QQN7xfI10g2MV1m7GDk5JARMJHbs7QSyuTiEBHYwSmxdd5wFwvnEKLHh
        fg8jhPONUeL4jC0sMC3vF/5gh0jsZZSYdn0fVMsPRolV7YvAqtgENCWe3pzKBGKLCFxnkpi3
        PQPEZhZQl9g14QRYXFggVKKp5R2YzSKgKrGleS0ziM0r4Cax4tJNRohtchI3z3UygyyQEPjL
        LtGy6SgTRMJF4vqfOVAnCUu8Or6FHcKWknjZ38YO0dDMKLFzdyNU9xRGiSX7P0BVGUvMetYO
        tIID6CRNifW79EFMCQFliSO3WCAO5ZPoOPyXHSLMK9HRJgTRqCzxa9JkqNskJWbevAM10EPi
        1LJ7YLaQQKzEy28bWCYwys5CmL+AkXEVo1hqQXFuemqxUYEhPJaS83M3MYJTpJbrDsbJbz/o
        HWJk4mA8xCjBwawkwnuM+0miEG9KYmVValF+fFFpTmrxIUZTYIBNZJYSTc4HJum8knhDE0sD
        EzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MZV9/PWbouHW819PGnXFxbp2n
        oNncJpk5LCHGCre9ZBoEc3pLqizsROL59osf/2ow2aBB6L3OZLXur9923V5wdebE4Oeyt8zV
        QmSXsPTy5FxaI5TP7GUsp3Bkg7u/V1GYw9w95TyVIvIed3bWXeu2LjvtfzK1UfxaTNLcrmcu
        YmbbdJ8FPyy+X6H9I1QprPnNTT+VrdsuannceXCO5+O5wrOmAg8z/rS/2PF2p9hMvnf83P/K
        xLknMvZ4fXzvluhrOYmjui2D12G98OtpH1N+LWu1fqM5a8nCOWsYm3gzux4ue3umnncqy/za
        tNTWSMslqSfet3afYnpsP6lF9uV15mTlXctaryUZlzK3f1RiKc5INNRiLipOBACdpmpCGgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvG6269NEg5abMhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiOKySUnNySxLLdK3S+DKeD2pi72ggb1i+RrpBsarrF2MnBwSAiYS7xf+YO9i5OIQ
        EtjNKLF7Uy8TREJS4sTO54wQtrDE/ZYjrBBF3xgl9jxvYwNJsAloSjy9OZUJJCEi8JJJ4sWc
        NWAJZgF1iV0TToBNEhYIlri/dRMziM0ioCqxpXktmM0r4Cax4tJNqA1yEjfPdTJPYORZwMiw
        ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOGi1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe
        Y9xPEoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgMns8
        UWwPS92k2+u3z2GtXWjkMfWW7jHZ/IWqWupS377EXk/cHrx/bmr6vnPV+gX3Xj56+iTtWOTa
        6rJIxY78aeX3T257xnfnQdWPKleD68Kfih9VPWDuY3Fcf/yVZGVZwo0Pl51lRZYs67XjOsr5
        PlHvvq1hxtMZ/b/611UtOeZX+zdxi5lmTI7qI965aXp7H0sF3Pn3tvqO29QHDCuczS7U7GKR
        CHAKWbvXTm+RYfG9trbWFNNiH4Hv1074rap0/VNev1PjnMiVmbdn/fkytWWvTcCFYK/zO57L
        51zv/Mhw71WmtYVSgkBifsIpvjD5RXuEYrU/5N3x2PXNfFoHt7NZzaeLdpGzRdayFfLoKLEU
        ZyQaajEXFScCAKD+/TXJAgAA
X-CMS-MailID: 20220117103107epcas2p3d7223ff63f6cb575316695cc8fb155a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220117103107epcas2p3d7223ff63f6cb575316695cc8fb155a4
References: <CGME20220117103107epcas2p3d7223ff63f6cb575316695cc8fb155a4@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of ufshcd_set_dev_pwr_mode is given to
device pm core. However, the function currently returns a result
in scsi command and the device pm core doesn't understand it.
It might lead to unexpected behaviors of user land. I found
the return value led to platform reset in Android.

This patch is to use an generic code for SSU failures.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1049e41..a60816c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8669,6 +8669,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 			    pwr_mode, ret);
 		if (ret > 0 && scsi_sense_valid(&sshdr))
 			scsi_print_sense_hdr(sdp, NULL, &sshdr);
+		ret = -EIO;
 	}
 
 	if (!ret)
-- 
2.7.4

