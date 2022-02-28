Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33B4C6EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiB1N5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiB1N5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:47 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2B7D012;
        Mon, 28 Feb 2022 05:57:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id bm39so10366337qkb.0;
        Mon, 28 Feb 2022 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=oc6VWBpEbroshkPMoR1Hgu8/7KKPhrHKZYPZUwUNPRegB1nJ1Sl2fNfLNrkdg+vzUa
         74zrA58Yzorzcv+Lvvb4o6KZgHnpwGPfoQvUBKdFkjU2SRcT9NnT7FO3LdcOWyYbjLYA
         aFAovpW0TdhyEEClis+xkr4RgOGH8NQlKaqbCKpvLSOZK8rB+n8zegvrD2e08kBqsvtm
         3DLSfuiho2nlJqQ/AjEqzJ0C55B85wvcAYJH5sFVOmVd7/sLnYUER01irJHWlzSjctE1
         hJh4m77EM/HRhCtIYLmjgqq3DdjvlQ2mJLitRref56joIDWu++Dawp6eBox1I74qGU67
         354g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=fzO7idswJJu4oyACEhbwdOxsJ76f8B1ycwJOXy3fkE6KP2H4dvZPriBUeAtfr0xlpE
         jyBNH9Xzre6Xgi99N5g6bB0J7fWkBjIi5spnbPXWle1RWv7zswMhQaQUjEga1+p1CjuZ
         pKw9n4eALeQkZiXt8ir0WbJ4XDZ2FEfbqaTpHuHNjC4Fr9yKn/pFhQ1PiTEZfJG32aQa
         M+Qy1Ab5F2Ws9f7RgcVQUJ9CNzh0aITHc2vaRaiHPObgn0vRXiHHi4b9uDnsH0IECURM
         FUqlIph3wpJhkXFaI+V1sbd6eORhO4J1NaXUqTsrrplHIy8a4gm9s0uAmgKlHRIFRnpW
         rdCg==
X-Gm-Message-State: AOAM533JuZkSZjr80KA7kDrn3zXfOwCOqe3YJUgtkqisUEbvzjwAg9tl
        kwrIZEjweWnlV/ax3SXCh8WibB7UUk+ZiQ==
X-Google-Smtp-Source: ABdhPJwKA+QtxdCp2x6ZX6JxtBEUGs0o8ONRL499Hoz/Uzm3NlcJz6Z31+cZv+G5iNxRncj9x3pzKg==
X-Received: by 2002:a37:9e87:0:b0:4e1:1921:1f9f with SMTP id h129-20020a379e87000000b004e119211f9fmr10881086qke.480.1646056628485;
        Mon, 28 Feb 2022 05:57:08 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:08 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: soc: grf: fix rk3568 usb definitions
Date:   Mon, 28 Feb 2022 08:56:52 -0500
Message-Id: <20220228135700.1089526-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip,rk3568-pipe-grf and rockchip,rk3568-pipe-phy-grf
compatibles were incorrectly assigned to the syscon, simple-mfd
enumeration, vice only the syscon enumeration.
This leads a dtbs_check failure.

Move these to the syscon enumeration.

Fixes: b3df807e1fb0 ("dt-bindings: soc: grf: add naneng combo phy register compatible")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 072318fcd57b..5079e9d24af6 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,8 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
@@ -39,8 +41,6 @@ properties:
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
               - rockchip,rk3568-grf
-              - rockchip,rk3568-pipe-grf
-              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
-- 
2.25.1

