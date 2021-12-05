Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A806B468CA3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhLESUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbhLESUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:20:05 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B1C061714;
        Sun,  5 Dec 2021 10:16:38 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r2so8062273ilb.10;
        Sun, 05 Dec 2021 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25U6Yhax0BXTLLFHy75HSeiByRDthooJoTH4u1dV5LA=;
        b=Rvj12MBSzB80e3ODwTCnzkmAw4RhufBgyW4U+R2JP4L0wojyAi/SRkDQxFRsGsZsgG
         Ot1xrmKFqypAotr9EhCSrd6SGtNYYEi0dqk18FKHD4OGc2kCOQJwP0wgqJK4BZCn+gx1
         dpA4FViXSM0f/Dhodlfxnh5j0hdMEWQ2ytdDJPRl9rbtqnLshuSS3x/pdjrH62Ce1WXU
         A06czOMCtxrssoeWrhD88ZAk8ykMUU1M+1mXofIWbJRSv+zbse0scYbzB+jocTnDccwm
         3woQ5qQtcWMWGjrWwOd7+pXIMYz0mguxX/ZKCkaWkDADGQbXvavU25dkjk58jzmhqVb0
         ml7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25U6Yhax0BXTLLFHy75HSeiByRDthooJoTH4u1dV5LA=;
        b=rn+DVttchGRBCRm5/0Q1ptFrXBms2d7s8NaF1ToKIPX6dz3/rAGhNQciILQe6wjS10
         aTQ98X5cFIWWOUvOGy7NCYPgOnThSxkX/ACPZ4sCxIiqJK1+SdLiEi+2qEiMHdjmjB0O
         hKSpyGG8exAy0OWobhjtYsSpnu/Fxxq6EAGNMtfF/m8nBHk55rNdWnC6NBNjkZNy6Ari
         MjmUVcz7er8mGjr6C8W3JKnPOvdgdxSKDLTv84Tgn5OJugbNXbRNaReuxYgvHEQvXCJT
         X+qKrxccUcCZzlfRgP04GkWsyXn1AZ9oX01ABE6ycYXce/dtOjTFhuBsk/U6yHw6G4n3
         NYKA==
X-Gm-Message-State: AOAM531Zqmz2OlUeLlj/A3MnL9offdL/GeOyAiyediS0G1tVULbnW/Qo
        /cTwaDYB4YrU59CDPDjeMrFRP3DRHRC0Nw==
X-Google-Smtp-Source: ABdhPJx+8/AenvnBcExwEZRf0KhljG3vKx+5WKg5qzFjex7s64VgpSRc9LncTEdDstvRNWWR9oaMUw==
X-Received: by 2002:a05:6e02:2144:: with SMTP id d4mr30553751ilv.11.1638728197216;
        Sun, 05 Dec 2021 10:16:37 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9ea0:bb99:b16a:6159])
        by smtp.gmail.com with ESMTPSA id z12sm5808164ilu.27.2021.12.05.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:16:36 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        nicolas@ndufresne.ca, Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC 1/5] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Sun,  5 Dec 2021 12:16:14 -0600
Message-Id: <20211205181618.1041699-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211205181618.1041699-1-aford173@gmail.com>
References: <20211205181618.1041699-1-aford173@gmail.com>
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

