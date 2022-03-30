Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F144EC68C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbiC3Ob6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiC3Ob5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:31:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515240926
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2t6LlKjyha94TuEfWpGxRCVj5C7zx7e9rtJJ7oiwLiBhy3WcTmT0rYLU1M9lRPMZ/myJFIqMD+8hTcVbKU7oOKvSHOT0+rEtsjC5oVrO4vSDifFcx9854vYi1lM8N9II6RpQlKcXRulv8em9wzXfwF55Tk0B/bX4YLsHhLlyf3WKRoMDBtwkOORtl+T6zCxgMMATRuKr7UVw4kJhWENtE7Pot58nqJ4xEV5CNcmlpEtbrXkObUTXVrK2fpBb4/ygCk2AeSVIEs2RcvtZzpz8zZanyMj03QJ/CTccsyf740isv4fQMYBXj1MdqFjvC52FrLVaO3K7WeXSknQcWtfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ijkh0W5MAR6R6l8INNBZANDHYB7WgucgSG1hWLFd10=;
 b=gMnIjSEQcTZCyTO/l/j2PbC9cDt5Q9P5mxZkc+FgW7RaiqMqaQo9E026IHDSBO1qRBTZeuMPdtDMKi6vd0PTT2DaRWfwOceod0uuSLpDynPNGkYcmQv0HC12oybpZe8HehALqfktoLEOAvxkMkbr0FAipuV1qZpf9B89Jv1DnJ9rHV+ImTRl0N/MlNr56aUBti7ZUateRQA9ZkjsP1UPxeqiyrCE2pBGHuGyZwcukoSHA3iM9xbKnMdUiJh+6IYUOH8phASVA3Plr+T3obNxGCs3SvRMJkyRTTBTuuLG1O2uhrNetoCQyTUMkFfIZgnl8C6mfmNppySovXRosF0XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ijkh0W5MAR6R6l8INNBZANDHYB7WgucgSG1hWLFd10=;
 b=TotZMlOTYhU53Ij1BjPmA7yoYAepH91dSdQ2HIi3pIunczLPmjjX/yBDnqhwNrY/EuoEeCmB0DdbmNu1W4aG3DRTQkWXYDfh3TPH57G7mOrvdnVKkZyWNTs4ZRFARId1xldPJV1bkD8Avq1Z9hyuN5VEYlKpVWUkeFpy6lpl1jYedD5fSbxmh1F7M55/jC0O2f6gbfo8Sfvf3Veip3KrPFiT7JtE4ZQy88Esoc/V7Ew+GHwT2i4kvMgtOBGrUaBWMLEFgf9S1Xi74tzX0S/kCBuywvcIHzzcp1gbZq/2/wTxDOzJ2mydhRMhQGIEiEVofKmp71/xpC3lcK72NsEhjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4602.namprd12.prod.outlook.com (2603:10b6:5:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 14:30:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 14:30:10 +0000
Date:   Wed, 30 Mar 2022 11:30:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220330143008.GB2111031@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d04116-715a-4cb7-70d5-08da1259cb4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4602:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB460236A966F7042D3007CE33C21F9@DM6PR12MB4602.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3mRi0n0Y0x6r1dF9jqqoJTOK5IPGg1WMg2lytiKaXtOvU6ttqORqixJYRscTMcxghyvrPWGNKptNbmeqybfkKnhhePOtRLjFpPlw00wvAWyUbkBxVyxbZnrpRJor/rx14YfOoBq9zfTmDVOznYKEu28mq9Cfc2ZtaKvUI5XRC2Sn88+1v0WxQqIZr0zGfeUYnx+WvXU1tpVxWneMRZdQl8mOz4D38EPnUbC4lR/3mo/UHj8F/5JQqmMvPI9jYS0fTDxGjHyO39BfLqbsEExlJlqKIxBW4JEHOmPiuHB6a3LUmlwTkSBnf7V1ki0vsqWDoai40B3B7MuT7jGb7tYTjzHdDsi37YXagRBDtUJgZ+xxzm3VKtUEt3/yqCxbEggYReMW+U7hrJlpvQCbcDiNYRc7PuaxuwrOWTQaVhNlTQbERS/ghCfjPsth4ZUYDUHMXoS0AlxK/p0O9xjqMkBMVIAk528D24VZ3DW+E2hnQ/GNtX0CSxi9WXrrCPOMpQSorHSAFqyNhrM+5Jyu578g/OVwGODSd25eoqitIQJMMOnqwPVzYx4npANhk5wjT2yy0TPgtRa3LFTTH+BBrme06gimO1hHauA/H9RvJWWnPcZWpwEh7nRYBSC+y9o2jdO5A6FOyW9WXQin9Kakmgqiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(1076003)(6506007)(6512007)(33656002)(5660300002)(2616005)(83380400001)(6486002)(508600001)(26005)(186003)(2906002)(66556008)(8676002)(66476007)(4326008)(54906003)(66946007)(8936002)(36756003)(86362001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0shwvUipBsPO6sEvDnOuVdfbSP/R7WcHnEXiEwgi0Ik2/79qfmK8yaHFsgIT?=
 =?us-ascii?Q?c4ZJAUOPs52hqEwuWgrJukdoL18WNPYwcCERoYQMLx+bTLV6tlhypLcE+M7Q?=
 =?us-ascii?Q?SBpfD64X+BQNMlOOzLUEwTn1tNLaUhHU5wbxheJMPlsFEkawDPyC7BitGDWA?=
 =?us-ascii?Q?F9COf8NqMoOBKKSgdxm9vj+adt3kdUyIrYYQw+SOB4wfGivEuKXlYT8FHdW8?=
 =?us-ascii?Q?9/sF40LUEDe+Rt5EWam3U6kCHziO+EOpkLuzqpg4DgLqLSZynnBvRXqDby89?=
 =?us-ascii?Q?kzDin/GYh+xR/NzizBw3vxgEpESy2gwIuEp6sH1vKXjUj2UfQlZb64Js/3n/?=
 =?us-ascii?Q?9e4wv4Pu/ZV5r0bVXliod0/twQZgH0iSniyfZpGdV7JpiLuZOdn0m+N5B0tI?=
 =?us-ascii?Q?YMcmN+RpA/+i3ChVC3UGNl7+V90mVQRdFQWemeeeJKUeQIQsTpBEcaDI50Xx?=
 =?us-ascii?Q?xrilzd7RYXuYxMTTlvRg+k81kK5gesV+U2hMQa4JZryZHSLobwBYsx/lDMpr?=
 =?us-ascii?Q?Wu1Bj8A6XcLVqjXwgPePUYd9fUNcxJOlSNr66ik1BhXLI7U7Q6VXSX8iFCj3?=
 =?us-ascii?Q?gensJKI453EHytHsBvSprLfegqrJ6FZgRFVZ+ADusXmH/zmTxeCE6zYfPNip?=
 =?us-ascii?Q?3jtHcWogkW+uYU9dGpy/l7DQOOqEKUfGXtxxhSrX0HTor4u1Q1LQS/JusAF7?=
 =?us-ascii?Q?DuX2ihWS3j6iiu0fxqWOgk7OD4SyzNJ2a1K2BYVA991IMchXM2X+LjHQjEny?=
 =?us-ascii?Q?0bTlRRgLGSCesb61SqgApt0cUYRZOo26/KLcs7dWeeIFsdmPS7ZjL79lD3eK?=
 =?us-ascii?Q?CvdlDQPDUWKfTMNwzhQ32vg+Bd64LWKUx0m4jA3Hw17neaW6WmplapksGKpG?=
 =?us-ascii?Q?PsVHNyFPnubzl7llWMaV8ZR/w0L2fEt19XknF/7uRAX20EqtBOLP8odUmblY?=
 =?us-ascii?Q?bryQTy1GD6ijGvdsci2XsNCoQaT3bdeDVJB8/I4YdrlCCFr7FTLyplqu1ZEy?=
 =?us-ascii?Q?Yqg0/XdOOE0dF6FCSiI7Kmzcg+kWR1blno4n3QX23jsbFV811WSnACORXWtx?=
 =?us-ascii?Q?SfUSDi6i9yUcaCPg5wEjguZr0ZUQVz14kQA+2Ym5e6IwzXuBTRuwYw69la0w?=
 =?us-ascii?Q?PFx0rueYR8rz0MvI2aZC1pLu62/NoFzV91GJP7VLXjcyHTQP7dvgcCsg3sKY?=
 =?us-ascii?Q?Yt6UbmQyRVMCn/zPK3EtVzMi//7XwjyZ9H3a1gB4at3xd0loHS2orbNCmU6M?=
 =?us-ascii?Q?3H+fr/qgD6eQoc1gAyCGVofJEPyvnn0oUYHKGO7pN/PfG3PmISI+wXutlnto?=
 =?us-ascii?Q?hbaKEeRqKBtd79MjUI/l+vwyug5bf6Boi+6Bgw287SlD8UbcWIprY9y1qWOv?=
 =?us-ascii?Q?3RLVqeikhfjjo8wRu9yd5muCWunwmGIkZ2Yl2TKDI5DKdYY9J96gC2zVqJHl?=
 =?us-ascii?Q?mhYlpdl9ZRpIKC7Czwg8AfeX1tEaaz3FL5wHM/96sm8keHo30VCsNoudWPb5?=
 =?us-ascii?Q?jDn35bfkU3TN/azINL33nsrlKgGUwhv7k3dIz9b4+P97ohRD+oFKbzVjV7z/?=
 =?us-ascii?Q?DQWsHW0R/8gqHyDC/JroQl0yZLQJHy8OrcrMjjjbaI6yzVRAyc4MHz8b9Qsj?=
 =?us-ascii?Q?IsHMjxhrBIpcmdhk5QjS16iMjYZPg/EhaKhyAGcWU69X9A01vz5dFBpv2edC?=
 =?us-ascii?Q?+3ujxn3hyGFdIc3FI05C0GVul5BK4R1L4xOe4QGVagiuBKVcgBLqf+s9PSKo?=
 =?us-ascii?Q?MQ/ojIQDUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d04116-715a-4cb7-70d5-08da1259cb4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:30:10.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv8x8UmjCstkeG1OCzhagjJ2s7RWAgFFDWnuCUNU9acJ0MbjzHYnZstpg3aXsCfd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 02:12:57PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe
> > Sent: Wednesday, March 30, 2022 7:58 PM
> > 
> > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> > 
> > > One thing that I'm not very sure is about DMA alias. Even when physically
> > > there is only a single device within the group the aliasing could lead
> > > to multiple RIDs in the group making it non-singleton. But probably we
> > > don't need support SVA on such device until a real demand comes?
> > 
> > How can we have multiple RIDs in the same group and have only one
> > device in the group?
> 
> Alex may help throw some insight here. Per what I read from the code
> looks like certain device can generate traffic with multiple RIDs.

IIRC "dma alias" refers to things like legacy PCI to PCIe bridges that
do still have multiple PCI ID's behind the bridge used in
configuration cycles however the PCI to PCIe bridge will tag all PCIe
TLPs with its own RID because classic PCI has no way for the requestor
to convey a RID to the bridge.

So, from a Linux perspective the group should have have multiple
struct devices behind the bridge, the bridge itself, and the RID the
IOMMU HW matches on is only the RID of the PCI bridge.

But we know this because we know there is classic PCI stuff in the
heigharchy, so we can just mark that group as incompatible.

> > Add a flag to the group that positively indicates the group can never
> > have more than one member, even after hot plug. eg because it is
> > impossible due to ACS, or lack of bridges, and so on.
> 
> OK, I see your point. It essentially refers to a singleton group which
> is immutable to hotplug.

Yes, known at creation time, not retroactively enforced because
someone used SVA

Jason
