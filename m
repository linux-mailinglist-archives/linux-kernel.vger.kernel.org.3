Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330656A8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiGGQ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiGGQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F6B86B;
        Thu,  7 Jul 2022 09:59:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so18413260pgu.9;
        Thu, 07 Jul 2022 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur2SMpGF3lpcKS5cVDXDzlMKPuUxkl+HJdr22eYxiH8=;
        b=JfTdS+QSCovVQYXsXhxjTUfU6BeTrNLgDp6raooDdEAuB8LZxKiJudxfu/NEvDIWlT
         2R3+Zh5TlVc1nl/zhOS9DZYPY3ITXazE7qvOGpSnOPhJAAzThH66Eafbshk7dlycKf4r
         3p6nC5IAULGoUUbDbQ7Dn62OSzzHOCoWSyE/hpLZn8POaIRApYHatnSvy1Jfyaar+irD
         /R5k8lSzv/iSgYeER9ZWJqmq4QSgCNq99Jgar7jQtieMcOoZDVmTnKdm8G262wlTBR+l
         Wj618LyvvuzxauOgKaL5z3CrDdbzriqweMgmynJSEhXLF4RIuo/tvJbkuqf70MKg9b5i
         jqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur2SMpGF3lpcKS5cVDXDzlMKPuUxkl+HJdr22eYxiH8=;
        b=AblbSTOnj1ISFf9PvEAc1+IlDuU7hW/w7pJovxb81/H24iFJi+OD9aBi9TrBOTdmf+
         dUxVm1UGXFTkubr2ohevqnUNgiE63ftVhK/QXV6IeerjtxtnV0qgI1Y+TN7t9E+yFGah
         zgfE5Db2gfSyPRGgszCL5u0jOVVtCzuXfE2hIlusk2rPpWOdGwFPFa3HYxwC99PK/5oc
         r+XZ2gOAMHF2NxkEB7RjIJ2WsO/52jRqgbFc6fs6+3RzJ1XdiYImd1WkBrRNLIQayKzt
         0V/vIZKH8ZqDio8oJfjY68hfCS+Q/NvpMloBCJEpoGLWzvtDMuTUVCKdAHyXaazV6tiH
         VCkw==
X-Gm-Message-State: AJIora/SgP5fkVHtG9P9xlicgr42A0yzFYnMJcf8EMgK+JcpBc/VV9Te
        eX3MmyVCzGX9XqszXLXrB47lHe1vx0BxWA==
X-Google-Smtp-Source: AGRyM1v47xvyyZ8jUF9j/bSsYWlL0WqSZx4JkF1dpPDFeLq/iPlXoJx8ryDs6MjjUBV6opXRoZxJeQ==
X-Received: by 2002:a63:734c:0:b0:40a:88ed:dc3b with SMTP id d12-20020a63734c000000b0040a88eddc3bmr39296930pgn.244.1657213162740;
        Thu, 07 Jul 2022 09:59:22 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:22 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 0/6] Add spi-hid, transport for HID over SPI bus
Date:   Thu,  7 Jul 2022 09:58:56 -0700
Message-Id: <20220707165902.3184-1-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Surface Duo devices use a touch digitizer that communicates to the main
SoC via SPI and presents itself as a HID device. This patch's goal is to
add the spi-hid transport driver to drivers/hid. The driver follows the
publically available HID Over SPI Protocol Specification version 1.0.

The specification is available at
https://www.microsoft.com/en-us/download/details.aspx?id=103325.

In the initial commits there are some HID core changes to support a SPI
device, a change to HID documentation, HID over SPI Device Tree
bindings, and finally the SPI HID transport driver.

Dmitry Antipov (5):
  HID: Add BUS_SPI support when printing out device info in
    hid_connect()
  HID: define HID_SPI_DEVICE macro in hid.h
  dt-bindings: input: Document Microsoft G6 Touch Digitizer
  Documentation: Correction in HID output_report callback description.
  HID: add spi-hid, transport driver for HID over SPI bus

Jarrett Schultz (1):
  Enable building drivers/hid/spi-hid as a module

 .../input/microsoft,g6-touch-digitizer.yaml   |  135 ++
 Documentation/hid/hid-transport.rst           |    4 +-
 arch/arm64/configs/defconfig                  |    1 +
 drivers/hid/Kconfig                           |    2 +
 drivers/hid/Makefile                          |    1 +
 drivers/hid/hid-core.c                        |    3 +
 drivers/hid/spi-hid/Kconfig                   |   25 +
 drivers/hid/spi-hid/Makefile                  |   12 +
 drivers/hid/spi-hid/spi-hid-core.c            | 1326 +++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h            |  188 +++
 drivers/hid/spi-hid/spi-hid-of.c              |  141 ++
 drivers/hid/spi-hid/spi-hid-of.h              |   30 +
 drivers/hid/spi-hid/spi-hid_trace.h           |  194 +++
 drivers/hid/spi-hid/trace.c                   |    9 +
 include/linux/hid.h                           |    2 +
 15 files changed, 2071 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
 create mode 100644 drivers/hid/spi-hid/Kconfig
 create mode 100644 drivers/hid/spi-hid/Makefile
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.h
 create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
 create mode 100644 drivers/hid/spi-hid/trace.c

-- 
2.25.1

