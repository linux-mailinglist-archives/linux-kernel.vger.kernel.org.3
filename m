Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2259AD38
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiHTKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbiHTKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:30:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD68A571F;
        Sat, 20 Aug 2022 03:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4695CE0187;
        Sat, 20 Aug 2022 10:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF3FC433D6;
        Sat, 20 Aug 2022 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660991415;
        bh=5Sem2MQf+IZyyC+DHcRKkeVWonfrn1+/FxE8deI3vSk=;
        h=From:To:Cc:Subject:Date:From;
        b=hKibc8kvdqgNmlTp9kiYFyYjoqFM+L8jEsJGJhvwqG7vrMIgI2qL/0S5yuxYUd6EW
         Q8dlCXC92YU9ZTtV33FrCbLqdJfUUuZzcIPCCArWCoKFSUB1qIEvOlulG5GUIKvTOA
         bCy/VhB83GoZzO+0EKAxElV7S8elnVqa9CiTuIE+Uo30kA6MYUoXRVZOz42SS+os0S
         cJKWKxorl62ZSjJjotc5hVfZae89Lwh6fL/ZdzUsUQgjTHZ4jthSKSHlWeTXhwUZAN
         pYRYJMmX/fX+RWcfG2ImisOxzxun6kTMcGDZC457RaYqe4s1jtiaSeFbKn6Jr162t7
         fkL9QeItCIDkw==
Received: by pali.im (Postfix)
        id C7E995D0; Sat, 20 Aug 2022 12:30:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Sat, 20 Aug 2022 12:29:23 +0200
Message-Id: <20220820102925.29476-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new optional priority property allows to specify custom priority level
of reset device. Default level was always 192.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../devicetree/bindings/power/reset/syscon-reboot.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index da2509724812..d905133aab27 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -42,6 +42,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The reset value written to the reboot register (32 bit access).
 
+  priority:
+    $ref: /schemas/types.yaml#/definitions/sint32
+    description: Priority level of this syscon reset device. Default 192.
+
 required:
   - compatible
   - offset
-- 
2.20.1

