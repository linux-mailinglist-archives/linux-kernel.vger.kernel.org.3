Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573F7552FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbiFUKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFUKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:36:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DC28E0B;
        Tue, 21 Jun 2022 03:36:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s37so12697239pfg.11;
        Tue, 21 Jun 2022 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=690PLBVumykqHvXRfbpeTt397V+lvH2pXtqvwt2Ufc8=;
        b=c0QGurYJNRMK3UMxsy3QW0s8lheOT+3HBk7/aVmxeGnsDa/4Mz3PxfwyLx+/zLuwLq
         vEWLMtHeeBOGEr3g2bc3f2HRlLr6S1X7ar1WEI2rOAie0xwOF8iYhw6k5PKJDYEXFLtG
         tPrclTO4rFQuDCuTCTVh9d77q69eRMIM5AJRmZCvW7I5bxwOTYLhbtoPZEdwpeK69UCy
         BDhTpsmFMM+SdBSdHy59c/dR5JXABq/nQjkt5EIbtDd0oKuKaBUcutrRkhdbps9vYszw
         cytcf/3FxDj/wXwWYMHIT7EJ4zXoKNk2PpsgjzL3NJKgoY8c1c+K9q3/24+nzRLHtOo9
         TvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=690PLBVumykqHvXRfbpeTt397V+lvH2pXtqvwt2Ufc8=;
        b=Y+2J9ObzcP4eeivpUVPjZTH7Mo8MTlekOWGBHlTeK/0TRShw3sARKZ/JduVz1VgF8z
         utooLIdfPYQRjmjTOSXlNN95wRxzyhjVWZPmW0cY7DY5atOhufGW4Ez/fLSgOfblUZBZ
         3l6MGyjwizTqmJvAcZb4dxlYLMb+MOkGjVAvB0wc+Uq9X3KjOUX5J6HCp1vJBJfmw+UZ
         XnOloDKZTORhAaJeZ2O3Ul8WhWhynQR0rpUBh04YhHyQQskMFW2fB1jxJfqv4EqkToJw
         Jy7EXPWqnqROsMpznrHkXKUlLwsbYugneSdNnzfJOPfBPp8i+06aVpiuXUIR4XGLjzAh
         LIBQ==
X-Gm-Message-State: AJIora+j7MTtyPViKK1hriDblvwxDRsT6QiOrMcPyFyrr90zXoDW+osR
        peelrMjQOC+IrBKY5VWLwEM=
X-Google-Smtp-Source: AGRyM1vor8LKN4/OSFgCvaMisJ2B3ZIyyYU/vXq4D6EHLN4tE9ZukH3WdJP7Ym20T5kb80NVeEkYhg==
X-Received: by 2002:a05:6a00:13a5:b0:525:1da8:4af4 with SMTP id t37-20020a056a0013a500b005251da84af4mr12372757pfg.43.1655807796742;
        Tue, 21 Jun 2022 03:36:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:c428:5499:b787:9:3bde])
        by smtp.gmail.com with ESMTPSA id o188-20020a625ac5000000b0050dc762819bsm36295pfb.117.2022.06.21.03.36.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 03:36:36 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add the property to make backlight OCP level selectable
Date:   Tue, 21 Jun 2022 18:36:26 +0800
Message-Id: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
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

Since  v4
- Fix wrong macro usage, must be 'DIV_ROUND_UP', not 'roundup'

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

