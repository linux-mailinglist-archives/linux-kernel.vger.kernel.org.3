Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5058EDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiHJOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiHJOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:07:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0B6E2CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:07:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so17920412wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+X/pid24gIjSOOJVEmO9iW9i2TMfPX6OSEZMbd1Ah4A=;
        b=gnyGClV2Eo+ylgbSznKAc5xS0/tmKZAO4UhCDTCl41U/p55TPKgwPR205jZ/5T0NNe
         mY3nqNo1qLOKluMW3UrnNj8ixMO4DPxNfeG78dWzCFlMpZwy0An3nPbqnMH/Pu3k3jHe
         K6GZFuvkoavj36ycCk9OyOKuS8RV7Hz+XfMN4mWzTEoU6bVjwG+pectg5fg8LeXHYfj+
         bvKrrxRZuCt+QCZmTWQeXmDgN9yYvDHPiFy4eo6rhPjVWfARxcEdDk7WVDHB5ZnWP2er
         IZQRHo7eE3F4P/gUv3jyBC86Buv49fczLcrVszX/rb860r6Li9Nh0mPfO7PrlPsMhvOq
         Usgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+X/pid24gIjSOOJVEmO9iW9i2TMfPX6OSEZMbd1Ah4A=;
        b=mWfqwR/dsm9VHqO5yCJ3HDwFWHGdluGm04nndcQa3eVrbsJY5ljXfidBSg4ZoFM0PN
         lHtRfUuut9IdsnrLEh0tMWSQQJgO+mZmRDLiADRStVq0TSawjojUu3rkXHoPVHx3LRvZ
         XemLV6MN90HFNTZthjI5l4bYO7dyODfHdVjcKAxT1ckF5Eg5Axw4j/b1TfDgxs/XCzvv
         xpJqq0fx9F/jWBxKRgaJ2IzPDGbvD+nnP8gLa4LH5Cl7Wpubh3w2bnywu3AeSiGNDmLV
         SCKl98H0Eq98U0XBwgA2hc0H0QRcfYGTgvI3PfD9m21RH67Ear1cs+TEbYR5aiVzgaoA
         P/FQ==
X-Gm-Message-State: ACgBeo0hfq38tHrc8U9xORKmR04sJe1eq55dEUAraEahk6BjGiz1fc8x
        WTDBbi1+hL+ryMpPDTKabb9vbw==
X-Google-Smtp-Source: AA6agR568HfoJRNkXemPCbfg6p3C2Czwqa7Z3xR7SRRYgOaUQkt3jPpCLL397aCfk2kqvqSLfbNdaQ==
X-Received: by 2002:a05:6000:2a4:b0:220:687a:cda9 with SMTP id l4-20020a05600002a400b00220687acda9mr17324057wry.187.1660140460789;
        Wed, 10 Aug 2022 07:07:40 -0700 (PDT)
Received: from localhost.localdomain (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm16258229wrj.47.2022.08.10.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:07:39 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v4 0/3] ECAP support on TI AM62x SoC
Date:   Wed, 10 Aug 2022 16:07:21 +0200
Message-Id: <20220810140724.182389-1-jpanis@baylibre.com>
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

Modifications since v3:
	- Migrate driver from IIO to Counter subsystem
	- Minor modification in yaml ($id) to match Counter subsystem
	- Add ABI documentation

Userspace commands :
	### SIGNAL ###
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
	echo rising > polarity1
	echo falling > polarity2
	echo rising > polarity3
	echo falling > polarity4

	### COUNT ###
	cd /sys/bus/counter/devices/counter0/count0

	# Run ECAP
	echo 1 > enable

	# Get current timebase counter value
	cat count

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
  dt-binding: counter: add ti,am62-ecap-capture.yaml
  Documentation: ABI: add sysfs-bus-counter-ecap
  counter: capture-tiecap: capture driver support for ECAP

 .../ABI/testing/sysfs-bus-counter-ecap        |  64 ++
 .../counter/ti,am62-ecap-capture.yaml         |  61 ++
 drivers/counter/Kconfig                       |  14 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/capture-tiecap.c              | 634 ++++++++++++++++++
 include/uapi/linux/counter.h                  |   2 +
 6 files changed, 776 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/capture-tiecap.c

-- 
2.25.1

