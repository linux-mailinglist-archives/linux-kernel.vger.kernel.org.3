Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2A4948BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiATHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiATHmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:42:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4195C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:42:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so24716881edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1Ta7YkopCvYMD6WK6F0yOJ093SUahdvNEyiNyngQuw=;
        b=aeTEQ8X44CtEtcG6Fq+kFY/Pgctr+Njh7GKzsc6WqXi5VaDaEUD4sNvlehuJyT8WwS
         8use6dOakXUdWZOyqwYmSYarEoQWClM/5cCBAtk6XaJL5ufssi/TlJ6XqTjBYlC9MViv
         Qf4mS7vZcY2epBgpOhK+L1FgYej1M+/Fgsj0Du3xVzhkO4bZYCJtJLRpfQaeew8Fh213
         Fdnp/n2WIOaSRSwRQXOx5R6v/yGsxEhuv8WFgv+vrskp1AkU0/6jl9skigW9FRcioS6D
         m2peDv0hzcvWMx/l1KitskJ/da9yheGgTLFfbEYFWtbIbcV0leTJQJqHMBZwfv2uRoex
         rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1Ta7YkopCvYMD6WK6F0yOJ093SUahdvNEyiNyngQuw=;
        b=q6LknfNKKWux3b3Uz3c5uoPMkpwsMkOIh1ILrDmXC0EsNELd+q6FNhd096rs7d8ZG1
         qb1+fx2cR4WeIAtbqYadOlvSlQvj/WyePS5TvG9BE/ML3YGhY4U9rgP+oViGdgotEc71
         uBQh+fAW3Q0TrzF4ayaW777wtuVNhtmTybmPOlh+V/hzoFLEU3KsRjLVRnL/ktyShc8o
         mIfOJWQrapj4/X6y7TRGMfGRio20LLmhkJikCTWgShfq3ETE3GxBAWqjyoXBDJpDcRRR
         iUUlC+gegesQdJbenhVKbRM8XeNhs+9zgt+pRgIJqfAvQZBdK14mmq/hIa/gnKwNQUlT
         Ftow==
X-Gm-Message-State: AOAM532BENm4F5JISf41ta80B/6KEMQohmLPfCVRqEWNam+Yg2BH57ha
        tEyZWkPF4OQNzGxHsnuhtBBsH2YYhLarZw==
X-Google-Smtp-Source: ABdhPJyTEHJaBygh0B+Fcr90hP5m4iyLbW95FvAHihrNWilDBGl0qVy5CDgZEcHE0V6l3rPjtezXYQ==
X-Received: by 2002:aa7:c3d7:: with SMTP id l23mr34056517edr.258.1642664558251;
        Wed, 19 Jan 2022 23:42:38 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id fn3sm630479ejc.47.2022.01.19.23.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:42:37 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        David Laight <David.Laight@aculab.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2] optee: add error checks in optee_ffa_do_call_with_arg()
Date:   Thu, 20 Jan 2022 08:42:32 +0100
Message-Id: <20220120074232.1084967-1-jens.wiklander@linaro.org>
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
index 20a1b1a3d965..0775759a29c0 100644
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
+	if (IS_ERR(rpc_arg))
+		return PTR_ERR(rpc_arg);
 
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
 }
-- 
2.31.1

