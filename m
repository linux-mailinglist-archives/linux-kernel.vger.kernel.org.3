Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FC58500A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiG2MWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiG2MWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:22:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F756248E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 05:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIczNLXdjN4o1mzIux1LmatEprcj/PFamYWI6SxNL5fjlJ2ODCmNjhngYZEYnIfnYMQlCvirBoio1vtU6D4RVRAm8u9d93Ja6ZXScXuzgXkXB143XYl3oojU5ENDp1GmQUonTRI7okKUCMN1oeUjw1BXkcYbKq50A5gRimVvewM6wzUuyiCgBOZWPa3XXBov+u5+p/Ko4FGSz6Somv45fPd9sf0CgEijS2EjAf8mZ9dLzan+nzHnKRF+2o6IvkDbaDLI07gBNWRqSHnhXwV5zORDzIEioh584eaPpwikarXRcUMv9prKiof5Zn5wYxbMxGUZpGMWqdMwToLSZPMUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqNPD+ACzYKmxXcZfXREKM5Fl1MIQAPUB6a5uIQhWYA=;
 b=heKWOLoPNfL7SnD7+yWDUlezQFjQwcRiVjhknM9SxJY5xHtESNffOyYoxYNHAsNprmSl69WGI0a3J09mi6/Egs7plEITkDOBWu0UwbVdSDtQd18kV+aq1++73NzSGN6UWSGOqcKr+ZUu0WDU9Mpb/w5Bqog/8SBJq05oBrf+lElRhzOOzOw4Atyarxa8WZhOgWcd+n+X0uaZV5G65/Ighn43P/LS7OfwAtCknyIiQnmVjpWdpehnCRtm/NodZqx5o7GMP3As2TUyGJf0mSaI8X/TABSC03UQpswpyimDQQzoWih2lHXF21at87kSAwODzuPORF2OBjtHLC3y7anDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqNPD+ACzYKmxXcZfXREKM5Fl1MIQAPUB6a5uIQhWYA=;
 b=XzT1Ehq23j7wu8jaVzhNRlbB8hGmSw0i71+07Em48I8/YM/acay1a/O+5zuSeVolRmGgy9Nqx8z88CfzbOftZ4/il5vXPWWwGeT4PaNriYSbyhSLUBdUjgi28aqM+S3wq1Sr85vos1zjROEFAE98WxWbmGeE/zAmfcqJpQnA9rSz9845Vz0EB0Plv+NSy2uuKrc9N3HVB2q5NJLc0q3fpVXyBggXTB/oGO4yGPblYAyNdd84vfZlw+SQOuaESX3UJ6pM7287XV5MeVay/b8DPJ30W9ykNED3Og9zMolupixMxdJWa7O2vRvKk3BwOL1cjdDEhw2TcIpq+I0LpPEBgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3638.namprd12.prod.outlook.com (2603:10b6:a03:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 12:22:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 12:22:04 +0000
Date:   Fri, 29 Jul 2022 09:22:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <YuPQ6om0gELPqoiu@nvidia.com>
References: <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <BN9PR11MB52764B2B1B429ECDA0410D558C999@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52764B2B1B429ECDA0410D558C999@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dedfa6f5-7a3d-4df8-20f9-08da715cf1f3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YPQg+wVvdaCCciI0foGGH26H1vpP1J6Ei+EOiljdvbGNXMwc1YPT5mIgCiKduCMxspkOaL3HxkCImrTrL7CHH1JPi4/N0m9yxRRpzC0S2kh53SQ4T6V1Y3X+PGOGXZe212KvAvPzL2/X7gpakqz6qi4YcSDfA1exBtXVigUurdV/aUGppGZBT0b3y12uPExkW2KM8rsNcMLhjg1UMt2+BKVD+cN99cdJGUMrz7hTT9jHUhxuUpwi0pZOWS+4ERZJgV14EXgqaNwe7pA7w3zI8TobLXhF5+ZP2x0k0S0Sur9dSNEO9zgD9NGgVrKoVr00lR4c+a0f01N2DJDtveaQXz5vAtijBBJCtZKhBoxx9aaqx7KKjadq24VIh1taeAHRVN4KppNhiYlelhNdXq8CHeXMoq9JJEPEDr76mPWZ0tJKxb95evu1rMot3bkplRKWpT3WaCMId8o3/10g5+BNpEkky0tVGj/qiKhLE1a9C8r8jCH/g7puEAAexrVcDjbmOxIfA1EmxOTiR+RCKqe1BHGXj0bbYZ0AvQUBFQFBlrQcw8bPIa/fehjBnffsrAYQPBV9rEfnJiSWxuY1SvtJIZNHatF4C34qI2OoZI0qw32wLk+xylDLLwHm63XYHoaEouWzTUeIuzO17Lo8I3eDAgmL3Qp4fh6PizcqsLv8uUYfkXaMmpGkfFaZEsa23Ev48vzK0bvJmbauZzCHkMjjtahxZia7ns/RgN3fE8CVNCY2q9NU0xR4xepXyTdsC14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(38100700002)(5660300002)(41300700001)(8936002)(7416002)(66476007)(66946007)(478600001)(6486002)(6862004)(316002)(4326008)(66556008)(2616005)(8676002)(26005)(6506007)(54906003)(186003)(36756003)(86362001)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3BVSWYzVDBSeDI3b2VsZWtDMW1pbVpUNVVQTGt5S09MOTBwOUtqUmErNk1x?=
 =?utf-8?B?VEFxOEdtS0ZNRC8xSk03eHRvckJSaXRZYUdRUk1zWGMyVDBCdlFJb2VzTmZB?=
 =?utf-8?B?WkwyYmNhRkJWbzRaNjFSUnNQd2FsZ1RZY2UwZmg0RVE2ZC9LQ25nQnBRYmk5?=
 =?utf-8?B?dXliL1ZMTmlpZWkzaFpvRDNnL1JOUmFVQWswRWdzL2xMSjZ2aXVWbnhzcFU2?=
 =?utf-8?B?bEM5SVlFZ0lSRUNxZlFoZC9QU2VzbkVtN2hERjI3OVRCa2RQczI3WnZxci9G?=
 =?utf-8?B?T1oyRU5NTFhZeXUwaDgrb0lKSDdwRFU0VW9LZGdraHQ5QjlueDdybHVlTldm?=
 =?utf-8?B?L29sSTlOZ3MrOHpZbjBHaEdpUkxRMU9mZmc2MGR6N1Z6ZFVNb1g1N1hzbGRC?=
 =?utf-8?B?RTVmbHBVd29acGRmWktINTkxTjhXaDh3M2w3TjlRMXRkZTFZRXlVY21BeHk0?=
 =?utf-8?B?SGpVT1N4d1d5U0RpUW14M3FHQ0ltUGUxdzFERkhnV0R1K0ZCMWszTHRmdWQy?=
 =?utf-8?B?b2ZqVGJLTUF2TzNyRm94ZmJJcUk5U1ZwLzh0UWZ4R3VmczM1RlJiOWtKSWtI?=
 =?utf-8?B?VXJ1T1lzNEJNT0hWV1RSejIvN0dxeGx0YXBDcjh6VFMzQ3JmRTRreDh2MVAr?=
 =?utf-8?B?VVVNUXZnbk1RVjZVY0UvZTdFaVJneU9hTW9Xejl3VXd5L3d2UUhhcHhHZXZY?=
 =?utf-8?B?TG00U01RRDZWbnV0bTl0d3N2amtuZkJDdGxWaUNHd1ROcytEWmE3bzViaWxU?=
 =?utf-8?B?a0NWbjdTRDJTeGttSzJ0U3FUbTErTG9mMXZ5VVlTQ0Vuc3ZsUDZVWDc3QTUr?=
 =?utf-8?B?WW42dXFJY2h2WllsSElWVUdpZzFXY04yeEJYMWVIcHdZVVJhcDFPZGl1NWpQ?=
 =?utf-8?B?V0hic1p2aTJGU1Z6LzlDL3M2TzNENTdaYytocmtkTmtHdGVPT1Z1YzI0QzMz?=
 =?utf-8?B?YlZ5b0U5d0s0THRDU1VRL1ltdjJGaVI1M2pZWWhUbGpWWmswL2FzbUpMNkNw?=
 =?utf-8?B?UTk5aitCWHAvZWpjVW44M1VzWHI5T21wSmxQYmEzVmQ1eEN0RTdWdmpiRFlz?=
 =?utf-8?B?YmhCVWtCTjkyTjlJend6MGlYaTIzc1VIelZaRm1DUnVqQzBZNUZqRWhiSllu?=
 =?utf-8?B?YTB0b1oxaDFWbWtISzRhbml3cm1LQmtETWlVN2NYWjNwU0c0Q3Vyd2kycVo1?=
 =?utf-8?B?S2sxdXJ1ZDBGL1dxQVRPRTh1Kzg5YlBkSi8zaHFVcFhONFc2MFh3QU81SCtT?=
 =?utf-8?B?b2RqM1FSc3B3ek44RlR3dEVWVjgrZENSUEVlMzVPL0xzSTlSbTN1YmZmaGJ2?=
 =?utf-8?B?NWlOUlc0ZWV6YWhzc213dExQU2h6RGxPMWdwcjNaaDgzQ04vcDhyb2oydWlW?=
 =?utf-8?B?RVBNZ3dDcnQ0WlNEVDg0amJac090YVAxdXVqWEVmRmUvNWNJY2xTcTJkZHFM?=
 =?utf-8?B?SjlBdzljYzZmdE1DMTlxWm02aVlJU2JJSyt6OUU5VldxL1lWTVN4azdtaWdP?=
 =?utf-8?B?WTg1WTlQa2JNdEwzb2lTQWRJc1pvelgvUDRNbHY1cTZBaDZlUU5WWnJNMGE3?=
 =?utf-8?B?TEx1dlBMbkVvYUk3UEhGYkFySUVwRWMvYnR5eE1KRUY5OUNwUGk2b1pmMUhD?=
 =?utf-8?B?a2dBT1BscENrd1lGa1psWnlRNDhpMnppTWJlYjBCWm5mZytOemxjRG9CNklX?=
 =?utf-8?B?NFlFeFFTUTVCU2hoRGk0ejRVbzBaeXJTZy9uem41QVkvdTNWZjgrcU5EQ1FN?=
 =?utf-8?B?eXk5NFdNemtWQkY0WkxFMm5ab2pkeTNDS05ybndSZDVacHpvT25VK2wrRnNK?=
 =?utf-8?B?RWlUZGNlUlRURmhrd1dmdk92eDI2Y2xJS25JSkRlN3EyckU5VVJpTk1PaHIr?=
 =?utf-8?B?VEh3c0Rodkk0RlpiVWNHcWRZNGtDV1E3WHgycHNlRHpSTE9QbEdab0wrVzZi?=
 =?utf-8?B?Tkx3bnJ3OXZKaVlaakhHRXpPcEFqQjdSY2g2dW8wenYxbllVZXBxZW5lbEtJ?=
 =?utf-8?B?eDFJdThnMWRCTVhhK1NHb3d3dGV2dnZ6eTE5UFBIZFRodFZWWEtxU296VEdE?=
 =?utf-8?B?dUsrWmhYbFo2a0hRbTEyY1BSMVZaRytHTUdjYzhqVXFnZTNlQ3VUN0thTG10?=
 =?utf-8?Q?nyfuriwEWaIdn21j4TaDWzlI6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedfa6f5-7a3d-4df8-20f9-08da715cf1f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 12:22:04.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi6iUc1lVlzP0SJjeKyY3tK4IYH0IcFmcrCjoH0uCDyDcoMoKcIH0sdwC2ubSYzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:51:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, July 28, 2022 8:00 PM
> > 
> > On Thu, Jul 28, 2022 at 03:06:47AM +0000, Tian, Kevin wrote:
> > 
> > > > Then we don't need this weirdo check in the core iommu code at all.
> > >
> > > and then we could also move group->pasid_array to device->pasid_array
> > > with this approach. Though the end result doesn't change i.e. still only
> > > the singleton group can enable pasid the iommu core can just stick to
> > > the device manner now.
> > 
> > I don't see why, the group is still logically the unit of attachment
> > in the iommu area, and if we have a multi-device group it just means
> > we iterate over all the devices in the group when doing pasid set, no
> > different than a RID.
> 
> Probably I overthought about this.
> 
> To enable PASID in a multi-device group one prerequisite is to reserve
> P2P ranges of the group in the related address space (let's assume 
> there is a way to do that reservation).

No, that isn't the requirement - the only requirement is that every TLP
marked with a PASID is routed to the host bridge and only the host
bridge.

ACS achieves this universally, that is what it means in PCI.

We should not even think about supporting PASID in environments where
there is address routing present because it will never work properly
(eg SVA is a complete no-go)

> But for a group created due to RID mess e.g. PCI bridge the PASID table
> has to be shared by the entire group. 

A legacy PCI bridge will be without ACS so it already fails the ACS
test. No issue.

The RID issue is that we can't reliably tell the source apart in a
group - so all the RIDs in a group have to be considered as the same
RID, and mapped to the same PASID table.

But that is the only restriction of a group we have left, because the
'iommu doesn't isolate all traffic' restriction is defined not to
exist if PASID is supported.

> So yes, from this angle leaving one table per group is a simpler
> thing to do, especially when it's unclear whether there is real
> demand to enable PASID for multi-device group. 😊

Except it is confusing, complicated and unnecessary. Treating PASID of
multi-device groups the same as everything else is logically simple.

Jason
