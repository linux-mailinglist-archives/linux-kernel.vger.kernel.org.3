Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359E4D11B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbiCHIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbiCHIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291C3EAA9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:30 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F1F33F7E0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726969;
        bh=29Pf3ZsU5JJVOHBIO1WRfRouMVWJymQOmYuJyfmZYy4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LkfbNmA9Vjt18uCAYkD/pVLrecoVDZlQhW5ah475s/GQnogj6tnEjYQ6nHpDib1X3
         R3473N8FT7FF25HiCF7EMiaMW6GYb2rCOMD99DeNX7sxtMEEGck8lzy7sT5Q3vpxBI
         XpwVT0ILex4z0miDeiAXMaognDhTvvCh6Za3ur3q8nAHkbimbx6oDPLOrHBm/uPr/A
         FAlsUBQA2n30Pq5et4NQzOgBQh3/2PWjbNK7MkxTLiLz3HpdqfNd4kkvD7NbRB7dl9
         IbuMAczN6X4DYZi8g9FL42hBwyVVENMDDSSZby3uCMcI2qOufJ7M7nnCTPFuV9pVTh
         irARfJ5mM/3+Q==
Received: by mail-ed1-f69.google.com with SMTP id co2-20020a0564020c0200b00415f9fa6ca8so6664726edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29Pf3ZsU5JJVOHBIO1WRfRouMVWJymQOmYuJyfmZYy4=;
        b=BdqzbuAV0tId1XXSzZ0pSMFs3+FR9V6mODeSQNtfM7li5KO3KT1aN2tBcYogweRDkR
         PgXYijySKvWw/2RVJVrJGLyhS/0NtwfwQ9FhJ7l7GafX4GIjp82sO+QMmBdnU1PIl58H
         QopdYtzUOoNnaTEE71xbZ4QqBXI6Tq5ZfooRDQrJzhIxjU8nbQ9/LwNWr5bjZ2MY61nD
         5rKBAQXJQyJ2l93UiQEp09Vm/QihXwj+Jpeu/R5mLlHR8S0mYu4kSG9q6ydtjr8lAcQn
         Kozxo65x8qsnD23dBM/09uRXc8CVkfKVJ69LylztW4RvBky53m0vfzVDaIV7d7tU4HDb
         Pf6A==
X-Gm-Message-State: AOAM533cXpVHHNLNUT0ra90HLYAUsp+LQD2v+LJq0q6ZpKW9o1UUKiz6
        NO/ElLvsX+IwAht4FPkAYhHv3oHhfi12IJ8olRrL1O8+Z5ilj5Uu2cGK2mYkIsUVoBbIUFR4aCo
        dQiQIcrbPXL0nfEJSgXOULNOwmRr0moS/FlLdn/S5rA==
X-Received: by 2002:a17:906:9bd7:b0:6d6:e920:8d04 with SMTP id de23-20020a1709069bd700b006d6e9208d04mr12389916ejc.547.1646726969067;
        Tue, 08 Mar 2022 00:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCDpyzVeafJO+tBKmLNUmXCUwu/pvO8ES0IOzwYdYS55Y3KidkwCIqb81SC/LBMvb5FhouCg==
X-Received: by 2002:a17:906:9bd7:b0:6d6:e920:8d04 with SMTP id de23-20020a1709069bd700b006d6e9208d04mr12389895ejc.547.1646726968858;
        Tue, 08 Mar 2022 00:09:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 5/8] tty: serial: samsung: constify UART name
Date:   Tue,  8 Mar 2022 09:09:16 +0100
Message-Id: <20220308080919.152715-6-krzysztof.kozlowski@canonical.com>
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

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4b13f2d6e26..7025306f76b7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

