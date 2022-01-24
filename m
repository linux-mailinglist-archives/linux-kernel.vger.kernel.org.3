Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5F49774B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiAXCbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiAXCbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E45C06173D;
        Sun, 23 Jan 2022 18:31:34 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n17so1907825iod.4;
        Sun, 23 Jan 2022 18:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa6XTevFEqtbC/DVeN/V/vlo7FN29Xl+JkqDuO3dnjc=;
        b=EZqSX3m/b79QIHHKJpNK7iciDNnVqv2GsxsNslHqcu+b2/SVqWynl3l15N0qCsVK/I
         Yx1eudSWla7Dd8qyzF5qAsiUpkVMyj2XJDrDr9HOWdJKc2E+ay069qw97DTs4bgISlFK
         03jL2XfE5E5sojSaVA4Y2QJO3McRJH0rg5E6MWnvvXqclq4FjCVS46AOUKMIhxg6kSHH
         ewK2KmoE9/IIpVFqmdwY5A+xkX0aM0/ibEuwupB4bQ1AEamqEVi0LPEW1oZGkBWyoRyO
         RW2MUulcBjX1lu2hG2irWeKiLysinNyNDbhVT0EOvKcB/VaUalJqUqaPzAw1bH4Z9bQP
         NX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa6XTevFEqtbC/DVeN/V/vlo7FN29Xl+JkqDuO3dnjc=;
        b=G9xn3uK7ndM0M13GPjSt7390NOYx7D9UlwFQfdJhjWU7fK04xUD2D8bhMvM4AcrK31
         MT8P91hVLn6OfaIeNV4/XhdEhRwXX9kONycZDr0t9mkUCiTpost0YfE2pQumgy0qQivs
         0cy0tGXOzMnzIs8J+VSZM76IFZH/g31JXBWx0kMPzojlpGUprxPW9b9SL5kCwf0FReht
         9mtcv0AX0f0YZ9gZsC1Ugni74cMJRpb6FEgxfdW7s3+psYqyuCX6lV0JsBI3MKV6U5Q1
         fhM4SLyRH7eWsNYUSAl9gB2puoxuXLKgc2p5ojnZJqpP2sNut7ah+UUzSr5m8+KunhIU
         yjnw==
X-Gm-Message-State: AOAM532ts7nzuxpWZheoVmjXXJPSfkERqpBnEQ8qnvv1qpYkYhXYmDqB
        nU25hSzQfJuuqKKdxspISQ8fYaqmDVc=
X-Google-Smtp-Source: ABdhPJzZXrS5FylPpYYU4zVBZQCSvGD3wFbcXnczpoUHVM/tfgVP3PLph+WJ6MmfCFVpINI7srDZMg==
X-Received: by 2002:a05:6602:2e8d:: with SMTP id m13mr7155501iow.68.1642991493493;
        Sun, 23 Jan 2022 18:31:33 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 01/10] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Sun, 23 Jan 2022 20:31:15 -0600
Message-Id: <20220124023125.414794-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
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

