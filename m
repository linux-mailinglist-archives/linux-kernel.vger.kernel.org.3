Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B674B31ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354386AbiBLAYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:24:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiBLAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:24:21 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF59D7D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:24:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3oAtbrcKhpmFSJ6L5B+ZiuS+tywdoiHl3pCT2DJFYlZ4cynIXSyzM19CFkRat6RzliG16PseAS9pPjT0YoOtIfNS0bKONKA8qX37FazeT8xfEdUZ5BcN8CfmO4hldOWfe9EPSiJ+NSrFNQfTO2rOBjE4DPb9tXl03GRPQbopPHOeSQmCDbCqhLzrSqIwkrHeR/t3/S+yVGyewKJG035WeaUqTvJ7VHTI6tKl6p7MFlXQvnuDCCgKvVGZ8dT/yQzeW/DRVdt1bc0CdiN/PgZsFu/StDL3Iq9Ru/WXoGsKjSs68iTD5LpY4rjZU2YHMwEXVG31e09T3fTSX6kwNzILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms2O+WWZDkt06Vvn9djlZSo6r2oTRDh6iLJsabvQbb0=;
 b=EBQOMwi7kZ7SF5mzn9n1rzogzoBWhHGqIBrUWtisudIZrzwqsfzcFEkMj2A55QyHoo+DqJOVjUyT8E/OzIY7/Z68ag+EPODvlMptC9Yfqt4NnspEdnkReebfaM2j7RS5/32kXDIHvUmg3GdX3u14vKgBJSMC1R3KV4m8s+OnFPThHdVSyhZwAx5yftsFGQEOGzJzNviKnpKWWU7ImOEOQNITDv5pag2E/UKkz8Ked3MlnnhPUc9qG9cE5ZKN1HGP9u1kfL3P16T3K7ouaGLb1zXqrYvPFodThTXHSXDe+Ecd5+FHLqlZZ2kko/fdosP6Xge29vdLp3UOOUB6M80Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms2O+WWZDkt06Vvn9djlZSo6r2oTRDh6iLJsabvQbb0=;
 b=spcfqIu3VydH0CY/6JokT1KpBkUruGB04Wg3bZRtTyFoeFCPh8rhlKCiD4HZIFxOKef0qBSN5cOB96ZnThTZyxFZTmwAMvhzn55rKBiSu3Ldu2zCLtOFVwEkfgxOasmvpWKmLzSm1FYoIpRVRCMVPoaM8UOAuv4EFrS1t45Q9ZRtvZOa1A5X77wM6L7ziAYeOKZdvoH5xdgbKozS4thqLuy3shZlaJF7f28FIsaxfCXFv0Tgu+G7X9f/gb3G+ShklVw1g9Gd49oCrNKh6a4BWrUXeqHaXwKXRa5iIFh/f1acoVgNx/+KSgZSvO7nTXY5f8KZmBq7ZJjWBJqsb7g0+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 12 Feb
 2022 00:24:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Sat, 12 Feb 2022
 00:24:17 +0000
Message-ID: <6712a07b-d1ac-520d-8bbb-7539476ec679@nvidia.com>
Date:   Fri, 11 Feb 2022 16:24:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 0/5] mm/gup: some cleanups
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220207062213.235127-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90f26e3-4edf-42b2-7779-08d9edbe0115
X-MS-TrafficTypeDiagnostic: MN2PR12MB3743:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3743449F29124722832DFBA0A8319@MN2PR12MB3743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMD1nLBlosE6BoS8aYO8d2SFeFQeqo01oc+8cRKiFdUMOhF64m47xJ7EMrlq983wRqUxHuSnU968Vnfp4vUIF4UjogUfPg1f/lKd0OjakDjOSwMV0+b4TzMLJN4b3NhF1JAKcIXXcPKqE6fvwtHK2Eir2V9yJw+v4w3vx3i8C7fS9TA2y7w/10flEHCvpXB71sJ1mnx5t6omum/fAJgea4qqTfYtwFp8TL5xg3nd77irn2L13g/g+zAvBIpDjmQBDHNeDFWA1U6Zy5j9x8keeDEAi/nV7zGJO6Zm2CvYvcOyP51OvoEWqTf/jHa9GSaN7VH8fdJJj4KJVFbaS0UbuVZ8bNjM8EG51L+nV5VpTeZ8pjjuqM0msFkZUOvFWWgYZsgzhtJI5Iqa7015V62UneoWtAjqGoqrCIE/QQzHD34mk7jQjvP2hZ0zglUgkE+AQ+lIbO4Wq9AYg0NF2+tiUovJujYKetI1qA2I4BTm9Ro3xKkHaXIfaQkA+fxqPl1pJDyxPMKCpzwRhx7yVEeuCWGSpB2rVDg0YRxRyEoFGj21PukmxZzcX6+1gCtQdmhdwd1RHytfIYcsjpVShulgfFXbMVv1vSbh6+q8AznQx2LOvkOL8zdS/dJqydSQThJV4dkzsifxwNsRan1twGPVYbcjn/PgBoHYgHVf+Y3mPgpogg8+xrId7NjVlh4BJaUoUSXlTdHufLnpCuazQj2n5e/36AAvLd0wZaKrE72x/xXzSyLXqEVt2bTQjIrDk+re0ap7w3IjegTCfclXs6LZiCtHyFYG5/6WNpIeTZB4gpGAS657+ysu00WVa0P1fuhA0UYfAxhE+ggAwhazTfIf7cYPFlsYlXHW1nRc5KplMQOhkBT9SHD3EjBKWPjMUU/h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(7416002)(186003)(2616005)(5660300002)(4326008)(66556008)(66476007)(6506007)(8936002)(66946007)(53546011)(31686004)(2906002)(6512007)(83380400001)(36756003)(86362001)(110136005)(26005)(508600001)(38100700002)(6486002)(31696002)(316002)(966005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5hNGlNSlpMVS9US0h2S0c3eHJ6QjBXYlJFbjN2dzZOS3dEM094SUFSdG5G?=
 =?utf-8?B?cXBENTVLa1NLN01UdmNsbTRucE84UjRuVGpiQjBlQ2F4U3ljenpQU3NwdFIw?=
 =?utf-8?B?SlZtQWs1N2ZsRkdpWDJudE41alA2OTdpS2tZcU55UzBKNWYxRW95d2FyRWw2?=
 =?utf-8?B?YjBFdG1lOUMvdU1hOE1UQlNLZXltZC9OeWlaWWpINEE2VzMzT0VNaE1iaVZm?=
 =?utf-8?B?cERQQWJYSUFEVGJDdU94RkxRTHVTQTBTbXdUTHFZWXdQMXJqdGJ0bkRxcDRW?=
 =?utf-8?B?Y3FWa2dTWTlxWWFoaFZBUFFyZjNMcklvaXlLVzBHK0VVUkx4Z1E4cjBxTHBR?=
 =?utf-8?B?WWZvNDVKeFZIalYzWTVMUmFWWFh4VjVCLzAxZUNDRVc3d1RFT3BDWk5qblhD?=
 =?utf-8?B?RVViZ3RnazdpTkE5dXdXb3ZrMkkwc2swTnp1QVUyUGRKSk9zMGFrQSs2VkxZ?=
 =?utf-8?B?TnUxdDFhVVM5UGVpd2tCcGs4ZWJvOTRGUUo1Nk5rUUNwMTNUTVpQM2c4L0tO?=
 =?utf-8?B?VWwrUzJMbXFsZ0lRUHpjcTNqZlV4enZjWmNTZzRKMlJVTDVySGlKN2JZd1JY?=
 =?utf-8?B?Zlh2M1NKdVFLZWpyRU96Z1RGNjlOamZVTHl5ZFRmZFJqaE80TlJRUlJTb1Zk?=
 =?utf-8?B?bmRDdmMxa0FsTU1oTkI4RWhHNmk4TDA0Nk5jOGx1TnUvaS9pMFpocnVhcVBy?=
 =?utf-8?B?cFJ2RFY4QlVybVNrNkQwOE9uSEw4WjNrdlRlc1ZzMmtqSXdRZE4rQkllWkNY?=
 =?utf-8?B?NE9vZFY0SncyT3BWYmdUVmpxSWk4Qks1REp6WmVIUUNkWU4rbVhZZlRoRHpU?=
 =?utf-8?B?OHpNWU9DWHF6K1JHOUdQb0w1Q0FOZEZNWWRZbk5nOVNnNW1iMXJub0pjYTVl?=
 =?utf-8?B?QzZGbnRycVI0WmNSVWppMzRIYkxmbG5TUDg1OE45KzZyZk1TdWMyQXNFQmFS?=
 =?utf-8?B?VWhycXcvb1pVb0tCK00yQVBQN2xBOVU3VFM3UFhMMzBxWHFaM1pXaW9aRlR2?=
 =?utf-8?B?NlVFN25TYVNUalhyQmVhRGxxS2xnUmRndUFoVnF0c2VCV0p0NXk0UWUwRmRE?=
 =?utf-8?B?ZDhBRzRkOWE3QytRRnlYank0SFRTbkNwL1FRNTFmdFZRY3NNcU9ha0pxbCti?=
 =?utf-8?B?ZWxZemtORXFhNGh5MUU0YXpsL3lkY1ZZZUtMS05WbDhjLzkwdTV3SEZFK1BK?=
 =?utf-8?B?T0VmZGxOVm9ROGVZQ21HRCtyU3RPZ0ozdTErN2s3R2VNVzJndEdJT3hmeEVY?=
 =?utf-8?B?VTJ1bWFPbmE2WG1jNkVzRXpYeno0Tnp6ZXpBbjMzWlNCWWU2cjZ0YmlmR1hJ?=
 =?utf-8?B?MW5Gdk9sQk50SkNUMkx2MmpWOElrK25ybnIvcUNrZm9wS1NiZ0xiU0tqT1Q2?=
 =?utf-8?B?QmQxeisrbFZGbXpXR3NnRGRST1Z1OVhUekxKY3ZFSWM3TUNMU0dWSG5RcUJI?=
 =?utf-8?B?QnpXV1hEbWdPbkhPcFF5VktLY2hhZkZmODVsYWlkb1JtRTF3UHhRVEtFNVNN?=
 =?utf-8?B?d3dTdDhDQ215T2VmWkpndVc4ODlRSjRKUEh4TkhKb3d6aGdqcjYzeTMwWlUw?=
 =?utf-8?B?UWt1NUNjY2JYVElsdU5SUUVEUGhZNFM3S3FCV1U3c2c4c2pwaXI5ektucGFG?=
 =?utf-8?B?Z3VVTk5Ld0Q0dUVnU1lQV213bHhxSCtaa3huMXZsTnVwMkEzYVQwT1gxcmJK?=
 =?utf-8?B?OHZCdk9FZ2F5eHN4RGcyQWFlK3U2Unp1T1psWHBpOXZQMzhIUU9ZN21vTzZI?=
 =?utf-8?B?ZEdrZVphWGdYTDM0NGw5Y3JMbE53Z2FqRGRGeTBaVzVNcWgyL2J2T2Vucmk5?=
 =?utf-8?B?ZkV4OFRJMFg3T0NjZ1RHS2YyRXZweXZxSDB6UGw1MmxJL2dSOTdBWEJoZ0Mx?=
 =?utf-8?B?eEtiQlMxdHNxb1lHSVZvZzVFUm5PVGVSclNpZC9tN295U2xRS290a2hjYnNz?=
 =?utf-8?B?Ti9INjFuRVBLTW5sb28vR2Vpb0VzbTB4eVZlMEZCNkRLcTJubTB2MFVXbDNW?=
 =?utf-8?B?bnVnUko4bE5Na2VqNk0zUzNwWU81NWMxZytFYmN2K1d6L1RTTnIvdUpvWnNr?=
 =?utf-8?B?RDd6UGJUcU5UdzZsdGdFMjRSM1I3cmVFV3FiN3VucEpsOFZUN2xDZks3aGF0?=
 =?utf-8?B?dUNGODBKa2daUzNpcnFnTFZ0TUltcVNlOWpwbEtwN25nOEIrR0c5SWE5bU54?=
 =?utf-8?Q?ppmIlOK8sJkKi9BAIhVWni0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90f26e3-4edf-42b2-7779-08d9edbe0115
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 00:24:17.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HPtxR8c7BE9GSq0TOHXKpul1xUM+/ay4ATctO6CyRDAG0EwhksDElQkibNFawRAp7I2jEH2g3Gw4oGYlAofyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/22 22:22, John Hubbard wrote:
> Hi,
> 
> Here's an update, mainly just collecting reviewed-by tags:
> 
> Changes since v4:
> 
>      * Patch 1: reflowed the commit description to 72 columns.
> 
>      * Added reviewed-by's from Christoph and Jan for remaining patches.
> 
>      * Rebased onto 5.17-rc3.
> 

Hi Andrew,

Is this OK to put in mmotm yet? All the patches here have been reviewed.
And this small series also does not conflict with Willy's "[PATCH 00/75]
MM folio patches for 5.18" series.


thanks,
John Hubbard

> 
> Changes since v3:
> 
>      * Patch 1: Commit log: removed a reference to an out of tree module,
>        and updated tags and added a short note to that effect.
> 
>      * Patch 2: Fixed up do_move_pages(), to squash -EEXIST returns from
>        follow_page() into something that move_pages() allows: -EFAULT.
>        This is from reviews by Jan Kara, Matthew Wilcox, Jason Gunthorpe.
> 
>        Removed all Reviewed-by tags for this patch, due to that update.
> 
>      * Patch 4: Split into two patches, as recommended by Christoph
>        Hellwig. Left the Reviewed-by tags intact because no code changes
>        were required.
> 
>      * Added Reviewed-by tags from Claudio Imbrenda.
> 
> Changes since v2:
> 
>      * Patch 2: Removed an unnecessary line that was causing a
>        clang-analyzer complaint, as reported by Lukas Bulwahn
>        [1] (thanks!), and retested locally.
> 
>        Jason: I've boldly left your Reviewed-by tag on this patch,
>        because I am predicting you'll agree with it...
> 
>      * Added Reviewed-by tags from Jan Kara, Christoph Hellwig, and
>        Jason Gunthorpe that have collected since v2.
> 
> 
> Changes since v1:
>      * Patch 4: changed from get_user_pages(), to get_user_pages_fast().
> 
>      * Patch 4: Rewrote the commit description--thanks to Jan Kara for
>                 that feedback.
> 
>      * Patch 1: Removed Jerome's Cc from patch 1, due to a stale email
>                 address.
> 
>      * Added Reviewed-by's from David Hildenbrand and Jason Gunthorpe.
> 
> Original cover letter, updated as necessary:
> 
> I'm including Peter's patch as the first one in this tiny series. (The
> commit description has my r-b tag in place of my Cc, and removes
> Jerome's Cc because he is no longer at redhat.com) The second patch is
> what I had in mind for a follow-up to that, when we were discussing that
> fix [2].
> 
> Plus, a couple more small removals that I had queued up:
> 
> The third patch removes a completely unused routine:
> pin_user_pages_locked().
> 
> The forth patch removes a similar routine, get_user_pages_locked(), that
> only has one caller. It now calls get_user_pages_fast(), instead.
> 
> v1 of this patchset is here:
> https://lore.kernel.org/all/20220131051752.447699-1-jhubbard@nvidia.com/
> 
> v2:
> https://lore.kernel.org/r/20220201101108.306062-1-jhubbard@nvidia.com
> 
> v3:
> https://lore.kernel.org/r/20220203093232.572380-1-jhubbard@nvidia.com
> 
> v4:
> https://lore.kernel.org/r/20220204020010.68930-1-jhubbard@nvidia.com
> 
> 
> [1] https://lore.kernel.org/r/CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com
> 
> [2] https://lore.kernel.org/all/20220125033700.69705-1-peterx@redhat.com/
> 
> 
> John Hubbard (4):
>    mm/gup: follow_pfn_pte(): -EEXIST cleanup
>    mm/gup: remove unused pin_user_pages_locked()
>    mm: change lookup_node() to use get_user_pages_fast()
>    mm/gup: remove unused get_user_pages_locked()
> 
> Peter Xu (1):
>    mm: Fix invalid page pointer returned with FOLL_PIN gups
> 
>   include/linux/mm.h |   4 --
>   mm/gup.c           | 101 ++++-----------------------------------------
>   mm/mempolicy.c     |  21 ++++------
>   mm/migrate.c       |   7 ++++
>   4 files changed, 24 insertions(+), 109 deletions(-)
> 
> 
> base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566

