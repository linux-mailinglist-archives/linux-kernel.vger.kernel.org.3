Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9B592935
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiHOF4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHOF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:56:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897EBCBF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLbWRCdrk537peygE43ZNlY3Omk8GjBaI0SIZZKVioO8t0Pd3lJ8M4LOvRIAwGxej9YwRBHwn7zSqjDCj6s2XfrOj2qlhpmGO1kz5RsmOCE5M3twBWRcf3dWadhZr1l52RzN2XPEMBIFjMN5Qw5uL3lDIWt6uw93m63C7aYVlLeDnlFNGZGDdipZJHQ2tKULdJBQU3pT9Uy/KyiYbgF0zOKEhGhQT7YyyeyEB+S1xMHcQEW3s3tR5Wr2ThmXSxaTk8nDaO4U9v1TYr4FYD2Ew4JgHN6bP5ySKQGpqt7/XN8+IUVnO6XMBrrn93MFIRVzZM9aLzWHBd+fLAIUDtoaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yREXTwDcofhEmVoO7G8RwROR1Ikjifhcc+t0NGXlsLc=;
 b=TZhGf9NpAu0dVKxdD+7m3xWGyaGzc6ydVt0jbONiWjf4SKUeBeww+ThNicutGheqN5X5HPxJYy0sW4e8XMmvyt2AR+k3+ZjYF14T2aQQqn+ZTjmm4sRzdJns0XUOTMRD0cKu3U9GA/p+LYldLjXi73KqWpZlLS4zSs/1qDtAJmA9AUAR939s3BcDfxmD54uaJSSjC7mTWgiTQ2QaXa5INVAyzf24Xy8nbNsdkaLRMiVr2/rFv+DPLjG7GlWFGlEmBUO+eypiQArrnXie2ZQI5TgttOlEotwXTq787IahLPysPZGiYL0wwI/Ku+7+oOeQvs/MKIvpB/veeNeVB3tAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yREXTwDcofhEmVoO7G8RwROR1Ikjifhcc+t0NGXlsLc=;
 b=Yw5o4G6WZjmM+uiX7a5QvCqXBBvY8xytxQaUNdULzd6frLqYy6odLPGbADFx0C9JT76PqZzlvxtb8tz0yPxfrh2LKvXuvSOK96FOGlClr+Lw73EH4DhC2Kg7NrO+nouQEXoqebz560/PyQetYCMcOGcUJbg7gjthvnteEWLAwj+RtuUU/dAN51u5BSyPu/fE/Ie8sACztVqvZu/nIIozw1YHpR/1xnDOdH4q4LQUKxn9/XcadUKYZHYToqflcl6yvLYEhv5UYidEGlpqGBavisorlrmow+sVe5jl/QRGebotf1lsXI/dpdjOFkGzLIMHOlIhQn3it2NpYAL4TH1j2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 05:56:11 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 05:56:11 +0000
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <YvZOSUrXoeYnuCyg@casper.infradead.org>
 <51d4408b-14f5-f6a8-80cf-d23cdb0a7c69@nvidia.com>
 <YvaX6emidD6ddjmb@casper.infradead.org>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Date:   Mon, 15 Aug 2022 15:52:53 +1000
In-reply-to: <YvaX6emidD6ddjmb@casper.infradead.org>
Message-ID: <87czd2vymg.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9b58ec-ba4d-4982-e102-08da7e82dac6
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W++CroTfN8wfMnO4R3TzGqlK30u9bG6n8UCcO3AJEmmS/H9Vh/4AcZwogCf0J/FXBAvhhwt18eVmJLLWJ2pAsJrZ6tKICOws7iP+On1+lO0YBKtVzf/l6QvBz0HRcpgRmaV3u914/jkD5j7hFQAFU1Ae4+9Zb+fboDh0vVAMkgcsfZgI4Yea5agl07iKkt4fo4H+uZN9WS6vYXcaDbrFDFlwBec1+phOWl29UlnW9anVTti/8rvmmoJ+qkPISBegdOereTajDxxm6Xl6czCOL2Qc/kbvxz/LcAIpHEDm0ieYxobakzhiHsAoQJ9Mf5A85H/FlbIbV2GuNosu9od7q/pQSwmbwCbvCvgJpPZzk3y/Q0WTmXPEPidJaSfJHUyN6NCt2qu+hSSGqMeke+gWcflJ6eapSPjNinSJzi17BVdD3MYFTOfzy1X7Om9G3O1hryM+0oFdUDPZ9uEgKraWnBbas+Zeb4LodWZH6LLvtGsOyIEZDfmHZp21c+bm6CeCw+9i0ZKsh1ZRfa1SQJxl6oDG0mOI50JtQKOjKhlrSruR6D86YaUZ6ZrSkG4tnj6jOzTQkTVCz5qRqiqHskBCoWgiGZS4QlnHF6JiJndO9cw1GN4HW3HbbjxItEILaZkneKCKdSeSNjY7tWqJwukUah0WSAzz8PJf0FFE9+4h5PrJsqJLMk9+V7tvPfchFFUgnKHsMrJZxFjSs+KO7fPgvNbbiFE7M+akrDnOshVWmM3qIrq4OMdHewEg3d3dJcJMs77yHoWDQNwPTKxuVpB9i5RD126qgSfGwNwytXIdD66/eRoCxijq/eZAJtjPj0H+Vr5EMIhq+LRtcLj9LxB6rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(966005)(4744005)(478600001)(6486002)(5660300002)(66476007)(66946007)(2906002)(66556008)(38100700002)(8676002)(8936002)(7416002)(86362001)(6506007)(186003)(6666004)(9686003)(6512007)(26005)(54906003)(53546011)(41300700001)(4326008)(316002)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eN0Ng59aZ2GzaUDJ9+PTBzxLAJT1ZrpyKbhg+IXXcCsh+dKcTHXxi+A3nq49?=
 =?us-ascii?Q?N1VXADtJd+Ea9QOEgeHTmXCykC96aOFxMBwssQqM4ur33rIbMSUrgSpF09rO?=
 =?us-ascii?Q?3xHFuVI4Ozvq2lc9S8FhLHShxuNwV55yF4DwWy/WjJEZzs551LmV0djgslv8?=
 =?us-ascii?Q?E2GIWyeABOhvfxqeQCyPppqToWAGtHyT5LeUKtDaDx7o6gu+pRi3DJdJX1rz?=
 =?us-ascii?Q?HbyWdojBX2EhPHIi2DIkgW0OTMFjnqB8Y9XQmzoLhD+EXjEGMB34YRserelN?=
 =?us-ascii?Q?pQA0629rVFaxVbf+A/jIwStnbvAWvR7+A1r41eXoqN/BFpZLitsEC5bpgnVs?=
 =?us-ascii?Q?+R724XqXq8eVEcEONZMpqPhex2QikFFvbjmmAXT35F7+p+UsSBQqOCWn6LO+?=
 =?us-ascii?Q?zvwWYKAomXkU3AcQiJBKAza6iacK5B+xZV1ASuypMe/ez5+RK7VHUws6FkGy?=
 =?us-ascii?Q?ZriAo6NxrL104rRJ3uc+WAKua9VIvdofrk8AX4FjfY2w7bTlnLBPH9+//W0v?=
 =?us-ascii?Q?6ehAE5MtUpu8oRD0tg5ezsx/d/sHQzQmapfUTDhva+m8KxZ3ZAPUwMxbTayF?=
 =?us-ascii?Q?pKDdVtc9guGcusoCL4yPz4cFKv1RYbmSSDfqP6kMc/NiTjt7y73v/ILz9/1k?=
 =?us-ascii?Q?fxzuzg1GAwAwOjuBPPOkmo6R31tSnrkP2k53p32U7tf7hHVvcQiLCJsVfXXN?=
 =?us-ascii?Q?fBwM6AHwJvflNZ+UiNg0pkfKS5iVD2YtduA6C/xcmeFbpSilrKjB0TXyVjcv?=
 =?us-ascii?Q?H+QsB4iu6MeZ41LjJThSRj5T4l7K91K7qmtEBe3uivW/jIAzWqZeDFCWBbUL?=
 =?us-ascii?Q?tMs9rYgpdfnn3aC6q6K9rpwAegz65ujUZXkY3ulky4jvUBgHOQR0rlnoaR0f?=
 =?us-ascii?Q?fD4iOJo5CnyaXUrm4j5JUPW8K98YpYmPT+S3W60837nKlbKkZeAZKejhZZ0n?=
 =?us-ascii?Q?GJ0oinZpMKidRQccEB1lsFOWxnKa3YXQE/nYDAPh/f6UBXkvjuk4FcEPSH/4?=
 =?us-ascii?Q?RBGVBsc3t60KJfb04uqL5OJAII6/qNmxMr3JZeRQ/HVwZXuHRORmkl0+hOvO?=
 =?us-ascii?Q?qoW8Tvxe1E/e73fbvqJeckt0+uPhpPPXX6HQ6vSQTFmqjzXBtatpJeBdIIfp?=
 =?us-ascii?Q?ppH8DAx5oMfXnLUeJ6L2b+rJFUMHlCnba9hPo6yYTqoiKzBvXCItsnfIx+kX?=
 =?us-ascii?Q?MFPEDVVHPGPksQegAth7aLuKUsZhQ6iVzzHjVNLbt/HwjRTF4McRSDSRnA3v?=
 =?us-ascii?Q?unEaEXWsYlwRx0a5fsN+0Wyy1vJuLOMFFBStT/k4hOPfdEYzm2n7WbSylt8g?=
 =?us-ascii?Q?QzbRYqyPJJMStXaL3eOJ4ZAjdlnF/cIOxaedYkTs7rFRs+oWEoH1QUH8CxGl?=
 =?us-ascii?Q?AgFDAgMJuuq6rB7o35nrZhxO4xVPNgDGhrMT2nPq0H52RV/YxmF5STwjnSYu?=
 =?us-ascii?Q?vxp1muYYp+/rhVqTjgTRuI668JzEW3deKKKLtNqpKSd0WWPCRHJNUGmA3lLG?=
 =?us-ascii?Q?t7o/pKJh+VDSCPgJgRzPaSKsUt0O9BtgxOB2gBQrSXbSMAaZvrVscpRjbzh2?=
 =?us-ascii?Q?tfXNJJH9KSbqOo+E+/rfwOZowUC8Msi+fP1HpftT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9b58ec-ba4d-4982-e102-08da7e82dac6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 05:56:10.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWEoZHmhp++SIqYT2R81jy67HgQ2YCyjv4JAQuGeNNtnSpUoh4Wh22xrcv2qrStt81cqFUTV41P5qYHe/KJ2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Aug 12, 2022 at 11:02:42AM -0700, John Hubbard wrote:
>> On 8/12/22 05:57, Matthew Wilcox wrote:
>> > On Fri, Aug 12, 2022 at 12:13:08PM +1000, Alistair Popple wrote:
>> > > +			get_page(&folio->page);
>> > > +			unpin_user_page(&folio->page);
>> >
>> > https://lore.kernel.org/linux-mm/YvJddHPZsh7Lwzps@casper.infradead.org/
>>
>> The above fix shows up in patch 2/2. I noticed during review that
>> it was applied to a different patch than the one you replied to,
>> but figured it didn't matter which patch picked up this fix, since
>> the problem precedes either patch.
>
> Oh!  I didn't realise patch 2/2 changed the same lines.  let me go
> and read 2/2.

Oh, and I missed that your original comment was on patch 1/2 not 2/2.
Anyway let me know if you think I should move it to the first patch, I
don't mind either way.
