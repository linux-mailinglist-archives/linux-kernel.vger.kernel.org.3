Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443BE467E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382909AbhLCTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:39:34 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:54852
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1382892AbhLCTja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZM+MjF+P9VH/ZDMW/JAaDFSHzo8sMD04JjrR1AJHV+SrS//jLwUUsL55oK1i+OC94Hv8/98131QjFrsc80RvaRhQQllpQjuP1Lp1xKhlVA3DfmGS1gd3S71AHiDkNvU9Mz4KCC1cnA5vJcAk6UN8FF5C0faRtLwzhvYSr+ReFY4mIPLkJtPbjS2aNAnjskFA9KdmkFAdsZoifRaqx5f+pGROeijGMJq6/uU/bT7FHUcruDd/nqIx0AUgnPGlL6VBx/Trv24Oox6lN4x/3U+KQvb1Z4CPvvtB7itkzwq+XwiiGp9mnyV/zDHsjbEqATeSNA8hMGJe6rAhezrcPPD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFI8L6R8dSTl4BuIEwj0LQXEwVosAYm2K+T7n5zUrVc=;
 b=i7+cReO+lUzsJ25XDAc6sSTURn5dsozhMfrVZ4pswYRo3oDGwVluOLBas/J8T0FmJ0xrNMbPSbsgPeyt6h5K7c9+7lzc6AkzDornSNAgPNDna+6FK9k2SmD+T/knV8WEkM0sg767tRbXZKOHRWgpTCG4p93VhsTo7EppgeE/7SIeGIsKuJwXOvygchti/AXa/ErueHpJLrZ4SfNjer0rZCg851UbMQJpTbl3wneiqo+uuDQIDVqb8JCoUGgXLcfIAfT/8Td1rTeUUGoYh3OkrYNZHQb/AKC5SHrYhq2LUJnsKy73Z4IqrrFYh52V0fcsH2eMkHTA2+YMuzMgnZYQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFI8L6R8dSTl4BuIEwj0LQXEwVosAYm2K+T7n5zUrVc=;
 b=KJNdBjGoUV/zdaLNsZZoKhuPpQLgQx7R7clJQxw+dBivjgeESZOzHSjmfalF2UDdDMyglW/QcEHzzEDTFae+3Mivn/TPUnkN8bGHh4/EAy8s+xA4X7E/8Zot4fjEWYgz5K0vAxm5R7oXxI9lPpss0A23S/g8nxGJmOkGx52YUUOl0n6eEKcN5jsX3JGg5AxSANZ/ZLH7EmWK4NuBaPlcNR80jybGzo5Yf/XDkWrWvo9nlJ7js8X48JSABLcWsf1jH6G68Cj0GAFj96bsWiLNhEgsV0HVDA8alFkN7Wja5h/k+bFXQhPiTjm3bsRwLEbIwwhpi0UyNjiYTQs7YyKuQw==
Received: from DB7PR03CA0090.eurprd03.prod.outlook.com (2603:10a6:10:72::31)
 by AS8PR10MB4725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:337::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 19:35:58 +0000
Received: from DB5EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::47) by DB7PR03CA0090.outlook.office365.com
 (2603:10a6:10:72::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 19:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT033.mail.protection.outlook.com (10.152.4.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 19:35:57 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Dec 2021 20:35:57 +0100
Received: from md1za8fc.ad001.siemens.net (139.22.45.74) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Dec 2021 20:35:56 +0100
Date:   Fri, 3 Dec 2021 20:35:54 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <kai.svahn@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v4 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <20211203203554.0b43f14f@md1za8fc.ad001.siemens.net>
In-Reply-To: <YaZAAgDPquDMpvIn@smile.fi.intel.com>
References: <20211126141027.16161-1-henning.schild@siemens.com>
        <20211126141027.16161-3-henning.schild@siemens.com>
        <CAHp75VcD0FQuG_AToNkVHHD9e6WV6=18P4U0cSi0qzD3FL=ssw@mail.gmail.com>
        <20211126191203.663e0d90@md1za8fc.ad001.siemens.net>
        <YaZAAgDPquDMpvIn@smile.fi.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.45.74]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc3568b3-f4ba-4fb6-bd97-08d9b694213e
X-MS-TrafficTypeDiagnostic: AS8PR10MB4725:
X-Microsoft-Antispam-PRVS: <AS8PR10MB4725C9553C27282AB339563F856A9@AS8PR10MB4725.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CTQkxcuHNrB5kiaxvDnZWxfFhQ48vpzKs4OsQHSjemSn1/QDEiVNwdpNmkBfwjQ3a29zaeK+ZKe7ucAmPNZeQ45rDGRJVw/qRMxURv38lPocJgPsyUt/bWOgfdqV0ytosmFzKIb6oHq17BWSaaC6JhZ6V873K8KiV82kghVVCXAhaGdf7I/zj+XtdgSP3rsqvOnrfXHOq1txrhnbHUVKOnE8l3gAUx+i/i1oj3R7fqnz7wAnqSg/wvpcpGtdDEv9I6bm8KQiVukpY4SoL5t6ewwvBN4vWt/SNzHlQuzu2oEtTcyh22R1fYhq+j+6D8O9WSFoVeDO2T+p+h/seqZQObte1ubH44tkNjFanebYrdOmNiRG2GSIr1HNqc3022lHDoJCoQdXAB8VS/WtvIzipAM6uVTWhER/RipAgbCIvmXAeEiU+4M4SFiyU5EMaGVc3b7a43E67pUXtGrO4IKeTsH32cWhbwYxEvq57okqdNXUnJ2RQHmAzoJCGnjr0qBla3JMfdxXzEwYRSFjwdW62DZiniW7MN6sNnCrK5wg7xxmudPsnMhSqGNYHXDAenLXVFDrA3OnIufBI4N0q8DpTQwTNzVJOiM2gf2OMbzNGeB0gL6Oxpu3Ou5otnJaoc4s9f23ZXUVfViJvcS7hhD22meRoo+BmrC4otKS8nCU2C28ggNdFItk6T7zRKRv362mNcOuQd2jz33YLUCNGKOASfXrQPAXrFFZM5u0drp2igbvMmIhsNZolbyZul5je4iJz2OQFuWysiMb+ny2HNze9bGuZpO21C7SIsuXQwiv4c=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(7416002)(9686003)(956004)(70586007)(86362001)(53546011)(8936002)(356005)(8676002)(82310400004)(5660300002)(54906003)(70206006)(16526019)(7696005)(36860700001)(6916009)(44832011)(508600001)(2906002)(82960400001)(336012)(4326008)(81166007)(55016003)(47076005)(316002)(40460700001)(83380400001)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 19:35:57.8082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3568b3-f4ba-4fb6-bd97-08d9b694213e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 30 Nov 2021 17:15:14 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Fri, Nov 26, 2021 at 07:12:03PM +0100, Henning Schild wrote:
> > Am Fri, 26 Nov 2021 17:02:00 +0200
> > schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:  
> > > On Fri, Nov 26, 2021 at 4:10 PM Henning Schild
> > > <henning.schild@siemens.com> wrote:  
> > > >
> > > > This driver adds initial support for several devices from
> > > > Siemens. It is based on a platform driver introduced in an
> > > > earlier commit.    
> > > 
> > > ...
> > >   
> > > > +static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
> > > > +       {0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> > > > +       {0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> > > > +       {0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> > > > +       {0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> > > > +       {0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> > > > +       {0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> > > > +       { }
> > > > +};    
> > > 
> > > Like I said, this is not okay.
> > > 
> > > Why can't you simply enable the pinctrl driver and use it?  
> 
> I have talked to my boss today and I have got an approval to
> prioritize the task, so I'm all yours starting from tomorrow.

We had a long and fruitful conversation today. In very short the story
will be that i will send a v5. It will make clear in the cover letter,
in the FIXME, and in commit messages that the P2SB bits are hacky, same
for poking on GPIO memory.
And also say again why it is like that and why it currently can
probably not be done much better.
With these documentation changes Andy said he would be willing to ack.

On top Andy will work on P2SB improvements, and maybe also pinctrl
infrastructure to make the existing drivers actually probe without a
need for ACPI fixes in firmware.

When these patches are ready i will change the Siemens drivers to use
that and take out hackery where possible.

Andy please follow up in case i summarized things wrong, but i bet i do
not have to tell you.

> Let's finish it once for all!

I sure hope we get there!

regards,
Henning

> > I propose we set up a call, that might help clearing up the
> > situation. If you agree please send me an email and possibly
> > propose a time-slot. I would take it from there and send you a
> > meeting link.  
> 
> Sure!
> 

