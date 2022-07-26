Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7903E581815
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiGZRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:08:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3D1B799
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:07:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h9so21076858wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYJZAGYDWBMT6g6cijNnHNizMWzKxFhdHEezep+ZyM8=;
        b=JFg1dFPc3aCGDcZqQP/YmQ+ORnEAFxNTUqKD4xP2JSkkRiCAG7wPPGNJAY9a7T0Bi5
         lbT/nHrUl9oxPbeYHYpArtD2weheB51Uynj4CrewODHCh4i/2Fn9ytSZ23BEYUXqy6qn
         eg0vfOgO/RE5D7Usial/oeuuleip50PkC49Ec6N0l9dz2uDVhG/aVF4Qfz18lKfssm2v
         A2VLmR9zMqkYfvbi0YSM9GkRvjtywJXAMiKfL+GlhwZJ4qbs7Op8Vhk7m/gZNPpSoOaa
         F3XPF71x+fEpaw/A9zR/1beKiAGNW5WzymfAnnemm878U3duUOjbYW1EGVmaefthEAes
         diiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYJZAGYDWBMT6g6cijNnHNizMWzKxFhdHEezep+ZyM8=;
        b=pWUpoAl1o83rJrSt5+S+/uqv7HZdSamUcddlOJkviJN0HvKlddC6YJxZAiN9XnzQX6
         9A3LYZSDNZGRRdQCK5L9zqBj5ONSVWxsy79KJG1mrEclaFwUJa67Y3Pe9HUn0wXguyDY
         Gxzs8CSK2ZC97NrOLNQ0OPd14EObmrn5MeIJvTetIb6N3hSaIKQEnICNs0qC9FmlQhsz
         1boBXQ7NfRfW5kIXdhYYWNLyl4QraaTRR3ZH/YTEoScMOWDTDT5r2/KjeIronXk7J5uO
         wnalRhhEpMTJ8pZ9BagqkmvqAy60sKbNHYdDhXSXMH0f9ds1T33sOZxrlvkUKPrJ19PS
         ZsfQ==
X-Gm-Message-State: AJIora9vlYbPl1JVSifH9sOBUgO9jH+2x9leoXqwQBpWwRmPLFOoUUDQ
        PcHEHoZgeJVs95K+vfXSz7+Lnw==
X-Google-Smtp-Source: AGRyM1s6BYK8WW9ORA/vI2Ql3Ij0kc9HdxUUm/7aljKXohKq8ulI7JwqqnPKXbr0u5sk9KEbkVlC7A==
X-Received: by 2002:a5d:5986:0:b0:21e:811c:f688 with SMTP id n6-20020a5d5986000000b0021e811cf688mr8824688wri.8.1658855278124;
        Tue, 26 Jul 2022 10:07:58 -0700 (PDT)
Received: from henark71.. ([109.76.124.168])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm14859618wrv.94.2022.07.26.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:07:57 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Date:   Tue, 26 Jul 2022 18:07:25 +0100
Message-Id: <20220726170725.3245278-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726170725.3245278-1-mail@conchuod.ie>
References: <20220726170725.3245278-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atul Khare <atulkhare@rivosinc.com>

Fixes Running device tree schema validation error messages like
'... cache-sets:0:0: 1024 was expected'.

The existing bindings had a single enumerated value of 1024, which
trips up the dt-schema checks. The ISA permits any arbitrary power
of two for the cache-sets value, but we decided to add the single
additional value of 2048 because we couldn't spot an obvious way
to express the constraint in the schema.

Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index e2d330bd4608..ab6043d9cdbe 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -46,7 +46,7 @@ properties:
     const: 2
 
   cache-sets:
-    const: 1024
+    enum: [1024, 2048]
 
   cache-size:
     const: 2097152
-- 
2.37.1

