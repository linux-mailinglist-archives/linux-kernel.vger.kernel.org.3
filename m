Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CBE4B23BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349257AbiBKKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:53:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiBKKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:53:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F3D8D;
        Fri, 11 Feb 2022 02:53:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso2905426wmj.2;
        Fri, 11 Feb 2022 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CINhVeMEJRnxt2N7nzrBj1BDzXGGBYQDuFCYQXZDz9Q=;
        b=AbUpsLT6Q8vFhkID6EtjOaQvpWaHkS8QEeygk/0buxwJJSzps7TIiknHO5u7Bt8vgZ
         MRlKnhRrPyjgThb1imLklvmKr74OLC0S9nEsID7cF6ZXKvSNlcqOiYZnGWCGVB8Nu5zd
         IG7rh3FUOZV+PsT/roqqch8DMo1V5wEYeHcjY26ib4ePjxu9uP6+JCnCP01tCgORonp/
         XMfKzAqcVQwqe0C3U+AOjyJsd4mdETt/5PV5zUuLBuGpXBLEQw/qVCPUeC2nhHz+n3B4
         1WAmJb6e4aUlO33T6FYcxwVLLQ2eMQaKAB25LOYsyk8rbO7Q2zQp52fZBzJ0mWNqDFY7
         28yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CINhVeMEJRnxt2N7nzrBj1BDzXGGBYQDuFCYQXZDz9Q=;
        b=yms1FXYB8zYPM/OMmoPfYS3oC3OnjBO85HjKNPA6vFoWW32z13MEnWpEh5sIoy1sO6
         Qxuj5Ef6xJVN0oiiZa9Msz24xYxo88pklUZtyqh0pkmxCr2Hxbn6IKE9wCO16jd/sL2v
         VjdjacUj3Zv1mSdjU3jeWaI047+h5BniLnYbGXHoVDSoafZ+bAt4aFYLX/tWI1h34+Lk
         G8HPzW3Kox1S4ncJZCb5CYV7AVdSEz0+Vqlm3UroDTdfPSWHriF3boJwC5lPwcRp4aha
         Y7QnOw7Q0Bf5w74p0SpEh89EtrVaRYKrEWxQuoMz6SIfYR3/KYoILYTlyan4udx7A0pi
         I3Bw==
X-Gm-Message-State: AOAM530JBm31jEKf9sWdIeyvY5wM+QMa5bU1S1vuxggt0i9bamYsDf9w
        uKvGyEufVjXUZ/7xa0fpzbs=
X-Google-Smtp-Source: ABdhPJxZoV3f2mPoFwf+yjHEB+HwKykDyDVn9gQPt43swzkwS5t8kbcqYbm7hJozMCJ+l5xx1K1weg==
X-Received: by 2002:a05:600c:4e4f:: with SMTP id e15mr1680626wmq.53.1644576801279;
        Fri, 11 Feb 2022 02:53:21 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b4sm13382374wrw.100.2022.02.11.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:53:20 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: add Vero 4K+ bindings
Date:   Fri, 11 Feb 2022 10:53:10 +0000
Message-Id: <20220211105311.30320-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211105311.30320-1-christianshewitt@gmail.com>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board binding for the OSMC Vero 4K+ STB device

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index a073a959232c..61a6cabb375b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -108,6 +108,7 @@ properties:
               - amlogic,p230
               - amlogic,p231
               - libretech,aml-s905d-pc
+              - osmc,vero4k-plus
               - phicomm,n1
               - smartlabs,sml5442tw
               - videostrong,gxl-kii-pro
-- 
2.17.1

