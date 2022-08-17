Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788DE5970D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiHQOQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiHQOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:16:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966965F135
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay12so6762087wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=P5r4ekCJrYr4Y+g8V8poSTNr9XUYMCVSh5pQ+9u9UXU=;
        b=IXRJoVP1bBS+nD45/LRGKhOElxU+l/CChkL+FQ/dov+x3awC1TLAhWinmmYBlYgIo2
         ldtRaTHN5hgAp1O8M20wQj2gBtD8yp5+D3CTGthOlEirZk5uh+lR0FIPhP2ex4Wsrf7n
         n53YVfX44+nNExBsF7r+OrgQ+dO4gFscMR3pUcN9RR2rONd11+6B8Cv3ilFhC6waUbif
         7kGRCXgHBn820wBX9dLQgChLwK6AZ7GJygphgim8y3RvWE/rwJPjj1+srT+DlAW1gwBb
         G1dlJh5VxG6Bzj4ZRwx586E93xX0Jmej7O2NuTWwO8/hWZyHj6LaFUMqqfg3JWU8dG4/
         WRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=P5r4ekCJrYr4Y+g8V8poSTNr9XUYMCVSh5pQ+9u9UXU=;
        b=sr51RqvOjCfKiGPtUxC1QlesYUtrPgmZTYdcQ9uGzgN82o4BSs5sT+2Zjs6NePqQya
         x7kHMPNxBfXbwjEen9Cf9rMdfzVufYUyxigHPIL5+Gf3MnW5nE9gqFEqAjCMIq84v029
         1vmeVcpK+JkRzT7NiBuK/PKE53QEnS05eYz8dtC3Ut4ylpmcT6PYPmYr+s3tOR4KIIqI
         Ov/gyY0LDQ2sHRV12H1nKQ07NvGn5nFr94XEW+UomAGyCX+h1CW1FFO5xcjbZkB5B3sv
         L8ictiu9ZJE5l4l5QLODVC/YX1uWhNNnx/xGtj2h3Pyflb1az3IpoV8rApaZhTyxcgtu
         q68w==
X-Gm-Message-State: ACgBeo14E25NJH/M1ZGaMEuRlqhbuogttebHsroFk6nJAosv7NF7+eXl
        Vr1vsuqfJH5+sy9YnxX3jy2ZPGSXQybddw==
X-Google-Smtp-Source: AA6agR4lqd0J1oLsz4TNR7Opw4ENQK3FZq4B4qebkgtvcb1kfkl+lnlFhgUELK+zAxwQGz99duatWA==
X-Received: by 2002:a1c:4c11:0:b0:3a5:4d01:54be with SMTP id z17-20020a1c4c11000000b003a54d0154bemr2398339wmf.32.1660745791222;
        Wed, 17 Aug 2022 07:16:31 -0700 (PDT)
Received: from localhost.localdomain (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm2416533wms.25.2022.08.17.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:16:30 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v5 0/3] ECAP support on TI AM62x SoC
Date:   Wed, 17 Aug 2022 16:16:17 +0200
Message-Id: <20220817141620.256481-1-jpanis@baylibre.com>
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

The Enhanced Capture (ECAP) module can be used to timestamp events
detected on signal input pin. It can be used for time measurements
of pulse train signals.

ECAP module includes 4 timestamp capture registers. For all 4 sequenced
timestamp capture events (1->2->3->4->1->...), edge polarity (falling/rising
edge) can be selected.

This driver leverages counter subsystem to :
- select edge polarity for all 4 capture events (event mode)
- log timestamps for each capture event
Event polarity, and CAP1/2/3/4 timestamps give all the information
about the input pulse train. Further information can easily be computed :
period and/or duty cycle if frequency is constant, elapsed time between
pulses, etc...

Modifications since v4:
	- Modify yaml commit message prefix (dt-bindings)
	- Modify driver file name & Makefile (ti-ecap-capture)
	- Modify compilation flag name in Kconfig (TI_ECAP_CAPTURE)
	- Select REGMAP_MMIO in Kconfig
	- Add capture items to sysfs-bus-counter ABI documentation
	- Cleanup probe function (dev_err_probe & devm_clk_get_enabled & devm_add_action_or_reset for PM)
	- Enable/Disable device clock in suspend/resume functions
	- Add PM explanations
	- Add ECAP clock signal & 'frequency' sysfs entry
	- Replace elapsed_time & spinlock by nb_ovf (atomic_t) & 'count_cumul' sysfs entry
	- Add counter overflow event
	- Modify 'name' sysfs entry for signal0 & signal1 & count0
	- Modify watch_validate function
	- Add macros for callbacks related to cap1/2/3/4

Userspace commands :
	### SIGNAL INPUT ###
	cd /sys/bus/counter/devices/counter0/signal0

	# Get available polarities for each capture event
	cat polarity1_available
	cat polarity2_available
	cat polarity3_available
	cat polarity4_available

	# Get polarity for each capture event
	cat polarity1
	cat polarity2
	cat polarity3
	cat polarity4

	# Set polarity for each capture event
	echo rising edge > polarity1
	echo falling edge > polarity2
	echo rising edge > polarity3
	echo falling edge > polarity4

	### SIGNAL CLOCK ###
	cd /sys/bus/counter/devices/counter0/signal1

	# Get clock rate
	cat frequency

	### COUNT ###
	cd /sys/bus/counter/devices/counter0/count0

	# Run ECAP
	echo 1 > enable

	# Get current timebase counter value
	cat count

	# Get cumulated counter value
	cat count_cumul

	# Get captured timestamps
	cat capture1
	cat capture2
	cat capture3
	cat capture4

	# Note that counter watches can also be used to get
	# data from userspace application
	# -> see tools/counter/counter_example.c

	# Stop ECAP
	echo 0 > enable

Julien Panis (3):
  dt-bindings: counter: add ti,am62-ecap-capture.yaml
  Documentation: ABI: sysfs-bus-counter: add capture items
  counter: ti-ecap-capture: capture driver support for ECAP

 Documentation/ABI/testing/sysfs-bus-counter   |  49 ++
 .../counter/ti,am62-ecap-capture.yaml         |  61 ++
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-ecap-capture.c             | 624 ++++++++++++++++++
 include/uapi/linux/counter.h                  |   2 +
 6 files changed, 752 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c

-- 
2.25.1

