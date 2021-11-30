Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE3464039
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbhK3Vba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbhK3Vag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:30:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE0C061746;
        Tue, 30 Nov 2021 13:27:12 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 207so43715939ljf.10;
        Tue, 30 Nov 2021 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fW57DJCflj9Czm2LmI1wf0fuzXj4W5mILUpBX6EJdfY=;
        b=WyQcCsIe/DugGdcAJzOldQC41dgxV+DRaJm5/TmKpNqv0rXB1aaQn3bOGx/tOeFfXs
         40WR24EdhIlcAeJtHLNL+DxRsIeYMdyRXY+zRfu7xvOWN9bnAVuHGhiosnrNzcKqo9Oh
         QYbKqq5PO0guqKipe1IilOYV93pGQ31BgTBy0IgxUeqN6SeJcCOfLoZG5YVGWKMBF5Yo
         zKd8a0BL8f5cY9dIGGOfFRr+hunthxUXNg2Jv8gci0XWq3RnKrCiS+uQJu/okHJTFvcT
         kZEXMU1UXEjRw0xOEgYjAbD11hdHAYazk+RI/c8N+mGNNmzoJ8DcvHfbeiHgm6yoGQ5R
         jfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fW57DJCflj9Czm2LmI1wf0fuzXj4W5mILUpBX6EJdfY=;
        b=eWt5uRlu6iC9tsUG1mD8nKlSYrCYaXFtb0CZ4DgVt/PB5+8CF/TJG1++GXs60yZ/hS
         Ki2elR5l+mkLSrgzchcslvUsgnoiDFv5B+lnWWemFyCrZ285rzsycnfw8H6lu/ZNDy/9
         OpmSoABjrPyBEoLvOQc6p2SUUG2MoOh1aNdj5N4mBMOkWENNgkSElAtng/Tbh6IP5sua
         LggBJzX/w7uPpuGlzi4Mn2aAFMWihcXwT3626rWAgeS9PSFPuXxwTQe/1a39536QxCjQ
         EnNPTKLD4LODG6/SdatREYEgncu/qYfCVHFRGZjwKYkZWge1ljkaAMwL6Bx6lfH/LDnv
         LVkA==
X-Gm-Message-State: AOAM533FWQ7HjNvRLNCudJClSfwTCZWwa3u10KxosT5OqVTrb7qROI7I
        j0d9/A2UKtDoK4140nwki2s=
X-Google-Smtp-Source: ABdhPJzs7IydSf8Tqo+R/9FCwk8GblCTiaAo3fa9S+9PZN9gXzFaeymJ7GUbuv1wMhu0IWEnNcOPGg==
X-Received: by 2002:a2e:8091:: with SMTP id i17mr1482583ljg.64.1638307630683;
        Tue, 30 Nov 2021 13:27:10 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id k30sm1831925lfv.196.2021.11.30.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:27:10 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] media: s5p-jpeg: Constify struct v4l2_m2m_ops
Date:   Tue, 30 Nov 2021 22:27:00 +0100
Message-Id: <20211130212700.1253521-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of the v4l2_m2m_ops structs is to pass their address to
v4l2_m2m_init() which takes a pointer to const struct v4l2_m2m_ops as
argument. Make them const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 6 +++---
 drivers/media/platform/s5p-jpeg/jpeg-core.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index ebdfd24e9cd5..a8d9159d5ed8 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -2425,17 +2425,17 @@ static int s5p_jpeg_job_ready(void *priv)
 	return 1;
 }
 
-static struct v4l2_m2m_ops s5p_jpeg_m2m_ops = {
+static const struct v4l2_m2m_ops s5p_jpeg_m2m_ops = {
 	.device_run	= s5p_jpeg_device_run,
 	.job_ready	= s5p_jpeg_job_ready,
 };
 
-static struct v4l2_m2m_ops exynos3250_jpeg_m2m_ops = {
+static const struct v4l2_m2m_ops exynos3250_jpeg_m2m_ops = {
 	.device_run	= exynos3250_jpeg_device_run,
 	.job_ready	= s5p_jpeg_job_ready,
 };
 
-static struct v4l2_m2m_ops exynos4_jpeg_m2m_ops = {
+static const struct v4l2_m2m_ops exynos4_jpeg_m2m_ops = {
 	.device_run	= exynos4_jpeg_device_run,
 	.job_ready	= s5p_jpeg_job_ready,
 };
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.h b/drivers/media/platform/s5p-jpeg/jpeg-core.h
index 8473a019bb5f..4a5fb1b15455 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.h
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.h
@@ -142,7 +142,7 @@ struct s5p_jpeg_variant {
 	unsigned int		hw3250_compat:1;
 	unsigned int		htbl_reinit:1;
 	unsigned int		hw_ex4_compat:1;
-	struct v4l2_m2m_ops	*m2m_ops;
+	const struct v4l2_m2m_ops *m2m_ops;
 	irqreturn_t		(*jpeg_irq)(int irq, void *priv);
 	const char		*clk_names[JPEG_MAX_CLOCKS];
 	int			num_clocks;
-- 
2.34.1

