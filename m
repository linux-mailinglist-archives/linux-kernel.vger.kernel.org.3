Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D904C56CBB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiGIWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGIWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:32:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D95C17587
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so2596115wrq.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZUSt9Tt5os109kFol/I1IAKuqoRAPWohLRw8A+Kqco=;
        b=UujOAH5qpbAiqUs0kF5Zk+ZXQz+QlLYSnKuDUMkFUjnp6NHazRoxgYr6ktJgR7G3ku
         fqlFXwRgQ3wfbfX74XUNGdiddNv4eUMUlcV4su1M3aUnMHWZe3I7Hdm6Doz/U8RrDC55
         7eW9N8iFEtBV3O1N/XvdhU/xdb/a7ABO6yRZUcQ7bPjiSlPUcip9J3r3gTBUIIdFV/nw
         Yxs322LVolFzbJ1RcBT1xwq4ITkMyZ8mPkqRuGxcq177YSzkS2impJwU7N3eUT8VRjG2
         U6o8PJf0kiGuxKs9wUEW+GE70OdWgzcsK/u+czJjmuo17ei9BCJrrIXwnGsnhHdPWzgO
         YWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZUSt9Tt5os109kFol/I1IAKuqoRAPWohLRw8A+Kqco=;
        b=0K39J5eQwtKO5HnEZgtnvv/4kUcLFUH4nSA9wt6nSIac9hmZtaq1YYhdJuldLzDGqU
         /bjtBemuQDykcqvy0P3LHW5koDjhLoNcofR90QV4D0ovRaJMvQRWbDwzFI3krBQuK02j
         2eVi0xx2Ps+t6b4JaWqvjfUB5JBgGOUspHrFtgCFvLi8VErfaxIYabgaQAKW7kXRwJJc
         JA/A5VFV2C2gX5HQ18hQ1RWZu/0Poz0hY95rsYd1638Z4IZk4Tbp3oXQ0KfIYKeJuGKC
         FvgTnmc3ZBENpolMd+qASd5xZUJUSwd1oRWnz6gyX6726mgOpac2olnywQPewqNv0VVi
         k49g==
X-Gm-Message-State: AJIora/tmW/0CCy7M4owzF73V2cDTn2NpZZyYavQ3cWk0miQyxaMpkYM
        tU9W+Tk1LpaUEEd8aKEpEI9Zwg==
X-Google-Smtp-Source: AGRyM1vMwBlwjPTO66pX6qDvlP5eqnSw2PHbGRjJrll9PZstswJfqWfd2jSRVBZesH9qqmggj2CJPQ==
X-Received: by 2002:a5d:4806:0:b0:21d:66a2:5a52 with SMTP id l6-20020a5d4806000000b0021d66a25a52mr9714932wrq.632.1657405961687;
        Sat, 09 Jul 2022 15:32:41 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com
Subject: [PATCH v4 00/12] thermal OF rework
Date:   Sun, 10 Jul 2022 00:32:17 +0200
Message-Id: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework initialization with the device tree appears to
be complicated and hard to make it to evolve.

It contains duplication of almost the same thermal generic structures
and has an assymetric initialization making hard any kind of serious
changes for more complex features. One of them is the multiple sensors
support per thermal zone.

In order to set the scene for the aforementioned feature with generic
code, we need to cleanup and rework the device tree initialization.

However this rework is not obvious because of the multiple components
entering in the composition of a thermal zone and being initialized at
different moments. For instance, a cooling device can be initialized
before a sensor, so the thermal zones must exist before the cooling
device as well as the sensor. This asynchronous initialization forces
the thermal zone to be created with fake ops because they are
mandotory and build a list of cooling devices which is used to lookup
afterwards when the cooling device driver is registering itself.

As there could be a large number of changes, this first series provide
some steps forward for a simpler device tree initialization.

More series for cleanup and code duplication removal will follow.

Changelog:

 - V4:
    - Added of_node_put(trips)
    - Changed naming 'ntrips' -> 'num_trips'
    - Updated documentation for added and renamed fields in the thermal
      zone structure
    - Fixed bad parameter type 'thermal_zone' -> 'thermal_zone_device'
    - Clarified there is more cleanups coming in the changelog
    - Put 'trips' and 'num_trips' fields all together
    - Made git-bisect safe the series

 - V3:
    - Removed patch 1 and 2 from the V2 which consist in renaming the
      thermal_zone_device_ops to thermal_sensor_ops and separating the
      structure. I'll do a separate proposal for that after the incoming
      cleanups

 - V2:
   - Drop patch 1/15 which contains too many changes for a simple
     structure renaming. This could be addressed in a separate series as
     it is not necessary for the OF rework

   - Fixed of_node_put with gchild not initialized as reported by
     kbuild and Dan Carpenter

 - V1:
   - Initial post

Daniel Lezcano (12):
  thermal/core: Remove duplicate information when an error occurs
  thermal/of: Replace device node match with device node search
  thermal/of: Remove the device node pointer for thermal_trip
  thermal/of: Move thermal_trip structure to thermal.h
  thermal/core: Remove unneeded EXPORT_SYMBOLS
  thermal/core: Move thermal_set_delay_jiffies to static
  thermal/core: Rename trips to ntrips
  thermal/core: Add thermal_trip in thermal_zone
  thermal/core: Register with the trip points
  thermal/of: Store the trips in the thermal zone
  thermal/of: Use thermal trips stored in the thermal zone
  thermal/of: Initialize trip points separately

 drivers/thermal/gov_fair_share.c        |   6 +-
 drivers/thermal/gov_power_allocator.c   |   4 +-
 drivers/thermal/tegra/tegra30-tsensor.c |   2 +-
 drivers/thermal/thermal_core.c          |  53 +++++--
 drivers/thermal/thermal_core.h          |  25 ++-
 drivers/thermal/thermal_helpers.c       |  13 +-
 drivers/thermal/thermal_netlink.c       |   2 +-
 drivers/thermal/thermal_of.c            | 200 +++++++++++++-----------
 drivers/thermal/thermal_sysfs.c         |  22 +--
 include/linux/thermal.h                 |  24 ++-
 10 files changed, 199 insertions(+), 152 deletions(-)

-- 
2.25.1

