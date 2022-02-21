Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD34BD715
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiBUH0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:26:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiBUH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:26:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB4B0;
        Sun, 20 Feb 2022 23:26:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so3020783pja.1;
        Sun, 20 Feb 2022 23:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/v5S5vNuug3GOI4emxMXAStkqzv+r74zEqj6r8qlq6I=;
        b=R1ZftL6146zTkxfAwi5L1mAFrxX09JqfgAFZX0hBlUUSA4+vlJsLu9Tk9PHkpuWOTE
         qUIc+VXUrzEElhqpWCpWF9PXphAo3wSyDyoFeHQNR7vD71ryPLZDA61Agyiuqk/L6p8N
         Es8qKjtlfK/QywMQPoOqm/a9rs9+Y0u2c9KesfQ1PMVQqZPfSRZe9/LbdgL+4XDaE7cJ
         M/4QceNEaW8NvExob1XDcJFiOxlg0OQn7J9+7PEQtta8UbuUuxRlXL2pHHjEDsquZR42
         1TZpAzeUj6sQtH93j3lmS2fcVxw4UewxQz1hRP6pKsWzKd/C3cSjijRANrzWenomTtff
         8L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/v5S5vNuug3GOI4emxMXAStkqzv+r74zEqj6r8qlq6I=;
        b=7oiqUDWz3hm/D0JCPPYb6si4360yZKyEaRnJzr7chByRo3XtDE+TwcHqPWJQc37Oen
         9UDW1TktacfiTu45kZWOAl+6s++HHd/2VBS+CWYkkEK5EgF9xO8KOihAV2/QtCRWpEdy
         UILC9Et8K/rUgP9PJue9P5SppdSnoHIW3vCKSVIoPqbdXiMjWTKs0uWo86kcVJojGakF
         zg0NsjVKiNGisfLTi+weI0EDhvdQFd+R8rCOXvqrAQZ3UojBbP5jvTdJH5pyc/SjGzr9
         4o2A37no28s1h+ySreOUoWHB5HuNdQLQ1tWigH7xvWznkvxl1DOJfRxjUQ7sHJxgh0to
         YIAQ==
X-Gm-Message-State: AOAM530JXqozVpTNjN1YYMxzxBk3P8nf6+sRRgKHxhfHZFMtYqdgxhul
        PA6rZEzaiYye2RlLaPW3qHL0/x8JRvHtxg==
X-Google-Smtp-Source: ABdhPJxnvwUiR223tT4jiy6N9TvQeZ2QJuyj6jVsRKtSW/aZ7FMu1qC5OTnbZyhJvtTM3E1oFQBgqQ==
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id bi6-20020a170902bf0600b0014d8c7296c6mr18080104plb.156.1645428365536;
        Sun, 20 Feb 2022 23:26:05 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q21sm11558094pfu.188.2022.02.20.23.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 23:26:04 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     edwin.chiu@sunplus.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v5] Add cpuidle driver for Sunplus SP7021
Date:   Mon, 21 Feb 2022 15:26:17 +0800
Message-Id: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for cpuidle driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Changes in v3
 - Rearrangement #include sequence
 - Change remark style to /*~*/
 - Align author email address to same as sob
 - Optimal code
Changes in v4
 - According Rob Herringrobh's comment
   There is no need for this binding.
   Just wanting a different driver is not a reason
   for a duplicate schema.
   So remove yaml file and submit driver again.
Changes in v5
 - According Krzysztof's comment
   You either use appropriate compatible in DT
   or add your compatible to cpuidle-arm.
   Even if this did not work, then the solution is to
   use common parts, not to duplicate entire driver.
   According Sudeep's comment
   In short NACK for any dedicated driver for this platform,
   use the generic cpuidle-arm driver with appropriate platform hooks
   Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
   for hook generic cpuidle-arm driver

Edwin Chiu (1):
  cpuidle: sunplus: Create cpuidle driver for sunplus sp7021

 MAINTAINERS                                   |  6 ++
 arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

-- 
2.7.4

