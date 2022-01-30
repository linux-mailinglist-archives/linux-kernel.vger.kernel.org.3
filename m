Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058574A3ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356818AbiA3XLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3XLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:11:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B682BC061714;
        Sun, 30 Jan 2022 15:11:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u15so21972129wrt.3;
        Sun, 30 Jan 2022 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIdPqYs8pcB/F7X2IthUrwmWJbc2O1lsmbqHpZXh+GI=;
        b=XjyGAy2uvlKwAUCs5+9yzRDXlMoY/j1Fhlmo2d66/Vlw6KVNcUKS2FZ/9pvNCr7MZx
         BlwFU03OlwWLausgmgG7ICtMVATz2iG4/WtA5brbo2hw2/MPEyJ769oW406pMTtU4UF8
         E4s5KTB2dbJKbAQ1LqCE7f4y7nM3UmC0rq6dL/DXbNI/iK4MEFA1Slbo4KmHrOGE/0S9
         4wCqVkqsv5VWLK7z7sPBUGpyJdxy0fVOs1rElhZIxtcQaR5uZiJCgk3WrEJ4uVMZzEDQ
         TqW0PgK3eRH+AnfbYBOGyMM6hGog/VHUbStj6jm2G9hhaNG3qGkjxIynljciYHYtMJlE
         FY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIdPqYs8pcB/F7X2IthUrwmWJbc2O1lsmbqHpZXh+GI=;
        b=a6J/txaPTP4BTs+Wie+R+od0nS7jhWQiONlh8OHGgdrT3OyU0JTalt9/trdxDsxa4L
         wVK1xvRspq/UhUx1bb/ZTwAjflDNmggWrT5Hpsb5M2AU5FQYTahiE0OIP8nUp8zcfBLE
         mQhO93I8MFrROci9NFGyb5ln6CboqNNo8MocCFE40fSfnVkfKqU6ss8zV47ND0jd7dt0
         peaH+MbnMvFjQyqowfrdpKzhglqhoeR+dXR2jF41peyMAKX2wTSMGOTQbwsSBig9zQA0
         0KICPH65D2t6y6MKJ1Rrjq9dsb4ZpmfbOyFVooUT8XVOmeZzBpJIYeglsqLnJNQ6a3sX
         /Few==
X-Gm-Message-State: AOAM531a6bpNkeefOWEfRSvLXEUiq3riLTCckZjH0Ly+07y7OTlz5YCG
        jSdGXHhA42YUOF8F98lv47E=
X-Google-Smtp-Source: ABdhPJw9oOFK6pyGWIH/2GPlhXou3jJsuUPf6+NVS+34/TUD9G3Tzw+tqYsd85BYIPXisSnWQkiZXQ==
X-Received: by 2002:adf:f045:: with SMTP id t5mr14744801wro.383.1643584272372;
        Sun, 30 Jan 2022 15:11:12 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p15sm10018366wrq.66.2022.01.30.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:11:11 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: remove redundant initialization of variable plane_fmt
Date:   Sun, 30 Jan 2022 23:11:11 +0000
Message-Id: <20220130231111.8563-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable plane_fmt is being initialized with a value that is never
read, it is being re-assigned a new value on each iteration of a for
loop. The initialization is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f332beb06d51..b334bbb2e682 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -681,7 +681,7 @@ static int mtk_jpeg_buf_prepare(struct vb2_buffer *vb)
 {
 	struct mtk_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_jpeg_q_data *q_data = NULL;
-	struct v4l2_plane_pix_format plane_fmt = {};
+	struct v4l2_plane_pix_format plane_fmt;
 	int i;
 
 	q_data = mtk_jpeg_get_q_data(ctx, vb->vb2_queue->type);
-- 
2.34.1

