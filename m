Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9448951F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiAJJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:23:07 -0500
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:64065
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242821AbiAJJXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:23:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXU9iPGOqzF9nfWFOw7jcTZ1nyaPmSG59DLlmjnzWJfiIr4a5Z8Bh0kUYhQ3OloJOoznOuHsj0osz03ECajTRF1AqRtc0kTUNT3VammDgrusIKx1iXdh223AJvQ6SCcbqPdNZHS4FTSm+r/oShgu7Zd1dFUW2IwNZ4jUQM/31iShHN8UTBnH1i2UNyug1/0gRRnldln6mYKDWrEZYh4M2yaNN0fihuxPScmfnvLORTG/+e7gYwcwW/2Zweq4ni/tPKS0CGvvUx/+IToyN9cHiZ1ggcNul1mNJp4UD+PIq75W78z2BKMoTGtPbOlp+oZyajVEAV7lHbTcqeqhcuAZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QDoW4/NLNoejItU69c37B8/Ai+AUU2f4XFMIArRQAI=;
 b=ZO1U/ZaIJJk6Wj0YZsoYPVZnMpJAHsVRLm0tao+xINLSYWl+YrhVY2CzXf68sV16GtOhvoacrnzKHkj7nSo5uKOtQR8XFO2xovNn1And7pkR98w3Vxd9KkFe+bHEHvAEmc5IoHrmlYCVKR20qrz7oC4fICV1XDkQZgjqL/saIRaCrHZWNmAl2HkaXJVbpqZdbT6zoQ+fG1RMHeaz5mqSXLTrBIpnS6VrgktndVtsAcxZwroXF5o+oArWi0qTdXcS+rH6fiZxpWpOQ2dB/4mcIZwzNKSDTQGj7b4e2hDRI7+MMiNB5jY7tDm1zDR2B7CbM3YBrir/SV6z+o8BQwq7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QDoW4/NLNoejItU69c37B8/Ai+AUU2f4XFMIArRQAI=;
 b=lnoUF65hbNvdvPxRlIffHHDvZYBX79DXSMcOLINk3ppiPzbLxPRk1leX8rEbM2n+mO66KFyQeaiqFwxeuuygt8PPjrBcOfiAC5iQJ0uLlVnUYH/0PcWrDG2Uz4PRI0XB8cH75jvyyX2dmssq2jCn3p86449lWoLUsnLO/l/Brd0=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by BN8PR12MB3075.namprd12.prod.outlook.com (2603:10b6:408:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:22:58 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::71) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 09:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 09:22:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 03:22:55 -0600
Date:   Mon, 10 Jan 2022 10:22:53 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Terry Bowman <Terry.Bowman@amd.com>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wim@linux-watchdog.org>, <ssg.sos.patches@amd.com>,
        <sudheesh.mavila@amd.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
Message-ID: <Ydv67VKcrCk81Y9R@rric.localdomain>
References: <20211103161521.43447-1-terry.bowman@amd.com>
 <20211103161521.43447-4-terry.bowman@amd.com>
 <20220106181809.GA240027@roeck-us.net>
 <9afabe55-6429-2284-cafd-d59ce481f067@amd.com>
 <YdgeU2p+i5hN1XCU@rric.localdomain>
 <ac8e1173-3002-54f1-0264-6f0cdf26c475@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac8e1173-3002-54f1-0264-6f0cdf26c475@roeck-us.net>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c126a9-5302-4deb-e3a8-08d9d41aca8f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3075:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30755F697B8069BBC4E050DD9C509@BN8PR12MB3075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjElTJPUGcWeU6Db2KtwBlnMigHMkoRzadeVxYO2YmZYEicx6QB6ghB5Fb6v1a6ZTjN42sfEOCS/WWlB30bbkZqzzBuIDqW8gaHoZkouGnRcm1DTMl0qTwJHH91+a0GDBs9bb3lBN0npDUnj+ktrB2/Sbsf0FWCJqSVyZldEomqfPx6hWlFRZkoBzuSfM6pGnV/hwK9/qCbmIxCXXTTgrMXAhIxZCTpNzWsdOC4sJLj05QA69WBADmlrbwtPSqDitKNpWs1zEHO+87i7wP8AQtPKXHdAtlYI8U5Poah3qGxskcqT7DrTv7gu5T3q5V+Hl7GnhBBGhU0ZikX8NW+UHqattzfLjsQmimMQE2h0sNqk1Eqw6CVTY/YzkyYNdQXhgPpzC20b96PmIdyNCtTQGicM6mGVIPgK2ADZWyFNmniMTkMwN/XhEV+sZpKZumicGDMr1ZSSepNhFOHMZj26+sKHtulxZOoupdIriQWnrGFJ19ke7HwqKZJKiLn2F+g0liwfZywaFI79WKa4bNSYlFgy6RPfRoi48Uhmb4Duf7JdASgEBNgIlKPj7eCNkxs/87hqBYtSxsuG7c/KmwLixdiFeZlZTERCV+M8yYjr4210z83FntnJCZw2GWFgTEG2LiChnj6POTYBnoUm/P5f0+ZwWiGY0GTWoCYZPhmRSgKqIk6nAoe2sB4phCeYL1FZzH49gX3OZXJub8gtCVR0dfAKioL1j/uKdpHWzAmj/vvpM00LeLiuKsMGm7HAC6Py+7wFyLruPwr05UJXcbLauAxM6rdtZmrop5y9YUF8GQGYaea6vcQzC45dafRy63i3OcKgkg/kiKJXcOpQu+8gfC03XJbOXfgV8zLyMJI9DfgalAp6sT/pgbcHSGu6sjFT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(186003)(966005)(16526019)(8936002)(508600001)(26005)(426003)(81166007)(70206006)(70586007)(53546011)(7696005)(8676002)(336012)(4326008)(83380400001)(36860700001)(316002)(5660300002)(40460700001)(2906002)(47076005)(6916009)(9686003)(54906003)(55016003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:22:58.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c126a9-5302-4deb-e3a8-08d9d41aca8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.22 09:12:32, Guenter Roeck wrote:
> On 1/7/22 3:05 AM, Robert Richter wrote:
> > On 06.01.22 13:07:11, Terry Bowman wrote:
> > > On 1/6/22 12:18 PM, Guenter Roeck wrote:
> > > > On Wed, Nov 03, 2021 at 11:15:20AM -0500, Terry Bowman wrote:
> > 
> > > > > diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> > > > > index 80ae42ae7aaa..4777e672a8ad 100644
> > > > > --- a/drivers/watchdog/sp5100_tco.c
> > > > > +++ b/drivers/watchdog/sp5100_tco.c
> > > > > @@ -48,12 +48,14 @@
> > > > >   /* internal variables */
> > > > >   enum tco_reg_layout {
> > > > > -	sp5100, sb800, efch
> > > > > +	sp5100, sb800, efch, efch_mmio
> > > > >   };
> > > > >   struct sp5100_tco {
> > > > >   	struct watchdog_device wdd;
> > > > >   	void __iomem *tcobase;
> > > > > +	void __iomem *addr;
> > > > > +	struct resource *res;
> > > > 
> > > > I must admit that I really don't like this code. Both res and
> > > > addr are only used during initialization, yet their presence suggests
> > > > runtime usage. Any chance to reqork this to not require those variables ?
> > 
> > We did that in an earlier version, see struct efch_cfg of:
> > 
> >   https://patchwork.kernel.org/project/linux-watchdog/patch/20210813213216.54780-1-Terry.Bowman@amd.com/
> > 
> > The motivation of it was the same as you suggested to only use it
> > during init.
> > 
> > Having it in struct sp5100_tco made things simpler esp. in the
> > definition of the function interfaces where those new members are
> > used.

> So, no, I neither see the need for having the information in struct
> sp5100_tco nor for keeping it in its own structure. If you'd merge
> sp5100_request_region_mmio() and sp5100_release_region_mmio() into
> sp5100_tco_setupdevice_mmio() you would not even need any pointers
> to pass the values from sp5100_request_region_mmio(). Otherwise you
> could have sp5100_request_region_mmio() return a pointer to res or
> an ERR_PTR, and pass the address as pointer parameter.

Yes, that is feasible, in fact it is option 2) I suggested.

-Robert

> > If that init vars are no longer in struct sp5100_tco then callers of
> > efch_read_pm_reg8() and efch_update_pm_reg8() will need to carry a
> > pointer to them. To avoid this I see those options:
> > 
> > 1) Implement them as global (or a single global struct) and possibly
> > protect it by a mutex. There is only a single device anyway and we
> > wouldn't need a protection.
> > 
> > 2) Have an own mmio implementation of tco_timer_enable() and/or
> > sp5100_tco_timer_init().
> > 
> > > Yes, v3 will include refactoring to remove 'res' and 'addr'. I will also
> > > correct the trailing newline you mentioned in an earlier email.
> > > 
> > > Regards,
> > > Terry
> > > 
> > > > >   	enum tco_reg_layout tco_reg_layout;
> > 
> > While at it, tco_reg_layout is also only used during initialization
> > and can be moved there too. This would raise option 3:
> > 
> > 3) Add a pointer of struct sp5100_tco to struct efch_cfg and use that
> > struct instead in init funtions only. But that causes the most rework
> > (which would be ok to me).
> > 
> > Going with 3) looks the cleanest way, I would try that. But all
> > options have its advantages.
> > 
> > -Robert
> > 
> > > > >   };
> 
