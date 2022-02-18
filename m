Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6304A4BBD37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiBRQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:15:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiBRQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:15:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF42B2FC7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:31 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C107440303
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645200927;
        bh=zU8PHhdXJ/Ueh121b9Q6oYq5mxpNaWQJcLKghCGJuJg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=M12UUrx2HT3nJUtjmqoggHUbECHNBS82JtAWNw3fzVlA4nCnihIG9D84gJTEbve+B
         +xvTj7j7TkA+I0cnrJcrtnd2KqO0b8/25c/4gdS/o0pBbhPJIimeqMo7oApxKtI49o
         fXCatzU9romxxGuxxTrKCt5COkWkjT43ypCij9Ug76/7BSHtKFRa9bdVeRtVxGtYL3
         Jh8Bt1qqtldmZQALAMxo7t6opcfcg8MYbRcKAFO28e79EITaIwWAebPEBHxpmXhALD
         YoYTTYBWewTgRpjjKftdspggXvQw1wudiUpGiFhOnHV4BJfGwYFYBqznXCnv0BC9x3
         TLZ9NG5jgkbzg==
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so3288452ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zU8PHhdXJ/Ueh121b9Q6oYq5mxpNaWQJcLKghCGJuJg=;
        b=vaxPceUCf/dhvAXQQBNnKncJlgH/ZXu3O4wYM7/zutiyQecGvXByfyeGwP/NSutn8g
         KmAuffKrW2W+lcI3h5QSFIAekgs0JIw2uCZBoB5yvRv7Gtqu7hBSlZSq0qexOEcdsqZD
         jxLRYQHKP4tguwnnpq4shnTY5MYdAnmoifMBq/ZwCYbvfDqzPNmdFKTlifVElG3518BP
         bPadmyBjG5j4HpsEeq6x1+wc2cja3uXQQnw4a8ahPKtvQ6x9J20S1KUuNkT6XeT3I511
         94wGxL7Xzlm7sliCnYGuADFIUszt7iIU1Jysj/zY3aGe/Rdi9KJugoMv9kMvCeWSTNPC
         AzvQ==
X-Gm-Message-State: AOAM532uYMRY/xOPGtKi6XktqK3sC+tU++yYNkHJG1hpi/NpTycLDPgc
        BTH34MDlTd5kjS+C/w5LXzb7EYTBijHU8zPQU6MnkLNw64WuImP6qSJ/SsmMsKKDebnnDUkjFXt
        NnlehdJ90XIiBkedFlXn/OA/cJ1Haxj42DLB2tqJu3w==
X-Received: by 2002:a17:906:2ad3:b0:6ce:3662:8d68 with SMTP id m19-20020a1709062ad300b006ce36628d68mr7033230eje.71.1645200927399;
        Fri, 18 Feb 2022 08:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/wkrF7krrpsgkdvOicdEcCrW3UqlmOyhO7J1hrmzKSDRnQT9+nScW8jsxPc1cVoroQAhx+A==
X-Received: by 2002:a17:906:2ad3:b0:6ce:3662:8d68 with SMTP id m19-20020a1709062ad300b006ce36628d68mr7033218eje.71.1645200927228;
        Fri, 18 Feb 2022 08:15:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y21sm2325572ejq.185.2022.02.18.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:15:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: usb: dwc2: add iommus
Date:   Fri, 18 Feb 2022 17:15:20 +0100
Message-Id: <20220218161522.52044-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC2 node might use IOMMU (e.g. Altera Stratix10), so add "iommus"
property.  This fixes warnings like:

  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dt.yaml:
    usb@ffb40000: 'iommus' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 048e352c531a..1ba96706bbcb 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -68,6 +68,9 @@ properties:
     items:
       - const: otg
 
+  iommus:
+    maxItems: 1
+
   resets:
     items:
       - description: common reset
-- 
2.32.0

