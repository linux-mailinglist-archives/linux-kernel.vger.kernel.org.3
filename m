Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED8F47EB97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbhLXFXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbhLXFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:23:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22EAC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:23:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g26so16839195lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8p5cAhIlsS0RVNWJwJlMF76TH5CwTtvB0RF/Dz+Mi38=;
        b=baDEms+uzCHi3HYHok74MXuUK46KTsfuP+YqAZsGbvywpwmxu85G64pCns3LNg5DMj
         KvYpjVmlpfJIVLW+YVLOUBXNMPFfjT+Mso/TSTweOI7XL4chwg7e5beZKzLhRebQsfel
         MeMg5iU6Kt6QLWm9UIruT5H32QK0aZ5y6Fqa51RxIi4hH4zr9zn514OqyJR/2TQJy0Mp
         F1Wei/sB1BvZe7YoM5YxUqL47A9uZ+/T6vrw9VXwjVTweXHkyF9v6sqEGfjg7cVGlDmI
         L8SlMVzOCw+M6puwGUckor6tOuzmGewZ9wwWJdOl7fIgfoqCJ+FkloY386QdSKQupmOg
         QkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8p5cAhIlsS0RVNWJwJlMF76TH5CwTtvB0RF/Dz+Mi38=;
        b=KJ1uXCTa1/FFgRAxFDORxgLmzACZdexFGV2pJsKhreY0+M/kfJs2PYlGJsPgvGY7ro
         WFMK32SSdB4dn1phu2QNQ/9NhjbX16RCOw0klOEHsMq+gHLKl8ZfLipWestAe1zmYIxe
         zsHVHv4Z0nm/VDLzAZd7R3Jb5b26XnieYxTZXy+m6YyN0MOJk9AVeU3QHnqivPuPfCFU
         jmLf3S3YAV2UH4DUbpWzZIJOzJgFSzW9o1qU+KvrHwCPBJbOn66m962+PBdAB2XLP5Rk
         7mm0wL3E361pdPUd4hVWGt6PVbKI4H4e7hd5sRGc34HRgcgk33+PhaNkypbdV9hB0gOL
         eoPA==
X-Gm-Message-State: AOAM533M1ia4+WXse/Tj2EDnG600JTMjSoMB0PEKaEscP7hUTlCHBvpl
        nVGIK+eOHQmJr1crSSxymPsicw==
X-Google-Smtp-Source: ABdhPJy+HN9Nf9T96QkeX0cpn8ucbeHE1l2R9SUX2XR+Qg6BdgeJDGp6k+PB5axfuBITIXZDhvTjTA==
X-Received: by 2002:a05:6512:15a7:: with SMTP id bp39mr2903128lfb.363.1640323421226;
        Thu, 23 Dec 2021 21:23:41 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id e13sm702858lfs.306.2021.12.23.21.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 21:23:40 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Date:   Fri, 24 Dec 2021 08:23:08 +0300
Message-Id: <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing lvds0 node for the R-Car M3-W+ SoC.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index 86d59e7e1a87..a34d5b1d6431 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
 				port@2 {
 					reg = <2>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds@feb90000 {
+			compatible = "renesas,r8a77961-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
-- 
2.30.2

