Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59B4ECAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiC3Rez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiC3Rex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:34:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60128.outbound.protection.outlook.com [40.107.6.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E957DABC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4pOkm6RdqURHOG87FwA1a7KAS8G3L11rd+ozrWehPxVWKvSoxqtSQLKl4DlRWCgd3aDKLZNiyYmRGVT/DN1NvoSkA4MO9kxiJHnhIsmaxsgjE5wqZzh6gpc1Lh5TShdUXuXY16+d8Qvxi3i0KnaJK+++dsqODSGKuDNZvmPS38Fc8Pyeqb4OpUHhqqzens77I3tCC/KlX3YXBKMT0oa7XSl72ucvbxdfc8al+P6CumkeH9+Vd2YiDDNfcEhjzMmEmB07USHGk4//FAvwM7MvFEoTahlRIjsWBy02ie3jG6gNKa/z+46k6fiFTG2EZn8hSLP5BLsab27rMxSEAKAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGHX6vCAwFYQZcpedUMNcNLq8rxXU4d7tMcUTPoTf+I=;
 b=OAf3BAKKota/UZfK2S1VnymDrOaWJ30h3E3pwrS+sVonq7GdwNHXQlfqynfivQIwhuTfA7dO+mLvSU7zFQ+iuIO+xgXIB30+l3XcPDSKuyM4oqGCMQXAk3ukBtTfgJ32ev9BKphq0lUyV0IE2DyycXL6+BDkPIWHmz38GRVU80OF2+YAGUB8GMLJzkmKbrBvJm/fis1dIlmy+sHoC/pTWrVmgOW0CeYJ3WrefwMUNL3Xmq61dI/sDKiSywb7MSPfw9Qz9IJV9XLkclfsmTagDMuBS9mJNgOlO0VjuK0uW+HBSCp+2AVbIvg1tB5EmxnGdpCscl1IOTCpsEyZqLuYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGHX6vCAwFYQZcpedUMNcNLq8rxXU4d7tMcUTPoTf+I=;
 b=icfbFmrXC02Yw+mPwVIlFn7ocl02xKmVgIGFgYd5zKgnQCpmF5j0Q7WWHTbMu7e8wbkWWFpL7+fegxdVW/XMqBaJeq8y8SIoQo9A//i6gRUD7V+sppWTX3xCNd/uuDe5dz1VtnhmklTMweFBiDR7/qq1VFcRYyCzWlyAyJSRJ5U=
Received: from AS9PR06CA0238.eurprd06.prod.outlook.com (2603:10a6:20b:45e::8)
 by DBBPR07MB7674.eurprd07.prod.outlook.com (2603:10a6:10:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Wed, 30 Mar
 2022 17:33:02 +0000
Received: from HE1EUR02FT070.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::85) by AS9PR06CA0238.outlook.office365.com
 (2603:10a6:20b:45e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 17:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT070.mail.protection.outlook.com (10.152.11.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 17:33:00 +0000
Received: from localhost.localdomain (192.168.54.86) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 19:32:59 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Date:   Wed, 30 Mar 2022 19:32:59 +0200
Message-ID: <10062923.nUPlyArG6x@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAMj1kXFcrG6TrSU+KcmXCVM7ZWZ2fMjiN8c_dtEwxBugJS_UAQ@mail.gmail.com>
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X> <YkSHJ65qGHO4bonJ@shell.armlinux.org.uk> <CAMj1kXFcrG6TrSU+KcmXCVM7ZWZ2fMjiN8c_dtEwxBugJS_UAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.86]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b0a886-6fcf-4450-881f-08da127356a5
X-MS-TrafficTypeDiagnostic: DBBPR07MB7674:EE_
X-Microsoft-Antispam-PRVS: <DBBPR07MB76741F3C6829D01268E3CD82BF1F9@DBBPR07MB7674.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIKGMjoRLEmM9nTABNE0z1CEPGNyYZp+CoENQijv748xAhPn7flI/cbHPIE7dqm4oRR2emUJyslmBwe7BzBqzJpuS70c3nkMVxc7/+1rcarMac0vRZAEDbZaaniQ9jUNffC5mAdm2Vn3OJ3ecb351DjoWMim98J+jaTDlHsm7gtFJbHevV2SQtVqH9+zQsVUW3upNVTGEjyaYssa71rIF+h52iJwxGTEtvkUquOKNyExtU+S5MzhNtLeLZ4Qo629MZGJlThgv1lHVQ82aGS5uuXFMUkelq8B+YENaeKwLfgpJBwFNbRX0LwoFQANGpMmwfUoV4DiDZuMwjBDv5/Nx37RtNPUhaHZLg5UyRiB02zVhO2R8HNsoWEJ0AiirFMK6gtR52pJl585JJsQUKG90crWlgcREboC7h8d9WbZC8ula6Ry46Yz9uwteOpROpmB092PEbEUgHZx5GTZeGUdSMod33uCfxbtArJfqd3QvMXKZa4h42P0Get7xcgtIRngqAF8uWPNAYcXghF70KRko6FK7+UsJHKUJuY/3Af7EqL9mKjWxvwSv0CJ4dAo5hNjLzzrT5a0S9a4fwV701LBDLmwW/AEHojthn8LK81q8SLT4H6+tZ/OUec+fgLHpmrBIlvmc9DgllBzVDVz5g43oL6aG7zEGXQNYxSLvJaJwcXe1ViGQVanifKMZPTSJFucD3Q25V2OTboSKHXTxvcTufrg6CuRAJEnOEbvjcHR4AhnbW40cw4Dxi9lfQjDyYMH8cs3F7asUCVs/IKhG1naveBNFK+ptY3yZLgFIPV++Wax7teQuWzNQ5mHow2TSPLk
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36916002)(81166007)(966005)(508600001)(356005)(86362001)(54906003)(110136005)(5660300002)(47076005)(316002)(82310400004)(4326008)(8676002)(186003)(16526019)(83380400001)(7696005)(40460700003)(8936002)(70586007)(36860700001)(70206006)(336012)(55016003)(9686003)(426003)(26005)(2906002)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 17:33:00.9793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b0a886-6fcf-4450-881f-08da127356a5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT070.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 30 March 2022, 18:45:18 CEST, Ard Biesheuvel wrote:
> On Wed, 30 Mar 2022 at 18:37, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Mar 30, 2022 at 06:34:25PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 30 Mar 2022 at 18:12, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Mar 22, 2022 at 06:49:17PM +0100, Christian Eggers wrote:
> > > > > Hi Nathan, hi Russel,
> > > > >
> > > > > I stumbled today over the same problem (no output on serial console
> > > > > with v5.15.28-rt36). During `git bisect`, I had also some commits
> > > > > where a few lines of output were visible.
> > > > >
> > > > > At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> > > > > sections"), the system boots up to here:
> > > > >
> > > > > start_kernel()
> > > > > +--setup_arch()
> > > > >    +--paging_init()
> > > > >       +--devicemaps_init()
> > > > >          +--eary_trap_init(vectors_base = 0xC7FFE000)
> > > > >             +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
> > > > >                +--__memcpy()
> > > > >
> > > > >                copy_template.S:113
> > > > >                ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > > > >                r1 = 0
> > > > >
> > > > >
> > > > > With the final v5.15.28-rt36 I found out that the system boots fine
> > > > > after disabling CONFIG_HARDEN_BRANCH_HISTORY.
> > > > >
> > > > > Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
> > > > > with a ARMv7 core. I have access to a JTAG debugger.
> > > >
> > > > I think this is already fixed in mainline. Commit:
> > > >
> > > > 6c7cb60bff7a ("ARM: fix Thumb2 regression")
> > > >
> > >
> > > It's still broken - I sent a couple of patches on Monday, among which
> > > one to fix the boot issue with loop8 on Thumb2. The problem is 'b . +
> > > 4', which produces a narrow encoding, and so it skips the subsequent
> > > subs instruction and loops forever.
> >
> > And what's the current status? Sorry, I've way too much email from the
> > last 2.5 weeks to find it myself.
> >
> 
> https://lore.kernel.org/linux-arm-kernel/20220328134714.205342-1-ardb@kernel.org/
> 
> Nobody bothered to respond yet, I can drop the first two in the patch
> tracker if you like.

I just switched to v5.15.31-rt38 which already includes
6c7cb60bff7a ("ARM: fix Thumb2 regression")

This kernel boots fine now, even with CONFIG_HARDEN_BRANCH_HISTORY=y. After
applying the patch series from Ard, the system still boots fine. 

I haven't any understanding what these patches do. Is there anything I shall
test?

regards
Christian



