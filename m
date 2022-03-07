Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E684CF334
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiCGIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiCGIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:09:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B456193DF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:08:22 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04DE53F1AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640500;
        bh=sgZCTz7Fe6W/u7IUGDX3n8sJGTarRFqwDIQ3hjVamCE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ghgUsNvLjgsus3AVIMaFAkceDtclOALfRxRijDuFqVHy5YfwfjtblhHfWYiWTZ6eY
         VRXyKio1v42ZE47czzR3RTBcK+qku6yp7avag/mtCC8/cVKUYPNdfJjiSDTLpfo8e8
         dVlp89uF/3Ti5ijMRubtxvny8HZzQbMfJNwlmenKdMOGebYK3hmQWnpIqvrnBpISbF
         qJqYTrgvF844dmr2EeGyAtNbkqFLp1dOIXBrrhQQHk/fIsMTi+9b5ZsnvJ1nu8sdqp
         0zLcV1ad9CuUJOXNUWWRs1uxOOP/hbUD9IpHM4d3KxmLKOeML0vgeNDr1+1SO4sZ9I
         u7+LKgyxVYF8w==
Received: by mail-ej1-f71.google.com with SMTP id og24-20020a1709071dd800b006dab87bec4fso3154407ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgZCTz7Fe6W/u7IUGDX3n8sJGTarRFqwDIQ3hjVamCE=;
        b=nbInAKXAplRLvdRKiB6iQM/aUzYUDbOmIA8ShPFPvhi8qkC0xD3TYHkPYgHB+vWTM8
         yqwu0R3QPXN0N22e3MdIbRI4PJhJ3VI20dpzq48cbZjDpoxxqCLHtb38g/70JlHvFuHa
         eXJQj5OmEu8MQzL9DwZW2i93ettDe9ZHm3lQxd5W4lKFONLCrLE/R0rmA/NFXL4QuEEV
         ClYyU1nI2Leakp9UrNnhjtUkHL0Qo2ls2tZWlr5JQKwgFprJbqe9W+OhMzmOHlAdkHQ1
         Dbq1n86BnP0+ea8yi/kTF1WpoN/zv2wzL3QIBDAvnF2bu+5+5o7LCzwoIawA6m1CzVm5
         Ebhw==
X-Gm-Message-State: AOAM532bw3svKs/umTizIjjOtpTOfEEYALBuRBT/Oa/u4dVvqjNP7bWR
        g4iZvb05f1F5nVFPp/uGNrIZ3eFMIEugLVYSq2vLAcZzAfGpbAUSpUR8qMQOOSemHUuzTvi/KgT
        w11aqFbCi+KMKJ6t3XLenbYXm47A7UhYxo6vRZsl4lg==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr9937654edu.112.1646640499307;
        Mon, 07 Mar 2022 00:08:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKrQ1hAkY0V7VoNi5tDyMXCwOUq6E52GbFcMd0p9HOHtzn/DMrzsm+17bd370phdDA20dUhw==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr9937636edu.112.1646640499158;
        Mon, 07 Mar 2022 00:08:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm4444584ejc.26.2022.03.07.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:08:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] tty: serial: samsung: minor fixes/cleanups
Date:   Mon,  7 Mar 2022 09:08:03 +0100
Message-Id: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Hi,

Changes since v1:
1. Patch 3: remove unneeded parenthesis and module alias change (Jiri).
2. Patch 3: move unrelated "constify" bits to patch 6.
3. Patch 5: fix typo.
4. Add review tags.

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  tty: serial: samsung: embed s3c24xx_uart_info in parent structure
  tty: serial: samsung: embed s3c2410_uartcfg in parent structure
  tty: serial: samsung: constify s3c24xx_serial_drv_data
  tty: serial: samsung: constify UART name
  tty: serial: samsung: constify s3c24xx_serial_drv_data members
  tty: serial: samsung: constify variables and pointers
  tty: serial: samsung: simplify getting OF match data

 drivers/tty/serial/samsung_tty.c | 225 +++++++++++++++----------------
 1 file changed, 109 insertions(+), 116 deletions(-)

-- 
2.32.0

