Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9351949EFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbiA1AiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiA1AiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:38:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0717C061714;
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id k9so4397315qvv.9;
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLFwv7MjOQ+N54vrBm9216io6/o12k65yBVIhwcPg5Y=;
        b=LxbFlMhLkImQU7BenMFSJxGZJe7qA50NBhuhQySXdCmKQOPYYjk6mWtu6ikBn35pca
         3+mCL1QKPT2X0fBzscixX63/zFpbqu4oIK8Z/y6xelxW61p94+DgEU/WP9KX3k1TaHIe
         somjPHKZ+svAFdzQvVqmxibq414ThT1PZq66WMG6XfkpmFhE7bzMS+KAcLJj2eqhPLiu
         DlVUcm6n07Hwymu9QlH9YHlchrZ2W7mwjJwK1klkWGvXtqFEWRqMh0/rIZDj/65aRQUz
         fZxMxzxG6ziSLO4idnclWdYFXqsZQBllQWdfAQFOLN92XE5cZJrNjK0Gmf5E9qlUwf7C
         dpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLFwv7MjOQ+N54vrBm9216io6/o12k65yBVIhwcPg5Y=;
        b=HY8bcVARS0n8t13qC0NUIOuAuOj8Xq46KJg8ic1+hGb6NkfHxn/QLJmr4X11wSlKdc
         yM+S3tZXPVCxAMe8cu15pHL2NBH2fm8mTU/tyPYcWzmRNyVWnBbDiqZVeAqo4nJ7aaBg
         gyRq3wyy7P+oUBXv6mokiric0le2WX0FSUa54c0wWLJKjOWcjb8E83O6NMyPKA7VyG3D
         MIYqULFz0NbHRvHDeEsVJhLTTt1QNnZc1oo4x1yvgZQj9DcYTmuuxLl6y6o40nDJHPq8
         1xEJpkEGCUOdWlfteTD1pY1qLjgg+85YnWG9B7ZcR+fWLJlb0NurdCPeAsfsfXBnXhFD
         tBig==
X-Gm-Message-State: AOAM530FHIxiiTAw3KhyYlMG45NcDA5QnhBAyw+m1gBNtmztdLSGi+c/
        CZIWbBDDsSk9K1t8EmYfkBw=
X-Google-Smtp-Source: ABdhPJwrhsjuD03NSeUskaZoQXKK7d36ovsnIB0/+BjyXAkBfGW8Owu0kBbjWXKy0HrxScJjC41hRw==
X-Received: by 2002:a05:6214:238a:: with SMTP id fw10mr5286173qvb.15.1643330296577;
        Thu, 27 Jan 2022 16:38:16 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t1sm2142883qtc.48.2022.01.27.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:38:16 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: rockchip: add Quartz64-A pmu_io_domains
Date:   Thu, 27 Jan 2022 19:38:06 -0500
Message-Id: <20220128003809.3291407-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128003809.3291407-1-pgwipeout@gmail.com>
References: <20220128003809.3291407-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several io power domains on the Quartz64-A operate at 1.8v.
Add the pmu_io_domains definition to enable support for this.
This permits the enablement of the following features:
sdio - wifi support
sdhci - mmc-hs200-1_8v

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index d9eb92d59099..33c2c18caaa9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -482,6 +482,19 @@ vcc_sd_h: vcc-sd-h {
 	};
 };
 
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc1v8_dvp>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs200-1_8v;
-- 
2.25.1

