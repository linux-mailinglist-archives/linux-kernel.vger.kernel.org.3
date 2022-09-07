Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B15B0496
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIGNDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIGNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:03:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405D73935
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:03:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z21so9550715edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LYF/SK1vPylCdUwpD4P4v/QeiaAVJSuIswDjrTrYYOQ=;
        b=mya91vFpJDRQ2tZ0r51Nv1IqEkvKq7fTMWK6+xn+xOTk2es5TmGLIMlL0ao2reGczj
         GkAA1jH0AtT0Xs9t/N8SWn3AcIWZKR2mKAA8/mfhJDwtSfUSTIPSCD4UPbAoOBn1SKuS
         7+SVwiTheuxxOmKhDhyYQPdhUC0wQwuIDCpAA6KTgrhmhZQIP5aJmS2n9DeYlnlQS0/a
         uWbRCkMzh64Yg1D9WEOwjzETb3YKTbk8PvIhHfM/ezmKXcfEiOotR1Ue38gqzf3xdyNW
         OIO/EMG/xMtOEsCR2xB3IdmEKAq/7D+nqlU5sOduCUrhjxIbvHGMbPfTONUUBUF+biFm
         QLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LYF/SK1vPylCdUwpD4P4v/QeiaAVJSuIswDjrTrYYOQ=;
        b=jNxIaV0FUZsc9Z4T++K5tS7sp0U7GSnG5Jclxl0jAXUL9uQ3EF1ifwvsupDtIKF/ZD
         UnnbfbZ1ppy/ZmeFqrLVAQ/A5coHi5WmDa6BDVLQILdR8Dbmw8pKfGbZnwDT2Iat/a3h
         z45x9zQpdWCguErAK98/SPcoy91kmvJvLiEKghO+afiBMYoTFuCPZ/WOsozEpdUTbkEI
         Q98bdhAtfopoflJwTz7CXNRRr7jv3YAThykO/5wpqz3j2Ctvv9lT9+EmPxIplJj4oeAV
         bVItQ8fqexC+4w77nJbh0tgXRo3+wnPsY5p3jpOCwbsIOBfaEo8u56jLBcKjHnH/v5AZ
         hyjQ==
X-Gm-Message-State: ACgBeo2tbDfjhvl07MeVookI69JcoDH28gT2NcA4P3AmvRKt8mQIgdau
        wuDDzSBKiLS5DGgKQADuUekf7w==
X-Google-Smtp-Source: AA6agR4uilx384ILNrdh1stwfgkvaNWoNb8IouvPY4eYz1BuXCMXTnL5ajqutr4aIH92H7DElt+rNw==
X-Received: by 2002:a05:6402:280f:b0:44e:ee5c:da6b with SMTP id h15-20020a056402280f00b0044eee5cda6bmr3093463ede.256.1662555810391;
        Wed, 07 Sep 2022 06:03:30 -0700 (PDT)
Received: from localhost.localdomain (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id r16-20020a50c010000000b00447bd64d4f6sm10785000edb.73.2022.09.07.06.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:03:29 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v6 0/3] ECAP support on TI AM62x SoC
Date:   Wed,  7 Sep 2022 15:03:24 +0200
Message-Id: <20220907130327.139757-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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
timestamp capture events (0->1->2->3->0->...), edge polarity (falling/rising
edge) can be selected.

This driver leverages counter subsystem to :
- select edge polarity for all 4 capture events (event mode)
- log timestamps for each capture event
Event polarity, and CAP0/1/2/3 timestamps give all the information
about the input pulse train. Further information can easily be computed :
period and/or duty cycle if frequency is constant, elapsed time between
pulses, etc...

Modifications since v5:
	- Fix descriptions for capture items in sysfs-bus-counter ABI file
	- Modify TI_ECAP_CAPTURE help in Kconfig file
	- Replace ecap_event_id enum with defines
	- Add callbacks to reset nb_ovf & TSCNT
	- Modify action_read callback to serve both clock and input signals
	- Modify watch_validate callback
	- Replace 'count_cumul' with 'num_overflows' & 'ceiling' components
	- Replace one-based index with zero-based index for polarityX & captureX
	- Reverse clock & input signal order (0/1)
	- Move the check for overflow outside of the for-loop (in ISR)
	- Push each CAPx event to respective counter event channels (in ISR)

Userspace commands :
	### CLOCK SIGNAL ###
	cd /sys/bus/counter/devices/counter0/signal0

	# Get frequency
	cat frequency

	### INPUT SIGNAL ###
	cd /sys/bus/counter/devices/counter0/signal1

	# Get available polarities for each capture event
	cat polarity0_available
	cat polarity1_available
	cat polarity2_available
	cat polarity3_available

	# Get polarity for each capture event
	cat polarity0
	cat polarity1
	cat polarity2
	cat polarity3

	# Set polarity for each capture event
	echo rising edge > polarity0
	echo falling edge > polarity1
	echo rising edge > polarity2
	echo falling edge > polarity3

	### COUNT ###
	cd /sys/bus/counter/devices/counter0/count0

	# Get ceiling (counter max value)
	cat ceiling

	# Reset number of overflows & current timebase counter value
	echo 0 > num_overflows
	echo 0 > count

	# Run ECAP
	echo 1 > enable

	# Get number of overflows & current timebase counter value
	cat num_overflows
	cat count

	# Get captured timestamps
	cat capture0
	cat capture1
	cat capture2
	cat capture3

	# Note that counter watches can also be used to get
	# data from userspace application
	# -> see tools/counter/counter_example.c

	# Pause ECAP
	echo 0 > enable

Julien Panis (3):
  dt-bindings: counter: add ti,am62-ecap-capture.yaml
  Documentation: ABI: sysfs-bus-counter: add capture items
  counter: ti-ecap-capture: capture driver support for ECAP

 Documentation/ABI/testing/sysfs-bus-counter   |  45 ++
 .../counter/ti,am62-ecap-capture.yaml         |  61 ++
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-ecap-capture.c             | 653 ++++++++++++++++++
 include/uapi/linux/counter.h                  |   2 +
 6 files changed, 777 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c

-- 
2.37.3

