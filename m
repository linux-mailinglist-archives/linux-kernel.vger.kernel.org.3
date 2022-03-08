Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8E4D11B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiCHIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbiCHIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454653EB98
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:32 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1339F3F7E4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726971;
        bh=Dr4tgo26oKDD7/cFmU+MgZtFQEJoCk73ZvgNX0zaNnk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MW4cS/a3rZ6mGwrKSnHQ9n+eNyJl1EoZSCGCxN/P3foXVGy6W5iqZ3gM7TiTKKrvt
         W6iXAeVZLcKVfrvMEsePZqimQGUDPrQzjoABVIGYLcrLCxxbhkmM1uohT8hZKEnwaj
         9tY6NKr2GJaXu5yRF5uybkXDZztssgVl+rMCNZjK2Ck2C9xoGlOps2mgzjCOfTqjMG
         CmOlZatxvEnhmYqS9aV3L90kblYY5Oc2PozdxcCk2Agi/wiU82Ss3gYPRd7ERuNEh0
         WzxJlLpmdmGL/KFqduwBKDvro+kbRiuY59jfNso5dDmG57E4KsU5zV8unPydIZ+mdM
         +9/wWiQBGFBrw==
Received: by mail-ed1-f71.google.com with SMTP id l24-20020a056402231800b00410f19a3103so10133086eda.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr4tgo26oKDD7/cFmU+MgZtFQEJoCk73ZvgNX0zaNnk=;
        b=6Hq1QSmiMm6LfnTU5we4N4BmvKo8OVNpU88Fts2Eu3O9FTUQrg2ZwDy1vzvUmyx4XP
         ae6fWF0lkuKeycfU5JCqOJWRlTGsppPHe/GnesWPBMkeUxOODoBvFCJfNQOVdHnHZM6r
         9WZ+iiayUrr+uFOuIcFdbgjYY+slwdD2zxv7kE5pIPt4nZJcCimKJZD+Iw/fCd7Na/p6
         eTtCIv1Rip+/M0gzAQ1OGHb9yWpYQki0hQ4JLCf6wiT4Y99XWZS5kL1F4IF1ct6GhmVc
         dTpeNphzV/kBXjsVjRwBbpP243tguxEB3M1Az7JzeaEh0jhlwVgjoEXgRMYm3pdwhq4O
         0mUw==
X-Gm-Message-State: AOAM5319NhVf3bboEnTDQzLYyqXtqxeB9RhN/25cKwxCcimeDxqXM/gz
        KkT1s73gpIeOH2fxrmiiCO62kbh+x/mvo8+5E5Bo9og7rtQVKZyHW4qk1ClOjBivsaIiZo/SP2o
        qJLnTFgdpfw7oKcE3YHoIzVuc1BOVefGCpYcHHFUHnA==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr12689316ejj.711.1646726970628;
        Tue, 08 Mar 2022 00:09:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvyuR3mb0kzIzmDG7xL2Oq1O5GTZ5RmEqTaJMl1TSRoKLAqTby19CSrJRxPUdjCfrfwqyzaw==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr12689291ejj.711.1646726970318;
        Tue, 08 Mar 2022 00:09:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 6/8] tty: serial: samsung: constify s3c24xx_serial_drv_data members
Date:   Tue,  8 Mar 2022 09:09:17 +0100
Message-Id: <20220308080919.152715-7-krzysztof.kozlowski@canonical.com>
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

The driver data (struct s3c24xx_serial_drv_data) is never modified, so
also its members can be made const.  Except code style this has no
impact because the structure itself is always a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
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

