Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66B749597C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348615AbiAUFfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:35:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:26104 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348580AbiAUFe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:34:59 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220121053459epoutp0440b166e86b87551da5fb6fce2125193a~MMlO9wFpZ0797607976epoutp04e
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:34:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220121053459epoutp0440b166e86b87551da5fb6fce2125193a~MMlO9wFpZ0797607976epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642743299;
        bh=cd4RrMRw6Ah9uJaL465e8L1nMucicozX871fyy/CjXM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nh0fsUJ5rmG2chL1257FF+YIQo6H9QvSALtxhchLiveBJBKDjNxZAmOnEeyOQu9Sm
         B62o/z2g5MRctYQCY49dy8quvGm/5tI77EQaExra0IRp+dGDsb0pyfVn0gdUN8krKM
         vkbCsJ+k8oamUUn4r3klx7P1w1nkg0gsnc/uh6mE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220121053458epcas2p4cff5a42838bbcb3ab9c29715faccad60~MMlOZBxHR0412704127epcas2p4I;
        Fri, 21 Jan 2022 05:34:58 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jg7PC6ZPGz4x9Q1; Fri, 21 Jan
        2022 05:34:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.AD.51767.FF54AE16; Fri, 21 Jan 2022 14:34:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220121053455epcas2p4f2710091dc5f722a220be91243c60eed~MMlLL5YgH0885508855epcas2p4f;
        Fri, 21 Jan 2022 05:34:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121053455epsmtrp1bfbd667c1dee4dba7c2eb15b190da248~MMlLKrzzQ1917019170epsmtrp1J;
        Fri, 21 Jan 2022 05:34:55 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-b0-61ea45ffa669
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.79.29871.DF54AE16; Fri, 21 Jan 2022 14:34:53 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220121053455epsmtip1733c8a0aa335ba8f86ea044cda500892~MMlK7wU5O1999519995epsmtip1Z;
        Fri, 21 Jan 2022 05:34:54 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Date:   Fri, 21 Jan 2022 14:33:02 +0900
Message-Id: <1642743182-54098-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVPe/66tEgyW3ZS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotP65exWqxe/IDFYtGNbUwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uNzXy+SxeM9LJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5Lz
        aD/QzRTAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDA
        wMgUqDAhO+Ng23mmgk88Fd+PbWRvYFzC1cXIySEhYCKxeO9Pxi5GLg4hgR2MEtNbPzOCJIQE
        PjFKPDuRA2F/Y5ToehAF0/Bl3iJmiIa9jBJbzr2Dcn4wSlw5uZ0dpIpNQFPi6c2pTCC2iMB1
        Jol52zNAbGYBdYldE06AxYUFQiUW7p3HCmKzCKhK3J08GayXV8BVou/vVxaIbXISN891gi2Q
        EGjkkJiwZxM7RMJFouvQD0YIW1ji1fEtUHEpiZf9bewQDc2MEjt3N0J1T2GUWLL/A1SVscSs
        Z+1A3RxAJ2lKrN+lD2JKCChLHLnFAnEon0TH4b/sEGFeiY42IYhGZYlfkyZDrZWUmHnzDtRA
        D4ktPd2skNCKlfi45ivrBEbZWQjzFzAyrmIUSy0ozk1PLTYqMIRHUnJ+7iZGcILUct3BOPnt
        B71DjEwcjIcYJTiYlUR4peqfJQrxpiRWVqUW5ccXleakFh9iNAUG2ERmKdHkfGCKziuJNzSx
        NDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE08fEwSnVwOTTLhgbu9WlXY7vlc7N1qVH
        /uQKr9zwQ+vQvW9HrmRpSPlZnD9S31Ew5/JzAcs3rgHZKx+tnx+779Nse1/lJa95HdgaWusz
        Aip0phzO7rPK7OvPOtSTESScMOtrsJT1J6+syQrFeyfOPePxImzpTodvEqt02CU1Lx62/KF6
        KPnJa5vm7Zyblob3tbRdvb6657edb/gh6c2/D9QtPi/FtepN/Jn4C5/a0xZ1n394SKzgu9+L
        O06ftueXhXaIPEpf/WbfVI79ZtukF6dNZFIMVWA2yFzvlmuVaZl8pFzK71h50+kG/W3nfsbY
        15dcLWmZxxkt67RCMNR/maist9aCCesv7jrRtHRrwqNpXif3bVZiKc5INNRiLipOBABTmqz4
        GQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO4/11eJBs/DLU4+WcNm8WDeNjaL
        lz+vslkcfNjJYvF16TNWi0/rl7FarF78gMVi0Y1tTBY3txxlsbi8aw6bRff1HWwWy4//Y7Lo
        unuD0WLpv7csFnfuf2Rx4Pe43NfL5LF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJVxsO08U8EnnorvxzayNzAu4epi5OSQEDCR+DJvEXMXIxeH
        kMBuRom7y/YxQSQkJU7sfM4IYQtL3G85wgpR9I1RYtPCM+wgCTYBTYmnN6cygSREBF4ySbyY
        s4YNJMEsoC6xa8IJsEnCAsESv8/sB2tgEVCVuDt5MpjNK+Aq0ff3KwvEBjmJm+c6mScw8ixg
        ZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREctFqaOxi3r/qgd4iRiYPxEKMEB7OS
        CK9U/bNEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiC
        5hQmiaVXsjJuT1nGOnVJcsDEOe4ndp/6s2ldVq6s58SzHG6CfQI1aTu/n+Df+axRvmnm5xvX
        TKc4fJh/1uX+cV8RuU01Yf9+nXj08WzM0VO8nsJ1sifsF1mkpG5a+Pn00ozkPQuaGU0OCvoU
        NtYsmS4v7/zhyEZnP3a3CTf3zA5zldSLnsO09mJbzpmfe5362nxYuazYLL8fvdL7Zl1Sx4NZ
        to8KWP2slZqulS2bE9aYysgnf/jQ4UO/Qo50nldoYZP4kXDZdW68ldXprZXTZbWu1fVmxerq
        399W+Gr670Xrc9YcXHZlesenBzmtH/p/Ldb7uL2Wb7ak58Wfvvsi3x28MfPWhGc7hQp/bL7e
        q8RSnJFoqMVcVJwIAIZGbnnJAgAA
X-CMS-MailID: 20220121053455epcas2p4f2710091dc5f722a220be91243c60eed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121053455epcas2p4f2710091dc5f722a220be91243c60eed
References: <CGME20220121053455epcas2p4f2710091dc5f722a220be91243c60eed@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3: change the value of ret only if it's positive
v1 -> v2: modify the comment of ufshcd_set_dev_pwr_mode

The return value of ufshcd_set_dev_pwr_mode is given to
device pm core. However, the function currently returns a result
in scsi command and the device pm core doesn't understand it.
It might lead to unexpected behaviors of user land. I found
the return value led to platform reset in Android.

This patch is to use an generic code for SSU failures.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1049e41..25e08a3 100644
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
@@ -8667,8 +8667,11 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
 			    pwr_mode, ret);
-		if (ret > 0 && scsi_sense_valid(&sshdr))
-			scsi_print_sense_hdr(sdp, NULL, &sshdr);
+		if (ret > 0) {
+			if (scsi_sense_valid(&sshdr))
+				scsi_print_sense_hdr(sdp, NULL, &sshdr);
+			ret = -EIO;
+		}
 	}
 
 	if (!ret)
-- 
2.7.4

