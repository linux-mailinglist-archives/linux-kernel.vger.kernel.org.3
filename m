Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52FB4945E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358230AbiATCyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:54:55 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:25206 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358223AbiATCyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:54:54 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220120025451epoutp0120bef57543b45a79af707c79298fb100~L2wJKG6rF1776517765epoutp01j
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:54:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220120025451epoutp0120bef57543b45a79af707c79298fb100~L2wJKG6rF1776517765epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642647292;
        bh=XQPpNCY6o9L6wI8RYMdTURx1HEPzXmGZ/31T3HsHNBE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XuYyB/SWmB9PwMxgBX1NOV5gn//jsX47Ou9dajYJSM5+NB85Gx6acZa9rhvK6OLMQ
         6T4F3ayhsjABXnHfau3O48gZ3bCaiBfz8kFANNraWO3+9CoIyHBW1DAPnpUqSTwwez
         h1ns/QV31bwS3WLaA43VwACzPSvuFsqdn6dLXUHY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220120025450epcas2p23ebf0d86750b3ec8db6dd97c618c1b93~L2wIMPy141051510515epcas2p2o;
        Thu, 20 Jan 2022 02:54:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JfRtw0qJdz4x9QC; Thu, 20 Jan
        2022 02:54:48 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.5C.51767.7FEC8E16; Thu, 20 Jan 2022 11:54:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220120025447epcas2p119e36c27179527429e4df7cbee87dd84~L2wEnnY0K0835608356epcas2p1I;
        Thu, 20 Jan 2022 02:54:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220120025447epsmtrp202dc6963bbd2992684618addf1c19bc5~L2wEmqevl2886928869epsmtrp2b;
        Thu, 20 Jan 2022 02:54:47 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-22-61e8cef74d7e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.98.29871.6FEC8E16; Thu, 20 Jan 2022 11:54:46 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220120025446epsmtip172d3861e3b08138334a0d633e2d0575c~L2wEVThQr0968309683epsmtip1k;
        Thu, 20 Jan 2022 02:54:46 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Date:   Thu, 20 Jan 2022 11:52:55 +0900
Message-Id: <1642647175-189097-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTTPfHuReJBr92MVqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsbm45ymJxedccNovu6zvYLJYf/8dk
        0XX3BqPF0n9vWSzu3P/I4sDvcbmvl8lj8Z6XTB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn
        0X6gmymAIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoeiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGB
        gZEpUGFCdsaM2x0sBbvZK34vX87SwNjK1sXIySEhYCKxdfEqxi5GLg4hgR2MEs2P1rNCOJ8Y
        JWbu62aGcL4xSryd/o0FpuXwhdVsEIm9jBKta+YwQTg/GCU+LpvLCFLFJqAp8fTmVCYQW0Tg
        OpPEvO0ZIDazgLrErgknwOLCAqES7/9B2CwCqhLnr/xhB7F5BdwkviybAXWgnMTNc51gZ0gI
        /GWXWDFjJyNEwkXiwvl+JghbWOLV8S3sELaUxOd3e9kgGpoZJXbuboTqnsIosWT/B6gqY4lZ
        z9qBJnEAnaQpsX6XPogpIaAsceQWC8ShfBIdh/+yQ4R5JTrahCAalSV+TZoMdYKkxMybd6AG
        ekgsvHsVrFVIIFZiwbzZzBMYZWchzF/AyLiKUSy1oDg3PbXYqMAQHk3J+bmbGMFJUst1B+Pk
        tx/0DjEycTAeYpTgYFYS4ZWqf5YoxJuSWFmVWpQfX1Sak1p8iNEUGGATmaVEk/OBaTqvJN7Q
        xNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVANTzeTlQfdfijpGvjj4Xfai
        X/kWHrFMRvFf7Hz9ng6OKuF6oU2bTBr102XkrwQ9m7rB7BEL+4Kvtaoht99V/ksKWS9YX1M6
        Q3rr/GSDglj1a2smxt2yZn/cmqLo8V5p+YSvV9ul9ggGZ5cfdMnpYXY9nXaGg7XT0lvAr8ZO
        8PDzx/vToiK/MxzcfVX0f0vlNyYV1+nrDBVW/d4kpdzUm7rw8NSTvaoLJFLnem+KkTPsuXnD
        dU34caetz988v/X/qU+fVWnz9vDXHEq+1/KN2358iIpoEj8vN/fn5789BRsFVkvabXPKjeGu
        KT3xc8eEBd7fZ+nc7E0/9urq+onbt7d9OcwkW2welXI13a9FSlyJpTgj0VCLuag4EQDZj1q7
        GwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO63cy8SDb6csrY4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vF16XPWC0+rV/GarF68QMWi0U3tjFZ3NxylMXi8q45bBbd13ewWSw//o/J
        ouvuDUaLpf/esljcuf+RxYHf43JfL5PH4j0vmTwmLDrA6PF9fQebx8ent1g8+rasYvT4vEnO
        o/1AN1MARxSXTUpqTmZZapG+XQJXxozbHSwFu9krfi9fztLA2MrWxcjJISFgInH4wmogm4tD
        SGA3o8S+Bw1QCUmJEzufM0LYwhL3W46wQhR9Y5Q4PekoWIJNQFPi6c2pTCAJEYGXTBIv5qwB
        62YWUJfYNeEEE4gtLBAscXDVI7AGFgFVifNX/rCD2LwCbhJfls2A2iYncfNcJ/MERp4FjAyr
        GCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCw1ZLcwfj9lUf9A4xMnEwHmKU4GBWEuGV
        qn+WKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTpbFd
        R8vqdtbAw6VvDj22rdiY+uxwsOu91zpn1+1xt/ZmnH2Yzdg+Y7KU8re8tjnrjVj2GR0+uqB3
        8h2FmbbPl01Tya/99NGBzdKE8dyMa2riAq6zO9RzKirfvLDvkDJimv13m8nxi291lUKDXvWq
        uc5ymDd95s5L+yrc9H3WZTIyLn27QDU0/dBh5/Sfh7PS955VnlSTdpZZiXHXl9iQ81sq0ibu
        /Vihr1cQdE5rQ+Z5BnYRmdWTHwqbp0u+/P5cY+G+lfLx7XKuAbpawtsF8oLUJdJ6JXdvkV6e
        Pv/fHLY/Tj/Wy2o2H/zXbNzkdWH1cvY2mVaOh2ZZn9PCN3me11g8TdZlZooYn/8+SyklluKM
        REMt5qLiRADBig9dygIAAA==
X-CMS-MailID: 20220120025447epcas2p119e36c27179527429e4df7cbee87dd84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120025447epcas2p119e36c27179527429e4df7cbee87dd84
References: <CGME20220120025447epcas2p119e36c27179527429e4df7cbee87dd84@epcas2p1.samsung.com>
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

