Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31EF544166
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiFICWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiFICWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:22:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894EB7E1E8;
        Wed,  8 Jun 2022 19:22:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e9so9659994pju.5;
        Wed, 08 Jun 2022 19:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nlEuBg8v8joAJ3nTxPPVFu0RND3GlqjDdGfi1BUzhm0=;
        b=LJmcIVVXNarxPUfq0rfH//BBnhbaZH2jWI5amnGOcwkJlP1CDETkYnGDqkPXyT/in6
         2R20GDuhfi8Mvdwzz/hVIxd+d5XD7TGO6dj8Y1h9E+BM12XA8MrixiYcQqXnpNcTUd2C
         FWU3Lqh+X+AVFPQbIWm3ZjXreXQSeYJ3RIEMusGp+vnyzWUGKsceywjN41TQVOpR/SUl
         6bjLPZBCbRPwf1r16aRxZIom5ou8bPWuS6EhOjjf3nSC4O5GYNkITndO3zrplEs8Ls6E
         6JDT2CHliZ3u9Icgoun8uP2dXicUoVK2+kqynUrP60LjwCFUc/LmZknTkv0kkAAwEPCA
         u6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nlEuBg8v8joAJ3nTxPPVFu0RND3GlqjDdGfi1BUzhm0=;
        b=pQAP95J2aXl2ecqUFWNUb5tq1aBJ9RMvI8hpzDfOvmYCxrV0VA//toh26NCQs67mOO
         35qM6wqYsXRCU0Vn//rb/iHLEszXL0QVVBpO1jiM8MuC/D/DvxD/CvwjjmuQjFutozRX
         c7KVhRLKmRaE9u7BsQtA7uWkZBchOErU+Gz+bkf19FbeM31rBFbUex33/5cyxDhX1IQe
         z85o6KPEcSGf5+eZuHeFvw82s2RLxTIaGZ/vTHvQlNiQgY3aw5WagNhFy4zGKMKmmuyE
         TT2McD9ncosJnxtrak8/mvcVWu2+iFRHkUqyvTIrloAR+EsF+b5Bk63j4eaj3u1OZ891
         87xw==
X-Gm-Message-State: AOAM532+MNKbnbViWLdUaxdSsXY5V9/TXXrpgwYdgo3uURPm9IbA4H1O
        K+QPcmVU9zhvnkGLclQfxVY=
X-Google-Smtp-Source: ABdhPJw00++Rt/yaahJuwvadiTVVY1cXYdUGG5axxtj0mdJqipLC/NYfxJoE1poR3gWa5OtWiVnM0w==
X-Received: by 2002:a17:90b:4c8f:b0:1e6:9bf9:1ab8 with SMTP id my15-20020a17090b4c8f00b001e69bf91ab8mr986765pjb.215.1654741350991;
        Wed, 08 Jun 2022 19:22:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:478:d041:804b:4db9:72:b011])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78056000000b005183f333721sm15748770pfm.87.2022.06.08.19.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 19:22:28 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add the property to make backlight OCP level selectable
Date:   Thu,  9 Jun 2022 10:22:17 +0800
Message-Id: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
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

This patch series is to add the backlight ocp level property parsing.

Since  v3
- Refine the description for backlight ocp property.
- Use the enum to list the supported value.

Since v2
- change the property name from the register style 'richtek,bled-ocp-cel' to
  'richtek,bled-ocp-microamp'.
- Use the clamp and roundup to get the ovp level selector.

ChiYuan Huang (2):
  dt-bindings: backlight: rt4831: Add the new ocp level property
  backlight: rt4831: Apply ocp level from devicetree

 .../leds/backlight/richtek,rt4831-backlight.yaml   |  5 ++++
 drivers/video/backlight/rt4831-backlight.c         | 33 +++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.7.4

