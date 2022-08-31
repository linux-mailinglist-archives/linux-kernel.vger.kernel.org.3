Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691A95A76A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHaGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiHaGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:31:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B546D5F202;
        Tue, 30 Aug 2022 23:31:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so14060030pjg.2;
        Tue, 30 Aug 2022 23:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=YWAShV8YZfHBQ9V1KHBqygpSP4XqwbQ+bpPaH2e34wI=;
        b=cIr1uW4eW+yIwc2E1wmBEGnJFerOPvUXYtY/5kq08xIDgJRiKLsTFDENxkR4wisYzj
         NhvaQhvXAcFNqOwL6D8XxJIXaiWIhzCFjyY8HPS48D+8pCKlC+fvEqXMEPCpAFrs1QHC
         Qb4ExIaxqo5Do+RxwZs5LbOiCpMRibzMDqql6FWbBl0E6rYLlfZmsUvLtDX8Bm6HH/fc
         6BIWX2CrrjSthXGQgCmHU0Tmgv/+wjnibEqa4dhI6sg50FrubZ2/jrXfpJfh0BfgBb/d
         HZNRp3bluju0pSv4/sVZ+gYzaxxDs1/hCT5SlEkLJ6Mt+ASCqIpYboEeo7vVt7YWNbdS
         kF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YWAShV8YZfHBQ9V1KHBqygpSP4XqwbQ+bpPaH2e34wI=;
        b=wHT43Q5sk7KUVwOBjV4s1XyViJDMkUfNNThWAt/gufnoZ6wsrNkLI1tCBRmTh/hpce
         lFkzpU/39Y2j62S+dKE3VeecZACigbl9gdDbztd9zHhb/HRyyu7N7Sd7B5CZHeKQBPq+
         dgcTp57dtBg3nbb4gwVm6eqENuC2PFukBfHTOFmnSiwad2DdOu9z/B6TT4ByY49GSIgH
         dUFu0qrRoszIgIg2ftOLzPxuyVvh1pW/SlmczaKln6jFR496xNtWgoRdVsjIu1J0TD0G
         4FpevZ6K8J4yYmgSMKwDDZCzmm8729OpYLnpjrlyY7plrvc5FSo7ZWQJhPQEX0BLecR9
         TMBQ==
X-Gm-Message-State: ACgBeo3E3fn0pPNRDpY87XCVSmml6YfzHe61jL9BqyrhFbi+IHNOHvZ4
        VvvcczeXDvszAwFrh7OecRI=
X-Google-Smtp-Source: AA6agR4t/Q7VZV1gHbT89eFvrAoVkSrvnR+hJ5W1paPb/Isz6yHWshgR/UJHztM68o9vekevUVTGzA==
X-Received: by 2002:a17:902:7b86:b0:174:231f:b6bf with SMTP id w6-20020a1709027b8600b00174231fb6bfmr24592003pll.172.1661927482370;
        Tue, 30 Aug 2022 23:31:22 -0700 (PDT)
Received: from localhost.localdomain ([115.99.190.245])
        by smtp.gmail.com with ESMTPSA id z30-20020a62d11e000000b0052d24402e52sm10362220pfg.79.2022.08.30.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:31:21 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: Add single and double tap events support
Date:   Wed, 31 Aug 2022 12:01:15 +0530
Message-Id: <20220831063117.4141-1-jagathjog1996@gmail.com>
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

Changes since v3
1. Added a macro for the length of the tap configuration arrays.
2. Corrected a grammar mistake.
3. Arranged the local variables in reverse Xmas tree order.

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
 drivers/iio/accel/bma400.h              |  14 +
 drivers/iio/accel/bma400_core.c         | 343 +++++++++++++++++++++++-
 drivers/iio/industrialio-event.c        |   7 +-
 include/linux/iio/types.h               |   2 +
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   8 +-
 7 files changed, 434 insertions(+), 12 deletions(-)

-- 
2.17.1

