Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B234BA4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiBQPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:49:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242832AbiBQPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:39 -0500
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BA15C64E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645112953;
        bh=R2T64fF012MpAvx/2pefsZbIP7UbuXf+c8VwNQhS83s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vfHd6cjtV5/ICRSNtM3tSkXbj1FVd842jm6689ZCw9jTyt+W2gYRMoT2UXVyR2/JX
         Rca5AUwr+UvboFhoNg7EE+4gqx4R3kNxc4656RK6dG3vJi7lN2inlOufwTFNMZY6UA
         axYwFs5w6I1wN5tVps0oFfJ+1sQxcqHxCcVzDtWA=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id C45B0427; Thu, 17 Feb 2022 23:49:05 +0800
X-QQ-mid: xmsmtpt1645112948t4765e92p
Message-ID: <tencent_03873F2A51FFDF808C33B3E73A717C51400A@qq.com>
X-QQ-XMAILINFO: MbECzfofyKaSxDTk9gm8v6uGmbRVERi5ZYRBZi5Vqa7NapwMKJqFMcrAd3KsOE
         Kry8r3SbYipGbd7g4AhNDMxrFBRcNHlzv/NY9E7RAsnFMItpDi4R+4+FMbaBnoqEw1OcBQGBDnrH
         BXktggiepK9oAr/LBNULORqPNCHKu0pp3wWyYfXYgnBbo+47MySM7uRjF6gQbA4y+SpZOa9TQF/m
         CVbXHm/yUTwvhCr8bH5gC240JvrInUZY+lM4xj33GvtP6Ar2ksHmBtaySaUBxK86ljjX1bMfLGYm
         VraSpTdoT/G7IiSE8cMIGyfJwccrPusxLaUyTtqiqBRIWIDyEB2HtJotPuEUcel3/vRcgr+VEHSb
         o8lqz00yhQgjLbDcuidrjAp9x4spzaJXo/brM+lvsDMKMkqs465VDAMCY17TDKtlpq1n5LnnAh1A
         qtiroDr4ibdiWqGTilARTx2qzZwy1PXhQNrVoyxyH9AbQrRZ+d3ZhE2RLPte6vcuw46dCbFwbffu
         HvUypXzDZ+iT+6BM/I1cLlDIPtossQa6j0lPpLOufE+ZaqOvJVkEzR16FqkAAqs+9t5JmcEXcgLy
         wa3mVcmJ4vg+h0J88u/nH2wroyG5Fj1QpJQ562CZOU1x0aXuP+7rnOpSrRvUYef3Aq72INdfKHQo
         sbpzJwJQk23R2ZyPbd9Y87IpG2cx8Y8M22vdtelGsuJ9m/FmILkoKufE2NJBDENgMgjW6ugrjRdy
         o4+tVWGvwW2fPbWamFUu1563tBpbchaLwdj6h4pj21xAjykj/cWEd5BG2reLTtpJPLdRliKfxhKY
         OWGkzCiSguZL3OzyY471D6yHT0dS5udV/ZqzSb3qB9NTrxO6FfXSJBqFnyu26mUic5M50uYIcfGv
         6s+02AW2H/nRj2Cy8sdWyN+q2sqB26mJxvmouA5GT/yhOPfj+XLNiI7lh8t9/mbjJn5wA0Uq0Kpw
         hr8L+iUrGa1+fCLR1rJL6hDf5qlqnIIHJdR63EAS0=
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 2/2] staging: wfx: check the return value of devm_kmalloc()
Date:   Thu, 17 Feb 2022 23:47:22 +0800
X-OQ-MSGID: <20220217154722.1226-2-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20220217154722.1226-1-xkernel.wang@foxmail.com>
References: <20220217154722.1226-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kmalloc() returns a pointer to allocated memory on success, NULL
on failure. While there is a memory allocation of devm_kmalloc()
without proper check. It is better to check the return value of it to
prevent wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/wfx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index f83df9f..5d4fcc3 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -294,6 +294,9 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
+		goto err;
+
 	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
 	       sizeof(wfx_band_2ghz));
-- 
