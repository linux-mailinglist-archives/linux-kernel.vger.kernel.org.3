Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087A65091CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382357AbiDTVOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382341AbiDTVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:13:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756A3B2A1;
        Wed, 20 Apr 2022 14:11:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so5976592pjb.4;
        Wed, 20 Apr 2022 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pT8uYZRqB6epfH5hvCdYtDuXc8rdtyp+ogqHGR0g+1s=;
        b=pL3mANDacILSYE71O2I0jfCOcL6rTeimnV6aBPDzB6XiLUtfzgucrwERoRSi/5I5nG
         u/A/3eOU/b9iSW2pyZENWY27Izc6vfMwTNhqbYVXfv73S6fk1HzZ8SqtTWiL/LxjREuo
         afndVB1u5mgpcB62IbklxJPZfyQyejcnDq+VzqSqjzwreX0KaPqz0ilM84Q5T+iKtXUV
         fkedkLU3IWPB3b0uA3l1CqB0ZW7CjurY91JyQHRV+2IUXUv8nSAt1JcuxrQHCnJwPuzG
         ZKA2NuPX+9U8npR1tZdHgoyKCphy0HWXMfyH+d78wn6ve+m45HvuhJnW1pTCTVdHUSrX
         Sdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pT8uYZRqB6epfH5hvCdYtDuXc8rdtyp+ogqHGR0g+1s=;
        b=dr57WPmhzj/qYTY+IhBXD6fsRJG3bn9d2G9Nniiw0cWL+1LiYzp2nHMmxmIxPkuCOF
         0LNLYtMpaqjWocSGUsa48zKBHtwlz5Lds6wBHNY+CwE+cLAZrTjLueEnG3veKFucPve1
         GG3DnO07abm9xLeEaC9UVkKitBluBV22BH+sQQ5jvdMcJvpypZhjEH7IMcGW36aW8L/e
         v2KBFHFcH5u/czMp5m3sSkSm9jUvXBbSqBjYU1IHOLmEyj3w04tsCNhyhCw7bHvISgzu
         ON9uxbvYFeVYb3/KOM6BRRFsuIJgiB0KTCr3YhAXHw00JfnDumTGgIK0O+0/8+V5zT3W
         OZVQ==
X-Gm-Message-State: AOAM532lsZeLhMoGlE4qfF1SA3v9OzYjLlMIuAEhEEoI23QBv2bVZ8FE
        hgkV9ngOLJ+fOTtwJyDZiAZOLg7p+8I=
X-Google-Smtp-Source: ABdhPJzZVkiN6/sTejSOhPT0l6MlG6IvgfD3etW84A3Yh5UWjDUsOumGAu5gE5tbsK9JUHPdABWusA==
X-Received: by 2002:a17:902:c1ca:b0:159:208:7579 with SMTP id c10-20020a170902c1ca00b0015902087579mr15678197plc.30.1650489069975;
        Wed, 20 Apr 2022 14:11:09 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:09 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] iio: accel: bma400: Add buffer, step and activity/inactivity
Date:   Thu, 21 Apr 2022 02:40:56 +0530
Message-Id: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds trigger buffer support with data ready interrupt,
separate channel for step counter, an event for step change interrupt,
activity recognition and activity/inactivity event support.

changes since v3
1. Removed all the unnecessary mutex locking for regmap.
2. Corrected the mutex locking and unlocking for device private data
members.
3. Mutex locking and unlocking is used to protect the device private
structure members.
4. Using DMA safe buffer for regmap_bulk_write() and regmap_bulk_read().

1/9: Fixed the comment.

3/9: Added () for the function name in the comment.

4/9: Handling error cases with goto in bma400_trigger_handler().
     Mutex locking and unlocking is used to protect the data->buffer.
     Using DMA safe buffer for regmap_bulk_read().
     Mutex locking and unlocking is used to protect the data->status in
     bma400_interrupt.

5/9: Using DMA safe buffers to read steps value by allocating memory internally.
     Using DMA safe buffers for regmap_bulk_write(). 
     Removed the lock for regmap().

6/9: Removed the duplication of code for enabling step, added function to handle
     the step enable. 

7/9: Removed the lock for regmap().
     Mutex locking and unlocking is used to protect the data members.

8/9: Removed the lock for regmap().

9/9. Added __be16 duration in struct bma400_data.
     Fixed the warning - impossible condition '(reg < 0) => (0-255 < 0)'
     Fixed error: call to __compiletime_assert_272
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

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
 drivers/iio/accel/bma400.h      |  50 ++-
 drivers/iio/accel/bma400_core.c | 694 +++++++++++++++++++++++++++++---
 drivers/iio/accel/bma400_i2c.c  |  10 +-
 drivers/iio/accel/bma400_spi.c  |   8 +-
 5 files changed, 697 insertions(+), 67 deletions(-)

-- 
2.17.1

