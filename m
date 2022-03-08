Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83904D11BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiCHILN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344824AbiCHIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBE3EBBD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:35 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B42603F629
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726973;
        bh=HBWgDosMAxuyNUJy93OLxsRzmckdD8hfFxFfwNDa3dk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gTeTFmNS5aebL7Hy7XLUm1mOhREgd7O3FVcgt1QYGhKZYxSTk0tWAjT/Uu5uryPoA
         WfdfSRFLipFl72xbXy1CV/QECMhWfStoQmy7CNGuIwk+yQOErXny4Imvz3QGPnBHbx
         HyTpYRFchYhuptwz8ri0GRWC9tGz0wRtIjclmAX0IzcLfNcgEYuhzwfbcxIosOOdv4
         1p8odZsdwLxL7rJ1VoVq7ebhArOygBHhCtyh0p1wsLYviFJA5doITv0KvV9In/G0G3
         btbNnnZXOYSoB9ikn2gfUfEC6xamK8/kZhGqJTcsTGfcS/bb3GpbzhIeqWjqcWaPKY
         lRR3IRG8dbuBQ==
Received: by mail-ej1-f69.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so8176310ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBWgDosMAxuyNUJy93OLxsRzmckdD8hfFxFfwNDa3dk=;
        b=dCjjWpOBLV9Bq+4zrcQMqvt5QrkqN2M7oYS0qoLysndSKZjh1bTBpW+40A1EsRrdjb
         PM4CM86uYzr0LoQvehXU/0cK3j/C1eyxfhjRmIv8VLWSksF501hGCoOCWVOLO+rLdj2W
         NNEveovlCJiZUFrhGYfJPfwwEKrTHKgJl4Cid+G3jEHugnlcXELeC7PrbW2LVBoBobIy
         8M6Vk4AIKin45NaWBg3Xs2zeuS1t6erBm7yIw8/J/qjJ1pcX9n1wX35Sw3yeBkZCIV/s
         OPhmOQsLyHsp59wzOWUjcdDynHLKt+pIv/Cy4M+zBZXcdRgzHR/rfsGq/fIKogqYM4cs
         CCxA==
X-Gm-Message-State: AOAM532hFSU2Ui4/8uxz5VKcRCHTWL/cLbcdbvemGALkrqlqad45k/Ml
        hN81kOfqLHBgSqqyzoT3KLZjj62nPuDv0PXX4kkFD3yEdMiv9PC+IRghprA+ytiqnkyK543BNVO
        /S5+NWElmEtkddmVUSqzGcyNaYQtce3VaR5tT22UFIA==
X-Received: by 2002:a05:6402:3582:b0:416:6d78:c693 with SMTP id y2-20020a056402358200b004166d78c693mr1885074edc.24.1646726973296;
        Tue, 08 Mar 2022 00:09:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX4vanJVIXL0r2uldoJOauafSu6vD8LH4bQI9ff/g3MAlWaGOGZ5yN4YqE3lb73p272nAkog==
X-Received: by 2002:a05:6402:3582:b0:416:6d78:c693 with SMTP id y2-20020a056402358200b004166d78c693mr1885050edc.24.1646726973053;
        Tue, 08 Mar 2022 00:09:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 8/8] tty: serial: samsung: simplify getting OF match data
Date:   Tue,  8 Mar 2022 09:09:19 +0100
Message-Id: <20220308080919.152715-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
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

Simplify the code with of_device_get_match_data() and use dev_of_node()
to remove ifdef-erry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 3ffae912217c..74d466cc4152 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2150,23 +2150,14 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 /* Device driver serial port probe */
 
-#ifdef CONFIG_OF
-static const struct of_device_id s3c24xx_uart_dt_match[];
-#endif
-
 static int probe_index;
 
 static inline const struct s3c24xx_serial_drv_data *
 s3c24xx_get_driver_data(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
+	if (dev_of_node(&pdev->dev))
+		return of_device_get_match_data(&pdev->dev);
 
-		match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
-		return (struct s3c24xx_serial_drv_data *)match->data;
-	}
-#endif
 	return (struct s3c24xx_serial_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
-- 
2.32.0

