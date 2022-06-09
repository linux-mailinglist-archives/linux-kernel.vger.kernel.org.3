Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD15545126
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbiFIPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiFIPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:45:10 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 08:45:08 PDT
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325C12FEE7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:45:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx308.security-mail.net (Postfix) with ESMTP id EE6055456EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1654789162;
        bh=4QuvHHS+YVrE/JoZYIlJPPVAIbUQSBiC2BS2Tpjqihw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SyMqVd0tjvWtZZcKFeCv7vSKdmWmtkHxeaJIHzxwZmCvnJR15jAh0U0yo4Usi7jMd
         AFIKXuKhJIKD942h/C91z5hyl3CWIpo5/PYhG2MHWKY5n0XDDFTX+NtNRigbXILcuw
         OxCpSNnuMyFvAYSfSGRJGeV19vBqi7rwVX1GCRqM=
Received: from fx308 (localhost [127.0.0.1])
        by fx308.security-mail.net (Postfix) with ESMTP id B19DC5456DB;
        Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <bfa2.62a21429.41305.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx308.security-mail.net (Postfix) with ESMTPS id 4192E5456BE;
        Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 27B2327E04D2;
        Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 116B027E04B9;
        Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 116B027E04B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
        s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1654789161;
        bh=0Y2Bwx1XXcdl7GIR63NkBsIwF7u0KjI75XBr1Xt6x4Q=;
        h=From:To:Date:Message-Id;
        b=KOyG5a5hebTbFhe6hfSRMBlS5i7JwKuHy+jfq9ODlbzbNVXpoxKmLxARrgpyEUeky
         8SR5Ti80RWLlesSOgVPcvcmVYshobtMSrYGPSjPtVJDkqmwvILx04oE1fKBre6lM1A
         UJ4To58ibeNM6gejsg8DIVv9x2WwBoRy/THpPufPQa6evNneMb/KEfMe75YD/GUlDu
         X7lvXbOHgKLzrl3vLjF+K8XgY5Uer5u8CFlUI724mJrmI0JikuiktFPtwJMpmH7+ge
         XgNpN+ewp6+kr2fY1w3jzU/auQYIdITBkI+gc05c9rcgaV6yu/GugicatnhLQD2sHF
         ntSksqjJ+al6g==
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mkXZ0Hvs-iqD; Thu,  9 Jun 2022 17:39:21 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id ED17227E04B4;
        Thu,  9 Jun 2022 17:39:20 +0200 (CEST)
From:   Julian Vetter <jvetter@kalrayinc.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com
Cc:     Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH 2/2] msi: Add sanity check if more than MAX_DEV_MSIS MSIs are requested
Date:   Thu,  9 Jun 2022 17:38:43 +0200
Message-Id: <20220609153843.1991-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220609153843.1991-1-jvetter@kalrayinc.com>
References: <20220609153843.1991-1-jvetter@kalrayinc.com>
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device requests more than MAX_DEV_MSIS the MSI index will collide with
the devid and might cause Linux to compute twice the same virtual interrupt
number for two different devices.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
---
 drivers/base/platform-msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 4b0b2fe3a7ff..627d8f6b83ea 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -40,6 +40,8 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
 	u32 devid = desc->dev->msi.data->platform_data->devid;
 
+	WARN_ON(desc->msi_index >= MAX_DEV_MSIS);
+
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
 
-- 
2.17.1

