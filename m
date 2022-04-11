Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1974FC5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiDKUd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiDKUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:33:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C335DD2;
        Mon, 11 Apr 2022 13:31:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s10so7344094plg.9;
        Mon, 11 Apr 2022 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pahEFmYM/dsCPcY4Y1wBDDI/c4yMZubWtYa+PmtvY0c=;
        b=iYwUJ5GODL5uQqRqwYSn+GxQCEKSwCapFY59buzzIw6CzuSWR5Z577nZYAcNPYLaJd
         paLf3Xu2kCPLRJaMZFywJvJ3JwjWn4/UXhCFvvJWoO/JgluCS0927TT5aXNp8HvrTjVA
         LrksFnr6Wr0SLl+CB2rKg5EE+Y//CGYStjiFgri+JT9ada9tho3/2cnO9BDTw1ds1BnK
         vyIcwrcDDoBYVqBpFJazvD4C7xVP+gGRVaSEggjhtZb1h1YZEV14GxSAX1tHs/wGepif
         p3U35m4yMqP7YDJsmoWKlH+fkTKt2d6xP62cIgBtR1UE7kxeWzbWpLmlwtc0S00k173b
         c8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pahEFmYM/dsCPcY4Y1wBDDI/c4yMZubWtYa+PmtvY0c=;
        b=rBeLsgKbh5yyy2i2OQQQyyQTzhtvNZkY+7/B0pvV8NcoSsj0cPdPYxivr77JUKRYAE
         lgVxvw5xpThNlOBtMIjvxzKO3Cg1DE8nroln/zYG3qC9XN9sJw57afedIlPTMnMgB++j
         gOLTNDyk23SI58RmgBztMBqJ95KzhB7uJ9LEL11pu520igxROFRKMXuFm6P7qvRlcNMk
         KUwCo56eXD5ADz2PqRzOXMjs8pl1bTbAgDb3ph4nvGPB9EidrNjO6JqoQdiiSZFVdcL+
         EVFh+LYtiXr+UGcXCkCMchyV/Jolw6h554Lpw9v8RSZ3fupm7GGlgHSVbqAeLGvCraal
         G+wQ==
X-Gm-Message-State: AOAM5320n8PyYjkVd1ZCxuqPyRVyeooHcNK0aqU4BcLLSGyMbS1NcMB9
        EvSmTJctPH0DkZvpkwWRdmY=
X-Google-Smtp-Source: ABdhPJxn23UHAlNxz7kyirUouNR/dc3JheRJ5SMGCHPU+WWvi4gPtz2UfCcVn/r6HbZ/GRJohugwEA==
X-Received: by 2002:a17:90b:2516:b0:1ca:aa68:ca71 with SMTP id ns22-20020a17090b251600b001caaa68ca71mr1049975pjb.58.1649709098103;
        Mon, 11 Apr 2022 13:31:38 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:37 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] iio: accel: bma400: Add buffer, step and activity/inactivity
Date:   Tue, 12 Apr 2022 02:01:24 +0530
Message-Id: <20220411203133.19929-1-jagathjog1996@gmail.com>
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
separate channel for step counter, an event for step change interrupt,
activity recognition and activity/inactivity event support.

changes since v2
1. Reordering of header includes in the separate patch.
2. Matching the IIO syntax for multiline comment.
3. Following the preference in the interrupt handler for returning.
4. Add support for activity recognition.
5. Add support for debugfs to access registers from userspace.
6. Add support for activity and inactivity events

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

Jagath Jog J (9):
  iio: accel: bma400: Fix the scale min and max macro values
  iio: accel: bma400: Reordering of header files
  iio: accel: bma400: conversion to device-managed function
  iio: accel: bma400: Add triggered buffer support
  iio: accel: bma400: Add separate channel for step counter
  iio: accel: bma400: Add step change event
  iio: accel: bma400: Add activity recognition support
  iio: accel: bma400: Add debugfs register access support
  iio: accel: bma400: Add support for activity and inactivity events

 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma400.h      |  49 ++-
 drivers/iio/accel/bma400_core.c | 701 +++++++++++++++++++++++++++++---
 drivers/iio/accel/bma400_i2c.c  |  10 +-
 drivers/iio/accel/bma400_spi.c  |   8 +-
 5 files changed, 703 insertions(+), 67 deletions(-)

-- 
2.17.1

