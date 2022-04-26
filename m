Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C950FBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbiDZLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiDZLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:08:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD092980C;
        Tue, 26 Apr 2022 04:04:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so35340755ejn.2;
        Tue, 26 Apr 2022 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZT1i1bg4sYs5M4LmcWJhxOR8/OR3mrbkBYeZo06MTg=;
        b=mzzEUb46e1zXmJuTI8fy2KPLX12vNzdZRGW+EPQWiHk2x9wj+Nu0SN7lH/MTChb+v+
         1W9MfBDGDeEYTc7VdPss6pliYhIiG9lyNbaCbSBYRywq2rWVUaTCmQE5I7gfLn5PtP/F
         5LOaeCcBm66OZYzNmtNezW7Rk3zbEClrGOi0tfajM2hQ0yIGTwFOEyIrVrT9pxabBi7n
         7PkslwxYPJZY6iYNGpcOtB0ahZWN26CEQpfAK85L1m8rH38OSnQgiDd0a0ECSXLbll6M
         ZsFFjt+zRvPaC/H8TX7AytPUoLNiW8Kw+MClGkWIai0snpdf+8FxtLd7/pbwmMKFaW6R
         ZYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZT1i1bg4sYs5M4LmcWJhxOR8/OR3mrbkBYeZo06MTg=;
        b=Et68Pp2/Y5vLl6rvuufZrBsHzpGWZXcWh8Ms2eLvEjDC4z2yaNZxp3A4tYo9xFozsL
         XWQlSu/Vb8pBOdsZqqZKqX3d4DLLufSKsnZLG92e3bpIYvJoH5q/CWOmWL6wKxnc5x2a
         SwcimoKaY/pLl0CobuIy7yngmhFj3Trof5xhfhtzrzHPfB/0ym+oLppdW74u1Lb1Qq5M
         5vBWozyVcTZIbVmMmi+Mdifes1/i+fpOR0Q5xL3U53QYB7YlkVZNHvvSzp+cLc+/Gwv7
         g8jCuGtuAWocAwTVnF1Ur/GEU6WllrXtWFpC+bNrdMRvyJYiIQ07GddvRdIcbb/IECBO
         m/jA==
X-Gm-Message-State: AOAM533crocNdmTQRqXIR+kxb2kcJ+qh9Gr8N5OvFPX+dHRCpgGOjjDT
        R8Lobb2DYDjGqbnCmjz7/364XC+7BzDo30v5CeFiLOpd+VTfiQCq
X-Google-Smtp-Source: ABdhPJzo45LUaVfiVFoRAHmaqYkamE7qKUHdPDkdVJV+cBrONGgMcVeP1eEAcp3NQkbThRv6h24xxpgkhEQomo+l0Io=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr20316412ejh.579.1650971092856; Tue, 26
 Apr 2022 04:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 13:04:16 +0200
Message-ID: <CAHp75VdyPekY7t8Y4-nyVXNt7wFZKB+yL2i6MNe1WLez178a6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] iio: accel: bma400: Add buffer, step and activity/inactivity
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> This patch series adds trigger buffer support with data ready interrupt,
> separate channel for step counter, an event for step change interrupt,
> activity recognition and activity/inactivity event support.

You forgot to add tags from the previous round of review, please be
respectful to reviewers.


> changes since v3
> 1. Removed all the unnecessary mutex locking for regmap.
> 2. Corrected the mutex locking and unlocking for device private data
> members.
> 3. Mutex locking and unlocking is used to protect the device private
> structure members.
> 4. Using DMA safe buffer for regmap_bulk_write() and regmap_bulk_read().
>
> 1/9: Fixed the comment.
>
> 3/9: Added () for the function name in the comment.
>
> 4/9: Handling error cases with goto in bma400_trigger_handler().
>      Mutex locking and unlocking is used to protect the data->buffer.
>      Using DMA safe buffer for regmap_bulk_read().
>      Mutex locking and unlocking is used to protect the data->status in
>      bma400_interrupt.
>
> 5/9: Using DMA safe buffers to read steps value by allocating memory internally.
>      Using DMA safe buffers for regmap_bulk_write().
>      Removed the lock for regmap().
>
> 6/9: Removed the duplication of code for enabling step, added function to handle
>      the step enable.
>
> 7/9: Removed the lock for regmap().
>      Mutex locking and unlocking is used to protect the data members.
>
> 8/9: Removed the lock for regmap().
>
> 9/9. Added __be16 duration in struct bma400_data.
>      Fixed the warning - impossible condition '(reg < 0) => (0-255 < 0)'
>      Fixed error: call to __compiletime_assert_272
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> changes since v2
> 1. Reordering of header includes in the separate patch.
> 2. Matching the IIO syntax for multiline comment.
> 3. Following the preference in the interrupt handler for returning.
> 4. Add support for activity recognition.
> 5. Add support for debugfs to access registers from userspace.
> 6. Add support for activity and inactivity events
>
> changes since v1
> 1. Added comment section that describes the math for scale calculation.
> 2. Added separate devm_add_action_or_reset() calls to disable regulator
>    and to put the sensor in power down mode.
> 3. Remove the err_reg_disable and out, goto labels and returning directly
>    if error occurs.
> 4. Added mutex calls while putting sensor in power down.
> 5. Added ___cacheline_aligned for device data.
> 6. Ordering the header includes.
> 7. Handling erroneous and spurious interrupts in the interrupt handler
>    by returning IRQ_NONE.
> 8. Using dev_err_probe() instead of dev_err().
> 9. Configured the interrupt to open drain.
> 10. Using le16_to_cpu() to fix the sparse warning.
> 11. Checking the step change event is enabled or not.
> 12. Enabling the step change event will also enable the step channel.
> 13. Using FIELD_GET() instead of bitwise operation.
> 14. Removal of dead code in the _event_config().
>
> Jagath Jog J (9):
>   iio: accel: bma400: Fix the scale min and max macro values
>   iio: accel: bma400: Reordering of header files
>   iio: accel: bma400: conversion to device-managed function
>   iio: accel: bma400: Add triggered buffer support
>   iio: accel: bma400: Add separate channel for step counter
>   iio: accel: bma400: Add step change event
>   iio: accel: bma400: Add activity recognition support
>   iio: accel: bma400: Add debugfs register access support
>   iio: accel: bma400: Add support for activity and inactivity events
>
>  drivers/iio/accel/Kconfig       |   2 +
>  drivers/iio/accel/bma400.h      |  50 ++-
>  drivers/iio/accel/bma400_core.c | 694 +++++++++++++++++++++++++++++---
>  drivers/iio/accel/bma400_i2c.c  |  10 +-
>  drivers/iio/accel/bma400_spi.c  |   8 +-
>  5 files changed, 697 insertions(+), 67 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
