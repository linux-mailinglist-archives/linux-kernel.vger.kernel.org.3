Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437D2488C26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiAITvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiAITvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:51:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29130C06173F;
        Sun,  9 Jan 2022 11:51:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l10so22844823wrh.7;
        Sun, 09 Jan 2022 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1AMiJvHNkryIw3zq3NggfXLhQA0Q2EvdEfeBbUqQJk=;
        b=aHe7mNIczcm7TCfDxqBQG2VIjLxWDMqx/qbHztIUodmkRcpR0c/nzNuApL4Q9K4Mdj
         16Axw2LGRfw5uaRPWd5uJBfyCgxXAON9phKk8ZIO+N/VbSsqL6I6yCxDF9fO3H3P21ew
         4L4DQFLYzJaYHG1HnmrENGenh+7h+/v9kELHvblwdyQn/obdp4+Bfw0qzlIFrx302OLu
         E8yy9UpOUGHnt6O2QvnkyffXJ+zOSzOu0wGtKqwGMU03Bdzc65xzV6BMxqh+xpzJ0ens
         3v+ihWU7UaMO0RTLgyTzfwekIDtyOoe3Mp4FCgyk8420yBFTKcceUH+i0Pqxj2RYl5Qb
         Eb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1AMiJvHNkryIw3zq3NggfXLhQA0Q2EvdEfeBbUqQJk=;
        b=teyAfkG/iVI7uRdR3F0li5XwXEmpEayP11MTL08J4465B6w4trYQ2168pbq5rZJb27
         IIXYpBfcZid/pp6hSbYW4FcRBVgtYKD30RNau1ICwrISfHBUuyJBwxSqRLlwAF5vDlYz
         tpViUdpqdlqxktvV/sG83QO8Y+38l1VkBLnhe71kI5sDDC8rOT3AAAsi4ihjrxgfgV4c
         rViZ/mxOKpEkg2oWI1+C3Lsy/lMqi7SKHGoeNYNMaDRdIGKWkdJvDQavEnqkCw8pS4lj
         JxZsE8fwtJtNrt1sqaalDOQ/naqlhKfMr5OZ9hq4J/i1RRK2ihbKa620k01U0igHK+en
         gf4A==
X-Gm-Message-State: AOAM5306KlQZsLsjIrXL73OIEu8JXKGkjE00wE+gaeiUw5rD76jRFOaR
        MfQmkWycjPY19Q1Rk1kk/Kk=
X-Google-Smtp-Source: ABdhPJxjZVTMHT+0k4EdM0whztncj82t+8E6deuAW+u7Dda4nR1z+UqDqS9/1mLW8rO7FS80wkxrXQ==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr21664358wrd.560.1641757890760;
        Sun, 09 Jan 2022 11:51:30 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 5sm5411820wrb.77.2022.01.09.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 11:51:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: make array idx_map static const
Date:   Sun,  9 Jan 2022 19:51:29 +0000
Message-Id: <20220109195129.46118-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array idx_map on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../atomisp/pci/isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c
index 562662ab8a44..a70bce1179da 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c
@@ -44,7 +44,7 @@ ia_css_macc1_5_vmem_encode(
     unsigned int size)
 {
 	unsigned int i, j, k, idx;
-	unsigned int idx_map[] = {
+	static const unsigned int idx_map[] = {
 		0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8
 	};
 
-- 
2.32.0

