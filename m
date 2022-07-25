Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36B5800EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiGYOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:46:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CBDF7E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwqJS4gLD40XH1ShQbTkmOzclPZHsQHBbnLY3WcN5X8xXjibKQfz/Q5gdo0ZsEWrIwWgLG+JCR8Ch89i3QgmnP5vFogabfGry2x6sZcudpnzRvJrQDykGa4IVb9neh2RsKDgEph1JxdesYQ+Fe0qwjeTjUl4Q/2a8HiLVzxV98IQkCacJDS9UJfAp1J7dfsMm5oyUYW/KD+G1cVjviCcoDs0guNAhqtSa69i0j3muief2Qz1GXzcTuEA17TLUAKZwdnlVbNa0niqdAoJ75kIV10TZEIVyatdCd/BkQ62b8LxgQWgb19vcT06EvBVmUS8ab9L8Js2vTOJgcHFeaGG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W58F2oVw0OYqsxWkkkh6TcxVGI6goGN0squwzg0GiHU=;
 b=lbx/yVilk27CkX9p3lzbYNscGwVg9xjqtnELaWGQWRNNdNZYA1URSeuQ1qQgKZ2JjhsSHY+KSTb27I65cR9TPJ/IpjEHFpiiK/4T8F1mgfFccwME+xAtOdsAkk7ntfS1gu/BMqjCH3vZnFWk4QXJ7lkW49m+T0bsSonQxnvnpacz7v2+khWORtuO5VALagkb05qVUJW/mmsuW6qkkioWUiAJuHvPNIO3Z6aVJabND6s0UsPXHtu+GiRq6OPqVVfboJJypHL5czWzmYt0ZDtuQ9rUS2h6YBjUd2ZZZ+IH7m+uOvskFcsRK9lDTitBiGO/5lQDcFZEy6j3T3x9lUNBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W58F2oVw0OYqsxWkkkh6TcxVGI6goGN0squwzg0GiHU=;
 b=WdAvaFdV8k6Qs+OHXTtzCLWDbhxGF4GZxIqVzHqqXc8nCX/MZ7Rax5vH5SNVcP+k5gYf1JOlGSbL0CklWEzbQdDQxZNnre+k2CjQGHWguK6XMfTd51RlYPN9BccDSjWHFIrp4YtnjlOwuQO/zLJr0JN9nt4lLeZk+a16iRJyDXCL2zLOi4kW7ayLEX1CCtgXhgl2iw2kxpbNa+Lwsro2EMww1IxWLNOMa0BegHDHnRs92dFhp8yevMPuvA8ZM+l2Jk9U/rEK0zNUeHHwN22568jnqcVIel1qLV3UskGmCvgpHoTDznnzNZukhiAFyqPATgipExYykC0ZSvNt7fkDwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 14:46:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:46:10 +0000
Date:   Mon, 25 Jul 2022 11:46:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <20220725144605.GF3747@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <Yt5IqyZw/Sa6Ck5t@myrica>
 <7862ed6f-b834-5dc7-8677-31ff52fec76d@linux.intel.com>
 <Yt5n6JCrigzh3cwh@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5n6JCrigzh3cwh@myrica>
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0ac13b-6800-4010-b737-08da6e4c69b1
X-MS-TrafficTypeDiagnostic: DM4PR12MB6134:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBUz6SmP2uO+X5j8oYud/maXfbM/CjeIInr54GQQDWVG3TD52LsCX00XQkSVBq2/BrGKxVAnJza1nOISahYO3PluyooP4oF3YP8mXDT2NAfrRMKc6JrK/CRACBf7haXPmVRSolU1SPMCB9/hPjH7trA+ZAnzhlRBpqtk/uXrfH0kdRYzBc6Z2XbAkTsvZsCE4wWoCpf3H6jJfaeuOtBGEM5tiECDwZB+XrigC6kamWYuDFLnLMibM0Uss+JC9ll5UlrlxQnICQjT43wCpmOjm4dLoqsjr54+Xe7I+6+pF2/ibWK9m9n3yM4E2p9zebOBYqW1oohN8UGxss8z1NzmmlvfvoMVqaLAG6A0k+OhQPbc7ngnqRC0csqyEjPQ99vOxkHCbmMeGkVjyBW0wIiv1WQHYPDw5VoTI0rC+ZCfZacI80zU91uedl302sQuwoT+IIJ4urUMSXMtqpd26V0ntLVkrB4ioOGVmKgf1CthrjtAakxA+Cv6MToYwCtnFk84/Pk7d6lf1oEq1/9MEAysp3x7mnXieiCb/xkf5UTbuS/mYe26qIVEPIvbXc0bWk2kLt0JrXnFvPd5bxp/DivWxL+JuSNZAKC8BIgBMywDAOfOAjpDlh9I3qB4lPdbhkypv0GIzcNTouC+1S9BbBsTjfDN1v7qYbn2bQcL3QFSdKj8BCdlWNiPNWhrR3a2wVC6rVOSH4TFbEh0+dT8poZjH9yv5pylm2C5gjjQE0trWOIIzSomLaPX6p81eKA3ORBt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(41300700001)(316002)(6512007)(6916009)(6506007)(6666004)(26005)(478600001)(6486002)(66556008)(66946007)(5660300002)(4326008)(8676002)(66476007)(7416002)(8936002)(33656002)(36756003)(38100700002)(83380400001)(2906002)(2616005)(186003)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZHjITP3eRCvuOBQDTdeZoDMx1QnlzS86Mr3ni4WxfF9oeDdUeCLCbjirHnF?=
 =?us-ascii?Q?ckyAesKKCjMPTdrIQeYgG5SbJKFihCq46QuamLYNFXaMHYUQQBlu3Z8C4sPk?=
 =?us-ascii?Q?1+EjT1Jh3FEJVQAZgT626b7CkvVOgtu0DKDM9e7RCWA+xErDP98GeZ/9Uzv8?=
 =?us-ascii?Q?u0viDTzGrCS2SQVkka+MQvOLcleTBn2ZK0wwa10niOsIaAHkxkn78y6ZpDNX?=
 =?us-ascii?Q?qZaGSjS77jkic9YkHifrIHb2pdBnakd3vNdzKdv6W1Uh6OZcNWSPgM8A+MtD?=
 =?us-ascii?Q?6PuetuOQcilyJggkFhJaaxqsUmbREVFFD4THTLFPrQFXYeofbzw6RlkSXnkQ?=
 =?us-ascii?Q?mATcJdff6jcIhNY0vUXGPIsP6NedzsqxHX25daPmKXpXTcWfms6xxpVMqX6Z?=
 =?us-ascii?Q?b/Tn98LDEDjJf3zJpSZAOXf1QCm1uKeWYn/rErTqNagycSMarrGiTjE/sbkf?=
 =?us-ascii?Q?LTLlg4B9MzGosePkzu8BlMRTl8q6S1UYmW/4Uq3+3wzQA1BXt/RE1z8pQF+h?=
 =?us-ascii?Q?qBcUBpzILAzjXYf2UKPgPCQLMMFska7pplwhFYBxWbvZAqtMnilKEO6kOLCK?=
 =?us-ascii?Q?DDHHfs2vHpr//DivJR7XnIRPAyqdUiE+OQVH//pO7pgxEvdwHcsblZYfuLC+?=
 =?us-ascii?Q?sbu6WDnR1ahuBAHUpIe3UfrVumFyETHosQrTOogZQdGXXkCwEMneskVj7OpX?=
 =?us-ascii?Q?76mYqk1A7eXdkltsQj0yk9wl026DW2kZhQAOuvXVwcoh5ywF9BkcpcHwtzzm?=
 =?us-ascii?Q?tkK8Y1U+vZkEpEVWHXLljyTA822d59XUBe5v8Vq4hmJkPMIvyA8MKHOTM64t?=
 =?us-ascii?Q?NWWMG2/I4KDww5yABM+a4AbmU02/MTTH1dVBdfKz8tjShWF+eClPE3GoJ1lr?=
 =?us-ascii?Q?PwsDIGEDDz73MMIS2GAoqEIaZ3JA3/6ZB1UjmeQTFY9wSy1fcPQ/Bs0awKle?=
 =?us-ascii?Q?LakLF7tRn9Ui4tWJDm6P8wHIxNBCVKMiOTCpMYJ8SqVYQBVqbqGFaJbcFu0z?=
 =?us-ascii?Q?+dAD3NGUrr9GsiqpUf9EKpGC0X0Vn0KTuEWYnCeW2GMNtTaGRbgbcy6Fojw/?=
 =?us-ascii?Q?q1gpc7k0fAMJzRzRBLMSoqV0YTGTfWEnYEpNiMQ87nSTAf9RUcAuFPxtnwCH?=
 =?us-ascii?Q?oN7N5Fcy4KhhbK4vAnEjslruLfPTB48zCL45KBXEpyjvVHoXaqe6Jyfgmczy?=
 =?us-ascii?Q?4Aq6OouD8xc3ttIF3odOD7ZQcCWAKRqkssJaenPvjFOy57eBBliNzLndH99R?=
 =?us-ascii?Q?tHhHEuFKbrMsDMBxW88Ecnyw3q6L3ZF0oPECKXwXoYKqvUIRmc+eZdMtVkwv?=
 =?us-ascii?Q?xiwJLSNDe3vX6KN0L+7TmWKdHZPeLCB0bPVsaGFkSYAeoR6QU/JNVy9aXq1m?=
 =?us-ascii?Q?25cRy56FHH8T3jMAdoCvWqX4IuXCmwxBrqlqeMqpcMGqGuQwPQZYe2bT5dB9?=
 =?us-ascii?Q?nxUizuLWWMfKlcNlTyW92ekInbAmJ9IfSSBOL8P/e42KcpUSnJ1nGHzz1tTP?=
 =?us-ascii?Q?u4avuQQOFp/MR0g46FXKsq22VYNFyYuYWrMx7ixl/07an0Uw0JeP2jcCqjLw?=
 =?us-ascii?Q?FdUpqm5XCmAg6VdFDac=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0ac13b-6800-4010-b737-08da6e4c69b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:46:09.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffq7XdlABjVDh7ZMAOt9pwgC95dRNue/naDbinJcTgFRQwX/tNyvDX0/gJH9T5XJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:52:40AM +0100, Jean-Philippe Brucker wrote:
> > The iommu core provides the interface to retrieve attached domain with a
> > {device, pasid} pair. Therefore in the smmuv3 driver, the set_dev_pasid
> > could do like this:
> 
> Thanks for the example, yes I can do something like this. I maintain that
> attach+detach is clearer, but as long as it can be made to work, fine by
> me

Except it is not clearer, because there isn't actually a detatch in
our model - many things already got messed up in the non-pasid case
because of this confusing assumption.

We have only a "set" operation and set moves between any two domain
configurations.

You don't need to call attach/detach pairs, just repeated attaches,
which is how the normal path works. detach is called in the legacy
flow for the NULL domain

So, creating a pair invites the wrong idea that they actually are a
pair.

> > The check of "(!domain || domain->type == IOMMU_DOMAIN_UNMANAGED)" looks
> > odd, but could get cleaned up after a real blocking domain is added.
> > Then, we can simply check "domain->type == IOMMU_DOMAIN_BLOCKING".

So this is probably a good reason enough not to do it yet, though it
would be nice to get a proper blocking domain concept in the SMMU
driver to support VFIO, it could be done later.

Jason
