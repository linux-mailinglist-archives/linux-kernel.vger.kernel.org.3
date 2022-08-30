Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5695A7143
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiH3XAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiH3XAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:00:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3594EC3;
        Tue, 30 Aug 2022 16:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EA7B81DFD;
        Tue, 30 Aug 2022 23:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC2C433B5;
        Tue, 30 Aug 2022 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661900429;
        bh=0mF3WeREdxfLanSbcau1tiUcnV31EVHGqWeXuYMj6NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpGy/AMtSAn+HdVaQW3eBPtP3Er2o0Zb7De0VP4AiuCrElIzbDKGU/KYT9JayRNvX
         UT8+r8Lw3vUb1kpeMceP+hqEq9aCZPMbu3uK5cK4eFae9nyyoNNNKJqUoe8JlBpBq4
         40QGjDe+g1TlTYRdZKQLhNvvBc5GcCP0nm3Snjp44TsyRSGk3k8M8MlGjhfKCQ0I1F
         jadGksW0lC5pftJgOflyC05imd/RgKy8BMs5ikrJAttRcQr4T2TLMwj72bKMuEhAqx
         NGTdb4wvQX6TNFl684MKN8DWcNelpkU+3Nn0eHgRCgsoowe2MsbbeB9JSTbNFptq2K
         7jZISz8ODLd6g==
Received: by pali.im (Postfix)
        id 3CD7F834; Wed, 31 Aug 2022 01:00:26 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Wed, 31 Aug 2022 01:00:10 +0200
Message-Id: <20220830230012.9429-1-pali@kernel.org>
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
of reset device. Default level was always 192.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
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

