Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E774B00FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiBIXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:11:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:11:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F229E00D0E1;
        Wed,  9 Feb 2022 15:11:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u18so8016874edt.6;
        Wed, 09 Feb 2022 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqzfmkNh5SdTGhwtfqhQO3tmrLYbeg43rOPOZKAzkHE=;
        b=PgTCnWJ3ZUZTNbfDOsNntOLGQrnCH7pkLtUQan5RM/J6wUxg7UqmMP1ojvHR/HS02X
         Qc8ucTboFVjfJrbrtlCwgcb9FCMTyp5E+gNVYA6Jiwu5oOHQXBcKuXohqfk2lQ1gReVv
         orIffH9trbyFykgGpDXJN324QuFAKLBsKinFb+9+AiCS1LxxxvA9SM7nTirbvPtJzcR+
         jmpPEU+NHFhTm3x0DOc/LT4dvSC0QVuFOcsTu0eQfHE4CjR8+ijb3zI5MP10MAHUHJg6
         IjBAqsQ99t4Lnmg0ylVy5UeeZrfq0a8Ps4M7FLQr4s8zc+z96gXAzttudvVJjbDi5T5F
         EjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqzfmkNh5SdTGhwtfqhQO3tmrLYbeg43rOPOZKAzkHE=;
        b=QnQhUkgw9lFuhqpX5Cz4+6urKmf46ncdUuj6MzpKyBC0+FaeR6LWG3N3mGq3xo0mEu
         LcisAql/T7qxrDMRi62k2OeB/GevZ549mvBG+RP7vDSw9wHgDaA8WLQzWCLVAbYzCK5a
         AiJfcKtmrAGFabSn0yw4nlUoDGijYMqzDHS6MVjfPZlNL213qS1FiobURmi3DA8EKjxQ
         ugxMJ29ugTD5HnaV+oo6yB+eERaPR0PJuQQptOaE9mT5JPN4nbZWRXRxvYgc4jj9/ZyC
         Vh4rvtQ86+hu+QKJKLrpZdA+qDJmDC2XnXsaorSbzeIxJ15RDK9uKVhWPEz9knb4S52o
         b7+Q==
X-Gm-Message-State: AOAM533QSNIpNO3ShGQlCwzoPRzmIGI66uwGcO5FBcSo1LIXF49CZbwh
        hQG3f/clsorBwdE2F30Mhw31qZ4BdeWJ5g==
X-Google-Smtp-Source: ABdhPJwSNp0qmBebgyh16OF4VOhO56NwwK5Hxoan+UJHH0AOxvcbPLEysUXAv0cpq7ktmXf4XRpR8w==
X-Received: by 2002:a05:6402:27d0:: with SMTP id c16mr5412714ede.276.1644448285958;
        Wed, 09 Feb 2022 15:11:25 -0800 (PST)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id qw28sm5268188ejb.0.2022.02.09.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:11:25 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: timer: Add PWM compatible for X1000 SoC
Date:   Wed,  9 Feb 2022 23:11:41 +0000
Message-Id: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
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

