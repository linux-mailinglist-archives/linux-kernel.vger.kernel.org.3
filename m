Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29F74BCAD6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiBSV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiBSV4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9B541A8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z2so1237181plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xFv8pYP/ZU+UReQceN+3cdKUVINAH0lfYR5sSaL4wpY=;
        b=XPsUi7jSiA5kjSrk5AzxuhDHnSy45szyngwKqcCazfH7MoUZob4Lm3qB/pUi+xGH1w
         tM2FTl2egymaCOspqlEYDrzD7iXa5xVrTZ5GeLKxYZzbH4R7UehkDivjq5OPJiotItOs
         fKrT6Etz8W7S5vIN7qCH3x04vVBdMLLHfjy+uoDjlbBK4EnnJyLJtPTURv+kLWXXhi39
         +3ekYDxTkPkpAjFkPprNKmRbSUMpOa2XWRWcwRVdE/LKBcDKQ5qLIBZX0JoZDg9/gH4r
         ydgqdMa7gdqIe+e3fy3oMstvVM4dBgTXBGUGgEshGlHfPMQ8ULFmRInkq6jCb39i2CS+
         LmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFv8pYP/ZU+UReQceN+3cdKUVINAH0lfYR5sSaL4wpY=;
        b=TJP13rzEsqDqp/x3QsRe/rzxP4kzvCyHHSS49/6axCrq4pOv/oieadPVwO1zhBejOb
         zRZX0+psftkyX0moRNMiOgzLR0OjpevGorECZ7X6N5zqENx+za3A8yOqocWWicN7y3zG
         XEY9GKGADXmgOnALzv2NC/C1I8SeVh/LLL/MOcEaNVuJhR2UQd8hIIp2Px+qduGHKRie
         TdtETxcrhtEx+S8BarKNeKLHhs5UDD6R13hFebkWCEGoYN4N0CemCHYJOjGkNX0k+BbB
         Z03tdRvfnNWYocMAPD7vihW+Y2P+jcGJgiXOuq8TPeP8iDr37cy8ZzadR9oiIYK5Kc8T
         WxYA==
X-Gm-Message-State: AOAM531NhkV7Kkvj4Fb2rvxyEdVY/7YxZIUk5Cpi4SghjMdoH9U2Tv3G
        cqEg0mIL2pyUGE6BIumpZodZsQ==
X-Google-Smtp-Source: ABdhPJyS54Vh+H8WNTs+GkpNEVkoLaIFTLqYsD/C0UVOD/Oa+ZbdqlFNf5Y7Edc06y/9TO+gZLiBSA==
X-Received: by 2002:a17:90b:f88:b0:1b8:ad41:e200 with SMTP id ft8-20020a17090b0f8800b001b8ad41e200mr18633706pjb.1.1645307740514;
        Sat, 19 Feb 2022 13:55:40 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:39 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, s-anna@ti.com,
        khilman@baylibre.com
Subject: [PATCH 01/11] remoteproc: move rproc_da_to_va declaration to remoteproc.h
Date:   Sat, 19 Feb 2022 13:53:18 -0800
Message-Id: <20220219215328.485660-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
References: <20220219215328.485660-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
[dfustini: fix line number conflict]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
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

