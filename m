Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF75A19C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiHYTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHYTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:46:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA25721F;
        Thu, 25 Aug 2022 12:46:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f21so21294763pjt.2;
        Thu, 25 Aug 2022 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=phvXPw0XdkiODNy/kS+Pv7T5j0DMBhcOd/sLWO1Yx70=;
        b=qSTCYSbWBt/iuyJ5M+3WQ+0JKgm5ZSuv0duWEiP8soEfkk4wIXdXKHAxF8KN7k5BDi
         3FZcOsYOCSxuNW1lbVFI75R9Weun+VMTK/+sccAk1J0u7VDcVJ3YNsJ5v4KSI/NXTGxH
         KZkYgWod/K2zqzn4tYywaoZNiqp0hraHTtNjuMggLtp7TYwAoJDWcpuwTG8isOgEMilf
         sb+2C8oIK5JhVqheMA2FVcFE2vhEeSzzym1E7uFwlPp1QjL5EZ/pHyv2UhhqzWWb/FGr
         PrABK8AbXj/y99zTtVUMLYcT2MKzkvGTjSLDmcoegxEEgOc3GOZ6zpj/Yj/xkl3VCV71
         M14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=phvXPw0XdkiODNy/kS+Pv7T5j0DMBhcOd/sLWO1Yx70=;
        b=N7mnk/7nIKgYVgsXhH9RoRWFLsQ27b5P7yw3emWfgwAa81V6ljWn6Ar1uI7LstbzLa
         rBFnUZ3phX9tk4cbKOLvVc8LUXo5QDgr3Jv241CnC1zcjml0iLvPG3MTTxe/wTZaY2kI
         zVikw7czx7QKHlewN+QFizRmuKaW33j860ezKxnqJd0RDCOWyhhbUzc69Tivc0ERMVLk
         iyCwig27e2dwBTJslaprxPgsM2kNW12PlzZ+Ft7xKbiCb9KdJT/EHLoSl6k6InHmCMkv
         J6CCabbzX6VeK5+JVu0VH9ouUI8WlvObIwbo4FDP8hN7yaJCI5xvTNxGsF5jARzXFxB8
         A2mA==
X-Gm-Message-State: ACgBeo0Rbab+ynLXxirHGL2QDqqlXbPbwlPblCAkA8XZWIQI6Eb6tj0I
        9r7HBYOb6K4pp/0NW9MqOkE=
X-Google-Smtp-Source: AA6agR5zqSbctjUtIM+fHEMDJ3zDB24GXVc0jORouIpqrcA7Y7AVlYmG4IplCC84iP7iX1juPMrF9g==
X-Received: by 2002:a17:90a:181:b0:1fb:824:d33f with SMTP id 1-20020a17090a018100b001fb0824d33fmr647470pjc.225.1661456770306;
        Thu, 25 Aug 2022 12:46:10 -0700 (PDT)
Received: from localhost.localdomain ([115.99.106.178])
        by smtp.gmail.com with ESMTPSA id d32-20020a17090a6f2300b001f7a76d6f28sm108789pjk.18.2022.08.25.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:46:09 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: Add single and double tap events support
Date:   Fri, 26 Aug 2022 01:16:02 +0530
Message-Id: <20220825194604.15645-1-jagathjog1996@gmail.com>
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

This patch series adds new event type for tap called gesture and direction
is used to differentiate single and double tap. This series adds single
and double tap support for bma400 accelerometer device driver.

Changes since v2
1. Replaced doubletap_tap_2min to doubletap_tap2_min.
2. Added ABI docs for available attributes which lists tap configurations
   values.
3. Added 'tap' in the naming of available attributes which are related to
   tap configurations.
5. Added check for channel type in _read_event_value() and
   _write_event_value().
6. KernelVersion changed to 6.1.
7. Corrected typos.

Changes since v1
1. Included headers in alphabetical order.
2. Changing tap_event_en variable name to tap_event_en_bitmask since it is
   used in bit manipulation operation.
3. Assigning boolean value to step_event_en and activity_event_en instead
   of 0, since they are boolean type members.
4. Using local variable for regmap_read() instead for *val itself.
5. Correcting typos.
6. Remove of IIO_EV_INFO_PERIOD.
7. Now all 4 tap controls like threshold, quiet, tics_dt and quiet_dt can
   be configured from the userspace.
8. Introducing new event info IIO_EV_INFO_RESET_TIMEOUT, and
   IIO_EV_INFO_TAP_2MIN_DELAY into iio_event_info.
9. Creating custom read/write attributes for tics_dt called
   in_accel_gesture_maxtomin_time.
10. Time based tap controls can be configured in seconds instead of raw
    values.
11. Provided all available values for time base tap controls in seconds.
12. Adding one more MODULE_AUTHOR().

Changes since RFC
1. Corrected the "quite" typo to "quiet".
2. Added proper reference and name of the section from datasheet.
3. Changed the ABI documentation to make it more generic.
4. Added ABI documentation for double tap quiet period.
5. Added available list by registering new event attribute for tap
   threshold values and double tap quiet period values.
6. Sending both single and double tap events separately.
8. Removed checking for tap enabled while changing data rate.
9. Returning invalid with error message if the input data rate is not
   200Hz while enabling tap interrupts.
7. Added datasheet reference for interrupt engine overrun.


Jagath Jog J (2):
  iio: Add new event type gesture and use direction for single and
    double tap
  iio: accel: bma400: Add support for single and double tap events

 Documentation/ABI/testing/sysfs-bus-iio |  69 +++++
 drivers/iio/accel/bma400.h              |  13 +
 drivers/iio/accel/bma400_core.c         | 343 +++++++++++++++++++++++-
 drivers/iio/industrialio-event.c        |   7 +-
 include/linux/iio/types.h               |   2 +
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   8 +-
 7 files changed, 433 insertions(+), 12 deletions(-)

-- 
2.17.1

