Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25BA4A46B9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376583AbiAaMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiAaMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:18:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:18:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u14so26390299lfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSf69tG7PIiJZjbb/f95YfT3zwGq913d3jDo1s6kLQE=;
        b=mSmvVxuPIomDOghhsssyioY1wWfmHeh3wLKx+XPn2Z3AB1r8phOri+C9bFxGrpYTPc
         EUuP6fMmFONHpTu55mVb/4R9lLVzWP14upyrfePhPQWULGXtgahSLXeTowFn9HWQcVYP
         AIlLjZk4kQOITr7h0uX2ZfpyvBHLsy3AuO+c0Ea/OQgiOu86sC/ujDtCiNzhj0BPdBgC
         amspsSCUKeJi5K1mT2/iDoufuRHrTmfelJftA5jCRj0bHng+DrhnXRahabmUImFwjEeC
         Y8++8jjavxGFMDvLUQ9yvLDDs4n05M9ehXdHybx90P/Je4DYbTu0GfhZ6IIYl95jJ47M
         wmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSf69tG7PIiJZjbb/f95YfT3zwGq913d3jDo1s6kLQE=;
        b=KRS8zBcNTtx1NS1ZCu2SLEd9sGR6VlYLFD9IARLxaXA/XILQlB88BvVyhP4V/SiTKQ
         jnvB6s3b+J5H6uPw7BVAlvEH86/QAeoeRJRuUGShCV3tuKLaObPwr8c4FurPAIDlRDWL
         UBIlyDeUBXbwr7ewpU/u5Fn9sbjNwL3+5NN/x06AiAIuAIR11ag7Y0LYlHSWRl9kd3yt
         uV/IsVjhOwgSBCq3c3M4wILLvhUeJSfA4NWjpV50GVuBHy2W1UXDxdR5MoGs5juFf2os
         IUyD8f8c3fJqZTHKBu9Zi6o2Vq1z3jLzpX4HLFhmtlQ/h8eA91Bg3NTQ9hbrmej9ov43
         zBJA==
X-Gm-Message-State: AOAM530ofMu6IBGS5JOk6uT2oV1Gxk+G2yInsta9Xvg2O51zZSlJJ/+o
        gsI2ONwrSWKMyGFt96K883Q=
X-Google-Smtp-Source: ABdhPJyJrSDMXvQod4umlEZb2wZbodFyF0PtTxrpaEHy4xkmYyJgd6vtpiGPfB6x8g0dFdVMPwJTLQ==
X-Received: by 2002:a19:6449:: with SMTP id b9mr15352688lfj.82.1643631490721;
        Mon, 31 Jan 2022 04:18:10 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id d19sm2741265lfn.21.2022.01.31.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 04:18:09 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] memblock: Remove unused io.h include
Date:   Mon, 31 Jan 2022 13:17:23 +0100
Message-Id: <20220131121723.72395-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock does not use anything from io.h, remove the include.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 mm/memblock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 1018e50566f3..4ee190b3f026 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -18,7 +18,6 @@
 #include <linux/memblock.h>
 
 #include <asm/sections.h>
-#include <linux/io.h>
 
 #include "internal.h"
 
-- 
2.30.2

