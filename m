Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14A948DAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiAMP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiAMP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:27:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:27:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l25so10717298wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3teCKMCWiTKibV9NJF6sI2UlLTztwiagclBsxXmy4Rg=;
        b=QcT3/xkGHJgTFwbVusORhBurI0G3iM0877j5CCtXLQE5fRUzYkrTDUIzJIel0V2+KR
         js17NeEYwitLjXTTrGhOV+Pwglvfq5hNPM/K1Iu+LOxUPVxXz4qNY95T3ZwbYQsdk0L6
         gJo5Rb19H9Ku1DspGsuRRaHddYqGIo2HHHHoPX60Bzi1HV8hYub+y6f3IMj7DB2VDuGS
         KYz0B+fO/bBpISA4mDnIo002AOMsn9PAAQBW1Pn2eCRFnXVWVlWAj2HQKxW0w30oZgFE
         HJ/hJzfLLdAJNrM2Yyhi4hH/PN8LkaFXMXK2zYiEmrPaoK4tIfF3QEm226VTUY9bSE5o
         hzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3teCKMCWiTKibV9NJF6sI2UlLTztwiagclBsxXmy4Rg=;
        b=eABbLo4j7WWwFwDHwiFPj4zSROY7jGDo9ueY8NMkJFfiJu7SonSzHgPaSoub5yN7S2
         Jet+cufGDhYt/QVswExCKzfJ8vPyq+KYwAMRd+quObVe08sdILHbYEKvSlq6xiLz27St
         y0HrPfq67ViD74EVKnJsnMQ25GwaNtmXn6zbPLyoj13gw4QG8Uge/H2DErLx8cb5O5l+
         0WSWIOzIdKWbIVye53U8q5FSIgWfjQoEPlPqd30KQbNAghQq9rUtOXYUkS4ymX8dge82
         Vc798AdDUw2wY2E3+nNGDNIySW3WeYWalio+7HvmrjEj77JayPQ3wctoBQI38g2Gdbw2
         Ejeg==
X-Gm-Message-State: AOAM533ESuCVezOvRcRXJAaWPZWiVshaaeyFnGo/vUdMGeE2SYG1fq6N
        6BXAFXI/Cjz64mgXRnXb0zCaZg==
X-Google-Smtp-Source: ABdhPJwCKCFfn14es8NKKjDu9uZMBVLMmCuVsDSNnAEcuaDxtkJ1wQgZZF8GMq7AspQIG+2tcGgMXA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr4372290wrp.178.1642087668411;
        Thu, 13 Jan 2022 07:27:48 -0800 (PST)
Received: from matebook.. ([2a01:e0a:3cb:7bb0:b076:68c6:c37b:4160])
        by smtp.gmail.com with ESMTPSA id bg12sm3661435wmb.5.2022.01.13.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 07:27:47 -0800 (PST)
From:   Jerome Forissier <jerome@forissier.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH] tee: optee: do not check memref size on return from Secure World
Date:   Thu, 13 Jan 2022 16:27:13 +0100
Message-Id: <a4e48364368cce3c91005a3bd4fdacee086ef00d.1642087405.git.jerome@forissier.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
refactor driver with internal callbacks"). Remove the unwanted code
again.

Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 drivers/tee/optee/smc_abi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index cf2e3293567d..09e7ec673bb6 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
 	p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
 	p->u.memref.shm = shm;
 
-	/* Check that the memref is covered by the shm object */
-	if (p->u.memref.size) {
-		size_t o = p->u.memref.shm_offs +
-			   p->u.memref.size - 1;
-
-		rc = tee_shm_get_pa(shm, o, NULL);
-		if (rc)
-			return rc;
-	}
-
 	return 0;
 }
 
-- 
2.32.0

