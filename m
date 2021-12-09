Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF52746E4B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhLIJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhLIJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:01:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17ECC061746;
        Thu,  9 Dec 2021 00:58:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6426336pji.0;
        Thu, 09 Dec 2021 00:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sBwRdSPNuRDWIA8Wm5gBhVfuyi+Iv8qULkfDYoJA8P0=;
        b=IQ7mun8KdelLvMVUQvjpG9LR1CBH8kXRxHaii6+I/J3Zhffy1ZCciSE6FTSfwzoHTe
         UpV4BTv1CV8dj+W65uMQag6ND9z0rFhTZ0tEFi1BD+S3iptqs8nD6CYyIfpGs22rA2JN
         Gj5RweihbAaJUbnE7ixyaLvAtkZaX1W5iUawHsWwRtgT1wqvEjy52ryaxnALbEzpicdW
         huHXqyc+JJIu5+e1pMvs3O0sbAHoKJJliy1s/lG8zcC80k6Mas/kTO7D6z3iqHvDNpQp
         VrNmmi7XA2CCckonUntsfQtUaRB6eBwLqS7mRd9z8VTJ9f66ita/WnASr+cB9dA6Ip38
         zMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBwRdSPNuRDWIA8Wm5gBhVfuyi+Iv8qULkfDYoJA8P0=;
        b=ze2gsVNEk/I1iWh5aHwEeGpmxW3xMHMP5MPUdEno9eyxTi/VSc8QQmCjrWjfVZpYMC
         8YsVBhYQR8i4k6uS2l/3fPU4deYVPYr2Y7kgZqj4bh2mFe5OwQmNuPbguLvFJmBPcv2m
         NkNOiA1QrazGBGeijNNlpSRfi5zZRAkQneWUMebldMO7hj58D903ov3PBVP2mIiH0nsy
         GgFGfmH4HQn0wLMaFmKnc8cFZQh+J7Qu/DET2awM6YdyLmdS2J/CZ2/dUYSyUu+1zahl
         O1JXBosQi60fzJxychXZeE4iNFLCioOyPwrUxTVxquNTlgTPYlluAQcyqEhKm3cWxCc+
         PuUQ==
X-Gm-Message-State: AOAM533/33IckEYKwcWrHXi+PsNQ+6AqU9iUKINdnN7loV9tNKtXAxUW
        FggOQSUjy5JfsIfEHu5XQq6Aef11KLg=
X-Google-Smtp-Source: ABdhPJwmDKoBxuWNU3OvGTiCFbZjsV4hExPGlzuo8uIA16/oKrC9IcYQmZarD103Om5X8CHQY93Cxw==
X-Received: by 2002:a17:90a:49c2:: with SMTP id l2mr14123493pjm.23.1639040288279;
        Thu, 09 Dec 2021 00:58:08 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id n15sm5008881pgs.59.2021.12.09.00.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:58:07 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v3 0/2] Add iop driver for Sunplus SP7021
Date:   Thu,  9 Dec 2021 16:58:07 +0800
Message-Id: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 .../devicetree/bindings/misc/sunplus-iop.yaml      |  61 ++++
 MAINTAINERS                                        |   6 +
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 395 +++++++++++++++++++++
 5 files changed, 475 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

