Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE574AC824
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352688AbiBGSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiBGRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:55:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D35FC0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:55:56 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 584A140303
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644256555;
        bh=iL0LIepeQaRgfvOw682KQCC7APivisHIQkh+XV3XvQY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s/R8Sngq+OaS6sh6NHe8zsUyuOQ8FKnmvari+FhDNC0VQPZW964d4ry4OYmgGkkLu
         iMC8xa/lNA6eQE3RpmXyM1zYCqYrZs0SsWn9htTqTUfoSU8mCInW+QWi4IJ9lH3QzJ
         t7Vgrb7RqrVJOB44MZkPyRs9AJ4K9/UWvLJfJylZMUFDg0wY8hHHZiKPdLEJl7Ouhf
         wsHygPEH2h9DhpFaTV6tsivCfKCXmOX8airBhPCed/+jI8mKjMMZ1rT6FLJq8Kgg6/
         qki9u2q+Z/O3IOmSZfRj/cxqMagUasOO7J3uiasVCaZmrgeRBxABjIir39+ps9tDrX
         wf/pEMdgeVnbw==
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso4615447ejk.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iL0LIepeQaRgfvOw682KQCC7APivisHIQkh+XV3XvQY=;
        b=7Y1mAjUliYAAKifnaeaZpZtFaAge/yLzb2HFTmwoog/RVU9wXrSXFPYT0rJmrxqnR0
         c9GCrhCHKbzcBZPguzZiCTMBGvF2kIu9WxL3tsgXX5a3QH4KbjFgGLjfrUlZcUI9Cmlm
         ZUIAZD59HHb/C9jSpV1KNjc5DYm3sAmrZ96lqBMH8PVxNI7RQaQp22KN43srA1+CWLM+
         yA+vBOfv99SuO2zQHVyJeDi3OBJJbrnPyywLzYAJwxtYeu9kbaYMzBBK2dofzgJ8Dm5S
         tiStUysoJ8m2Fgi7u9JjkOOH6i9zz3qj0Vws1JqZnVwmXSx0TOCEvDRPUbNoaVgTF+ok
         bBzw==
X-Gm-Message-State: AOAM532kXElR0pRRPhXuCbt9dEXXQKujNZnlJ8eekk7v1bjVDrZ7coQq
        BQ+cm4EKGo5hNXt3YEbApezoZ8p7wEkIwnDwWfQ2Kcoa0+SOB9cvnuB8FK3Z+OfFYkZCTZ/DwsA
        n3HPoVfrD0yaM8AV9CNlFWCk9EhbS74NLI4V7s7vC9A==
X-Received: by 2002:aa7:db01:: with SMTP id t1mr637164eds.394.1644256554744;
        Mon, 07 Feb 2022 09:55:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1G4vKpj2os6F6Z7fqUqCrdFZ65ttguW/jqIW3WbwlVZjZTC1cTnFdJkB82oG6+PYM+9UXHw==
X-Received: by 2002:aa7:db01:: with SMTP id t1mr637145eds.394.1644256554541;
        Mon, 07 Feb 2022 09:55:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c20sm3765210edy.41.2022.02.07.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:55:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] MAINTAINERS: add IRC to ARM sub-architectures and Devicetree
Date:   Mon,  7 Feb 2022 18:55:03 +0100
Message-Id: <20220207175503.425200-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220207175503.425200-1-krzysztof.kozlowski@canonical.com>
References: <20220207175503.425200-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the IRC channels used for discussions about ARM/ARM64
sub-architectures and Devicetree.  This documents purely existing state.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e219ba2c5ac9..95ecf8ac709b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,6 +1623,7 @@ M:	Olof Johansson <olof@lixom.net>
 M:	soc@kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+C:	irc://irc.libera.chat/armlinux
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
@@ -1630,6 +1631,7 @@ F:	arch/arm64/boot/dts/Makefile
 ARM SUB-ARCHITECTURES
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+C:	irc://irc.libera.chat/armlinux
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 F:	arch/arm/mach-*/
 F:	arch/arm/plat-*/
@@ -14443,6 +14445,7 @@ M:	Rob Herring <robh+dt@kernel.org>
 M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
+C:	irc://irc.libera.chat/devicetree
 W:	http://www.devicetree.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
@@ -14454,6 +14457,7 @@ OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 M:	Rob Herring <robh+dt@kernel.org>
 L:	devicetree@vger.kernel.org
 S:	Maintained
+C:	irc://irc.libera.chat/devicetree
 Q:	http://patchwork.ozlabs.org/project/devicetree-bindings/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/devicetree/
-- 
2.32.0

