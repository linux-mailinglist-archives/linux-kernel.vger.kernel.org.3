Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA34EA78B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiC2FzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiC2FzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:55:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D25EACAD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:53:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d65so9799940qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ES53g0OOqsPoiGi2d2Co81xUcv6Z1BfsAHsJmc4I4=;
        b=RlMWCaOrAo5dN1BiL6EVuuy1RvRkHVnOIIbStddIbRL5Tff3uKYocdMkA+X90v6Fp6
         q61Ck7S19m2JKbIxic+yoY97H1FNks/88LSGlKfUWzPRfdNrUa4koSZn2i8z9XOxU7Y4
         JoECdrQIT8aOikMti6FwwT1MMczrwysp7zevGR8L97OMkJ5RwafEOZGEWHgjWkAPrNm8
         2hagbnApe8/dJ7jwkppFVBWFWS4pjXfbddsBMdUocBkc4w+uZtBGml7Xaqu+iqPLxz0s
         I4d3z93wekZmLNdVuSz+LaySzuN7N5OXi6jV8X5bPqeCivCAH4GlhqcqFu91MEB0ERPs
         wzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ES53g0OOqsPoiGi2d2Co81xUcv6Z1BfsAHsJmc4I4=;
        b=tYiJPDaHYV1nrmpvoqTE09YCQH1uDnfgvG9nIcM4FwLCDtws9YrCMdxB1E9W4iM617
         nNUGZ8R0xLGNgeYzqdrfFVloG72vmLLXjVhJ1H+e/Lg9fZQ/hthlt+DXcAZnMpFZccug
         JEtT+Xdlmcn69grwSWkXdqchdvPWy79j2eFVCU9AUBx1Oy6E90S2AxbdgwzWHuC9lCZF
         6iVeo2kOlKtyVEjW6i9WPb8tVPjjCFHx90t7Q2hIf7cL610FoHrwOQ5JzIkDHAIMKUlz
         JcE4/bpHiwbnajkpKCP5QBRM8fKGCFvFaAdot73j/Isp1zZM/JoC0VgSKrfFcRRYU7Qy
         7GuQ==
X-Gm-Message-State: AOAM530vxJZ2+iIdkQmrvz6GZKqkZ8RHT1pMj7atNccvSRf1i48+KRvo
        OKIumg3X0lSYaJ0jChX8W4JgR4EAp6o=
X-Google-Smtp-Source: ABdhPJzx5EMjqNBolLzGQPqTHbHt0diMdH9y1Q1vkoKXBy0Bq3/cBK5s99yJKHmDbeOjCWuRtwLKkw==
X-Received: by 2002:a05:620a:4491:b0:67d:9929:ddb6 with SMTP id x17-20020a05620a449100b0067d9929ddb6mr18554334qkp.47.1648533209079;
        Mon, 28 Mar 2022 22:53:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm14153307qtb.28.2022.03.28.22.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 22:53:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iommu: add null pointer check
Date:   Tue, 29 Mar 2022 05:53:22 +0000
Message-Id: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kmem_cache_zalloc is a memory allocation function which can return NULL
when some internal memory errors happen. Add null pointer check to avoid
dereferencing null pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/iommu/fsl_pamu_domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 69a4a62dc3b9..43849c027298 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -152,6 +152,10 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	}
 
 	info = kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
+	if (!info) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return;
+	}
 
 	info->dev = dev;
 	info->liodn = liodn;
-- 
2.25.1

