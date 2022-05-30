Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD85379ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiE3Lar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiE3Lan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:30:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC2D7E1F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so10461818pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FDANzoD+ved+kLqkfGfvHR/pdrWdYCkcffUnS1gfwU=;
        b=Fu3f0elDLJOB2qbC/WiNHHrnzhkyIj+M6hmuWqiHDK3vOkYLQvzCSrr7LVh4m3XTYw
         zHYE0cnTsfWTDpSMBzpspezMLKffVInpKtx6Q6xL1bYNG/62ysHWflZJ8iUZZwz2DmLa
         LESrtBQuLJ1bR/V4bpVZuA5UHrSfe0QY1yOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FDANzoD+ved+kLqkfGfvHR/pdrWdYCkcffUnS1gfwU=;
        b=swX+LzeiiDg8JB44Czyzj8TsjQjRYvS9uIRkXdSJdre52FsPws7Ap5TGyOZ4/QyAvF
         jrSgdTEvCr9U+1d3jl/OHhL0qWJS99mbI+Fg01mi+SYSNMaCA2/FErecOjVDwD7vHkTe
         NXEWxKEjoMNSxnBUeaK1K12y4W4CyREqEsiEo+afLXN2SAhgMkKXOqZZUMP+acCgWtTl
         X5HmZseUp5bXKpzusDxs1cUvnRBP3sIgRjRSnV0VvgsZAZ2HSvusD5iOLcX+wKSh7tah
         dh/E8q7uZg8+i2o0aDFAvf6C34JKEze76Lwt2HMapBCpzCOLFyAESfY+jBKf+CI7NkgI
         R2Ow==
X-Gm-Message-State: AOAM530D64eI3+kOaj8iDLhyaxFjBNJR79Rr4sVQ7MQPjyVfpyAOsjBg
        zBwx+cSev3m3iWaDqnhl6YGlHg==
X-Google-Smtp-Source: ABdhPJxub7eHxeB4mlpr+M6AT+c0bGpa7kjAzy63YjDOWYW87ck7sC0r1LTX1UfyD0/ZFy7H+5i/oQ==
X-Received: by 2002:a17:903:1c1:b0:163:ef7b:e11a with SMTP id e1-20020a17090301c100b00163ef7be11amr2002458plh.76.1653910242646;
        Mon, 30 May 2022 04:30:42 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ae1c:3d63:abec:1097])
        by smtp.gmail.com with ESMTPSA id o3-20020a654583000000b003fa5b550303sm8384222pgq.68.2022.05.30.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:30:42 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
Date:   Mon, 30 May 2022 19:30:33 +0800
Message-Id: <20220530113033.124072-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530113033.124072-1-hsinyi@chromium.org>
References: <20220530113033.124072-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 8d5bf73a9099..f0dd5a06629d 100644
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
2.36.1.124.g0e6072fb45-goog

