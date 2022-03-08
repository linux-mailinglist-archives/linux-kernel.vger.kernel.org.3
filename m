Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F794D11A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiCHIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbiCHIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031D3E0F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:23 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4BA83F4C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726962;
        bh=/d+cuTswHRfObofzKWlwwKYoIDQbzww/xiphIp91T7k=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JQYDH4O/5ePgzf4QoE7pjk0iuIl01btcpLqQts5lOlIzFTU7iwAe0qGMQLl8gYFns
         jBE+IGdgeaOrwjMob4aSqmtFGYv4pYoCvHL9irn38IZq+kRsJlgpZ/WIxs9MZXPa2X
         4B/4Gv8xBo3WkOg/0G+hhu5YINEjNTkhvfE8uPItnt83X3Hbj5a1fXX1gg7Qi2k4LM
         jWFEEMdVOoQjZ608wV/9mZsip8yYEB2uV998Y5kXiFOTfKn/xyRrU2LfxBXPr7mfYF
         8u+I2FDbBZss+moIT8DoQ1vqySu+L6Y65FQEmzWuXJaOm5w/KVpdzu7IvORnLHa8K+
         0gnOeUbiVm+bQ==
Received: by mail-ej1-f69.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso8265218ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/d+cuTswHRfObofzKWlwwKYoIDQbzww/xiphIp91T7k=;
        b=DLlASTI+JUao+14X+Xt3DyjaAk4frlJXRxQEn4Tw57/9koSng787yQW0VQbtNddUiA
         bSJWq3a84WfXELjBpAh1HTBYeLTGHkS/s0bqIPX3DUplFifzAmSTies/FTMxdclvmEh3
         ixB2HCo0ns760tXK0o7rY4upgRkMhmySNmrc56BVOgSo28Pb6tj2LuC/7udVBnj7MKwI
         Odwqat+LTlJ2PcozgzZ38eGDkt/K6A1otfvkH2OBDzk6Yhddfiulj8jLk01Y7Jkoh9mj
         ZkesHgK/om1IVJApH8+4Lw1d1hp3UDDcj9kIYvdfRGGVK5hXYB6uHCfJBwYdj7Tq4riF
         fspw==
X-Gm-Message-State: AOAM5321++xLnR0TCahzx+dJfvSnCm9unyrsegNHqPNBBrZKe+Risszw
        87Y8mDMXMSeEvw79wi25wjwJj28QkRas6CSuzFQHU3iCn4AgFicVuT7g3JhXxJolpjeI0uZJpXs
        mPnqjgAqMiww34QamRX4dJVYF2pPNtO4CYo+sYfJabw==
X-Received: by 2002:a17:906:7245:b0:6cf:d3c6:8c63 with SMTP id n5-20020a170906724500b006cfd3c68c63mr11721622ejk.677.1646726962243;
        Tue, 08 Mar 2022 00:09:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJPHLp6T4YFWmBiyeFGtCdgDPQn1ALmFmvSZMWVXgp434TU3oTrRtaUyzLLRSlPxfGODwAEA==
X-Received: by 2002:a17:906:7245:b0:6cf:d3c6:8c63 with SMTP id n5-20020a170906724500b006cfd3c68c63mr11721608ejk.677.1646726962084;
        Tue, 08 Mar 2022 00:09:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 0/8] tty: serial: samsung: minor fixes/cleanups
Date:   Tue,  8 Mar 2022 09:09:11 +0100
Message-Id: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
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

Changes since v2
================
1. Add review/tested tags.
2. Use dev_of_node() (Andy).
3. Split cast-removal to new patch 3 "tty: serial: samsung: reduce number of
   casts" (after talks with Jiri).

Changes since v1
================
1. Patch 3: remove unneeded parenthesis and module alias change (Jiri).
2. Patch 3: move unrelated "constify" bits to patch 6.
3. Patch 5: fix typo.
4. Add review tags.

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  tty: serial: samsung: embed s3c24xx_uart_info in parent structure
  tty: serial: samsung: embed s3c2410_uartcfg in parent structure
  tty: serial: samsung: reduce number of casts
  tty: serial: samsung: constify s3c24xx_serial_drv_data
  tty: serial: samsung: constify UART name
  tty: serial: samsung: constify s3c24xx_serial_drv_data members
  tty: serial: samsung: constify variables and pointers
  tty: serial: samsung: simplify getting OF match data

 drivers/tty/serial/samsung_tty.c | 225 +++++++++++++++----------------
 1 file changed, 108 insertions(+), 117 deletions(-)

-- 
2.32.0

