Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D4484009
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiADKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiADKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:43:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E37C061761;
        Tue,  4 Jan 2022 02:43:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l15so12020651pls.7;
        Tue, 04 Jan 2022 02:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KV3FR+u8voPfKvUHu8OPNcwabevk3hL+FYCEeJsfP24=;
        b=knvcSLOHYu3D4eMyIPx2jGUSLJawr2WFA+16HoIa8z3rZ9bFPVASBKF+BwRvqj1HjQ
         tUHyJCj84u+hUQK2N20Au6GNxscPKBH3HLdDgdX9eurQXSMzCug/xYtpussSvCkDs5Z+
         wrEN9Yzfpl+8JAjcBu5QRTC+4EDgXU6NdZ9zFGQ990pb0yuHrpejqQiXmOyYNipqrodW
         wq8OipjxV+5HIk3gq7HsbH6MjErblxbxOU/fEMiM63XfPMVobD1FXBtzfPNws7+kc1It
         XldvdVLBts0nc15CgC8vZVjs2JlpcCx5YT9/xiG6NH2QmDqFuZHdE+50V017hUxUEYLB
         xQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KV3FR+u8voPfKvUHu8OPNcwabevk3hL+FYCEeJsfP24=;
        b=z92UcWJpaI+dwS2P94SIt+civEk8pEcHktnzQemGC0wOlQpWNVPKEe9vfGzMYgjYDX
         cfP+2M6tebbl1GGY3CN2sXQoNXAgkZV532jRd5tlNqxGJEIdIQaKYTWZ5PlgfST2R4vs
         qb0ZXgJHz0Driul51GAUlKVoE7saHJpMMd+dCU+NiL2disYH3xMV9xfebiyare0RXu7R
         mST1gJz1cYX4mKazemJ0g31Zxw3jUq3/KjkH/Eq2Uui4ug0JPl+547/psIvBqsS3T8VH
         ry44dhme+7TWn83Vz7r5rX5iLhlS/PHMjtKvMk8Vv8f6wf+QZNAKlob53yG0Ln+k/kbJ
         jJoA==
X-Gm-Message-State: AOAM533HrbmIdTKUm3Lify8AKd13HDvpEJHkZqhbiRoZ47UqtiGSc6lG
        RPxEclxAgZeHyZJ2NrTvZpqCF9wQU6w=
X-Google-Smtp-Source: ABdhPJxPx6qaFfHg0PvrZShXRveCF4ts9UF4tF2JpCyXR3ZcY7bOvjCYsdZ8vNYHp2+Hage6hrV2kQ==
X-Received: by 2002:a17:902:d682:b0:148:c928:1fa1 with SMTP id v2-20020a170902d68200b00148c9281fa1mr50188631ply.155.1641293026354;
        Tue, 04 Jan 2022 02:43:46 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id om3sm40795562pjb.49.2022.01.04.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 02:43:46 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/video: remove redundant res variable
Date:   Tue,  4 Jan 2022 10:43:36 +0000
Message-Id: <20220104104336.601146-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from aty_ld_8() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/video/fbdev/aty/mach64_ct.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
index 011b07e44e0d..e967536af166 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -22,13 +22,11 @@ static u32 aty_pll_to_var_ct(const struct fb_info *info, const union aty_pll *pl
 
 u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par)
 {
-	u8 res;
 
 	/* write addr byte */
 	aty_st_8(CLOCK_CNTL_ADDR, (offset << 2) & PLL_ADDR, par);
 	/* read the register value */
-	res = aty_ld_8(CLOCK_CNTL_DATA, par);
-	return res;
+	return aty_ld_8(CLOCK_CNTL_DATA, par);
 }
 
 static void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
-- 
2.25.1

