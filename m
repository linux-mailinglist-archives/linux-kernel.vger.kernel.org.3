Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891DD59AC2B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbiHTHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiHTHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:18:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608D6406;
        Sat, 20 Aug 2022 00:18:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k14so6137354pfh.0;
        Sat, 20 Aug 2022 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1zjTqUm4luCpgc05ENQ2GjoJH4VkCDObkjj2YRmbGQQ=;
        b=VU7DtQSsgB1zcrbxExarNoM/FM3oHXXC4E0gQvlVLBnzJU+FTDhawOTl+6Zc9crRbf
         +xHKDW0N2oPEouDXOJuEszJ1QD9Qqj+Q65IpkD+p8pRarBdph7EtdDxMEtYzBzQGhdJF
         94uRBci2yh/52XwIn6FYouKGDDj0L6c3MuC/jj7ruTsTijs4eq/cq+8PyPtJkvc6UCQb
         WALgMDr98U1gLCCwdWyZzjfwOQwmS4vWasROxU37cckCRohZQTYos7eFFw9+PuYnVTq9
         jfIxY5hqptbYCRHbk32h0Enbx8joXy0/Ufk73ifhc3UU6tP2gfhldSWTyMfh6nFqXKHa
         WXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1zjTqUm4luCpgc05ENQ2GjoJH4VkCDObkjj2YRmbGQQ=;
        b=cSdWd8Djjk8mjzZbv7La0uosalETnw4P9V7Gs7Jt9PYDCYK5FbRBxz9P/pIS5myllg
         K8APRbL52HABGeXx82cwEBw7KFJoK5vr2z9JXWwSvmVDjPXlYmEQYqlrieJl980u4PAk
         2+wnxZlMcVs6blE6xEJt9X8XWS8SXZvaTi9Vl3Hh3CR7Jmwh/VPok6DA4g62dntkbm6W
         Y5bbDCgBWJoIYXMNJyp7ZgT9CNZqQsK7bmF7OdnhYqba6K8lW35OqU9TFdReGvpluX/E
         LVWKEafqbO5hJg6AYRu94N/YYDTL4yQGgtR5H/tPsRrgYafTPTyylrP4Hk7T7HwhGJps
         pzaw==
X-Gm-Message-State: ACgBeo3vRws9HEBXratRBSA+LalU9kBTcPr77TLEXNSo3By3WyamhgsI
        cVJnS95JQatcjmWBM5suA0WfpuUnwytyjZHqOPM=
X-Google-Smtp-Source: AA6agR7Tn8tFdRxFz7954cWIplbnFqO0dmoiLoIt/8ZECUKL/T9JmOM+42WDNvNUvk4PSItxpF8exg==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr11227240pfh.35.1660979892605;
        Sat, 20 Aug 2022 00:18:12 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:18:12 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 09/10] dt-bindings: input: Rename twl4030-pwrbutton to twl-pwrbutton
Date:   Sat, 20 Aug 2022 12:46:59 +0530
Message-Id: <20220820071659.1215-10-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the Documentation of the twl4030-pwrbutton to
make it more generic as it can support other chips than
twl4030 as well.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../input/{twl4030-pwrbutton.txt => twl-pwrbutton.txt}        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/input/{twl4030-pwrbutton.txt => twl-pwrbutton.txt} (81%)

diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
similarity index 81%
rename from Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
rename to Documentation/devicetree/bindings/input/twl-pwrbutton.txt
index 9a0b765d3..43addc04d 100644
--- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
@@ -1,6 +1,6 @@
-Texas Instruments TWL family (twl4030) pwrbutton module
+Texas Instruments TWL family pwrbutton module
 
-This module is part of the TWL4030. For more details about the whole
+This module is part of a TWL chip. For more details about the whole
 chip see Documentation/devicetree/bindings/mfd/twl-family.txt.
 
 This module provides a simple power button event via an Interrupt.
-- 
2.25.1

