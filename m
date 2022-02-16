Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1214B8A83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiBPNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:43:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiBPNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:43:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A301F6BB1;
        Wed, 16 Feb 2022 05:43:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c10so3350936ljr.9;
        Wed, 16 Feb 2022 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hfWp9G5GbMg8ACSeTsZut9QPHNISVR0UVC+PAcblD0=;
        b=IdjsvazJH6PxjTpBJ4x6aMNatZU5CtYbz0Q7Xvatenkn2tIumk7C/izrvH9nju7qe7
         lXEP4UGql1zNYUjaefd8Z4VmjBHLWVJO1AVhhKd2eNai+WNeyYQdJM3u9rsAPnIuw8zX
         W19zN+GC25NsUZa13UIDpsS2p09Z62/IjqSpRrXpn22bx2f3eLLq4JTJLv8eTayCValW
         1cuiuwTi5Ouad4JIK8Bs/xTgh3JKG3cuapR8mtWUZdOdphDs8q/cEvcMKhw7PouhEJ2m
         wL3MkOzdb0c7BKJ9hSuO12y7JR9QtoIILT6Ue1PPEQ6FSxHhKjA8ZB6ymZJV80fmeiDn
         EffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hfWp9G5GbMg8ACSeTsZut9QPHNISVR0UVC+PAcblD0=;
        b=rrb4Sp541oBoyK9N7Sr9OGSBlZm7eBhmyADcfFW/kdT/2/FvZWNulG+MZC7WIfc6/o
         hqzxpSXChox2leX7KJhfA6ObhdA/uy9A/brGPsb25/9bbHy213TMcZgfCMyp3LrpyaAM
         V38PirwFOpGQ2S4LAQ0VwKuZRXcZb4oDSGV5JzR6rFwgrnbMa518RPA4Nmh2Pk7id2vh
         OCCm0wJ3DrCDutruJeaLJ7bvcWlZ0XFoEDTjhzsB+W9jHYwXFSHvkUGc0n2Q+S8TxYel
         AEP8DssrIqI0BtVD8LTrQAJcOrUvggdDPM3T1iEnMQK1bQYxS4KC7s3eIy7fMUrmCpu1
         Psqg==
X-Gm-Message-State: AOAM531d69MQSqFNikYZNok9Omad7nYrJ7CK8qmLo7P59qM5smI2bo8K
        bFMCtRSo2MH8+Fo16o6nLi5WhT8QyLxqpaYa
X-Google-Smtp-Source: ABdhPJxJRhwVMZXBLyRrV7DhdWEsYckDOWb+m4qBPlR0c88mJMPFYs9gEX7Ji0Kjb4vChum9fhpbxA==
X-Received: by 2002:a2e:a498:0:b0:239:1259:bc9f with SMTP id h24-20020a2ea498000000b002391259bc9fmr2018666lji.232.1645018994308;
        Wed, 16 Feb 2022 05:43:14 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id a22sm1049934lfr.24.2022.02.16.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:43:13 -0800 (PST)
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
Subject: [PATCH v5 0/2] Add support for Imagis touchscreens
Date:   Wed, 16 Feb 2022 15:42:59 +0200
Message-Id: <20220216134302.5153-1-markuss.broks@gmail.com>
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
v5:
- compatible enum is not an item of the list, drop "-"

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

