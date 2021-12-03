Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4311D467E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbhLCTsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:48:14 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:47927
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240365AbhLCTsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:48:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7ScbS20REGnR4VuVbe6Lm3LADnQq3LX4aht+cyo6gilowWbbp0DA7bDoxAwDhhfaBKpqZuBtp+4pAyyyqbiDXAJ+JVz40VfofzQZkykdMN2pOM/GyYoPj+3IleqgZxeFjlS6AjyCbAPIiPzuJ98nqKqiSG92PTKK8tg5FeZ0mBZoJTuqm+5JAHCq/hyjq0yNgREtzSV/+YkBxpx/qANkregTloMjBRAEzGOPyeDkvzzapx7EMKftnmnrSAbb6uzHCDtyzvBtMWeqpYnqcQQXme4aBnhAJmvTeOA/KTAFvwC4R9zYfSiQgUXZ16VdQbQICcPOAt13wy0B0tDOPNvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/DtsEQo+tAVkXc90kPNq2NW9xCT/shdmhfjIK4k59o=;
 b=A44B2K6QIKyNaX4TXCaovr4ftV5SLjU/2u14F/oc6SxXlsMyGsdr7IwTvIeq9shlta2u8tZtcINzOlD8kfYW6pVidwUxAdCK84fRZNTrdyhLrpEg6tHrHSz6KLnwt0LHPS2HnQBC/BOw7yVBmtJYQ9H5WywnVWQ3uMu5PoxbdClFKPyspxe4Z6vU80Agzo83IUhw0EYgi6fdY9mEwSzuy89dodbflk124NIzcyiG9hL4kiWwcgyn9EuXtp0Nf9LL8fG52/hjHBLe0X54czo3VyAYIIo/6dMPAckVTk03HU8jps8a6wREFQO1GXCg5KleX+Df8ptvKASbgi5q9+oJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/DtsEQo+tAVkXc90kPNq2NW9xCT/shdmhfjIK4k59o=;
 b=hssbCM1rpEAfe3RrNGw0egaAkguSdzLP766R8MjAvyIj2Wy6H8Wn7BAVlWbMsvKpotW/cjxNEv845YPBScUwq4uj7z6MKzZFvCJ3Mlyj9zGlDUl9+wWmCmyYMdOOVx+br2Xi0MhdR6jnm7zHFPvQITfq/CJS312bkIbVikTWxxv4YKEiXvPEI6AE2C22S7LQiVUjQbS7p3SS7B3lVgPl8G+RYSct23JO3F47MlYsm3VRI1xLk/6ejP25xx9kAo1tVd+eDkJaK0ZhB6T8JCnR5yzRDwekV84kKZVplTS/OGBsswl5B7qXn+LsuLVr96PpqtSZkjBzj0w6eJw5OPGSyQ==
Received: from OL1P279CA0017.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::22)
 by PAXPR10MB4814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 19:44:46 +0000
Received: from HE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12::4) by OL1P279CA0017.outlook.office365.com
 (2603:10a6:e10:12::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 19:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT041.mail.protection.outlook.com (10.152.1.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 19:44:46 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Dec 2021 20:44:45 +0100
Received: from md1za8fc.ad001.siemens.net (139.22.45.74) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Dec 2021 20:44:45 +0100
Date:   Fri, 3 Dec 2021 20:44:43 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v4 0/4] add device drivers for Siemens Industrial PCs
Message-ID: <20211203204443.01a92b3f@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211126141027.16161-1-henning.schild@siemens.com>
References: <20211126141027.16161-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.45.74]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2505fd99-9aeb-4093-568d-08d9b6955c57
X-MS-TrafficTypeDiagnostic: PAXPR10MB4814:
X-Microsoft-Antispam-PRVS: <PAXPR10MB48143AD7A3BAA80479848EE8856A9@PAXPR10MB4814.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWIN3pFQtuMMcvnExOvFrqLdFPzSPx/e8EPOvKNbC/KhAL5I5hRsk29S4mQwcjAvV4bDgDjtsJAoPADhmuhno9qkwo6jHPYO2FPZOCtu3yHNvZSFJ2iKFD8Lds+tKFScsPDRQ61JdilkoEr8xeLzXhXTYnyoR+XIss/FkrLboblaqA1jiUN/elkES5+yKkSo60igLeltdgqwtM7ti4jHuBCIL8dJNuCQVg3PpsdOVqwGUUW6fABfhCDfvyQ4XKDX6gPzzec4Lv8M0OfKLPjXCNSp8mvGT6542qEG6QoKDl/JHkIRgcHHzBlsU+epZ0w3TZPbnJS+woazwMPA5hbesUqtB6+xFP4WKSZ5wVGo8IsGl8LTFg9ENFvuAIszuoXZ9YCFWjv/8d7XZOeK6HRHnhOK1oWUxGE6MXzOTISy7665jvXF1CD3xkjtZp9Jn4QxI5rl95iu7n6iebX7Fz49f06DNzDBZU9AF7TW6sk5kIpg8zcaADua4pJAT9Bl+HsP8joG7+OPXlkrn6Hr4ZjOSR2XJY0X5Qkc4m7CniRhAghu7G/LdD173esyHRgGVAv6VgeNaRRL0ykyRhUsp8sOMwYadkYYas+A9vyXYdTyk1xvzHr4dH8cJ/wB45OVyvXHJ1VF92X3euHTR9r7DD1aJZjQK2EarHryRtHmLhefegOZhcUw05X/CGoBVx1OWzIorftaW7s0/OLyzsIZj9SrT/CoKTDEZPI5x98OfFG5KbvuncVK3im+7tTfq76WhLMp3CW8GnkUYXpyOpJcVOGkiiU7xxSNSmCKOUOs8/NmjCEUd3wkEO8yXtss+aJCkHng
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(956004)(508600001)(55016003)(36860700001)(70586007)(16526019)(316002)(44832011)(4326008)(5660300002)(40460700001)(1076003)(82310400004)(7416002)(9686003)(54906003)(110136005)(7636003)(7596003)(356005)(8936002)(8676002)(186003)(83380400001)(70206006)(47076005)(26005)(2906002)(86362001)(82960400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 19:44:46.4308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2505fd99-9aeb-4093-568d-08d9b6955c57
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

to me it currently looks like a v5 will only differ in terms of
documentation and could be acceptable to all people who have raised
concerns on v4.

Will send that v5 soon. And invite anyone to please raise further
concerns, or review again.

regards,
Henning

Am Fri, 26 Nov 2021 15:10:23 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v3:
> 
> - fix io access width and region reservations
> - fix style in p1
> 
> changes since v2:
> 
> - remove "simatic-ipc" prefix from LED names
> - fix style issues found in v2, mainly LED driver
> - fix OEM specific dmi code, and remove magic numbers
> - more "simatic_ipc" name prefixing
> - improved pmc quirk code using callbacks
> 
> changes since v1:
> 
> - fixed lots of style issues found in v1
>   - (debug) printing
>   - header ordering
> - fixed license issues GPLv2 and SPDX in all files
> - module_platform_driver instead of __init __exit
> - wdt simplifications cleanup
> - lots of fixes in wdt driver, all that was found in v1
> - fixed dmi length in dmi helper
> - changed LED names to allowed ones
> - move led driver to simple/
> - switched pmc_atom to dmi callback with global variable
> 
> 
> This series adds support for watchdogs and leds of several x86 devices
> from Siemens.
> 
> It is structured with a platform driver that mainly does
> identification of the machines. It might trigger loading of the
> actual device drivers by attaching devices to the platform bus.
> 
> The identification is vendor specific, parsing a special binary DMI
> entry. The implementation of that platform identification is applied
> on pmc_atom clock quirks in the final patch.
> 
> It is all structured in a way that we can easily add more devices and
> more platform drivers later. Internally we have some more code for
> hardware monitoring, more leds, watchdogs etc. This will follow some
> day.
> 
> Henning Schild (4):
>   platform/x86: simatic-ipc: add main driver for Siemens devices
>   leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
>   watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial PCs
>   platform/x86: pmc_atom: improve critclk_systems matching for Siemens
>     PCs
> 
>  drivers/leds/Kconfig                          |   3 +
>  drivers/leds/Makefile                         |   3 +
>  drivers/leds/simple/Kconfig                   |  11 +
>  drivers/leds/simple/Makefile                  |   2 +
>  drivers/leds/simple/simatic-ipc-leds.c        | 202 ++++++++++++++++
>  drivers/platform/x86/Kconfig                  |  12 +
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/pmc_atom.c               |  54 +++--
>  drivers/platform/x86/simatic-ipc.c            | 168 +++++++++++++
>  drivers/watchdog/Kconfig                      |  11 +
>  drivers/watchdog/Makefile                     |   1 +
>  drivers/watchdog/simatic-ipc-wdt.c            | 228
> ++++++++++++++++++ .../platform_data/x86/simatic-ipc-base.h      |
> 29 +++ include/linux/platform_data/x86/simatic-ipc.h |  72 ++++++
>  14 files changed, 778 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/leds/simple/Kconfig
>  create mode 100644 drivers/leds/simple/Makefile
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
>  create mode 100644 drivers/platform/x86/simatic-ipc.c
>  create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
>  create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
>  create mode 100644 include/linux/platform_data/x86/simatic-ipc.h
> 

