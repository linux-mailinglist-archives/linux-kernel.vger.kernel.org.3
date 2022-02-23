Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B44C18B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbiBWQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiBWQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDC55BCF;
        Wed, 23 Feb 2022 08:35:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f8so20496986pgc.8;
        Wed, 23 Feb 2022 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=oH1ou976HmXhvnLbgu7IxgeGoD4+eYCbPOT2XRjgKEM=;
        b=jlsREVy8R49OrDspMhQiqfPgjB0/PK5psEoO54u0TavB4obO/MKWx6aTTR76F0Kr+h
         oet2VkFZ756FkA/XakrGIVvYz1lATkQe5DtwJjrufsNlmY4vwnfEyn0s4vLnC4LzEFDw
         cjyeF5YJcss6GxXzdqMbN+RTDKW4UAzYNHbRylGJ/MX4bEqHs/uSDAVRyzNsEt7je4Qb
         Qc37ysfzIf9jmIyAOGV8lkZe+LMRGaXh/a1qgwlz8qcSeoe90jz3gxZlj16f9Kjcqtq0
         eEMQj7PS8RDojDDxR7SnM4pTqUcZGybjjVOw22Iuand6EJhIcPdD9y9u686eB/CB63AQ
         TUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oH1ou976HmXhvnLbgu7IxgeGoD4+eYCbPOT2XRjgKEM=;
        b=oPv9jfmNTbsiC5TRnGXud2sZpw8FHXXC/l6KmweNGgV/MOPF0nO8sUjBY9OJ8s+BHY
         GbPWqzXmGqZA4HX8gGBFppM7708/r4pt1IakevNvirv6/V9RXpnxfEZOHPKynCgAT9e4
         pzXQIfG+Uq+x+qFUzovqJzZR0qV7UF1qzHzsZEANsaO8nMJ3xPjbVHoco0/i+T5Gmc7P
         L3uBgNkev4B25F4N+QMDGIckHwk5Ug3diLurinFroMSKxU+p6c6/nTBO6K6RXKtCsaKV
         DkPDl23r8o+xMFg0T+2A1y0RXKU2S/KFpuXNCq9bByZNG+M4wjJcFH6muoDqb1ULK24X
         5u1g==
X-Gm-Message-State: AOAM532OTRiye33WnL3vcT3Rm6Vc0smxm5FkJ85cq+IQIiA5boIUW+Zg
        5NUGrPyZDRPfh/wyjviYF8GQJKa3/O7ox/I3
X-Google-Smtp-Source: ABdhPJyKVIuMD+OERPktA5c9elzcOl+QUNj4Ucx2PRwK8DxnElZ6xWssEcbRHGUnRzhlPHJOPnC83g==
X-Received: by 2002:a05:6a00:24ca:b0:4e1:cb76:32da with SMTP id d10-20020a056a0024ca00b004e1cb7632damr538969pfv.81.1645634132533;
        Wed, 23 Feb 2022 08:35:32 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:32 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] iio: potentiometer: Add support for DS3502
Date:   Wed, 23 Feb 2022 22:05:18 +0530
Message-Id: <20220223163525.13399-1-jagathjog1996@gmail.com>
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

Changes since v4:
1. Included property.h header which has device_get_match_data()
   function prototype.
2. Removed blank space in tag block of the commit message.
3. Style changes for ds1803_cfg structure.

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
 drivers/iio/potentiometer/ds1803.c            | 170 ++++++++++++++----
 3 files changed, 138 insertions(+), 40 deletions(-)

-- 
2.17.1

