Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4851190A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiD0NkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiD0NkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:40:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9054D273;
        Wed, 27 Apr 2022 06:37:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a1so1984453edt.3;
        Wed, 27 Apr 2022 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGr4ZsbPWAJgSC4/N8Ml+5pEamV/nRGhGHWpIvVEbm4=;
        b=Tv2JjvEfv1hLVOzguuqbtyJLIbAC/QhCW0O+L15EfZdHBEF2t0keCi5ajjV/M9DGS5
         4rVO+IfTupJyMKAN5h3l69l5ZZzEJZwZfPRcaG+tOCyeOGU9lpsKjt4ochVPrv2l8v2Y
         h7TvboXeXOIbHgbw2hUjNpk69hVla2UxYk1ag2KUmkZyB0GN7j4ltTzkBPQ5xp19Qn7w
         2Fv4mApyKjGR8VycuhwICYrsnVajjQKi5XFoowXug+DEljpn0bJdMKaGc5MeN3gjCFfV
         NTuXFr+WZR1lU+CIvDJNnqUQSBueHkgPKbRATpGS8XDPMP6PmE8zefDr+GXsb36Rud4S
         h/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGr4ZsbPWAJgSC4/N8Ml+5pEamV/nRGhGHWpIvVEbm4=;
        b=RO5A/kqyOX1F0TTrDerwm9pyNJ8IoO/lmwRTFfbi4NMSpYHY/oJkDYCUN0GSkTEzAO
         RzOw2sc9dtxzm5GBz9h0FOFNjaytUDP8n3zUsVZbB4GS2plxVUTZh7nLRQhDuXsAa2eH
         gbqtNECy+MOcKVBPwGoGYc7tuWpHMDPqt8pYnGYQtLfDcxHh81o55Gxt2WeXul0BxEDG
         439Wr9V2aI6xlW0bX5PATsJwkD74hhqWXU3UsVoln8jre1N15F6ZExiTHemRRji/q6ML
         ufF0EufCUI9T7EWz9SjSVaZ1dOkxL68SRrUa7uDLVQrT3rDjgD5hKSGJD1fNxcqcHcCG
         R9Ng==
X-Gm-Message-State: AOAM530MnstW2vOdWXGY9mi1wm2DtHkHCSF2xqSVHhwLPcct02R36w8X
        3nnsmvVtnrcWTA82UR1QTTo=
X-Google-Smtp-Source: ABdhPJzl6o9jtmwDLFYtEd7YCU1a7Q3HVzYclbP6QvLi4VIP49v5Xb8RCKpi0mEFL2I89utnGIo5Yg==
X-Received: by 2002:a05:6402:2547:b0:426:1763:4c5b with SMTP id l7-20020a056402254700b0042617634c5bmr3048013edb.176.1651066626106;
        Wed, 27 Apr 2022 06:37:06 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090632d400b006f3a60598easm3394052ejk.129.2022.04.27.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:37:05 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.garry@huawei.com, chenxiang66@hisilicon.com,
        bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1] scsi: libsas: Fix array-bounds warnings
Date:   Wed, 27 Apr 2022 15:36:57 +0200
Message-Id: <20220427133657.55241-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Use the latest GCC will show below array-bounds warning:

drivers/scsi/libsas/sas_expander.c:1697:39: warning: array subscript ‘struct
smp_resp[0]’ is partly outside array bounds of ‘unsigned char[56]’ [-Warray-bounds]
...
drivers/scsi/libsas/sas_expander.c:1781:20: warning: array subscript ‘struct
smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
...
rivers/scsi/libsas/sas_expander.c:1786:39: warning: array subscript ‘struct
smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
...
drivers/scsi/libsas/sas_expander.c:476:35: warning: array subscript ‘struct
smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]
...
drivers/scsi/libsas/sas_expander.c:479:38: warning: array subscript ‘struct
smp_resp[0]’ is partly outside array bounds of ‘unsigned char[32]’ [-Warray-bounds]

This patch aims to fix these warnings by directly using struct sizes instead of
macro definitions.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/libsas/sas_expander.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 260e735d06fa..ac6d9be358c5 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -457,7 +457,7 @@ static int sas_ex_general(struct domain_device *dev)
 	if (!rg_req)
 		return -ENOMEM;
 
-	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
+	rg_resp = alloc_smp_resp(sizeof(struct smp_resp));
 	if (!rg_resp) {
 		kfree(rg_req);
 		return -ENOMEM;
@@ -1688,7 +1688,7 @@ static int sas_get_phy_change_count(struct domain_device *dev,
 	int res;
 	struct smp_resp *disc_resp;
 
-	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+	disc_resp = alloc_smp_resp(sizeof(struct smp_resp));
 	if (!disc_resp)
 		return -ENOMEM;
 
@@ -1766,7 +1766,7 @@ static int sas_get_ex_change_count(struct domain_device *dev, int *ecc)
 	if (!rg_req)
 		return -ENOMEM;
 
-	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
+	rg_resp = alloc_smp_resp(sizeof(struct smp_resp));
 	if (!rg_resp) {
 		kfree(rg_req);
 		return -ENOMEM;
-- 
2.34.1

