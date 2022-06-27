Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6655C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiF0PWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiF0PWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:22:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345918B01;
        Mon, 27 Jun 2022 08:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C72B615FF;
        Mon, 27 Jun 2022 15:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7776EC3411D;
        Mon, 27 Jun 2022 15:21:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dmCXXbNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656343280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LCaAxooxJuCN5Dw6GuEoQwD5um/s+HvpoZCAe3Rx7uc=;
        b=dmCXXbNlaTa5w9oZAf+Yw6/wLgRBMiFTtY05XxvkGuYvn7CBojqyXUHpeEN1IbievF6X5H
        G7Kei5kpNIDf09MTqW+qmZ6s11j2CVl34EjUAr4HJbbAKcHIjydEvMDgXUbbEdbmfNRzEg
        N1OMmVc41vBrd0MlGzfnoa6M0hGNGsQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac12ea5f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Jun 2022 15:21:19 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: chosen: document rng-seed property
Date:   Mon, 27 Jun 2022 17:21:07 +0200
Message-Id: <20220627152107.645860-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the /chosen/rng-seed property, which has existed for quite some
time but without an entry in this file.

Fixes: 428826f5358c ("fdt: add support for rng-seed")
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/devicetree/bindings/chosen.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 1cc3aa10dcb1..49b175e133b2 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -7,6 +7,21 @@ arguments. Data in the chosen node does not represent the hardware.
 
 The following properties are recognized:
 
+rng-seed
+--------
+
+This property is used to initialize the kernel's random number generator at
+the earliest possible opportunity, and will be credited if CONFIG_RANDOM_
+TRUST_BOOTLOADER is set. All hardware that has an opportunity to set this
+with high quality randomness is encouraged to do so. It is parsed as a byte
+array, which should be at least 32 bytes long:
+
+/ {
+	chosen {
+		rng-seed = <... random bytes ...>;
+	};
+};
+
 
 kaslr-seed
 -----------
-- 
2.35.1

