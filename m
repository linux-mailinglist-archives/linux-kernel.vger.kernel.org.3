Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8058C631
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiHHKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbiHHKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:16:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B7FD2E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:16:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x25so9293162ljm.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X5+OY9C1JUS8+hnV0IE5pgrose61H6CK2ZponbGyzQ=;
        b=EyfrmTnrDXlotODXx82gzFKRsGHHudSI5dBZz7dEPF+vwq5g/VpTEuVygENJLc9MYg
         jkSzsUqmuwtDhKuwCelC1wSm+xTxwXILTvPepVU6oZGefnUrElS8baaEtmnDnDQelyth
         kjoaoE4KmDDWxs28HadN8/MTqZUymyqjEe5+pzFlwYiog9sjBbIXIB3cKPIl+9fXoQvR
         3oyL9iT6JED3JMHn+WN9TMBRDonmkG8Jz6/HxVrmDIpNQMZIAeHoH7AYU8UPAQE2A15b
         0bH5uQiYftr4gt5wYQdr4Czjg73qkzDl/cmud2Ei+QHhZv5KxwRk0brHHV875fnsp3qk
         DQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X5+OY9C1JUS8+hnV0IE5pgrose61H6CK2ZponbGyzQ=;
        b=UyftzAGxALFsG76gswpo6FX6DZHwbvXZzRn4QLU1hqsTCPMbs7PauX9xN02gBCWYUn
         xUc9J0499uYG43K6t9lPScrzI57YgDbzMg4n0gSWIS7tzi9qpt+VhSQ/leHbHth3VvVf
         H9ErNwussiWgI8weg+pqrDl5Ye6R2L41ds5cQ0sfhI8KQJxmEKUKitxUbjARvIrJ0Kkg
         S1rNKwmMenv0xfZFZVia8OdFhDlCr/zjxRclgDLqz452OpDs9bXh861V0tgQucXDj6co
         0MDkWddCMovMXtykoKVdB0oNL3ulP/FVDY249sLENujnzBopMlnb2UZ05+7jLewW1kbP
         WhGw==
X-Gm-Message-State: ACgBeo1JBg29FNnJmroR5zEIljx8sUnjZKSjV0GXUbEBJ0pCTe1SdMgd
        Udm5pWFUX3ZenZ25KcWnF5eqdw==
X-Google-Smtp-Source: AA6agR4tttRe6G0iEjjBNa15w2EGKbZLas/+/O7VoRN7jyC3KSWWrfglGpmZ0iCybcN82fFC9txRag==
X-Received: by 2002:a2e:9e17:0:b0:25d:78d8:407f with SMTP id e23-20020a2e9e17000000b0025d78d8407fmr5948114ljk.433.1659953782159;
        Mon, 08 Aug 2022 03:16:22 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] dt-bindings: display: simple-framebuffer: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:26 +0300
Message-Id: <20220808101526.46556-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
References: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej's Samsung email address is not working since around last
year and there was no follow up patch take over of the drivers, so drop
the email from maintainers.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume that if other change was preferred, there was quite enough of
time to send a patch for this. :)
---
 .../devicetree/bindings/display/simple-framebuffer.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 27ba4323d221..1f905d85dd9c 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Simple Framebuffer Device Tree Bindings
 
 maintainers:
-  - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
   - Hans de Goede <hdegoede@redhat.com>
 
 description: |+
-- 
2.34.1

