Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B454D1F09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiCHR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbiCHR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:26:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B1554FAB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:25:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1986122wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGktKJizHZVjsrjgZFodxerrowYpvdxzFK+Cr2t24Mo=;
        b=KmoPPagva7he8/HnKEgGM1bMMYLW9XsM0ghW7rtM2k+2KbB9fHmpnOnaGbqadao4kL
         I8AkMhZnJD0E0mzUUsEtvnthY3OQ2fatg66kn3GFD2pSx6OFEN10ZzDYAq93cg/kyhV+
         LdqU1waJQvtm13ob/6CDBlNsKgtudpKT9MfCglTzPy4oiKe8+MftPWyLsyV+t/muWD8+
         binkxwiW5X7cqq1guFr94P0bEnguwoeT+zYrgftnWoPAlN6Ix2tKkoyuQnrtidum7gRW
         qPeN//biS1Pxeutt66BIVX46enznQ9xkr6mmFl0+CuvBQFxudX1+HSs/eDRdbJKmh/l6
         yPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGktKJizHZVjsrjgZFodxerrowYpvdxzFK+Cr2t24Mo=;
        b=S1wFn5s5DoGKNuf+GbRvMBskZKT5o0M1BuLykWNUUgnM6k5BpzYonAEN1Cwx2v+GAi
         Kp4b8C0XU2mCVrojGcW4+EUqGeGuI14nm8yybxJh0Z4NukZWiaEO/V3T/txkEj/cWUnC
         Uvwi43wFWz22F9mIsSODZ3VKlaOuSD0ppuWeNBPoC1hz1sO6z6aIK7X7brI+r+ctqfEC
         tukEukDAigAb9xRW9K07tgKoyK79LGepWse/4xzb8Fzv0AYAkRFC6zPB/I7RUODSpJM1
         b6npo2prCzwnlMZWzGWKOAwsNkOYVQcIA8oUC4LH/irUX6GTw0zT4kmz0nKzZoaGiJNG
         s8jQ==
X-Gm-Message-State: AOAM5306wPS4PvVuf5sCXiGt9wHnKg1q8C7j6z0IDjsSIounA36T7psE
        l0mgBKwiwLE7ijB0sFYwvawSaQ==
X-Google-Smtp-Source: ABdhPJxvMANRF/pgTQEd6b248KCczrv3ebvNRgSao58Cw2Z9VZihaFdEu+Xg1zMefhR7PpNbfMWF2Q==
X-Received: by 2002:a05:600c:4f85:b0:382:e2bf:5fd2 with SMTP id n5-20020a05600c4f8500b00382e2bf5fd2mr276926wmq.30.1646760303349;
        Tue, 08 Mar 2022 09:25:03 -0800 (PST)
Received: from x1.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm3047328wmq.19.2022.03.08.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:25:02 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>, Suman Anna <s-anna@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] remoteproc: move rproc_da_to_va declaration to remoteproc.h
Date:   Tue,  8 Mar 2022 18:25:15 +0100
Message-Id: <20220308172515.29556-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The rproc_da_to_va() API is an exported function, so move its
declaration from the remoteproc local remoteproc_internal.h
to the public remoteproc.h file.

This will allow drivers outside of the remoteproc folder to be
able to use this API.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[adjusted line numbers to apply]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note: I previously posted this patch as part of a series:
[PATCH 00/11] soc: ti: wkup_m3_ipc: support vtt toggle, io isolation & voltage scaling
https://lore.kernel.org/linux-omap/20220219215328.485660-1-dfustini@baylibre.com/

I was advised to break that series up into smaller pieces, so I am
submitting this patch individually. I will in the future post a series
to support i2c voltage scaling which will utilize rproc_da_to_va() from 
drivers/soc/ti/wkup_m3_ipc.c

 drivers/remoteproc/remoteproc_internal.h | 1 -
 include/linux/remoteproc.h               | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index a328e634b1de..72d4d3d7d94d 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -84,7 +84,6 @@ static inline void  rproc_char_device_remove(struct rproc *rproc)
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
-void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
 phys_addr_t rproc_va_to_pa(void *cpu_addr);
 int rproc_trigger_recovery(struct rproc *rproc);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..cc9dc9aef0c0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -673,6 +673,7 @@ void rproc_shutdown(struct rproc *rproc);
 int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
+void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
 void rproc_coredump_using_sections(struct rproc *rproc);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
 int rproc_coredump_add_custom_segment(struct rproc *rproc,
-- 
2.32.0

