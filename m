Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294344BCACD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbiBSV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiBSV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B354197
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso13087113pjs.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tlXNd4WfVV+N9MiUaNSDYcpKd5QnvzkHB2jHSyxHiSE=;
        b=5CsPhfBVJpIWa/x8rm2/nRs+N1fPus18cLloeaRd9q55k67hSctSfb4OPSgzhhJRKN
         ds1xDXNKBbrg/YjO4G0VLVCjHl3B+o1j4RfesE2fybq4r4tYeUdXsR+h9I0zKcJRX1in
         ANy2eEEcRhi4ELUpvbxjt5gssa2HV/zXKk2xsUk1RXisQDOuDCvNlCnLYGYeJ6jUPjfR
         MxSpYh+aNtu+Y1K6tIqqytBwhlY1/fikjip6nBX029rlIymhVbR4Sj+dMNh/5faVGfUM
         EeXF5jv0IbknANDnNMHFurfvscQuwqwHttIU0niSRoEwE97/ecOlUqR7CWReYDyAIxo/
         Fbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlXNd4WfVV+N9MiUaNSDYcpKd5QnvzkHB2jHSyxHiSE=;
        b=uDa0GZ6YanVw0WCK7HiGwXvGpOS1tT18+r4PZ0i0pm5uen9Tvdl1ljo6Y+UhCP/kgk
         6wdpmqob6+1C1W5TECYONI3K4IZro7M2j+a/gCHm/F4KpXExFzFIsZ4JMhIuSMD+NGTq
         Dj6vc3rQgHny8PR+BPToyRK2duEraCCgTsvIaZ7vMWQvlrgwd/cdwSlQ5rICMnlaiExm
         fB7EEJHhdhQwvgv3NVIV2Rv93EBlL3d/yo95U27WxDB95cJIVnRD0QvZim23+paWiSzD
         8cCEjX5Jxol1N3Vsh9AhUu7AyCGwebaQTn1Z9j1n/r96/ZRRPphWMnRliGZi2BYMvR0S
         xZZA==
X-Gm-Message-State: AOAM532vJOIXBJHlfJz016HOeerG+xlc1M4qC3FCOlcNv8SoZf0sjYwb
        n8auZ7CjmLSBvLiairLSvjgvEQ==
X-Google-Smtp-Source: ABdhPJxlo3caslaF3DdogQsF2CNkabNAPdTzgIT92VlqtQMgcaudXdsWCY5mLtbEZK5i64FQjhgHfg==
X-Received: by 2002:a17:90b:4cc6:b0:1bc:210d:b6fa with SMTP id nd6-20020a17090b4cc600b001bc210db6famr741799pjb.104.1645307741905;
        Sat, 19 Feb 2022 13:55:41 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:41 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, s-anna@ti.com,
        khilman@baylibre.com
Subject: [PATCH 02/11] dt-bindings: wkup_m3_ipc: Add vtt toggling bindings
Date:   Sat, 19 Feb 2022 13:53:19 -0800
Message-Id: <20220219215328.485660-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
References: <20220219215328.485660-1-dfustini@baylibre.com>
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

From: Dave Gerlach <d-gerlach@ti.com>

Add description of the wkup_m3_ipc DT properties that can be used to
toggle VTT regulator during low power mode transitions.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../bindings/soc/ti/wkup_m3_ipc.txt           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
index 401550487ed6..4cdbb60fd0d0 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
+++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
@@ -55,3 +55,37 @@ Example:
 			...
 		};
 	};
+
+Support for VTT Toggle
+==================================
+In order to enable the support for VTT toggle during Suspend/Resume
+sequence needed by some boards (like AM335x EVM-SK & AM437x GP EVM),
+the below DT properties are required. It is possible to toggle VTT
+using one of two methods depending on the SoC being used, either
+GPIO0 toggle (AM335x and AM437x), or any GPIO with DS_PAD_CONFIG
+bits in the control module (AM437x only).
+
+VTT Toggle using GPIO0
+----------------------------------
+Supported by: AM335x and AM437x
+Used on: AM335x EVM-SK
+
+Optional properties:
+- ti,needs-vtt-toggle:	Indicates that the boards requires VTT toggling
+			during suspend/resume.
+- ti,vtt-gpio-pin:	Specifies the GPIO0 pin used for VTT toggle.
+
+Important Note:
+- Here it is assumed that VTT Toggle will be done using a pin on GPIO-0 Instance.
+  It will not work on any other GPIO using the above properties, regardless of
+  which part is being used.
+
+Example:
+	wkup_m3_ipc: wkup_m3_ipc@1324 {
+		compatible = "ti,am3352-wkup-m3-ipc";
+		...
+		...
+		ti,needs-vtt-toggle;
+		ti,vtt-gpio-pin = <7>;
+		...
+	};
-- 
2.32.0

