Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82158065F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiGYVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiGYVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:22:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCBA20F5F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u5so17703399wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUeq44FpieZZf39MOcw6sGKQagUVcJcqFQ1h6qbHWHc=;
        b=QoaObyUa7vRdqP162PPe5wTqXmtOq9hn6hflF9KX4K1t0E1Ga6OSjrxeGdVsqm6Ejd
         3/Qlz2Ly9qpmLngY7LQuImeQdgJNhmKRi6L4phaSbaf/0+nrx0CsJvGWuRVbjpoiCc0E
         r6xn/YVNgDBwPZRApNILnnN3MwKpe2sg32YepDiaFWBYjfZV6O7yhCaR2aTrVJQ4q/1P
         U+w+02akDiacKh4CM+IA6DUPlUbH9A0GveJuUFRQvcjTn2Nr5O4jeLBGgRDiOVKF+leP
         NnHP8qTiLeNzCEwnFum4MtJI2eEDMoQgmgrxeE0hRKp+zjaANcQIC4MsRtRyr4CAxrZx
         vlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUeq44FpieZZf39MOcw6sGKQagUVcJcqFQ1h6qbHWHc=;
        b=wO5YnbWNSrVlFZzepCjqMOzp0iTWOav3Fsrg0vYhTqo8jUCk87DBzxKGGz6vGLhcQV
         dZ0SBt723iiZfatF4iU1pjh269VdauBoRTfKl8lfHRcW7bchXNZ1Yssg4k9I8b64eD1p
         pKoiIau7nxS1cW8RQEd2ntlQYn004Tqy6y7Nlp+44s5fAflv+O79CvQny6GPiDkVZkw/
         5O6N20Bvrzp10OHAuP4JA/3UqeqSK8g37v9pCsMI2bHstcATh1SvZ7WBEgaAoRYUMFLq
         8qLGCx+j0B7XQMIccdTPpN1T/Gn1V9YEGvotPa2YBb3Hs1JxSdmZnlzWWvXMQManoC3O
         Gv6A==
X-Gm-Message-State: AJIora+aMk7eTBDIWEeW2iRP/S5O1kiSYmuRw7hrOoFqJe/GjpkMqv7n
        MzUEDHV23B/lMHO0uvt6q+ggEQ==
X-Google-Smtp-Source: AGRyM1u+jEYf7OjdadzD6OQaGE/LY1uO7V4UgXV1VqkgSHsKp0YdSy+fphLFKub6vhTkDajBV/jmVA==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr8742953wrz.690.1658784126607;
        Mon, 25 Jul 2022 14:22:06 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:06 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 2/9] dt-bindings: pwm: snps,pwm add pwm number
Date:   Mon, 25 Jul 2022 22:21:33 +0100
Message-Id: <20220725212140.741644-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add snps,pwm-number property to indicate if the block does not have
all 8 of the PWM blocks.

Not sure if this should be a general PWM property consider optional
for all PWM types, so have added a specific one here (there is only
one other controller with a property for PWM count at the moment)

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 Documentation/devicetree/bindings/pwm/snps,pwm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
index 594085e5e26f..e95f518b3974 100644
--- a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
@@ -30,11 +30,16 @@ properties:
       - const: bus
       - const: timer
 
+  snps,pwm-number:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the number of PWM devices
+
 required:
   - "#pwm-cells"
   - compatible
   - reg
   - clocks
   - clock-names
+  - snps,pwm-number
 
 additionalProperties: false
-- 
2.35.1

