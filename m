Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02327570A17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiGKSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiGKSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:44:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4323176
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:44:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so2007500wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2JL5BeTsm1LVU5sfoBIObfRgPh6LElCg+G5xm4swvo=;
        b=H0r3Hxp2neTDv5jPln/vTpOMlYqL6h/423r3IpRFomDRFVkT+5eMLk9RHOKG1n2NHh
         n23b0BXFwzHNaAr/yy3KGnEWhtevU42TfeXI/1MalTCyz7xTQ0DE9+nimMV+v+Q5wdDm
         Kt0DC6Ng+8+c/9wH9JqSYjETUO6ZbSeUpiIFk3pBHRiMoF82muWlxGs/4Tc3jILmjNUZ
         I4jB1JqUP1wvZuMG8sA9zOSCJgVCYlhhwDwU+WWfuIIvgGLPs8O58NLgjI77PbOpxJY4
         tFML/qQM775/o5yBW9O5qhLhq3IsWJfTDzpvC8qJbSngIzi0CZEYxtjmKuaoDskJ1b1h
         IR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2JL5BeTsm1LVU5sfoBIObfRgPh6LElCg+G5xm4swvo=;
        b=wgyOho56S7E0mBARD4kD1E+/SJnBBSX3S7PEqQ0j3beQ0JvhoWeuJ2ID6VdF4QXoVw
         e9P2ErZ2iT3lEPzFBg0qcrpF+GCRgce44SnbPsJD5+Hdsi4iUAVCe7PtuaVhPWegnUw8
         J+PNKLbgl8QimdZyYsrxZlhXBmA0brFb0U/fLIEl3D+nem1hzsxgb2r7QKCkp8/PmJBr
         nbbQ0y8TzvTXDFuY0Zeq7W2hTPJqv0JcvqDb+3oQHEnaMBQIbXPQHhqkYJeetMWAv/Hg
         nv2Hqpa0OhfP9OAAdiwkCKHEfofqvs1H3EKG8+r4Lt0GEIpOaQUxJfiucslVuiFuOLvO
         o2ow==
X-Gm-Message-State: AJIora/D4tWMa+fLBKBsGA1ewAEd09j4FYmjfn57XjD4SEi9PxSUta+o
        o4xh4T3q5wv8GTR1706KjQzk6w==
X-Google-Smtp-Source: AGRyM1uuUcWNsE8syVVPrFhzpMcpyLLcS0n5o2c6m4kE2QklAam0XRkF04EnT7f7dj1PLfBVVaxsmA==
X-Received: by 2002:a5d:5a1a:0:b0:21d:68ce:bc88 with SMTP id bq26-20020a5d5a1a000000b0021d68cebc88mr17745842wrb.527.1657565049608;
        Mon, 11 Jul 2022 11:44:09 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c410900b003a02cbf862esm7330892wmi.13.2022.07.11.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:44:09 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: riscv: document the sifive e24
Date:   Mon, 11 Jul 2022 19:43:25 +0100
Message-Id: <20220711184325.1367393-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711184325.1367393-1-mail@conchuod.ie>
References: <20220711184325.1367393-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

The SiFive E24 is a 32 bit monitor core present on the JH7100.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d632ac76532e..195e762094a8 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -29,6 +29,7 @@ properties:
           - enum:
               - sifive,rocket0
               - sifive,bullet0
+              - sifive,e24
               - sifive,e5
               - sifive,e7
               - sifive,e71
@@ -75,6 +76,7 @@ properties:
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
     enum:
+      - rv32imafc
       - rv64imac
       - rv64imafdc
 
-- 
2.37.0

