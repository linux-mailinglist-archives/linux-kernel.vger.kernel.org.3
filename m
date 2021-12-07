Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15246B023
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhLGB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbhLGB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:58:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D53C061746;
        Mon,  6 Dec 2021 17:55:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id k21so15226466ioh.4;
        Mon, 06 Dec 2021 17:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ci/iieSAzRzH/2rNrz9vVPVHZbfFcrg+DugyyrDVWRg=;
        b=LDfFHWx0sLwtOI4qmb+rJoZOe3pMc8wQmCBWVmAQyJe6fufpXB+EUy1UM2QqfrxD1S
         FXC9srcLOLwLdw2EH7fkdyPKJSNENNFpOo/oIt2DTrdW+0h7cfD2QfSoXLOOncr1Yc7J
         FrL938kbZFvzOSxGblv7OIzvTIRqVJeF6u6vk7EZ+cC6Xhh7SzGnf/KdSfu//7mv63Kl
         90qyoceR959mHeXesbrzKHbn5wiKggCNyUGuDZPrbGW40yqJBnGqqGVMcP5tpdRchk/Z
         agaLbMKO5DzlfSXJ1sh9VQ/i2y8EJEyn3PIFKr4kzGEYx7K9+WsuS5lfGfDo+/uWJWC6
         jidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ci/iieSAzRzH/2rNrz9vVPVHZbfFcrg+DugyyrDVWRg=;
        b=lHXq7sIxNTp3Nt+KsZ9BHLo+IjUyBZg1jU7ImxtIhnU0gIR0ZybQ27WfVuK1A0JRcc
         Is35E7t5fiiv2PTJPqN0ugnyCIqUmMHbneKTLJ35kz7bbzMWV6rGIm8gRBuWTxn8zwph
         5l/6+RMZbRcIupPt7F1LNIgshUWvN7XPn1ioW4ja97dOOvo53GBqPuHTkxjZdru8rzb+
         5c8mAQUNswj8+XlryvC4j+xXNBjRjEu9S4kv+K4xt8llgdpMelzMuQqMFOQ2HW9uZhsE
         cKp1g2syqwL6g+Lm0h8dwdwpmM8asbHMSy8bu8/zQ80jxpw1mhWHFaH5Cv1UdWWq4zqw
         uYvw==
X-Gm-Message-State: AOAM532ylFplEHWj61coWmkBBIbJ3fkJjBg186manytYKS17nwn4FkJ0
        VcFGw1y9m478h/iY31eLfCx4OBssLdA5Wdv+
X-Google-Smtp-Source: ABdhPJxJu3EIBppxy4TsSMZ5q6LJjK9+uo/vPJKjyNFfJtmW/D5eNatcK4jPy9Z0hq8LzNIXiJgFkA==
X-Received: by 2002:a05:6602:24ce:: with SMTP id h14mr36594205ioe.87.1638842100890;
        Mon, 06 Dec 2021 17:55:00 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6db8:c9e4:6f6d:f38e])
        by smtp.gmail.com with ESMTPSA id j21sm8623639ila.6.2021.12.06.17.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 17:55:00 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     cphealy@gmail.com, benjamin.gaignard@collabora.com,
        hverkuil@xs4all.nl, Lucas Stach <l.stach@pengutronix.de>,
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
Subject: [RFC V2 1/6] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Mon,  6 Dec 2021 19:54:40 -0600
Message-Id: <20211207015446.1250854-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211207015446.1250854-1-aford173@gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the defines for the power domains provided by the VPU
blk-ctrl on the i.MX8MQ.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

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

