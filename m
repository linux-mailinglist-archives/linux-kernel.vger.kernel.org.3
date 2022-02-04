Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB374A91FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356303AbiBDB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:26:11 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:57733
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbiBDB0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:26:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkgB/gZY2KRuyI/EbAGT8jVRdii/QVoK55ucSTyg42CWoVPVV9vOaK81HWrtAsZKwwYRkAEh/aO6cjhPkBSdLpzafENwykQ2jWImbF7Wf3mbGJwMYmezSQLmbqFKBowN2dVNVaY2RG4Uap/nT/jhRuPGTxdpKNbwt4TfIjlPvjsCdRftMxXAmCuUecS1OfV23F48ZA333dfag+w5USFBmV6OokQr1DVuNWYypr4K95cQKU3PrNK0K1v9CxRVRsFi0WvYmxAo2OfAjtvSvGLwN6XHn2xUnbCzHSB28A1RcdMBQ889XSS83XhPC4PTQUXzoYzIkouywF/0WYY0MU8lIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmMdKTuKhojHUm60ccr0xIff4pXojie6d1IS9wysTkM=;
 b=XXJBoUMKwjHR4L/919IVKPLD7NsD/5hqI2YzV/TwyoK2hTJfLsiT/5s0lO4Ag9G4tRWzGIPUk6KgBu3HVIp+zibAw+gpfgAJQGRk97i+Ck9aWAkEAIu7Sv6Yrsx7bP0LfDSHj1AJYra/ltM5JQhDLw34v1E/E+8i5s9xindu3rZ5vnMZ1Gxyqml4eFaZYSBFA9dDj6iHuH/yq3DJ/p1aX2ivDrMgdsJJjQt/57JjTnjKbRjM4MhUo/+YrhFrVLWVldVekuMI3KH5mRujXrqY/E3g1SIVlEUNcJHQvRRnSx6E9HFOo93TBQtzoCF5tEs+GaezAQrLeoNNJDOsz31D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmMdKTuKhojHUm60ccr0xIff4pXojie6d1IS9wysTkM=;
 b=B2bqN8Zeso3wDGcFbScbv/auqN2ClcnzgoCYth1Vcqlk8JegATH0srg5fuWcrZv4aHmvk5bSGSFwpKPpyzJCdlj9FvImut+y3G1FYSEa+L5lAnRuT+pn8bYFwbYe8wfBjQ0+22Ik1ob2NiDIL7N0mYjXKrWs/han9pnF++jmXUqEDJY7LGkYi9YvPmITY5tq4UjRvOsH0wbfKAEPxIoID6sxdQF8dqbGCEUqou+i8FMjsSG6ZzxSh0QAzntOrNfzTKc1dx8CvUqUZas1IAJ1nQMSERgf2qisE+Syo2XN2Ni5Q5tgvFSgEVROswGmIH53WZACRMl44dHJqnZB1HQhJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 01:26:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.012; Fri, 4 Feb 2022
 01:26:09 +0000
Date:   Thu, 3 Feb 2022 21:26:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Weird code with change "mm/gup: clean up follow_pfn_pte()
 slightly"
Message-ID: <20220204012607.GQ1786498@nvidia.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
 <20220203130137.GZ1786498@nvidia.com>
 <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
 <20220204004541.GL1786498@nvidia.com>
 <c0f57bfc-d34b-a34b-4f2d-0d66782e4ae7@nvidia.com>
 <20220204010612.GO1786498@nvidia.com>
 <afedd0c6-23c0-7e79-3b14-48fffaed7f99@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afedd0c6-23c0-7e79-3b14-48fffaed7f99@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1bc984-9274-4276-010a-08d9e77d52a4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB418013F1D7D905C1940DA329C2299@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJw3y0uL89koNqnZmCbMNDWqTKhJJbehFkyc+xNeAs600Cn9Vl/2xiyWle5yR+nqEbOlRcsSLY4RzfJvjCB7z6b7LteONlD1DUPdLxojEunNFMmB/JtkJ1jF46UAbywJMfVd6mFAG1vjUUSQz3VNp57cN/7SoDA3DyG0aROhIKHkxBXrcd3Kdo25s8k0TSe9PUhKLeQc2Y3Lg2mH+TDRA+4A63vaRgYSYWX47c/rZadKiGzQU6RKU76wgZ1h4LA3l2hkFQWznCxam09xD0rEK0+Qbl7EAxwF8Vs4Rijs0UWFL8h6GivQlDYFWIV1ciEpQv4oDD9QTKpt/OCCSnD416wL0uUyd8wOOdps572CJ/fLhX7KuuFOVke0oi0LyGCllpgxtteazPqBEM8wiM5qYXR07EdBb0R0gtwcI3huyhcVNgyfYF3FwkLHqoTksgn1qllzUnxQzo5t67BpXvKV0gPo3Y1Ysm0sVIoimxLq3wFALjc/7T1sprmadhDWtS1URxEuz7ZSZ2Ji97L6CGVAn3K2MH4KGX1+l6R9QGVuPueknnTEM2moa1HFGvQcnkOuBMSuUJ27S0fwFjuAodE20NOEXTzCVCN4ffxa0qoPlFz9qG4/Y8ib27ndlmzeR2d7Os9u0PeaeIYGZ1cfSTDrqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(86362001)(38100700002)(1076003)(36756003)(4326008)(316002)(66556008)(33656002)(2906002)(8676002)(6862004)(66476007)(37006003)(6636002)(54906003)(6486002)(26005)(4744005)(7416002)(5660300002)(6512007)(6506007)(8936002)(66946007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HW/shb3/aKJjqi0j30HixqchMf0DHWdQpBa+xzOrJPg7OQ3ZFFv9qQaN/Fk6?=
 =?us-ascii?Q?QBqyiJ0mt3cuVgDdxSiexlSXKccLU14qmNz+ejgZdIyyQ22PtrSxWpgT0BSD?=
 =?us-ascii?Q?0A07ab600trxjaMzY3GinabtYDUeqvF8KC9AF5T+nhPwiRq981PXNDD7A3RR?=
 =?us-ascii?Q?Eh5DSUn961MpMCjjh/V8QX0SQhQ++lOobpmrfSGO7xmYJW/qxxYpm8q8p3i6?=
 =?us-ascii?Q?LXrL563SNYYZYwjJMxgDXZCR7ObOPfAb5sPqx4unFXAe4+s0X8yUZDdzMiRE?=
 =?us-ascii?Q?WJ4qkJEFX27MqxjrcJH26KdiN0+DKXs0kcoKYzwLKH9ByK4f0LcpsHQTmSWt?=
 =?us-ascii?Q?KqRBKwt8zxUNSggXMFX3ipBcSYsBSOoANKCxewx1lnGRRA8FwnETX0nzEHP5?=
 =?us-ascii?Q?A5g5ril4qthamq3hZTx7HblhYrMu3XiN28NUyee7xGzBIeCPAW1GRuQDRSth?=
 =?us-ascii?Q?0ZLdi59pizpAlePMh5/6aHup6Fk28iMk14JzdVc4ZlLwFrrmO3VUVm802f/t?=
 =?us-ascii?Q?9JVt8qlqVNcYttuaBvS/yIKGDpKO/AAL2ZcP2Rpo2cWM8g9ORpTMfFbUyaOF?=
 =?us-ascii?Q?aMM1qXppNACgwEthlE68z7n+9xuk2/f6EJAg7EdZteBlvlOY269PKT/o3dks?=
 =?us-ascii?Q?2QWpghjep75SadDq7dG713sxYM08T22tdsHvBcmVP8wCWsUssUlvl4o9ohLF?=
 =?us-ascii?Q?YB3FgQZ/u5CpfFzDMnzlg0ZY/zH17Ubx/jWKgYcl3EMFWAxV5nx4F+ScQ79f?=
 =?us-ascii?Q?QxivWq+ovxD5j+9kSCYz9CQ+uvMPZp5GOHhXtdSu0I87E4+Dk7t86DnanNtF?=
 =?us-ascii?Q?737k9pALp1ECS04G6AB1OmmUUZ/l3IFG5MXPuJC8bVvMKHkdxx/4b+htB7lT?=
 =?us-ascii?Q?sQ+oFXShi2358095+h/YimWWEpcbs56p22CFf5jhMoGpPrx7NPT0VdZfLawx?=
 =?us-ascii?Q?xxhTLUCfCvcwjby02guW3y7HIURneTilv71OlwO4772m3TZuurkLyYfRboSL?=
 =?us-ascii?Q?XjZEwhUXZKovxucws75Itu2kd0u/sxwrhozxG7JVdDXTxqICrqp/T7PpW2gC?=
 =?us-ascii?Q?cHa6gtzDTvI99cby+BSW1FArYapsipWHP7HRYsAY7ycSak0lkoUKDv60740p?=
 =?us-ascii?Q?c3SHVb34BL3GV7tUmI8jG2zR8ZWi4to+DymAYE+tUbKHOkQRPG8QIjSScweS?=
 =?us-ascii?Q?wMpR/hmKXidZiD1/jHvaW3hVqYPgBvKZZ/dNwSMfoyqp5306LekgGurGvwLA?=
 =?us-ascii?Q?WVIepDKG4lxlyG/zG2ZOejEUpgbwXUSUSzGHiaVoEV/DIBE9hQUR8KMThPE+?=
 =?us-ascii?Q?SlyRWF2UTRNLDWuzJsR0ONqKddjbQXqJPRGyUUpehGWiErje69LwhxlxCKQJ?=
 =?us-ascii?Q?SPRPxKlJ0doO/TUFKUSo9Z3u463xOR7UQEAyLYGJ5W5fiVfaL1JprxFyveNK?=
 =?us-ascii?Q?H1qO1Qrjw61o9lqknIjty94tPofVeVKLBAVYBvqRYUY8RLGtqDVAOmTEVJes?=
 =?us-ascii?Q?byCZ18WDLzDSvN5ygjRFESvn8trqakQNaZrKG08wY/O6hJ9mTYnCaBZsng7q?=
 =?us-ascii?Q?BZ2RBv0YoZy0VcQoAW0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1bc984-9274-4276-010a-08d9e77d52a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:26:09.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ7FUW7/DtGH/7+bmbdHyUvtZT2wesITP9BlMyQF+gLsuky3pp5l/+NbEI97u9dF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:22:36PM -0800, John Hubbard wrote:
> > So why do we return 0, if it means an error, instead of returning the
> > actual errno?
> 
> Well, now returning 0 sounds all wrong, when you put it like that. :)
> 
> So, simply this approach? :
> 
> @@ -1205,8 +1201,15 @@ static long __get_user_pages(struct mm_struct *mm,
>  		} else if (PTR_ERR(page) == -EEXIST) {
>  			/*
>  			 * Proper page table entry exists, but no corresponding
> -			 * struct page.
> +			 * struct page. If the caller expects **pages to be
> +			 * filled in, bail out now, because that can't be done
> +			 * for this page.
>  			 */
> +			if (pages) {
> +				ret = PTR_ERR(page);
> +				goto out;
> +			}
> +
>  			goto next_page;
>  		} else if (IS_ERR(page)) {
>  			ret = PTR_ERR(page);

It is what I had in mind, I certainly wouldn't add a new condition
that returns 0..

Jason
