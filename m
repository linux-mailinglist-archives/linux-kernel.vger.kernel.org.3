Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500064BB979
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiBRMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:54:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBRMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:54:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D129C119
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:53:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so14409120wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNcXzhgwzcz/2AjxcflJDokLtgtn2TJEhjz6dim6Ns=;
        b=YpqaUCTJzHC3bfwdWCPJ+Yh2AwMHP3DOjv03u4W1no9GXWsrntokNX8jKrdf5dQ7zU
         IJvby7pyQxj0tiOsFtxc9LJAEFCNEeJneuja3QXPUd8AEEVNWaB+gFSBGIZkrqc+me6a
         e0+abozOiHAoFKAXelkfDnCbTU2+NiqOj5Ds60s3idYbPjNyQfEHL2oJ4XsOefkFPcJ0
         RqMXsQgadUXLDS13mXJY0V2yKLW0v6A/UuUIpwt5Zubso9r7F+ZZMO4n1h83MGlc2jle
         1g3GPqvjWTGGqBFHJtGvUYXTtpcpDYZLD5C3a3kTDWisK+xwrlpTnK9yXzw2p9v6P1fV
         3V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNcXzhgwzcz/2AjxcflJDokLtgtn2TJEhjz6dim6Ns=;
        b=JDaGIxWBnU34g+E4dsJBRdutUQv8OcK1Hyx76Dy3nXXdDnitlHQq19mtmbnJPPopI+
         qjRZJNdiIwNYGLork9zcmtZvOh5lP29OZZ0QuOVX5pJaKriu040zwHPto76h5yRBM4PQ
         37m/kjy7yvRx2hn/fiZ0MvPdgJpj2JEf1bPfaR7WTP5XmtXYdxqCrjBINBS7X08LnkpL
         aByh3FyRwMbJ2LB39sAn67Nuc8uK9PYHHJZjhqMnod2uM1Nb8N7yWTsYgZnm37tZRZKn
         WUDsCCODfCYmUi9uYrJJDyaWudxT12C1KxlJUEk/1IiO1CcMRLUd4gZqh4W9zKppwL2r
         nS4A==
X-Gm-Message-State: AOAM533m8dg8CM25BIHRGkswnx3jsq+8JMCD64z9yk8aq6tGUjwVl2Vc
        t2BwmrKp0Cw96zqqND9y9i7lKUqCkQAQ5Q==
X-Google-Smtp-Source: ABdhPJwnHafTSJpYNRr+U1bder05gKs7s7H/+Lz4duoGFjxE7+G/4GyYmPoN7jGxYpKdUWMr8G7dGg==
X-Received: by 2002:a5d:6c6e:0:b0:1e6:16d5:b849 with SMTP id r14-20020a5d6c6e000000b001e616d5b849mr6088498wrz.498.1645188823625;
        Fri, 18 Feb 2022 04:53:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:5828:300b:5226:ef02])
        by smtp.gmail.com with ESMTPSA id p7sm17034011wrr.95.2022.02.18.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:53:43 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 0/4] Thermal library and tools
Date:   Fri, 18 Feb 2022 13:53:30 +0100
Message-Id: <20220218125334.995447-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a thermal library providing the basic callback oriented
netlink communication and events with the thermal framework, a temperature
capture tool and a thermal monitoring skeleton using the thermal library.

Changelog:
 - V1:
    - Took into account RFC comments (unsubscribe, error enum, thermal daemon
      renamed to thermal-engine)

Daniel Lezcano (4):
  tools/lib/thermal: Add a thermal library
  tools/thermal: Add util library
  tools/thermal: A temperature capture tool
  tools/thermal: Add thermal daemon skeleton

 tools/Makefile                                |  36 +-
 tools/lib/thermal/.gitignore                  |   2 +
 tools/lib/thermal/Build                       |   5 +
 tools/lib/thermal/Makefile                    | 165 ++++++++
 tools/lib/thermal/commands.c                  | 351 ++++++++++++++++
 tools/lib/thermal/events.c                    | 164 ++++++++
 tools/lib/thermal/include/thermal.h           | 141 +++++++
 tools/lib/thermal/libthermal.map              |  25 ++
 tools/lib/thermal/libthermal.pc.template      |  12 +
 tools/lib/thermal/sampling.c                  |  75 ++++
 tools/lib/thermal/thermal.c                   | 126 ++++++
 tools/lib/thermal/thermal_nl.c                | 215 ++++++++++
 tools/lib/thermal/thermal_nl.h                |  46 ++
 tools/thermal/lib/Build                       |   3 +
 tools/thermal/lib/Makefile                    | 158 +++++++
 .../thermal/lib/libthermal_tools.pc.template  |  12 +
 tools/thermal/lib/log.c                       |  77 ++++
 tools/thermal/lib/log.h                       |  31 ++
 tools/thermal/lib/mainloop.c                  | 135 ++++++
 tools/thermal/lib/mainloop.h                  |  14 +
 tools/thermal/lib/thermal-tools.h             |  10 +
 tools/thermal/lib/uptimeofday.c               |  40 ++
 tools/thermal/lib/uptimeofday.h               |  12 +
 tools/thermal/thermal-engine/Build            |   2 +
 tools/thermal/thermal-engine/Makefile         |  27 ++
 tools/thermal/thermal-engine/thermal-engine.c | 287 +++++++++++++
 tools/thermal/thermometer/Build               |   2 +
 tools/thermal/thermometer/Makefile            |  23 +
 tools/thermal/thermometer/thermometer.c       | 393 ++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf    |   5 +
 30 files changed, 2591 insertions(+), 3 deletions(-)
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
 create mode 100644 tools/thermal/thermometer/thermometer.c
 create mode 100644 tools/thermal/thermometer/thermometer.conf

-- 
2.25.1

