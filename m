Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A016D569F19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiGGKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiGGKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:03:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998D26AF1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:03:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so10888687wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+l1iL0NEuXMTD9v+9+cJIdeSZBJgkzTvXEeRZPmJDmc=;
        b=ILohkxWDl/nTQzvdTCs8NkfmN8dgIhtrnAZn0crydzEMid/17eesAXMw1lryR8vUNg
         dHI1vhLtMVAOnjEYS66sw8Gup4ggYg+CUi5ki4AFxTQ6PiYwpCAAsVzUbXDLHUYIUELv
         MjNC3X6CyG8utflI11bDVMLJEKs7VPYAX3qji72TYPzL/dVnMe2nGVE+csd/enpKur7I
         ANBa3Zt68bafqepLiOEsDK1FDotparNMJWyMg4jd3SwvnhdZhdMu1z49pR+JqBtso11p
         JNndb2Cy1VMsZqu4m4q3+ojhf/3eu/CHbfeTw+Zw4c2NpERB0s5ihjz0LO0HlBmufvY0
         jqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+l1iL0NEuXMTD9v+9+cJIdeSZBJgkzTvXEeRZPmJDmc=;
        b=nSzdJPsQB3/ToFMOeQDBwEzssW3e1kfJFyt8W9xwhBHpWaET1PIKqAFAKPHlzmQoA6
         ZRQSijuvZimy/lch+BiQJRN/dWmCtC+HktSiTcYS8iPsLZ6+VpLpTRjHhUGZgD/Z552P
         THLfhClnJWIP22P48iwYuCWZT9EtHeHOHfp4VMt0N6GNdSiaUJbUjfiNafDZ4p8BLLhG
         H+ec5bFIdNsSzZLBAUPrgJqA2esQP+VIcICV4+JDio9IpvdMCeBkj90j/CxVuLC4+5P8
         Rh9Lmu4CX6+wmF7yeUoOGQlEPbGhgTwYmYTkdZWuc9SRsC0HAd+9zMWF8Z+PudlhzANO
         g0cg==
X-Gm-Message-State: AJIora+MmOz26pgEval4ySaqjQuwvXSTmHLUQyVUnxhu3mGbDphvqlST
        kelP4AXclWDTVCnqvqz+1iLcERRJvtgQdw==
X-Google-Smtp-Source: AGRyM1vwP+rjkJ16/oi7CdPdPHtzE/ugfCPc/WqLwUxB+Yb4OogyiysKjo2MWcBXiuhJp86oGRPH5Q==
X-Received: by 2002:a05:600c:40d7:b0:3a2:d438:4e33 with SMTP id m23-20020a05600c40d700b003a2d4384e33mr113235wmh.33.1657188220194;
        Thu, 07 Jul 2022 03:03:40 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d548e000000b0021d7ad6b9fdsm4612034wrv.57.2022.07.07.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:03:39 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC PATCH 1/4] clk: Use clk_core_unlink_consumer on __clk_put
Date:   Thu,  7 Jul 2022 13:03:06 +0300
Message-Id: <20220707100309.1357663-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency, use clk_core_unlink_consumer rather then hlist_del
directly, on __clk_put. Prepare lock is already acquired at that point.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..e1d8245866b1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4347,7 +4347,7 @@ void __clk_put(struct clk *clk)
 		clk->exclusive_count = 0;
 	}
 
-	hlist_del(&clk->clks_node);
+	clk_core_unlink_consumer(clk);
 	if (clk->min_rate > clk->core->req_rate ||
 	    clk->max_rate < clk->core->req_rate)
 		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
-- 
2.34.3

