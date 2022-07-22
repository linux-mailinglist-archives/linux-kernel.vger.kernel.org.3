Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56C57E7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiGVUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiGVUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210EE52E55
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v13so92740wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3j7KdP9diKndVr49hY7R5tOEchn8S7gnNI8IEoVqXc=;
        b=hV0JT1g0753+tBm9fMshVZ2sEgZ5B9ZEa18ZoTNcWXQWia4/LtRgE6ce5WR9uyzOC4
         03JYij9aZYnX5dGL1imPWcDgZul1UjnJqRIK/xREy6SsE7SRkYzAq//LQ7oX8iyy00Xf
         YgymQNCb3tvEBq0p+SJz+jCvdhVXmZxKREvd7WgHE1ZanYZQ9cvFy22UADXJiAH05sES
         8DVOH1dCpQFEaS0rm4fZTPLFo4z6ULt5i8z3kellO8C8Jdw8fs6087PzTKmFqJ40AGtM
         D5VtU40bdww/LIY/YDKOfb8h+G/tPAJAUyGdaysJzKx06HsxfbUNnICGO7xDu8G72izg
         RyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3j7KdP9diKndVr49hY7R5tOEchn8S7gnNI8IEoVqXc=;
        b=RZojoaqDvs39dcoPT9gJgZXDqwZt5Iol2uej5j3H2meLlFJ7Vxd2C/CpmQymw4tzW1
         f6D500pKNf3FFHKnrQdBFUmbwZ9DU5b2FmDbR3h/K5040SRLPNDT1ynqZrSfW3Cf4Tk5
         y95SSc95OFQFjcwGSvaIJiR2SNQ0rz55ga/Alz5qDYWaBNw7MLcM2cIZuQja5pY75GpP
         TIRg+F3X1goVYUu1An6g3ef2Z24Pj+ryVT+xBHRxSoceaAC5KKx1AN2VYgkd9lPZK/GV
         VbRmCEmVBwrxzrJbvocG4QdMWipugkZ7VPL2kjeY6EVBrNw0mhyva38ISxiFn5adRist
         YWGA==
X-Gm-Message-State: AJIora/lN51bwDuoArKqKU+KcM2vXEiJfg4uOxYX7KoO52MxbaC1/rNm
        OMPqNfwm0mZIWC7+aOS5Jekt2g==
X-Google-Smtp-Source: AGRyM1uUeYLs8NrRNK1OIGIy/VCdePWCDGTvxbwnaShq1ewnyjm/o5XlQ69K8zBXapP6wnjwY5+lNw==
X-Received: by 2002:a05:6000:18c1:b0:21e:4712:b284 with SMTP id w1-20020a05600018c100b0021e4712b284mr894689wrq.545.1658520029437;
        Fri, 22 Jul 2022 13:00:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com
Subject: [PATCH v6 00/12] thermal OF rework
Date:   Fri, 22 Jul 2022 21:59:57 +0200
Message-Id: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

 - v6:
    - Folded patches 8, 9, 10
    - Removed thermal_zone_get_trips() and thermal_zone_get_num_trips()
    - Moved tz->ntrips => tz->num_trips changes into patch 11 to fix the
      git bisecting

 - v5:
    - Remove extra of_node_put() reported by lkp

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


Daniel Lezcano (10):
  thermal/core: Remove duplicate information when an error occurs
  thermal/of: Replace device node match with device node search
  thermal/of: Remove the device node pointer for thermal_trip
  thermal/of: Move thermal_trip structure to thermal.h
  thermal/core: Remove unneeded EXPORT_SYMBOLS
  thermal/core: Move thermal_set_delay_jiffies to static
  thermal/core: Rename 'trips' to 'num_trips'
  thermal/core: Add thermal_trip in thermal_zone
  thermal/of: Use thermal trips stored in the thermal zone
  thermal/of: Initialize trip points separately

 drivers/thermal/gov_fair_share.c        |   6 +-
 drivers/thermal/gov_power_allocator.c   |   4 +-
 drivers/thermal/tegra/tegra30-tsensor.c |   2 +-
 drivers/thermal/thermal_core.c          |  53 +++++--
 drivers/thermal/thermal_core.h          |  15 --
 drivers/thermal/thermal_helpers.c       |  13 +-
 drivers/thermal/thermal_netlink.c       |   2 +-
 drivers/thermal/thermal_of.c            | 201 +++++++++++++-----------
 drivers/thermal/thermal_sysfs.c         |  22 +--
 include/linux/thermal.h                 |  24 ++-
 10 files changed, 189 insertions(+), 153 deletions(-)

-- 
2.25.1

