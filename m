Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106954DD1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiCRAku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCRAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:40:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71913E994F;
        Thu, 17 Mar 2022 17:39:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j26so9728968wrb.1;
        Thu, 17 Mar 2022 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gsTkrihCJqnEHPeTUREyY+grPIvlwOYy2RYZrHaUHI=;
        b=FLPx3v9O3yp794Fc9m8+3Fms180PmpDjbtrLO0Xu1i8qXrAd/9enHHAeShbg4oSb7t
         md9G09lQyD5JyMP0ZOdKfNy4zxT1/xQDszXVsxP0F/x1wl9DLVVpLchZbrsin0Bk66P1
         6vop8DECEbBHRj1ikoWDW3T6qUgGUzdvVDfOLlDTvrq+71zXZi95SfBq+N42khglWfuX
         awl0h72ycsBAS7Vc2MvCwZJOkRdTx/T8lBcQ45hjGnfQ3EcTD2ycbkgFp385z3MYIC6P
         APBPni1nM3HPfu7A1b4AouHvNpwkbgHS7k3Dshz85Qn2R5p6/e7AC7alVu8nhg2wvHKX
         yjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gsTkrihCJqnEHPeTUREyY+grPIvlwOYy2RYZrHaUHI=;
        b=h9r3Z7u5YrIMSxiZdaOgTqp+vaTPBcz7edOmEw36FGZa1qStVbF8CnI80P8VDdqOyx
         z/HGxa9oeAqmBS52HR8cd0cJvFGv9LnJAu5upXRuNfFBV4WoCGg4ze1YWlV6aup2HGCe
         HQAdA5Ol9llMwGVYu4AjlFdcPt7bDGUZelWmeBASUI6nOc+16RnM6C1k9f14+hZ6f4YW
         A0/T3t5BGZT5slpgXWiRwSwmRJNIi39mJey54aRwPjotYBY8TAae64rhVHqsNbqiUcmD
         05Lc5Cz59JCMXgirCsORy9bRuynPvF9Mz4W2Zb2wLuIf0A6bi2ZxybG/D616RJvuUagv
         NXcA==
X-Gm-Message-State: AOAM530f17/pLSJ0gxFjPeneVQgbVqe6OslyjcYZjVFBymUzy6dDmpIp
        62OAli+eD4YJ4XwDXQrclYw=
X-Google-Smtp-Source: ABdhPJwoQZOjUskNt5TU0ZyJE8Ju4uZEdL59fCI7gDoWZSkg2jY3/M90ILkKoeR3EvRnfG/qXKEatQ==
X-Received: by 2002:a05:6000:18ac:b0:203:ecad:a203 with SMTP id b12-20020a05600018ac00b00203ecada203mr4249744wri.177.1647563969021;
        Thu, 17 Mar 2022 17:39:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm5533293wmz.43.2022.03.17.17.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:39:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] scsi: message: fusion: mptbase: remove redundant variable dmp
Date:   Fri, 18 Mar 2022 00:39:27 +0000
Message-Id: <20220318003927.81471-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable dmp is being assigned a value that is never read, the
variable is redundant and can be removed.

Cleans up clang scan build warning:
drivers/message/fusion/mptbase.c:6667:39: warning: Although
the value stored to 'dmp' is used in the enclosing expression,
the value is never actually read from 'dmp' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/message/fusion/mptbase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index e90adfa57950..9b3ba2df71c7 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6658,13 +6658,13 @@ static int mpt_summary_proc_show(struct seq_file *m, void *v)
 static int mpt_version_proc_show(struct seq_file *m, void *v)
 {
 	u8	 cb_idx;
-	int	 scsi, fc, sas, lan, ctl, targ, dmp;
+	int	 scsi, fc, sas, lan, ctl, targ;
 	char	*drvname;
 
 	seq_printf(m, "%s-%s\n", "mptlinux", MPT_LINUX_VERSION_COMMON);
 	seq_printf(m, "  Fusion MPT base driver\n");
 
-	scsi = fc = sas = lan = ctl = targ = dmp = 0;
+	scsi = fc = sas = lan = ctl = targ = 0;
 	for (cb_idx = MPT_MAX_PROTOCOL_DRIVERS-1; cb_idx; cb_idx--) {
 		drvname = NULL;
 		if (MptCallbacks[cb_idx]) {
-- 
2.35.1

