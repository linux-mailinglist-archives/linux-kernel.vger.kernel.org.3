Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECC578036
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGRKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiGRKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:51:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BF20194;
        Mon, 18 Jul 2022 03:51:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p9so11343807pjd.3;
        Mon, 18 Jul 2022 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=a4smhlXQRPY08uZFYWaREPplMOTenvaPYfLKafzeLgY=;
        b=AKe+sNy1gChpstieXUsxZD5p8A2lNFOyH78szTrmAd73Lmp2K1cEvITIVrP/MNLtCn
         2r85CO3G5vrj+Gvj8fta7XfmzIxRnJw3s/zWl0OwwdJI/rcG4+v1MnVy6hX+LHOYhrsD
         lEY/6Dz5TOoYMf8kgMvnROzDlMJ54F2Vk37i1Fc3ICDk3jH6X35iQ8aaMpO5l7Qh3Y2Q
         dCV7iSPYj8NJdoY+lpNLXAEjZl9beB3I1tgXxXbS0tvOJ1cb5axYI9HBMnk8gMQD/Rtc
         gXeOLoZi0ZA+MCHSbjmUVEpwfvZCAbgQsHrQDZBY8hHhm23jdSEXBVOAe94HIeqMwZi7
         iHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a4smhlXQRPY08uZFYWaREPplMOTenvaPYfLKafzeLgY=;
        b=XCM1m+DOeZpCvx19BoF4IEzqIkK6DO9U0Pmd2Q1Au6EpUZduI+t1c6rJ30uPh4wMDE
         7IYgQHTwMlUJZx2MZdEcfeX8S7bFwAbeNWXWl3c5/8hsZ9qzfNoEpGw4vL/x4Fm8OcCh
         yJLhkqoBQc7iy8xOyf2yJtXPKCF+5NaxARCnACVSzXKytPMYUJHV8hSbkRrxGjQD0tyh
         Eal7Wu4mBZ/D2pzHs19B8aQyfcMt4HXJqVBL+0z5eR77qXzWHsVmfib4tty4t4vLCxB2
         6WRba3g8Z6Vs/acKHESLOG5kYM0rYHdbE8mOril6Q8Yz4lW8DqnP3CNRExbZXqoC6SdU
         F7nw==
X-Gm-Message-State: AJIora+Ijic2lGyKXLD7DZ6kOf3jkakoZIOxCmL7veNy7gut8LKf5stD
        SshES9L2RX5w/G3iFnu6fMc=
X-Google-Smtp-Source: AGRyM1vWjlz2YT9znDMfpyN2OCP1gJjgGcm6C51sU4kd9nkBsZL7ktnoIxjmL2Pi8skCdAI/z5Sogw==
X-Received: by 2002:a17:902:ecc3:b0:16c:461d:802b with SMTP id a3-20020a170902ecc300b0016c461d802bmr27958364plh.167.1658141499900;
        Mon, 18 Jul 2022 03:51:39 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s2-20020aa78bc2000000b0052ac1af926fsm8914641pfd.20.2022.07.18.03.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:51:39 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 0/2] Add USB2.0 phy driver for Sunplus SP7021
Date:   Mon, 18 Jul 2022 18:51:18 +0800
Message-Id: <1658141480-9291-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for USB2.0 phy driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  phy: usb: Add USB2.0 phy driver for Sunplus SP7021
  dt-bindings: phy: Add bindings doc for Sunplus USB2

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 +++++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/sunplus/Kconfig                        |  12 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 297 +++++++++++++++++++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

-- 
2.7.4

