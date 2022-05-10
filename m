Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C05226B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiEJWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiEJWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:13:53 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD52878C5;
        Tue, 10 May 2022 15:13:49 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id y63so624313oia.7;
        Tue, 10 May 2022 15:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=apC+quOopLDJEx5IvNDystjZ/JR51on+Skgly38QLAM=;
        b=SRBZBC7Kej11hagdqbTWD62yqmgFezFRc5GMeMHY4FagurHR2ch7MGFDlbeTNM8jFw
         L2L2OPewi/ePfjgykc2zZOMYQgltDLZEeqLOx54xKo20ceJeVZ9cFIWy6B0viPTbaoZE
         Q5348g00eUB6dquKHnF8DCfSH5rP2VE5/3cXFbRgLlu57JZ9fLK+p/cjk+9DgKZEKpOs
         rQS44ztm4HQcoqzyXtWcUY68lKQ6ju4Nuc1PKRozvylTmUDEViY+OQTLowXDwxEYLjCp
         OqG2C9bI52wSQlqVa0TIxrlhV18I2H1hGMAnAlgzEXdSGSSijE4FMrmRmwMmgNNPbU09
         LD7w==
X-Gm-Message-State: AOAM5303ybfFpw0zTz4Wg7vvetikxqNd6WF1hlIypa3Myjy7CXto7WpN
        g5wkgdh9dwy6CspCmgw5qPvpFsM93Q==
X-Google-Smtp-Source: ABdhPJxxvuT1U5FlExDMnThz74rPcrSQRjagwhztHk5WI7PXZW1elll5YK54z+n8RR4y9Z1TgRlEIg==
X-Received: by 2002:a05:6808:1448:b0:326:e239:a490 with SMTP id x8-20020a056808144800b00326e239a490mr1086302oiv.253.1652220828525;
        Tue, 10 May 2022 15:13:48 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id kw43-20020a056870ac2b00b000e686d13879sm83993oab.19.2022.05.10.15.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:13:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove example file on dt-extract-example error
Date:   Tue, 10 May 2022 17:13:32 -0500
Message-Id: <20220510221333.2770571-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 'dt-extract-example' writes the example dts files to stdout, a file
is always created even on an error such as Ctrl-C. The resulting empty
file(s) then cause unexpected errors on subsequent builds. Fix this by
removing the output file on any error.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index c9953f86b19d..c9fadff3dd74 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -20,7 +20,7 @@ check_dtschema_version:
 	{ echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
 
 quiet_cmd_extract_ex = DTEX    $@
-      cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@
+      cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@ || rm $@
 
 $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,extract_ex)
-- 
2.34.1

