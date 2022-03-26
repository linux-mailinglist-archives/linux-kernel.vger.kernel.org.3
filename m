Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4164E83D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiCZTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiCZTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:43:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721617156E;
        Sat, 26 Mar 2022 12:41:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so11740340pjm.0;
        Sat, 26 Mar 2022 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aIwjZik1/zaruSghW8xQ1i1xKaqz8bOpA5tKq+kgq4I=;
        b=Koc4LEfz52vM+ytlgFf1R6AdkBHrEdS+1zRabCjFI7Fanfph3BsoRX6mOf7yl0GOFz
         5hEFZtyR9gDKxyp2uSRCifdOd+BsjNEYNSmg2vqWTrgULzxlQ6ee2plh/YDEpyY17T6z
         4aMo9PK6mJqIqA7fng+yPFZNmoypVU0Y0HXRWr7GIAfblaAi8y+qChcuNnGR2CVmjYky
         sF+exsnBlH96LcgkcTqRD9PkZtf6z55iPQ/RxUNVA1ADldCalb5S7uN57na9zP6PyKFB
         W7PKTtoTQbIhmORIGxGLs4beLrrAznH7pRKfJ91MpLr838BKo2uTBQPSw/jxco+QzwRn
         E6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aIwjZik1/zaruSghW8xQ1i1xKaqz8bOpA5tKq+kgq4I=;
        b=eIaJCWEfPhQLjxmPPNf7gvJ945/NUknMwOlyXyfaM3sv0ipiiiDpRWmwLMpFkSyYfG
         NVSBsr3naFe6jrZxkWnZlLpAtqfQIlVRXjmvCEcFwv5YWkQH3QM6fcmjfKgDm/JGibjE
         mWidTp/LoDhv6XRYc2mEKeOqcfIdy0h34oSXJyVoCyAgg+wA7uHQq7xrf7Fn2CqBRevH
         feTIwd9yvP4JtZSI0QoaUTFLwC1exNPizxA9ZahHviZ7D9sjw3Z9L+WCvx2sZPvniHn9
         07B6bz55acqLbeeqR8HyRMeVTo9VyBdWyW5fwRq9yZayV/A2i1i+TniTguE7uBW9aFjh
         r19w==
X-Gm-Message-State: AOAM533kRZ8ZOJ35dRMON1VdLyv4QCS85KpTeuoIDgtMuX7XBO8jm+9T
        pO4RgLkGpJ8MBAwz0NXBZ24=
X-Google-Smtp-Source: ABdhPJz/cJMyATkGEjKUesI6KTg8fkvR3M0KD8+hkGZdYcOWNovePbjV51j5NA0pS4/2xbNdyPiJKQ==
X-Received: by 2002:a17:902:da92:b0:154:10dc:26f8 with SMTP id j18-20020a170902da9200b0015410dc26f8mr18309675plx.133.1648323710915;
        Sat, 26 Mar 2022 12:41:50 -0700 (PDT)
Received: from localhost.localdomain ([116.75.119.161])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm8778784pgd.27.2022.03.26.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 12:41:50 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] iio: accel: bma400: Add support for buffer and step
Date:   Sun, 27 Mar 2022 01:11:41 +0530
Message-Id: <20220326194146.15549-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds trigger buffer support with data ready interrupt,
separate channel for step counter and an event for step change interrupt.

changes since v1
1. Added comment section that describes the math for scale calculation.
2. Added separate devm_add_action_or_reset() calls to disable regulator
   and to put the sensor in power down mode.
3. Remove the err_reg_disable and out, goto labels and returning directly
   if error occurs.
4. Added mutex calls while putting sensor in power down.
5. Added ___cacheline_aligned for device data.
6. Ordering the header includes.
7. Handling erroneous and spurious interrupts in the interrupt handler
   by returning IRQ_NONE.
8. Using dev_err_probe() instead of dev_err().
9. Configured the interrupt to open drain.
10. Using le16_to_cpu() to fix the sparse warning.
11. Checking the step change event is enabled or not.
12. Enabling the step change event will also enable the step channel.
13. Using FIELD_GET() instead of bitwise operation.
14. Removal of dead code in the _event_config().

Jagath Jog J (5):
  iio: accel: bma400: Fix the scale min and max macro values
  iio: accel: bma400: conversion to device-managed function
  iio: accel: bma400: Add triggered buffer support
  iio: accel: bma400: Add separate channel for step counter
  iio: accel: bma400: Add step change event

 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma400.h      |  37 +++-
 drivers/iio/accel/bma400_core.c | 351 +++++++++++++++++++++++++++-----
 drivers/iio/accel/bma400_i2c.c  |  10 +-
 drivers/iio/accel/bma400_spi.c  |  10 +-
 5 files changed, 341 insertions(+), 69 deletions(-)

-- 
2.17.1

