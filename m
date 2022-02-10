Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C54B190F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345444AbiBJXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiBJXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:09:32 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646FC66;
        Thu, 10 Feb 2022 15:09:32 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o3so7144365qtm.12;
        Thu, 10 Feb 2022 15:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Il/njuSffEOrDW4E6Z5WwCggqy6XxgY6UGpPrL0AIR4=;
        b=JHJhNoUxh9ZuIiGYQov/FCIzAnjDxw6DqtVPkL1Zy1CLrsVwmf/L1YO0+GvOXbDRZ1
         pqP9mY9GzQYWTgjathqD6S833i3Jn5LhtxZir6zDdzPkcq0f+VaqtHxlBS6ulo5m01Uc
         5DJQwrfoKFPrAReQX/OlzhfusR6gY3jUDmZ2vXh/MK0XJxvb+JBDrj+24HC4sMqKBH2x
         kal6x+3q2ykI4/TCu98o6Mozggc8N7XorGZWzB7iKSz5i9wIizC8TdU+Cz+wzu1nNQay
         JFJ9W+P6+SkdtD9v9e2pIYBVGBN0oQwzdYpdb3O/UPoDayEfqa2+ziM7S0gFtv3xwP3k
         JINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Il/njuSffEOrDW4E6Z5WwCggqy6XxgY6UGpPrL0AIR4=;
        b=wij2CJmAo1Sp0oor3zOLtoYdXM4d3E+sJqga2rLIYQpwhx534e0hFSct8wQQrRaQhS
         NhPZkLGQEuHtXVV4ChYHwuJdD/euv+VwP9yyuFiIWk96GYs4wNdyPgLN0ynE2MpeDLoS
         HxH9UXgVAtiOks0S3JpR1+xKjmyO1giJT+WByxuxqZKsBRykOM1fDkuNPhCqpmGKecJv
         kwn/Tv3Qx7HGk5O8T70c7VaHeEF4q3rBVR23YkKUDazxCA5XxBRTZxIaYZ+Xu+8b8/nb
         0NdTEcCpH7JGBGcHjbDk4usEK1lqOpaKKSwAuSkv2P2r3Lw+AbQqTPQtnZdhmgvYjh7q
         Xb8w==
X-Gm-Message-State: AOAM531n4VugdfmWm5lXpAOD1/sDzuv0QK0YGPZbuWtZKmH17QvNqVyA
        C/IU3zPms1zPU9BBKi40vkc=
X-Google-Smtp-Source: ABdhPJyv7MT5wCGfdlfCLRk0wYTBM2q1x++ztUAm4XQN4J6MUGrqRSzzk5Brej8rnmEAO7fi58Ap6g==
X-Received: by 2002:a05:622a:1304:: with SMTP id v4mr6649618qtk.359.1644534571568;
        Thu, 10 Feb 2022 15:09:31 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id s6sm11824113qtw.18.2022.02.10.15.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:09:31 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 08/49] drm: replace bitmap_weight with bitmap_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:52 -0800
Message-Id: <20220210224933.379149-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

smp_request_block() in drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c calls
bitmap_weight() to check if any bit of a given bitmap is set. It's
better to use bitmap_empty() in that case because bitmap_empty() stops
traversing the bitmap as soon as it finds first set bit, while
bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index d7fa2c49e741..56a3063545ec 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -68,7 +68,7 @@ static int smp_request_block(struct mdp5_smp *smp,
 	uint8_t reserved;
 
 	/* we shouldn't be requesting blocks for an in-use client: */
-	WARN_ON(bitmap_weight(cs, cnt) > 0);
+	WARN_ON(!bitmap_empty(cs, cnt));
 
 	reserved = smp->reserved[cid];
 
-- 
2.32.0

