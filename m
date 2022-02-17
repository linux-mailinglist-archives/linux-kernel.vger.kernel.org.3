Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923084B95CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBQCFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:05:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBQCE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:04:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2105.outbound.protection.outlook.com [40.107.96.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A51FE52B;
        Wed, 16 Feb 2022 18:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3PlRxCqhZfQHppAEdheNQ12Fm50kBSnA5AnFsrB5PuSBfb2rp20AwLzLDEJhNvE/gtT/FSgbUUCgOfZ7n56SUeMWB2Kl0XOhH4KiYOYmC14OrFNRHPzyrqd0smaOchpja4v5QYCMr38PdiAwSqgQje2Rp1VzUMkQ2Bk44MCuhL6FVHFsNIa7fffl9/4NQdoSITJ+SHvPKC1+7xi51pkZYFiRP8Scl48LRUAbfFtShhPc/iVrxeJP3uEAKiS3vN4KhEZkQaNQPR5PDQ3/N8b6/9j8EkNsbOZeh6yt84tLSRp69Y6qUjXSFuszamT9gacyJ5i3enUei9lcX5wl8T8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Gj2mWhnqiNajbj+Ng3b39UbLrtqnfcIXtYMrHTW+M=;
 b=lhgKXejWgh9I1DIokGKfguLJyLrLpsBfW6Wt3fxF2/zoDFeSRooBXVSJyZjMtmLkHafE8JKy79n2i/o32c3q7LD2qHqgDjzwMKnA2Tonx9oHLy9hLVoqbouSGKpzggEOcuAekyWaaATrtFXKT5Fv0PhdSBMYCq8Svc4rWYnmlBZ7fTbwCLT8E80ifvxoh0pWaF2FDtbYtTkW0RerKCSGioKwri/Ltnx/BBKMlbmDWNN4p/AtSjS7L0dbLzZ9we8yPgNsTglRmXnkfJrGDgDV1JgiktkxlVJEsEmiT/pG7umzfx9MRmyW1oQD1i5ua2p2hFqSmxk6yk7VBDah3BmnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Gj2mWhnqiNajbj+Ng3b39UbLrtqnfcIXtYMrHTW+M=;
 b=NagV/qpasChipJitpNovgfdV27ARWlnQqY2GLNMLahBilqroKuxdvWpo5skGSc/AcgZV0MUa+rVDjFzrBmAHcO9OgnKTnCUYnh8XSURBfcQZaA07OPrhx16+K0tcPq557BUmSrOk1ew1Gj4XvqHGSOR7tZVkVnyRaHG5qU1J7Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6826.prod.exchangelabs.com (2603:10b6:610:ed::18) by
 SN6PR01MB4045.prod.exchangelabs.com (2603:10b6:805:a3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Thu, 17 Feb 2022 02:04:42 +0000
Received: from CH0PR01MB6826.prod.exchangelabs.com ([fe80::58f:eec5:66b:f82c])
 by CH0PR01MB6826.prod.exchangelabs.com ([fe80::58f:eec5:66b:f82c%9]) with
 mapi id 15.20.4975.017; Thu, 17 Feb 2022 02:04:42 +0000
Date:   Thu, 17 Feb 2022 10:01:49 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com,
        k-hagio-ab@nec.com, lijiang@redhat.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <Yg4dDZGEyRzWcGH1@hsj>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck>
 <YgzD0ZfZF34u6whJ@hsj>
 <20220216124026.GB9949@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216124026.GB9949@willie-the-truck>
X-ClientProxiedBy: CH0PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:32::17) To CH0PR01MB6826.prod.exchangelabs.com
 (2603:10b6:610:ed::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019b3796-a4c3-414b-34df-08d9f1b9dcaf
X-MS-TrafficTypeDiagnostic: SN6PR01MB4045:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB40450BB2E3EE943755BEE690ED369@SN6PR01MB4045.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbRHQ7bORDNsMp9luhMnMth2EQCO+ogarLGCSCN2B6aSvhmOeyYwPaqC7Y4a31bHwfxR10AzviFsrv/U1hd2vvoNfE897nIHWY162VwYyi3C+gnyn6hzpw5PWzXCurLpDAjgRtOhVyd6vw4DsukhH74a6Xw4qMDILCKjIGiGmO2ek46ki/Cu1YyGQaiQZ+B3ttirXQUCZSzayFAMAoUcXg+1KvGGnYTZECe0HIR3VIQMehGtCR4mqF03r72i645KLWDkTZmd8AQwEE+gbuNDNWZ7UgTU4wjrczKoZGOJ8qFF21TEv2GeQMKmSdmCcN9HOVUx917q/+R5i/QDKIDGjlXwLuxNWmHRbvpsb2qHo/mEHjj454gStKaADtpGNqW/FvPDFFt8XHuvUxoO8uKYVK8KYbg23umBJMAZg/YgQVSrxOpiXLOwuVtxv+RNc3/L+ENk9AGzaI+LpYF2FtMJ8MqVdT3yurGlrWhzkrzNXZ7n7j+uckemVhpWHiKfz+IBMcENwGmxsgKcDGaqkbesDNHmZSsa8CKTKDZuwwQ7gmrekWkifGjZdrQ1nogeX5RiyG4IbFVhJCPioWtT4aYKos9TALy1rpyCvY01SCTx+/3l18UUA+ITfgdKaygiQb/sz8ueLMEK5MI3WGoczdq0avFp+3SNuPZ2PajlQ/xn7tqcCFnE6f/Y4HQbjvQ7OLRD7b0fsO3xDANWEgZF5D1tRvHoU5FGUHBuTR3McI2ICWVvoRtEv6GdjuvJPVY+W0lx06PFV/X25FiE+YmUMeT184D1p15nrXxPrQQReS0cd90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6826.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6916009)(316002)(38100700002)(966005)(86362001)(6486002)(6512007)(6506007)(33716001)(508600001)(5660300002)(2906002)(9686003)(8936002)(66476007)(8676002)(66556008)(4326008)(52116002)(66946007)(38350700002)(26005)(7416002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mpn+cGG+PglsLgoUNhZxdBGdMPf43UZXgKCX6TtyPf9YV0VB1zatcYz9szn4?=
 =?us-ascii?Q?Va1szWcSflCGjAVw8tfrGiJGeyutcVTZfyDJN2UXZ3AYVf2I1Q4/pasZDkT/?=
 =?us-ascii?Q?0eooj1QCbT6nx40RrDZ+2FrpLsTKIdDLOK1QZVVJBkBFEPf7Vnb1+BT6woBQ?=
 =?us-ascii?Q?AF1Q4H/HCjsvKGKUeLwfPxHPLyrlFbbrMChyf1XMqmx1IUBCq4BIEm671pYk?=
 =?us-ascii?Q?mp3MGzXZbiAahnIql74/KoNd1ycMXNPggQWeQWYy3tJYl46XwMwBtWItcD0V?=
 =?us-ascii?Q?fKysfHp1CXNJPtqz/jqW5OXgUWoOA0+Jxr1HWLEwTEx1kguX1n7/ptnikVKE?=
 =?us-ascii?Q?Bapdwq9MdSH7vlq0IhFyaisvaopoDjJUp74y7wDgQoKj5wRzrfXVjPj8joZ6?=
 =?us-ascii?Q?P4ln8yvf04oDHUfN0KXtuPk6YXTKkcDId8NLoK6ZDh9ks7evcNtdGwd3ylJG?=
 =?us-ascii?Q?nhqHFx0fcMOxV2ic/yaHx131r/y2F2jH/8J3Y5vYta2K+DkeS40Ih+ImfE2F?=
 =?us-ascii?Q?bxRCqHx5xFN+2rLAFkBM67pFYc7AY7m4DVHTvNlTqSnstHxa5oaHgtXMdc2D?=
 =?us-ascii?Q?ZhvUDUse4ny4JKOsiHSyEzbU1vPPt7WWpi9U/46rgKXZ/VtR+cn3Z9GxKAPi?=
 =?us-ascii?Q?GQDQisG52Fbl2zq1dWtEFUQ1px32yDxxRYMHdWrzRb3eSonK9DxQGTQ2y8pt?=
 =?us-ascii?Q?HDxdzIoh4ucxBiVOlXKKjuIiLclisHy67WoxEzNg3xDZIiLUzmd+osEq3LSg?=
 =?us-ascii?Q?vpZQ3HcLWoXuSiD2S65IT0RfxqTc047171BtiFFUNDw7Ntb7N3TURhycY8LO?=
 =?us-ascii?Q?N6Z321VyuMPLl4MHeE9Qc8UzBVydh20anUCDZ8FQv4xsKH2GCLpV+Tvipv1S?=
 =?us-ascii?Q?mUz4lWY/sWh+ifuebyal65W+ZY9wZMEqfIIV/puUDbLaF0o7uvXUrka9jCAk?=
 =?us-ascii?Q?clHOSkR+Q/mpIzerRykRvcE7pg4bYHkgndjpHpRLfLCRtnYM4iN/iyZSb7AN?=
 =?us-ascii?Q?FjNG+wvravkO1DsXEmUVgOoTWSx4AqpOm1t0oi2hMhTSqxb364gX/vSkY1kU?=
 =?us-ascii?Q?6XVhzAuIEQhQ5Gti/luR/XnWhbsFaj2aOu7+Wm+YmJNiBq1+XZJ3X0Z9u3Km?=
 =?us-ascii?Q?xDiQa5k/rljCLbRiHpTy/mImekoEHPrquh9FwLJ2iOemrr+pFhJ9yJQP7W9o?=
 =?us-ascii?Q?ovrVPLS+nFw+YE/PqrZC31ldVG3jYlodIf3IIi41tugKqPk2cfBOX1HAny8p?=
 =?us-ascii?Q?0iAO4Z5u4lnW9GLt/Ek1DjOWo8Gooy2QyIFdCMky1nRCox1MXKo956eXn4bJ?=
 =?us-ascii?Q?DDIL9GK/nHk2ZyqR7gfL9ZEDHTaap2QZNb+tqie7IA1f1gTk/m44RCPt6jHW?=
 =?us-ascii?Q?XdCSBVBDiJe/gj9X4RVy8iXF/4r2immeF66p78RT+TH/l0DXzuqvuYdNnBWp?=
 =?us-ascii?Q?ZEYrj1Hke/vILIuttMIxmp0lSFnSuntpD5MlTuQbRfSC/AfDtlveHOP3sZqc?=
 =?us-ascii?Q?1+hfhlmcXdoIi0sWtTDDzT4Tr6ZOLiElj/HlB3Kzk3gWuNTqr8UYTgYoOwIC?=
 =?us-ascii?Q?1xNO09gcrv7TUPhn1yQHxXvWS31+iBH5hS6zlpEgyFyeTL/j30oNn8BucG6+?=
 =?us-ascii?Q?u2ZktTgOS5aDsDbcTd+LWpOGU41VMyBcgCdOJAuB8WkuB5cyxlzN24ney8qQ?=
 =?us-ascii?Q?MnNPL/Zj46KqnugsCKVxGY2OS21dg5LqkDhu6V/8Ql4AFybpv6TlzTcfTQHK?=
 =?us-ascii?Q?SUwMdAsD2g=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019b3796-a4c3-414b-34df-08d9f1b9dcaf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6826.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 02:04:42.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/KDHQdW59guuwrnk97rKOgHO82w3YJyvj6asw+TheWrv1LplpRQ6f47Klql5aSVckQESjpC45Pk4+n5QNX9i3nbxfmuEVLeoFmKYdt2M7h8u2rqeqzV7vPdPGdDqFY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4045
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

CC Kazu and Lianbo.
On Wed, Feb 16, 2022 at 12:40:27PM +0000, Will Deacon wrote:
> On Wed, Feb 16, 2022 at 09:28:49AM +0000, Huang Shijie wrote:
> > Hi Will,
> > On Tue, Feb 15, 2022 at 04:44:23PM +0000, Will Deacon wrote:
> > > On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> > > > The following interrelated ranges are needed by the kdump crash tool:
> > > > 	MODULES_VADDR ~ MODULES_END,
> > > > 	VMALLOC_START ~ VMALLOC_END,
> > > > 	VMEMMAP_START ~ VMEMMAP_END
> > > > 
> > > > Since these values change from time to time, it is preferable to export
> > > > them via vmcoreinfo than to change the crash's code frequently.
> > > 
> > > Please can you explain _why_ they are needed?
> > 
> > The current Crash code is still based at kernel v4.9.
> >    The virtual memory layout looks like this:
> >    +--------------------------------------------------------------------+
> >    |    KASAN     |   MODULE   |   VMALLOC   | .... |     VMEMMAP       |
> >    +--------------------------------------------------------------------+
> > 
> > The Crash uses MODULES range to set the VMALLOC ranges.
> > If the ranges are wrong, Crash will _NOT_ works well for some latest kernel
> > ,such as v5.11 later. (Please correct me if I am wrong).
> > It seems the VMEMMAP range is less important.
> 
> [...]
> 
> > 5.) In the kernel v5.16, after the patch
> >       "b89ddf4cca43 arm64/bpf: Remove 128MB limit for BPF JIT programs"
> >     the virtual memory layout looks like this:
> > 
> >    +--------------------------------------------------------------------+
> >    |      MODULE     |   VMALLOC   |     ....     |      VMEMMAP        |
> >    +--------------------------------------------------------------------+
> > 
> >     The macros are:
> >     #define MODULES_VADDR	(_PAGE_END(VA_BITS_MIN))
> >     #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> > 
> >     #define VMALLOC_START	(MODULES_END)
> >     #define VMALLOC_END		(VMEMMAP_START - SZ_256M)
> > 
> >     #define VMEMMAP_START	(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
> >     #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
> > 
> > 
> > BTW:I am currently coding a patch for the Crash to update all the ranges to
> > the latest kernel version v5.17-rc4.
> 
> Thanks for digging up all of the kernel memory map changes and taking the
> time to explain the macros. However, all I'm really after is something in
> the commit message of the patch which explains what is broken without this
This kernel patch does not break anything.
It just makes the Crash easy to maintain.

> patch. What does crash use this information for, and what doesn't work at
> the moment?
I know two cases now:
	1.) The Crash uses MODULES/VMALLOC/VMEMMAP ranges in
            arm64_IS_VMALLOC_ADDR():
		https://github.com/crash-utility/crash/blob/master/arm64.c#L4104

	    If arm64_IS_VMALLOC_ADDR() does not work correctly, the internal
	    code may get wrong results. 

	2.) The "help -m" gets wrong output about MODULES/VMALLOC/VMEMMAP ranges.
	    The guy who use the Use the Crash to debug a vmcore, will get the wrong
	    information of the kernel panic.

Thanks
Huang Shijie
