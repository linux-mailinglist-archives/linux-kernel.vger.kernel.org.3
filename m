Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98E4C0C32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiBWFby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiBWFbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:31:39 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47456D942;
        Tue, 22 Feb 2022 21:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645594245; x=1677130245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v44Gg2Pi51r7C5Yz0LglEBe7K1Ubw4buBZxC3226XpA=;
  b=kazKmxAFupOl/tUMRjhxJqGshBUJeh9xLNdkDg5qg8swLaDEZDHnW3st
   Pp3uw0rFRhIw0siyZ88X1JJubsmxKvUpjKkWslXZLoA79Go2a3vo3gCT7
   bfyiKSKP/+Wdj1TEPVBvdGkFdeuWI2mp0ChyQYvnzEVq2GokV/m5yLX/3
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Feb 2022 21:29:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 21:29:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 21:29:15 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 21:29:11 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <corbet@lwn.net>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <lee.jones@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <luca@z3ntu.xyz>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
Date:   Wed, 23 Feb 2022 10:58:54 +0530
Message-ID: <1645594134-16082-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220218183116.2261770-2-bjorn.andersson@linaro.org>
References: <20220218183116.2261770-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
with their output being routed to various other components, such as
current sinks or GPIOs.

Each LPG instance can operate on fixed parameters or based on a shared
lookup-table, altering the duty cycle over time. This provides the means
for hardware assisted transitions of LED brightness.

A typical use case for the fixed parameter mode is to drive a PWM
backlight control signal, the driver therefor allows each LPG instance
to be exposed to the kernel either through the LED framework or the PWM
framework.

A typical use case for the LED configuration is to drive RGB LEDs in
smartphones etc, for which the driver supports multiple channels to be
ganged up to a MULTICOLOR LED. In this configuration the pattern
generators will be synchronized, to allow for multi-color patterns.

The idea of modelling this as a LED driver ontop of a PWM driver was
considered, but setting the properties related to patterns does not fit
in the PWM API. Similarly the idea of just duplicating the lower bits in
a PWM and LED driver separately was considered, but this would not allow
the PWM channels and LEDs to be configured on a per-board basis. The
driver implements the more complex LED interface, and provides a PWM
interface on the side of that, in the same driver.

Tested-by: Luca Weiss <luca@z3ntu.xyz>
Tested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Tested-by: Satya Priya <quic_c_skakit@quicinc.com>

 Documentation/leds/leds-qcom-lpg.rst |   76 ++
 drivers/leds/Kconfig                 |    3 +
 drivers/leds/Makefile                |    3 +
 drivers/leds/rgb/Kconfig             |   18 +
 drivers/leds/rgb/Makefile            |    3 +
 drivers/leds/rgb/leds-qcom-lpg.c     | 1401 ++++++++++++++++++++++++++++++++++
 6 files changed, 1504 insertions(+)
 create mode 100644 Documentation/leds/leds-qcom-lpg.rst
 create mode 100644 drivers/leds/rgb/Kconfig
 create mode 100644 drivers/leds/rgb/Makefile
 create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c

