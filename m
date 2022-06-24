Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB20558CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiFXBeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiFXBeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:34:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4003522C5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOypKYeYW7CkIwvtuK28hom0wrYWTinLIOtL+LDcTQ9A3M28CoOIlirfaupBwUcasr09m7Us6jaGmESOM5Dx562j703UVLFm441Zs/DQIBmt1AcVaeYZDjwIlLc05EQbJht+xwDEZYZC06xwGPNIN7Ig64SEpaeo3uCxciCbagL3gxYGOI6a5vJL9ePKBSh0UUQsaz/vg7rnyvwicgh9orlgR2CMCZlEHh+zjN921RAFkr8qvr0YNsOFNDWuQHzaoX6d4cc4/D7lxVOGYXCBePjPX3poCQqP9NFlm55FNlRe7RSXRHhet2rwCYoskpiBoQNvrkvQ+ovwu+qVnOD3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQvjLQZlZE49rhRlSeTF38QvkRNdPCgkTs8ISJcj4GA=;
 b=CfurhVsHfusiPamKRw8eDbfQAtGcRBWh0rxgxjfglSuDtYWP0/okIFBLw/lBT71AQLq+cBwv+zLOOY8LMR3ApZcI8ydAJgHplVcfY9n+t5O4vQvYkeFvavMB2bUo4eBifJMeI6Lwu54Rf3fZqzTdcaIm/RCU0sr2K/Cw84/dw8ZzCDE2H5i100E9pMPxGRyn7Hd5VsAJhh+FNJgdE5jYJncOL03jYpDpae/9iyUa8c4pkliyKCPBHO7gNxf3hQDUEundYuNfFbVfDrdCMkNrWCS2IbWt+NDIBq0N/ywUW18HKaNlJBNEGfq0VTOGuweNXHDZr+2gsFzmlpO0QYSAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQvjLQZlZE49rhRlSeTF38QvkRNdPCgkTs8ISJcj4GA=;
 b=cBK1z+hMTZ7ncTscX67Cj6Z67GuuQw6U+fNZ7En2YlVwUIIwZCqAzp1w0Bl2cBcdFn/+QyNzCSo7A47CEkLM4SVB6/p8yjRV+Uxuxu+/GuyuHZ80R3xu3hLJWaTFaAQm/Qqm+WVyV+atUFF+BX2sJ27H3nYCX57w2xe9mPXcDUvk68nkx4133J+AYnXkFV5N296Itj8YpwY4L6yp6Aod/QW9aVpvfAA37CgzXPZuYuWPuh2xUjeHsDP0Z5N0ZQ91a/qlwhINuf3wEi5ypJbrGX8cPijfKr1TZR0jyMgEGn5vImdm3wun+cUBU8p6DBmC52P7jYpuG3moS7HNLnEvvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1838.namprd12.prod.outlook.com (2603:10b6:300:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Fri, 24 Jun
 2022 01:34:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 01:34:16 +0000
Date:   Thu, 23 Jun 2022 22:34:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Message-ID: <20220624013415.GI4147@nvidia.com>
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com>
 <87a6a2zyxk.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6a2zyxk.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BL0PR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:207:3d::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d60226c-bec7-46a4-a28a-08da5581a6f7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1838:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsgpvBcsZqpffaWKMNx4289NM4KLNN9q4NW3oCnGZ3b+s91wGTLgbhjATSd5jcH2UYRC6Fex7DNivEQcWlFwMTDbYanQ4lLAc7jbUGmn6yvRSzhx0zClFREdxTUTUW0r1BvVkEkPy4gAh3wOuvlBlJ5UnJv4o4wh8xLw6/qC+FL+cIC7ugcCVCfFPhwZJ1MhoEUn+74DMyXL+HthnnffXunScKKsIrPLALNddpM04BRKwDKx0+KTwt3VYDqrexP0xYmexxSQ7m3bNm4cMQNCSKLzd9BG2uxbcjX5ise9GZ98TzX+IUWeBz/SN+fjGsgcJCu1vFC1Fd10TqPoGAgUpkff6DB086tVPHYvNx72/amGXIKDmXJSDJdqIC3TX79yOhBBEWjrEb7nKEZctb+TWG9MwnSC/wOhmbTSEABek/rptzWv90siQddDlo7jiR21FTkMmqoT8HMAD9d/PkG6y0yOwWNAJR5wCzJ+zB+t9VjLV/6txGJ82ClaUtGCQyX360bl4sG8xB0plvCWvGPw0qRZiojoDZVhAk7pqRvGXXV1xlv5nURnwvz6m1NEW1XL+I45ctwWVyY59tyI171YdvFHDw/9xrIKaBdr6pcD8SjKuci9l775A1h/F3ap5iMqQd4x5kwL3OJDvofegjdlSzv3130IvExeIAcQypDztEtIOY8NbJUjAVFp9Gx1slBc0xoDs5uFM/2jQEuWI/3WAl5NEJfEVl+s8EbEbTEvVLZZucS85gfuyV0R4kA/sMRt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(66946007)(8936002)(37006003)(41300700001)(2906002)(66476007)(6862004)(5660300002)(66556008)(1076003)(316002)(6636002)(4326008)(86362001)(8676002)(478600001)(186003)(6486002)(26005)(33656002)(2616005)(6512007)(6506007)(38100700002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0VLbJLJBWRrSleQocwc34XUIKDf9/hIBMmu6t0TlG9J+JPIndc9W46bCFCXd?=
 =?us-ascii?Q?Y8oMLHwu1qlLVMHxLz+p7vW5q0cd/9NaPGa+vD3deF+1Bz5711vCVd60sajh?=
 =?us-ascii?Q?+UeUm3mCfdcdJmPeajMH4fqtGAIa+o9KxoErwVqDVm/N5rWxkduYTZLzuhSA?=
 =?us-ascii?Q?1/22ZqYQqRLihN1zzMPNugrVB2zfrDUN75RMn/TbVDSlb8SCqLGNHJauQ8fh?=
 =?us-ascii?Q?Wreivve9ZyHusVXyjz+DfQJsGuRX5PCJQ2wrGixCvbZHvhzrhq5w/tmh63sT?=
 =?us-ascii?Q?O2RHMmgCxkXGR+Bfa7mGgMewqsQkqHlbfnpS4zHmJWaRERHRzRWmL4n8ZjMP?=
 =?us-ascii?Q?oVqAPcJlezk51THa5kjfxgbgMs215UagjtZMXRkuvraRKj3jUpskLac5G5aa?=
 =?us-ascii?Q?/EELWxFDo/cpfRmQxk8EV1E8+YI072ROwUCplVK7tveN7Yqpprd9j3xNKZAS?=
 =?us-ascii?Q?fCPXr0ijl11qxlSuWfzokfKQvo3X/2Yd9+6V7Z19xtANW2pg/2sNaa+wxlv+?=
 =?us-ascii?Q?E6fJM8AYT8P2oE0YcdE/SefngxBpBLitvSZkTM+mOXPBw1A/p+lKQlZIhpBU?=
 =?us-ascii?Q?gt7VPLW5addMs96dhVV2v2IEfDfcDiU20WEQvWKBEPb0rSMELizv5eYAQ2Eq?=
 =?us-ascii?Q?Y5b4beRNalZVBa1YYNk74Hp9julf4tDk5KV3P42E00gpMJOih6ZwDqF812Ne?=
 =?us-ascii?Q?mKg1gEE/TkIgMiR0pyEw1B8vvDVtyxDRagS+0DvSofb3B+jzpy0TdLRl4o4F?=
 =?us-ascii?Q?0a/Rv/eA0RiXRWUSGzl7IGTTtvQ3a35RsuoGRsaSigKqKNTH1/Emd+Hr2T7Y?=
 =?us-ascii?Q?rCXzSHH3u/e7Q0arVhUvMsUYALlTs+H8peB/RJFOsEKrNc+6WLsJZTzzlkML?=
 =?us-ascii?Q?YMXoT2q6t+Lqs8g0NltKr6DrPdI5tVV7BpO4MJyZ+uFmMN6B4x5zGl8srFuO?=
 =?us-ascii?Q?/t8FimzsPPz+55qzX4s6cSCBPOyxB57IFvjGGnjU0DWm6yceHOwfnS2UxEGn?=
 =?us-ascii?Q?7uy2mClVrJuRdbJZS1FgO3OWscE6bJIHw0gPV5yL1Bx5wyWxBaoCqzYtWvj9?=
 =?us-ascii?Q?8tjHrBaJehY5RHVChFDkzwl+eSobrK8hSgCR4g+F5f6VYzlJrqshb2X6gi1v?=
 =?us-ascii?Q?Csf2hRRVzmxF6NIHPTzL5zpkP3QNIqn5Pzj1mDKx5JtdAn2Vu/85f9RV0Ty8?=
 =?us-ascii?Q?56dPDRXR2JFsOA3HTSIn4AdifljZQ2+EgCUyap3CvxBxIlFJey0SeWnBEaPD?=
 =?us-ascii?Q?3UPzlZsFvCqVM6Mhi6nB/QeCMcmxS2nmWQ1hSCrSVdILY5wCn8M7HzvX1Hwn?=
 =?us-ascii?Q?CRtlcC2Cag0CTEnDoNyozY28Sa1RKkhnsHxp05LL2Y4LoiGIqnqKlb7b4pOj?=
 =?us-ascii?Q?oUNVPIgQeZJDZZwXXAWZXTa8m7Tm/EdPfrDKxMpWBym5M+HLZNcMBqYxLAw4?=
 =?us-ascii?Q?vJmIkYIczfJL6kvT1GzMNrBIR0/snlYvrv+E2sKv2DHQvv0TlpOPu7Z+3SzG?=
 =?us-ascii?Q?lr5qavtL+EIwaDMOUGJ5eSV93W3IH+jLCr7cjeqx26SEKNfpPLPzEZzPvhGi?=
 =?us-ascii?Q?hAP2YlFfBgJUlQgG5i880BNZEGwoe1PvOl/MHbJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d60226c-bec7-46a4-a28a-08da5581a6f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 01:34:16.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spN4c48aP7zTKrLFHnwtsL22t4GZ5qTDICcnfRqLoM6liPvC9oJwifyU0EYozy8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1838
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:11:01AM +1000, Alistair Popple wrote:

> > Hum.. Alistair, maybe you should look at this as well, I'm struggling
> > alot to understand how it is safe to drop the reference on the page
> > but hold a pointer to it on the movable_page_list - sure it was
> > isolated - but why does that mean it won't be concurrently unmapped
> > and freed?
> 
> folio_isolate_lru() takes a reference on the page so you're safe from it
> being freed. If it gets unmapped it will be freed when the matching
> putback_movable_pages() is called.

Hm, I guess I didn't dig deep enough into that call chain..

> > Anyhow, it looks like the problem is the tortured logic in this
> > function, what do you think about this:
> 
> At a glance it seems reasonable, although I fear it might conflict with
> my changes for device coherent migration. Agree the whole
> check_and_migrate_movable_pages() logic is pretty tortured though, and I
> don't think I'm making it better so would be happy to try cleaning it up
> futher once the device coherent changes are in.

OK, can I leave this patch with you then? I have no way to test it..

Thanks,
Jason
