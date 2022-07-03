Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65456491F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiGCSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGCSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:31:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDB2BDF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:31:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n4so3036337wru.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/dQAlLb9v0K7wDs4Mx74hQuc1qbwjyUP7a9c6lw8sM=;
        b=oLbUcXtBpX6fAcaggVlgw4WsyVqOvXWDZfNFeyC1D5CM+bU4wrGCIlTXmTopAqKVu5
         DHG2acHSVNYWC0PQPZxanNly/re9NfDqxwTO3riBCsRdTvJuweYgQk5KHXva7naCMR3l
         W8wdsEuGMn4MG9fjqTVgggXnJNE8oxH6sPU40ItFA2Ddw/g2vA4ZOxfJcaworoeMxmvH
         HF7sCSX3MkE/Ido3ToP3c8qBTgyi3mDG256YpoPes2DlaL3zaB4kyQhRjSdUW64+ySw0
         fzJ06lb/ftjPSzjimXTXpLOjaOSGnvXogoqIdEYsP0B0bou5Ji2KpYydPeBwXJvYqUe0
         1jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/dQAlLb9v0K7wDs4Mx74hQuc1qbwjyUP7a9c6lw8sM=;
        b=11zMMU4iluFfXA5hjbPs9Jlke2438VIeJSzpbMI+wgH1sA2S85DiUrq2cA13gG9w4l
         iD/1l62abXJhYMpDXaB7pt+HEuLbOKj5rMdlAqPXu88r1mEdGH7z+psVndyJk/t3soaP
         IaUd6KMvA2h0LhQ7c2sFn6Jud+OR3yHyfkVEqSpPtMHNU+mNPY0b0NpuG2b9ikX0Sq9T
         pvzyEHMjeM/1upBeIni5c+Zjb1n7Up/x35/RuYyWkG8Zan1/CG6tP7bfUOjsBowa1maG
         OZzn5GqP9hF3lrdLa0WGgcdo5oj6/oB3kJ78OobseDTo6iyPpnhI5TaX9jySZfy5ZXJO
         pZ1A==
X-Gm-Message-State: AJIora+Rx4spum1pucE7JE/Ktdy/mZqyPHtw8CI+GAGLdhAmcJoR+S6R
        ofFNenV+PExjsEdLnvQ30sRJUA==
X-Google-Smtp-Source: AGRyM1sec14U0eJBHYfcXAY2ZiqrxrnNBq3qFb8ihWW8/qqdsMXvv/8oI9Wg1n2moyIwtzUsfA/KVg==
X-Received: by 2002:a05:6000:ca:b0:21b:8082:7518 with SMTP id q10-20020a05600000ca00b0021b80827518mr22429233wrx.124.1656873086232;
        Sun, 03 Jul 2022 11:31:26 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com
Subject: [PATCH v3 00/12] thermal OF rework
Date:   Sun,  3 Jul 2022 20:30:47 +0200
Message-Id: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

Changelog:

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
 include/linux/thermal.h                 |  21 ++-
 10 files changed, 197 insertions(+), 152 deletions(-)

-- 
2.25.1

