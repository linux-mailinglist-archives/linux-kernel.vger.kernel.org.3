Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6586533F05
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiEYOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiEYOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:22:28 -0400
X-Greylist: delayed 1506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 07:22:26 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.67.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719B38B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:22:24 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 75F2E400CD68B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:57:17 -0500 (CDT)
Received: from 162-215-252-169.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id trVlnr8nEpk0JtrVlnGP4R; Wed, 25 May 2022 08:57:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eKrX6kNpVLed89fPLoyVC6rMPjDh7kXs0BzGvHfT6B8=; b=B0c95fhXKWngQ6wdmaJj6lZWtP
        8pKXzQmqK3qcqx//T7W/KOucQKt6F8O/sBg6RWUQ0NN5BhUcGk+W+oVf9lbqmCVGfTuAU3GHnXywk
        7vJBfLjrjY9Xq4E/5ZF4/+4f8dC9JCAQrM7hLpzNiYe8r4IrY0AKzSmuEgLuypokwi91l30lcRvuB
        64MKiwpUFYR1XsrhRWoNhnYwONNge9MFE8cqkzPDeSYjuN/d2kS0QF9F5PpEcjeNtH045j76hvoYD
        0F4rvOXLKQ4vQco9yls2BNBJX9jQR8tCcoKB758Oe4JiOWwYVmCGrPggTzTNVhoIirR4AL+EgVLae
        CRl1n/zw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58264 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1ntrVk-000P3Y-PB; Wed, 25 May 2022 13:57:16 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/40] hwmon: (lm90) Various improvements to lm90 driver
Date:   Wed, 25 May 2022 06:56:29 -0700
Message-Id: <20220525135709.2899592-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ntrVk-000P3Y-PB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58264
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
