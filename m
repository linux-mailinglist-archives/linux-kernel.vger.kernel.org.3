Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC064C39D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiBXXmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiBXXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:42:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1CE13EA6;
        Thu, 24 Feb 2022 15:41:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so757472wmj.0;
        Thu, 24 Feb 2022 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6ewTQe3OK7iobMzAQ+kBl7N3pik28kzqkjBtU/uD7I=;
        b=I+Cr7zgqAT+H7lkk3no/19oCV6euhBjxueswiyfUC2r3FZQkeT6XwK3HFlsv81Y9S6
         avWoQTTJjExpiJCk1TjDmpt3VgeIw8eJa809Ia/rYv0rNwO0Qw57uuWFXftF4795sT0f
         RhQdN1t9M8vgI0pNZq6yMLveDHr/WLg4M2d+WNAM4PqmU1jp6h2HB/VS6Nmur7vBhApL
         FwSZNbcNTLua4re9Nfp2mlw6tOteqkz7ZNHBT808s05FIsASKU9tcnMXJ52lFGCQLONs
         X7DSQFAB99W4MH4RlOolclNfpWxSiUQe+q7dcI63UkwFhAHj6U3QOafAe+bekyiHCsLC
         omqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6ewTQe3OK7iobMzAQ+kBl7N3pik28kzqkjBtU/uD7I=;
        b=xANuttIIpYT1C0V7w5s3vssStOmUn5WSUPBKXABRxOGnb4E/mqqbjR+QtV5X5LOU/x
         7Ym9HCQReQ8lXuXEbXblfCHSaQW/ymMeasp726/dp74SIf9OV0nVl2H1BbzY/yulOZkY
         7/S9AXlZ/8YZkkIJRtJ/ZgL6AkzcKgvzNxfoF9fIYeDC6CPXmpCenKd8Pt8T502wTwRT
         ZUBabsSoMrVjdvZyDQAiDPHh2+jK4EtCGy+Sj7VjkeqkK0110vraV9DnVaNKqdhyUq2P
         80ixu2UIubDfLlsthXEDfmQJm8LMzULnTRJ6ExIJY2Dh0IQUwYg8LYPyvJUVT/p8tT3K
         SCYw==
X-Gm-Message-State: AOAM533OK3xX6GNOP9hcVMwqFa0pGcoQkYOyCuBMLxJPs2NlYMPYwF7H
        GWltnVvB2GE6CFoPbqC4W3g=
X-Google-Smtp-Source: ABdhPJwgxXztv6Qx6WHWUyrzMIKpTwcpHGBjSuM0fBqN7TflbUU7dsEbQGsDORRwHs3pwRUlSrmQNw==
X-Received: by 2002:a05:600c:b41:b0:37b:f88f:dea6 with SMTP id k1-20020a05600c0b4100b0037bf88fdea6mr338357wmr.3.1645746096851;
        Thu, 24 Feb 2022 15:41:36 -0800 (PST)
Received: from localhost (92.40.202.225.threembb.co.uk. [92.40.202.225])
        by smtp.gmail.com with ESMTPSA id a11-20020adffb8b000000b001e4b2617e5asm663422wrr.29.2022.02.24.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:41:36 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, thierry.reding@gmail.com
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: timer: Add PWM compatible for X1000 SoC
Date:   Thu, 24 Feb 2022 23:41:33 +0000
Message-Id: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM hardware on the X1000 SoC is almost identical to other
Ingenic SoCs, so it can be used with only minor driver changes.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
It seems Thierry picked up the driver patch separately (thanks for
that) so here's the DTS changes on their own. Would've uploaded a
v2 sooner but I was busy the past couple weeks and couldn't spend
any time on kernel stuff. I guess this isn't a v2 per se, but for
completeness:

v1: https://lore.kernel.org/linux-mips/20220209231141.20184-1-aidanmacdonald.0x0@gmail.com/

 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 7fb37eae9da7..d541cf2067bc 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -152,6 +152,7 @@ patternProperties:
           - enum:
               - ingenic,jz4740-pwm
               - ingenic,jz4725b-pwm
+              - ingenic,x1000-pwm
           - items:
               - enum:
                   - ingenic,jz4760-pwm
-- 
2.34.1

