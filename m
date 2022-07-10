Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79F756CF0F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiGJMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGJMfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A181115B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r14so3861003wrg.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iu8NsclK7JFmY+wUFMCI26v9YBeA0ybRek44nKEV3A=;
        b=DGAlXdSAhG+4S795iQscSCYdtXs/vNbFQ+rY+OZ7eVA890tEtOnvjBOhvEu+owT7as
         ML6JVCDa1n0HI+2QXrPWGSmNATt7V+KPOvuzzJEAbchHWonCTPxVIbyKjcrxZx5GG8G0
         rG8bS/juS6UV41Mjv93cj3k5Smcrk7/o39KOhOTc/ZnZIICczAMhiFdS1+bxrzx73zvV
         8WFUb0qd5insWjFfUPG5xJ9bu6/hEEpHuE99SP6aRWCX+AoAOOKtQfCaKAxjabzys/c+
         9QXr3qzOFBBdrxQ7YQtc8yCC5YtHhrAPr6/LZZ6SPP85Uplb/bFOqpeKkHxXla7nQTcE
         P6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iu8NsclK7JFmY+wUFMCI26v9YBeA0ybRek44nKEV3A=;
        b=1+aG4ul0mSfYrygllRbFfReFS/zTcH6ak1x/14BK+Nkwul3eWJjocO3Cu9eFuFCGca
         O8tFGl7FNDXGVvvR38Xv8xq4PHZxvHj0XE+3/MCdRWxf64gORUHd6xacwuIbh3CnVUoQ
         bHt8sqiZ7cSgvUSdLMabyPhHbQaeZNmkDXl70txeUc21nPCTB7qz1MmD2FPTWeZ9YdSn
         YlLvLW5Ued7Vgfvxeh8XU8pmhIJZlvEY22ZoLgQsOJlH2Z6ImuxQWLo61GihKh1rFBqa
         2HFccORcvsOXHyztycvf3aEVYutYvOeD5gvn8tIZGGBdR+xtqvdtPSQuYvDazhV6VE6E
         aweA==
X-Gm-Message-State: AJIora8QqPtmUI0AEhvRkdvdN50GZgwe1lPeGgJajryjERXc61SbJd3M
        uMeWUdc6uQuxuPV2vqIg+HyYHA==
X-Google-Smtp-Source: AGRyM1sIrwljPIVDaPkvGjTYdZohHb0FzDYL834CewaFtw/VWbFR2CkfMpUSnSUeB13fNR/4cDFLXg==
X-Received: by 2002:adf:d84b:0:b0:21d:6efd:efa with SMTP id k11-20020adfd84b000000b0021d6efd0efamr12198620wrl.384.1657456516470;
        Sun, 10 Jul 2022 05:35:16 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com
Subject: [PATCH v5 00/12] thermal OF rework
Date:   Sun, 10 Jul 2022 14:34:59 +0200
Message-Id: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/thermal_of.c            | 201 +++++++++++++-----------
 drivers/thermal/thermal_sysfs.c         |  22 +--
 include/linux/thermal.h                 |  24 ++-
 10 files changed, 199 insertions(+), 153 deletions(-)

-- 
2.25.1

