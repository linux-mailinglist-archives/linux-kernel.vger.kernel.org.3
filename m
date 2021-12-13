Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD913472C38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhLMMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:21:30 -0500
Received: from mail-db8eur05on2055.outbound.protection.outlook.com ([40.107.20.55]:23649
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229766AbhLMMV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:21:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJa0OdiiGr8Xa0Z9gB9ZLqevlK3uwKkCTsz91dTsS0IXv3A38Jur9WOlYftao6QtHH8hQ7BUh5e2FcHftGTJoHA1cka2NhuBUsJXdQhuc2c/WbkDO0zhvotB/8ySrX86W7XFA9gdnUb+gWABTyfx6JPoLaUCjb5iD1ptV5TPNW/m6Me13l/LWXzvwFBtasa1Dft0LG2HKyuY+IEyRQk3Yi/p1CGbpBSE90T9Tf6SnF0JgoOj0KPPsYYisoJfw2jNfwwTQ4atsJzvXROTTkazeZ6KdmPjah5A3q9vNf2qziArHGVXO9A+tNCpZ9QNLRuqj6m96jrbg89sTVkhbYGRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdFuShIlhlt+HlTp/7lyEV1Mw6kWrkKLliUAYx7XzbA=;
 b=c7YvXCoXPfsdqmWUBfMCEqhJXZkfLNxGQD7ITMxi0gLlzymmZLmnI8g1wu7MPrJxUcLWsVeF5ahGbBBlRfNQZxBYhOJMllMaa/N07GQqG3Hz0fn9BACeK8TTkFyzr0PySIDMSjlE53LcBmeIZUg2jJJUXG6vsP0OR+K66mZDPsBJM8nmSATztNtAHFzKc8OZ4Tk6Zzg1RGuy2ljt/W37/96MNKmn0AN4JlrH/YOSAM8mGSvwH0RgFu+ciB6a8voFopOXuSUCfCWQR5D0S0dknM4rgdfPS5UBuvYAAPF7fv97qxAxlBbK4dCu1/kv9uQ2zCniO7AZhrCS7n1Ewsf+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdFuShIlhlt+HlTp/7lyEV1Mw6kWrkKLliUAYx7XzbA=;
 b=Z0ZnY+WO96dAw+mvM+vjPeJN2C8kV3jECVzjEZs88Lg3qMPzxNZd5ANYQ4BUVKuJeStxmubp9TShf61X0WJBYQow6ysVPwTtuXjp5jRAp3mcma/Fv83hkY2bNRZdXIZmOqDOaN2JsHbcPNpwDgxrdWqoVjLY0BGzdAlM6mS9pKICY5vSVzXEX4m/7hLwACB0EGX0ge4vWhB0lirVuCaMKTyVVIAERwbqzHgm6TVvOyFLFDONeIvVGI9MG4hOW0UMxksItjn/Z95S/RS5mSbZ1GHuw00eV94dDUfbkHY/pKpGr+YRhbhJK5C3SePhNsPPPUVPh+TkeWrBPwJvM1qVVA==
Received: from AS9PR06CA0329.eurprd06.prod.outlook.com (2603:10a6:20b:45b::35)
 by AS1PR10MB5340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 12:21:26 +0000
Received: from VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45b:cafe::64) by AS9PR06CA0329.outlook.office365.com
 (2603:10a6:20b:45b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 12:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT016.mail.protection.outlook.com (10.152.2.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:21:25 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:21:25 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:21:25 +0100
Date:   Mon, 13 Dec 2021 13:21:13 +0100
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
Subject: Re: [PATCH v5 0/4] add device drivers for Siemens Industrial PCs
Message-ID: <20211213132113.09104069@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211213120502.20661-1-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 244aa1ab-9d06-46c9-1325-08d9be331552
X-MS-TrafficTypeDiagnostic: AS1PR10MB5340:EE_
X-Microsoft-Antispam-PRVS: <AS1PR10MB5340CBD41208F3D1DA4EBC3285749@AS1PR10MB5340.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8VM5Hy7d2+AbxgDQMLvHgsBwgJRUraTAJ6UIJZhAZ8wb1bvf/XLXVpC0I2N28KnNFuQT4Rzf2VWRZ1IFA9nGGiWOmGxSWp9N1XduzFPuBRMSCCgxb2OJ5YDjK2gb5prOwpTltVV5Nuxx0UpUWcAryNCPFi0NqAUJBpf1XDFD1gVYDjckGkJVw7wugRqFz8LoRUNOZ6cvD0r7pD6H68lWkShUbAkIrSucU7WT7VzR3TuQqof0GXk2LK0EBfolJWAg0E5mmtKmzs9uqE4Q5/JKGy4MfpynXwZI2QLoziZfYNbKuDoSSCJf3UdoBt0YKoFirTQkbvchLp8mSVoAuTmwQfrFzGYxh8fwJQj+FICetab2LwJ8UVyhS/bY0mYF7cG53iA1gscXvWg+6DSqaOKUjaFwStaBunc7B9T2IoflwuG40ObEjYyckqkUwbEimm5yLu+5XGS+XGG9jOxfziiTxkDCE+RvmJgYBTq2kUL0/OUC5KwcOcxNTYUW/f7UHCvAang24tSpq4hsGA+FDJgisAWvkocdQDhmOJs/9wT+g4DqurIlIalgrCcwJSDvdBXZyPNwspwnOmHCyhFybEnrGHKiej5rjiyd2T444k5+dBM+89ljVIkhMXpnda8LYFD4sY54GWhvxcfRxmaV0jASTYdBR6iej4w9bUPvpbE24BfEHzn6PP/Rj8h/sUVTA9yTL5jdXsnL+PhxtPNdlqwjf7TVVCav5a3owkPPJGqVZY=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(44832011)(186003)(26005)(8936002)(2906002)(36860700001)(16526019)(956004)(86362001)(7696005)(5660300002)(81166007)(83380400001)(336012)(1076003)(9686003)(70206006)(7416002)(47076005)(4326008)(8676002)(508600001)(54906003)(110136005)(316002)(82310400004)(55016003)(356005)(82960400001)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:21:25.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244aa1ab-9d06-46c9-1325-08d9be331552
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5340
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now the outcome of the phone call i had with Andy concerning
the use of pinctrl. I could lay out why it is not "that easy" and why
we do access GPIO memory not in a "general purpose" way.

Yes we have thousands of devices out there with missing ACPI entries
so pinctrl does not come up. But our firmware guys will not add them,
because they strictly only address security fixes and not functional
changes. (stable ...)
Adding new ACPI entries could have unforeseeable side-effects on
devices already at the end-user, where many (also proprietary low-level
SW components (OS/hypervisor)) could be in use.

I hope in coming generations we will not forget such entries again, in
fact it is not even clear who forgot to put them in. Might even have
been Intel to begin with.

Henning

Am Mon, 13 Dec 2021 13:04:58 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v4:
> - make everything around GPIO memory usage more verbose
>   - commit messages, FIXME in p1, cover-letter
> 
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
> The LED as well as the watchdog drivers access GPIO memory directly.
> Using pinctrl is not possible because the machines lack ACPI entries
> for the pinctrl drivers. Updates to the ACPI tables are not expected.
> So we can rule out a conflict where two drivers would try and access
> that GPIO memory.
> So we do not use those pins as "general purpose" but as "Siemens
> purpose", after having identified the devices very clearly. 
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
>  drivers/platform/x86/simatic-ipc.c            | 176 ++++++++++++++
>  drivers/watchdog/Kconfig                      |  11 +
>  drivers/watchdog/Makefile                     |   1 +
>  drivers/watchdog/simatic-ipc-wdt.c            | 228
> ++++++++++++++++++ .../platform_data/x86/simatic-ipc-base.h      |
> 29 +++ include/linux/platform_data/x86/simatic-ipc.h |  72 ++++++
>  14 files changed, 786 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/leds/simple/Kconfig
>  create mode 100644 drivers/leds/simple/Makefile
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
>  create mode 100644 drivers/platform/x86/simatic-ipc.c
>  create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
>  create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
>  create mode 100644 include/linux/platform_data/x86/simatic-ipc.h
> 

