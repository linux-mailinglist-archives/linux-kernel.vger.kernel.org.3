Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC19488CE1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiAIWhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 17:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiAIWhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 17:37:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC95C06173F;
        Sun,  9 Jan 2022 14:37:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o3so23357900wrh.10;
        Sun, 09 Jan 2022 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAsgOQMc3UKaM9UezU0vbWaZoPnffHLnW6ZeF8Qj0QI=;
        b=o+1lAT46noVYrgjZW9HZPc4qtWWikPTfj7o3lrQey5wipz6hDagam9IyTzyQlrIuDf
         C3BLmI4U+rXVZnmH8cuGyo/fZcLaPKWtzc+V5MI3Rcb/+LT6OaowZHljFj96uBXarKIL
         YKWJEHyyk2W4x6lk9ifx+CRWtoiV3oXqknRpjxKNjacAPANhA2XV+hQs9ZBWDnv8RStH
         8So2Sw8zJc0AmNx2nSJlnsDrqon/AedkMcLG6IDjfbph6Qc1ra1+8QBwTNvjhva/NgTu
         agAjj/Vxc3iOMCgURtm8kAjfGbozceWZM5OdYGC9cPaltCp+J+wCuYMy9xPsq7QB6Agd
         djoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAsgOQMc3UKaM9UezU0vbWaZoPnffHLnW6ZeF8Qj0QI=;
        b=E8HC+ImDe90tyMB5JK6MU0MsC48IoiYU/CLqgJC1ERq3436Q2FQ+vUefEQoMR1SSNf
         5ZuY172V9FLio7dCqTW3zD5oOgCeV9Txd5rtw+SSs0t/uyx86DuK5B8ZMWy4Pv5UqCOt
         AMBXR9/r4Hn5BeKvmY9tDlO3iIFWs+H3Zn2EWRaVecy8YLI8bU5KTZuIzdZANsKxMVot
         bW8hGpuZiIhMfIF1Lfi6fCKQvXfY9cYD4+9T8uWQARf8QpyO1P4QJLKaggU/VlumwMF7
         wtjnpHHYEPvGGCvahG+0TN3eNU2TG1LN/axQ4PprKHNF68kEhaVJT7oIpf+EXyZUxv64
         4G+Q==
X-Gm-Message-State: AOAM532t+iAY0R3qa0giW2qi4Nb400YMMnRQfIS71rwuilY8JMjuwpoJ
        Z3zSY0I67ae5wussjft0tUrZMaSrjeGKzw==
X-Google-Smtp-Source: ABdhPJyH5i6RVFey13kTaLeghj8KZIguTmG4qmxVgzJ9wwoBuJgCycBO7xSTg+/0yiCjBMUkLWOyrg==
X-Received: by 2002:a5d:4450:: with SMTP id x16mr61237707wrr.95.1641767841045;
        Sun, 09 Jan 2022 14:37:21 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g6sm5266102wri.67.2022.01.09.14.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 14:37:20 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: aty128fb: make some arrays static const
Date:   Sun,  9 Jan 2022 22:37:19 +0000
Message-Id: <20220109223719.56043-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate some read-only arrays on the stack but instead
make them static const. Also makes the object code a little smaller.
Re-format one of the declarations. Add spaces between commas and make
PostDivSet unsigned int to fixup checkpatch warnings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index e6a48689c294..882e3cdb750d 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -952,7 +952,7 @@ static void aty128_timings(struct aty128fb_par *par)
 	u32 x_mpll_ref_fb_div;
 	u32 xclk_cntl;
 	u32 Nx, M;
-	unsigned PostDivSet[] = { 0, 1, 2, 4, 8, 3, 6, 12 };
+	static const unsigned int PostDivSet[] = { 0, 1, 2, 4, 8, 3, 6, 12 };
 #endif
 
 	if (!par->constants.ref_clk)
@@ -1321,8 +1321,10 @@ static void aty128_set_pll(struct aty128_pll *pll,
 {
 	u32 div3;
 
-	unsigned char post_conv[] =	/* register values for post dividers */
-        { 2, 0, 1, 4, 2, 2, 6, 2, 3, 2, 2, 2, 7 };
+	/* register values for post dividers */
+	static const unsigned char post_conv[] = {
+		2, 0, 1, 4, 2, 2, 6, 2, 3, 2, 2, 2, 7
+	};
 
 	/* select PPLL_DIV_3 */
 	aty_st_le32(CLOCK_CNTL_INDEX, aty_ld_le32(CLOCK_CNTL_INDEX) | (3 << 8));
@@ -1360,7 +1362,7 @@ static int aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
 			     const struct aty128fb_par *par)
 {
 	const struct aty128_constants c = par->constants;
-	unsigned char post_dividers[] = {1,2,4,8,3,6,12};
+	static const unsigned char post_dividers[] = { 1, 2, 4, 8, 3, 6, 12 };
 	u32 output_freq;
 	u32 vclk;        /* in .01 MHz */
 	int i = 0;
-- 
2.32.0

