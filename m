Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82454C57AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiBZSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiBZSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:30 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D91E64FD;
        Sat, 26 Feb 2022 10:41:56 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id w7so9341411qvr.3;
        Sat, 26 Feb 2022 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=b8h2md1WmQjX7RhaC4BQiXX7tOqaDV3OwgQyAUEJr2b42o69PSbDY21E7A8rmT818U
         nPEoYJ6O4Of79/TnzbBDSiRGLY9kV8Ctr/Q0VBW09QYWbGP+BX0GOhZwXgLzuqYRM2M1
         fKG0ANecenEjmkV4kD9G+o1PfoUOG61SbaWWk9wB8eLC+U1ZdMbT0a2P2kf00GJ22q+l
         KOuAGo0zPeR6EfzmpgLUi1pRpKUWrLxXr31FutLGGMcC6ajXiMDavkIG6hvkA7u+Qd2x
         CC/9UMko58HF6N/FVmMDGNWAn1GlldmJC0/Eiuyt1rexsVW7/FhmD0UizILrIbtXlFQZ
         dYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RL6lgc9JQzCOWChXKBrpjhVjZkUp1FLcriOwSbYz2iE=;
        b=Mm4XlxvUdAUNvJy4aALbKBw2X4x9r5eYYC9Wyd0tOx3Y6MFaQXbfKRolrhJu0GiCcy
         6hoMLiXhiGkY5GzV1WrV6BGzmRixaPx3xGZF2EIUpTOYUN1REssVPBS0mb5DYCvY55Pa
         nNLGP+kpXmGhMoy3JgPKMnj3iLjiTmUs/TYQgmFOWUKLxQN43744m9B7bU9YPFsS1poK
         /MRyH5Sr9wY5DcIdk38dRWQrZ1ois7YDKI/TueJwzF6Pn/5EA51R5QHQ2G55ZBPuU0hE
         1zK7p9y6fe/0+Fg9h0GWaMLedLlnGv4qUCWBpCoRgkg+GAESsmZs0jNPvEbO8MDCt+Nr
         TWIg==
X-Gm-Message-State: AOAM530xxAuZwljlad/MsP3ptxMMFpR9rS1gt73zKhmHFCvwtLsU4PbK
        A8JzlfLFbauPRa92OqJ+lHU=
X-Google-Smtp-Source: ABdhPJy65A+/b7Lw1aZW6kWg9TL5CgvA5j41RS8nNYZCyADkvvYkoO/EsYCgDT1NG7Tj0FMyseujZA==
X-Received: by 2002:a05:6214:76b:b0:432:f424:4ea2 with SMTP id f11-20020a056214076b00b00432f4244ea2mr1533960qvz.121.1645900915655;
        Sat, 26 Feb 2022 10:41:55 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:55 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Vinod Koul <vkoul@kernel.org>, Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] dt-bindings: soc: grf: fix rk3568 usb definitions
Date:   Sat, 26 Feb 2022 13:41:37 -0500
Message-Id: <20220226184147.769964-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

