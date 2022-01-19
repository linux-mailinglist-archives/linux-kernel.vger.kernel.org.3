Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350AF493606
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbiASIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiASIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:07:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED46C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:07:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e3so5992149lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvJhbswWbub3rJX8zyyNzHLh8QmAr6Ho6yFADPS8SWU=;
        b=rgy/vdgrjHWkIx1GuiKunJnKxAdTb46B3TPpfCFZukMYmGqfJYQzQ5w/I/msUa24mk
         ZVt/F+KEhEvkWoco1oRJeG0KkC+Kf4YzlTD4QWbqlMVIeRE4h4IIij/F1YtIKXTic7GR
         xc6B2cUxC+yxKI5kcrxIKuldpC0ro+eFgn2RAU7rX2ZD3MF3nkkMuQ53T6LD7CvAxgjs
         jtdwugKZ8t6ENVIYZs5rvMiQP9JuzPRLyCjGUGbTxyMeJXM0tf8VLChVkZ8aU8tECpjq
         zfRR2UvO6R5Kf/mTh3dDjLklwHV9qNvWeHwEBuWNNMTcmrYkyOFC6PC36WEM15IkBfqc
         6hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvJhbswWbub3rJX8zyyNzHLh8QmAr6Ho6yFADPS8SWU=;
        b=zKKgKpURkg5O4W/acFZK8ttyauqYNGEEt+E2pT6q3M+HcqyMdfmKEFfmFLaFusVi9G
         Qjc32ZLjlw5i4dpzzqSF1iWQ1ie0rxKxe9vsgT+/wflGtCk88d1UdNdGNskXEmxwyQQl
         I1/ICOOMfwGoDdzTuGEEt0bVb9r6cZpiohgHdlvogpR395Q83Gv/aFkVD2IIR+xnzsCN
         V9xHWAy0TQbGZ+s3QAPF+V/UMIihgPllhJDUzGKxJl7Dz59h0YuRvUIQTzguXoV9eGGB
         gIZEcDNn3zaaAFgMqbn9d9egwJWVXETTRLx3rd4FxCmVDl3ef4d4A4ozd/PwOL5ey/Wh
         PxOQ==
X-Gm-Message-State: AOAM5307sdxafXhCSNuiVnRnevfLEriH51NKvKWJ6/+Nv7FegM31hhFT
        3Dv3nkfPPHpLPptw2KmdEr0HDtraj486QQ==
X-Google-Smtp-Source: ABdhPJzaxvPfdXIZzqg1DCoo/BpBWQ59h9gPQ+TaAtwFArDLaV7nicoaBm5rWP0O/Ah7MkhkXvKOcQ==
X-Received: by 2002:a05:651c:171c:: with SMTP id be28mr23989056ljb.183.1642579665251;
        Wed, 19 Jan 2022 00:07:45 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id o9sm864100ljj.4.2022.01.19.00.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:07:44 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
Date:   Wed, 19 Jan 2022 09:07:36 +0100
Message-Id: <20220119080736.2940906-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds error checking in optee_ffa_do_call_with_arg() for correctness.

Fixes: 4615e5a34b95 ("optee: add FF-A support")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index d8c8683863aa..d88bd2e41572 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 		.data2 = (u32)(shm->sec_world_id >> 32),
 		.data3 = shm->offset,
 	};
-	struct optee_msg_arg *arg = tee_shm_get_va(shm, 0);
-	unsigned int rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-	struct optee_msg_arg *rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
+	struct optee_msg_arg *arg;
+	unsigned int rpc_arg_offs;
+	struct optee_msg_arg *rpc_arg;
+
+	arg = tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg))
+		return PTR_ERR(arg);
+
+	rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
+	rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
+	if (IS_ERR(arg))
+		return PTR_ERR(arg);
 
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
 }
-- 
2.31.1

