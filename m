Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6E537066
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiE2Ixr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiE2Ixq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:53:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B828214E
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:53:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so10095996edc.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2NVO3ZVIRvilA1/pRJ16fJOodre9PqqgYbhhOtvAN0=;
        b=OCYQI50mHD8gfV2u3ESFy7gtVoDL/yro9bhNOW63bSHK58pTC6r9uquEyl4ZKYIWmB
         MVD3e2FZ+3sA3REYpONG8wWp/7JFWfQoTOIzK6S0kspYU1Im5rHNqL2UFmNFCRrlhGjm
         KJ0/txNrQ6dV9O+HPj55RAMiuCzW21AiqSoiFy02xwlOD6njgVKafDDp7uuKMjaP0+au
         XP92x7tRmNz4xHeO9F/YbmdvpIkmeXzCqlrCsPhDHBZUpkD1pQ8E4xICGx2zrfl1j6ED
         434POoNrQNGRlqU2EWfhUufLI+XKQzWHtqmfOn6Sxgs7z6NH82L/gkzJe2Z7a5jmM1y7
         CUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2NVO3ZVIRvilA1/pRJ16fJOodre9PqqgYbhhOtvAN0=;
        b=cpbUwi9q/SFWtjNcOiSZX4iwInPzNVPdi06XcnOxR2TGK6GHQ5JA1fYv5C1UgcnF54
         yTubX7ZhostVDvNtubo5hPsE0aHzGqD4FIIhHIqVMmBL0MgRod75cP3W0OpNIL7WTUhB
         K6RnmS5UkNEyToh4rQhVSNJvqef5x6L81DRE3Nk6FZPl2m1ZmyPahSM7RjFK//Hft2FZ
         4FdcptkP9ffcv/6d0FouLCUEUeslDJl94ZmhMh6DF0OSpt4gbNxJiwuTsew8h+CgIwaB
         MwYmge7srssWWb0b3EyMiVq1o0g7eMFcm4MXGShxVInUTd6mlwi88+m46B2p1VbNKCdj
         m4oA==
X-Gm-Message-State: AOAM5334rZXB6CWa07jMfif7edBuMWOa9iEsctquUN4G1qzmNAwP3+Mk
        y7LTJdPzfgcrAZzeZ8SWQB7FIIKjwlE00jnl
X-Google-Smtp-Source: ABdhPJzqXwXFEvb1roAvgF6allYHtXZLauAHhoyYXxFX4KDHJmQuobgBOO728lziRdRIBDv8PYZvWQ==
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr3113925edb.166.1653814423276;
        Sun, 29 May 2022 01:53:43 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z16-20020a50cd10000000b0042bac9df764sm4690507edi.27.2022.05.29.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 01:53:42 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/3] regulator: Add max597x support
Date:   Sun, 29 May 2022 10:53:36 +0200
Message-Id: <20220529085340.411018-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
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

The MAX597x is a smart switch with fault protection and sensor readings.

The MAX597X provides two programmable levels of overcurrent circuit-breaker
protection: a fast-trip threshold for a fast turn-off, and a lower slow-trip
threshold for a delayed turn-off. 

The MAX597x monitors voltages and current for fault protection. Allow to read
the measured values using the IIO framework.

MAX5978 has single channel & MAX5970 has dual channel.
Every channel has it's own regulator supply nammed 'vss1-supply' and
'vss2-supply'. The regulator supply is used to determine the output
voltage, as the smart switch provides no output regulation.
The driver requires the 'shunt-resistor-micro-ohms' to be present in
the devicetree to properly calculate current related values.

Marcello Sylvester Bauer (1):
  dt-bindings: regulator: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (2):
  regulator: max597x: Add support for MAX5970 and MAX5978
  regulator: max597x: Add IIO support

 .../bindings/regulator/max5970.yaml           | 144 +++++
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  18 +
 drivers/regulator/Makefile                    |   2 +
 drivers/regulator/max597x.c                   | 575 ++++++++++++++++++
 drivers/regulator/max597x.h                   | 116 ++++
 drivers/regulator/max597x_iio.c               | 139 +++++
 7 files changed, 1001 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max5970.yaml
 create mode 100644 drivers/regulator/max597x.c
 create mode 100644 drivers/regulator/max597x.h
 create mode 100644 drivers/regulator/max597x_iio.c


base-commit: 664a393a2663a0f62fc1b18157ccae33dcdbb8c8
-- 
2.35.3

