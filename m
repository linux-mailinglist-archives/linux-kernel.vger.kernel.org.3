Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C747A5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhLTIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:14:46 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:23365
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhLTIOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIKCMeI9+ZHhU5oXhyqWuoZIAd4X4cAIj5eQRj8TA2yDBVFIAs2rP+vchBhuQkk+xKnJla4ViOBNDIXvGfPRoL3BLcMLgFQoUJzhlAxUMX/JwriSH6LebjIe6K/aAvO9EGT+sU+yptFqzhjuuNjK2XQegQke+EIDXt76R21IYhBu4AXbHmzZTOvJpWYqod09B9/4COba8Lqs+I8i1BHkM5yuRNN1CINCbsD0ImNAm/O6P9/XxDBatE6yFe78hADhhZxjbCTcNGiUrmitMD1kNTd2LSNWaJdgrASVqggvG+1UMbW4q4NsNWw5zwJqAW32nCFSGpYzXvHPRMbRwwFhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpa+A7wrhzYn8nGGLDa0KODWLsb5jw/swE1l7N8vc7c=;
 b=JrVTP6X9/MD3cQXyP8xVVd6jfJYa5xJP8TvHG3ohxT8M36XagPXNg/IlMyfMSw9XBoyrcnSoOpyP3p1COCGBHynkggj/OUN8I4+bfWe6u8dvSpHh1aP1AsYTlNJ2wpjcjRfIPEDtoEfvDhnqzUsq4AFIeLIFBO/3fvhIanPQjkWI7PDxz6BOQMRsZu5jDiI554Meh/iIH6RKEdyrxt3TxTd5DuV/9Kcv2mLqIb9ar94Ixq94dT6vtJ+TkbwrFBs7xJ2dXzSJUZTaqODk8y559+XCVl+ji4cf8e5Y39v0xRwBTIpQdzZn6XAVZWpumAWJTGf47CXNHQCspIWE69CaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpa+A7wrhzYn8nGGLDa0KODWLsb5jw/swE1l7N8vc7c=;
 b=XPt1erEm2BqwgW2zgcOR/Bu4DxClXz0ggENI+Dj285LPqY5XLYeooXhyKZVSaGzM0pw2Q5f+K/Xu3fyTSKYRikR7Ok7iWgH3QBACo3O35YjHLQIE9XiRGnNy8Vax0L5/ypIUg/gkEnFzp0broBl5ZGHJkZH7Y3Dkl4yibDr5q8QO177FcLCPFPXIIibKwIJDKHG6tyOf+/ecqzqQ/0vVHcE+cLD/lAmmQfQ5KA4zMDXMGZca8F0vbBlWwzOXoI+Meazo6tO5DIeM0sNHsGvE42GXhDbmVHgNaboET4x+b8ADqqq0JQYMqMvB15laNDWLTtQ2iYyJ/pQKvsWtrCY51A==
Received: from OL1P279CA0054.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::23)
 by VI1PR10MB3295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 08:14:42 +0000
Received: from HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::da) by OL1P279CA0054.outlook.office365.com
 (2603:10a6:e10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 08:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT047.mail.protection.outlook.com (10.152.1.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 08:14:41 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 09:14:40 +0100
Received: from md1za8fc.ad001.siemens.net (139.22.39.215) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 09:14:39 +0100
Date:   Mon, 20 Dec 2021 09:14:34 +0100
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
Message-ID: <20211220091434.2f696d76@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211220085220.23753298@md1za8fc.ad001.siemens.net>
References: <20211213120502.20661-1-henning.schild@siemens.com>
        <20211213120502.20661-3-henning.schild@siemens.com>
        <20211215201800.GA28336@duo.ucw.cz>
        <61983e62-bc3d-a711-c197-7436a2e33531@redhat.com>
        <20211219164903.GB28481@duo.ucw.cz>
        <20211220085220.23753298@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.39.215]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c588ee29-1ed9-4af6-d063-08d9c390c610
X-MS-TrafficTypeDiagnostic: VI1PR10MB3295:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB3295E72B820B0E28E9E4A5C9857B9@VI1PR10MB3295.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjTIkOxSR1cpItxOcpJdoAGvkQj4oJ1uBaX5AywRSCJz7wy5pXslsuHrLHnJSQV5eIHetb3K5d7zbFWqqoQIRpSlsMNP0y5Zh4zhB8HeIoLAOqpcskbVUBkQ8yRh/yEtf0hcaawSSez1D1DzEs6xM6ghKE0W0xfmal8bhw1TIriYFQdEyddogtU1I3oEYxE3fR2ddMAxOaWKkHa+Zaryk6OX7qIccK8GyRb1AZIRNzu6YI1kuKxspVG9xV9Lv4nKdoeVLcfMC+T5719c2dBE6twuYTVNnOuDnb5+HueEtD2dPdYNKKC3ArgNRdjHhAf5zn1tWZH5b1eVfCnYSvY4ltb5f+vZFSIwRYgrl87G9XH7XpDtunNVQw+UIvmgPWxDLsO0zxS0eEAe+2M+8+80rWBFB9LhN8u4GSLlWsDpf0frLft0aMcsaMON8oHJGRDhnpUk4h29Gr8Rsl6AGkQXie3BXfeOgdRSg3+nZB1jF78Ab+0lVfgZh9YnhvKRtCfKgzWk+Dni3gcnchBPPX2Kau/9UapiRv4yEFYVVniH2WH0Yc2N78O1t3rEPiDzfjHfiX9u+Xlt6VuEq11dhTcbOjrGWpamC11+PrAfVp54vz2udV2RLAoHKeb/6wAKb0kTbsp2qdw4irBkXJAbR7zGBxrgYKCY3cm9ZUJ4OI5lDEkOJtxlr/olXd34xI7kh5H0Yi3STbuPSWFJNmHC/81xWrEm/oVyuapLiiD6k4Gsc3MIySG2ArpDnbjGQsbYPR7VlIpYKUohc3m3wY6ySNf3tLoFTQecwXAAJ+nclleBye5rZnDo4/zfSA5WaXEU98lF7qGJQI7ypgdefkpQ/w2UexDHW+/zjS0k6N1KBMO86+Q=
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(4326008)(36860700001)(508600001)(44832011)(47076005)(82310400004)(70206006)(70586007)(40460700001)(55016003)(966005)(956004)(7416002)(5660300002)(26005)(9686003)(336012)(16526019)(186003)(4001150100001)(7696005)(1076003)(53546011)(6916009)(6666004)(7596003)(316002)(86362001)(54906003)(82960400001)(7636003)(2906002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 08:14:41.4489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c588ee29-1ed9-4af6-d063-08d9c390c610
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 20 Dec 2021 08:53:55 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Sun, 19 Dec 2021 17:49:03 +0100
> schrieb Pavel Machek <pavel@ucw.cz>:
> 
> > On Wed 2021-12-15 21:53:56, Hans de Goede wrote:  
> > > Hi,
> > > 
> > > On 12/15/21 21:18, Pavel Machek wrote:    
> > > > On Mon 2021-12-13 13:05:00, Henning Schild wrote:    
> > > >> This driver adds initial support for several devices from
> > > >> Siemens. It is based on a platform driver introduced in an
> > > >> earlier commit.
> > > >>
> > > >> One of the supported machines has GPIO connected LEDs, here we
> > > >> poke GPIO memory directly because pinctrl does not come up.
> > > >>
> > > >> Signed-off-by: Henning Schild <henning.schild@siemens.com>    
> > > > 
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>    
> > > 
> > > I see that this patch #includes
> > > linux/platform_data/x86/simatic-ipc-base.h which gets added by
> > > patch 1/4.
> > > 
> > > Pavel, can I take this patch upstream through the pdx86 tree (with
> > > you Ack added)? Or shall I prepare an immutable branch with patch
> > > 1 for you to merge ?    
> > 
> > Yes, you can.
> > 
> >   
> > > >> +
> > > >> +static struct simatic_ipc_led simatic_ipc_leds_io[] = {
> > > >> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
> > > >> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
> > > >> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
> > > >> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
> > > >> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
> > > >> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
> > > >> +	{ }
> > > >> +};    
> > 
> > But I'd still like better naming than red:status-2.  
> 
> We had the name discussion already several times, and i have to admit
> i am not too happy either.
> 
> But my impression was that this is an acceptable compromise. I am not
> happy because the names lack scope, which i had in the first round
> with "simatic-ipc:red:...".
> 
> Function is also a bit unclear, but with the numbers and the user
> manual, or looking at the chassis it kind of adds up and should be
> clear to users which is which.
> 
> But i agree with Hans that we should sort this out before merge. So
> please say what makes you unhappy, maybe that can be fixed ... might
> even make me happier about the names i feel i had to choose.
> 
> The LEDs are per definition of the manuals meant for
> users/applications to signal whatever the use-case might want to
> signal. There are 3 of them numbered 1-3 on the chassis, and next to
> the number can often (not always) be found a string like "error",
> "maint", "run-stop" So a function suggestion i would say.
> 
> I could envision to use "fault" or "alarm" instead of "status" for the
> one labeled "error". And maybe "standby" for the one called "maint"
> but i would really like to keep the numbers.
> 
> Which would look like
> 
> status-1
> alarm-2
> standby-3
> 
> But still i have to clue what those names stand for and choosing
> and of those "undefined" names could just suggest things and break
> expectations. Calling them all "status" is neutral ... 
> 
> Or can you explain the difference between "fault", "panic" and
> "alarm". Ask 5 people and get at least 3 different expectations ... i
> guess.

Long story short, i am also not happy but the current suggestion is the
most generic and least "expectation-creating" i could come up with.
While keeping a mapping between the name and the chassis/manual.

So i will stick with it, unless i get concrete suggestions on how to
improve.

The misc functions
https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/leds/common.h#L63

do not seem usable. Without a set of conventions they are nothing but
"allowed but undefined strings". I could however introduce
FUNCTION_ERROR FUNCTION_MAINT FUNCTION_RUN_STOP ... add more such random
strings. Which would probably make me happy because it would create a
better mapping between the names and the chassis ... but it would
worsen the problem of "what are those misc functions anyway?"

Henning

> Henning
> 
> 
> > 								Pavel
> >  
> 

