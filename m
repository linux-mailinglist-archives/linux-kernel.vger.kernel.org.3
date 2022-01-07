Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2E48762E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiAGLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:05:58 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:29537
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232906AbiAGLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:05:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjCJEMWFYHjAtu3PGfYNFZp9cA59bHQsxzox5ouWNUYfp9701r+RsYCH00JaexGHbImujOqHy9ePbXcplmqY2UFk1fnyxYgrBj4ApiD4cYve4TpMrr9ItTUYOCrfVWJINaVqeemmIMTYQhf2ezGUXU/JXxP7g5wdFAVi//JDBgDxmQotikMwKLqJdHSe8mSfZvj5zot7fXndyp7xXj5RjdI6PxYIi7hbmMHN0xzkKLW+1drQYCtKwwjgIr4ZNe5bO88Fd4o7Jgh5w0rsiA7anJbZNDFMhpdJaPfJbCCfuFPRZCBU479l61zr21or6UMyytHp5XpBkHOnnCsaf8/lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmvfhvfHoz3aPgLS6nhVVrzyoBJTyjZa14+VGrPc7wA=;
 b=n3dTC7JdnKjMOOiMlGI4r56+CMZin0ZgNucbk33Ddjgj+3zCtXOd1DVxAse4Lelk7mKkSE2K2PixflKf4LgTaUVK4qKgW6zIf9HWt4ykPBH2RoR9Lg46eeMLLTslRsPBovF/WU31TaW2l0GwrBJQm8F1a9QzLlmFoBejtqwDuh738+kAr1JMu12xmI4W+m7VQ4+KXJ9aUDeq0G2grGb8cAhmZZT2pmlOX4Phf/7N+RPi10Eg0zch84oLBUpxvgZMBpsbQVQq01I1jt1xhgtldqZGMsDETQ0LJAtFBRqYDtsyAXs7xiTYQNBodrwUihcKLXCWDkm6W0qdG683nXxeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmvfhvfHoz3aPgLS6nhVVrzyoBJTyjZa14+VGrPc7wA=;
 b=iUCgNIxBCpb5ZHMOQGiJxeBYE53/7r/d1SISOCaJCG6dnNkwqGA+Ew4ogak30SpZxul73dW7N7g7nx8P7kq7mIPnJ1+VaTCmqSuOWMBoNhuQOtsocv7lWP5sLd5H2DXOlPMILk0ql5jX3YE3zswsw2ApzgFJbZmAfQ7e5K1cZrA=
Received: from MWHPR17CA0059.namprd17.prod.outlook.com (2603:10b6:300:93::21)
 by MWHPR12MB1789.namprd12.prod.outlook.com (2603:10b6:300:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 7 Jan
 2022 11:05:51 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::8) by MWHPR17CA0059.outlook.office365.com
 (2603:10b6:300:93::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 11:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 11:05:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 05:05:48 -0600
Date:   Fri, 7 Jan 2022 12:05:45 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wim@linux-watchdog.org>, <ssg.sos.patches@amd.com>,
        <sudheesh.mavila@amd.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
Message-ID: <YdgeU2p+i5hN1XCU@rric.localdomain>
References: <20211103161521.43447-1-terry.bowman@amd.com>
 <20211103161521.43447-4-terry.bowman@amd.com>
 <20220106181809.GA240027@roeck-us.net>
 <9afabe55-6429-2284-cafd-d59ce481f067@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9afabe55-6429-2284-cafd-d59ce481f067@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ec5a07-0946-4bc8-8f53-08d9d1cdaad1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB178938CE597E5C63B65BB3D49C4D9@MWHPR12MB1789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nR0TM5itFHqtMpkbCybeLCEOwm802gBfFEe+9iT709TKO8jkHOVyqNRPV+UCCpG+idDPpGY/U8kaWCsw5e2wF89Ec7GGWTY2MIuTqfb1H1y1Gw9nrjo2ABUwnejtzl45OeUV35nKkezzil9drFBA4uhTlWo35mRQZDxC60FtmmNMk00UZcENtQBKAQnprjGnKKIoNIwhVB4W1YcEXnvO2zbCV/xRGvQ6ju61EOf82TMVtU9jUUGOx+gGhYGUiJOOIcPLe7pgfc0cC1R4YkcI+A8rngSVPfW07NgPBFaMVGzAE9qDcGHd1NdWuLrclAZFGnbAJvredZcc8nf3kurf58jKSJJXwweC1+7CrHwsaAX24L3vRHo5YIWtRqAzwkQ6TltiLqtv26ZmZalcVJIaQASQp2gyPawjgfrT9GeAYAog5dnC0Zdjw2OcJc1orMr+Q+l3A7NOtMe6WMrNP11M4D5LfK+qaPV2tz6GrW2LYY9ksxvj5FZ2Za5L9Wix09j4d4cEjNFmnvoQHQ29bEmR8LhDVSg8wiPoeS/ZHqDpBGL8KZ+PhXQl9JIqkbMdpLZtjfb4wTDKPpPvnAmW2reuBneTxK5j+2MCvjO8mcSA42lrkH3EoVWUGJtMziXltb8M+FeNTeTIP0p4kWRnin/Zg6JjIScVHFugutfjWhd+ZBy1f17GRNHogt1Yo51P7kY5O3MPMP0ZMfyzZZvKgpFnDlOJEitjcv39WATktT7isF7riDhADMf6TdwzIgw/APrYu5YZtSkoFs2n0erFKRobncFn7HJ379PDR4O5cdOS0EXwO8Thv3W8bQN/e+Zcsw8afaSOe7xZdaKY/CY+EXyMiZ5MZatK9sqh2WQ+ST9/wICgIGg/RGPpUO1zd3iM22LlXfvZ+WmoOgEYiSQ7dgirNX19HvkAoz6Q5Ggzd2lxeas=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(9686003)(966005)(508600001)(4326008)(6862004)(8936002)(8676002)(53546011)(26005)(426003)(336012)(16526019)(186003)(6636002)(7696005)(47076005)(5660300002)(83380400001)(81166007)(356005)(82310400004)(55016003)(36860700001)(40460700001)(6666004)(316002)(70206006)(70586007)(54906003)(2906002)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 11:05:51.2434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ec5a07-0946-4bc8-8f53-08d9d1cdaad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.22 13:07:11, Terry Bowman wrote:
> On 1/6/22 12:18 PM, Guenter Roeck wrote:
> > On Wed, Nov 03, 2021 at 11:15:20AM -0500, Terry Bowman wrote:

> >> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> >> index 80ae42ae7aaa..4777e672a8ad 100644
> >> --- a/drivers/watchdog/sp5100_tco.c
> >> +++ b/drivers/watchdog/sp5100_tco.c
> >> @@ -48,12 +48,14 @@
> >>  /* internal variables */
> >>  
> >>  enum tco_reg_layout {
> >> -	sp5100, sb800, efch
> >> +	sp5100, sb800, efch, efch_mmio
> >>  };
> >>  
> >>  struct sp5100_tco {
> >>  	struct watchdog_device wdd;
> >>  	void __iomem *tcobase;
> >> +	void __iomem *addr;
> >> +	struct resource *res;
> > 
> > I must admit that I really don't like this code. Both res and
> > addr are only used during initialization, yet their presence suggests
> > runtime usage. Any chance to reqork this to not require those variables ?

We did that in an earlier version, see struct efch_cfg of:

 https://patchwork.kernel.org/project/linux-watchdog/patch/20210813213216.54780-1-Terry.Bowman@amd.com/

The motivation of it was the same as you suggested to only use it
during init.

Having it in struct sp5100_tco made things simpler esp. in the
definition of the function interfaces where those new members are
used.

If that init vars are no longer in struct sp5100_tco then callers of
efch_read_pm_reg8() and efch_update_pm_reg8() will need to carry a
pointer to them. To avoid this I see those options:

1) Implement them as global (or a single global struct) and possibly
protect it by a mutex. There is only a single device anyway and we
wouldn't need a protection.

2) Have an own mmio implementation of tco_timer_enable() and/or
sp5100_tco_timer_init().

> Yes, v3 will include refactoring to remove 'res' and 'addr'. I will also 
> correct the trailing newline you mentioned in an earlier email.
> 
> Regards,
> Terry
> 
> >>  	enum tco_reg_layout tco_reg_layout;

While at it, tco_reg_layout is also only used during initialization
and can be moved there too. This would raise option 3:

3) Add a pointer of struct sp5100_tco to struct efch_cfg and use that
struct instead in init funtions only. But that causes the most rework
(which would be ok to me).

Going with 3) looks the cleanest way, I would try that. But all
options have its advantages.

-Robert

> >>  };
