Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5AF5A3FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH1Uk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Uky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:40:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09926139
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:40:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so5983376pgg.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5TKSzCkq+Hjec3ecHLHkEdqDfDjWmi1Bym5aA69ZNIA=;
        b=mnfJBsV9a3uIqAfaRUMXms0tHpa9eIdBMuHWtBtjnkSU5zHX5mqpuJ7/3J9Yfc7LD4
         EW+oiPnTmDKkyPmoejg2T4d1+qQOFiU89yRtRPgJAqWrk6t/CHny+8hwUSrxkNf0QMXA
         B9hIJZNRwSBSiuN5PhiVkvrqhatAkGX4p/sdkMLcCEsFIsOrE+52BFdcz2utLPI16iji
         lNz4tZ7yfn+hPiGe1b2YmVq0WuVMGXVUGTsqaW+lPblUsP+ZrOfAYYiUbvImBhd9kMdG
         NyWB1pclvvn+QX2UAAl56uKFqdHia27yhQWjQxNPQahxrwexJBx4K1GJV/+AkmzYtQD4
         uqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5TKSzCkq+Hjec3ecHLHkEdqDfDjWmi1Bym5aA69ZNIA=;
        b=UnjOgafBegCd7+KUlsrnTo1ihQvmnAGKaxmbGAqJ1oUJCAFccGfVKxQiXEtMjBrEkd
         uxR5YuXCTC80D8saqwp1mv5oafyiShdnMonyOnXy9VdCv8IS9pddm1Nk+wgXXi6fF/S9
         rq2nOGRzafOaedZTZWxk0zOVchlUm6xBf+OCytNIhMwpOYJQgydNfpIHfQ8Irsn1jqLy
         xjRIf9M+VBFJog2jEY5x8dsaIKlyRvqQgzv75GGv1a4NAYbT7cvEFQ/NQ2lDPM1ToWlO
         WCKgIn+SN1FjS33it9KjIjdWjrSz7qwYIBq+QV9l1R6MNIN6ud4kDq/83rRgpYGe33qR
         fx1A==
X-Gm-Message-State: ACgBeo1wJmXQ0Cw3c5j7cwh85Xe8dOVCKqpe6vqPo1DsjGVXRYS08rXi
        fV41p5bquIlsakFHuMVV9Dh0Vw2wduU83w==
X-Google-Smtp-Source: AA6agR6cRtlk5MBW9Bo1jHvWWebvofHWBkmIjNaKbpizSkHJ0ByFzt3xf5Dce2jbiBIJLrXksS0b2A==
X-Received: by 2002:a63:491c:0:b0:42b:4321:a492 with SMTP id w28-20020a63491c000000b0042b4321a492mr11172817pga.160.1661719251984;
        Sun, 28 Aug 2022 13:40:51 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id c18-20020a621c12000000b005381f50d1e8sm1531921pfc.115.2022.08.28.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:40:51 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/base/auxiliary: check return value of strrchr()
Date:   Sun, 28 Aug 2022 13:40:40 -0700
Message-Id: <20220828204040.1953493-1-floridsleeves@gmail.com>
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

From: lily <floridsleeves@gmail.com>

The return value of strrchr() could be NULL, which will cause invalid
offset in (int)(p - name). So we check it here.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/base/auxiliary.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 8c5e65930617..7ac23be47e1f 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -191,7 +191,8 @@ static int auxiliary_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	name = dev_name(dev);
 	p = strrchr(name, '.');
-
+	if (!p)
+		return -EINVAL;
 	return add_uevent_var(env, "MODALIAS=%s%.*s", AUXILIARY_MODULE_PREFIX,
 			      (int)(p - name), name);
 }
-- 
2.25.1

