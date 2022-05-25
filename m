Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77C05342F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbiEYS0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEYS0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:26:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56CAE26D;
        Wed, 25 May 2022 11:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvgUJMsU+7hxvXdullCuscnAXRdu3Q28u3aaC/mjhThc3u5GBU5D4hcAmEo8p++zSqUOIvP/ipoLn6q5FqVIQGQTl8Tl3vRC5Xern5yhtwcvNPNgMywxmKai9NLGR5ybl3iNsLRbX4hP09aImqMoR+sWNl240Rr0XrX+6iv/GBb1LF5FaBsGeMYbYeoG5UdHiYWfiTC9dv+/AYLAHDiv81W3qAmuoQXlhFEa5n3YfofZRBKYsapA9f8ZZm8UephrOLb3EPZ3gMP8y0KZfnsYjxsihd6exHE6dsZpRG0KSwTi2zobUCnVwHhB/UCoCIThz156narFuWmAi1+rwUyQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxFXRHut7SMR0BfWxKahnGrvEDyVBVam30fJa1G6nxI=;
 b=bIcfb/OpIMN8um25zo6bLlAhza2kzz6Ap3g75KfV6NqHDOvv0lw9eWXINppFBPF6WgsVtZ8XvhUMe0JSVOvqq5Wyj1wWyt9S8qJ6EksuCKkehm8HbD8jL3r9qbe8+HdDmPH+rOqcIpVkTPOPD1Nus/hVz/BMPZtzUMFHKDvlYig1GLP0cF74cz59hS5lhAcf4rqxdNh796RFfHBLjn0GSFXnHoh5KSbhwNLezOkmVpY8LXWzAb3mctYaRpRNT8zGkli8s8dqoxKBnOQ745g/hjQoTjMOGo3sZ4aMdz0QEU0ZATLraaxo8uGodAYRqzIB+1uSDciKeBbrLvHMNHRXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxFXRHut7SMR0BfWxKahnGrvEDyVBVam30fJa1G6nxI=;
 b=YFVui3uf3P8/r9II5vSNgNeO1NZ2zswUDO8Ftpl7ppRRnbXgpkJZbA95GjlJ2fiqwibud5zne/Ui/ZkipNMdPA01zN7CLTQF6A4uVSFonwVIim0JWtFFSHXBv37kPU82w0heSXesWBCPo/yCoGjKuVP787qMxXK1cBBummOhc7XtOwllYdliJCQNAmQsyOwu+NsaY0FX7PiM1KFJeybyte7+P38tsjo4rhHSaM2X6r5QDmmiNfTV6KnNzyiXzPMSkrRgQcYT7YpHwHp7eoWFWQwt4LkqGNrL1eMxbIJtkBg6aNNsd924vxnDMAMtCtfiFc6CGHesea4os1DcVctnoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 18:26:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 18:26:45 +0000
Date:   Wed, 25 May 2022 15:26:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <20220525182644.GF1343366@nvidia.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aa6d43d-6ee3-44e2-758c-08da3e7c1fc0
X-MS-TrafficTypeDiagnostic: LV2PR12MB5893:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58939D4DB836B3DC07E6A268C2D69@LV2PR12MB5893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ohqb9quK4LHykGRWlBEwWnuJqIY2ElIB+IIxj3QhTCDFmVvK4jhSByldTc+3cjexk7WjIusabsToRJoVSkI823i3xt6TX2PtT4KNK1qsaZRncZNpEpe6qHh8266DTr6JyGWOEvOKRDKWoejpBGqN9LLgZEbpCTwVHkuCtgcV1e3X/9D6uiioSZjaDa31w4nq45Z8tdIw39gxfiZfVyIthh64zMgKRuIIv8HaArs80TWc9DJmXtAf0d6XgqXf5RQ8G3Ps7qAoC28hgO3xAuyWeucVf18cq4Oawoy3NFDvu7G/wbvV83Hos8osQ4CPzHWlz6OEQaqlHo6kWOPDapkTVTT1Sru/PWCCFp3NJjXp+QZxtFrnpOOJF8MtFxZpAH90s6rz3DjVXz8LPFasRGIe1MAo/bnDscqFBxKcfmzm7lWKQOaSVytm9vOOghHxH0HmRfm5Xn1IbA+IlePaDJ8h4ZHlJWh8LHALg/lexa76ODkPkIlyO2NpcpAe0/cEHc2trulu/6YRp5mzdTl5CjkwLcsLV6Lj732C09xPxN15G7/48ZjHe97XCI3pI7buS8x1W9t5CiDldNHN2apFBLSPWuujKb2RAIvtFEgLCNxR+aWX5OFLvoEFumXcPEC3Jtgkc1glenzHV3ODgVyXYD5Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(186003)(8676002)(508600001)(316002)(4326008)(66476007)(86362001)(6916009)(53546011)(83380400001)(66556008)(6512007)(26005)(6506007)(66946007)(2616005)(38100700002)(1076003)(6486002)(2906002)(8936002)(7416002)(5660300002)(54906003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cX9KBADPhEKoXKuxjZdMlw+rE+Kk1KC99rCbNdHrE9cFoiaVepPUq1sVkzVS?=
 =?us-ascii?Q?sluDgA5S2Ixa22G9zIamLyS9my3kDdEZ40fZJ8q4Cc4MB7WfI56R0W3L8zfy?=
 =?us-ascii?Q?f1EfiGe5BIPHQ+FjTic0vC0HUB0wcSwN468d+px+0zDnfzjT6Z57k8dIo6m1?=
 =?us-ascii?Q?jX+aDq5pNTNMIblVcWoImCWyuzbhN6j2aggfiLc3k/2rYAY7tKZcEMbYYHHy?=
 =?us-ascii?Q?QvlyL9qVf/YtQUM22ufdcVPg9wu+5AC8A66932NEnLlPPhU6cOQxzKFZWpRg?=
 =?us-ascii?Q?3E44PIXMmyXVi2cmVcNd6aot0VzKJa+zMwLXPhkWfRL/MRERDc1ZZFuAR3dw?=
 =?us-ascii?Q?+wjrZClrbQVZ/xjYLXHI8gz5jhoR5JQqTLs93lPcyiApIHsB/8lhHqd8de3p?=
 =?us-ascii?Q?79cjSQE/Wzs9BTGn8tfuTy0smpd3e4EFc/n/Htm9PrgTPfjWcNbbDJVbxhqn?=
 =?us-ascii?Q?9H5/3Ze/3KQ9YMvDZCcSbYBgmxC4OhFDL7uXjr7rJz7Q0PebBtHvox0bcmk7?=
 =?us-ascii?Q?fCc9vOGEGnFXcDCoOL9vl5Jn3yWdxcst8P3xFYn9LLCz3WbR+bczNMuGEcA+?=
 =?us-ascii?Q?Y/Za/0R/MeCRhEizfPVGhknjNeCfeg5qLsLs4anroysjPde3SZsTTiAqy2jV?=
 =?us-ascii?Q?zOckZjRlXsRdGwyM6kbMn/kbrByXhsc8I0DiSExPLeA/hKF70/X4CRWmmPbF?=
 =?us-ascii?Q?h5n6fc5kbh8dSFmbsfHCd+WvcHy82bLwIZ2UoBGp+oxxL0uwT9jSFvSlizRU?=
 =?us-ascii?Q?9+EwYP2gxqq+zdfVuC3Ro5oF1o25JM8Xip3QUj+eWw/ysP0223rwUn31lBgh?=
 =?us-ascii?Q?CpnbXpYF7igvgx3F99Kel9W2D7gIA1WEPb+2YfDGw2hheGZqrF/5XiDcpdvE?=
 =?us-ascii?Q?1q11A5ac36KE5F6UIjyrc8lBWglFFBrhUwxtKp3EIvRhgo1xKXXn3A8C6gam?=
 =?us-ascii?Q?cdKvB2bijHcoX/M1tLeWFxbmZrFrgFSbnegeZuVodboc8vtDzwW5Omid2Uwn?=
 =?us-ascii?Q?FIC+BmFcVs1uOd3Fwd3IpWuuJ2mz8G/bc6pwPxUQGyHmC8zqIcD15tzmgIrU?=
 =?us-ascii?Q?VRmMbdN01eWxA2uKcxChhCWuVU58BH3V05HXNal9F+dGrcvvIxDebOwCdY9D?=
 =?us-ascii?Q?WgoIMb7bepcZTjQiSAIruBAacV+XCa+N+d1O4C88vmtPndEfejO4n899D/cd?=
 =?us-ascii?Q?2k+OVrvcIrlOQZfOP9SF/VawGPTP7ob9y0K8RAvEtWA9vZFKWYgt+z9cZbqt?=
 =?us-ascii?Q?WG9Ta2w2enijSL+dL+5YhNLRuXWfZCNJ4UvfUga/jRslHGaOmkcorBv5RhwP?=
 =?us-ascii?Q?79HF9x38uNHpTn4p6I5/p7sQWHyr6+gkxKHLRzpOcrjkM/XydZlRph2XeDSk?=
 =?us-ascii?Q?tXCjaRj+uNPaKM7YQSjaBdyJcbXWSQ51GKYst8VWYtB5/XM2Tu/GnGUvGykq?=
 =?us-ascii?Q?in3+/YJhEu/f0xcVd51ls5y6y4FBaT7402iHCAzlkbFgMaN8jwnVK1h1pGof?=
 =?us-ascii?Q?92AG32mV8W/aJkNWpg+Z/k9bzgkwFWDc/4RaqvTwBgTB92nUqCJHIA5UqR9s?=
 =?us-ascii?Q?xwELxwjud5Y4cMeF2TrZtNnoR3CtQMyzD+pKev7h4Szsm5KrBHHKjtjzvsPw?=
 =?us-ascii?Q?5s/a8VaXoL/gni/KtE7/nCTKtR1H0QcW+yV7V2FI9JIo94rZysMIR+aFOVaN?=
 =?us-ascii?Q?3C58x3ZMKIhlHNSuPE9RjbpOV5NPPR6Ve6YsDONg91RLXMTHhgbC4j6kcNbF?=
 =?us-ascii?Q?1bU5D/pwig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa6d43d-6ee3-44e2-758c-08da3e7c1fc0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 18:26:45.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJsu7t1oXkTuzXhvH7pqXAZ8siYiwNmA+pCyA6y7S0ti3cO62ikj5snoEVDQfFJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:26:37PM +0800, Baolu Lu wrote:
> On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> > +static const struct iommu_ops visconti_atu_ops = {
> > +	.domain_alloc = visconti_atu_domain_alloc,
> > +	.probe_device = visconti_atu_probe_device,
> > +	.release_device = visconti_atu_release_device,
> > +	.device_group = generic_device_group,
> > +	.of_xlate = visconti_atu_of_xlate,
> > +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> > +	.default_domain_ops = &(const struct iommu_domain_ops) {
> > +		.attach_dev = visconti_atu_attach_device,
> > +		.detach_dev = visconti_atu_detach_device,
> 
> The detach_dev callback is about to be deprecated. The new drivers
> should implement the default domain and blocking domain instead.

Yes please, new drivers need to use default_domains.

It is very strange that visconti_atu_detach_device() does nothing.  It
is not required that a domain is fully unmapped before being
destructed, I think detach should set ATU_AT_EN to 0.

What behavior does the HW have when ATU_AT_ENTRY_EN == 0? If DMA is
rejected then this driver should have a IOMMU_DOMAIN_BLOCKING and
return that from ops->def_domain_type().

Attaching a the blocking domain should set ATU_AT_ENTRY_EN = 0

Also, if I surmise how this works properly, it is not following the
iommu API to halt all DMA during map/unmap operations. Should at least
document this and explain why it is OK..

I'm feeling like these "special" drivers need some kind of handshake
with their only users because they don't work with things like VFIO..

Jason
