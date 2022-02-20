Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A414BCBBD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiBTCrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBTCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:46:58 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDD5FA0;
        Sat, 19 Feb 2022 18:46:37 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so11233140pga.5;
        Sat, 19 Feb 2022 18:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=j08tqWBEN8h5E9YAL/mlMShWRnLDdiaTyKWwQQyWLNc=;
        b=Z+J/50E99oxKUrebYU0PNuHC3HioU3MRIqrj+OikTOW9pU+oNj5ela/0bX9ThlJShc
         veMYhv75jt3ExqLWXWk/uFProit/bYozw9BRf0BUJBc7b+LP16OsAgH5HOYecki1uUZ5
         3owG9UUQiO6d1XGIHzdhYwLTYWCqCr+ZckJpZ/yTeePkEtgeWr8rk5TToVZ94WAva7GD
         lL+Sb1rwwJHH1Edb9plriXJRY/N38bWgPGQbWpUgvkpL6T3K8rhh891QCNnMnuPyeHy1
         h1lI9tHYdkMtKFDbjmg/Hl2BOVFW5s3hAU3/8497n4MOdUdGzKJIHXx/ZjPIKTTplw9a
         Y9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j08tqWBEN8h5E9YAL/mlMShWRnLDdiaTyKWwQQyWLNc=;
        b=EsI25Hw5F635VKGe1eN8Lgmlm/L2ijHUO3Ruq2ivAn5dh6fG7HU+fKCrRCSTEsw2lj
         IrviKIp0ird20asB/g5NTgizIoYA7iXZgJhgn6xgJAovlxV3To/HA3xnb9Bm9TWghkhf
         vkaOKb0oD9awmp9tnFAP043Em/2ukUWD93a42PBqJnpfQGxcdNkrdQIbDuG6zduh89kv
         MMibb9f5vtDeHjVSqJv369o1nq4esKYq+wxhbRUdktlTB+xeDkT83cTDUroC/TAtVAgc
         e1ppajIvOMU/YUBaOpUl/Noc0QM0v7AHZS7HHwNF5wzYrGaO8aVoR4192rY8DfbSoh1f
         tnpA==
X-Gm-Message-State: AOAM531+H2GD/sstoNK6eovhUCk6UTmELIXFgkRxlZO9dsAT6ta2PWkI
        olme/yDrzO/ns++N7QjHZl4=
X-Google-Smtp-Source: ABdhPJzmdYqoxrt26EOLftsJtDYYhE+hpXj3Mr4y7RjSpQ+GD7UHbbl9qDx9WOz+A61he3D3gsGEsQ==
X-Received: by 2002:a63:10c:0:b0:36c:6dd0:44af with SMTP id 12-20020a63010c000000b0036c6dd044afmr11571935pgb.41.1645325196978;
        Sat, 19 Feb 2022 18:46:36 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:36 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] iio: potentiometer: Add support for DS3502
Date:   Sun, 20 Feb 2022 08:16:25 +0530
Message-Id: <20220220024632.4183-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

Changes since v3:
1. Dropped the chip type switch statement in read_raw function.
2. Added device specific read function pointer in their structure.
3. Added two separate functions to read values from two different types
   of devices.

Changes since v2:
1. Addressed Andy Shevchenko comments.
2. Adding device name in Kconfig file.
3. Spliting up of patch into 3 patches.
4. Adding channel info into ds1803_cfg in separate patch.
5. Dropping the use of enum in firmware data instead using previous
   pointer method for accessing device specific data.
6. Separate patch for using firmware provided data instead of 
   id->driver_data.
7. Adding DS3502 support in separate patch.

Changes since v1:
1. Fixes the alignment to match the open parenthesis in separate patch.
2. Adding available functionality for ds1803 driver in separate patch.
3. Moving maxim_potentiometer members into ds1803_cfg structure.
4. Droping of the INFO_ENABLE channel type.
5. Firmware entry with data is used instead of id->driver_data to
   to retrieve the chip specific data.

Jagath Jog J (7):
  iio: potentiometer: Alignment to match the open parenthesis
  iio: potentiometer: Add available functionality
  iio: potentiometer: Add channel information in device data
  iio: potentiometer: Change to firmware provided data
  iio: potentiometer: Add device specific read_raw function
  iio: potentiometer: Add support for Maxim DS3502
  dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/potentiometer/Kconfig             |   6 +-
 drivers/iio/potentiometer/ds1803.c            | 153 +++++++++++++-----
 3 files changed, 121 insertions(+), 40 deletions(-)

-- 
2.17.1

