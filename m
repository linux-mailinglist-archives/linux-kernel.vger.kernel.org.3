Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A20C533E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiEYN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiEYN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2098D6BD;
        Wed, 25 May 2022 06:58:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q8so25048035oif.13;
        Wed, 25 May 2022 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKrX6kNpVLed89fPLoyVC6rMPjDh7kXs0BzGvHfT6B8=;
        b=Jzz8cUeANrOWUvYLI9PctwPv/wo6R1OCzmm0J6o8V2AF1sxbJ1ILXgXDeeYNH89fsI
         xJwE7Qin7OCYUJfngrpVdg9ZUwOgkrXkiX9l7qTRqWOlsLejkDvT6Is1yfK1LzEBQWO/
         RjBFEC7FkhqcW+CdpQKdNpApnAZXH4m+lFfYw31+NQCSWsKZylXgiONWr02G2rTrhufZ
         OGuTew3O9K3dfyBatzkL8MSDzqT6JOaQrpDiTZB6C7AoFNMggSOsQNNxSj7/cWgom27I
         TRhG+4iO3Yk6IfUnI4lzgcusCB/+4pHkCS4CR0fkPpRafsJ/q9+PL0u66rzkU2xy33YG
         W6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eKrX6kNpVLed89fPLoyVC6rMPjDh7kXs0BzGvHfT6B8=;
        b=n/CghCOOB3OiA6r5zVwl8PqsqbXxCKnRGPw3c0XxoG+iZtmrOOYEUdt4X9VhJYi2hv
         Pmm2PeY5XjPhYwmmK/j4kNpVd/2VEba1xkgaMudVLC25Frpi9tn3SuxatXrxh0gam9EQ
         z6+fRA/m1/SMW8FZNSUSIjcEAY4+145oI5jlwGl0mYD7Ozuge4sSYwjJ7IY0oNfPCP3c
         5kPQ9W5DD3K4UcSTTXRWpQP5iBV5Gwxb1OeIsPRXxu/VjODy0ZLSYZaH3hKqgP01NjxO
         GO//EL6O9RYFIL04ZVNoK4QFlOzmSIxyXmrI7gWOlGYasjIHE7GsGyAJY6wKzdaKscY4
         LSKg==
X-Gm-Message-State: AOAM533/zwjMpcAM2ejxFY4lWxOhP5jqQFFVP74SI2sRO7IIidRS7NV4
        qjxelyHD1WZig2PYUutoJP0EPDu+GvsVZA==
X-Google-Smtp-Source: ABdhPJzHMAjDAd5UTKnqEPadgdRIZAT/7Jt/PmgVfpJJ0mWQoI01zMHqNaIMB367OGjj0hLmcZ2RaA==
X-Received: by 2002:a05:6808:1393:b0:326:379a:507b with SMTP id c19-20020a056808139300b00326379a507bmr5338358oiw.288.1653487081665;
        Wed, 25 May 2022 06:58:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k23-20020a544717000000b00325cda1ff87sm6371877oik.6.2022.05.25.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/40] hwmon: (lm90) Various improvements to lm90 driver
Date:   Wed, 25 May 2022 06:57:18 -0700
Message-Id: <20220525135758.2944744-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements various improvements to the lm90 driver.

- Generate sysfs and udev events for all alarms
- Add support for LM84, ADM1020, ADM1021, ADT7421, ADT7481, ADT7482,
  ADT7483A, NCT210, NCT214, NCT218, NCT72, MAX1617, MAX1617A, MAX6642,
  NE1617, NE1617A, NE1618, GL523SM, THMC10, and MC1066
- Explicit support for MAX6648
- Handle differences between ADT7461 and ADT7461A
- Individual drivers for ADM1021 and MAX6642 are now obsolete.
- Improved PEC support. Some chips support PEC only in read operations,
  others support PEC for both read and write operations.
- Improved alarm handling
- Streamlined temperature conversion functions 
- Reorganized and improved chip detection code

----------------------------------------------------------------
Guenter Roeck (40):
      hwmon: (lm90) Generate sysfs and udev events for all alarms
      hwmon: (lm90) Rework alarm/status handling
      hwmon: (lm90) Reorder include files in alphabetical order
      hwmon: (lm90) Reorder chip enumeration to be in alphabetical order
      hwmon: (lm90) Use BIT macro
      hwmon: (lm90) Move status register bit shifts to compile time
      hwmon: (lm90) Stop using R_/W_ register prefix
      hwmon: (lm90) Improve PEC support
      hwmon: (lm90) Add partial PEC support for ADT7461
      hwmon: (lm90) Enable full PEC support for ADT7461A
      hwmon: (lm90) Add support for unsigned and signed temperatures
      hwmon: (lm90) Only re-read registers if volatile
      hwmon: (lm90) Support multiple temperature resolutions
      hwmon: (lm90) Use single flag to indicate extended temperature support
      hwmon: (lm90) Rework detect function
      hwmon: (lm90) Add support for additional chip revision of NCT1008
      hwmon: (lm90) Fix/Add detection of G781-1
      hwmon: (lm90) Add flag to indicate 'alarms' attribute support
      hwmon: (lm90) Add explicit support for MAX6648/MAX6692
      hwmon: (lm90) Add support for ADT7481, ADT7482, and ADT7483
      hwmon: (lm90) Strengthen chip detection for ADM1032, ADT7461(A), and NCT1008
      hwmon: (lm90) Add support for MAX6690
      hwmon: (lm90) Add flag to indicate support for minimum temperature limits
      hwmon: (lm90) Add flag to indicate conversion rate support
      hwmon: (lm90) Add support for MAX6642
      hwmon: (lm90) Let lm90_read16() handle 8-bit read operations
      hwmon: (lm90) Introduce 16-bit register write function
      hwmon: (lm90) Support MAX1617 and LM84
      hwmon: (lm90) Add support for ADM1021, ADM1021A, and ADM1023
      hwmon: (lm90) Add remaining chips supported by adm1021 driver
      hwmon: (lm90) Combine lm86 and lm90 configuration
      hwmon: (lm90) Add explicit support for NCT210
      hwmon: (lm90) Add support for ON Semiconductor NCT214 and NCT72
      hwmon: (lm90) Add support for ON Semiconductor NCT218
      hwmon: (lm90) Add support for ADT7421
      hwmon: (lm90) Only disable alerts if not already disabled
      hwmon: (lm90) Add explicit support for ADM1020
      hwmon: (lm90) Add support and detection of Philips/NXP NE1618
      hwmon: (lm90) Add table with supported Analog/ONSEMI devices
      hwmon: (lm90) Support temp_samples attribute

 Documentation/hwmon/lm90.rst |  233 +++-
 drivers/hwmon/Kconfig        |   17 +-
 drivers/hwmon/lm90.c         | 2415 ++++++++++++++++++++++++++++--------------
 3 files changed, 1832 insertions(+), 833 deletions(-)
