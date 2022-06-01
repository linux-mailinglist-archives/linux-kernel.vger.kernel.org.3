Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461253A515
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352487AbiFAMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiFAMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:33:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66F8FD6B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX7fSRpUpuZrCIFe2xifnlBHBE4jswS97ZR6E6cmyfuS23HC84P5jYSj5PWq21yMQqI87RgEo/ptYTUxBqn2WnIrQNIUisIoSvhoYglvQJrxBLS7f5vp5CXnE1fYPsUQfKY4p86PY6edJ8f7fZaXvqLoLCnsBqCLAzw/1lLUEJAoMSGzLhbfOXnm5La0pMFTBYUdMrKdIH6/FnS8jjVJKZs2+DydH61WeicyZJlNZTzYctR7F4mNBsRMy1DxLlGGXKM4mHTEHaGbC11AZFNf5zWbw86w6A3czc3NbSRB8mxOPMYZbfR6J1iVM8xbAjMatFSNn2RnqcWpTh0RDp9FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KlnR+Q4LobtH2FTCEkGMfeKjmJT6j/Xu0IO6U6czjM=;
 b=fUb+FNJ7HDc2EnKY8L7LHGSH0x+IoTO2x854VMWd6v+TKY/Grfh5xAqWYaKcggYDpFBgOmR9KhuluWjlbnhNrD6VDjLmHane9DYGhyxY98DmAyEpRwzq6Tw5C7TXLQVVrazBDlN4lI9pMnuMMUKkrlfi31My/Y6nWdHhE6NZkCM8yhnckIenuvkZl07WEpYvOQNKBoNpTZQ5a+/S485wfgvPuYBRPaccJb3x0El/WnKSQczCptqBU3wvRiKrsfzQtUg85CiRwCKOJhgpTd80vkXpXnk9fWAvczJ5ht2/Z6XSPtmwyDSPW9jdCut+zKjeZrl5ApAfxsTv2Wb2TteEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KlnR+Q4LobtH2FTCEkGMfeKjmJT6j/Xu0IO6U6czjM=;
 b=mqC8ntSIHir292Y+cQbhajtJZKLTElKcHbyNfuRVLhDSewjYGYY5jBsUqS4me2KWjIB4TsfaJU8cyQU3YNaNDX/yZtWaVQoBqCSmzePDjxBaQzIG7/0V/I/K0IYeMY5Oeqit6h7dgQsgNzNwnhyMEqD5lKiN79aR/AcQs/SXEOkJ3nfti4u7EhLg2T103i0sLDhqEh4r1cdiIPhz3MbabcYt6U5SPsUxWO8UH4s2k7aSliab0l/96rrD956uco9o4xVddhTFQcIqehR2WZL5T1531vyiJoKxsaWM1bzA6S3m7MLaakvATxe+mavhO6NQKprhwVRG7806uo1nQhtYqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 12:33:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 12:33:22 +0000
Date:   Wed, 1 Jun 2022 09:33:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220601123321.GQ1343366@nvidia.com>
References: <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
 <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
 <20220531231039.GO1343366@nvidia.com>
 <135e22b8-14cc-446f-98b6-9ee059236641@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135e22b8-14cc-446f-98b6-9ee059236641@oracle.com>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a604826-4722-4b3d-c52f-08da43caeab0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40321427F6332275C07908E0C2DF9@MN2PR12MB4032.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmHb3QVG6RglEy6Vx3BAXC4tZnCexUBjGtewOwms5UD4IeNBSvYkyN0QbbLjTtjg875VhVe2O25AydlauMIqDbRpIf+s0jtT1VmOY34LYtErYZTf59RnaBGwOSigrsF5Ms4lF988rc97Wg7aT4jNC82JQ/wCVZxzcLYTAwdC8zOZQyxNaUudYTsGmpydxXHpo/N40NsgYi72IgrAvQAKXfccVvURTz4GA+EBlga1q0ojdBEtSFwTB0EsTe0aFFysnlu470R8uXrlsg7V6WAjkXulm9gpxs2UMBO6SGT0fgteE+KwSqz5i/J9OqzGCN09NXZaZfSy2JdtUTDBpsDw0614FqfxnVyu3GVUsCQARFVw2V5xWABsZxlZgEXRAIu37lU/3Rs9/YxKROvlDkDXAcWGmGpVvcEFn6l+zyJfCGuUZcftBBVFGUGyL/IMzxiAqOREBCuWN3S8y02dkhy6Fc7xJP+KFqK9AHQZRVGoXG1XB9+1AQErXp7unkBYp62u+2aKiub/I4i3CljFMPWnKMtg+X01ugb3ZJaRXuUe1/zcEnCtEf3XhQFPU1kgm6cpWJrTFAyJ2wzjsfVsn7/K4bzCzkx5OqD7kFLP3NyhwVZ4bnw/un6QpqB+ttWJTHf7BJ2p7sy1H8VSXlUsMv7Gcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(54906003)(66476007)(66556008)(66946007)(36756003)(1076003)(2616005)(186003)(38100700002)(6506007)(8676002)(508600001)(4326008)(2906002)(83380400001)(316002)(6486002)(26005)(33656002)(7416002)(5660300002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W2xw5JTBO56xhU+/wjhYnycaoPsXXnq1wq8dH7gWjaouDjNDED/2TXIx8DaD?=
 =?us-ascii?Q?f8Qfs3jWd1o5E8F+ALoxQpM0ouTRzjMKrBzZ/c+hxqF+r91SDEOHyOHIrogj?=
 =?us-ascii?Q?p0CrEwEzBtzdlVkuEoScGE/lwAD4WiF9B8JuSgfOCxdIotOxzmsqogazVynG?=
 =?us-ascii?Q?0GY4yXs010IGQMXILv1XTE0bgP3VvBwXTw3NVWhjLcjjZ+NzDTM2JWClezGw?=
 =?us-ascii?Q?NkCAK6C4umAgw+LbA0KrmVJ9DXmz5qzxDy1Clu29NSyKSTHXjIeRQ5CS6EI9?=
 =?us-ascii?Q?YNQnvy16027jM4WmRU9LUVUSIUO+v9xm9diNe0krr26TdA4l1BPrlqi3sNZr?=
 =?us-ascii?Q?VMiCxFu6brjeVVekcsaRDpbDKXUdjpj5Ho8jnvdLwvVK/4PsDNXwQaLfe7go?=
 =?us-ascii?Q?L4+EU4gJXNl5KlnibC06lGTKVczxupabRR26eyiqZeyzqxtRQv3d89bj9pqf?=
 =?us-ascii?Q?s6vzG1bfDzJ0bKQkEpnyh4mN61lf5FwbiZ81uftdBaC6/n2zVlACOWVCwOTv?=
 =?us-ascii?Q?6+0Q0io4aiiA9aR17ySJhUE7yf5l7X2YoAVQdBg0+67EEhlRO0fJiEywiqOY?=
 =?us-ascii?Q?q+3fQVTkHSKf0HOugVVJxZWRlmYbEuPC05LWZE6JB/I91QGzylsQHrygjhOh?=
 =?us-ascii?Q?WqcQ+2/JdbRx0PTRLs6hzzQYOzuZSid+g10rxBf9OMjD+80krNW73e9vRbJ7?=
 =?us-ascii?Q?4H9cXEEJwvXTbld0dC6RiKnZ11F+WaIhORxlvkxyuLDgFtlRvBLAQU40ft2I?=
 =?us-ascii?Q?nVrq6A+JUKQZSBbiRnehoIWxIwMhvuggHbIMQUK5k9IzIBifNqWWBwVvUvUx?=
 =?us-ascii?Q?gyTpoBA9tPG10QAX06aQAFc7v/73K1eSKoonYgg60UDLny8obGMR+pyWAnUk?=
 =?us-ascii?Q?4bzgwFYtt8nX7koKU3+KQLosT/DmpgFhY9Nid9Znn7J6bYn1okJburyeZclg?=
 =?us-ascii?Q?H48UZ+d/FbnFlXvGPcm6rOTKmoQk3++lbuTwitMcADuC9jboUrODXONIbCqK?=
 =?us-ascii?Q?7QIG0+9CBKj/UdZ3skGOYie1nhEdNXXrkMePJUww58o/RYgcYhIRZElHG7Q9?=
 =?us-ascii?Q?yIUJ3PBt729ig4ceGIBh2/a+xwgDQfxDwGfJgiTQpSoSPODhA17XDKyTHmgK?=
 =?us-ascii?Q?qTy5kPu5y1R6CQu4Rbbl7e5HAYbsP9REbrADpWlq1igv9nrCRLk7NsVrJR2k?=
 =?us-ascii?Q?ld1ZmwMvVjD1jQKA4U/Y2MIDNGBxSjqt0JeC/+fNVnyy2epflNETvb3K1zfV?=
 =?us-ascii?Q?X3rpXYOsbUDtioGw3IlEB9Mj3eK+MeZCK+v/c0qCnulhGny+qc1AATVK2Y+A?=
 =?us-ascii?Q?mDBcZ3B2ujrutN4NFmYR3jyhDg1mEZBjOTCDtigkYZwurECoBIGg0tMzO8Os?=
 =?us-ascii?Q?sBCda7JnMRAo+k7m2TS/ZiLfdPnLZkCuYchOytF/8xRVionYckk6mIp92hUd?=
 =?us-ascii?Q?sUdy7D6Ss9I51NYRRyqnQpyGUKwTqAnqpJBlWzLsJyEDn2DIJlc2Y8CKEwOz?=
 =?us-ascii?Q?8m8oGP3MINioJ2zzS2msRdt5gLrMRzG4Cl8p2saH4A4S55t+8ZtaQJSsKbJV?=
 =?us-ascii?Q?8z/Z27CeUVP1/KWMnIyEVgxs2DzU1x6Q0FFqDn+IZqedKMj0FQA0dlYnLIU9?=
 =?us-ascii?Q?7G5TSNY571mHw2cfVWmKzoS+MFLT9UV4A9DZUavJryHWP2fSa1yvq10QpLfD?=
 =?us-ascii?Q?Sn2elJXHpfrD9jluRy32nzTvGKlWSZPpSA7OhY/4iMID0QtJ5BcLqhOoprzX?=
 =?us-ascii?Q?vCXGZ0hOQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a604826-4722-4b3d-c52f-08da43caeab0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 12:33:22.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9zYlCZ+cJcGQbah1uRWnbnWni/SNE0JkRihVQBabxu7tpyy1/k6yOWANN19VKHR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 01:18:52PM +0100, Joao Martins wrote:

> > So having safe racy reading in the kernel is probably best, and so RCU
> > would be good here too.
> 
> Reading dirties ought to be similar to map/unmap but slightly simpler as
> I supposedly don't need to care about the pte changing under the hood (or
> so I initially thought). I was wrestling at some point if test-and-clear
> was enough or whether I switch back cmpxchg to detect the pte has changed
> and only mark dirty based on the old value[*]. The latter would align with
> how map/unmap performs the pte updates.

test-and-clear should be fine, but this all needs to be done under a
RCU context while the page tables themsevles are freed by RCU. Then
you can safely chase the page table pointers down to each level
without fear of UAF.

> I am not sure yet on dynamic demote/promote of page sizes if it changes this.

For this kind of primitive the caller must provide the locking, just
like map/unmap.

Effectively you can consider the iommu_domain has having externally
provided range-locks over the IOVA space. map/unmap/demote/promote
must run serially over intersecting IOVA ranges.

In terms of iommufd this means we always have to hold a lock related
to the area (which is the IOVA range) before issuing any iommu call on
the domain.

Jason
