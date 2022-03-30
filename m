Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619C4EBE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbiC3KGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245128AbiC3KGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:06:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06020DA6FF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:04:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i4so9669188wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nM4nXFUdqosmsuyckEfB3BKyVpqwLHkB/6ppkQnz40=;
        b=uMq9xwyAOLfuw+I1C5mm/XMFFYfU90zueZVqRwglADw2pWXARSdzaqWDPU9/jIP095
         5StQ4PpFZ2qgImWAAJ9w9uL5mbfIr4+8s7vqL5buEEPET6fmuYgPTy11NkAECQ0HJDza
         rykpzkbGtYXIRqS4+l+eJmxKORrgxaov+0WDM9dFXl3Rsqoz0LF1rtWO1xPg82ZbUMvM
         b8DRWr/SYXvz+BywQGATi/j8vV4sB8N6bU3FsKqHMcZE0VsO49zUTYFt/l1jmh9UPnz2
         PYFs4euADtJH/MTwJ5OVwW7MNBQ8T7u5jypLwzVcvzsqmeql7DJkY7N7LgHV35Tqh8h9
         170Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nM4nXFUdqosmsuyckEfB3BKyVpqwLHkB/6ppkQnz40=;
        b=1l+kMQBXjB+N/59b9J9czdUpGQ6Vybfu3JzG9GME4kbh+nAdDrWazfzTAc5lyVZ5R4
         9AxAztswJ7Qrjj9Dn+KPniWN6NeZ5JcveBW/nmEeCs7uA1bsuXSswhHcMyKnnywCnQNq
         PdItGT891BuvPV8I3+UXzExIPVkH99VA9RRyD1aIt1DPk++dySY3ezUIMaQO3qhsRyNL
         40zm3LKIuAHzl3TJP+RNq3wBw0azxf/3Du0UFgrQev9G8PX0FK0m4BeBo3KWEarQ8I8S
         UrEs2UNjBK23gkI75rEN9S81/oJIukhAjJCk3Ezu4mfgOHG5d0/oUSqL/57hGDpCkSPv
         Dreg==
X-Gm-Message-State: AOAM533eOmTKL3OUYOBaGOKTwCRukSqDn2LL++pypPKj4KjbzaeEZzMz
        cDoYbwi3x+aB3b2vWmnqo3i1aQ==
X-Google-Smtp-Source: ABdhPJwp+5KHPDEsHaBvVPiKA8kh08lLLsuF0Tw/LaWK9aAP6BSnLl66vS+kTs5ymIGWQ/jfHhph2Q==
X-Received: by 2002:adf:fad0:0:b0:205:ad54:e51e with SMTP id a16-20020adffad0000000b00205ad54e51emr26182631wrs.650.1648634694428;
        Wed, 30 Mar 2022 03:04:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm16542743wrt.115.2022.03.30.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:04:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] tools/thermal: thermal library and tools
Date:   Wed, 30 Mar 2022 12:04:40 +0200
Message-Id: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

 v1: Initial post after a RFC

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

Daniel Lezcano (4):
  tools/lib/thermal: Add a thermal library
  tools/thermal: Add util library
  tools/thermal: A temperature capture tool
  tools/thermal: Add thermal daemon skeleton

 MAINTAINERS                                   |   1 +
 tools/Makefile                                |  36 +-
 tools/lib/thermal/.gitignore                  |   2 +
 tools/lib/thermal/Build                       |   5 +
 tools/lib/thermal/Makefile                    | 165 ++++++
 tools/lib/thermal/commands.c                  | 349 +++++++++++
 tools/lib/thermal/events.c                    | 164 +++++
 tools/lib/thermal/include/thermal.h           | 142 +++++
 tools/lib/thermal/libthermal.map              |  25 +
 tools/lib/thermal/libthermal.pc.template      |  12 +
 tools/lib/thermal/sampling.c                  |  75 +++
 tools/lib/thermal/thermal.c                   | 126 ++++
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
 tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++
 tools/thermal/thermometer/Build               |   2 +
 tools/thermal/thermometer/Makefile            |  26 +
 tools/thermal/thermometer/thermometer.8       |  93 +++
 tools/thermal/thermometer/thermometer.c       | 558 ++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf    |   5 +
 32 files changed, 2878 insertions(+), 3 deletions(-)
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

