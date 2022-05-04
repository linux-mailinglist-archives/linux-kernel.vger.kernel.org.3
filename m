Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A2519E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349162AbiEDLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbiEDLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:55:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD6020BE5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5cERgxUu4pNn8DFLrZ04/8i025P4E54CF9LrOMZnPv8dccpocQ/jSsgQqxyRYohTCaG8ne8kPLlmX2zaaACmHoxWVhuuw8sFC/SABXqQPcYPUmHr8/TRQ16T3FHAn34jDbPzhTQoA/zoJWOz7rwjM5G6zfdy1Yupz3tt8ri63wHIt1mfBaXqqjSNUnsuR9mQIXjE8aBQG0xC71AguUQj/RoBqF62vtp//A5HdP+hm71Sn9/NcsC5WApG7Lf6vvKDudM6/VAIKfXrdG1mtpu9ZlT8CiG81gt1kSQw+N2U1DzBc4t/gEcRkku1DM2r2Z+10l3nRq6l7XprMzcD8NVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXaS8Ee5huh3UfpiuUuapEfXpAm+qgtY0aX5QpNL2VE=;
 b=QcE2Ka2QhuON3Zb8Aw06+vZ2ZfRhT7/35jcSZHhYNr1V9/gV8ymu+p3izkT06JQUhLQzMu3u6CF0CUACtxZk92rGclLPNFipHU/LoInkSsYt57ftVOJjDgNMTvpJluPebvWawYqwUvu/tGYR+Cg/VDqHAHQ23JwVXDlLydntSaT1WyWfOx/d8Gubd2OMaDLM9C0HjLSYNMCHuFyex9aNg+z8PaLQP1Dw7h+TNVVvDEJ7GVDw/5PkRZ4p2pbRO3IBxOSuqtzo/aXPCNP4zgv/ZXdyQxNp+APyDDaulAyZXoeL8kkrySLRsGduMnU2c80+MeRntc/trDArUs0XP/AsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXaS8Ee5huh3UfpiuUuapEfXpAm+qgtY0aX5QpNL2VE=;
 b=gThCmLiOjZU6rUlcuVBNTSGBsHF1AIOjBCybrlrZ5l7o5NYGJzy3aQVWAX/niW72sCLBVyWsZxQWSumLPuuE3isfS8YPmSu/l/uFvaoxxLwWpFR2h6PpIdKVLsPZ7tE0plTrJa8xaYAvSiNMC68AuomWNgnsVm8fQXmibCHqRJiG0uInM10Z7D2Gorypdkrsadnh2i1kUq9FFYAyn1GqB4OQPV7PGRqHel0ja6V+orRZCJYAO+/dVPyeNxwo5Bx9eBTEXUjAgk7R6JB68fWqJ/mg01bU0PAwEWHVCyVj0ja9tzBUpVAv4DqWZJyrkQAPMzgRwHolUH/zAtdPI9FWTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 11:51:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 11:51:36 +0000
Date:   Wed, 4 May 2022 08:51:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220504115135.GA49344@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
 <YnI8Xy54M3XQpS0T@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnI8Xy54M3XQpS0T@8bytes.org>
X-ClientProxiedBy: MN2PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:208:237::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9372ac6b-60b3-4b32-86a5-08da2dc4711b
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB64291DD059D0AA3FA3D6C91EC2C39@CY5PR12MB6429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlPES/34+uFjVMcwiOeBHwROOfi7UTB4VI9oW8rOLt2wmD3h+UdxIG6rU1jojvpXVR3tKD8Z7ekvVCoMk309R5hzWVUKGfDGoDMVwVOVzgIc/l0L9VMoTnrp7PCgoveaE8SIIewHYkkO1rKBwK4s5VhUgGfdcQNRqLVOWYex3siti6DU59YN/9Z6doowsmmgPzjewGef0knmXo+HwCGZtM9x20QhLT/O/cMRs66CsAkuNhWSrZSmeVdFDrp4HvpIEzei3HQpKn+5epkp736KjmmMv/LEIJYPfbD3LEQwyW7d1yYaN6KGgvkBae3mRy7m3UwC9SozXYc0F+v65nMrwoDiZYF5bdgv0B4P1OBcZSuFUw8Qjp5NyaPk14g6d/MHp8GYecrVyVs40ySVGMR/ikM+/gvY3CbGLFj02Zr4LQTTnpBRjc6ienO6Sni5o1jbAkTEe8sBdnIlR6ip7LTUSBTR5+tI5T7MYOH3ESLZKLyh20hgfWZqAhqRJxWtBSp1BTxucATjO4GMojwUxvFnuW0Q+a8J1kwG8fie7MA+L9xSonQs/HxCZh2eMg9lUvCQtfskLbIMieNWLzFbXKt4qtdyRGOsPQLFaoR+Z1u1/+k8nPs+EtQ7AZc4mQAIbOiu54MBtrOMaMmw5ea9z0Frtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(33656002)(36756003)(316002)(1076003)(83380400001)(8936002)(2616005)(186003)(4326008)(6916009)(6506007)(54906003)(6486002)(2906002)(4744005)(5660300002)(508600001)(66476007)(66556008)(66946007)(6512007)(26005)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkei3kZ8qN2IDM37OJsmotG3ccUta23fbQr8brA50SQuMRvmziDFYq+ugsl/?=
 =?us-ascii?Q?jTr5yOOb7VvAQ+5Vmw8nZTL+TuR2u+zALkE2RmDROvG0O1X6CUIwwXF5rWNt?=
 =?us-ascii?Q?LIym10B/q12eT1vi6RqHgBBNy30tYhrvajmE68BYGlXVUfqQYgNOnjLE1lP/?=
 =?us-ascii?Q?eHjkB90kDcha5Ye/N0HNr/P8aK6FVvUqni3avpF9A9gNuoVPI0fjs8IjThQa?=
 =?us-ascii?Q?Ro1ON8yeE4aqcphT5MiRK3OmeVTW2PZ4klbjbpf3jboMTCyYWtSeOzcu4Fj4?=
 =?us-ascii?Q?XuHWOS1/R0raf+0LKhvrteICMtIeh7jyrk1FnSoRX/aieXLYqvkS4gzl2J6Z?=
 =?us-ascii?Q?iYgzwa2kAvf1TRzVtf1lfYbYCN/kSc7stJtUAAUsYPaSqdVM7/vbJHRFxXej?=
 =?us-ascii?Q?Xa6AvPguELTN2RH5CDOUW9j9G1u0cDP09WQn84yXzBfZJWtSE2m3OuFUSkMn?=
 =?us-ascii?Q?/aI8f51Zd2DYzp2S5Bp9ICMd0o0+uTB8z3MugJRKPfBCHQ8Nf0XHtZxzpLsE?=
 =?us-ascii?Q?QconyfguOlmSy+rGR3+LwQlPACQHriIbelmxgd9oR0IPBylbSMosbT0sZ0FX?=
 =?us-ascii?Q?Pipw7V4pW86ZOiVU0hO/T7MO2zj2K8zo5vCIXzsS07D4K8H0CDgPgCM7C0k5?=
 =?us-ascii?Q?US88tAIZj+3hh40ReeM+l9ocMB1JTbUTl6ie7zYmhF7aNynUZVVqZMTp269l?=
 =?us-ascii?Q?ECkM+JSfQYWu+eXvCcD6++3JiozTrpVAryFJt11+VClvcQomglOalMsMrYc9?=
 =?us-ascii?Q?6zbvRxFJsAdHqnycIqL6pYntbGMgLiYesa4NzrG4fJD+8ZF8COdxZD79zSxD?=
 =?us-ascii?Q?UhxHAlWxzNksktyHdtIv2DLSYgEIgud/OfSRhoRoWZ9jdMyLFGQEs20Ekg1t?=
 =?us-ascii?Q?JfjJyExTORoUBdO6qsKmVAommexiLpVJhGm62yh/T3gJAi2R1RWtuFmcyM0f?=
 =?us-ascii?Q?qLvLUsXb1SaHSIyanrMRas8wSo4SUcWx0f7/kfCQ6Y/YUcbpi4aNp9NVvEqn?=
 =?us-ascii?Q?yA7sl6dJQYHMSK/pLFiOfEjIVdPZYajmugJ+lgWmf+InJ7Gg1X9u/jJsduqH?=
 =?us-ascii?Q?c4aQBVV+nBlBUWR0SOzVdP0ZbnI2ujnci7LZhm55dLV8sHGGZE9xGLug0QJp?=
 =?us-ascii?Q?VO7RAXnh8SRGFr1YKlPgbXrhgQMinQBR017WMO9cS236tlZ+ylYsgYr9Qmy3?=
 =?us-ascii?Q?V+kJnVR3D22kEezw1OeDyPk9EIWfpwszYVbPgSNFf39wgg6+XFoHOVoYZbDJ?=
 =?us-ascii?Q?lSee/jSeCq0W5zlseyp5lw+byH2GrRmi22CyZofUphrkKFAV+nD0b1CJxZy/?=
 =?us-ascii?Q?fr4oJvWwNGvYnTVIPcFW4DVpQtJU/s511Yy6hSUyHzC7fjTYmKVf1c3om10i?=
 =?us-ascii?Q?Ded8cOR0HYJaxdXbeJVVg29YpH5W7gv2GQ3xc5tupdRIZlJ5gJvnNdCt0JjS?=
 =?us-ascii?Q?PiYmpoZYaQ4Fxf1MxO/uBrCvq6n3+Ne97ngasZIq5/dFZh1DujrKVcUu3Z6u?=
 =?us-ascii?Q?hfEP0hvN1qhLq1fLmEJxi5kCM89pkyz8CH26QNaKdG9iDC2vYnMzl42OLX7L?=
 =?us-ascii?Q?QiNEwpigF3Mpqh39kY4+g/Ad19iyZZW6Tm+s/1VOxER9wmvyIDjIoBh7OQ0z?=
 =?us-ascii?Q?1rU2RNY72Equez86jpnxPaJn2tpR9kGVEh3EbeiexqwrfV4k4ywfnbY6iW6D?=
 =?us-ascii?Q?xCtRQ6GKHwbzqo4fgetovEal0oiVn2gxiKhHNJE7r5A6axSNrh7dUebKt9RG?=
 =?us-ascii?Q?a8jnZ78DHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9372ac6b-60b3-4b32-86a5-08da2dc4711b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 11:51:36.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dqofnBuEb0037Wja4QUboUy1/F2LCg560pI5DtzjvnFG0K7QMw3kTmPRxMD4IO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:42:07AM +0200, Joerg Roedel wrote:
> On Mon, May 02, 2022 at 12:12:04PM -0400, Qian Cai wrote:
> > Reverting this series fixed an user-after-free while doing SR-IOV.
> > 
> >  BUG: KASAN: use-after-free in __lock_acquire
>
> Hrm, okay. I am going exclude this series from my next branch for now
> until this has been sorted out.

This is going to blow up everything going on in vfio right now, let's
not do something so drastic please.

There is already a patch to fix it, lets wait for it to get sorted
out.

Nicolin and Eric have been testing with this series on ARM for a long
time now, it is not like it is completely broken.

Thanks,
Jason
