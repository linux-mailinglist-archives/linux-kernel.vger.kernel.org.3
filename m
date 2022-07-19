Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1768579141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiGSDV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGSDV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:21:56 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB7183A5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 20:21:53 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220719032148epoutp04041aa08ff184e4798d47ad7c8625f45e~DHPDrq8-a1561015610epoutp04R
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:21:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220719032148epoutp04041aa08ff184e4798d47ad7c8625f45e~DHPDrq8-a1561015610epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658200908;
        bh=IzTJpwJDmv27DqFGcnFFbEYZnoox6AVDGRsU60ndVjo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JXsDrKMcQqe12yibPMQM/8TzBmCiPCbcZ4K/5DiTYKjzw40Z7fnC4YrzEixps0eOE
         VpHgpyc8iERMMSQZ3eUnUJuQQlSSGfW3hsUvEA4CbL5eJcHrCEGxDaFiBY8RUIFgTl
         B6yGeWhTk/pKBXcZYTgX/RzYdPTjqXtaN0qeBCiE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220719032148epcas2p40620d8c2deacc8e9f312a97ff9d83a06~DHPDFIQ1B2191821918epcas2p4N;
        Tue, 19 Jul 2022 03:21:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Ln3yz4SFxz4x9Q7; Tue, 19 Jul
        2022 03:21:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.BC.09662.B4326D26; Tue, 19 Jul 2022 12:21:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220719032146epcas2p3a23b4266bb6adf788b656840b855e3b9~DHPBwOODc1950719507epcas2p3y;
        Tue, 19 Jul 2022 03:21:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220719032146epsmtrp125a31940478b463502ed6a9f299f284c~DHPBvCMCf2146621466epsmtrp1x;
        Tue, 19 Jul 2022 03:21:46 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-34-62d6234bf26b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.B0.08802.A4326D26; Tue, 19 Jul 2022 12:21:46 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220719032146epsmtip102c9df9302f0fdd1538513a65359277c~DHPBfrYn_0745907459epsmtip1G;
        Tue, 19 Jul 2022 03:21:46 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: enable link lost interrupt
Date:   Tue, 19 Jul 2022 12:18:38 +0900
Message-Id: <1658200718-90312-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqa638rUkg+e7ZS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3J4uaWoywWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsXizv2PLA58Hov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MAexR2TYZ
        qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
        hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzNk7u
        ZC04zV5x9MJu5gbGpWxdjJwcEgImEu/PP2IGsYUEdjBKHOnQgLA/MUq87yruYuQCsj8zSrya
        28AM07Bm8mkWiMQuRomFz35COT8YJVZcWw42lk1AU+LpzalMIAkRgUNMEtfXn2UESTALqEvs
        mnCCCcQWFrCUuHDpOAuIzSKgKvH82WegFRwcvAKuEm87vSC2yUncPNfJDDJHQuAru8St7l0s
        IDUSAi4SK1sZIWqEJV4d38IOYUtJvOxvY4coKZbYtE8eorWBUWLJp80sEDXGErOetTOC1DAD
        3bl+lz5EubLEkVssEEfySXQc/gs1hVeio00IolFZ4tekyVBLJSVm3rwDtdRD4vzKU4yQcIuV
        uPH1BfsERtlZCPMXMDKuYhRLLSjOTU8tNiowgcdQcn7uJkZwGtTy2ME4++0HvUOMTByMhxgl
        OJiVRHhFai8nCfGmJFZWpRblxxeV5qQWH2I0BQbWRGYp0eR8YCLOK4k3NLE0MDEzMzQ3MjUw
        VxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAdEJ4SbzmuZfTWS7M2PnIPIq34OYc0cvnft77
        w6l2hOGWnPOzzJypE5w5n7DoGavOKW9qW3r7w4oFz2o5r69btM7qzKXFa57n3em4a3vq/DpD
        vR0t1r7m9Zor2ZL2BNdMeLzg3Sxtm7bD3cuennq49Kl41LTHed4t/9OUHnkZ3xP6cWFZvndx
        +2v/uOl/0uQnRHBP+Hsvt2DRfZ3SaTXSasbXfB4ntF+ydJ9i9/vVsVuzOn47zhA8oMpx7e7s
        5kozk7QTGy+apHO7/v/ktuHxzx3tbycXiRZXXd/MeUmn4fFO9Sd/X27T/c/Po7yvwO8BV7z6
        9PgjWo/EnJJDPky5MLvPzeW5zNcXx+99amF8O+WcEktxRqKhFnNRcSIAHP507QwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK6X8rUkg6v/NC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3J4uaWoywWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsXizv2PLA58Hov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MAexRXDYp
        qTmZZalF+nYJXBkbJ3eyFpxmrzh6YTdzA+NSti5GTg4JAROJNZNPs3QxcnEICexglFj67jAr
        REJS4sTO54wQtrDE/ZYjrBBF3xglvj5ZC1bEJqAp8fTmVCYQW0TgEpPE/1vmIDazgLrErgkn
        wOLCApYSFy4dZwGxWQRUJZ4/+8zcxcjBwSvgKvG20wtivpzEzXOdzBMYeRYwMqxilEwtKM5N
        zy02LDDKSy3XK07MLS7NS9dLzs/dxAgOTy2tHYx7Vn3QO8TIxMF4iFGCg1lJhFek9nKSEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUwVXfMlCwS9+LbJ
        f25iXi6RnFvGfbjPVX9px+yJ31Zd2Mo/Ielg5AaD7Pdbf1yWSpwj9UsxYN6kTyquidfzyx8f
        Xqi52bR9lqCWS7q6BreTgsiftCA9nf4YzuPPNzh9FuJra+JUjXtjsPN5Sv0968N71tRcsind
        W5V069eVQyue8LzYs+zhyu7ZVxfvXdY3zZ//XoxY9NlnDioLCrXXvJyiZuWnXlV91Gfuz8h9
        vVyPZhb9zW9V5olNOv5R0OVeuE15jn1Jqrm1yyn9C/ohCtrRTLccta92xCRtdJeVWlWsMpFr
        8gmmJYaP78++sF1rBZ/Mg3d3/Csb0hbryMZxrHzw5/WBgJniTJf1X5xUPKLEUpyRaKjFXFSc
        CACl4iQgvgIAAA==
X-CMS-MailID: 20220719032146epcas2p3a23b4266bb6adf788b656840b855e3b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220719032146epcas2p3a23b4266bb6adf788b656840b855e3b9
References: <CGME20220719032146epcas2p3a23b4266bb6adf788b656840b855e3b9@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link lost is treated as fatal error with the following
patch, but its event isn't registered as interrupt source,
so I enable it.
--
scsi: ufs: Treat link loss as fatal error

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshci.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index a7ff0e5..0b627f4 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -133,11 +133,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 
 #define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
 
-#define UFSHCD_ERROR_MASK	(UIC_ERROR |\
-				DEVICE_FATAL_ERROR |\
-				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR |\
-				CRYPTO_ENGINE_FATAL_ERROR)
+#define UFSHCD_ERROR_MASK	(UIC_ERROR | INT_FATAL_ERRORS)
 
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-- 
2.7.4

