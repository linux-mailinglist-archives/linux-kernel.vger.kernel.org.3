Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA853A931
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiFAO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354797AbiFAO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:27:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6F65E3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZlBMdcDGjb/F2PAEJ9kr/pwf1CqCFYlaEFY9AOKrBtQqVc5vthFq8ZIDYUZbXlLKdPN5NPEGyC1a6SVvLC01vZnokugdpkOJiG/rJWjQEOZ7bwpgDU0MXGy6x6iWlHfzpRQhUVKXC7/Hwr87Em1WPyM+As9SwIR6inYPMzQmE/rm2luVaB3gN65rzLWG7Rr3ZFzGkbUm6SUYLWT0zIr0lKsYKF9Qzh93rJhsXkoHUceIykAYshMvvmI0hDsFvoJM/1WUhSRp8m4/o1gktkdDwUFi4mqXT+qZ3S/cqgHMmVEB3+/E0e2UAwVZgebIx7Dzx1RjjmqeSUhv07Z5CqWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLH5WvtCri+7w0p9G87EUGdG6lbsF66Tap3Kyf0cuM0=;
 b=nDh4JGLNlDk9ftiUpLxbkE4sjDbeph/SPxyXTS4H7iads+2uXiLWnx1EqXwbHs3ONBlWOShoKIae+5Uh8NLUHjpJqbZwHP0LI5WRMuMkBO7vyM1EWXhGobO1OgqR7UymLcZnqGBaZCyEmAVN95Karbukvhcp5Vd1Wtj021/q1SksJN+tONCJSSvD3C0jQhlUCgYdiIzCOzS6FSmY2SohexqSUImU9MxehFPZmE++CKBHE4ZXayzD5mCEHTRXQVeJs8iWao8ABYcTKVH6M4vI79bRK0UCbVVaeh19ZfRxH8bavBg/LhMRD6yul3CBTIXG3+MWbO851LZB2vBNoeehBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLH5WvtCri+7w0p9G87EUGdG6lbsF66Tap3Kyf0cuM0=;
 b=lIYoayrDRTJmP2p81+dDxJIidTzYd5NM6cK0bOlGW2rUvu499mP8SzLNj4zVCgj2AdmFG4t8w65uTkRbf8gccFPZwqoSemrvNjSfgl61dVp34iMr0iwRs1CHICVKaAn9uBrtc6HdcAI2NuOrCWPuLnImqgCu8UQjFX7HCKCZAtD21kqzau0MqB6a1lt2viYKLr6q6gW0LSJ0g3gCSQXWFe46prczhw9DbNfqbzcHZg5ZdoWjQrn8fzQ6YQEyz90EawUXdNtLJzgVSzRGO+PeAnSl0Rpj46gMUsmE9h3juF5FTBlBahxdeL7TJWO/swwKAPL5VuUm11+TetE3MhQp0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 14:22:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:22:51 +0000
Date:   Wed, 1 Jun 2022 11:22:50 -0300
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
Message-ID: <20220601142250.GR1343366@nvidia.com>
References: <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
 <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
 <20220531231039.GO1343366@nvidia.com>
 <135e22b8-14cc-446f-98b6-9ee059236641@oracle.com>
 <20220601123321.GQ1343366@nvidia.com>
 <c79978f4-7304-fe62-73c8-7cbcc4b2b24a@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79978f4-7304-fe62-73c8-7cbcc4b2b24a@oracle.com>
X-ClientProxiedBy: MN2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:208:239::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3943de-23b3-412e-7768-08da43da35cc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB371758D0BB4C1C22B9607685C2DF9@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GBjmA86pSjMunyOlqzfED10AsUjaLAJRXFG6bE1OeoHZJXWjaXFVU37oXteIJRgWLB2wvHiuKK3BmBku/yRy5Y7DYfvakWRSHFF5KSkTHzukJR60UPb/ncEy2t+ZyXPZRr9s6LdQIS7DdINEBZofJ5vc0EdyDANrS9Aa/bXQsKfy6uRAoVukH2J5jnT4VZOYVwX0MMwVadiOVQCOlrVzCwUFLPMkFHmsrgzr4x3pH/B8FG7RPApzbV7Z4aqgoMUQvOzPWenx+8lBqI459eXlJE4z+FFQz4eqkbEU/2RWxksOvubuVPxOLAKXjIFhooKzI3RUkVY/tKbYqVxXOF/aqlYnEwzfAcPhRjfeTgWSO2Ad9UZ6rUESEZxGu0T8aPBdAWpME+an58w5vQP7pSxGIz2v2OUENGTtHzXnFsy+/g+TjF4D8CB1dBtOgqa+5qcDlarDqXRt3MrCqAAfRbNwpJNbGu5xoOxMa0e+f/OkNy5vQEkx/Gw4uUw/aaUu8nVwE6EwKz82L5GBltlGNWbhDvQsQBFgVSgk+RqJ2GgQkAQqI8N3ZKRJ+D2tCP05v7PZczQW8T/s9V5bSDCrJqMePrQ8bj1vXwuNEmmec6188WFgRYDYR9Ztnmdcd/+gBuVbau8avF/9YvP4RPwdrmcjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(7416002)(86362001)(6916009)(316002)(2906002)(5660300002)(83380400001)(54906003)(66946007)(66476007)(66556008)(1076003)(2616005)(38100700002)(4326008)(8676002)(8936002)(186003)(508600001)(36756003)(6486002)(53546011)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcKnKaoN91OsoWjEgdGmGwqwX5l+Ma/JAzoRDEnBNodilWvmMI+d9Gf03Ia5?=
 =?us-ascii?Q?K95vQ/Af0Ps0nOMkun6G9VARDOEgoW8KVRHEYKQSLG9m0rI5dNG29sVpTA1L?=
 =?us-ascii?Q?T3j/A7qVRf0AOVbAgbyKBsGiuJ4cbweGm3hvpxxPcukSieq7YoLckin49bzz?=
 =?us-ascii?Q?tAuYjXvJDIDOmuFd4KkUn9mLiAF5zIQdc31apBB9h+RtSlQD8tRPmhtudKfq?=
 =?us-ascii?Q?XgXmyZQ+W6MTc/mg+aMnaXshbbjETb5MI0sjSANeAebqrK7s6ABJXwGGvH/t?=
 =?us-ascii?Q?xWJeTFMZHB19K67/NiuVUfsVZBo271s+nAd8E4n/GZtnhcRUjoHJOUAZZeIL?=
 =?us-ascii?Q?cq7ZcAZnjGwUTH2AeqBNF+bqkJK9mvS9cv/eWsGqSeCNDrBqpUfJefk1Seyl?=
 =?us-ascii?Q?owDe4V5BReI46SHUG0Xt6kwO/Dik/kkpZAEM6oenVEljFpBnTrvn+8ddZ3Fs?=
 =?us-ascii?Q?HOxat4FlVOFjzrZevfH7jMzJILlohuSk4ZDGl3fCyv6UFcE5rFZ6mSd3QBPk?=
 =?us-ascii?Q?wIbRv59/ktp5KKDAQq5bMSL2vRw6Mp0bxuSGGI9KZ9j4PqiiXqEzLPctvIOL?=
 =?us-ascii?Q?KL0HrVs66uCgTJylCQEdGVuzQ4jtYesL90SYbTjXdLp9UCH0EDRfx24Ikhft?=
 =?us-ascii?Q?PIukIvsoE+Pya68OXi4EPFIbkFFus5sXSn/uPCBISIC2zuzHp3P1Dwjn23Aj?=
 =?us-ascii?Q?1IlP9uzdHr6sHG6WQ813gyFsrsbn6xFG+OBa+TLZw8zdib4ICoviSFVLjLug?=
 =?us-ascii?Q?V9YOm2WyTNEa89q493vu1dEahHm1b57vq/lUu3EyssWRDEokxA9roBxe1VwT?=
 =?us-ascii?Q?jgZgMbAA7GAwT91LJJmCq4beXrqMzvhnj7oFNB2Z9rlCS+RC2cnz9J0qW96P?=
 =?us-ascii?Q?ao8HFA1mBp73B75qoWTeBcuOTRqnbGMJhVqT9CrAPdJQ8HnKjf+hEQ8057S+?=
 =?us-ascii?Q?Dh2bZvQhCjfDP2DQN3c3R+cT4yjuf3sVGcFEIz4ARReFJM8PfgFIr1xsfHMm?=
 =?us-ascii?Q?VaJUZmsQCbVMaSCBAW0iZUV0nfxyLy99yEy8D4N8Hi5S9Thlsv+6/tOV2vqu?=
 =?us-ascii?Q?DtyyuNjKVnzcyLm6t09BU3QoYquZ4kTSRyejzJOhD564cBuj7Nqj5RlMAWQj?=
 =?us-ascii?Q?QktUaUNOs/vR2ktRPzcJ58hP3w4hkl7k0vVopj1MqWFpG2V1nnrJZdMPd65R?=
 =?us-ascii?Q?lZS386WC+josqmFTvUwHnqqNll88ercqYDFim4KSFopTU5Rr2K1UieZqKoEg?=
 =?us-ascii?Q?ASifxsHeHhObytNODlbEq3pMEpV8aVjYp/MrxNsghAR5lu/HMcaw1ZO4eQgW?=
 =?us-ascii?Q?KLPTjZwh25xR6nHgT1cIDyFSVPrVRAvZuJl1+E/Bjvl0AARImp58lmnjrOts?=
 =?us-ascii?Q?qa8YffGVgDhRXx8sDiQxCay/kv1+v5psuOF02CwqHrp7O6EbxWQ0XHBUxqnd?=
 =?us-ascii?Q?zHHDnlThER1s5vRA3YJHN4E1u8naXDs1VAleGZ4RLYriipEJAHT5R/oMT1IA?=
 =?us-ascii?Q?1g7DAb/dzYTiuWuoPqiWarduzqoMxpiw4x58eTqjlWO2bfNGhjCzcQ1z2kqM?=
 =?us-ascii?Q?d6jYJpfR4JmdwyiAOlcNas7kCOWupHU+Ov/bhenpFMrAt3PTTE27XVeyQOGm?=
 =?us-ascii?Q?V1awv5wTkKdspNq9n0uzUFOQxGkwY/qaimleEtGrHFl23tQyaNa1E1Ox2nya?=
 =?us-ascii?Q?Z1XV5ELFT7Pk/Y3UjwgFQNJyVfTfwGGL1O1bH0249xOXw+F8sv154EA1nRda?=
 =?us-ascii?Q?6v02AdnV/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3943de-23b3-412e-7768-08da43da35cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:22:51.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXW0KeDoE9p4f6cNpg4QH14Vl/FVseu8dh6AD+1+ubZ3l0zGOdP/NBxgJk4ZlvhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:52:05PM +0100, Joao Martins wrote:
> On 6/1/22 13:33, Jason Gunthorpe wrote:
> > On Wed, Jun 01, 2022 at 01:18:52PM +0100, Joao Martins wrote:
> > 
> >>> So having safe racy reading in the kernel is probably best, and so RCU
> >>> would be good here too.
> >>
> >> Reading dirties ought to be similar to map/unmap but slightly simpler as
> >> I supposedly don't need to care about the pte changing under the hood (or
> >> so I initially thought). I was wrestling at some point if test-and-clear
> >> was enough or whether I switch back cmpxchg to detect the pte has changed
> >> and only mark dirty based on the old value[*]. The latter would align with
> >> how map/unmap performs the pte updates.
> > 
> > test-and-clear should be fine, but this all needs to be done under a
> > RCU context while the page tables themsevles are freed by RCU. Then
> > you can safely chase the page table pointers down to each level
> > without fear of UAF.
> > 
> 
> I was actually thinking more towards holding the same IOVA range lock to
> align with the rest of map/unmap/demote/etc? All these IO page table
> manip have all have the same performance requirements.

IMHO ideally we would not make read dirty use the IOVA range lock because
we want to read dirty big swaths of IOVA a time and it shouldn't be
forced to chunk based on the arbitary area construction.

But yes this could also be an option.

Jason
