Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5584818C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhL3Cwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhL3Cwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:52:36 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:52:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t123so20170116pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jccTyg7vrHF0S+bQCJ8I8LSXrcz5SWfRQTdxjUX7Eg=;
        b=Exid+35BwV0SaQHC8U/1Dv5xnBLGbIkK4hPRUTKAErw5FZIN0rAkhKqRU28ADtz25N
         RiFQP7/whNm52s+b+m1dT6VfKxy10uv3bQmR4z1pezShQkNHpETDTvP8gNVuTeghKdFn
         8XGjSZ8eqjyTsOMKMdwSD2Epn2B7F2eWTwxa/L/syDtSAGWBENEbJejInMzzjzUdOxmJ
         VAsKYfuQ8Eh34stFd8f++yCEG6XtBD4ZWGXp0w6/Ps2M8Kaa5bZEXWPqk25VxsxW2uIJ
         uRMSX3qHL04isOr4qOpvdLVBky7aNT0SGjTXCppOqLO82H9WbocHb9uT745oUXxeZPH1
         gr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jccTyg7vrHF0S+bQCJ8I8LSXrcz5SWfRQTdxjUX7Eg=;
        b=cpa57xlfKAJFBcaJnZzXbegpxbAHuhNKJ12Mq0NyVnq+kf5rTovuEwoGlM6bFpvh6f
         LVttfb1IIXVDWuYdflSQ9KmqHKbIhj9OnKi26ya2c235XsVOfDywOrFDJ2mwPS7VNO5n
         i2YP+XPMRtHGKkW44QLOH0aMhPO2zhqBVzSdVAenWLiEY+k3/o/Q50PVZ4p/5+0NkEMT
         HqTX8NJQ1fFrQ/FwIAvxP2ypI6iLA8Lw28xtACc3kukAHUsHVtZs+/o2AA+TRJ7f7ZcX
         FdsWZ9y+E4d4+7W6r0l8CZz/nk3ryBPx4npIsEDhGywdr0wEXzEbAXNBQhC9p/JosYF5
         MStw==
X-Gm-Message-State: AOAM530njyqgxZwQm2l8DZjO4vlAr9bPT0PfoZnzQcWzTSvkJasFXpdG
        Yd+3ki8pckjGIRXFbYPYmABCia97ky+fjBiD
X-Google-Smtp-Source: ABdhPJyZ6TsOmlLJCev7bA9yhfbhmmrXD9ZDL+4SoNf+uDsEdc86AzAli2yBm/zkPpVGx2QfU6Mw9Q==
X-Received: by 2002:a63:7519:: with SMTP id q25mr24245362pgc.597.1640832755717;
        Wed, 29 Dec 2021 18:52:35 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.gmail.com with ESMTPSA id f8sm21271449pga.69.2021.12.29.18.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 18:52:35 -0800 (PST)
From:   Zizhuang Deng <sunsetdzz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com,
        Zizhuang Deng <sunsetdzz@gmail.com>
Subject: [PATCH] lib/mpi: add the return value check of kcalloc
Date:   Thu, 30 Dec 2021 10:51:59 +0800
Message-Id: <20211230025159.460218-1-sunsetdzz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the return value check of kcalloc to avoid potential
NULL ptr dereference.

Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
---
 lib/mpi/mpi-mod.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
index 47bc59edd4ff..6fd6900f0798 100644
--- a/lib/mpi/mpi-mod.c
+++ b/lib/mpi/mpi-mod.c
@@ -41,6 +41,10 @@ mpi_barrett_t mpi_barrett_init(MPI m, int copy)
 	mpi_normalize(m);
 	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
 
+	if (!ctx) {
+		return NULL;
+	}
+
 	if (copy) {
 		ctx->m = mpi_copy(m);
 		ctx->m_copied = 1;
-- 
2.25.1

