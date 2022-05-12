Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B3524D68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiELMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353989AbiELMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC8B24EA17
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p4so6177561edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffQ4orED3aiUEBYoSxBZzhQ5xLKzp9tGr66X/MdgpYE=;
        b=wwpR3bqanEewTxLg7wS9F7WsDB2jEc7163B2KtFP6RN2s3xUdnTsDuZSPQ2imwuA49
         JdxEAusdOFqPwN4TG3gwvIsHBwnFJxk68POGam6rePgP3g2lGtA/Osr8JGlRmOTw0ETj
         YzcMnr6f3x+s5xWsuvX9/QDjIEKPcVP6gxwFMVKqteQ/Wy0Q2Y+h4Vci3k8US261yDlH
         I4tMNg4UeBH1BO7eBgnDgT8emwRm5GdGGCnf2ZYCLObez2XHOjzSfu750MvaX2eGRtat
         YIp+59N7Qz/2PmS/D6Onpel4EIYhNvYaa6JAkx+lmyNMJtFkICXUnY0a5hkLR0MUr4dV
         8+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffQ4orED3aiUEBYoSxBZzhQ5xLKzp9tGr66X/MdgpYE=;
        b=TU8nZWf2yEvW/triSmy9EDOCeEjlPCiHBFk5E+UdAoCEPjbrw0cgfnLfEQ2+spc4D2
         Zr3VPUTuOYTvF6r5Guj3of2QaqzOoeGCTmOCITztN4dAUlF10IHpMt60e/dfvB5yjmKj
         VbDKLDdJ5RSXqiq/osv5XwNFoYmzhft2RzfiWmG9IBCQ2IR0o/3WuuRA41nxApDK2Sl/
         YhWVPlqo7jh4+Que4vPNMOIQOQ75tNLt+fNE0jafrGvCKQFf4f3f5B+CExGr3MofncHe
         yql9ykEUMOQDkKaqQWlWUr7Ym7CM9/3pxqvntJYtdODRottisXN9rxsuDRkez3Xt+UE3
         e+4w==
X-Gm-Message-State: AOAM530yTYHxjrx+T0LZVpSnTOWJQnqt6cwfJoC0Q2Qbx0fPUzMD7/ZD
        zb7RMbyfDb5PHltCdjXmgr963vtmQcB4hIq/
X-Google-Smtp-Source: ABdhPJxNaBDvuq2EJfEryi0nCUHgYuhIDbfcTiJwRKQw413HGCsqeJ2CMmt/NO/XMXyqwU1QUeTMJQ==
X-Received: by 2002:a05:6402:3590:b0:427:ba05:6f19 with SMTP id y16-20020a056402359000b00427ba056f19mr35666281edc.334.1652359766319;
        Thu, 12 May 2022 05:49:26 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:25 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 10/11] dt-bindings: marvell: armada-37xx: add Methode eDPU compatible
Date:   Thu, 12 May 2022 14:49:04 +0200
Message-Id: <20220512124905.49979-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible for the Methode eDPU Armada 3720 based board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Alphabetical ordering
---
 Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
index 4460608ac1e1..4ace605a8701 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
@@ -20,6 +20,7 @@ properties:
               - cznic,turris-mox
               - globalscale,espressobin
               - marvell,armada-3720-db
+              - methode,edpu
               - methode,udpu
           - const: marvell,armada3720
           - const: marvell,armada3710
-- 
2.36.1

