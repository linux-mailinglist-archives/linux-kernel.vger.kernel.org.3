Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78158D495
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiHIHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiHIHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FFE003;
        Tue,  9 Aug 2022 00:32:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x25so12143031ljm.5;
        Tue, 09 Aug 2022 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNXFoW8pYrIf1/G1F0nD0otxreymSfu0Gf6VI2D1QBM=;
        b=LtBCC3Ryr7UEW6G0Dyk0vL+uquG5PoGU1/+Tu7pMOEnCS+E5TrQUkjN5COEL/yqth6
         jqmQYlnhdWyIqK/PXvgEQoqrnqOA7fDaibtEwJCPTNJQrFtkbQtHH0TGdX0Xna3Y7odU
         fsfeYOcqXY4vgfaAIT/CjJzZSvzbsyeI2Dl3sucQHz2/HQHeEbETgjXhsaYU3V4/1tNx
         IusMF8amheMe0jLBAJTXeqpQZVy5+zRAQHuah0PW0esdTUIJQN08FSsWu4ACogu7P12C
         Xge1TjuDHlX3RXHmOhkDdwIX/QLJ+nqhrauQu9P6MjOW1S1PMrILAsorlCDrz6M9IIz3
         WQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNXFoW8pYrIf1/G1F0nD0otxreymSfu0Gf6VI2D1QBM=;
        b=kUhzb7mUBuooOFcas3FxNO83dDG6Xm6dFi1Tw6JAuUNy3ZnWZAXQGocfCziq7Eo3mh
         aDuOlwN7HWfHFUq/JZTHUaqvWW/a/nXGSSDMApLNVbp8fuoO4lDEJqkjGouOC7A2MxEM
         Lh3XRKaoOoFxeD/y7GxoumiM/ubcghbK+VJe+6djYUUvnuX1JxBmf8zBLD0GvxXwV+2a
         GXy+HFxgVg26Wt4xV7zzk6kS/n/meQMxQuNm3RmRH/76WHIJfHxNT/b9X3e3Tu3XPzC2
         jdeMbSVV1gmnVJ3gjoBCxSoGdcfj5XMKtSvkvHR7dAOUcIqtz37XuJZPIC0IryS6FpDZ
         MuVA==
X-Gm-Message-State: ACgBeo3gPhybDEzWqRO6W7+GI+b9Zfeih4h1soek+tVn7Fm5l4k19Ea3
        e277hHEoW0fcPp6bioJmXTs=
X-Google-Smtp-Source: AA6agR4vCC9jRQntBClKnFqUUr0dQxqsrq5EzM1fwPvVoj9bIt1YOEC8OUe93ImPuyRVII6BDfeghg==
X-Received: by 2002:a2e:9884:0:b0:25e:4b41:75da with SMTP id b4-20020a2e9884000000b0025e4b4175damr6617834ljj.339.1660030346766;
        Tue, 09 Aug 2022 00:32:26 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:26 -0700 (PDT)
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
Subject: [PATCH v5 0/9] Improve MCP3911 driver
Date:   Tue,  9 Aug 2022 09:36:39 +0200
Message-Id: <20220809073648.167821-1-marcus.folkesson@gmail.com>
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

Hi,

This patch series intend to fix bugs and improve functionality of the MCP3911 driver.
The main features added are
- Support for buffers
- Interrupt driven readings
- Support for oversampling ratio
- Support for set scale values (Gain)

Among the bug fixes, there are changes in the formula for calculate raw value and a fix for mismatch in the devicetree property.

Another general improvement for the driver is to use managed resources for all allocated resources.

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


Best regards,
Marcus Folkesson


