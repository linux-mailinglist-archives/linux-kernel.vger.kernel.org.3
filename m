Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007AE5739A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiGMPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiGMPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:05:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6442422FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:05:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so15929127wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89nMQY6HYa205yz8a9PXVreqJnhbEp/5UjZ/0K+ojBk=;
        b=XuaI59GVVdLaY9nGGjKfAeviXgy/ApZnblUPAMvzh46fG/tmr3xTD1thS/DDCwEtuc
         GBpP29/u6JHMFSWSwwseqH5VrHazePwy0/LKvr+Kp3lDKiruCavOroFiysLzV3SYaneP
         fsu75ziErn8Qtva15PVP6DadY4A132NVDqQS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89nMQY6HYa205yz8a9PXVreqJnhbEp/5UjZ/0K+ojBk=;
        b=Z7iFuYVSTCH2X/NJxz3xVULehXN56/pyutud8XdE5gZR9KVykSR2qkfhZ6ZPBAxaFg
         GNbQFuEyoABKE+M/QXFmxod9ovUw7kfVX4ty9JJweEtoFeOz0vyEbMaYpSpiLSeYHZCB
         p72Qc7GfveVYt7j2T74HykcZz5K0o8acksU91wSDonXvKfuA5NsyZyTL3oh0/blw00Rr
         xJrDYtva1VTDePwE6+1Gcv47H7epIKYnSyZQkFVeRABbJg9ktyJPZmebQUgPoHesMAZ6
         Y940pX5x0b9f2IFEB4gKadtAD+VAlfcBm+5KXx97TF8kOtagQZNtwRvS07CWiSUxQbk4
         17mA==
X-Gm-Message-State: AJIora9YwiXPjTNY6Gg4ZmcfYoBzihGXyys2g/6ZYQ0/sOo1DXmaS+uK
        OtGIGd1+WSjbl+BWp+MW8eQu9w==
X-Google-Smtp-Source: AGRyM1t3t3ov77Q3+O1KqqHLoZA8HZXwyZ27oOlPTEg5Ae5GY3X5ipE2PQP8rWM0aKzLnNmLKd588g==
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id u3-20020a5d5143000000b0021d61b65225mr3649852wrt.164.1657724720297;
        Wed, 13 Jul 2022 08:05:20 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b003a2d87aea57sm1465537wmq.10.2022.07.13.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:05:20 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] media: ov5693: add ov5693_of_match, dts support
Date:   Wed, 13 Jul 2022 17:05:06 +0200
Message-Id: <20220713150506.2085214-7-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713150506.2085214-1-tommaso.merciai@amarulasolutions.com>
References: <20220713150506.2085214-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ov5693_of_match. Device tree support

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v2:
 - Change patch order 7 -> 6 as suggested by Sakari
 - Add missing signed-off as suggested by Jacopo

Changes since v3:
 - Add reviewed-by tags, suggested by Jacopo, Krzysztof

Changes since v4:
 - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
 - Add Daniel reviewed-by tag

 drivers/media/i2c/ov5693.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 701468267f20..82a9b2de7735 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1533,10 +1533,17 @@ static const struct acpi_device_id ov5693_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ov5693_acpi_match);
 
+static const struct of_device_id ov5693_of_match[] = {
+	{ .compatible = "ovti,ov5693", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ov5693_of_match);
+
 static struct i2c_driver ov5693_driver = {
 	.driver = {
 		.name = "ov5693",
 		.acpi_match_table = ov5693_acpi_match,
+		.of_match_table = ov5693_of_match,
 		.pm = &ov5693_pm_ops,
 	},
 	.probe_new = ov5693_probe,
-- 
2.25.1

