Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381355979C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiHQWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiHQWuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:50:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C64A220E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBdCtqjU4NJ9me+DilKEgGSsMLICcqXb9lwMV0BrRER+Z5aZZvhr1XAXwlOfz1dWH/3WN0ywlOgkGFBjBRWzLi/r8qt4xnm9SNI19wVDOX85/9z6cZ64zayAplJ9V3/vN+3D2qetF5SCpH1Y6eV79VOrKk3soHlBS/UXGPPFPBHDOxfLNEr4Y/1IR/TKj9f+O5ADczokqbB6DI6FgIThskaqXn+to7qkMjdGWT1P1NKDRsw6VcsGCVgHRZX48R0RoSshfLqI5vAIxSRn2nMK/4+mV65r/o/MnySYMyS88wdDeKQZh9sFS8RhcSuKg/Awnvq9qVbTw3ZHV+g6jPP+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/CtIoNig97YsR4/teW4tjCmi6HIEPwB5xYMshscy6c=;
 b=ALk3vUmPErhiVwKJLyTBogH+n1IQuVxFshW0S8Po2OEkLbFe4I1BGqmE+UsecmfAFODToGCCAS3pgjY7OVlnNFu/FxJxy6S/q3n3rxny1UJD93PDwQDHWhHQUrUynmhz7juE0Mjgh1vqjoYJcqtdMAg1j0Jci3T7D3/mb6H9lpBTUBEbWm7vDxGHIU4feSAZmRMEQeIIGEVk7Rj3rxppQyA53+tmCfhXU0HChXiWp2l4MmtGzJTAxIH4FzhoIIJwxGzslrUYtfTSWyxzNj2fG37/2Mct4wCgbRNYxLTrV1qYuzFGd6SjwhvtdvIqPIMPPayhOXwnECfdhS5Nws+cDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/CtIoNig97YsR4/teW4tjCmi6HIEPwB5xYMshscy6c=;
 b=nuGoviNF5wUkTaQdFgYxpfR0bCkftGxUaSZ6x9yJhWNjNqlU9NJIi9EcEz82rU/kKQCz1Q0UI3mP28psfXnxuYUpqc7qlLv77CiTAurbsbKXQz8TEPkbtAjkKxSQiRDpMx4GSg/dMOEqA4pvvVAcOn0UWD4Ips4WRFudbBLk4BOjthzN0vLe7ZGALjmwid9z7eUR1yHnpNAPBR5AjfK3zPq4Q4Nvyfhe6T3ugBWUBJ0VwFwqHhzQJheNbmx3c1jlKneCkby+KJVprEy7K/v1GgOtt/ECnu25On/J7PdCULWvVAyKgwo37HTz9wBGmhUxE5WcTfl5fCIrqjYj3TsS0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 22:50:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 22:50:07 +0000
Date:   Wed, 17 Aug 2022 19:50:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
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
Message-ID: <Yv1wntznpzSXuTYh@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com>
 <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com>
 <87wnb7tycb.fsf@nvdebian.thelocal>
 <YvzaXeRox/9fqfdW@nvidia.com>
 <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:208:32e::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b9fca3-a9d6-45a7-1951-08da80a2d4c0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy/V/dEosrNeMG7cLfO6oXiEcJenDtXUoQMwElMMDwkQ16RjJ8oz3e2ctuOUrhgNyZiyFqrkKPuS/7566jRb14Mi9Be4IeeTWwZF1Ax8y+oLmfiFOg0s5P/akdEsMn3OpUN2Wdvjlg0H5CxE1TJfclg3djbBIkEhLK7mzBompOHp8xmhRStq1XfHMguMk6TuVTYZrkpAvyF7dm5snhMJYTDJKMlGFGJE44R96QKRRbC8zXFCVgwG+6kDvPNww9GJ2gNcca8Ko56wH/a4FK5YyEnTZqHHw2J5EiWLa/5yPu8QlGDpOYte/EjXFwbJwqqCeJ7jVpVrCvDT4SVnEAMxOpibwfB5XgxkHmmkpSB2BOZ7/8sQ7gm9ntAc5fxEWryMRMzzstubre24z/xWKT26f1qVNs1g8ZIz/HAKBR0QFekpzx3MiPGGBMPP1vSdSxsAt/I6nKaXTALbEXlt1pT3NaXh8i2HL09AWvoRHkSzqiHhdCsaeilcRW8dIqoo6pLm27GIObo8rP8dRXqHYUlZMDBNvUYT9za/hAket83K+fxPxLJKdg3t2W/24gl3B2HCJfV3mz9xOPDg/tYYWvxP4wMa3oRGzULlGbz7jm96xYjFN4IAMSuaAgb4alkG2Vvo01MJ0CQN0O4RDAPVgnm5eR9sczXUVmIpKAbDZDVhEKdbCo2qh83iNbfmIZmtmA8lrWWobxl/w9A4QygG9yZhqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(36756003)(6512007)(26005)(6506007)(38100700002)(41300700001)(7416002)(6862004)(5660300002)(4744005)(2906002)(8936002)(66476007)(4326008)(6486002)(186003)(66556008)(66946007)(478600001)(86362001)(8676002)(2616005)(6636002)(316002)(54906003)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E9S1Rky5MLTgQiBaXC23FKNjPxTsPLEcNsqqqmBNSonP36NFsIBG79rXX8d1?=
 =?us-ascii?Q?uPeb0ljy4VF294wsXZh9vLOeCUD1Yw+HnJbv+mZ7B7Ny6F+vvGySXFKXZ4lo?=
 =?us-ascii?Q?DKukLLNxdOeqDmQNdGPcLBDXBO3NhB71BhjCppBnMs9yQ4GvEov4WQROmmj9?=
 =?us-ascii?Q?2q91cA3wW3p9trOEaAWCEdjlkJsNHhxaCE3Md1fUx4V8lDlukSTe6OcslUcv?=
 =?us-ascii?Q?BJJP+sohU7mp+y2FYJaCJ5SMyMjLeoAQv5sPXdhqgOLZoUxI8DttIxVseGVY?=
 =?us-ascii?Q?lTikUwa7bD1f2jlrkanegKZZ1kFsb/LbjoIDOub338B4H17/m8gmnoGqtE5s?=
 =?us-ascii?Q?jSojck2ouujNBMjAw5BISZd5rWP2Pb1xITrZ9zwEwBBmBEvwKTyOzM+pZ6C1?=
 =?us-ascii?Q?f8R3jqDPxT7rIanzFX21Rmg49fmctpgqtmZNO+y5sbZ4QNrq4zJGjppmAf0m?=
 =?us-ascii?Q?m6xB3XOHEs9PLo95WVWp4p2q6OuqfASIbhNnxgan31n3dQgbMcErl91Zd9SU?=
 =?us-ascii?Q?+Lt7L729Cx+E54oXPNdkdXXrKOSPVg9AlkozKk3gIMtFHSqLPVQ/Vk+B3Hdy?=
 =?us-ascii?Q?3cXWk3tcGpSZMtoU6ZKFuwHfZayAHfC6nal/9jiMLPwMyugd0UW5mFMXAyd/?=
 =?us-ascii?Q?XziL7HnB4smnsPV9oxAZ6fku48DpY2iJnJK7xaqTC9GieXer0x0LtKIA15Ww?=
 =?us-ascii?Q?shHolI22LeiFOcilLfGKuLFr7efF8lXXvenugwAMNthObYK1UscWSyRxOZSS?=
 =?us-ascii?Q?wSp1UF3xCHdLy0Rbq2JN46zhWVDVWreT1zIpZEXExh8HTWfdyZaNe/B2rfvQ?=
 =?us-ascii?Q?9AUIAhx31N+LbbqrdzB/+R30RUGKwFLOKZ1PiDD39ASwaeVwcOdprMhEWedf?=
 =?us-ascii?Q?Qg4k+1Zg2XVF6SQCwkOm/jIpoxrtx5R6iMktw2wlrWxG7USQivQUU+MJvnPe?=
 =?us-ascii?Q?UYRDl22vS87/Pma5DqfUnaafjrzBkqyUQokFWfQ7VeiahyThI8kcZLCI++I+?=
 =?us-ascii?Q?1gh4bE8m6cQSr3WfCfF1pzCNFoUYiypnvxKkUe1ZBoPYs4/yLxEsFylYBK/4?=
 =?us-ascii?Q?+zzgyqY0Q3zIC0GZfwmyzkoxZbapJcCRG7BEOwjDMbjmQ1RZFHEY1aeP0JnR?=
 =?us-ascii?Q?1FRlOOan3YXBtwegtlSKZdwZSwWdpCeXW24GPpn2Dk7w2CTrkDSve2eseJvk?=
 =?us-ascii?Q?tavxmPLkHwBrrSTwKAq3whoZXHokyOqzlnwW1fbzae7GIc552V5fJs9JYMxR?=
 =?us-ascii?Q?lZ1MOa4O1mr5iHK6uUNAtedIOBVx9A3xtfYZy8oppnQ/ujTYM6r8gYY/dD/w?=
 =?us-ascii?Q?IFZzVzb7scXJGNut6fcaEbPQAP7Ka2XSG021dU+djj55KSrzEvrDD/auiyyv?=
 =?us-ascii?Q?7yW2z0cxkTHP1ZsNx00ElAtbKVfZwq9jZsssVyI5K/iQd69q0d8ICxH91irH?=
 =?us-ascii?Q?1XYWhf9jdvXec62INJOyW6uxsqSQBZCInQbvpD61pUdZcAaEBSr3YmRSeJqo?=
 =?us-ascii?Q?CHULB0oqmsHl03dhSZXOmh1JH0IA57PCY0g0SSKEOELtZo/WUVXxSJ8Tb/zT?=
 =?us-ascii?Q?PhI0PFR7RsB0ZzyBBsutTohidpeUY9LYtuWQqeC/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b9fca3-a9d6-45a7-1951-08da80a2d4c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 22:50:07.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvxzPLGjxVk5GEVNFy8SspjuSfxtL2Kq5h6rdc0mPRC8tdZq50PZqQ4Pxo7RxQrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3041
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

On Wed, Aug 17, 2022 at 01:35:12PM -0700, John Hubbard wrote:
> How's this look to you:
> 
> 	collected = collect_longterm_unpinnable_pages(&movable_page_list,
> 						      nr_pages, pages);
> 	if (collected == 0)
> 		return 0;
> 
> 	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
> 						pages);
> 
> 	/* If we got here, we have some unpinnable pages... */
> 
> 	if (ret == 0) {
> 		/*
> 		 * ...and we successfully migrated those pages. Which means that
> 		 * the caller should retry the operation now.
> 		 */
> 		ret = -EAGAIN;

return -EAGAIN

> 	}
> 
> 	return ret;

But why return 0 from the helper function in the first place?

Jason
