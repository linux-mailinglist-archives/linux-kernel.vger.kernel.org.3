Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B14DD631
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiCRIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiCRIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:30:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C922662E1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z16so8905245pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYSHS1HMX6eMTWBoPQekbY/LnrHx+hVCf+4KGrQDYmc=;
        b=IFSSe8csUXjGGDosRHCGn3fO+VYoniE9x8J42lOZEudFDsNsV98ZesN6bj9YZHlSGx
         rzUUSNDgAqKWsCISlWsWoXZJ4+na9/zRejmLQtAxJeL750XBykhjuPYp5PtgjzXaioRP
         W6K8uKY7G1XRI6cPC4FJKf4UJipGp1a8UxVkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYSHS1HMX6eMTWBoPQekbY/LnrHx+hVCf+4KGrQDYmc=;
        b=cGFF3Wu2ONsofOniS6YEidSYvwGRf5NJiXM/kLA8LuWNsjN7wDgEpHxJ8IjsKvBdTX
         gOH2Z6Fd8rJDyRDPKqK1LyOrIk3c4QjQGnn13R30E/CqvFtPjasyqBS5fy0Ux4BTqTJS
         7x8jlu31CHr5SQ+aMZF+YxMDgVN3WDkPVNRrcsjPffqRrjU8mCL8yU0nxCdoUULuWWjD
         MPuH9L8+pfNLb7cCoBihaufwcf7NYZkuJV9XKgPMObYIG3v6mH4khmbOvxEaVKM+sSnq
         wioCK0bGD9k/RaPMmyU6hok/MixTIUgyqd4XTo0Q26wVYIr2fRbpuLECL3TQMFR4cVl6
         KaVQ==
X-Gm-Message-State: AOAM532bvhXPAu8uEWNSQKoAJZvidjYmve4nApDWNlnW/YKNXrOHc+5d
        Ka4MNorNLEISNtSfvn5E7jfaOA==
X-Google-Smtp-Source: ABdhPJzDLKDOl+pmopyHHP4KLg/0fWOsTqeY58M7BYm1nfrAKzxakmXqooCP00hA6BSnGX9OcZh/qg==
X-Received: by 2002:aa7:8385:0:b0:4f6:ef47:e943 with SMTP id u5-20020aa78385000000b004f6ef47e943mr9052216pfm.38.1647592165505;
        Fri, 18 Mar 2022 01:29:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:435a:ce78:7223:1e88])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 01:29:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v9 4/4] arm64: dts: mt8183: Add panel rotation
Date:   Fri, 18 Mar 2022 15:48:25 +0800
Message-Id: <20220318074825.3359978-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318074825.3359978-1-hsinyi@chromium.org>
References: <20220318074825.3359978-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 0f9480f91261..c7c6be106e2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -276,6 +276,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.35.1.894.gb6a874cedc-goog

