Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A42597A45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiHQXkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiHQXkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:40:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7647E80A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrfPOEVb/QpMmYob4KLfN9WBhdZRDk+DfjcEEE9uSKQOztYzpJXtJEB2YfTZl1b+WH4STNlNdegbEh/aFA5Nl9bEGHsd6vLTCa53bH4J14H+wgU+3ocJF9anX00L9jAdClWPWNDovrpJD6bSCsKPn3WJJh83YSzCYG3kReCB36eNOT5dPqrqiZvawMTNY3dMHN4bVlqyaFd+vMorTLHLzaNwB20GIITw9aGgo6dOJ2Xl5DMxFYqEaI+JHdufTmtZ48RumChDtWm6+G2wPORx3OdPE9ho+QrXPt92d5tAyqwZeProwJTFySyUgd9EMCDIjzm/oR60Hz9eYavvVQ7IDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCftBy5KoxlpHiTJOh64PY+ZlVPYUckWAcPQycZ3veI=;
 b=oO/aRdJEqJXEd0N18V57vDj/W+dIlAixLcPisXKOqL62VqVERC5FHFNoUX60wzz0/jHWa+jCUqKNn/ULmAhjhZfvJsaSrfVcMC3oOHyC4I6dNqS6LjWOavNH/sp8J71lrYOXXggSjLjEVwqPaxz5tF/iN68ktzMJFHwGIfj6ZBCIn1+diHDUwkByddMg22G7f6jxYrVh/vbN/IH5B7UEfCZBnw8E2+F8/8XzeDMzrUDYkzWwBdCIAOr6OzxOQl3ujw5pLYOA0EZuvL9irRE0a/bvZUaZQy8zeL2Q1ISl8lmrYp71FqOkcU02yilUSnGKA2X6IqTbgnioWnUNgGzaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCftBy5KoxlpHiTJOh64PY+ZlVPYUckWAcPQycZ3veI=;
 b=SvDvgkOGFFrTTGwr2C7axaf45smJvpDrreAP9LyR7iSYku6rnaMTCadx49zqq344wW/XXUN2zgOd1tHGKvy3OGnleaRAMTt2xoVoNPzP4qBwHUBNlW4VspiyIi0lTmKa1FPWyeYAken+UsmYcGjKEwpBqStdlObbOEVidtnw4qjjaqdjLYoaIx4YduTr9XnS/B9GXOrhKt7FX6UX0QzEkyHDxL2UWQOjM5DjgJT8uutDbhQixt1LcHNU3FdA+HWocAngX69fo8IUax2fclZ/2F2BoxfGHEl/7URNXZ5aCa+/KsbN1xb/nq301j5El6bhQPIalMHhBrImoOBVNZ3v3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 23:40:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 23:40:47 +0000
Date:   Wed, 17 Aug 2022 20:40:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Message-ID: <Yv18eGBvWKi3l/eW@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com>
 <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com>
 <87wnb7tycb.fsf@nvdebian.thelocal>
 <YvzaXeRox/9fqfdW@nvidia.com>
 <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
 <Yv1wntznpzSXuTYh@nvidia.com>
 <87k076tpd1.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k076tpd1.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 606cd5ae-9dcd-42f9-7ab8-08da80a9e8bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WAyg83xrFC5+1f7vjVWQKSHNxT81NmXq5BY0FsFgWIWRFL6nXLlYYV3RYl+LU2nD7Ho+K2Y0OcZzW7sPQMh953VFG6XIuD0UoJvmw5Ls8X4wHZcRtla5CT3tZEPgVkqLnBAoWLJOLeySY48PowDwBZAOqO/PbSlHWTq4YX99dHiy9yuo5b/d/tXE1vAVrgHBnCQA+qY8WnmD6wt8IJP/Ab/BG1ngzWc+6zBU0zIz1mX9SLpBX35NBREDSh572IpRuvzyFdZk6+tYMHvwKBzF05eUtUBF+GcMBqHKcMWzVVdPRiOod4kr6Q0aQAV3FfXBuuCQWBkZCUCum0GG1HeQ6gWCVAxVkYr8BHjybwNa4D4O/C3hfD1Zepae2KdvVgvMjqy/k3nSBKhj65uBop4Li6ld+JZt+isWIw2/MH9/qlLimcEUJXiQQNyGNj+1NemWWuSnsr0D82yHR+XEY5zD2+nAa1rAWhTExXt+w6eU7r/b5oPsnxcVG8K/4kgoIGSPlL5KpEDfRxIBMvtrC+CN5tt0FIf6V2VDBnYDtzKans88A+qaAaiqhZu8cfdDVrTo4j+NEkLOnlBMYcbeMw8J5Ph7SQpdT4T5+3o2xp5STuFx8iHlpSsKEjGmIf23uCkEl/b17z5+x/QhKmP8gUnqxrg1KSkdbPo02CfW3THi6jhYyNhuEHB32zURGscuWShjaYM12VB6bR0jjqUfi6OlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(38100700002)(4326008)(6486002)(2906002)(86362001)(8936002)(6862004)(5660300002)(66476007)(4744005)(66556008)(7416002)(83380400001)(37006003)(54906003)(6636002)(8676002)(66946007)(6506007)(36756003)(186003)(2616005)(41300700001)(6666004)(316002)(478600001)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXFZArKWqo8qrSBWfWK0wieO9PsBpwz53E4SAVk0wKoCudbwO4Y/gC2eX8Os?=
 =?us-ascii?Q?/1ATaYEQoJKaU5PdiNWPTgGdL1uguVsyHJFQQKUu25kLBahIjN4yp8Ao0mJZ?=
 =?us-ascii?Q?djqkN7uTVrBnwk/icyK2LR7F5HxfY3DILAYvBLmCfwEfF/qf14TB5A2pakgc?=
 =?us-ascii?Q?pw/t38xOjnYBGvRXF7sBY89ACXMybFO+DEa/zJn+AdvnPVoWlsCTgHwNhaah?=
 =?us-ascii?Q?DMfSdZ0k0xy35+MC52BppQZbhO7wmCTp0ToBhjgaGryHhIitdMDB8D7vyRdr?=
 =?us-ascii?Q?Cgu+l06CpYacV0Be6DbUxqj0UNCmhqBR3b+y9+1Fy0mzTGiLcodc5AEwbT7g?=
 =?us-ascii?Q?WiM+GJ41/i4FAvV8Py3zdE9Q5aJj3XvcGn2m5WPlQpwmJ+UPQnjP4rPwVxsQ?=
 =?us-ascii?Q?55ndRW7SYM029fJxzJDPUpEYu/pHI8vkG3pHv8X2Gh4j21xMV4bi/XSUyT3a?=
 =?us-ascii?Q?jsWYejXERTr+t3xbQ6VJAwKjA0WRe1uumUj9zHx8LpDO++UX96vLmOvzwC1g?=
 =?us-ascii?Q?5KlXrizkImvpBLeoMOUzja7vcvl2yqo3Z4FegXlLXy7QTBVFdVE6G4G1MA4U?=
 =?us-ascii?Q?u+9ePW38B0/gwHm1QO1GoIDiJA8cRqOsKUazX4yDATsf7b6jWyHiRxmfmhLC?=
 =?us-ascii?Q?en6WgfhfDcqhpztwLl4raDAVvjDxHgYu9xyGCSGwq6LVfLsc5NLwtfif9+6F?=
 =?us-ascii?Q?RctiCOfeb+OpyYXg5uo05w8wGzWcVlNCqukO4yIzNVkdj2iH/1x5CkF6CM96?=
 =?us-ascii?Q?6eDwlf4bJn5X/FScAV99lzQHkVHFViKhlLDppMD0FFWnzDICXqNwYET61WH8?=
 =?us-ascii?Q?s1ZcVEA5MmVRyjjQTVu2JYaHgsL8tirsTVnW/Vgv3hYRKdLu4zhvDMt+ypmy?=
 =?us-ascii?Q?7y3hMk3GPT0FJLKovEm6dPFVPx24gSuW8gtn5frLCMJs2Q6MjDonDlCC5+s5?=
 =?us-ascii?Q?NiXvf//cuEU+kejS1OKzTGq+kcD71DkrY+OzmvvY1wA4MxlzOnDbHUQ5Yzb9?=
 =?us-ascii?Q?V5hf3e3TVTzk2oGPA7ZZDoD6/itsRFntgt9aiaVHEnX+vAmDvx+ScsK33sTX?=
 =?us-ascii?Q?/0UK8M8nx2KifEXL9zoiFZ/TucngrnLikkCE3KVD6mZHt7dR5MdsLf3dO0IP?=
 =?us-ascii?Q?XtXe6qw9G/LDHSMD/N4/TeMlQJDi5ne1N1T8DcNBAFQzGm3V/h/wJ/feGWNV?=
 =?us-ascii?Q?pkU9kuwXQGImOM540U8kMwNRD4Yf6A+KhFqPuChoashp6ueFascgUXpK6O6y?=
 =?us-ascii?Q?QlxVhYIDkHvOPZC5NILVfK+1jRLvogJd83dz5ogt8hO2mZWcN8HRfSj3FC2/?=
 =?us-ascii?Q?qJV2UhDxrMwY///np6y550Yv2oQ5ilGCU3ioboBE6sLSSaH+3TKBfvY+2yyt?=
 =?us-ascii?Q?wfbYIVatuLpXV3qRLnKOc8QoKpqwlu73qbK4WFLvsje4Z0StpOczDIk+3Qp6?=
 =?us-ascii?Q?SKD47S/LKrME7W1YXD0VROmU7WRuov5TL6Zuv3MwdFsSdoDVsV3aHSzfSyAx?=
 =?us-ascii?Q?1R77bD929AuhX9/RPJ4mfEmQOnxTDWkc2VnDg0aWa4QIHDnHDwRU9qdF5CoK?=
 =?us-ascii?Q?A+IdANrOtrzCTcb5Hu0dBbG6OuCD1t1Zf11NFdyY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606cd5ae-9dcd-42f9-7ab8-08da80a9e8bd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 23:40:47.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYdMwXiS5n6wt/zVGKeQuMZTXdQacjjaFMtH6P4R8ZEOc8D0Vq8c4hT7ail4S8uj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 09:24:28AM +1000, Alistair Popple wrote:
> 	collected = collect_longterm_unpinnable_pages(&movable_page_list,
> 						      nr_pages, pages);
> 	if (collected == 0)
> 		return 0;
> 
> 	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
> 						pages);
> 	if (ret)
> 		return ret;
> 
> 	return -EAGAIN;
> 
> Which IMHO looks at lot more normal and sane than what I had.

That isn't "success oriented flow" :)

> > But why return 0 from the helper function in the first place?
> 
> To stick with the paradigm of 0 == success. Ie.

But it doesn't mean success if we squashed it to EAGAIN here.

-EAGAIN == retry
      0 == success, real success
everything else == -ERRNO, failure

Stick with one convection in all the functions in this file in this grouping.

Jason
