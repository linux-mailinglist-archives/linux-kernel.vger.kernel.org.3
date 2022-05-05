Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E751C0C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbiEENeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377608AbiEENeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27EF12742;
        Thu,  5 May 2022 06:30:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c14so3655617pfn.2;
        Thu, 05 May 2022 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cephgPcblnwNu1qlE3SOQDufngLfMfT5tSk91aqk2J8=;
        b=gSE+T5ZF3xc5crwMqLxzTj26xfk7d7lj4iYWmkO60c01oKZqHWBliHj/3YqZm8Il2F
         QlMYIqpKgRIJZbRBUiRqXkLzUvmAbJmn8HgSRuepLT81xovRP+WXYxgzkeX3TnRAh1H4
         QqYYN+ZpX0f+xfeQb2vcy671M6ktPU0tXTh+Oqit5xE7SY3mPu4uufZwfMkJYsWRjhHb
         25Va3l1dpYuQla6MLR0f44e4wIE+rcUKmY/joDEfyAJSBoVMD3JAzuBfyCHv6OaJhiTz
         eTrb2bTfpaJ2/tHgNYoLVC9gbZFkHYOaQ13/IzdxvVtvDLvTvixym0e9r7HDhXjJz7mW
         w+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cephgPcblnwNu1qlE3SOQDufngLfMfT5tSk91aqk2J8=;
        b=XRjkPvKqabrWmn0CwvzsKbOOK6C0/w3hsNQRwIsLUSg4tJ3RIsDY5wjieHYW9U/JSB
         tMHrCkrqgRDAoAdKEDiSvJuTLyXa7uZ8SShTG1zXWihm789OR/Zm1L6TCay855x5oVGO
         ydHo4TWpvvNiRpzUAOKNYrKVlp/nMyfNeLthpbtwUga7P/MVVJ30tgLg2GH0rIxbucvc
         AMYeg5z/EjaQLgXmkm/82Bmd/LkwkCloNuiyalBn57wQ9deZ1F6+c0GVJmGv85HKO4bp
         E+Ffn0zEFrlP5TNpg/zpC1MC9DgOAxkyZvx4vjkHWGVjJ3qf7ZYLgWwtZXQgHqqC7FOr
         Kc0g==
X-Gm-Message-State: AOAM533Zw3ZPVpq2U28j8nVM1Buwqnjo/qWDgxVLqANz3zaSLapPqGXQ
        PqSUlyPwbdUCmvj3LBCZOAI=
X-Google-Smtp-Source: ABdhPJxBq1ftJq/UHcsA0kG9CjVQ8pSp6FWxcWcNoAtY0dfvnJmFg0VS2gXrJmhd+AirQWR85ybR6Q==
X-Received: by 2002:a63:3f4e:0:b0:3aa:193b:8c5d with SMTP id m75-20020a633f4e000000b003aa193b8c5dmr22659593pga.624.1651757426101;
        Thu, 05 May 2022 06:30:26 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:25 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/10] iio: accel: bma400: Add buffer, step and activity/inactivity
Date:   Thu,  5 May 2022 19:00:11 +0530
Message-Id: <20220505133021.22362-1-jagathjog1996@gmail.com>
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

changes since v4
1/10 -  Added Reviewed-by tag.

2/10 -  No change.

3/10 -  No change.

4/10 -  Using __aligned(IIO_ALIGN) instead of ____cacheline_aligned.
	Added another entry to bma400_avail_scan_masks() only for
	accelerometer axis reading. Now temperature will be read only if
	requested by user.
	Added Reviewed-by.

5/10 -  Checking regmap_update_bits() and return if error occrus.

6/10 -  Using IIO_MOD_EVENT_CODE() instead of IIO_EVENT_CODE().
	Pushing all the events that occurred by checking status register 
	and then in the end returning HANDLED so that none of the events
	are missed.

7/10 -  Using IIO_MOD_EVENT_CODE() instead of IIO_EVENT_CODE().

8/10 -  Using set_mask_bits() instead of FIELD_PREP().

9/10 -  Added new channel for tap and modifiers for single and double tap.

10/10-  Added bma400 single and double tap support.

Removed debugfs patch.

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


Jagath Jog J (10):
  iio: accel: bma400: Fix the scale min and max macro values
  iio: accel: bma400: Reordering of header files
  iio: accel: bma400: conversion to device-managed function
  iio: accel: bma400: Add triggered buffer support
  iio: accel: bma400: Add separate channel for step counter
  iio: accel: bma400: Add step change event
  iio: accel: bma400: Add activity recognition support
  iio: accel: bma400: Add support for activity and inactivity events
  iio: Add channel for tap and new modifiers for single and double tap
  iio: accel: bma400: Add support for single and double tap events

 Documentation/ABI/testing/sysfs-bus-iio |  11 +
 drivers/iio/accel/Kconfig               |   2 +
 drivers/iio/accel/bma400.h              |  61 +-
 drivers/iio/accel/bma400_core.c         | 886 ++++++++++++++++++++++--
 drivers/iio/accel/bma400_i2c.c          |  10 +-
 drivers/iio/accel/bma400_spi.c          |   8 +-
 drivers/iio/industrialio-core.c         |   3 +
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   6 +
 9 files changed, 923 insertions(+), 67 deletions(-)

-- 
2.17.1

