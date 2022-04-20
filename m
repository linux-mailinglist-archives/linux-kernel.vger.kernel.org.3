Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543D3508CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380402AbiDTQM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbiDTQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:12:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343DF11A08
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:10:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so4037802wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AagxDjZOYaXYkTVeSJD+8nkr2dQKgd1oEypSkLfkgM=;
        b=jXVGRegVbmClrs+10S74PNfRHe2h641HYf//7N0B9kC5CqdZpUce8QxilKp7sfdJDp
         71FB2JPyoWONdNod9Lx7pRlRPO1bqlRJSB46Uz5U7alLcmlxmW5Vg6U/xeeXjUtwjwKz
         Vs/Gc2tNUdby/YGUhyQKPiCcLRQhBNfFHqnerhr4Eu0cs3DjXdMSuFXj4kstUMchCrXb
         vqGhQNF5prxB6Qw5FfigTOpHfnQtM9yfvp6qDCmQa98bk8q+CAIUbtn08MS7jCDbYIH5
         OK9w5wfMGKUTuTtDrA+H0hK0YqbDdICxlko0QHcQjjxK2Fg97ppQAr5xgsUZEnaLcsTo
         kANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AagxDjZOYaXYkTVeSJD+8nkr2dQKgd1oEypSkLfkgM=;
        b=Wym/HbirGQ/J9Ik88Df6GDNAR6EdB2sUrRLHeY5pptyCDZJeZGWQWcEOUExhcs74vw
         HvA5ZrgQKe3HQ2g+3UPryzCYaEPUbZei8k0u+yK6hRWtdn62VcAA7IZH3JEDszfAEhN7
         nsVbI+GOcjfPdlmULc+rt+k8368b2iZKeDIqvsD3nFhzeY/qYw+CItgnP8fcpF8jD/xB
         Xk00Ob9el2/8SdlY+jTPImqh1WEEBi3dz79xD2u/ji+VBBnUXBElblXfR5Y6cA2p7jWw
         03j33qTameNSY8uIKfk+Rd9afLSEdBQLJsgE2XdB9qwoz57+/s0TKrTjFJSBB5uFHrqo
         PUvw==
X-Gm-Message-State: AOAM533nyjjhyIjuHPXqeIAvyu5xcXchyog2l6shsh27Z3yBcIXYht4D
        bQohaph+WiVZelMHOLg2hH9cLw==
X-Google-Smtp-Source: ABdhPJwRsfkE3BBucqjfpJs/m3iLruS51nCdliq/z8+daHVv6ilyRqugFwd5xHqfrgduOfn1+wNcFw==
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr4422755wms.69.1650471007726;
        Wed, 20 Apr 2022 09:10:07 -0700 (PDT)
Received: from localhost.localdomain (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id m1-20020a1ca301000000b003929c4bf250sm244836wme.13.2022.04.20.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:10:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] tools/thermal: thermal library and tools
Date:   Wed, 20 Apr 2022 18:09:28 +0200
Message-Id: <20220420160933.347088-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are providing the following tools and library:

 - A thermal library doing the netlink abstraction from the kernel in
   order to make the userspace thermal implementation easier. Having
   the library integrated with the kernel tree is also a guarantee to
   keep the message format and their encoding/decoding aligned
                                                                                                                                                                                                                                                                               
 - A thermal tools library providing a set of functions to deal with
   usual features like the log, the mainloop and the time. This
   library is used by the provided tools below

 - An data acquisition program to capture the temperature of the
   different thermal zone during an amount of time or during the
   execution of an application. The output is formated to be easily
   parsed by gnuplot, a spreadsheet program or a statistical command
   line utility. The timestamp is based on the system uptime, thus
   giving an indication of when a thermal event happened, that can
   help to spot or reproduce thermal issue in the long run

 - A thermal monitoring program based on the thermal library. It gives
   a skeleton to build any logic on top of it and shows how to use the
   thermal library. It does nothing except discovering the thermal
   zones, their trip points and listening for events like cooling
   devices state changes or trip point crossed

 Changelog:

 v3:

  - Fixed NULL pointer reference when there is no thermal zones, trip
    points or cooling device
  - Kill the child process when the duration ends or if there is an
    interruption in the thermometer
  - Add error messages in the main body for the thermal-engine

 v2:

  - Fixed all trailing whitespaces and some other checkpatch
    warnings. Some warnings remain but they can be considered as false
    positive

  - Added in the thermometer tool:
    - Usage/help option as well as a man page
    - The ability to execute a program
    - The capture duration
    - Create the output directory if it does not exist

  - Add in the thermal-engine tool:
    - A usage/help option
    - A message telling the userspace it is waiting for events
    - A daemonize option

  - Minor bug fixes here and there, as well as typos

 v1: Initial post after a RFC

Daniel Lezcano (4):
  tools/lib/thermal: Add a thermal library
  tools/thermal: Add util library
  tools/thermal: Add a temperature capture tool
  tools/thermal: Add thermal daemon skeleton

 MAINTAINERS                                   |   1 +
 tools/Makefile                                |  36 +-
 tools/lib/thermal/.gitignore                  |   2 +
 tools/lib/thermal/Build                       |   5 +
 tools/lib/thermal/Makefile                    | 165 +++++
 tools/lib/thermal/commands.c                  | 349 +++++++++++
 tools/lib/thermal/events.c                    | 164 +++++
 tools/lib/thermal/include/thermal.h           | 142 +++++
 tools/lib/thermal/libthermal.map              |  25 +
 tools/lib/thermal/libthermal.pc.template      |  12 +
 tools/lib/thermal/sampling.c                  |  75 +++
 tools/lib/thermal/thermal.c                   | 135 +++++
 tools/lib/thermal/thermal_nl.c                | 215 +++++++
 tools/lib/thermal/thermal_nl.h                |  46 ++
 tools/thermal/lib/Build                       |   3 +
 tools/thermal/lib/Makefile                    | 158 +++++
 .../thermal/lib/libthermal_tools.pc.template  |  12 +
 tools/thermal/lib/log.c                       |  77 +++
 tools/thermal/lib/log.h                       |  31 +
 tools/thermal/lib/mainloop.c                  | 120 ++++
 tools/thermal/lib/mainloop.h                  |  15 +
 tools/thermal/lib/thermal-tools.h             |  10 +
 tools/thermal/lib/uptimeofday.c               |  40 ++
 tools/thermal/lib/uptimeofday.h               |  12 +
 tools/thermal/thermal-engine/Build            |   2 +
 tools/thermal/thermal-engine/Makefile         |  28 +
 tools/thermal/thermal-engine/thermal-engine.c | 341 +++++++++++
 tools/thermal/thermometer/Build               |   2 +
 tools/thermal/thermometer/Makefile            |  26 +
 tools/thermal/thermometer/thermometer.8       |  93 +++
 tools/thermal/thermometer/thermometer.c       | 573 ++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf    |   5 +
 32 files changed, 2917 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/thermal/.gitignore
 create mode 100644 tools/lib/thermal/Build
 create mode 100644 tools/lib/thermal/Makefile
 create mode 100644 tools/lib/thermal/commands.c
 create mode 100644 tools/lib/thermal/events.c
 create mode 100644 tools/lib/thermal/include/thermal.h
 create mode 100644 tools/lib/thermal/libthermal.map
 create mode 100644 tools/lib/thermal/libthermal.pc.template
 create mode 100644 tools/lib/thermal/sampling.c
 create mode 100644 tools/lib/thermal/thermal.c
 create mode 100644 tools/lib/thermal/thermal_nl.c
 create mode 100644 tools/lib/thermal/thermal_nl.h
 create mode 100644 tools/thermal/lib/Build
 create mode 100644 tools/thermal/lib/Makefile
 create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
 create mode 100644 tools/thermal/lib/log.c
 create mode 100644 tools/thermal/lib/log.h
 create mode 100644 tools/thermal/lib/mainloop.c
 create mode 100644 tools/thermal/lib/mainloop.h
 create mode 100644 tools/thermal/lib/thermal-tools.h
 create mode 100644 tools/thermal/lib/uptimeofday.c
 create mode 100644 tools/thermal/lib/uptimeofday.h
 create mode 100644 tools/thermal/thermal-engine/Build
 create mode 100644 tools/thermal/thermal-engine/Makefile
 create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
 create mode 100644 tools/thermal/thermometer/Build
 create mode 100644 tools/thermal/thermometer/Makefile
 create mode 100644 tools/thermal/thermometer/thermometer.8
 create mode 100644 tools/thermal/thermometer/thermometer.c
 create mode 100644 tools/thermal/thermometer/thermometer.conf

-- 
2.25.1

