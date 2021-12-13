Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F31472BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhLMMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:18 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:32965
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229618AbhLMMFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp6TmfKL8pC5mRvMejfEvq5neWcNC/Ods4EF93Cd5tdypnt85mX0njWDjbGwm4bzp1cImZOGWie9ur95hJ270OfNtxfJunxqRWLlxHckYlSg/ZoqOObsCjVbueGWFe8KYNiM0iDa+dcT80FwmSh9ANkaA7pgisJIUoHlmVq7yw+TZcc55wgqJwzmshh6T/sbfe/wR1FS4BXcaOd8Yqxlcbe1dP9tSUo+JzYMfmcmhdqj8V+v7Qeo+wnQKR+n6eAaw2upzQ3o8aoZ60naoU6f0A0kP5YMi2H+KZB3i7NjlIPQJlLvYBUfCsSFgZV1ndD9nTyoIhV4UGuM1MjAHIoG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMAWZj7JtMho6QTTu3ke3PjJz/uK+VQkd7jSZRXmIKQ=;
 b=TZ77VuJS+ReTMyhEhXWqyuDm9+1YAGY0xxtt3lXaMg0moDukonyMonV1BnshelJSygMBCsiWHe+gKLOguRQGBnrjLjmm/WtEsUJfux+OmE6v7tFk89CyJikExTRhxZsT6p4hnWdzO+kRUzc50RVe96426QeH+/X2I0FfoKiZfrONbQojzRdNpgg+cNGw37xglw01+Ta09+ei2vnvY+D6+CNxLAIJUZGy4mtsCFWChc13Ub5rvhRv3VQMVIkR57dGhw5a2sQjMyNkvLcs884jInKMOr97xXmusedZsLXgFBuBQElBmpJ9feZoF0LSZkIBUT5jpQl+sPff5P89R/IILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMAWZj7JtMho6QTTu3ke3PjJz/uK+VQkd7jSZRXmIKQ=;
 b=NU3eZ7SxcSA3CnnZT481gP6UcbjUHzMKZ+nLiVpYiqcWwLuglA3mSggJGp7pjfPFckaMhhi2uciEc/OYhQvqe9m6FIX62cicHexz8bVTzuALpVsPGh4/yCnm5hwxZ6F8KJaOPnSG4U7yNmCzM8ZUbSTDNwiAmb7XgHWnjtQmzNEpj1yHv8HLK4vn8hM2a+AYviQ+4V/ugXCrkqslIIh5w7vYHUaHW8RDwryU7Nj3S9p3fGZbphcqspB4Xyzh6+t8bjEgS6kSIp+RhSNvnH3G+R1USVkwHZvAIAHJAb7tsnXzow9L6kpFEpQ/EZq8aDE05tFbp55XE2kzLP9W05wX9g==
Received: from DU2PR04CA0267.eurprd04.prod.outlook.com (2603:10a6:10:28e::32)
 by AS8PR10MB4661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 13 Dec
 2021 12:05:13 +0000
Received: from DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::5d) by DU2PR04CA0267.outlook.office365.com
 (2603:10a6:10:28e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 12:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT022.mail.protection.outlook.com (10.152.4.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:05:13 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:12 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: [PATCH v5 0/4] add device drivers for Siemens Industrial PCs
Date:   Mon, 13 Dec 2021 13:04:58 +0100
Message-ID: <20211213120502.20661-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94555f7-4896-4a7c-4769-08d9be30d1ac
X-MS-TrafficTypeDiagnostic: AS8PR10MB4661:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB46610579B4F6DED0A7E190A785749@AS8PR10MB4661.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJcizBIiSeU58JtJvUx56IPt+agryRKti+ew1O1HxQcF3IfvuHvYNhBVIbvt1OINyUExBotpF+oXHtwhmymHfKDRXnYx5AOreeC3aAffnofGikhETM0h9fmRnEdlvSUujZx2zvB9AJOMahfs5aWE6z17MLd8ZvoSnE/lypk7kFxovCn/TQ5B7QtI5Mw3Zeti7pHbcQOMcsiz1xyYidCG0H/4KriTjFKd/kdGOBdlbX+DkJJYbrtUibuxUUhxKh0bw1MG4hhO3OaaxgdUOAltF/AG03T/0oI3cQEaTnBuYnQu+TwvZjo06kpKlwgINOVEuZQvYJIWuJGD5O3Y8Az6QDEy0H+S/8ngGsZuziPzNaUqK//mAaR33bdea/U2FCCkhFIMF51vygvGMLJACM683cox3f0s5alXmErxdIQDqHvIBzoxB0CVHFkXLIqLiiUZArcRFMzAXTKw7BHGtA1FwiqrV162HPDvDthyaHsrElO/ajqzbkpGg+XYo4+Y2iKElN95NNW8cAzlzjYPAebKmDTISg8dvuyRyJ6P9RSaJNqDH1QnX9QGkvNgawedwjKk1KjhzWtwptZqnum25sM1TfQV1lu13x7WoXSKgL4tHefzczN0V1ZRcNfPYNh7rQNcM7BaLciiso12RHlfB0lGNYAXIJV6XhunotopEjvbpRJxIf/h+f3N25GGyZ9sRm1q0y3b43fZTCbDhqu8RsROXdHNQa26K5HXo6dxwiHU9OI=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(16526019)(336012)(36860700001)(4326008)(86362001)(2616005)(81166007)(8936002)(5660300002)(508600001)(6666004)(44832011)(356005)(70206006)(70586007)(316002)(186003)(110136005)(26005)(82960400001)(36756003)(1076003)(82310400004)(8676002)(956004)(47076005)(7416002)(2906002)(54906003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:05:13.4290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94555f7-4896-4a7c-4769-08d9be30d1ac
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v4:
- make everything around GPIO memory usage more verbose
  - commit messages, FIXME in p1, cover-letter

changes since v3:

- fix io access width and region reservations
- fix style in p1

changes since v2:

- remove "simatic-ipc" prefix from LED names
- fix style issues found in v2, mainly LED driver
- fix OEM specific dmi code, and remove magic numbers
- more "simatic_ipc" name prefixing
- improved pmc quirk code using callbacks

changes since v1:

- fixed lots of style issues found in v1
  - (debug) printing
  - header ordering
- fixed license issues GPLv2 and SPDX in all files
- module_platform_driver instead of __init __exit
- wdt simplifications cleanup
- lots of fixes in wdt driver, all that was found in v1
- fixed dmi length in dmi helper
- changed LED names to allowed ones
- move led driver to simple/
- switched pmc_atom to dmi callback with global variable


This series adds support for watchdogs and leds of several x86 devices
from Siemens.

It is structured with a platform driver that mainly does identification
of the machines. It might trigger loading of the actual device drivers
by attaching devices to the platform bus.

The identification is vendor specific, parsing a special binary DMI
entry. The implementation of that platform identification is applied on
pmc_atom clock quirks in the final patch.

It is all structured in a way that we can easily add more devices and
more platform drivers later. Internally we have some more code for
hardware monitoring, more leds, watchdogs etc. This will follow some
day.

The LED as well as the watchdog drivers access GPIO memory directly.
Using pinctrl is not possible because the machines lack ACPI entries for
the pinctrl drivers. Updates to the ACPI tables are not expected. So we
can rule out a conflict where two drivers would try and access that GPIO
memory.
So we do not use those pins as "general purpose" but as "Siemens
purpose", after having identified the devices very clearly. 

Henning Schild (4):
  platform/x86: simatic-ipc: add main driver for Siemens devices
  leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
  watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial PCs
  platform/x86: pmc_atom: improve critclk_systems matching for Siemens
    PCs

 drivers/leds/Kconfig                          |   3 +
 drivers/leds/Makefile                         |   3 +
 drivers/leds/simple/Kconfig                   |  11 +
 drivers/leds/simple/Makefile                  |   2 +
 drivers/leds/simple/simatic-ipc-leds.c        | 202 ++++++++++++++++
 drivers/platform/x86/Kconfig                  |  12 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/pmc_atom.c               |  54 +++--
 drivers/platform/x86/simatic-ipc.c            | 176 ++++++++++++++
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/simatic-ipc-wdt.c            | 228 ++++++++++++++++++
 .../platform_data/x86/simatic-ipc-base.h      |  29 +++
 include/linux/platform_data/x86/simatic-ipc.h |  72 ++++++
 14 files changed, 786 insertions(+), 21 deletions(-)
 create mode 100644 drivers/leds/simple/Kconfig
 create mode 100644 drivers/leds/simple/Makefile
 create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
 create mode 100644 drivers/platform/x86/simatic-ipc.c
 create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
 create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
 create mode 100644 include/linux/platform_data/x86/simatic-ipc.h

-- 
2.32.0

