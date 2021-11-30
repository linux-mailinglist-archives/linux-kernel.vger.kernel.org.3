Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE52463A57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhK3PpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhK3Pox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:44:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8161EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:41:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i5so45378047wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWeycku9rme4rKkoWV+3Jz04z48OgukxrXDwD1/MLWE=;
        b=qHV8gWrfu1pXYPlWVayeYdwQmMea6gk+lwKsY4ry36cdDhQhnYdOxUsjIhE6SR87tV
         FYVdclS7tXSDDjvFjSiFvWYH/EzZcqm1Xoq92Z1ldrsvEPqVV43wPedH+xlELROXpOOO
         kj2I9XppeSuAv2Be9Zc6V/VbTEy/KWV8lxqHAqWZGk3VbSVAdjbWrBh53tr051ZHf9ZO
         2Fis1nueAp8SbV6hFYkSILKfBFiOK3v9zj1Ee8fQWmIWNzHwMRm5tRABtsK82ia3g8LP
         UF4OenH4ARtgS3TLz4LWBcpNFw8b5wo15aPNLzHkrtBHAUR3o8aTGw+NL6jWjGQLpG6T
         Si/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWeycku9rme4rKkoWV+3Jz04z48OgukxrXDwD1/MLWE=;
        b=v9jw8uHOp2LB/mxpKn6zuWgDrF1AgVC3pc9IlCpVbn7EuvcWfn6juY23A+yAQGTq+L
         c+m6fQl7/BYUEn48rgCtr1Vw6FxEqNctRUaYO/n56OuIDio95y44W1lJH7nGP+7WI6pd
         TdBHBsh5ruTIPv2dVRB2Vm6d0R+n1lbw4NiLYcpwqg4Yd32ZOZ1m7xVU/v8yaaFP3cWw
         W5a3GgeTnHpZY8ocSaBQ2M53s+WQ5MlWCGYAPlt0aPglkTIUWeDRSTHU0s4SvmBsYGKZ
         wt827hElbP9Rzl1I4+W992ZdTHo3AVilZtDSatoQqjJlXov/ADP5V14ISOoif3sczUR8
         YcUQ==
X-Gm-Message-State: AOAM533FQQ8lMhkQjEgDI8h7NPnwkl1Jdi2sZbcBMXiNa3+cF2NLtWqz
        rVMY97Ai0XrwTxQ6hxxzVoXRyg==
X-Google-Smtp-Source: ABdhPJyWGVqiWuUu86c5IJghtk1J5YM6TctRo7f/E+kTp1Vsao7JtgkV0qzdV8GS/iR14Vvu8NXjyQ==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr38031076wrx.524.1638286892057;
        Tue, 30 Nov 2021 07:41:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id l2sm2962792wmq.42.2021.11.30.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:41:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v11 0/6] gpio-sim: configfs-based GPIO simulator
Date:   Tue, 30 Nov 2021 16:41:21 +0100
Message-Id: <20211130154127.12272-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the eleventh revision of the simulator.

As there was no reasoning with configfs maintainers for many months,
this time the whole concept of committable items has been dropped. Instead,
each configfs chip item (or rather a group - more on that later) exposes a new
attribute called 'live'. Writing 1 to it brings the chip on-line (registers
the platform device) and writing 0 tears it down.

There are some caveats to that approach - for example: we can't block
the user-space from deleting chip items when chips are live but is just
handled by silently destroying the chip device in the background.

In v11 the configfs structure has been deepened to allow creating
multiple banks per platform device. The sysfs interface has changed so
that the gpio_simX attributes are now under the bank's device node and
not the platform device's.

v1 -> v2:
- add selftests for gpio-sim
- add helper programs for selftests
- update the configfs rename callback to work with the new API introduced in
  v5.11
- fix a missing quote in the documentation
- use !! whenever using bits operation that are required to return 0 or 1
- use provided bitmap API instead of reimplementing copy or fill operations
- fix a deadlock in gpio_sim_direction_output()
- add new read-only configfs attributes for mapping of configfs items to GPIO
  device names
- and address other minor issues pointed out in reviews of v1

v2 -> v3:
- use devm_bitmap_alloc() instead of the zalloc variant if we're initializing
  the bitmap with 1s
- drop the patch exporting device_is_bound()
- don't return -ENODEV from dev_nam and chip_name configfs attributes, return
  a string indicating that the device is not available yet ('n/a')
- fix indentation where it makes sense
- don't protect IDA functions which use their own locking and where it's not
  needed
- use kmemdup() instead of kzalloc() + memcpy()
- collected review tags
- minor coding style fixes

v3 -> v4:
- return 'none' instead of 'n/a' from dev_name and chip_name before the device
  is registered
- use sysfs_emit() instead of s*printf()
- drop GPIO_SIM_MAX_PROP as it's only used in an array's definition where it's
  fine to hardcode the value

v4 -> v5:
- drop lib patches that are already upstream
- use BIT() instead of (1UL << bit) for flags
- fix refcounting for the configfs_dirent in rename()
- drop d_move() from the rename() callback
- free memory allocated for the live and pending groups in configfs_d_iput()
  and not in detach_groups()
- make sure that if a group of some name is in the live directory, a new group
  with the same name cannot be created in the pending directory

v5 -> v6:
- go back to using (1UL << bit) instead of BIT()
- if the live group dentry doesn't exist for whatever reason at the time when
  mkdir() in the pending group is called (would be a BUG()), return -ENOENT
  instead of -EEXIST which should only be returned if given subsystem already
  exists in either live or pending group

v6 -> v7:
- as detailed by Andy in commit 6fda593f3082 ("gpio: mockup: Convert to use
  software nodes") removing device properties after the platform device is
  removed but before the GPIO device gets dropped can lead to a use-after-free
  bug - use software nodes to manually control the freeing of the properties

v7 -> v8:
- fixed some minor coding style issues as pointed out by Andy

v8 -> v9:
- dropped the patches implementing committable-items and reworked the
  driver to not use them
- reworked the gpio-line-names property and configuring specific lines
  in general
- many smaller tweaks here and there

v9 -> v10:
- make writing to 'live' wait for the probe to finish and report an
  error to user-space if it failed
- add the ability to hog lines from the kernel-space
- rework locking (drop separate locks for line context objects)
- rework the sysfs interface (create a separate group for each line with
  a constant number of attributes instead of going the other way around)

v10 -> v11:
- rework the configfs structure to represent a deeper hierarchy that
  gpiolib supports, namely: multiple banks per platform device

Bartosz Golaszewski (6):
  gpiolib: provide gpiod_remove_hogs()
  gpiolib: allow to specify the firmware node in struct gpio_chip
  gpio: sim: new testing module
  selftests: gpio: provide a helper for reading chip info
  selftests: gpio: add a helper for reading GPIO line names
  selftests: gpio: add test cases for gpio-sim

 Documentation/admin-guide/gpio/gpio-sim.rst   |   93 +
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-sim.c                       | 1592 +++++++++++++++++
 drivers/gpio/gpiolib.c                        |   26 +-
 include/linux/gpio/driver.h                   |    2 +
 include/linux/gpio/machine.h                  |    2 +
 tools/testing/selftests/gpio/.gitignore       |    2 +
 tools/testing/selftests/gpio/Makefile         |    4 +-
 tools/testing/selftests/gpio/config           |    1 +
 tools/testing/selftests/gpio/gpio-chip-info.c |   57 +
 tools/testing/selftests/gpio/gpio-line-name.c |   55 +
 tools/testing/selftests/gpio/gpio-sim.sh      |  396 ++++
 13 files changed, 2236 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.25.1

