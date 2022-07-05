Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E0567917
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiGEVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiGEVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:01:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528C63FC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:01:53 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25E4040AAA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657054910;
        bh=/+iqepEXJiQtf1kCLKBlcRYR4nyv6+zJPzgNc4qYD7Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=g4kb8ffXrChQNTrnBkWO9Mf/+fE85kbkiMknN2qIy7l95lrpHiMEyN/OWjhPtZNG7
         q5aIxyMdbpfXa161CRF0NbcSUMNyEiHrMkGZI/VTmNdZcuX+LYvUHSE2eFcA7NxAF7
         +Ep+EWR5jk2KZYS1a5Mml4ZIz7+d207zvz4Nn4doizvcowzLX7e0YdL8q6iT7aqGMR
         VTFvLnJCP5e9QiZ9tNEdW9kqOacSUdZEtZ5o8hB0jmJbFzT416BOyTvS6BVu2nfGQc
         e5ZWldI7/vpjEnIz2DrQ4yqIk1wj5qJzgcmJ4Zh9F23fiku9MxWCHuBkF4B8PspKo1
         yMe7BiFvRzHvQ==
Received: by mail-wm1-f69.google.com with SMTP id h125-20020a1c2183000000b003a0374f1eb8so9381177wmh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+iqepEXJiQtf1kCLKBlcRYR4nyv6+zJPzgNc4qYD7Q=;
        b=zxirtKzcT7JjxYz3X5c+aVOaUjvAtCptzFn6Cm8V9kv1tn8dTVczJvXnuLEK5r3wY/
         C6Z6TJvY0c2LvvQ0PcLV3HVuLJZ2n8f0SUskYBnjjU3ld0LAS7qjCxjeH/zHNGEeZXBx
         KeJqLteG9RshuytXOEAfMFtnVwaDbc83fLk8R8a2KqzhX3lUxr4t4cnkiUEgenwRDJUF
         vxDH39MB/pDfuCdj/A9WLx3KTKKHhWMu3swtGuiK2esJhbrGqLxHK1he7nOio/zYhiEU
         k+3mQQ9h3ChSV3xyswGWpYvVavgGdqvBYnVp2MZhRjD4Q3LNihNA+sQ3jKCgHj2DgpJ9
         T8RA==
X-Gm-Message-State: AJIora9MzKpa7OX8I+yyUFviPMS8v5LPvyVa1XrI5MW/jJU9wZ7mffTo
        CJlb9X39GeiXXp4uOpVXPKTWrmNTL9koRDaQjS0aykFHTgRm6pHTx3YuM7N+y1iLy6EQ7B8hS8I
        WWiGHlUTyV/5P+3VWffVK97WzW+LtwNvdW2ERbYBcEg==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id cl5-20020a5d5f05000000b0021b8ca06d3dmr33987905wrb.382.1657054907934;
        Tue, 05 Jul 2022 14:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1voNkjmJLsItk4qX2FcCqMMV0I2vwoygxRWgEn1u2iRJAbKSZJmuQVNG8KjvMDWpNkZS4aZLA==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id cl5-20020a5d5f05000000b0021b8ca06d3dmr33987869wrb.382.1657054907727;
        Tue, 05 Jul 2022 14:01:47 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm2517667wru.28.2022.07.05.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:01:47 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 2/4] dt-bindings: leds: pwm-multicolor: Add active-low property
Date:   Tue,  5 Jul 2022 23:01:41 +0200
Message-Id: <20220705210143.315151-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the active-low property to LEDs that are part of a multicolor LED
just like the regular PWM LEDs have.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../devicetree/bindings/leds/leds-pwm-multicolor.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index 6625a528f727..8d614eaf5c5e 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -33,6 +33,10 @@ properties:
 
           pwm-names: true
 
+          active-low:
+            description: For PWMs where the LED is wired to supply rather than ground.
+            type: boolean
+
           color: true
 
         required:
-- 
2.37.0

