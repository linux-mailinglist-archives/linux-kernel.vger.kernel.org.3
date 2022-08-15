Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDA592953
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHOGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiHOGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:11:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B218B12;
        Sun, 14 Aug 2022 23:11:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f20so9381786lfc.10;
        Sun, 14 Aug 2022 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IPypJTi2oPAJPrH9pG0Plh2bOzEqGN21LURLxGfIVec=;
        b=RP7iM+fDqMuju9+XPWPVzZ6h2kd3J3e78JglAMrVdjO/vLq/cuD8em5EmgLLw8a9Z+
         J2oNQtAsFVuUTLfwnVF/2YPpTyKHiuvtsboTCQRCGKHJsY/Ltmum0Z4lr0eartLmI0r4
         gpdtif06typhwxx7PdUFtntpqMpjVn5/QaVhmtUztfIqEwqJ8RLLz4Ci2YY386SRD4IA
         7TztQogw7Im1rtD9fkbUBIPBUYFTvxla/32WpPcNiivDWvp0o9Pgu2k3C+SCkAkDBY8u
         ue/wSiQOyArKjBrSpJ9oKHmBtyZUzT+PLGrG6mTk7Un6XKQMIxMQe32CJ4n5SzX/ExVo
         4CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IPypJTi2oPAJPrH9pG0Plh2bOzEqGN21LURLxGfIVec=;
        b=E265usZVb2KlFD0G9Awa9QSMW7VNt9q01jKDlx48UszAdVdX7zgFmcT8FHJx4T4w5Q
         siOA6C4lTtSjwlBW1jOuzTnyR4+6WwnQUKfMl0Z38OGBLmnoBgak4O2nbEe+v7aj5uUt
         XR3oZtK6MPZo5mEFQan80ysjjbDsnXSvDZGKtvGaXq8HGoGhF63phvCfts9F72nndNbb
         ov1zcHEJKjCi0D1nyuJC+fRyiSSOrzc0SKNaXC+NHYBFoRpLKA4O6d1UH0NceJU1OSIE
         2UYPDVxxsUJG9GP4STb3VykoFHDR8scAEXI8gzSA5R+34FcTlWND9zNlVoRhXXunVJyO
         c55g==
X-Gm-Message-State: ACgBeo3hqd5DUhNqQ4P2XuOd3aCcCgSYNrY9Qauzx5qisE2Uq8hxz8Dy
        /MU+ZC1ZOeo7O7mH+2rFjcY=
X-Google-Smtp-Source: AA6agR71MRzZu9tuJAu2z4teJ2IaPQlIDv/Hg8CbJfdj9hPQcwpQDJZ7JvVU6Eh98P16slTZeEGyhA==
X-Received: by 2002:a05:6512:930:b0:48a:a0b9:8dfc with SMTP id f16-20020a056512093000b0048aa0b98dfcmr4660191lft.45.1660543907559;
        Sun, 14 Aug 2022 23:11:47 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:46 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] Improve MCP3911 driver
Date:   Mon, 15 Aug 2022 08:16:16 +0200
Message-Id: <20220815061625.35568-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This patch series intend to fix bugs and improve functionality of the MCP3911 driver.
The main features added are
- Support for buffers
- Interrupt driven readings
- Support for oversampling ratio
- Support for set scale values (Gain)

Among the bug fixes, there are changes in the formula for calculate raw value and a fix for mismatch in the devicetree property.

Another general improvement for the driver is to use managed resources for all allocated resources.

See patch notes for more specific changes.

General changes for the series:

v3:
- Drop Phase patch
- Add Fixes tags for those patches that are fixes
- Move Fixes patches to the beginning of the patchset

v4:
- Split up devm-cleanup functions 
- Cosmetic cleanups
- Add
	select IIO_BUFFER
	select IIO_TRIGGERED_BUFFER
    To Kconfig
- Add .endianness = IIO_BE

v5:
- Drop remove function
- Split tx&rx transfers in mcp3911_trigger_handler()
- Moved Kconfig changes to right patch

v6:
- Go for devm_clk_get_enabled()
- Cosmetic cleanups
- Clarify the description of microchip,data-ready-hiz


Best regards,
Marcus Folkesson


