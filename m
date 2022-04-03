Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC34F0B1C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359344AbiDCQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiDCQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:12:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A352B2613A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:10:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qh7so5309153ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GerM7K1QlzkK570Ne5mxP4j5BtuMq64KksJorrc+3FU=;
        b=XqDN8Z6d/ouufz75zZ7xmKBDt9yCWbq8SF9trZxvr46jz1jBPcr9jNdXJGAu6muIIM
         CPu4Me/Tq9/0ztqiHi2GzDBICWZV+sGchSt/7gayfNqtpE9IdpmsM+KIhJqJB6IbuqFT
         9zqgTy2Q+h2/sxut0KXexu3XOzxLWW5SHtWE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GerM7K1QlzkK570Ne5mxP4j5BtuMq64KksJorrc+3FU=;
        b=bAsm9r7cV1ePCpQ0INNRP3Xb6Y1XRBN4UZpBKrMqHuIv2Jw7CaGtuf6vMprhjSykuH
         K16Lr5GoLdbjhN4guvcdOFQWJ7ooZZo4vJ6Lc7qkiPQi9xuitQcHpVdomhdncSBd5qN/
         5xYsn8oTF3wQ/chSMGHRyCfFdisb2RZFWOhKK3KPaa/obvzpdXpgdAwcCIIqr2gKpgWn
         CWvVVYFU0uQTSGrZTdSDx2IAm73621/MQIwgwvozAp9vWpAd5Zgzp69QIjb0cVxR3Awh
         qjPQXPnDcyD4R0X4dUv9ey3mwzOluQNrh7fknjsPNlnRWtLwN6pSCUdLd3T31MEczhxx
         OI5A==
X-Gm-Message-State: AOAM532sVzql0FRXPswIfGFvoAJPfW0eOsn/Oc5MkFAYmWXCbXZQq60h
        06RXVh+mT44DZsuRa8+XZx+Q6VsLsZP9og==
X-Google-Smtp-Source: ABdhPJwyHq31GeXgzY9nG8s7qLw09zTYTNofyHIMncc0oDHC03jsbGrQwxs816K2Imz4ez3c9HwCLw==
X-Received: by 2002:a17:906:af6b:b0:6df:83a9:67db with SMTP id os11-20020a170906af6b00b006df83a967dbmr7681986ejb.222.1649002208874;
        Sun, 03 Apr 2022 09:10:08 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe2af50d8sm3350119ejc.121.2022.04.03.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:10:08 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 0/6] Input: edt-ft5x06 - Improve configuration
Date:   Sun,  3 Apr 2022 18:09:33 +0200
Message-Id: <20220403160939.541621-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series was born from the analysis and mitigation of a crc problem
raised by an M06 type device. The added sysfs attributes were helpful
in debugging the problem. Patches that change the report rate on driver
probing, mitigated crc errors on kernel bootup. The patch to get/set
report rate by sysfs for an M12 device, has been tested.

Changes in v4:
- Add Rob Herring 'Acked-by' tag to:
  * dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz

Changes in v3:
- Add hz unit suffix.
- Add '|' to description.
- Check the lower and upper limits of the report-rate-hz value
- Convert the M06 report-rate-hz value

Changes in v2:
- Add Oliver Graute's 'Acked-by' tag to:
  * Input: edt-ft5x06 - show model name by sysfs
  * Input: edt-ft5x06 - show firmware version by sysfs
- Fix yaml file. Tested with `make DT_CHECKER_FLAGS=-m dt_binding_check'.

Dario Binacchi (6):
  dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
  Input: edt-ft5x06 - get/set M12 report rate by sysfs
  Input: edt-ft5x06 - set report rate by dts property
  Input: edt-ft5x06 - show model name by sysfs
  Input: edt-ft5x06 - show firmware version by sysfs
  Input: edt-ft5x06 - show crc and header errors by sysfs

 .../input/touchscreen/edt-ft5x06.yaml         |   8 ++
 drivers/input/touchscreen/edt-ft5x06.c        | 103 ++++++++++++++++--
 2 files changed, 103 insertions(+), 8 deletions(-)

-- 
2.32.0

