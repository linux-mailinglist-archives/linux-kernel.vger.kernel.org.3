Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842B4FB8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbiDKJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbiDKJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:56:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A141984
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:53:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u18so6967091eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BhgOZc39QKLmHBUXm+e0SJMr8Scf5KRVK5HQ4X3qYVQ=;
        b=tym9lWOtYSwH5ja36H+aSBzsd4Zzlw+8bl+saKNIgT9jpYXxzk09aE8/UeczM5EV3t
         sz4LuUG5d6DHMI+oeiFA7eHdHFW1X0Iub4nqE1PohL45yjM+57h9rUxvbDALcdJF0Jrz
         4D4c63UVn0hsZ0UkDJA34woQHeRokh7rvXrIioOfzWnvWMV2RclezWSpxPkbPyIq8lf7
         nqdw4j3hzx6l6G/R2VTjSvFtZKSQjp55mkV9GmXZTMjJW2WkfxpWeBDGwzbTcGYeXugl
         sAFoAAAnWwvRW/PP0piUfG9jGJcIRg3ww/eaRZziHpqdTTAfJw+89CsUQL60d4qcKhY9
         Z6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BhgOZc39QKLmHBUXm+e0SJMr8Scf5KRVK5HQ4X3qYVQ=;
        b=bBRgRyL1um5JJJTcTW7lPD35FyI1L1SJDobFWOUPqkz3NRMHg4Ojz4bFbICZoKE6Hj
         fYHJmOA/J7cxjUT7nrzDK5Xm8nfZlrLk+hefDmupfEhnm3zcjVMAY0OI8lIHisx0NGPk
         bsiTwjnu7nTeCpPGgYhiSN0UBcqmen5IEzk898VCebBugT/kUCwHXBgyyisXEjkGzNIh
         +6ac/lzFNPYVLISOAP6ypjSAc+JGPF5qIjZPwzjyCvTva4hOTmtytFqssAUDFeMqa4yp
         wBqkL7GNIu57sPxxN4cvXtSD6M+duzdomB875TmyaKKUnFegTiNNT/33zKeE46AkAW+R
         9L5A==
X-Gm-Message-State: AOAM532CKuAdKPuggJ6+CH603EJ06TZXIcDwQuHkl/UaIG5/uz8nm6Oy
        UjLzb3hn6C2rWeOhXDx74Jei7XhKe2izjTKH
X-Google-Smtp-Source: ABdhPJx7uRDXMK69U1uBZ1ynJKqKcsr7pdHRVAJK9n+g1AwmPpC5evjXzVAkkb2NTi1lXqJ4T6V7AA==
X-Received: by 2002:a50:9fa2:0:b0:41c:d9c2:6b19 with SMTP id c31-20020a509fa2000000b0041cd9c26b19mr31934885edf.393.1649670800738;
        Mon, 11 Apr 2022 02:53:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gq5-20020a170906e24500b006e87644f2f7sm2457774ejb.38.2022.04.11.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 02:53:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: power: renesas,rcar-sysc: correct typo in path
Date:   Mon, 11 Apr 2022 11:53:17 +0200
Message-Id: <20220411095317.221317-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo '.' -> '/' in the path to headers.

Fixes: 981a34054038 ("dt-bindings: power: renesas,rcar-sysc: drop useless consumer example")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
index bd9608c83c3f..76c417990f12 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
@@ -14,7 +14,7 @@ description: |
   The R-Car (RZ/G) System Controller provides power management for the CPU
   cores and various coprocessors.
   The power domain IDs for consumers are defined in header files::
-  include.dt-bindings/power/r8*-sysc.h
+  include/dt-bindings/power/r8*-sysc.h
 
 properties:
   compatible:
-- 
2.32.0

