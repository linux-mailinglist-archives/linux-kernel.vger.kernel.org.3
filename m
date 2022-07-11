Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3856D3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGKEaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGKEaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:30:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20418E3A;
        Sun, 10 Jul 2022 21:30:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a9so6815246ejf.6;
        Sun, 10 Jul 2022 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi53u4QJgosCISnTmcyYiG9I9s/LhFX3/A6st//BwUM=;
        b=Hd55IR61uvW2yTondhIt00vpk9E5U8B+C/utJoAupC7aIVwBiC7pAfSfxjlP69HlVf
         I1BJfhC5TyMSkhHlKm843yxrBVePP/9I/yoM4WQbkxAAtduvvOBUZWbYxezVbdhBN/A5
         yA4Za8Uid9NBZXuudDSvgmQgTvV0G1f0/ralZYpK3kOXdsyCnzhh+h2PSAPXj0px2b4h
         raz1bIHbnL89lX/3jpX96yf5esgDt+ohllt3rgvqItOpWZXOdPKnhr1GyVDCEXIXh36P
         Sus3XA2j1PIH/POGVvqtc6WTkynYteu1zzcA9HdtMftFgOC9MAphnEWyKN+k/ZbFAqbH
         bhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi53u4QJgosCISnTmcyYiG9I9s/LhFX3/A6st//BwUM=;
        b=lzTMnzvnD234ZSdverwU4ltgdiqDyqkWniTF1oZBqgD5bMHLsc7CfFVcKJ8NIYKscT
         YwLCr+QgbL+JExLIFpumuA2mzzw8uSv55qEvSJoNUOTvJKUGtD8rRc/6a/UrqZfjbfWJ
         K02lofA2uUU4s4bTeRcFVCVKhSeKMJ6ON2lAzdq0Q640fK2hQmz9UIGcctkNlG6NIsRG
         O/BH50k0/SQLBZL2j0Q14fqk6eSjg/4hOu9H6dePYfho7TKfFrSw5SL19C6q4K6MrWIZ
         RufyOKT92ZFf70BX+I4VgSpHpLaOyYRpJGFcemspNN4z30xElipSw0x3tMo+7iyKJiC7
         U8zA==
X-Gm-Message-State: AJIora/R0kq6bYmSwaUNf1tONomxuxxsxVb8sD4XUzTwNnNJQ43zRIQh
        vXY9lAJ1AIXV5Bm43oVI2Uk=
X-Google-Smtp-Source: AGRyM1u5ok/VBonTP+OnfW26t7V5NT0deUGsauIvg2tLk5Lm3cqcvEcU3/9UoIiQdJ31AK80gQo3Bg==
X-Received: by 2002:a17:907:75c6:b0:72b:496c:77c7 with SMTP id jl6-20020a17090775c600b0072b496c77c7mr6465141ejc.47.1657513801672;
        Sun, 10 Jul 2022 21:30:01 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00726298147b1sm2203100ejg.161.2022.07.10.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:30:01 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] media: dt-bindings: ak7375: Add supplies
Date:   Mon, 11 Jul 2022 08:28:38 +0400
Message-Id: <20220711042838.213351-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711042838.213351-1-y.oudjana@protonmail.com>
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add supply properties to describe regulators needed to power
the AK7375 VCM.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/media/i2c/ak7375.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/ak7375.yaml
index 4fc216846ae7..baa91de55927 100644
--- a/Documentation/devicetree/bindings/media/i2c/ak7375.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ak7375.yaml
@@ -20,9 +20,17 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: VDD supply
+
+  vio-supply:
+    description: I/O pull-up supply
+
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vio-supply
 
 additionalProperties: false
 
@@ -35,6 +43,9 @@ examples:
         ak7375: camera-lens@c {
             compatible = "asahi-kasei,ak7375";
             reg = <0x0c>;
+
+            vdd-supply = <&vreg_l23a_2p8>;
+            vio-supply = <&vreg_lvs1a_1p8>;
         };
     };
 
-- 
2.37.0

