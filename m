Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAF578C36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiGRU46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiGRU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:56:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7B2D1C9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:55 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso9879775otg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtI4BCeOWThxZjOmQgxVm4koZgluey3sle1qSuO2+5c=;
        b=ZKmaB+crK0BerwFXSmevFclc0XnCZ5K9FTG0NZAwHG121SfjnuDqDrTCA89jFuvXHC
         L9X1pa2NcaBOUk905nmom+8X0VHVhecaMrK7JOGPjcY57T9FCi7l2f19cjzUgKoGBvzD
         D2q0i6dfAobf5oT0Z929u8n61QkgqT+SdxqB7U7ncDBrST4Q3Y/HAhJpxH4RjMr1HbAT
         RYO+sYrlXyePnWfqS9eCAfTkXs5DyLWXPTt0edfbHz7yYBVtC96s30O0hTxiSDl/AotN
         gGNX8XiCYVEV7Czueelk3O98ToxcgKpfsoCmQ+IH4TSydDG/Bnws6Dls9b/zhW8sLide
         QN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtI4BCeOWThxZjOmQgxVm4koZgluey3sle1qSuO2+5c=;
        b=dCxJNeBLxTKf4/Rh7DRTUCUk8Tb/YZn+xR2Bk0EneAmWZ4WwpWTfQUIzwHwydB4fHz
         WoXIZhywcoseBebu8FHLoVczKsT/2q10JXbLcYFAnuAvJs5I8se8Ufrr3bL/UW+VvOt6
         hSEihitXRJU6v3rFUm4/eUZXJQiAswPMFlBVGR+0lRdTavslZCke5FqXw+JmlJq2vgGW
         56NLecgkRkx6yEWvFPWJ21nbApwCrtVC/B0BQRq6zwgUpvb71QGLKU3Ae7Ul4wWnDoY1
         yF/ETi09HOnuGURtzhg+4xTpq9/v4qVtTZY6Hn06x/eoz//vlfviIk5xNS7sI6fO5MWi
         5K8A==
X-Gm-Message-State: AJIora9WHGSPKRKqhCsV23krvdc8MQOlS/Sn+kdzFog0/2l+t5QLfc3i
        jfv+hloaWguclA77tBK8oWE0ow==
X-Google-Smtp-Source: AGRyM1vy8HybHOdsbc4hElRNtYQZ0XM2oeyBoFh+w2bOR8ozgmVtF9e9YkHJBGlyf76HZqT/TsY2yw==
X-Received: by 2002:a05:6830:6517:b0:614:d582:77d7 with SMTP id cm23-20020a056830651700b00614d58277d7mr12062999otb.323.1658177815107;
        Mon, 18 Jul 2022 13:56:55 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ab2c8000000b0035eb4e5a6cbsm5252065ooo.33.2022.07.18.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:56:54 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 0/6] gpio: Implement and utilize register structures for ISA drivers
Date:   Fri, 15 Jul 2022 14:52:22 -0400
Message-Id: <cover.1657907849.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Updated contact information in MAINTAINERS
 - Added help text for GPIO_I8255 Kconfig option
 - Move include/linux/gpio/i8255.h to drivers/gpio/gpio-i8255.h
 - Include "gpio-i8255.h" instead of <linux/gpio/i8255.h>
 - Include linux/types.h instead of linux/compiler_types.h
 - Add underscores for *PORTC_LOWER* and *PORTC_UPPER* defines
 - Move (offset % 8) expression to a port_offset const above the io_port
   const in i8255_direction_mask(); this should help optimize assembly
   instructions on some architectures
 - Implement an opaque i8255_state struct to organize and access i8255
   device states; this replaces the control_state array passed to
   various i8255 library functions in previous patchsets
 - Implement and provide a i8255_state_init() function to initialize the
   i8255_state struct for a consumer
 - Use a spinlock within i8255 library functions to protect access to
   i8255 states and synchronize I/O operations; a spinlock is used so
   that these functions may be used within an interrupt context
 - Export the i8255 library symbols within a new I8255 namespace
 - Update the 104-dio-48e, 104-idi-48, gpio-mm drivers to use the new
   i8255_state struct and I8255 namespace

The PC104/ISA drivers were updated to use I/O memory accessor calls such
as ioread8()/iowrite8() in a previous patch series [0]. This
patchset is a continuation of the effort to improve the code readability
and reduce magic numbers by implementing and utilizing named register
data structures.

One of the benefits is that we can now observe more easily similarities
in devices that share similar interfaces; such as the i8255 interfaces
used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers.

A new module supporting the Intel 8255 interface is introduced to
consolidate the common code found among the 104-DIO-48E, 104-IDI-48, and
GPIO-MM drivers.

[0] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/

William Breathitt Gray (6):
  gpio: ws16c48: Implement and utilize register structures
  gpio: 104-idio-16: Implement and utilize register structures
  gpio: i8255: Introduce the Intel 8255 interface library module
  gpio: 104-dio-48e: Implement and utilize register structures
  gpio: 104-idi-48: Implement and utilize register structures
  gpio: gpio-mm: Implement and utilize register structures

 MAINTAINERS                     |   6 +
 drivers/gpio/Kconfig            |  13 ++
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 248 ++++++++-------------------
 drivers/gpio/gpio-104-idi-48.c  | 141 +++++++--------
 drivers/gpio/gpio-104-idio-16.c |  58 +++++--
 drivers/gpio/gpio-gpio-mm.c     | 202 +++++-----------------
 drivers/gpio/gpio-i8255.c       | 292 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-i8255.h       |  47 +++++
 drivers/gpio/gpio-ws16c48.c     | 119 +++++++++----
 10 files changed, 657 insertions(+), 470 deletions(-)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 drivers/gpio/gpio-i8255.h


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

