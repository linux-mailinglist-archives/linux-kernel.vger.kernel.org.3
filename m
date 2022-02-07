Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9924AB66C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiBGIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244786AbiBGILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:11:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767EC043181;
        Mon,  7 Feb 2022 00:11:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso2387705pjg.0;
        Mon, 07 Feb 2022 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BPjSWbh9AJ/hwlVO5qE57HHwxamYnP4dP25AlKlaQB0=;
        b=fljC4K8mp7UCV0YBMVphzhqbkGi6y6RWCT/EkUq7gpJt/RBphqFd0VUpS7a4gvGiDW
         1MvVxMOi6quLAZr/sq6O7CTd3gp3/VjoxVkvmTbWD8NnKvx+rn421HNz3NY/LKozZEpu
         hJ1Ur2sHlonWawIcw+hlDQXrtLmggy+NDPz/4Vt0i3z3lvj8svvcfQv4ktGcayPFHGiz
         gVCf0CcYzzJdnNWmRiskoMF0yJKa8XFcLPrrW/mMD41M5Rm3gA32hiMMeU8qgzzm9L+v
         8nZgnNQEi7yMvD14jvYfD0/i5KI0S8eOtZhms0MFY5iyczSAGkhvwXAoURKtXhHO5OV/
         Ubmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BPjSWbh9AJ/hwlVO5qE57HHwxamYnP4dP25AlKlaQB0=;
        b=hjP1hNVCpT/ykeYdkTP4UZB/UE1m5YTN5gyXmgIPSni5H0VwHMjls9bzkoU1uSz0CZ
         0W7Pggj0kx3awybOBgeHmo/aJpf5K0n5cxxAH+1bSBdax6Mi/WkZxWM1v1t70GEzY5sf
         DdLQU7IPzav3nO6Ay28jPOFTa7FOG9JnxIvx1SgzH4U2nuShLlHu5NMmN0fBT5yD2uBh
         nY1Vy6jK6jKmE2FBux6bQc6Z3ZY1ZYNuxSA+duJ0uatrtfs10pF32djNttyrF4uC5FWH
         5ScNeIjRd53oehyYHfgQYePmCdfGrgw0JUXlRzq10PYDgZU0Tp/k+VN+/4hJV6s76f1e
         HSQg==
X-Gm-Message-State: AOAM530m2SFs7dMmlVwffDE5kK8WFyZNIXu9cZX/9DsLbO2qMNAykZvW
        xPVejJfaFHHUyrIvVLTweq0=
X-Google-Smtp-Source: ABdhPJx7GFGlv+foTQZ4ZI/MYmg/49E0npi4U0C71AkA+B/UvYbzmgsZo2CrJryGWKM/d/EyYTxXGA==
X-Received: by 2002:a17:902:d2c2:: with SMTP id n2mr914582plc.76.1644221465677;
        Mon, 07 Feb 2022 00:11:05 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h6sm11774502pfk.110.2022.02.07.00.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:11:05 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        edwin.chiu@sunplus.com
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v4] Add cpuidle driver for Sunplus SP7021
Date:   Mon,  7 Feb 2022 16:11:14 +0800
Message-Id: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for cpuidle driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Changes in v3
 - Rearrangement #include sequence
 - Change remark style to /*~*/
 - Align author email address to same as sob
 - Optimal code
Changes in v4
 - According Rob Herringrobh's comment
   There is no need for this binding.
   Just wanting a different driver is not a reason for a duplicate schema.
   So remove yaml file and submit driver again.
   
Edwin Chiu (1):
  cpuidle: sunplus: Create cpuidle driver for sunplus sp7021

 MAINTAINERS                                   |   8 ++
 drivers/cpuidle/Kconfig.arm                   |   7 ++
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-sunplus.c             | 167 ++++++++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h |  19 +++
 5 files changed, 202 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

-- 
2.7.4

