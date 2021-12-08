Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1314946DE96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhLHWyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbhLHWyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:54:13 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38587C061746;
        Wed,  8 Dec 2021 14:50:41 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 15so3664324ilq.2;
        Wed, 08 Dec 2021 14:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25U6Yhax0BXTLLFHy75HSeiByRDthooJoTH4u1dV5LA=;
        b=IoYpEX/ULICdxAUXcRO4zYu+4e6lAYdr09BYwsVnPD4m2n62fAvPHlC4El3MNgAy+e
         nWfBtwYKW/o6D0eclIrJECJ1nRUmoPWCYs+eESR/s4gbZ29GlWbHuxnFKSQuE7+w0IAr
         R753ClJyqt9hIi214ogONAWVz/TinGE1Auusbyr5W95IVRH/H7TqcSWV93CRrTb2Z4gp
         C5xHNWuGFIn9bcOWnqI4EjqYNzoOa0SeLYkprDPT9h4E82qjdq5taOtVcc8VNw9F8BYE
         Pc0LJ8+UpagLLPFXr9G43kxBjwYPigf7va8nNaulIJz2UkcwdHSTUAlVxOE736k8qW3w
         FVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25U6Yhax0BXTLLFHy75HSeiByRDthooJoTH4u1dV5LA=;
        b=ETOK1roNtQboMT/NuAVr/BOvh5KJgRWr7XBfCtZWvko1JVYY+th9WS8YUuro9qUbOm
         TtZwZWLJgOxXpq9xfGzKaRAufC9Xk8pE98buWQgeiXvaNUJ9lf6ioKqJ+WIXqYcxKO+B
         MkzDe2x+uuPmPhLavrT416gTAKxUiQ6xdtk4250IjJxLOYE7tBXEx3VotFeht99GiXo9
         kTW6Ay3PPPkTSQnPPCpK+dqjc0s1Snk1cok5UDQFLNN+/TahmLRdjmhggiJsvLUVIpCh
         7D/ufKAR7B3zMvTJwea+m0ZjLJ2MbAUoerk5EyyncSFrlgQ53OrF/THy5P6dpp2rnlUh
         vddw==
X-Gm-Message-State: AOAM531mU98Bt4Tbwtlw01jgxgRWQX8qG2Xb2OdMTJ/tEE31N3uTuWVw
        Px5j5rct3R5RuB+DuDl8OVLNndhhQQIG7Q==
X-Google-Smtp-Source: ABdhPJzYh5UPP8BPYPny3NBqelVcmvIDzON4ttwf3iKAX0NCfy6JGIDBcalxJHp5I8V2AFvLNA8f/A==
X-Received: by 2002:a05:6e02:10ce:: with SMTP id s14mr9697999ilj.320.1639003840061;
        Wed, 08 Dec 2021 14:50:40 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:269a:1aa2:f1d9:8dbb])
        by smtp.gmail.com with ESMTPSA id t6sm2378751ioi.51.2021.12.08.14.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:50:39 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        aford@beaconembedded.com, nicolas@ndufresne.ca,
        Lucas Stach <l.stach@pengutronix.de>,
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
Subject: [PATCH 01/10] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Wed,  8 Dec 2021 16:50:20 -0600
Message-Id: <20211208225030.2018923-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208225030.2018923-1-aford173@gmail.com>
References: <20211208225030.2018923-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the defines for the power domains provided by the VPU
blk-ctrl on the i.MX8MQ.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 include/dt-bindings/power/imx8mq-power.h | 3 +++
 1 file changed, 3 insertions(+)

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

