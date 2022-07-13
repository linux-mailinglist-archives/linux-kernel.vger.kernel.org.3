Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D640257310A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiGMI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiGMI01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:26:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A5974AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:24:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bf13so9782229pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5sAsO2wYpmyBej1oI2gW5mRBt9gRqB28PHRf25uIGQ=;
        b=qtoQgyqqiU+0o98lMh7dHFARhlde72nzdf8xKOpdxyrqm7c69W1Io2bpt9CyU9jiHU
         DoCfGSXS+g75/9d2aAtMe4mjzAu1JeMgEHWS/70D9B9wuJm/l7HquoZBFgJj5hW1spcc
         CuhsYkSLqzbn6m4K1c7WgNpcy3jQbvs5414FvYl6dZ/3NK1XJf6ObCL+XxnS1kHO5+q/
         c8zBaUuMoI2iZG9fZfbTLo4/+4BBEhHbvUm8PCm5oVwlym+pStTkENOQZQlR196QnGiv
         xyGSJ1elMeVyVZq+nwQr36sjQUtZeK5csa2XZJ8+6A6+JdT5adWmMRwair4VTYdAgtDL
         x4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5sAsO2wYpmyBej1oI2gW5mRBt9gRqB28PHRf25uIGQ=;
        b=rxJuIBCm3LJ8K/jl35QGWu6UQl0Xi4WR/PI+Rtx9oFtwzWTlV52Re/K62IQk3m8Qap
         r5oyMO+FcGfd68ajLu5evV5JboyUvMIbcDJajwOeM2LyPwf58UKc1RpeCK+rWMpVvcok
         XySvWE6fjp7vupBgiFdy86hCHOb/Eo2v/39VlYqINFvujE6J7Ocxu3LxToWi2BS6ZWhQ
         OpT2m2iQn3OOcJbQ0IB5+fRnIoxUVOwrub8MKYxocuWLAbsKKQVh/O+AZTDrqxxYM11j
         YItxyXDaJBY76lomJy2lkSc6OEbwoVhktYLsUE6mKbQcx5KKGDHrOETRQieVzELLULv4
         3P0w==
X-Gm-Message-State: AJIora9Gkgp6hjky/JkXAdUsaaaTy7drKafdbbYengbvqiFlwpDGlYVU
        8SRP5wFhJyiUdxllzGbyQ2Y=
X-Google-Smtp-Source: AGRyM1uG9QBFxxiKV/qBDJ8FA1qcEfj7UjQx/7Zs/Qj4kDxgnDow/shJbk2lOf1p2H3QCro3qvciVQ==
X-Received: by 2002:a62:7b57:0:b0:52a:bb3b:21fb with SMTP id w84-20020a627b57000000b0052abb3b21fbmr2223245pfc.21.1657700696152;
        Wed, 13 Jul 2022 01:24:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:1:c5f4:8afc:8ea:ba5d])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001ef8ea89a33sm991613pjb.2.2022.07.13.01.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:24:55 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Check nslabs after initialization in the swiotlb_init_remap()
Date:   Wed, 13 Jul 2022 04:24:54 -0400
Message-Id: <20220713082454.700487-1-ltykernel@gmail.com>
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

From: Tianyu Lan <tiala@microsoft.com>

The check of nslabs less than IO_TLB_MIN_SLABS should be later than
initialization. Fix it.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffb23c0e0e8..c39483bf067d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -308,9 +308,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
 	/*
 	 * default_nslabs maybe changed when adjust area number.
 	 * So allocate bounce buffer after adjusting area number.
@@ -320,6 +317,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	nslabs = default_nslabs;
 
+	if (nslabs < IO_TLB_MIN_SLABS)
+		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
+
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
-- 
2.25.1

