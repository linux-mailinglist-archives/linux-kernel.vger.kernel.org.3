Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E305587CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiHBNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:05:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1470260CA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj1qIjefy66wLpNgo/mSyYjCLIDlkyftjcV5zzQoESJ8rLG9VRFtJQve99jnE7Ok1T4DOWhf1Txc4WLIL9VvDwdHBqhJdBBCWRbqXUYhddbKUQhihGqSQ5YxNwzxd7+KRMPwxlbI2/eZB1ZCd+OibQXrqF3pRXw3SRYBunr92FU5CNC+t79qFvEzIeROIGMA3dG8pQa6xY/AkjAfkLtNh9jZnoMW8UsXR8jcBGNStAal+AdxXMnYnK93cv8u1JGUhM2O3FORzxYgPbiwh4LJuBiiw8MbB9jkgGxGocYOAg3YD0ili57XXt+grjPCUBG4eNn1pKtffSnAYwVQJ8yqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHmS7WMyA34Bn0aC7lJhjPVjeWJAniM2yJjpOFEBwgI=;
 b=WizJ0Hu7+ngCLz7H32cXAvaWeMe6fFS9Q/Lb8F48k2WmRXdxzZhOqeFRyNn8HWhLrje+40iCnP/6OHrIwrvXJYRXvjCG4vB7xZq7PBYOSbmq9xK+2e/L6uLvgweNJdfuU+VWa9/Raj4vUjly9S61BMRqN0x5JP5+FELo325C1IRdt40MLSHW0r56sd1XHvnlOVRnXOQqHy3rSy0tqOnm+eM1dVeAAmqWUWFsN+vM1jyEW0MDA1Hg2JYMWR4BWMsMSit8dN/fWJulvm8+2Ta9RZyJqB7QYArA7ifiRbDIi7XfiIvQ+tcuCR423FFEf6vq1wBDASqYPm9KSLqX5zXzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHmS7WMyA34Bn0aC7lJhjPVjeWJAniM2yJjpOFEBwgI=;
 b=PHcavlQ1vTCuXo7Egm4WQPn08AvQqtcLs99zrs6gxj7vICMGGXzYEK6aFQyErI6nI09QREKddpWGl6nYiGGQX5tsmq8GRWutn/jh45GaCXkw+y3GfgTBOjQnqO6QOEbY1h5Gay62s5jxDIEskjZnLxS2uzKcp3NH4qQslOGKS5h0wffxEgqU5uhSXxTs6G5eUjs8rBSTf+G9uvmZlIRj4leIaDtwmIfFnf06x14AfttKAaePE8MH+Z4V3ULs7pPfxuM2yyFUzo/o6R0qDnPBuTolo6VZdn5uPW3NH8gDfgHrYLV+TAw/JAXhOMnarlepVDlQw7UgnlN8PysK6MvMMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MWHPR12MB1678.namprd12.prod.outlook.com (2603:10b6:301:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 13:05:22 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 13:05:22 +0000
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com> <87wnbsd6yp.fsf@nvdebian.thelocal>
 <YukWtNwRvOPh6jmM@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Tue, 02 Aug 2022 22:52:29 +1000
In-reply-to: <YukWtNwRvOPh6jmM@nvidia.com>
Message-ID: <877d3qdcds.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71062cbf-82b3-4e2e-6d26-08da7487a897
X-MS-TrafficTypeDiagnostic: MWHPR12MB1678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eMVqJDSoBkIg1woskIiXpKUGtBC7VTags/rOVZGzzbJhQzixSVQTZdSDSQr2ONm3ZxNikE8utmKaoe7hfnXk9H+aS9960AXoVgUpTj8P+57ulKOIH/+NUuqJhYPJq5VWhaeqsaCxCEFlLVSVcKYK3XZuR5b5+WjRFcix5juAHTSoeMRijGv+Ahdk/MtvRj3gvQzXkR8w6WrVTxWgvAiRkKGLNY/cnQ3/C8ryGQfnOVXLW6wrbs5GAVVkqhdY44wqxC+qDp5zuS2YPD8pWA5S2QWhabAD72sp5BMVIvecXairyPu6OC9T9w8UtfGcas9tmnQ8o5g9izByxEzgxPOgXpHa5sKsbO3ayOIjxTA9TdOhfzwIhUsZblJw/byPP/YcBbImOcpVVi5/UCI1FSKGjtYA/4Ep7U5ulTXCWcGuheSo/rNk8l/2pE3NBJNKHyFMMFvyQKrhFJLos9ImzC8D+NNb0wYH0ev/FoqjNGKyWfd6Pj9e/WLgD/welzdzwETPceFVpHltKiBsAlFurX6RFxrzlSF83ueNtAqsnLIa6i2nFSeY2KITkUL1QNdqmqeHfR7gKsHiWkvUHEhpAFu5Jfi1luhBVXWVVVCrqqM+CU3i4NwIOBZvOVzY2Nv9HEhpbZGWttxlpaodAaEQY7jdaYUYlwJKwWytOeFp7JRkc6QosNjPDU1yUPWy2lRcELbmSAeUtsAyPkFjT4tmYWmPpVvhXCGZfiWsFNU6kVGDkxMQY5e8BfP15pXQXpARaER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(41300700001)(6506007)(9686003)(6512007)(26005)(6636002)(316002)(86362001)(478600001)(6486002)(38100700002)(83380400001)(4326008)(186003)(2906002)(66946007)(66556008)(8676002)(66476007)(8936002)(5660300002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZfbfgysEkCSfZ7ymaRtvJZ+LOqmAEL5TI06y58DpKxs3gt1xC7DgvlcXohy?=
 =?us-ascii?Q?RfslAy17MOSG+YHqAh/uSH2T48NGdXw9KZe5tbwi9sw+lVbY5C51Jf2bfvD6?=
 =?us-ascii?Q?vZGQv2aAan90EajHwPFxa/F6tZQFSICEOWl8aMm5gValch66axKFptekaxFi?=
 =?us-ascii?Q?ys+eKwbZnxSv3tQwOnR/1hr5RO+Wgtk0aP2tWkmW8H2qw7MWY2yrey3MIWTL?=
 =?us-ascii?Q?KbtT9QJiCL38a9i593+LJ9DhDPTOrrTcXadsvxKR/3IVp3TJnDbAc7ehESm8?=
 =?us-ascii?Q?bauEDY8V7gC3RXcrVIEujwMoigB0KhQSN0/1sNmFNlhndLS1h+F2NTBqq7l+?=
 =?us-ascii?Q?BdVKzwolzpfVl5YZhyi3395Hn50NGIERutTrskdti7yyQKXAtvANTjmT1ocI?=
 =?us-ascii?Q?NNd4OcJKSMTm+6w9z0bBS/gClGfD0DqsXTywW1Z35TaCUFDYGn9CqhCq+mYr?=
 =?us-ascii?Q?pATpMTO0d9puFU7Z1xGtGXbnTxToW2VB9SH/nY39PljQDNmkzahlQ3MUJMyQ?=
 =?us-ascii?Q?uSZsstiOVxT9RNAlO/0dBaI2mXJlK/EWVCOUdIoNOLhsKUgZHG0V5z7PKjJd?=
 =?us-ascii?Q?4oDPu4x0tKoEuw+Y6cHzBHaEBCnKgJksT0rh+7Vp18D/XteGQzYQKbky1o+T?=
 =?us-ascii?Q?3ouxW7WB677Xc7MAp1NeOmtls1eCL742kKfVBEyZdasvtLzIAQSQnAtUZ1YL?=
 =?us-ascii?Q?aX6zCKp5cfM+fcZuaCiaIwRFn7ZZC3Nt7QicDCMPegE3vN28ahFi2UlFR3LF?=
 =?us-ascii?Q?I07fg7wJl0EYBx9Oprg5YLOPL+PnU0W0iAjBBcdS3rMxL0HWToGGZGdXFkxH?=
 =?us-ascii?Q?75rQNcEnsXXpaJiUOsXk/y5x242H5pwhKNHyNqqqX2/RMwtbsvVrt7Wld4kT?=
 =?us-ascii?Q?+vfQvP+0z9ntPupaCxd7PzD3RZjT23S6WguRbDTSysOYsBn6MpbeRP/LQQY5?=
 =?us-ascii?Q?WoznV7Mvd7FJB0KLqhguYsy/d8vEjALo176kzOAHwMA0tsMC51+IHViCduoX?=
 =?us-ascii?Q?P5mJnMJ1tOLd5EuiVSfTE5+acHij/R4h/fRpBrHt3wJKzh6svbIVsNFPzHyx?=
 =?us-ascii?Q?kBDWP2WOWS1EqHFPNl1OBa8YEdfZ94bK8M8Yhg9pTCZiGczGhFNt/0vJWpO4?=
 =?us-ascii?Q?olYVr9V9oI1yuCYP9vDLL6et0OhDBPZ5MaPB2pA4RZ+UjYOkM0x06valhXrw?=
 =?us-ascii?Q?4CDLAhS2Z0OwTgeKoMK0rDCpviCdyEaxap1l+7vqK5n72WYARyLU9RyPi2r2?=
 =?us-ascii?Q?VUEtah2Uce0IkvfutoIHxFsEy/gRYkXhv7wX50dlrQsraUKFxyn1eNee7gAk?=
 =?us-ascii?Q?jfH2qfzQ4dr/VAdNBxX53V7LOyJPz9o66QhCbmjcALg3URv4TwsS+b2DMeC8?=
 =?us-ascii?Q?fnp8Uw6TXNdJ9s+Cfdcje91RfeWctV8srnJPv86yba/VOwpaDxKZGesTf+b1?=
 =?us-ascii?Q?IRGGDP8rSmbu3ZKbaWo48FYqNhpYUBUJDfaiOblTp9Ct51x+PPrsbpD9y/s5?=
 =?us-ascii?Q?X7+qEmylzWpoPUFnyP8Zfg9dvcvuOGcuRy6iO84F0WWiyNtzJ8EtzMS/Ahk5?=
 =?us-ascii?Q?7qdqnhBpRLEDLJ7/8lxMykH/MVoyoi/aZi4t0797?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71062cbf-82b3-4e2e-6d26-08da7487a897
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 13:05:22.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSGZj3DRt7nLtF7C2Pn4fqIhxUVRSDGH536cW+NHJQy5CyXghzh5vgJM9e1D6Z69gE+PKD5s6mT168JSilHngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Aug 01, 2022 at 12:18:53PM +1000, Alistair Popple wrote:
>
>> > AFAICT there is no reason to 'continue' in most of these paths since
>> > we intend to return to userspace with an error anyhow? Why try to
>> > isolate more pages?
>>
>> The main reason would be if callers want to retry the operation. AFAIK
>> isolate_folio_lru() can have transient failures, so if callers want to
>> retry it makes sense to isolate and migrate as many pages as possible
>> rather than one page at a time as subsequent retries may find different
>> pages that can't be isolated.
>
> Except we don't try to do the migrate, we just isolate and then
> unisolate and return failure.

Unless I'm missing something any pages successfully isolated are still
added to movable_page_list then migrated if we 'continue' (at least in
the original code and this patch version, but not v2). Obviously pages
that couldn't be isolated can't be migrated, but subsequent retries
should only need to deal with those pages as the rest should already be
in the correct zone.

>> Actually I should have called this out more clearly - the previous
>> behaviour on isolation failure was to retry indefinitely which is what
>> lead to looping in the kernel. This patch turns isolation failure into
>> an error and doesn't retry. I wonder though if we need to maintain a
>> retry count similar to what migrate_pages() does if there are unexpected
>> page refs?
>
> This makes more sense, exporting this mess to the caller and hoping
> they retry (they won't) doesn't make sense..

Ok, sounds reasonable. Will post a v3 that does this instead.

> Jason
