Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC84CCF97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiCDIFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiCDIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:05:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387B125514
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:04:12 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 711A43F5F5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381050;
        bh=rlX9LT2Ku3zafWWNfSgPawKn9LilfNFaq1DtAqUhXpM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dtsHTDX9flbhuXj8NHivyMW3Z1q/30OtO3SR5JW/BKH+TtEkRYFaNqzRilJCVui8y
         I92T6UsU7ywcnF9cEBMTLqGgoxGcavAyPyjSUuuS9Plf/c7NS5MkvUQgOfLtP7T+Je
         n8hsf566Ky37oxIPzJZvspw9j8fUDFHss+fumrdSOh9NhPRh5sv46MxF2V1Sot5Yzp
         eltQsyTYRhsRUqTR9+ipE7zFp1ooQ5+0v7afB5oQN3lAs34febe/cDoeVwWqTeLrij
         7xl8eaCKv14SVQVwbzkOOzmUhTRwNIJ292E+rFYhIRL+XkZF9OV/IEcpz+PqW/4Nlc
         uXxMjRHgS87Nw==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020a056402344e00b0041593c729adso4202792edc.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlX9LT2Ku3zafWWNfSgPawKn9LilfNFaq1DtAqUhXpM=;
        b=lVuw8Ksw4J24W4K4/I47Sab+9cUjT34NQZOwmBQcKSv8ZEVMUDIT0UriGTS8bLKjOH
         yv43H8xN4I1FNcp7K5XoCZVGAkH5P7F2ijPJiZlBXnCYpK3E1QsUTip76/cHxgTZ8ohe
         KfJl2o+jLLTjhQDBttVz5vHYkYitgR/zSl4G7D+pssNnQKIsscfrxF4tYQyvuosIPoDb
         X0eCkwh55qBS8rtFzspEv064/2N6mka33sGs1cz5EEOo2LgkE4LPfJrEpWNeIn8BOnTv
         0O1AtTLVAGq7zX/Od7w6SfTDqhuXKpc0KkC/9mTgAg8nbuwZLaZ94kLUHx7OZ8Zowg+1
         iFAw==
X-Gm-Message-State: AOAM531DbMkQx4NfGWgrxYs37yiSOxlx5oSN3IbDWxBxVPgUqdeXwDgs
        +JWtOuyUmYSfp7qZpt2/3i8HNz4kndswKpKRUB4/b2pTFPYkvMhdC0PKA4Ku+1L9ziv3QnRxnky
        WCphY/UF2MrAE056cSiJxJFMePXhRACblZLU1MEhvAQ==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr29023909ejm.70.1646381047109;
        Fri, 04 Mar 2022 00:04:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9NTQ5aaCe/mw4aEV5jifd4tz1CDgIbNknK5DSvctYEEFyUW63B8TVoeIxQGRv9fsptQj8Sw==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr29023896ejm.70.1646381046879;
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] tty: serial: samsung: simplify getting OF match data
Date:   Fri,  4 Mar 2022 09:03:48 +0100
Message-Id: <20220304080348.218581-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 00e7c34fad46..76f7afd1b7f7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2150,23 +2150,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 /* Device driver serial port probe */
 
-#ifdef CONFIG_OF
-static const struct of_device_id s3c24xx_uart_dt_match[];
-#endif
-
 static int probe_index;
 
 static inline const struct s3c24xx_serial_drv_data *
 s3c24xx_get_driver_data(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
-		return (struct s3c24xx_serial_drv_data *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return of_device_get_match_data(&pdev->dev);
 #endif
+
 	return (struct s3c24xx_serial_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
-- 
2.32.0

