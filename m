Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8B559A78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiFXNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:39:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508F11157;
        Fri, 24 Jun 2022 06:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPJcIudzmy7WuHbPCxv1xjLge1nJ3kASwLwX0LlBhtgFFkHKDquWWm+t2NJ72jAc+GoEPHMN4JDi1SLaTVX+eE2Mi/pMYNVwTbriVMTSKklUiStsZvOFeA2UC9g6Opo/hDpyTX8crspDzYN8tCiCgvFxeLJIcD8y06aAbjSxUam5EjnILc3HX73Ub/U6cIHAABg5uyWGr2U3DwZpe5M6CKvkcW5BEXpHHPjVhVcHFSSnsU13VBlunVe+ZQd4nQtukMjgcxW8OARCZhKYFnr5aAXU+1YMZtRT+CuaP5Seje06kh1HIa7mjHqB1kNEiCeArL8ccyDrbR0QjhZO5qJWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGlYcA07qLgF37l7X+9ZycBJcLp8VxO3IktFM1G+R88=;
 b=L0eoSs3hKbeHxo3AnDijBm6HpprdY65tTyUeupJlK4/Rh3ZhO7GbbElJdu07AzNZJqaqNlSddOIEWh5Do9jMb3PRnJT4ZGf5GbWGsnVo5tDuWxACVS5d9xxmDGn41a0/rQRw36WWJhwDnQWyuVsvXigoMGMs+CrV8KSWyaTis+hjIyNRZb2PLKu302iRALgPRuzUkSRxNFJutl1kkVHk6fObh0NipaRctmJZgjrgXP7JW9onjrox1RsV9upIRAWNG36J419qx8OIEc0P3U26QX2XkjBzm0349m6QFZ0XMpbq5A8CKYGKFfqY/xMA1xPfhRFMUk/YjDG5A5qphVGw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGlYcA07qLgF37l7X+9ZycBJcLp8VxO3IktFM1G+R88=;
 b=hh7rxL723jAu8O3FsFQVtXVvK/3jO18cvGVrTqx8yVn1NS/jJhKpJrr6Kwy516moz95PLbeXOVwULyD2LUA13Yfa9PSDE3evCLAz6NyWHcmLcd0M13C5jQplgY/yZ6MhQNIhQBZL+NRSID8gt7GwV4+idJr07rnPSEqy1CFnOtACoP/07tzuddPga5IJecHMILjeYb+gxgjND2voE+7hHrFzVmO/0KsujEv7YC8v5mldHecD4qhW5pYJXys1lXc3vd5s/xZOyDBxgkH7BaDlQfUbu6qoz3tCruMkd8b2jS33Kr41xaha8quZ+pY9c0kLJrmhpbUbnjOH/5mTI5m6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 13:39:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 13:39:01 +0000
Date:   Fri, 24 Jun 2022 10:39:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <20220624133900.GN4147@nvidia.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
 <20220525182644.GF1343366@nvidia.com>
 <TYWPR01MB9420F74E27D8513CD2C2D27592B09@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB9420F74E27D8513CD2C2D27592B09@TYWPR01MB9420.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0ad465-9239-4653-9e01-08da55e6e5ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB4173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFOWHI+7M3d0wLEPtiJbY/Vo9v2vXiGnPWRbVsZYCdHZ9Aqw+jDAmliiM1epuEEvpmnbBq5yTenLJfaAGMioIrHEOX3s0cXLHqHPhDOsJHTh0aH5R/S8SyCcDXRZuvKAu5Rfv1w7/qKXX8zmRl0x+U9rPq3ueXv6evo73vClsb8AfLszDZZSoPmvqBAK9Gpj+InJTfc87HKMr+/subOyBDcWiK1NT6j3uPNkrnc+KYU2DDofHEUlTP4wpSO17v3FofXx9sXxYp6RJBGdDAu4qVW3W9ufmfweOHzLybnVIwNdqd6N2WWukpIijtGXP9iJedlAWGQc21Mq0sIwiBKmplIi4Zh87EIWqnByb/gdTG7R8Z+2rpn+G/XU8PafESbKK09dTriy26f6Z3HsUGfjpK8f0ILNSaxQnhIdWghMRkslCxyHq2BVC+Skv/MdcAXfz18MH4vmqHCRkWcwXLTgMKd6C7qAwFFpEGAM+QqxKBu9jlRFdX61tjZ4eoLRRdmfXyyKiJwu2qbJPkyfmBQwC83WD9R1J+u6VMmjeWQr34csFEcw0pnQNL07flzPKYqns8UgtT/VB8m2HUcRWk+OR9JWquYn1OdZdwYlXexSOReVJFTZQ2IW/BLQ0o/4qBRbaTisfcEN2D3P1uJiGSKxRGb/Ph4Pv2qlFtGOxFFSt45+czErZydArumrDxXiaGg2b5XCnfDHp0Z0SbbSAL3lnKSRkC0zw4STm6kYT/Z3RUBYi/mn+ndgxqSdRAhfGYB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(83380400001)(316002)(33656002)(478600001)(8676002)(6506007)(34206002)(2616005)(8936002)(6512007)(53546011)(26005)(41300700001)(66946007)(1076003)(186003)(66476007)(4326008)(66556008)(2906002)(5660300002)(38100700002)(36756003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05LUGIrZFZncnJwR1Z1Y1JSK0NvMDc1b1N3YVJBSGpzTUVUVFJBdWVBQ1Jm?=
 =?utf-8?B?bEhUSDFJR25HTUFlelhIOVFULzBRZDBRZzZsUVJoTHRaZFIwa3ZCM0tncWlo?=
 =?utf-8?B?QmczMFN1ZkRkK3ZSaFFRQ09IZi82TkVrbHFhNUpyZVFwUWlCbWxiek5JQVp2?=
 =?utf-8?B?N3pDYTdwY1l1Q3FiWWdmWWE0SEtQUHE3UXR5bEl4MWN2cDV0S1ZGNUVhbHJG?=
 =?utf-8?B?UzB6TTlNUkFubkFyRDR2a29nRUR6T0s4eTJQV0dZUXZpSHJGRDZOc1J1N3p5?=
 =?utf-8?B?QTVMallQZnIxMDB3Rm44dzIvbUs2R09Yd2U2UkRmbXovNG9ZQW9aR1lFakVI?=
 =?utf-8?B?MWthTndkdGlGNXV5OVJJdGZHYnRlVStXWUxDRTBFMzM1Y01ZT292UHdPdTRH?=
 =?utf-8?B?WWRHMVN1Vmg4a3FwZFMxVzVQNEVHZUVTVW82c21LaGZFSWNhK2Fma2VQM1h3?=
 =?utf-8?B?cmNvTWhrTExqN2NYYVk4VVJwUTZFSGlHNC9GVklQQUZiZ1dmS2NheU1Pclk1?=
 =?utf-8?B?LytNVUwzQ0NHSGd2c3ZVOE53ZHZNVk43Q1B6V2k1VWJwVFR4ampkbFMyenJ3?=
 =?utf-8?B?aUF1NzRqWlNFTnliUGFjNUE4VmM4c0VuV00rTVJJOXlRb09Fd28ydHBxQld6?=
 =?utf-8?B?RG13WThxdjd1S2RVT1lHV0lEazNpeGhGM0lINGJiMU5xS2t1Uk5qZzBjYTJj?=
 =?utf-8?B?MDFYWVdER2RGL3p4Wjl3bVE0a1hoRlhLSnI0L3FwV1hnMHlOcWY4d3hLQngx?=
 =?utf-8?B?RFAwN0s0NnZNMUVzS3NLVlpRYU0yNk1sNFUwa3JpYTI0UVl6Rit1WFgwazdE?=
 =?utf-8?B?RkEvSWIzb3VMNUh3ZnUrc3dadmNEdnAvR01OandrL2NhUjNIZzJBZlI5VEJp?=
 =?utf-8?B?TDJOeHIrVTFRaGl2M3Ywak5PdnlDdlhraFlpaWdrSVNsS0dqYStXQzNjT001?=
 =?utf-8?B?ZGkyQzdZRXF4YllzRnk1ZjB2K2dNOFFNTVQ2L2V5SlM3RnlaL2g5Z3BRTml3?=
 =?utf-8?B?bFptajRUVHUrWXJENUtpYmFobFVmWEhYSGdHNUVRQzBCZUVLcHRNVkhpYm9i?=
 =?utf-8?B?WmxtSk1td1VuT0djZDdNWUViT3d2S1NGR1pxRDZHbThCYitkNGxBckxYQTI0?=
 =?utf-8?B?Z2tGdlkyRks5T1JrV0thQ0h6ZGVOeXJHaEpyR3h0Ly9sdXNFY05iczUvUXls?=
 =?utf-8?B?YkpyNFhCVEJNL2pXNHJxcEpYY3RkdnJIajhaMFlPdXFyMm9iaHlNak4wdUNr?=
 =?utf-8?B?OFJPdkd4cmFWVk8ySS9oajNJa1UxTmpPekgvSk1WTVF4WnhVZDU3dEkxUEE3?=
 =?utf-8?B?eDYySXBXeDhVUWd5NUwyNTY4enlHSDF0bTlRQ3pDS0J1WmVKZ1Q4ZFFURXVU?=
 =?utf-8?B?c1VzWDMxejk3N2owTnZrNFh6YVFRYXNSTE00bmJhSDVVQ2hLWjVaUTcyY2t0?=
 =?utf-8?B?VjlsaG52T2xBNU5sZ2huakg3cHVJUGFObVRvdGxCOE0wTmlieTR2QmMvUUFZ?=
 =?utf-8?B?ZjFYMjlCZ1c4M3JLa2VlbFAyd0tzKzYrZ2RmYU1qQmd0SUVSWFc5MXltcFYz?=
 =?utf-8?B?dGlTV0RxdFpFOVJ6bUMwYlk0OUMvemRLRmIzK2lKNzVVUmlmSUZwdGRRb29U?=
 =?utf-8?B?eU4zZ3Y1V3Q2M0N1clQvZnZxeE9zclhlb0g3aWdpRVJDZVpSU3ZFYm41K0hK?=
 =?utf-8?B?RUxDNEg5Q0V5T1p6c1pGVEZKNmlJZm1rdzEybjM5WkdiVUgrZE9QN2lyeU51?=
 =?utf-8?B?ajhMR0hxSmNVQnNjam9kWVl3K250czZZclNHenBPSGZvMTRCSjFCU1hwalpm?=
 =?utf-8?B?S0JuMnJDanZUVi9ZUThwOGVWMWt6TTBidHlPdUZqNE5NcTVKeFNpMkJOQUFh?=
 =?utf-8?B?OTRBN21BZGdIRmF0ZU9RRXNGdXVJN1J2eCtSaDJKa0FSSkxCNnViUHorTXdw?=
 =?utf-8?B?UnZUOXhadDhYM0FUeS9Td0dHdVRjWTczK2U1WUhyc0VRUnRJT2pEenpPN2li?=
 =?utf-8?B?bDlVcXJLZDZEWFFveDRRNGpvdC9KcU5MZzc4Lyt2bjYybEZrYnFjUjFzVnp2?=
 =?utf-8?B?cXpCenNhUjFzZUhiT3pqb1NqY0VWS1NMRDVoSjRjaEdKaFVuNVl5VUg4WEJI?=
 =?utf-8?Q?41NHhE0RXbkl61xxE3Ht+Grww?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0ad465-9239-4653-9e01-08da55e6e5ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 13:39:01.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bILEbS/3yVcqfPlcosz1W5e1w+YmP2yGSRzqXG8pq4JmCe0aJnV0QdiR83iMLTMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 05:49:13AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
> Thanks for your review.
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 26, 2022 3:27 AM
> > To: Baolu Lu <baolu.lu@linux.intel.com>
> > Cc: iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Joerg Roedel <joro@8bytes.org>; Will
> > Deacon <will@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴ
> > Ｃ○ＥＡ開) <yuji2.ishikawa@toshiba.co.jp>;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
> > 
> > On Wed, May 25, 2022 at 02:26:37PM +0800, Baolu Lu wrote:
> > > On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> > > > +static const struct iommu_ops visconti_atu_ops = {
> > > > +	.domain_alloc = visconti_atu_domain_alloc,
> > > > +	.probe_device = visconti_atu_probe_device,
> > > > +	.release_device = visconti_atu_release_device,
> > > > +	.device_group = generic_device_group,
> > > > +	.of_xlate = visconti_atu_of_xlate,
> > > > +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> > > > +	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > > +		.attach_dev = visconti_atu_attach_device,
> > > > +		.detach_dev = visconti_atu_detach_device,
> > >
> > > The detach_dev callback is about to be deprecated. The new drivers
> > > should implement the default domain and blocking domain instead.
> > 
> > Yes please, new drivers need to use default_domains.
> > 
> > It is very strange that visconti_atu_detach_device() does nothing.  It is not
> > required that a domain is fully unmapped before being destructed, I think
> > detach should set ATU_AT_EN to 0.
> 
> I see, I rethink implementation.
> 
> > 
> > What behavior does the HW have when ATU_AT_ENTRY_EN == 0? If DMA is
> > rejected then this driver should have a IOMMU_DOMAIN_BLOCKING and
> > return that from ops->def_domain_type().
> 
> If ATU_AT_ENTRY_EN is 0, nothing happens. It does not work with IOMMU,
> it works with the memory space set in device tree.

So that would be an assignment to DOMAIN_IDENTITY

> > I'm feeling like these "special" drivers need some kind of handshake with their
> > only users because they don't work with things like VFIO..
> 
> Since the devices that utilize this IOMMU function are fixed, I do
> not think that a special handshake is required.  Could you you tell
> me where you thought you needed a handshake?

In this case the iommu driver is so limited that it will not work with
VFIO - it is only ment to be used with the fixed drivers that are
paired with it.

Ideally we'd prevent VFIO from connecting and only allow drivers that
know the limitations of the IOMMU to use the unmanaged domain.

Jason
