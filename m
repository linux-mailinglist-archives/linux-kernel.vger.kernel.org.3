Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229234A8461
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350678AbiBCNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:01:41 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:23777
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236030AbiBCNBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1JdfwX0tG5TForll+YXGAMpKTqvrt7kfoD4AwIEkD+mE0H+oqCJwwJmSpzShGhlybXKnYmeeTRHI0YCp0DIbkXmqrK0HzMOfYt/w5SdW2QxC1GbymkedZBPKMw3D1dV/UIx2JYtG1IFRwlNsZbreJ2D2PA87itKCHOB3GomX9OUv83ENxhOr/nZZ1GjJV+e/olZZCnTzm1CkPrpGZn9USBTemPFxAkByNjRio54ni6j73Ya/ger2YWyODCAg+eW+8mXMxY16dAKTTp0iORG73kDbtrQ4XgbxUYl9eoxbXafv+kcVBFIQhEgjsEmiAp5nAObKVEWKCRmL8mdk+HF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gIgtvzUZdD0p0FwgfMRi0yTcewzHVnSoqIKjziEG0s=;
 b=Mkr/4auNXvhX+QP5KC+0/UGEbxkPlvlVB8AMo+YSCFZdoFIhwagBvd9Ic+Q0x0nEYWuNBk1ivWm7uUBnWtq7FIV29ZilXLiN5iLO50e7RbYbv3ts3wd76Tbn8rBPy8W/XotzuKSStWs8RDK67RU1agdq6rNVGGcV/8MlwU+FUNEA6L4t2NgkW+f1q+HI9e8biSTFNlfaQW+UjnHY3g8VccsT7k+/yocTDcPGVxnYamJ2O2G8hvJQZlAzitwAP0zxo+NakYYKftH4yHOar5OCaBRxsUlTReMu+334yOJFORrw3a6m1hTGZFPYO2sa+RfWl9PDOMk6i7L21wyA2p4usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gIgtvzUZdD0p0FwgfMRi0yTcewzHVnSoqIKjziEG0s=;
 b=Q2AJuCnsp8HncfYDkElBLx6+fo5uLlQQzVzRNa0u5U36E3aAnpW5heaXE/579uznmSM2U4wNhW1vFPbytyid0jggnvVX746b3Bv+soQ42y86hK77539T/dCPrhmNYz0qdxuoDeTwr4+SKwJg1VPJxem53cAj/FRL81V9TcdT3H/ne6nnXmbostb6z8wBmCtC8ypOA3WKRCS0wec/oZtZ/sxtyCb5lxVeY0bgRtgBPZvle6fKJm8m4d1t+dtMqoVMoAFoscLbWIEJLW4TqETubw9rPj58TMlrJ0Zb3eIKRICOJhYVDtYjI118fvVQ6Dk30u7oyJ4hAJf4Bb0UXz0vrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:01:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:01:38 +0000
Date:   Thu, 3 Feb 2022 09:01:37 -0400
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
Message-ID: <20220203130137.GZ1786498@nvidia.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0245.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee1c8fc-29a6-4cf7-e3e5-08d9e71550af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37755496A20CC7975D372873C2289@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpjGoseHqm6bL7nwxdN+yEfcP/KvEDMG2voiMy9iycDmUGQNuHk4218DTDiGfZD2WDOp5OA4P1t693MrClaqsu5Lr9T2QhE/kLZtgEB13vPEQcj1tRZ/CPwF+mKrPR9+DTXLYR7311rZ5Q/PL2anp9m1SlGi5LJ4v+hXpzYJA1QM17fCyHcxmPzIWdainVVrCHSy881ULKLtMw9jz/3i5IuENyoYueVKgLfs1PEZFD5yTHwN38sjtKT7U0smzgCVaakArv/loJu8Ptuz2wQlPqf+UPfEWMFgfggQsuJjucmXt6ztpZugvq87/QKvqPR0Yfq7b69WBj+9yFJJPN1n/4aiu0M57VZW5yENy5YrYl4YIKIsYtd//16PfBw8iVQ16hmpTaVGbJZDYCsAQUWf/gpi0tIE5zU3COPXNl+VhlSiyD4Zzfan4Y7r4Wg4LvElWwTJZRXCF27JA9ORYZfVTg3Jm9LQu5Q6Xz+Wx2oq9WLaNKX60ypDvQdTweT+wevj1faxRDIomG0P1oeG6gF9KaeNW6pgQL4JJSV7bVEcqY7PInCDrTkBGvrzqpG1dXegmc80J/7Z7LSDaKq21R5PXouzbEXh8jTBx4jnLepg/VZ8qaKPRUj9nWn9izKOOYWSp7C+CfVOVUZgcOfQn17VBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6862004)(316002)(36756003)(2616005)(8936002)(83380400001)(186003)(6486002)(1076003)(26005)(4326008)(66946007)(6512007)(38100700002)(66476007)(66556008)(53546011)(33656002)(6506007)(2906002)(6636002)(37006003)(86362001)(54906003)(4744005)(7416002)(5660300002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFvQfYNAuPa1Ssf/vSu1qFj/cfZuWC2K14Nd6VljzOE1DREiFOEygQUiaM7R?=
 =?us-ascii?Q?uS9XJaJMAQJ2oH+VIkozFrG7QA6Clh4Pxy5SB/IH1kE+UD2082M5H7uKZ1kY?=
 =?us-ascii?Q?l6IsoZlUEYTftK3+O6ZjFddOPdfXQwfhkEwIBU3jZaHQVLHcdcjPClBLSNGv?=
 =?us-ascii?Q?xPossRD0n9hfJLvrSN8fsFUbytw1IrUkclBpQTHalfP4CQ0HhbNB4lw5Et2V?=
 =?us-ascii?Q?jin3GDWaByA+nOalKK5bQ3BaSFOn8NXKF86ggz1yswz7U2DXYD1UyaDhCSCk?=
 =?us-ascii?Q?2LMAzHGRrr59zzadYXgbe8bmqeqsBoP/TZ1vqN1Sj6xJh+7GiRELhLnK8I9B?=
 =?us-ascii?Q?h8g6VC8Nj94MepkA4mbvSHgX/g/76HF6T93N5AcGrvs+dK/CduKbr4nw0Xe9?=
 =?us-ascii?Q?ceKBs0wp01EoX2DX1GZtt6D0hvuFrz+a0ARHHe/c9XXBcMzOD6N3Y7p7x8H+?=
 =?us-ascii?Q?N/ly+UF3TASDAUxjcBuKR9tBZdsXsBsoAkCtBkJ/uD2+ydHolx4Tvg6YBOuf?=
 =?us-ascii?Q?vy6aFWZKcMCbx1K51rIuHTUtIV0hxLaueWpLviYSWKmCdK359BERhz1EdKzm?=
 =?us-ascii?Q?WNMliIcX8VwIPGifVMX/K6K3IGEVMANIE3FHMAO57oO+8rae0rR3jblIi8DI?=
 =?us-ascii?Q?vvG2OHJpfzCHP+EtPbDwjElvkPH7/oktGyMkdTBDXp37BY8Psi0w/6yg0/7p?=
 =?us-ascii?Q?oTbrCUCiZpeyUggJXQ/y6wZjVZcMnofmLg2aPm5rFSNlnMrEts+0/lvLOP+Q?=
 =?us-ascii?Q?atg45pAMQXr9u+KrKtabYr52A24F7Fk38ovhDrhYlWss3OyLqcdnPNpsBnEA?=
 =?us-ascii?Q?PvTPiiSGtm9pQJlvuefoUI2TkhEkWiPKdXukDdnIYI2FwgRzgQf3vSdqkmkp?=
 =?us-ascii?Q?7PNuu04ixCotPBS0QWXC634orqQzt/iY2mAhJy7ngu8J/liiAzQVsP8pHbLL?=
 =?us-ascii?Q?giMUladghw0Scy6SS5KsnhitbmD1v/xyZBq418hARW3TkS0cOY5V5IzfcWKT?=
 =?us-ascii?Q?FYVeFyWSRQPE+fsIfXTjuXql2wg9zhS/eDUJexeVIp4JDuQH3bs7TbWqBvYH?=
 =?us-ascii?Q?8tR/QgEUSTyx4osf6hCudVgKQQXZ6CDMHzg+gboV+5AuBxkmBQSbLS5Lf1nm?=
 =?us-ascii?Q?fWLU45r5c+ckGA6oSGgLxIdqhP5R/8MvVJ7NabiP7yorT6hiiRmcUTt6o7ig?=
 =?us-ascii?Q?+oPbPpYiX0Of9SueO2Iae0NGLSoSwWa+5zZ+4J4gwzc7soRoX2NuDAhMbDex?=
 =?us-ascii?Q?JHkjVqiDc9wZuEzE9uRKhReO925VjwSPLardUn9HPRgbB7y/0CP2a2LPIu16?=
 =?us-ascii?Q?vPlPUqsMfU7PkbopDXJucufhlhidnmlYBDIg/mjyRS23rQIv9cru3RpFYTk2?=
 =?us-ascii?Q?zHhf/pTTjEPPFgRQUC5eOaevgQEIEiEaScvjUvNQjvUIiu+4l0DPs+17FJwg?=
 =?us-ascii?Q?tIJ+dwNVU7476jcKRLO+rifngAllh7BQZ23a2v+Roh/LAXuqJ3uFxRnnPhbI?=
 =?us-ascii?Q?46y2duRX/BmGKnVS5TejQT6sa/e7N4XqUmSpZ67oD9ztectM7uvc0Hrhu+ur?=
 =?us-ascii?Q?95SAAAGpQSg5D6C98UM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee1c8fc-29a6-4cf7-e3e5-08d9e71550af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:01:38.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf9laW/eqtf5A2ERymuR2drngwifNwsCfgRJF+1G9S4goq78lUw5N4gvMJ/vYJKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:38:33AM -0800, John Hubbard wrote:
> On 2/2/22 22:27, Lukas Bulwahn wrote:
> > Dear John,
> > 
> > Your change "mm/gup: clean up follow_pfn_pte() slightly" (see Link),
> > visible in linux-next as commit 05fef840b5c6 ("mm/gup: clean up
> > follow_pfn_pte() slightly"), is somehow weird.
> 
> Well. That sounds like something to be avoided. :)
> 
> > 
> > In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
> > out. However, at the label out, the value of page is not used, but the
> > return uses the variables i and ret.
> 
> Yes, I think that the complaint is accurate. The intent of this code is
> to return either number of pages so far (i) or ret (which should be zero
> in this case), because we are just stopping early, rather than calling
> this an actual error.

IIRC GUP shouldn't return 0, it should return an error code, not zero.

Jason
