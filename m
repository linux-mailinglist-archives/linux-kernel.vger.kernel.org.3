Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF84E6BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357278AbiCYB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357274AbiCYB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:28:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A125E8C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso11037478pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGZw8qyWofqQh9TdH3MPUYSBiE8tPJPN6ibqOxgZh3k=;
        b=NWEbto9YaeDD1I3s6wEJ65UCzv+QNtK9xxA6Uv7U7TVYrQ2gvhnxZVWwRJ1F1LK27q
         ed3wstCVxtOyzEY/tQq2UP+jvtct6mVoA9fiTSDBXSXrUHZ2EkJ9YXJUfIdljyKRqHuc
         z8+7/rYRejFNgyRCAjNYuk9YDade/ela0SkA91hkkm9tHPPHNQh4UN/4qCqvNLPz7G66
         rFUSPprNZLzyX6LDPDmt07RwIc0qpRz5P+HzibnF9VW4QpduB/2SSPc5L7cnauTL/o91
         WAt51ykxTk1iYJMnPRv2ztJMy8D+YV9ZscqlUsiZUOJp9d+QfMPodJHBsMLbU6kXn6zO
         j0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGZw8qyWofqQh9TdH3MPUYSBiE8tPJPN6ibqOxgZh3k=;
        b=eq2zNHQrStvefYvGFTunq2Wp4XXW/6xQPITknNMfXnVLUoTIiY0E9V6McWc378Rk5I
         3v4aobTPNIk8ATV65/6UelwPXHdKRsAnZLUFf/P7+9+8rs13Pioc5WhcVYT77JUkW0zy
         OVJbE6lIbyXZ/0WIjoya8eRTvQItA2+03mzquPzN5meKm78Vb11RYXpJ+yT1+jwC++GC
         7Z+Fy24igLg2M5oMh7LEOJVl7RE7o4VIgMzkzfxG/IcNFEUimPuZSxtYOTsHUwujmWCh
         iDCwE765MXe0xP2C407zqeVg+BvJc8pWhMBVd3Qbg/JmnvASwZvP51JaCYrZTmbccdSh
         XOOw==
X-Gm-Message-State: AOAM533fe/lk6jtBf2dq6LGKrdAH7nHxBp5fMGYU4uAZUX4ISkQUCYLw
        7teTzDAT/ZlCdTnz1ykgoMNXn2isKIM=
X-Google-Smtp-Source: ABdhPJzoKMnJ0cn6ry3V9hAQzfkuM2rS327FjALdJuonRTYitc23EGTSmeNm8KvhgLciQK437AGBpA==
X-Received: by 2002:a17:902:dac2:b0:154:5d6d:cd02 with SMTP id q2-20020a170902dac200b001545d6dcd02mr8923631plx.123.1648171594820;
        Thu, 24 Mar 2022 18:26:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:d674:140:d261:4ff3:2835])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm11729204pjb.29.2022.03.24.18.26.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:26:34 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, lucas_tsai@richtek.com,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 2/2] regulator: rt4831: Add active_discharge_on to fix discharge API
Date:   Fri, 25 Mar 2022 09:26:17 +0800
Message-Id: <1648171577-9663-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
References: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
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

To use set_discharge helper function, active_discharge_on need to be
added.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt4831-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index 8d24b5f..2016062 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -127,6 +127,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.enable_mask = RT4831_POSEN_MASK,
 		.active_discharge_reg = RT4831_REG_DSVEN,
 		.active_discharge_mask = RT4831_POSADEN_MASK,
+		.active_discharge_on = RT4831_POSADEN_MASK,
 		.owner = THIS_MODULE,
 	},
 	{
@@ -145,6 +146,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.enable_mask = RT4831_NEGEN_MASK,
 		.active_discharge_reg = RT4831_REG_DSVEN,
 		.active_discharge_mask = RT4831_NEGADEN_MASK,
+		.active_discharge_on = RT4831_NEGADEN_MASK,
 		.owner = THIS_MODULE,
 	}
 };
-- 
2.7.4

