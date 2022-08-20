Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7459B033
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiHTT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiHTT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239E6467
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7842258pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=2Na4L6Xa/1uu7YylwEePPP9ETbiBvw5nj60ibbWpCTE=;
        b=a9V3D9wuMS6prN8rUYdyUZX6fpGi+FRkPzO69Q6kw1t5OceyCRQOjt7w83h3VGAmMU
         HNf+u51EaPo+3fxT4DOrmkR0mBzmgo3NIeI5aknUXHTuBDnB7vYz7B/3eH8Hj0EUEqk3
         YLbFA73FKUkCz1zFlBsUDUN4rYSQX62cz5oNgyw8kVEjUoqLwfVN65rl6d2sAjVRRuCs
         DAN7wr3o7gY2qvSB/3L4ds6UwZrpjqvGxEPvUkBXcNJEIaJMEm475leelMAtcyvzMZj6
         BaXX6ayvqDm/jHvlUxLpr4hJnM05MBNhc6pY8diQ3gVnr0Aqfloz6S5dBSpKnOWz8eJA
         0ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=2Na4L6Xa/1uu7YylwEePPP9ETbiBvw5nj60ibbWpCTE=;
        b=oYNSzEpjP2PB6yhkAtgHrFyw4w1hlKVl8xJNmoMjS7K6WhF1emQbDjKw+B+8hI8n1T
         YZmw/C8T/MhypnAvUd78++pzgEAaaE5QieNjrEj2HntpVF5BWeuw1bLUWTCQxHEWFqdb
         xglC/0oQHWRE5OMq0jk8nfZaAwRUGoqM1qZP52XhGSBPl1azYjQHcM9kapt0bfCkkq6+
         r+4SvlIYDwq+qKjIfdRtLNARFZNHddxNt0AcK4zVgUoqRqrT6TwUnrGeWULdffGZR3Pd
         haVRc3Vfh3HkbEVSAhsyJ1Joh9B/2puLJnrBIoMxnyVogpRpT7r6gt1MPTMu/SkH1/0V
         70tw==
X-Gm-Message-State: ACgBeo2kaJsf5Rlln5t8NYn5a/cIOlfkRu0wKVGfkvTfTOGH5byEdomP
        Az29oqt0ZK7rKhpGhy3OR5cUcg==
X-Google-Smtp-Source: AA6agR4C0HSq6DXsMwBxsQEhmJfsvMKW08eFxzvRY/J5a6Zi96O/DvEWwAk5qv+nSumVeBUZwTfRBw==
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id o22-20020a17090a9f9600b001fab4fb6297mr14833546pjp.80.1661025505887;
        Sat, 20 Aug 2022 12:58:25 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:25 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 05/17] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Sat, 20 Aug 2022 12:57:38 -0700
Message-Id: <20220820195750.70861-6-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add the AMD Pensando Elba SoC system registers compatible.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c10f0b577268..b6ae68851752 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - hisilicon,dsa-subctrl
-- 
2.17.1

