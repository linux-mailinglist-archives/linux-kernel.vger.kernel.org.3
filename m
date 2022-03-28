Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E14E8BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiC1CN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiC1CNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:13:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9A4F440
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:12:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z128so11108006pgz.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=785BQAgQ/fmXmnK7LN9iPs9KhRHeXeAbtde080rNxiU=;
        b=at4e3yxgx2xDwFHe6ilij5ANvI+EBic1G+1lp3r9Qs2kHPOKb4f/C4U6fyF5mFaH6n
         2ad+n3zjlC9dS+OkzGDJc2Ou0f5vs5uvKK/ExojsgVvf6kpTZGSm0u14n8TEPdEAIL2r
         7mgCXT5dIQfSGQuumy05SWABdMOBhZG/rjt463qSXXWjDccUIU3oBpvEKu9kmthxUUhw
         ByOI5yaMeBwa/C4oKIs5KExpEE580tEh+Ax2EHfEEHQlXm7Vx/E2zKPi57GeFv1oQ5vE
         C39TJqvyYvN43dtgIRHBkaG2/IGw70bj6soTSd/dGk1S2rLjIm8tnjVey14Yel1cRecE
         mvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=785BQAgQ/fmXmnK7LN9iPs9KhRHeXeAbtde080rNxiU=;
        b=xm1fkRI/CwvPp+KkfVAqTGjTMCaxrPA8c+JXsVO8qOB/dmhdp5HJfiHfk4fUhq+u+n
         7KqYILRthdnMbY9KFN0nv/24ahceETQFh5pMS2mPPkDhV0LBH2fAftt4GEHiK7ytMI8S
         p8gBrht8aKuZEfK4BIu/mFD9V7y1299dSB7wN7bhB6Rr8l2RCFUFGwtP4upHGI0hkTW8
         icRjhPhFwIuvShAmaWKkm6SQ+iqVsligPkk1BD95BKFKP6zLZrWyHGZnSgA9btJ2KduO
         yDvLUDnjvLFEzzblc5JoqqFqbZxWng9LLJ6tDVPi1mte2UJre7ZMoSsCysMaWtskbAFG
         ncsw==
X-Gm-Message-State: AOAM532suwDpHyFXfwEHNOxOZpZHVKwuyYkLJYRGxiwNuvEsLEEjMmfb
        m+U6cbkQ8aYIxvbsHlpgV74yLHaLXlv0fg==
X-Google-Smtp-Source: ABdhPJz3Fmr4nLVOv9MmVn4Rx1d3jkYMkLMxoem6hmY+OZtwNuwPfgPq+/fccaY2ZxV7h8v2raIksA==
X-Received: by 2002:a63:5311:0:b0:373:9fdb:ce03 with SMTP id h17-20020a635311000000b003739fdbce03mr8679354pgb.518.1648433533205;
        Sun, 27 Mar 2022 19:12:13 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004fa9ee41b7bsm13322058pfb.217.2022.03.27.19.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 19:12:13 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, nuno.sa@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V3 2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
Date:   Mon, 28 Mar 2022 11:11:39 +0900
Message-Id: <20220328021139.8700-2-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328021139.8700-1-steve.lee.analog@gmail.com>
References: <20220328021139.8700-1-steve.lee.analog@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the reset gpio binding.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
index fea9a1b6619a..deaa6886c42f 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -29,6 +29,9 @@ properties:
     minimum: 1
     maximum: 8388607
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -37,6 +40,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -45,5 +49,6 @@ examples:
         reg = <0x38>;
         maxim,temperature_calib = <1024>;
         maxim,r0_calib = <100232>;
+        reset-gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
       };
     };
-- 
2.17.1

