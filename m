Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C15150D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379082AbiD2QbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiD2QbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF30D8933
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l16-20020a05600c1d1000b00394011013e8so3881752wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzbjTt7bbaGoTgd9BBuYVRvUmfXJe3pDmlsm2tqGi2c=;
        b=htlKlFrXq5VjQhL6nAA032ZZ1G8zLlLaKOnZMmvZsO8cjX3KfpvA++e4oWPgWAY+pU
         MlmjKU5TgwwJZoR4tzVvvI2UqiepBvdJZbIXzklIA5LxTyBhkyiM6u5j+50evEA/meqN
         LPs8Ss7SvqeiP7PeuuX7KfeDMLVl2+KXUfjy4UB+Ak8RTdvm8slWbawu4uRIRDNCZAJ8
         0ln6cE5VrPa/Hkdm//sdikOVsztAuD4/VekePIKkw1X5Z0rK/uBBmH1NjSBRhCFToypo
         BQJrM6/HIkGKXf00FScUWUND5CMvRH3jFnbK0UqiSffjra+XEX2MwqZy56Q/MLm9ubX9
         rxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzbjTt7bbaGoTgd9BBuYVRvUmfXJe3pDmlsm2tqGi2c=;
        b=ml9nk1/LDNdjHdPfdplomAVnHObA02we6Bzkrtwa8LP7c66Wkw+JzzSWhjOTJNkYAF
         AR3qWidlHSK6I0EQIyVsqkwB4Mndh5NuBdYPrJFGszr5GtvL3EJ/lMFCe9CRyVOhdfzA
         JfnyI9G3PgMcZtxipL6Ak7xB/qMHIJ10sT15U0pXbmpx0Q5gqoOT5c9OBJgjqLLNtslB
         g93EFV126L3nZGbPZNMnT9fQlHzIizeefSaEjNU4hUmRXzg7A9mxWM4UDZod63AnyQ8y
         WQZFlbJqS9phzqohyfWyqE14FSPlhC5VybFf1lDU6Vv/BeVrGfbSqUuUrQstt0o8+Zjr
         iIwg==
X-Gm-Message-State: AOAM531LQyT6R9JJdc3fRWGYNgdGNxb0Zs8fVJbms8qEgEiiQwmUkwog
        TFMhlpydPcuDoneI00i2fNzO1Q==
X-Google-Smtp-Source: ABdhPJxXy1NKJdfdibqvqIfsIZUkzIHVr3DZelgDIH9x57u0E5vDWMetV3zGMfajKykECPLEy85nTg==
X-Received: by 2002:a05:600c:1d0b:b0:394:1e75:1fef with SMTP id l11-20020a05600c1d0b00b003941e751fefmr4033054wms.5.1651249671871;
        Fri, 29 Apr 2022 09:27:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/16] nvmem: patches (set 1) for 5.19
Date:   Fri, 29 Apr 2022 17:26:45 +0100
Message-Id: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.19 which includes

- new nvmem provider for Apple efuses.
- support for regmap and TA 2.1 devices in sfp provider
- add device tree node support in nvmem cell info
- brcm_nvram provider to parse cells from dt.
- few minor clean ups in qfprom, bcm-ocotp and sunplus-ocotp

Can you please queue them up for 5.19.

thanks for you help,
srini

Dan Carpenter (1):
  nvmem: brcm_nvram: check for allocation failure

Krzysztof Kozlowski (3):
  nvmem: bcm-ocotp: mark ACPI device ID table as maybe unused
  nvmem: sunplus-ocotp: drop useless probe confirmation
  nvmem: sunplus-ocotp: staticize sp_otp_v0

Minghao Chi (1):
  nvmem: qfprom: using pm_runtime_resume_and_get instead of
    pm_runtime_get_sync

Rafał Miłecki (2):
  nvmem: core: support passing DT node in cell info
  nvmem: brcm_nvram: find Device Tree nodes for NVMEM cells

Sean Anderson (6):
  dt-bindings: nvmem: sfp: Fix typo
  dt-bindings: nvmem: sfp: Add clock properties
  dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
  dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
  nvmem: sfp: Use regmap
  nvmem: sfp: Add support for TA 2.1 devices

Sven Peter (3):
  MAINTAINERS: Add apple efuses nvmem files to ARM/APPLE MACHINE
  dt-bindings: nvmem: Add apple,efuses
  nvmem: Add Apple eFuse driver

 .../bindings/nvmem/apple,efuses.yaml          | 50 ++++++++++++
 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 30 ++++++-
 MAINTAINERS                                   |  2 +
 drivers/nvmem/Kconfig                         | 13 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/apple-efuses.c                  | 80 +++++++++++++++++++
 drivers/nvmem/bcm-ocotp.c                     |  2 +-
 drivers/nvmem/brcm_nvram.c                    |  4 +
 drivers/nvmem/core.c                          |  1 +
 drivers/nvmem/layerscape-sfp.c                | 36 +++++++--
 drivers/nvmem/qfprom.c                        |  3 +-
 drivers/nvmem/sunplus-ocotp.c                 |  4 +-
 include/linux/nvmem-consumer.h                |  1 +
 13 files changed, 211 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 create mode 100644 drivers/nvmem/apple-efuses.c

-- 
2.21.0

