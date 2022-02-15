Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000D4B7916
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiBOUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:52:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiBOUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:52:49 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1611C129;
        Tue, 15 Feb 2022 12:52:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id bx31so369746ljb.0;
        Tue, 15 Feb 2022 12:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMGS+E9enTU1RcYho7dj5zKVAmkRHoSxC5p3q4YCOAA=;
        b=TXjKJBkXqHUJCRipKn5GIAwWraS1vUkN1i0EQt9VdLuvIyWVfKvZRokvzg152ndI4k
         8NX/TaP84SGMpYzCPOQZCLEYtHtdSOHW+NqzX7VCPYgh1PL6/uuZj0W+pVqfIjVHbD7w
         ppaVgXSohp6ycHYxOviqigiTtE8NHePAkjXjoQgzzYS+uGO56eUAHThOFwxuaQLV++YT
         fswQAEMZcdGJ6tcPRhaXSMX/ez7pOgsU5E41hdB/lnSHl9MUtv0N3AkxHDjpTHkMcYMF
         p/WP3vPFRFme3B++oKJJvL6oD4LKbryqCWhuvpRy1LmlJeErAzYuguLaDAMpHdGrDShn
         tSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMGS+E9enTU1RcYho7dj5zKVAmkRHoSxC5p3q4YCOAA=;
        b=77s0gb4P185C8WXFhNdEl2v/9ENfQOPFC3YCn4z46f1yya/Hvb71t+AuF9ePB4Zwsc
         xroL95bGL1pOIEiUVIjrv1nN7wNp9/AP5bWYmYNHi09y4bjYe1kMxVq54m93Yw/wHHMA
         7NzUkGOztEx6xBdqWSwk0+AmSe6OpRqdatNTcuH+8+y6h2tOLk8HIOm74ZYBQkMMnA8U
         N/pWHfaJY1rnGcZtnstqNekvVS8XMSYAGDl/2BH86ud7pfeo9imMKe37xET8t9YRlZFA
         lsOr4f/Uccv1QYf9KCsyivqE32la8wTSUn7A5AfJOfOQb+S73/PFdZhNMAtMRyw8ojg4
         YDkA==
X-Gm-Message-State: AOAM532K+g1zlG+S4K9AKwh/Z1giiXyC9KLnx6ouzJZeKHkwVLA4Fg5t
        V6eO1XBeD24xG3d/ny6Q/OwxuWleOsI8oPPo
X-Google-Smtp-Source: ABdhPJwiCTNEg3YI/aYqALAieZsJp9VDJ6J4PFaM9mcfBU04Kstzv2YEB7Tvm59YAYTzsqXUsyo7tg==
X-Received: by 2002:a05:651c:1403:: with SMTP id u3mr569012lje.265.1644958355155;
        Tue, 15 Feb 2022 12:52:35 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id 18sm1129337ljw.71.2022.02.15.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:52:34 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Add support for Imagis touchscreens
Date:   Tue, 15 Feb 2022 22:51:50 +0200
Message-Id: <20220215205153.57966-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
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

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

v2: rebase on top of the correct tree
v3:
- prefix all defines as IST3038C
- use two tabs for all defines
- add missing <linux/regulator/consumer.h> header
- drop ADDR_LEN and DATA_LEN defines; use sizeof(reg_be) instead
- use __be32 type for reg_be
- add a comment about i2c read not being successful on first try
- use "ret" instead of "res" in read_reg function
- don't use the internal __cpu_to_be32 function, use cpu_to_be32 instead
- use "error" instead of "ret" in interrupt handler
- pass the slot state directly, without ternary operator
- drop the dev_err in init_input_dev function
- reorder the functions in _probe so that the chipid command is read as fast 
as possible
- don't use imagis_start in probe
- initialize the irq after the chip is powered
- save the return value in imagis_resume
- drop WIDTH_MAJOR since only TOUCH_MAJOR is reported
- the "chip detected" message is now dev_dbg
- reorder headers so they are in alphabetic order
- use GENMASK to generate masks for getting the X and Y coordinates and touch area
- drop *_pressure from device tree bindings since the driver doesn't
support reporting pressure
- fix the typo with i2c address in device treee bindings (48 instead of 50)
- add IRQF_NO_AUTOEN flag to avoid unbalanced irq enable
v4:
- alphabetically order MAINTAINERS entry
- alphabetically order Kconfig and Makefile
- drop the error message in init_regulators
- disable regulators on probe error
- drop IRQF_TRIGGER_FALLING
- @ is not optional (device tree bindings)
- don't use items for compatible
- add maxItems property to reg, drop the comment

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

