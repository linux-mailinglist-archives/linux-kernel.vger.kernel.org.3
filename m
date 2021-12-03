Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDC4671AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378488AbhLCFhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:37:15 -0500
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:9024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbhLCFhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:37:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCQpZSh5qtXYKB9GHPm+t8+TrpXC6HG0iEAO61admDV25QCiX6cWfZHegffPnj7iLLrQewGDLmIDrxScIOk2PGiSbpIRbro2tUDaWBX/P0Ve82eAu6IztsHQd7qFwJEoRLC2/KPJ3la4BJTsTb6nmSt3cY+9pzJCC8qzdiddl/VMQs74SS+5s+o33ooqUpmj0Xsq49iPf9zUdq5tsoQPmcXFH9fkR2QBVl0pHp2mn3XnXci+35IagUY20etultwloocAo8kZ5Dh72dnEiIE27W7DZg6hqrD8Ty/vj3iVyqNE9GQizchNIFolVJZXhdmdC8Zxh8MRmEuS7UbqSbCHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ5Xbe9qaNdG3VDoLyEftjZTxkxpwHMWhl4XFriPZd4=;
 b=ApqGg124zGFRkAMKhDWboAPj22igxS3HC3X2iu9CsjpANbHWiA/V2H/r3CV9IdWSRnAPdOlhd/NYdtNYmGWfyJZYO/o6r+lo3d33EOCU9E8p5khrPXvw+wmwsrVmbn7FOi4nm0eRHysX6vj1mMnyNaGCvD1fKr9IK7K/vD2mKYEa7E3xsXsmTcn7gIUKccNe/RWNmcZTVhV4Lw2n2NEduBDlV1socBx8WowwwZnDdKNE1Cw5n8suJqjq06/iIezc/Oiwe7L7J2DlqO0vVkYltocmo93/AAMexceHZKYekMgKkdXfUFHnYmg6Xj6kkgWLQEgNm27Lbx7S0ysd82lVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ5Xbe9qaNdG3VDoLyEftjZTxkxpwHMWhl4XFriPZd4=;
 b=ioSqtF+Q+7dAOant449qDiT2OTIEOsJsWkNvJhrf8zsKG/SvFtzHv2l1icXpFFsG9qWGRoAqmhz7STxa2Y9U59c+sd+eFWKOwbSkQtVWEk71TveQsMFJd9tGbRKT97NgV2ugXPUE5lL1IDPAx5/O5BA6uNS7okPAS8l8+x+ZwBmJhXfRjvnS+DZVmBPhchnaar2Rb4Kzs/2jSbYP8FwhvNZA4IvGymA6EG/8OSDaL9pzFJB3rDxy2+Ld97IH2FlemTgma2lG+XrPAj5B68nJ8yepeg7mOo4JyzHXKN/6erzbZ2lDK/3j1D/je4Qjow2LpsMjLw2bxeW+p+ARztx1ng==
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 05:33:49 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::d9) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 05:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 05:33:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 3 Dec
 2021 05:33:47 +0000
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 2 Dec 2021
 21:33:45 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details specified
Date:   Fri, 3 Dec 2021 16:33:43 +1100
Message-ID: <11226930.BYJfa7kJGD@nvdebian>
In-Reply-To: <YamNRcrLDOPjG9wg@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com> <5393877.lttFOZEo4r@nvdebian> <YamNRcrLDOPjG9wg@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c283477-8729-4788-cc17-08d9b61e7b87
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54446DC542494937C51D7917DF6A9@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTym8AVABoFOcd7MfG89qC3+LG5xak57ippJUJsDQS7H3B0SOvxpiUm7IKPYS+uTAepTGDK0Xz1q15VB1qvtcWNA4KEtgEIHnscNC1gJ86TvyfAe3SY8XwT7uX1+Oa+JHicJVkbROGzJky8ferUQcaGILldhWcaknE/+2c607nvajnzA6DnC1FvV7xz8lQZyEpqjwL3oyQQIFBsw3Jf/OJpeO4eY2LotwiE6mfvPP7qStFNeQB7hKSunsV7u7CDDzW60ZF9l9A4g1WeqiJXYhyAKpAis67+CALWMKdbgK0p630p35q3PdWXzl4YHDJ2IHbkuepqobEA30jymQWuROwQaEJYsgYyTEJSd7vMzYQgc+JbsvxQUKYfVHum95PBjMIMiMHoUR0cxoAgJYAX49hNMD1eI7PKD1y+Zsfzs3Up9XgReEESPgUpjqsE5kU0KQ8LzVOwwez3EZBuCYXbtfr+E7ExfwnbP743muWLH/Yeb20PsX6ayfquS7MSlb3sDqLVHjgS5vrA+QvB5of13knW+o7Buc79qdcCdeRgLMYRSpwdUtzl5UCnYdLHwq5A+pnDHROf5Pzn0yu7kuQY17n0pTrqKq8jmxGDe+c7uR/p7EkMQ1uRjvsoK5x+uNVr3q5RNrIkOoOSFaSxyL05J7akw/M1Mwj0BB+J2jCNWo2+iLz3MCko/ThQVjOXNMUuD8YIbovgIfguIpXdnfmf6w9WsJ74X7n9d+TrSwDjNxYzbbZobfoy+i+x8Jd3Z7RREJXzQ8exyGXxXgT2j4TLtB5qNT5nxBh/Zxa5/BwxoegM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(70206006)(336012)(8676002)(70586007)(36860700001)(47076005)(86362001)(5660300002)(7636003)(6916009)(508600001)(9576002)(316002)(33716001)(26005)(54906003)(83380400001)(426003)(40460700001)(16526019)(8936002)(2906002)(356005)(9686003)(186003)(82310400004)(7416002)(4326008)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 05:33:48.4594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c283477-8729-4788-cc17-08d9b61e7b87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 December 2021 2:21:41 PM AEDT Peter Xu wrote:
> On Thu, Dec 02, 2021 at 10:06:46PM +1100, Alistair Popple wrote:
> > On Tuesday, 16 November 2021 12:49:50 AM AEDT Peter Xu wrote:
> > > This check existed since the 1st git commit of Linux repository, but at that
> > > time there's no page migration yet so I think it's okay.
> > > 
> > > With page migration enabled, it should logically be possible that we zap some
> > > shmem pages during migration.  When that happens, IIUC the old code could have
> > > the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> > > without decreasing the counters for the migrating entries.  I have no unit test
> > > to prove it as I don't know an easy way to trigger this condition, though.
> > > 
> > > Besides, the optimization itself is already confusing IMHO to me in a few points:
> > 
> > I've spent a bit of time looking at this and think it would be good to get
> > cleaned up as I've found it hard to follow in the past. What I haven't been
> > able to confirm is if anything relies on skipping swap entries or not. From
> > you're description it sounds like skipping swap entries was done as an
> > optimisation rather than for some functional reason is that correct?
> 
> Thanks again for looking into this patch, Alistair.  I appreciate it a lot.
> 
> I should say that it's how I understand this, and I could be wrong, that's the

That makes two of us!

> major reason why I marked this patch as RFC.
>
> As I mentioned this behavior existed in the 1st commit of git history of Linux,
> that's the time when there's no special swap entries at all but all the swap
> entries are "real" swap entries for anonymous.
> 
> That's why I think it should be an optimization because when previously
> zap_details (along with zap_details->mapping in the old code) is non-null, and
> that's definitely not an anonymous page.  Then skipping swap entry for file
> backed memory sounds like a good optimization.

Thanks. That was the detail I was trying to figure out. Ie. why might something
want to skip swap entries. I will spend some more time looking to be sure
though.

> However after that we've got all kinds of swap entries introduced, and as you
> spotted at least the migration entry should be able to exist to some file
> backed memory type (shmem).
> 
> > 
> > >   - The wording "skip swap entries" is confusing, because we're not skipping all
> > >     swap entries - we handle device private/exclusive pages before that.
> > > 
> > >   - The skip behavior is enabled as long as zap_details pointer passed over.
> > >     It's very hard to figure that out for a new zap caller because it's unclear
> > >     why we should skip swap entries when we have zap_details specified.
> > > 
> > >   - With modern systems, especially performance critical use cases, swap
> > >     entries should be rare, so I doubt the usefulness of this optimization
> > >     since it should be on a slow path anyway.
> > > 
> > >   - It is not aligned with what we do with huge pmd swap entries, where in
> > >     zap_huge_pmd() we'll do the accounting unconditionally.
> > > 
> > > This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> > > should do the same mapping check upon migration entries too.
> > 
> > I agree, and I'm not convinced the current handling is very good - if we
> > skip zapping a migration entry then the page mapping might get restored when
> > the migration entry is removed.
> > 
> > In practice I don't think that is a problem as the migration entry target page
> > will be locked, and if I'm understanding things correctly callers of
> > unmap_mapping_*() need to have the page(s) locked anyway if they want to be
> > sure the page is unmapped. But it seems removing the migration entries better
> > matches the intent and I can't think of a reason why they should be skipped.
> 
> Exactly, that's what I see this too.
> 
> I used to think there is a bug for shmem migration (if you still remember I
> mentioned it in some of my previous patchset cover letters), but then I found
> migration requires page lock then it's probably not a real bug at all.  However
> that's never a convincing reason to ignore swap entries.

Right, it also took me a while to convince myself there wasn't a bug there so
if for some reason this patch doesn't end up going in I think we should still
treat migration entries the same way as device-private entries.

> I wanted to "ignore" this problem by the "adding a flag to skip swap entry"
> patch, but as you saw it was very not welcomed anyway, so I have no choice to
> try find the fundamental reason for skipping swap entries.  When I figured I
> cannot really find any good reason and skipping seems to be even buggy, hence
> this patch.  If this is the right way, the zap pte path can be simplified quite
> a lot after patch 2 of this series.

Yep, I think it's definitely worth trying to figure out. And if it turns out
there is some good reason for skipping we better make sure to document it in a
comment somewhere so none of this good research is lost. However I haven't yet
come up with a reason why they need to be skipped either.

 - Alistair



