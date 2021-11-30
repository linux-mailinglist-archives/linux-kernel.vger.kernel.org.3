Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC87462A54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhK3C0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhK3C0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:26:12 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE7C061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:22:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z8so38165883ljz.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skodrfetI6sQYeMS84TqmzdXMiAWMy4xHtCAByWVHFI=;
        b=bbVlySitNulojxKNQQ8ngwgYFkULqgbWWmRVoRSk3H8bMyFfkSoSLBJgHIWIfGbDgu
         iFCTjlBS3fcCA0S0un3T2LwZic9OyCDZtw5Jokcyj99g1178UlQBzzjLjC2uXINhJiwP
         MeSAm6xWoK/aXDNmHlPoYb37Xavs+6DlD0ScFYO+zALf06yEgEcRKFF78jyarpF1CGZ3
         s+90ffS3b2yUK6ZuHhdQUEUclTwrxcZvSNFD6rznZ7YARbHw7vg487xzvs0Ova2XxYFi
         V3K4D9W+qsY8K343GvJjmUFbxHXza3W/m6c6QCpLwSMgLZu0+F/GaIalUos5uc9QyxA8
         t7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skodrfetI6sQYeMS84TqmzdXMiAWMy4xHtCAByWVHFI=;
        b=u4C8Y4sli+xM+JdvFKXeHY9ZWeaUZMDOZ9Wg0ZDva0Czpyyq6nt7i4OxkjJ1NN9GZN
         ZsxFYl8M7WHvY3syKUFHmXgs0BMPkuVQIzUJifUspffeQrP7gnshxTXNxvU4grKOsqGc
         Ew2+AYlep5biirrXCtnPCjgOSXhocnY4qCuhuNVQcbHLAbpOUyn+Si3pY+Em3asyQDBC
         y5LEUhXs9O09Rkdu3O+bU4uWL77YMVkvuGMcsA/hK4gXHOxFugF4ZVPmP77Pz1kxB/Y3
         vS/q/Vw6wAE+5/gUSrLgvlNzHugaSRE7hB33NftqjYqkIJH6L9FclRRfuHH1u3E1qqAu
         rrCQ==
X-Gm-Message-State: AOAM532Gg/eyT4TiWJjBprlmpW33Rs3qK5rslZAauaxXD91Lu1OAAmUM
        78qEZSA9dM1EZd+8SNqdp/un+g==
X-Google-Smtp-Source: ABdhPJzbQjHPWKFGyNsFRwbVGmhUdKhSrsWJwMsK/Qyy5iQbpNmLx265oR/zw1HBJOxgDvAso0jIwQ==
X-Received: by 2002:a2e:b816:: with SMTP id u22mr32739595ljo.51.1638238972342;
        Mon, 29 Nov 2021 18:22:52 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id e11sm1539911lfq.65.2021.11.29.18.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:22:51 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/5] soc: samsung: Add USI driver
Date:   Tue, 30 Nov 2021 04:22:45 +0200
Message-Id: <20211130022250.28519-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USIv2 IP-core provides selectable serial protocol (UART, SPI or
High-Speed I2C); only one can be chosen at a time. This series
implements USIv2 driver, which allows one to select particular USI
function in device tree, and also performs USI block initialization.

With that driver implemented, it's not needed to do USI initialization
in protocol drivers anymore, so that code is removed from the serial
driver.

Because USI driver is tristate (can be built as a module), serial driver
was reworked so it's possible to use its console part as a module too.
This way we can load serial driver module from user space and still have
serial console functional.

Make it impossible to build UART/SPI/I2C driver as a built-in when USIv2
driver built as a module: USIv2 configuration must be always done before
tinkering with particular protocol it implements.

Design features:
  - "reg" property contains USI registers start address (0xc0 offset);
    it's used in the driver to access USI_CON and USI_OPTION registers.
    This way all USI initialization (reset, HWACG, etc) can be done in
    USIv2 driver separately, rather than duplicating that code over
    UART/SPI/I2C drivers
  - System Register (system controller node) and its SW_CONF register
    offset are provided in "samsung,sysreg" property; it's used to
    select USI function (protocol to be used)
  - USI function is specified in "samsung,mode" property; integer value
    is used to simplify parsing
  - there is "samsung,clkreq-on" bool property, which makes driver
    disable HWACG control (needed for UART to work properly)
  - PCLK and IPCLK clocks are both provided to USI node; apparently both
    need to be enabled to access USI registers
  - protocol nodes are embedded (as a child nodes) in USI node; it
    allows correct init order, and reflects HW properly
  - USIv2 driver is a tristate: can be also useful from Android GKI
    requirements point of view
  - driver functions are implemented with further development in mind:
    we might want to add some SysFS interface later for example, or
    provide some functions to serial drivers with EXPORT_SYMBOL(), etc;
    also another USI revisions could be added (like USIv1)

Changes in v2:
  - Renamed all 'usi_v2' wording to just 'usi' everywhere
  - Removed patches adding dependency on EXYNOS_USI for UART/I2C/SPI
    drivers
  - Added patch: "tty: serial: samsung: Fix console registration from
    module"
  - Combined dt-bindings doc and dt-bindings header patches
  - Reworked USI driver to be ready for USIv1 addition
  - Improved dt-bindings
  - Added USI_V2_NONE mode value

Sam Protsenko (5):
  dt-bindings: soc: samsung: Add Exynos USI bindings
  soc: samsung: Add USI driver
  tty: serial: samsung: Remove USI initialization
  tty: serial: samsung: Enable console as module
  tty: serial: samsung: Fix console registration from module

 .../bindings/soc/samsung/exynos-usi.yaml      | 135 +++++++++
 drivers/soc/samsung/Kconfig                   |  14 +
 drivers/soc/samsung/Makefile                  |   2 +
 drivers/soc/samsung/exynos-usi.c              | 274 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/samsung_tty.c              |  78 ++---
 include/dt-bindings/soc/samsung,exynos-usi.h  |  17 ++
 include/linux/serial_s3c.h                    |   9 -
 8 files changed, 483 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 drivers/soc/samsung/exynos-usi.c
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

-- 
2.30.2

