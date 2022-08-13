Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB45591933
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiHMHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:18:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF15FAE8;
        Sat, 13 Aug 2022 00:18:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so2489106pls.4;
        Sat, 13 Aug 2022 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=hyi3W6o1iE4MzIUefZNiCk1gJXRkeduTAafJRxOanQo=;
        b=XW/WHHcMWmAnAdids+ycJAct2rwaYJhdU1Rw/mLfhwjOy7uq0etlH/xydBLhhtdBJe
         StvNysphzkTPi7CTd+VwGU1+/g9fzidNkH5ov3g3MOxdfi9K5Z3n//BjJRRHW1+8COzM
         8nrUbD3x4FnM9P4EniYCaz015zRD77ihsg/kbuROZCLDiAHgStRSghWxgn3xSImUvM+6
         9p7WIGQ51a+5wa3LIfpI6JfV1kISFJCiML1bXk35ECtWKKjIXfmTY9aJ3zopQ2rbtSZh
         8liSW7HN9Z+dxptN7bpX7pHngK1Yvh2y8cq52wS3i4aXoOFz72HCakUm1TTAS54CkpwG
         f7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hyi3W6o1iE4MzIUefZNiCk1gJXRkeduTAafJRxOanQo=;
        b=CUxP77inPcfmyc7010jq4KCU3NGq1lc25LbG+W9BLJVxszmfDdremp30oFfuNiXtwg
         oa3Dpw7Q2dLGI98dyanbPBOAa3BolVlFlyEXHr3jJszs1hf7HQRMx6gXSFwS0HXCxeG9
         r+QP0/cjG2Oyom0F741Nisu7Pz/sQa5LOh1YbWmFxxI6lzA+YcDstzZ9bUWu0U3A27VC
         XWzO7n4RFdXcX+c2zGiF6CC/71Cpdsb1JCOjOLaS0+/51Lh4SGA5W+bEAzoRqPaONZU6
         Ylajt6PySpOzHLSpaE5b69smTbCmT5aU0llm5vCXRG3D0gZZ0qoNNqa0d34XDSdLv2/t
         /S1w==
X-Gm-Message-State: ACgBeo08x4o0IlOysoeT/MrNHerR5XEqjjqp/zYC98J7ziTkhS8kNmfa
        JO0FyRKNL4mLwPlkKQ9Q0dE=
X-Google-Smtp-Source: AA6agR7C2jeUZU2JjNmTH16Li8AWDwoLtf72tfJhJ8LAeJj0mz1abAeGEG1jhy1EgncRID+zBE6aYQ==
X-Received: by 2002:a17:90b:1189:b0:1f5:1311:cd89 with SMTP id gk9-20020a17090b118900b001f51311cd89mr17357965pjb.181.1660375088048;
        Sat, 13 Aug 2022 00:18:08 -0700 (PDT)
Received: from localhost.localdomain ([115.99.250.21])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm2423001pgv.75.2022.08.13.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 00:18:07 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: Add single and double tap events support
Date:   Sat, 13 Aug 2022 12:48:01 +0530
Message-Id: <20220813071803.4692-1-jagathjog1996@gmail.com>
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

 Documentation/ABI/testing/sysfs-bus-iio |  41 +++
 drivers/iio/accel/bma400.h              |  13 +
 drivers/iio/accel/bma400_core.c         | 337 +++++++++++++++++++++++-
 drivers/iio/industrialio-event.c        |   7 +-
 include/linux/iio/types.h               |   2 +
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   8 +-
 7 files changed, 399 insertions(+), 12 deletions(-)


base-commit: 180c6cb6b9b79c55b79e8414f4c0208f2463af7d
-- 
2.17.1

