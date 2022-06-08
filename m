Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF9542B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiFHJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiFHJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC355224462;
        Wed,  8 Jun 2022 01:41:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so23139723pjl.4;
        Wed, 08 Jun 2022 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kCNBdcO4eoFOVjLRvT8Z2N/y1O53eJhJcKUq651+9sk=;
        b=bit2wIiyAJxn1s5PrPmVxVa8L9FFb163p3AmfXkmDPgZQYMURTcFenjrXsCY6NqSIk
         PuvsU+AvCWlaah1oVCI6b9yYDqT97QUVSyOR70IWJY/d13pMB/XZJvB76UP2u5QThVoY
         yBXPWMS26gx8it4G2E15Cd0h5p4svWGSkUmHsXsfdcnWC3q5d9LPuD0qSmHAUsKmoMIU
         yFyA/3sGyyWT6jzcGsluJRxxuZz/muWnFyNnhxCcWmr5jeOhaKqpURTed5MuU023P383
         RBl4eQveJrM4024P+PAcQFeOrVMQBOj9431ZkTk+gCxdDOA58rpSDyDzbrwK4/MzDPs+
         4dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCNBdcO4eoFOVjLRvT8Z2N/y1O53eJhJcKUq651+9sk=;
        b=Of9T1oW80zJUx33bI+k5wrdHzz910ZJ3lu22CO4SqGmGNb2Btm4KjVPqYBPFtedrL5
         nOMfdvebywfDmi9hRp7CtyG4JvhVI0XJgXlYjSsmfPnJ5inoDgzq5q0ArjnNPYNTiDyO
         Wj+xvYZRq8CxLbogU0LyKQaOhMUz11Li/baaOUTqtYpZe6mwLKZxLOZ+jQhoPL9Kud1J
         ixvSAZyaWNKZZLOKoRNVVhCJseVBAHsSzw8d3bLk+GCfScBfsrwnfKKKyxNlEkROMUHx
         fzyKLlnGFclvtjyT+kopc2l8OTahnxphyNcjhcBwt3SkCriVEeIatLI2+Z25hs/07cXJ
         jphA==
X-Gm-Message-State: AOAM533VUc3pe0nktG5FvcCuA2+C28GVgMW7TEelaNJc///0ry32HH6b
        1idOM9LiJAhRKEvX6rozv7/2t8wReG8X1g==
X-Google-Smtp-Source: ABdhPJwNcbYcVlZIhaeCGBxYyO+6ciZc90nZSC52cPCGgsTAQa8jbSACg9+m6+RlipHxUBy8lvwUXg==
X-Received: by 2002:a17:90a:4291:b0:1e2:92f3:20d1 with SMTP id p17-20020a17090a429100b001e292f320d1mr36261288pjg.163.1654677687268;
        Wed, 08 Jun 2022 01:41:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:837b:38ad:1ae9:1239:b178])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902f34400b0015e8d4eb263sm13902217ple.173.2022.06.08.01.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:41:25 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add the property to make backlight OCP level selectable
Date:   Wed,  8 Jun 2022 16:41:12 +0800
Message-Id: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
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

Since v2:
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

