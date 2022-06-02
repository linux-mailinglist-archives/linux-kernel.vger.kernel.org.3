Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034853B31E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiFBFoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiFBFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:44:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9722E691
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:44:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so3946204pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 22:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eMtJVeZI1KQcNXj557Juxr+LA31+JeDU+zp2yc6qXaQ=;
        b=JRu0GQwj96tRIGf0GuDeb++vELbXRr2LCcmXnc609jXDrHWJYjna7zLYkjxJvwR0LP
         EpPC5BkOO3vqmGKCcrjc47DZk4/MVwPscg90qAorPE2YblXa4M0kJuB/MTw+ySTZZzp2
         F0TmVC5PAAGmfPEveezdA/JvEgsDY++MPNwAcTJar/vV4J97M9lzHnorrjqeu3QK5M4r
         mXMmZWf3H49z80GutNd+hO7MT/lAbVKZ3+9Acd0eeR38akCZDeAJkyJOr2h0vjAXfD8S
         Ia4/7Nqr4w94vrx1ZDd/98iPfXlRGNUGMEu2gafK0wBjqvcPw9DAV+1LJTVZUAWSdOyw
         bMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eMtJVeZI1KQcNXj557Juxr+LA31+JeDU+zp2yc6qXaQ=;
        b=6InLFL5mZyBlaIlEnRGFpWml8ajRJd9b20jTHbr4TPdkUqka4cpsiGpCzJpTAcUjRK
         PuM0E9Xg8iWjyG4O0WJ+hoUGZMuQJaJMxZzYud8xlPx8P5nt6wV/F8bFuAUQZVrZI1Bg
         Gyg3ljUb3wu2XRs5AliCVLGjuA6Xp3Geff6YRLPQfHQx6OHPeNFUeLfpqQe26VDvaKnm
         lQ5eSSJdJvYiuWa0ZkycN0RAriL1Q/ySFY5gbIaSuKxAq5J13Qh2POreJlGkCaRbp9SW
         jSUequMg/I17gMvB0gHoW0m4mDgKLwvXhaXY2T1d7M4Gc5dQumFN7JLWy/SaPTdVaYPn
         bg0g==
X-Gm-Message-State: AOAM530U61YSw0AhTWLCAZqnZ3njQjbTknHwholyo6+TTJPHzH5jrv+6
        inIGTj/0bPK1jsfoW01tFWU=
X-Google-Smtp-Source: ABdhPJyDaaKOQTiD9f5t5H7dhhDQ7PJ35+v6kLxUVMnDwfF/DH1iVSDcq37LLNdEfP/PfxAlenQIDQ==
X-Received: by 2002:a17:902:b70c:b0:156:16f0:cbfe with SMTP id d12-20020a170902b70c00b0015616f0cbfemr3178691pls.152.1654148655756;
        Wed, 01 Jun 2022 22:44:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:e4e7:9594:e92e:b3a9:bf26])
        by smtp.gmail.com with ESMTPSA id 184-20020a6300c1000000b003db0f2d135esm2359987pga.49.2022.06.01.22.44.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2022 22:44:14 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rt5190a: check if init_data is NULL, bypass rt5190a_of_parse_cb
Date:   Thu,  2 Jun 2022 13:44:06 +0800
Message-Id: <1654148646-12182-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

If the node for the match name cannot be found, 'of_regulator_match' will
returns init_data as NULL for this regulator.

Add the check for the init_data. If it's NULL, make 'rt5190a_of_parse_cb'
function directly return.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt5190a-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/rt5190a-regulator.c b/drivers/regulator/rt5190a-regulator.c
index 155d4af..4a3397b 100644
--- a/drivers/regulator/rt5190a-regulator.c
+++ b/drivers/regulator/rt5190a-regulator.c
@@ -224,6 +224,9 @@ static int rt5190a_of_parse_cb(struct rt5190a_priv *priv, int rid,
 	bool latchup_enable;
 	unsigned int mask = RT5190A_RID_BITMASK(rid), val;
 
+	if (!init_data)
+		return 0;
+
 	switch (rid) {
 	case RT5190A_IDX_BUCK1:
 	case RT5190A_IDX_BUCK4:
-- 
2.7.4

