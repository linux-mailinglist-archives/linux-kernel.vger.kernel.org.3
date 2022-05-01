Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F87516541
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiEAQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbiEAQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D8411A19;
        Sun,  1 May 2022 09:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C58CE60EF6;
        Sun,  1 May 2022 16:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D6C385AA;
        Sun,  1 May 2022 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651422478;
        bh=tfUziATB8ceyhRS+KXLuHyRUSLa9xFmooO49cxRP/XE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mdfPRTQwhoUF9AgqjmNLDBkpLoeew24KML0puGMY5+NE6v3vOg433Wn8KY6ivpEzU
         qAuyyhUd0RGBxtI5cyLkSknqhXszq7ZWo//axOFFW7ihA5Iou9Cb317I0LMQLKr3uK
         6E6a+ybfrtvojC6FKOtw7j9AFnCDjRoK67PLcLqQpukAKVu6ktEyN/GtMi/N/e94DE
         DmFjdquRqeVA8BvZjEP73U0tykAWV6GX1RU1/7dOP4e4mDUVkT41s0bBPyTFmG9wox
         4zaWRHp64eYXgftPN9yxleFS1RWT5TIc8Gef02wxQ9yqa0HjtAciGxu+nMUCpZ/aL1
         n/UpmFV5oYj/Q==
Date:   Sun, 1 May 2022 17:36:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iio: accel: bma400: Add buffer, step and
 activity/inactivity
Message-ID: <20220501173613.338c657f@jic23-huawei>
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 02:40:56 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> This patch series adds trigger buffer support with data ready interrupt,
> separate channel for step counter, an event for step change interrupt,
> activity recognition and activity/inactivity event support.

Hi Jagath,

This is coming together nicely. I'm fine with all the patches
I haven't sent specific replies for.

Thanks,

Jonathan

> 
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

