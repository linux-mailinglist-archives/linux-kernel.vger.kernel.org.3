Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E924CF348
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiCGIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiCGIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:10:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8584D24E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:09:37 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BCAA93F61B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640573;
        bh=kV9bWky3aqex0YOWejd45KPzqFNsCZcNjbYJT0yjx5k=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RQphjHQJmXBAx8OeYX3OY6E4zyOjEy4PMuiTtFe9MtP6VCgrOaAkK0apjKxRO7F7m
         K7BmT9MdmXicq9yhv0zszOqSmESNTkEaUonfd3E9yTFDBO/wwWnLiOuh+uydgdycSl
         IWYvNCP/ksnjlqLXFz6hipklyLKAr1QAXGOom/GhpbS1yzdShup3re0/4i9epK7snC
         eHZ0slxKAOjPmYX0xj8aqJ2Op8sEtILpBkxkDcqy5Ie8qBz7qD2cWaGH66e3/hi4I5
         40jzuA0yuQIucLROu97t2utbpOIUpMrWrogbQhua8zJG5Q9MdGN56JkpKvpN5eCIIO
         TQa0rPmVzbDUQ==
Received: by mail-ed1-f72.google.com with SMTP id l24-20020a056402231800b00410f19a3103so8158455eda.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kV9bWky3aqex0YOWejd45KPzqFNsCZcNjbYJT0yjx5k=;
        b=P+M6S9iMqxHJZ2KXz6US48ZFayh56yYgGw5fsTXzWdNsZNjnUbZHEoR0he3V4LzZFp
         thY+fGlrQGBD5DJp3PMmZpqt1B9S6Q8dA/s85z0cJ8+k3OoccRztvr9/qHYXIEv/wTo6
         JXmfOMuCgis8jiK7A/ejXww8URSJDF/xo7b3bjDykKUtCBsTVwRChgQIKp8Gs+KnREaE
         5AmCHe/3aD4Ie8IkeerMDym0jwEdhctbRQ8cyBRqmV5RdakKjNmRxdBk80e5oBVllR+p
         qgEAVUYpbt7eSnw3/cXSZ0o/JcZ/qhCoXp6yDk7lcXVVAfNlADL4EFOfJWW1E4IVurDL
         81zA==
X-Gm-Message-State: AOAM533aRwAvrLwNUgsYZsDxCUpyJWSblhoZp8pyr3qxjbSeo7c1t1XB
        ggAFvFxgwHjCHHHnqddK/bd8qduUrAEU2zv1/DhyoX+QDoGr3pvk4wwHAAIWhju1/JPRZSv53ak
        yIOvmCKRrY0DN+DQJAFBjWzSLbDBkMrkto8ilHxpIhQ==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr7978723ejc.635.1646640572156;
        Mon, 07 Mar 2022 00:09:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu85jkg65tIPk5L9NKONVRpMHiBi3IKZigN9L3D0ZJ8f0joA64x28uwWQqTpa7qj5dJKGMqw==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr7978714ejc.635.1646640572014;
        Mon, 07 Mar 2022 00:09:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq14-20020a1709069d8e00b006da650af5a9sm4472594ejc.3.2022.03.07.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:09:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] tty: serial: samsung: constify s3c24xx_serial_drv_data members
Date:   Mon,  7 Mar 2022 09:09:23 +0100
Message-Id: <20220307080925.54131-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is never modified, so
also its members can be made const.  Except code style this has no
impact because the structure itself is always a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7025306f76b7..b9783d8fb440 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	info;
-	struct s3c2410_uartcfg		def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	const struct s3c24xx_uart_info	info;
+	const struct s3c2410_uartcfg	def_cfg;
+	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
 
 struct s3c24xx_uart_dma {
-- 
2.32.0

