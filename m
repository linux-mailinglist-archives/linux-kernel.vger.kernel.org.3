Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDAF5A78DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiHaIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiHaITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:19:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE306C8889;
        Wed, 31 Aug 2022 01:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1A09B81F15;
        Wed, 31 Aug 2022 08:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD68C433D6;
        Wed, 31 Aug 2022 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661933882;
        bh=xyFTl9ErRj77KZSCzkjC/ob/fuCmtgD6a+3LQbWto7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ay5bfd7LGGe8NQPLlBqSLhJ/QcXkrb9ovh2q2UjSlrlkbG9p0oWIijI+BdlmxbZ6i
         vvfvgsFre8UzMPBcjiYKmbdoRpV9D4PWIPLicSS6dhxh0hEeu2jLbFSTcWA/Cl7m3K
         5Hez9Bb1F9pRgOAsx4YTt6EoJf/2w2WiwN9VZ3bhG4uN7exzRG7vmWkxCy0mkqFGXh
         eDiHpnO593CMMbHkQ39txUpdLcO1URUBYnQg6ws4zFQabukw8NQvERJZu+NwWqHM0M
         vPzHHP2r84QepfGuxT0Dz+fpKfgL6ZWBpfCYhfUg4Hr3CpkHDmv+pbSQK/cFqSDlgp
         G0CDEv2SIt93Q==
Received: by pali.im (Postfix)
        id B89B7855; Wed, 31 Aug 2022 10:17:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Wed, 31 Aug 2022 10:17:13 +0200
Message-Id: <20220831081715.14673-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220820102925.29476-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
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
of reset device. Prior this change priority level was hardcoded to 192 and
not possible to specify or change. Specifying other value is needed for
some boards. Default level when not specified stays at 192 as before.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v3:
* Add explanation into commit message

Changes in v2:
* Change sint32 to int32
* Add default
---
 .../devicetree/bindings/power/reset/syscon-reboot.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index da2509724812..4c8b0d0a0111 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -42,6 +42,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The reset value written to the reboot register (32 bit access).
 
+  priority:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: Priority level of this syscon reset device.
+    default: 192
+
 required:
   - compatible
   - offset
-- 
2.20.1

