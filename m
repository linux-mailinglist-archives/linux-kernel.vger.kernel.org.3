Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0653474F78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhLOAqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhLOAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:45 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5DCC061574;
        Tue, 14 Dec 2021 16:46:45 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r2so18576386ilb.10;
        Tue, 14 Dec 2021 16:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOj6+FRrWJBe0yzwKdDY+lwzo/kGYuvHuT0oZs9+DUM=;
        b=eSflWeUUijpaFjj4V34Il4s7QrWE2XptATWBJZ0JZsBFWFz8wnMjmYWmfvLlAYtH59
         uDGnINyNxAarNfVtlFtsriqxSJzpm4CT/sfIakQ6ATbFQL+P+PJ/Yt8vc2fg0RX/Yex+
         wTktJdQUqOyhVl153jYzMRAmniqgfE/8pB2Xm3Y7lLl3rhJ52KaqNBXVw/rP34Wlcf8w
         vGUGwFxEuAfIhJ6wT2zdIuJvlB8YdadzzQudnfdkIDvogcVWhsK6sWv4/DRUOh39Fr1m
         2a6qDYfC1KUQpqpHSDDBhR4FrNRaSULGEvBvA3OZ5mSNB/ix1sZ66f4WPhtyrFEDGKEV
         GDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOj6+FRrWJBe0yzwKdDY+lwzo/kGYuvHuT0oZs9+DUM=;
        b=MqnbPpFgYb+OHyYrb4wrezIXoaiHBcHXvEEHK7Kb28kk1OHHainQ1hq5fEgtBXC15D
         SAhBQSw++MDUWCKUa2kt5AAaJNRKn1XkXYC8nJO0YhSuWzBsP8zRgrN+NkFrt+MhCHUB
         uIIWlxHVsHhRQXbwIe/cpi9BMPMMYUy8U/8KdyK7Ic3YKlYYHKWXdNTLcplYAjRXhooi
         yvLaJiAEw1wNzdXQRecRwJNmgDVuiQ+lOlvcGCRMlOmLNqr3aY9JhF6Mm9zwk11od0Vl
         DfMBLPlQCKU29yKCzSV9Q9TuUCX3o16AXqhGmmeFr6ZLu90bi7aM1u3sB2ys+FexVnm0
         DC0g==
X-Gm-Message-State: AOAM5328Yq08Q8K6gttPtX3/CiZ8WpZlFjRaoCQBELjt3D//ZRvnL6VD
        2LJ25T3aopImdW+2CkJOeKefPhBzkptLSQ==
X-Google-Smtp-Source: ABdhPJwG/Wjm+9RxQ1YIY+e3WP80NillHAdJXqmT8faF2TKzs83aDEIeFNwXswxydfY8jfp5pdC53w==
X-Received: by 2002:a92:d705:: with SMTP id m5mr5490789iln.47.1639529204235;
        Tue, 14 Dec 2021 16:46:44 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:43 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/9] dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
Date:   Tue, 14 Dec 2021 18:46:20 -0600
Message-Id: <20211215004626.2241839-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the defines for the power domains provided by the DISP
blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
index 102ee85a9b62..eedd0e581939 100644
--- a/include/dt-bindings/power/imx8mn-power.h
+++ b/include/dt-bindings/power/imx8mn-power.h
@@ -12,4 +12,9 @@
 #define IMX8MN_POWER_DOMAIN_DISPMIX	3
 #define IMX8MN_POWER_DOMAIN_MIPI	4
 
+#define IMX8MN_DISPBLK_PD_MIPI_DSI	0
+#define IMX8MN_DISPBLK_PD_MIPI_CSI	1
+#define IMX8MN_DISPBLK_PD_LCDIF	2
+#define IMX8MN_DISPBLK_PD_ISI	3
+
 #endif
-- 
2.32.0

