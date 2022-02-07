Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B24ACD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbiBHBEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245715AbiBGX2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:28:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:28:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cz16so15320580edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STukwnHLJ5JlQRTYdPROsCoSZDqNrbFLjrqiynzZIGo=;
        b=V1LxTsspX/2KvteenHDf18lalZxHNEVBq4cfehyDGPcEMldBsF1aN+NyubcTrnYnZP
         grCXV5UnY7xQB3Yf4Pbs77nsnZDwdkrh4g3rHHu7AFYi20uhNplepumFGBZa+phjsarp
         Y+z9CZ9nxLRzdcqOq80GxU85D0BQTw5NaiCUXxhE70ABGJiPv8slPFiW0XA3opcK4Pm+
         eoUs+lyeDd6OabER4VzIqTzv7h5UKHhnYCrWzSYkpTZVdI3UmnsBi5tYnbgT5RpDTfyx
         yxRpg3fyXDz1likmSTgfNhK4gortG49lQ1p48V/9Kiq5qujXRLFoLg1Cfe4cdBCc/rPy
         mY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STukwnHLJ5JlQRTYdPROsCoSZDqNrbFLjrqiynzZIGo=;
        b=YfuqjpTUP6Y3Ds5MhEi/9pOICmzrPLnJ/Lg+xzAY7aL6gNjBBF0Ovh0iwL8e4eXTxD
         S9GpA4+NisTqB21DCdxFJdCcq2tCs5twBOlnCZpODtIC/HZkFD/jYPUgQvCB7AuuXMTR
         Jb91cOfk7ePe6DzVI+5upbLH2Ql22Vtq7u/HfNZ233cctbdvXoaEwrn0TxkNpvLnsV8l
         rnibPekGQrtIuUMQQN0MydBtRSyi5Iy/T4as+D79jj95nzSzSZ27/Og72lSUF5xjqqRG
         c2Eq8+fO1GgDUlEH1p/iuQrSFF8p5bElr9TbPDnQMqmCVxkPRAngeY/o+JS+hw6P6lYn
         sC3w==
X-Gm-Message-State: AOAM532qmizyPS53z/nDa+0a7E9liCWYq45oj+6cEho0QuV3XUOIVJWQ
        9+HjqLBYZPPsnerRHHd3SlM=
X-Google-Smtp-Source: ABdhPJxFIkBlfI0ZUVxiZnz5qy93KNnZAceYCmxedK9MI9MRjx1vOEdwSVgvmh6jaNA4WY4bL0LTxw==
X-Received: by 2002:aa7:dd15:: with SMTP id i21mr1759125edv.198.1644276495213;
        Mon, 07 Feb 2022 15:28:15 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300c58721e9801b2c6bc4bf3c75fd.dip0.t-ipconnect.de. [2003:c5:8721:e980:1b2c:6bc4:bf3c:75fd])
        by smtp.gmail.com with ESMTPSA id j12sm1776765ejc.83.2022.02.07.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:28:14 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, beanhuo@micron.com
Subject: [PATCH] nvme: add nvme_complete_req tracepoint for batched completion
Date:   Tue,  8 Feb 2022 00:28:06 +0100
Message-Id: <20220207232806.411801-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Bean Huo <beanhuo@micron.com>

Add NVMe request completion trace in nvme_complete_batch_req() because
nvme:nvme_complete_req tracepoint is missing in case of request batched
completion.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..eaf0b18ff29e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -368,6 +368,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_complete_batch_req(struct request *req)
 {
+	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 	nvme_end_req_zoned(req);
 }
-- 
2.25.1

