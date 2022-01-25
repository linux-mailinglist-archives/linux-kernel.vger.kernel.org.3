Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8849BA04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587133AbiAYRQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiAYRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74035C06178A;
        Tue, 25 Jan 2022 09:12:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e79so24458327iof.13;
        Tue, 25 Jan 2022 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa6XTevFEqtbC/DVeN/V/vlo7FN29Xl+JkqDuO3dnjc=;
        b=W9ap+qvkTCG8bjc0uQsVrBYvZj+B6Rvoq6pwWYTLVUoilzUICwT2AXwpniH10xZ1uq
         fUKZ9RiQFWI2INOumUpsFdJ92qRdGBLlMC4sgcC7hexgQX8yoIqWQmi2+sEuAUEOowIR
         DZOI45GDFr2y8nALDb+hk9VuaZy/4zTuvZpI6tDFuWiZincB1L8RfzNkOaLhFVTvyGct
         TUu8dM/96xsrK0KNQd5MSsZL6cWEQfq0p5q7/DQ9tISr37V9Dlt7RwoKaXJT/V17C8Wu
         sVcNjMdhPdt8gMTRuqr7NtOX6PwxTafeRjOWDmZVOzM0kr4LFQ29VVSmSED74t6HxJ9/
         G3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa6XTevFEqtbC/DVeN/V/vlo7FN29Xl+JkqDuO3dnjc=;
        b=tKpgQyTiJeG2JAZONRr0GipmZ0RzRNzfGsLfB79mdB6TwALtHOD8d14uE5wHFxrFmw
         91W1dK7EGKzTUtkTYn2WquUINf9Wg/QASbmMp193l0NFY7xxDJVytLNWscZ2+gbFX/CN
         CoN+1g4V7zPZoWCeK6ZJH1pzjR2MndslrOC6s7pS3SterMsVJ4yVUe1lEvk6+46EmdH8
         +/s3/DRCWodXF15OnL1f7dn/pUjozY4qt3rRppn1SFqvrCiSpS9DQ7c7GC42G872nV6U
         pSYezubRR2tRzM2jfeDmR1OFygevOGLFAgI0dIrk34ZvpbQ5XOgptfHv4rYnycu4XHUr
         QxUw==
X-Gm-Message-State: AOAM5312lWkGe5G5ZfPnth3C8VyHSN3w+l5iQpDHl1MjTvmgFXA09n2M
        PwIvHQXJzkK6GfNmcKX0OyBvTufvfGg=
X-Google-Smtp-Source: ABdhPJye5D11pR1pHEM0xttSm1nhgngvx9EPzIDrdcN8uSOlWKpqZa7TaFWo9wUdt1OTEK1fxYrw6Q==
X-Received: by 2002:a5e:de4a:: with SMTP id e10mr5353405ioq.51.1643130746425;
        Tue, 25 Jan 2022 09:12:26 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:25 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V4 02/11] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Tue, 25 Jan 2022 11:11:19 -0600
Message-Id: <20220125171129.472775-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the defines for the power domains provided by the VPU
blk-ctrl on the i.MX8MQ.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>

diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8mq-power.h
index 8a513bd9166e..9f7d0f1e7c32 100644
--- a/include/dt-bindings/power/imx8mq-power.h
+++ b/include/dt-bindings/power/imx8mq-power.h
@@ -18,4 +18,7 @@
 #define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
 #define IMX8M_POWER_DOMAIN_PCIE2	10
 
+#define IMX8MQ_VPUBLK_PD_G1		0
+#define IMX8MQ_VPUBLK_PD_G2		1
+
 #endif
-- 
2.32.0

