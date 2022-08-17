Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA125597035
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiHQNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHQNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:51:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F38E99D;
        Wed, 17 Aug 2022 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660744311; x=1692280311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WU7eX6e3UJ/hqQkHWXZsv9Mjil/XhKvPXBu6YGKbrGg=;
  b=BXJo5i7Ilf/R8Df9ymYxGhXLzfL3cxpFGy7S/srY4EfnjN0RW3w9Sy9G
   8oo32LvnQYh5ToGlBMCN9dL1iOjCO49LvDn5FYgy4YH7DrGVTzguirOAU
   YvjLlk5a6x6mPdAQuvjC5rIsKlxZumSMXcA04SDHaNhh8kvyt66YcjQ+L
   aSJfNawEsvV1dgoRcniYhesakZGfoxleL10cYCDxP6XzHIAnFstnXSggL
   W61UyHH42esf9Hc+LLG2xbdaf+HZZvM0/79HWZE7bvGexLEwx2FDsRYUC
   Fe8UhkU7w30416ik4dyarBkKlU5rrYiqHFepgKdDfkNrsmKIZd5axgOBo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293771902"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="293771902"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="935363183"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 06:51:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 06:51:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 06:51:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 06:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj2uZ0F9mH8Qc3azrZDj7pbrY2paiHxYjnCCbMkK25/Ucc4PFwln/M/Y1iAR9RnocsS/ricJqvkH1SMuuLCkm2hIYsRqlwIPFh2wvy6kohbrDAh67DopGD07zo97HcNsm1avpdl4DaNpACor4ZPt+NEfXANovgIjiO7wMx9ElnGEL2EBr8okNb4u0Iufo8KS7rXlxOhiFk0cCDdQEHRjEzCQ7qk7eIQSm/xnNA9gdzJ8V343rBgl8C6wgwbXLAx+g8+RYfzyaMX3XuDgJcXKlxC25EOJYC284camjCsR0UdQ4DH2JvSYUYVKZMUjaV5aLt1+iXWUoCDCLjaTqZVX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmlATT04zCffZ5pPtrVDW4QnKSnrwlA2PwtDKvlHhwQ=;
 b=POTNshv6gGelQZBoS08KCGHaOStV3AnXB4XU9SVWDpTgiK+bti5S8Vu+cBAnf4cRBzd5pFoc8hldA/FDiDjpEQNqSBzXuQEg+9M03wZvPHnZVZk/tVvyTVJc7Ir0TJBxRUOYkxoWxMvbUmNCuwrS/Tor6R75KyHxwOiR3RqPqn1EgTaQAEmyeZPQxXzHO1siRIsYIbQ33v5JPhbFokIoHAN1C7t84IgStlwkKke9UvKJ8MrJS+ZF64+9a3HUVoLDrQ9SmdM/6MDFgogTMVT8C0W8RIzJNuSyaRG5YTIzY2D2zqx0eRdcNVaMHdGdId8Evhwjd0Fo/UUSQhydxR1J5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by BYAPR11MB3286.namprd11.prod.outlook.com (2603:10b6:a03:79::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 13:51:42 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%9]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 13:51:42 +0000
Date:   Wed, 17 Aug 2022 21:51:32 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     John Garry <john.garry@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Message-ID: <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
References: <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bb3a2d5-2d03-49be-2b8f-08da80579d4d
X-MS-TrafficTypeDiagnostic: BYAPR11MB3286:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALA69c3HGRjtp9j+3UmFKW/APRS0Ygd1Sms+e+gR97cq3it6gtyQpsXxMJ/r5PG8Tbj5WIEjvLkzOSyeP0UOvbraBvZQYvNbbzO9/VwEMI02P3ET26arMdMyPzZeEv3L1aKXVrcmWTPrEjZBwf1DiusnzzVmBIUDj7w0/Qk6RupRh2Hce1iltPi/U2Hw3urkK7jLmarTFSL4OddjSk+lskUhzUr85Asyn3FTmxe2Lpp3vA09jisJSJYTqwbcR4iScvGKFwLfgHEJV2VE/RTbdX8mEnLA5osyDkDp8WBnLc5ADoY7BTjg8TvrsHUEA2v1GZuK52zvOJMBbnQt7GtjNCa1GUcLOt2dZrwJ8fSzMju15Uc0+2+NMPInJDBpCp0KOjsbDsh/Hxa7SerNIvRw7S+h4E6Zc8XBcv48Ff855cRvDbvO303fAx6ZwSaKOV+h6QdjKUm70tcsgdWBZDFzkpRUCxq/FmJCVVvB228nqCkzIvCBGrJmoI17cNweNz8i6ow4FTNSpg+ZKyh+ahLKyUEdObBhtdzN+FeZjcnXkZPlJMQr/+jioODa4EnLZxYXta6kl5wgFICmaxCNbX494K01bgU47TBuJmEVW+ANxGFCo4vm27Su0Uct3TWvdLTRuvo/CpiCukwp80BNru1zAITvToIXmUVHVE8pMEH32kDNpIxbbEiwImQIoCucfvy7sbW8iSPX1k2aypnMfr/XaIEoPJnCeVqTV6GpF4Tl0rv8ZtH4DESUBzrhUIjsWhl4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(2906002)(8936002)(5660300002)(33716001)(44832011)(86362001)(26005)(66476007)(41300700001)(186003)(6666004)(9686003)(6506007)(6512007)(82960400001)(6916009)(478600001)(83380400001)(53546011)(38100700002)(316002)(8676002)(66556008)(4326008)(54906003)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXPl3MJ2nOkxTmE9PE4/LIF4Aoe61LGpsP9JN6zIYfnTwA5Y3wHicvAgMVsl?=
 =?us-ascii?Q?I9cXFhjWxIoxuW30vC8owSLDGpd6WIZ878yUHuidBjbbfObCoqSVvETxOqCy?=
 =?us-ascii?Q?UyDGRkzreZfEyVEmxnEw2CG/wnDW32VCsBhSKOT7osGBZWdwXCgGxZxbZ0sb?=
 =?us-ascii?Q?UKS3vePmsaoXcg/oG0CjNEdYrYtB3wKJQjN8idKIcfMr34ceH599fRaUt+YU?=
 =?us-ascii?Q?T0KwhC3NAXo270AZMhkxVRUQSdvQ1Uqx85nLhJxTfaOocv78dMJaAqLww8ce?=
 =?us-ascii?Q?gRDdPMazRudVswZIzfs43DmH1sPmYPrS2vAO7J/F9zYZW6c0fNddXOPNmn+T?=
 =?us-ascii?Q?LgQp0J4+OT3t+zYo5PT1KCVGd2a5+trjlqeAv6fDFvgPagq2WkeLMV2o1Say?=
 =?us-ascii?Q?8maP+1UwgqEAVH7DOt+e9IlwErfennKuzBO6mhT4jKnjd8Z8y8srV8wQG5fk?=
 =?us-ascii?Q?4f+ayEXpyTFslz0UV2lT14AHRV69wqjiDxEcnpsXeAz1je0PRy9rnRF3Dhcl?=
 =?us-ascii?Q?J8NmD74hszLdrHy0IYS7PdHtTBnMQHl3Qtg8Y/AgE9AA0aK4TG/XEGRBnQdc?=
 =?us-ascii?Q?ncJ4RxwL5VFGMdNIAreat7MxAx1gMERfVvqyiikNrVOIGHKQXYsEhkv91X60?=
 =?us-ascii?Q?61FONphOtKAy3YRJU9Qqa8ZX/ildOxQhqM7qNksdT193TWTEX2SOBVDEDxKE?=
 =?us-ascii?Q?UgdZoAXbP/q7MxKJMfjFJkyAkeyUlAwqDiM336Mj/VMAJS5uP1TAHKpTYfnz?=
 =?us-ascii?Q?+Io+SpqAZHQOjlS9VCUFL4SUHfdgzHhBp9pBzF+kjCyqtDIgCckUzFGvreSg?=
 =?us-ascii?Q?0e6xXWQWjTGt8Z6v6iADqeXoJHt27orqWSwz4BFO1vTKO4HBcFqwHkjZUGGG?=
 =?us-ascii?Q?bHB5hOBru3kzCuI8NEVCdRKvJenr/orYGnxcXZtUcXFaoMhacQG5DGU0oM23?=
 =?us-ascii?Q?lTs6VtFoI3Mk+yWm71UCCO24hLP0M0MRgSurF8xenGqvWWzI9zA4+w2hac0z?=
 =?us-ascii?Q?nBO2hThF4yq60Gd+ZyY6vLKIQWz1dj0FLwD1RZVScqskTzE3yHPYkwFgurNf?=
 =?us-ascii?Q?vTwZUkphpOTkacr8VfiGW4tkYsgYU9BCCue05y90xt7Y/q1famupTRvmF7nQ?=
 =?us-ascii?Q?OeYzY2yZaOVpP2EGBBG+dC4EUuQu9zpKox0E7dLw18FAeJ/GJGOYp6qcGn6i?=
 =?us-ascii?Q?w/om95XZDfQ91JVHKO8MsV52O0qIpPuYqpwBi4AEmRN8ss/eY+jNOdK0Z/Gh?=
 =?us-ascii?Q?DLpRqWat65GI1itZngkq5UxKSLhftKniCiWkOUeS2YZuktRQ0J54ij69iIyl?=
 =?us-ascii?Q?L+0r2N2RW15pcBxogOaAmCQ9jjcpUuw7dFaLS88sfGDCfNWaplzpS8JnatQr?=
 =?us-ascii?Q?OwaMZHoC8MdaMWwB9VnmeZMVt+dYLvyTwJkdFcjouD4ZS4c8lK1g3Eg8JL7O?=
 =?us-ascii?Q?+a0gCMjsJVsj1IdyPbJqhhtmm2Q6Y+CDJ8pN4COw5FmiPmbq7W88Q209uerG?=
 =?us-ascii?Q?sN1U7kAiNt7oW7a/ATRbvTUy0fO3a/J2yJSerzYwIrrOm/RRfiK7/1KP8hw9?=
 =?us-ascii?Q?DEwadgNrKW87vJLb47iO0r3yiVFkUS1nEq1k4TB1fxjcn1uiX+T5ZYqz/+1Q?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb3a2d5-2d03-49be-2b8f-08da80579d4d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 13:51:41.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0weT8HtcTNtvPkHniuU5PSbCluEfE0BAOqYsYMoA+JwF971B+4sPRDe4Nrb3qTCGIaoScIT6uFSCD5tD6Ovnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3286
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi John,

On Tue, Aug 16, 2022 at 05:38:43PM +0100, John Garry wrote:
> On 16/08/2022 16:42, Damien Le Moal wrote:
> > On 2022/08/16 3:35, John Garry wrote:
> > > On 16/08/2022 07:57, Oliver Sang wrote:
> > > > > > For me, a complete kernel log may help.
> > > > > and since only 1HDD, the output of the following would be helpful:
> > > > > 
> > > > > /sys/block/sda/queue/max_sectors_kb
> > > > > /sys/block/sda/queue/max_hw_sectors_kb
> > > > > 
> > > > > And for 5.19, if possible.
> > > > for commit
> > > > 0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
> > > > 
> > > > root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
> > > > 512
> > > > root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
> > > > 512
> > > > 
> > > > for both commit
> > > > 4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
> > > > and v5.19
> > > > 
> > > > root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
> > > > 1280
> > > > root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
> > > > 32767
> > > > 
> > > 
> > > thanks, I appreciate this.
> > > 
> > >   From the dmesg, I see 2x SATA disks - I was under the impression that
> > > the system only has 1x.
> > > 
> > > Anyway, both drives show LBA48, which means the large max hw sectors at
> > > 32767KB:
> > > [   31.129629][ T1146] ata6.00: 1562824368 sectors, multi 1: LBA48 NCQ
> > > (depth 32)
> > > 
> > > So this is what I suspected: we are capped from the default shost max
> > > sectors (1024 sectors).
> > > 
> > > This seems like the simplest fix for you:
> > > 
> > > --- a/include/linux/libata.h
> > > +++ b/include/linux/libata.h
> > > @@ -1382,7 +1382,8 @@ extern const struct attribute_group
> > > *ata_common_sdev_groups[];
> > >          .proc_name              = drv_name,                     \
> > >          .slave_destroy          = ata_scsi_slave_destroy,       \
> > >          .bios_param             = ata_std_bios_param,           \
> > > -       .unlock_native_capacity = ata_scsi_unlock_native_capacity
> > > +       .unlock_native_capacity = ata_scsi_unlock_native_capacity,\
> > > +       .max_sectors = ATA_MAX_SECTORS_LBA48
> > 
> > This is crazy large (65535 x 512 B sectors) and never result in that being
> > exposed as the actual max_sectors_kb since other limits will apply first
> > (mapping size).
> 
> Here is how I read values from above for max_sectors_kb and
> max_hw_sectors_kb:
> 
> v5.19 + 0568e61225 : 512/512
> v5.19 + 0568e61225 + 4cbfca5f77 : 512/512
> v5.19: 1280/32767
> 
> They are want makes sense to me, at least.
> 
> Oliver, can you confirm this? Thanks!

I confirm below two:
v5.19 + 0568e61225 : 512/512
v5.19: 1280/32767 (as last already reported)

but below failed to build:
v5.19 + 0568e61225 + 4cbfca5f77

build_errors:
  - "drivers/scsi/scsi_transport_sas.c:242:33: error: implicit declaration of function 'dma_opt_mapping_size'; did you mean 'dma_max_mapping_size'? [-Werror=implicit-function-declaration]"
  - "drivers/scsi/scsi_transport_sas.c:241:24: error: 'struct Scsi_Host' has no member named 'opt_sectors'; did you mean 'max_sectors'?"

not sure if I understand this correctly?
for this, I just cherry-pick 0568e61225 upon v5.19,
then cherry-pick 4cbfca5f77 again.
so my branch looks like:

a11d8b97c3ecb8 v5.19 + 0568e61225 + 4cbfca5f77
1b59440cf71f99 v5.19 + 0568e61225
3d7cb6b04c3f31 (tag: v5.19,

did I do the right thing?


> 
> On this basis, it appears that max_hw_sectors_kb is getting capped from scsi
> default @ 1024 sectors by commit 0568e61225. If it were getting capped by
> swiotlb mapping limit then that would give us 512 sectors - this value is
> fixed.
> 
> So for my SHT change proposal I am just trying to revert to previous
> behaviour in 5.19 - make max_hw_sectors_kb crazy big again.
> 
> > 
> > The regression may come not from commands becoming tiny, but from the fact that
> > after the patch, max_sectors_kb is too large,
> 
> I don't think it is, but need confirmation.
> 
> > causing a lot of overhead with
> > qemu swiotlb mapping and slowing down IO processing.
> 
> > 
> > Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
> > default for most scsi disks (including ATA drives). That is normal. But before
> > that, it was 512, which likely better fits qemu swiotlb and does not generate
> 
> Again, I don't think this this is the case. Need confirmation.
> 
> > overhead. So the above fix will not change anything I think...
> 
> 
> Thanks,
> John
