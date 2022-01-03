Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF148312C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiACMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:53:45 -0500
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:34784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbiACMxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:53:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJkK5f3VWuXNcgsoUi6xIS1CchIHS24/Ub6G3ATkjwZSADgiGjEUm1ANRVGPwSR/9E/RfgVE05L0up8WUm6aYMUuhcH8SB4bZnltcR5rfJveXmUluM5nGrEEYCdwtMBb29UosPifNF8rWgQIp6ebAruwSHUYjuHAoulFzWymXeB7bRqZmqIaVB8a0kM0GVd+2NknXg9efoIu0ccpi80J7yA09gbuAzJ648ioGATGEUogO3ndO1cj7T1I3SHbE28OW00vUE5hjZtPRrk9e4l4F1BDjxESV5a/dQDnRzIcSphjEnps8J5NYdp45sfLTqj8iNVCalnIm8Eh7r3TxuV3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmfGATzxK4wh9jah5VIVxLK23QoSNKCzIMwEN4QDHV0=;
 b=Qz1FkW0bhv0cJRto8+SMIMoDZFP8iSiDpXazXsqHsqbhfUzGXe+RXvKuUm1TGpker+Wab3veJLYVf8/hMpuwet1Ms/YKpfatRJlpWmZCfZSQsI4+tGB4rRl8O6g+xgQDlajlsXQnN8jDrDeEok9bBhtIvPfIXekDqCUYPvnkAwTW+kxc3LheYgyAWHEzDY6HkVer0qRR+DOuNwI+STOXxprYJGlA9gL+NTyrg+WE39TmI4JuWk+JzUGTQYxc6akjt7IFz9DPi053dn4V35FVVOP/XansKdmP8JKkWY2J8O1z4BAwe2dmrHXs6xRwFEBth5pi7bJB2ekv/M9WkinJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmfGATzxK4wh9jah5VIVxLK23QoSNKCzIMwEN4QDHV0=;
 b=G7/khJJg/YpyXEaMyjlC9ChOoDQlp0WmfTszDIUTu9gqyq40DBOPOlnZuFfyfsW2Rd6mkdEWjD7Zp1UEHw5izvndg8VJKdHWMruTg48Iv/9uIAYt/4sBLorH8tvQhGA843kXXZDAy+VVde5ARoAjFiYjUzNdGQ7YpeTfD4eLYvj5CnnJcD/jPs2Xuq9LETPylk9ZNggF+t97IRtCoXYuyAUZeebanOV/Lfr8iyVSoeZAkJl2moX9GWHP9qbpmUE+vePqH78enXF+m9dZLns9FqhJ++XwkSWQwDA6WiMEPBYoMxGJD9k2o7ZY/U8jxc02TAFSo0I5dSbhWposbRPbUQ==
Received: from AM6P191CA0091.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::32)
 by DB6PR1001MB0982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 12:53:40 +0000
Received: from VE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::37) by AM6P191CA0091.outlook.office365.com
 (2603:10a6:209:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Mon, 3 Jan 2022 12:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT051.mail.protection.outlook.com (10.152.3.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 12:53:40 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 13:53:39 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.68.217) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 13:53:39 +0100
Date:   Mon, 3 Jan 2022 13:53:36 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v5 0/4] add device drivers for Siemens Industrial PCs
Message-ID: <20220103135336.2fc44711@md1za8fc.ad001.siemens.net>
In-Reply-To: <674e8c50-ece7-9aad-7876-c739dbc96498@redhat.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
        <674e8c50-ece7-9aad-7876-c739dbc96498@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.217]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c345395-5d8a-4c8a-463f-08d9ceb810fc
X-MS-TrafficTypeDiagnostic: DB6PR1001MB0982:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB0982144A230A3AE180FC1E6285499@DB6PR1001MB0982.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++lpG6zy3PgI++p7ydQBNDHpBVqvm3Z1E5p49aCXF954LB0gn4GXK9ochMwGnyba7908t2A8F3I2ZIS/O7+XTBoQIdSngw+5tHbmmCRE2apY7FhinTfeZBXwHv650Z5DMLu9EXQlP8iiJtPto5LxK5yMC+UQD9JClnbtwuUUQcr+xsc7r/+pC14T1bCJDWoGOV5brnsCV5g6lB9Z03knTRviFuVj6fZ2Zgo7AQ8y+jfK8h3/kKEQEHU0WRKwSKbhhXsF1r00U865zGVLO3PXpOqnzRDHPbIVRLXjyLLShs4ogaReUgetqujtG4+3y17dxM/i38ryFgiP4NCMg6+egTuwqZtjG72+XiqoaXuPBhkUHUSUGWNfaRTS+9jQmLqM57k4Cj9GPsRXIWSQ7QvxS2ViLsgfoCgbViG+xT1xL8vBs+fe3DrsW6lpXZM8JOQKGQJBsDZKG7q89/XWA3uBPMILm3io/hU9NE7EfzMNlSX4+tSd5m4VbYSzZpfRowSnUOcskiAnr6DHpjmxnFv+eSuBcPsA883xdA65HHiKMPb5Y55VHkAG3NOXoVR7N8GGHwuClOb3+W1z/VWuFQR2Wwk2WJozuMlsVs7PJlURPgt0U8vk+bNWTKuDSv6B/ztKZBm4totYnrGfDOQdpba0W5nPgrT6U0ScZEYdam1xsWh4WN7mvhF7fRSweEL309IgYkaEfHaqy92TaMdAEzECyupuy+k470ApXz40tRkyIGrUvlGmsp7OJf8aV/1ODXuIHAHjFLr0oXM/br5qG1f36RnZUmkpQRkSWeh8bFKDOo8L4c1rc2A+TotOUZEZntcM6btvWJUZkDuPc7R62pYAKOa2FSx5BOoe7WCvSXPkyQzrbza7tJN6+TYiCIZxQft8
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(336012)(8936002)(508600001)(7416002)(47076005)(16526019)(40460700001)(82960400001)(1076003)(186003)(9686003)(2906002)(44832011)(26005)(5660300002)(956004)(70206006)(6916009)(53546011)(70586007)(81166007)(82310400004)(55016003)(7696005)(54906003)(966005)(4326008)(356005)(36860700001)(316002)(6666004)(8676002)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:53:40.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c345395-5d8a-4c8a-463f-08d9ceb810fc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB0982
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 23 Dec 2021 18:17:03 +0100
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 12/13/21 13:04, Henning Schild wrote:
> > changes since v4:
> > - make everything around GPIO memory usage more verbose
> >   - commit messages, FIXME in p1, cover-letter
> > 
> > changes since v3:
> > 
> > - fix io access width and region reservations
> > - fix style in p1
> > 
> > changes since v2:
> > 
> > - remove "simatic-ipc" prefix from LED names
> > - fix style issues found in v2, mainly LED driver
> > - fix OEM specific dmi code, and remove magic numbers
> > - more "simatic_ipc" name prefixing
> > - improved pmc quirk code using callbacks
> > 
> > changes since v1:
> > 
> > - fixed lots of style issues found in v1
> >   - (debug) printing
> >   - header ordering
> > - fixed license issues GPLv2 and SPDX in all files
> > - module_platform_driver instead of __init __exit
> > - wdt simplifications cleanup
> > - lots of fixes in wdt driver, all that was found in v1
> > - fixed dmi length in dmi helper
> > - changed LED names to allowed ones
> > - move led driver to simple/
> > - switched pmc_atom to dmi callback with global variable
> > 
> > 
> > This series adds support for watchdogs and leds of several x86
> > devices from Siemens.
> > 
> > It is structured with a platform driver that mainly does
> > identification of the machines. It might trigger loading of the
> > actual device drivers by attaching devices to the platform bus.
> > 
> > The identification is vendor specific, parsing a special binary DMI
> > entry. The implementation of that platform identification is
> > applied on pmc_atom clock quirks in the final patch.
> > 
> > It is all structured in a way that we can easily add more devices
> > and more platform drivers later. Internally we have some more code
> > for hardware monitoring, more leds, watchdogs etc. This will follow
> > some day.
> > 
> > The LED as well as the watchdog drivers access GPIO memory directly.
> > Using pinctrl is not possible because the machines lack ACPI
> > entries for the pinctrl drivers. Updates to the ACPI tables are not
> > expected. So we can rule out a conflict where two drivers would try
> > and access that GPIO memory.
> > So we do not use those pins as "general purpose" but as "Siemens
> > purpose", after having identified the devices very clearly. 
> > 
> > Henning Schild (4):
> >   platform/x86: simatic-ipc: add main driver for Siemens devices
> >   leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
> >   watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial
> > PCs platform/x86: pmc_atom: improve critclk_systems matching for
> > Siemens PCs  
> 
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Cool! Thanks all for the reviews and for allowing the drivers in. Stay
tuned for more.

regards,
Henning

> Regards,
> 
> Hans
> 
> 
> > 
> >  drivers/leds/Kconfig                          |   3 +
> >  drivers/leds/Makefile                         |   3 +
> >  drivers/leds/simple/Kconfig                   |  11 +
> >  drivers/leds/simple/Makefile                  |   2 +
> >  drivers/leds/simple/simatic-ipc-leds.c        | 202
> > ++++++++++++++++ drivers/platform/x86/Kconfig                  |
> > 12 + drivers/platform/x86/Makefile                 |   3 +
> >  drivers/platform/x86/pmc_atom.c               |  54 +++--
> >  drivers/platform/x86/simatic-ipc.c            | 176 ++++++++++++++
> >  drivers/watchdog/Kconfig                      |  11 +
> >  drivers/watchdog/Makefile                     |   1 +
> >  drivers/watchdog/simatic-ipc-wdt.c            | 228
> > ++++++++++++++++++ .../platform_data/x86/simatic-ipc-base.h      |
> > 29 +++ include/linux/platform_data/x86/simatic-ipc.h |  72 ++++++
> >  14 files changed, 786 insertions(+), 21 deletions(-)
> >  create mode 100644 drivers/leds/simple/Kconfig
> >  create mode 100644 drivers/leds/simple/Makefile
> >  create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
> >  create mode 100644 drivers/platform/x86/simatic-ipc.c
> >  create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
> >  create mode 100644
> > include/linux/platform_data/x86/simatic-ipc-base.h create mode
> > 100644 include/linux/platform_data/x86/simatic-ipc.h 
> 

