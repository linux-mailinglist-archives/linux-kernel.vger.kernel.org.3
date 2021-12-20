Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6247A58C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLTHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:54:06 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:65088
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232332AbhLTHyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:54:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiS8VSZbbFplb6iL/e6rzikMavLR2UWrLaqTs8fmwc9DFOVoVJuT10zwlAr1aNbIJz02mm46+A4L3g5usdEtonWUr91pax2GZpu07kG0kFMLudMd9tYRSSKabwfUqesnIaBbFLKkwokfqsgIIUbbvACAwo/zxiFgz7675DusxihyedwU6vBsQuAQ5SVvGXwJZ2gRBWtyifhc2JQvI5WfDzO7Xbzyc/54VtRBV1lPXZrH/S4MeLRzrPv2bEmB/3u8ynYrRilrjoAZQk4uIMF9DkxKFzzkdaw/n/hFk3sd8LEyEqHm3VaNwatzJGk5sgpYBrLmPue2XJksJFXoQGbgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9uycmDl0blFnq/cTYA6KU7Ub2ALnCuXt+xMZAkctaY=;
 b=loV0y9I6HCh6HnvfRZE6C62XFaOuZHuZP9rY2sLYR1+Jwnayby3dXDD95LL910/P7up+BB9DyGdc4TJ63wywL7F7prpiJgoBctojwVghfC3BEz3F7vHhSXMNg70EWyOucxK+kqCLzj821DPpDs7/YyE3snEqX3H5S4zCle7Xhi3h9rFcM3/zRfWqeHRMFV65EYUVKdky0WyA+BhwPhpjPyiZEGjAl+lh67y8Bqpg3CTPAHustajHEKpzy7K55/PvEMoX7Q0oCHuhxlJc1+ujn2fdJz4TbYBe1h/bS0XUcsxIamcnxVd0Z0hlPfxAEDnSbAoRCnKeYo9+1a9UyHCXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9uycmDl0blFnq/cTYA6KU7Ub2ALnCuXt+xMZAkctaY=;
 b=cKq5E8DxXEI7tabjYUixL69Wj+87tBfScC0YFFbMtzsDWw8zXzgWqx1J6TAWeb1SJFYMg96YOssk52TMcHos3+fxcubeUwHRCSzU+R4ZeLWcyp8zbAQp2Um0Vfj6zxkZMKSWv2i4LdySXA81kdQuRqdOnsT7q9mkW8pQFelAhao0ZsMDQXwizz7NPH/eqPaZS1GxHU7w5M+LmG6TXs5bnruZeTuPJpRRvuGmlGygydm1f+EnRn2GmybwWlMcrk0oMxVBwiGU4HR7W1+JDVvSf+2kQZF8YOaxccy+yy+2wWqKNfSpwH55UsH0za0siFHwswa0v8bUJ/5xrkI64YpJRQ==
Received: from SV0P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::7) by
 AM9PR10MB4385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:263::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 07:54:02 +0000
Received: from HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::4a) by SV0P279CA0056.outlook.office365.com
 (2603:10a6:f10:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 07:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT059.mail.protection.outlook.com (10.152.0.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 07:54:01 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 08:54:01 +0100
Received: from md1za8fc.ad001.siemens.net (139.22.39.215) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 08:54:00 +0100
Date:   Mon, 20 Dec 2021 08:53:55 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <20211220085220.23753298@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211219164903.GB28481@duo.ucw.cz>
References: <20211213120502.20661-1-henning.schild@siemens.com>
        <20211213120502.20661-3-henning.schild@siemens.com>
        <20211215201800.GA28336@duo.ucw.cz>
        <61983e62-bc3d-a711-c197-7436a2e33531@redhat.com>
        <20211219164903.GB28481@duo.ucw.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.39.215]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a569fc84-f2cb-49a7-f15b-08d9c38de337
X-MS-TrafficTypeDiagnostic: AM9PR10MB4385:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB43857EC09F7F1884CF31E85B857B9@AM9PR10MB4385.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH2H8mX89hO00pwhFZqy19zt4FlvmyU3z6MnEwPki1WF/wnD0OhNs13X2SNDRM0B49Beav6bU6QpxpQ7Je+d/ssit26zayYszVsA/xm1ynPLP5rRYCf6HlXD7H9MtQVjvtMce0YI7hhpGbbYUlOHxal/Tr+yn4HWir6svzhPOF2N0vvkbCOw4rwfm954G8mjM+pklodoFovG+weh69blqvUwZUEb9sHZZh25T2OsW/uA0j3WFbxiqhMRXKiiNQ6kI6S5TpfD6OXvG2HdxgJWRSepWx8B2eoDPx1j1uR40BrK+oq/u6rFwvhr4OylJ4He3tk4Wyj6QJfryuUJtS8hljPOI8kAl3Nw++QhNrtSSzacJcgTpu664hU64LBJc4r3A2GZCoXKGs8Nil9DhqOESgXCgdPJLXGQ56ggoS8mwfSCke+AEZeSq5wlhZFOUdfPzqOuo8EOHSkax+GEt1Jovx8FlvFymtCSGoW/YL9sk+8xLcux/leEFRMbu6d0BHXhwiKrBjg89d1LEIO7iYAmgQeLWyQAPbZCOL6QBRKWVa9JgcNzf85G5YuOK4Uw9+BhG4dOldCbzvrzjo0aY6LatULpS2UG5cW0DmAP88aLKz5Na0gQZnCfH5C/GevG1GC9X1LgSxHQhFkG+KaOh9+meoCup80RWa1QgZtTuv7YY1JFSMm8Kh0ekBxfEDrQCe+iImiSu1DZ13io9DdJi3Dz/yqGW/BG0SgwMOXgukyFcfTwBgphwCoP6GqP2/lUuhBi
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(82960400001)(53546011)(47076005)(7416002)(36860700001)(8936002)(186003)(26005)(8676002)(508600001)(2906002)(956004)(316002)(54906003)(44832011)(7696005)(336012)(16526019)(70206006)(70586007)(5660300002)(55016003)(40460700001)(4326008)(6916009)(9686003)(82310400004)(1076003)(4001150100001)(86362001)(7636003)(356005)(6666004)(7596003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 07:54:01.8753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a569fc84-f2cb-49a7-f15b-08d9c38de337
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4385
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, 19 Dec 2021 17:49:03 +0100
schrieb Pavel Machek <pavel@ucw.cz>:

> On Wed 2021-12-15 21:53:56, Hans de Goede wrote:
> > Hi,
> > 
> > On 12/15/21 21:18, Pavel Machek wrote:  
> > > On Mon 2021-12-13 13:05:00, Henning Schild wrote:  
> > >> This driver adds initial support for several devices from
> > >> Siemens. It is based on a platform driver introduced in an
> > >> earlier commit.
> > >>
> > >> One of the supported machines has GPIO connected LEDs, here we
> > >> poke GPIO memory directly because pinctrl does not come up.
> > >>
> > >> Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> > > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>  
> > 
> > I see that this patch #includes
> > linux/platform_data/x86/simatic-ipc-base.h which gets added by
> > patch 1/4.
> > 
> > Pavel, can I take this patch upstream through the pdx86 tree (with
> > you Ack added)? Or shall I prepare an immutable branch with patch 1
> > for you to merge ?  
> 
> Yes, you can.
> 
> 
> > >> +
> > >> +static struct simatic_ipc_led simatic_ipc_leds_io[] = {
> > >> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
> > >> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
> > >> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
> > >> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
> > >> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
> > >> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
> > >> +	{ }
> > >> +};  
> 
> But I'd still like better naming than red:status-2.

We had the name discussion already several times, and i have to admit i
am not too happy either.

But my impression was that this is an acceptable compromise. I am not
happy because the names lack scope, which i had in the first round with
"simatic-ipc:red:...".

Function is also a bit unclear, but with the numbers and the user
manual, or looking at the chassis it kind of adds up and should be
clear to users which is which.

But i agree with Hans that we should sort this out before merge. So
please say what makes you unhappy, maybe that can be fixed ... might
even make me happier about the names i feel i had to choose.

The LEDs are per definition of the manuals meant for users/applications
to signal whatever the use-case might want to signal. There are 3 of
them numbered 1-3 on the chassis, and next to the number can often (not
always) be found a string like "error", "maint", "run-stop"
So a function suggestion i would say.

I could envision to use "fault" or "alarm" instead of "status" for the
one labeled "error". And maybe "standby" for the one called "maint" but
i would really like to keep the numbers.

Which would look like

status-1
alarm-2
standby-3

But still i have to clue what those names stand for and choosing
and of those "undefined" names could just suggest things and break
expectations. Calling them all "status" is neutral ... 

Or can you explain the difference between "fault", "panic" and "alarm".
Ask 5 people and get at least 3 different expectations ... i guess.

Henning


> 								Pavel

