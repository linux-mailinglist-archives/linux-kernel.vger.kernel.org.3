Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B1597B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbiHRCHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiHRCHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:07:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635795E4D;
        Wed, 17 Aug 2022 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660788439; x=1692324439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lso6a7RcNsvPp0hQminowiDXudxpCiAjd7SzPHe4j8U=;
  b=eKaQs211gHj9RhsGcx6o5KOoQxvMCXrszzGw2cqp0g3PkD2ns8gNbivd
   79B0caF0fD9q3sSxqyR1QPh0o/ezGX/QzUt337F8H4r72jfY7Vizmye3+
   +EasLouZ83laIevzeysFJNTrt2sZDiKfFPvS0qm7ZXLP6ZRJVhi+ekaWV
   heGiIRJ5ZFPe98D/b/Ly5zi+wIDkpM/wfM6/6c1C859rFfp30pMJ3rRO/
   L7pHGKTwa5kHniiswN8lO4sJprq3DK/LQU+eknrscKDR1Z3Rw8R2nz1aU
   CCCyqrmQRH6c3C6D/u7Xj9ZYvEBDNS8YtUmw0vmYo2jBBc/qj8jLacfZt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275695391"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="275695391"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="675877557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 19:07:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 19:07:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 19:07:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 19:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izlovkPKthwr57LlGehbThphM0kPjVtIGwzkZRLaSLGujAJL3gKVi5yGf6XQjv10xr/j8bbJBi6tmgLjFr+v3nNkv+n/1T2jE1gBElY68hq0NUZoIPnGIa4N8xAPcOF4Tkw4fl6IzPHRNvsdA1VsH63PBb6disxZwTiN8EVO80b1wpuPo1nctQeKps1tRNPIQHC8PWIVy4lqbgseMXtTWBSZWP6lLLUjSkIrUu1XhOoMfJ7Q22dJ8H1rVoKOqJxTiXzj8wvqQqbsmZNeZi+ruHYUkvm+kSnpVBRCiL0gmb+24f38sQqvV+rQvFdBeR1qnv9KsnZ9kIJ5QnOXD0uk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRjyBom7dNJvhJ0eJtzHTHn8qlRDjoEy6EqAotTvQEE=;
 b=merkbzR1guRBW/RzrtBeZl85lYuQ2opywVuAbATti893zF/WboJYP7NYqd5XqY9ZRedi+J8htdoUxQ2gMTawaXt6cXKXrcDDEtG9F29yEmqqmof4G1neq7gfBMR2GKwmUjt+JhV9ap8d51g0BJYzXtthW4kaUxX5yaEQLYPKP2teSRGjiSB7n8hHweoLqJXcx/OK7pT/vIBObUdqz8ZKSzwIiTY9flT2tVf/lQEFgu1q3TavRab38MPs3FsJq6S5sP1u81JTMxe579pYFjFq7uxhpbkkAr8KNWvv/J/6kSva8j8PZxusDRYBHEXIqeRs56mNReBUg1xH38txip/Oow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by BN7PR11MB2850.namprd11.prod.outlook.com (2603:10b6:406:b3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 02:07:00 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%9]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 02:06:59 +0000
Date:   Thu, 18 Aug 2022 10:06:48 +0800
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
Message-ID: <Yv2euLFLjl8bEaeI@xsang-OptiPlex-9020>
References: <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
 <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8dcf8a8-1ca5-4c6f-e485-08da80be555e
X-MS-TrafficTypeDiagnostic: BN7PR11MB2850:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlIX5c0hs7TYmQfMN4/UN14bxVnCgFWGtdKN2/iuDLtW+Dg5qvKP14cDgrWpS462zJYPsySB5psY2HsqoptKnZepJN2uxSenIp9lC5ExJvMQ1lKeYN1IG3cEyaoHLj/YX2Wz7K15GSh5wY7rQnOh7TbvQbLhgJII1iF90u2DFsNJtdeKAvYBZPORnJ+Fc8zDVibE2Tfc/0YzVP2NL7UZepbzTe386L7CiT68wVHFs09nRt+lzGZ41F0lM47BxCpuMoL2EG62V1VATMUo2MV0t5NdGvIuPTSzgjVPHiZkGs5c53/TDIilFxFalyn/m4TnRKlX6/0bVm5x/+qXoiEnItekmkI95cu6uTj3zz6FdGKbOb48YfC7WH9F1Mlja3n2RWESJzaWA3R3zgvkC5CPTtIFrFP5vQLKyRxJxM3EeYp1ZYEkwZPs2ZHw31VsQTuFs3LfTACOsPpMSuTKz9KOggc+irumtxr5xb65OoZv7cxUC+GjlQBVMqEvLD0zGWQGPxlPmKHqfHXB2uCxPLVrjUtI+1EVGhPbsFrkqR3pSUp3Cf+vHC6YNgN7OOlIl88MVIG7hXQ6e84sNIQ1yabnqXyyvjiWBTQ0h7S0geO0T7NFTg+SXr9TQQYhMlt/RkWevpoY2J5TU9S/b1QhRvBy/6ZHVGYLP155LboRU6db0QPfk+CmrivqiFdUkZd//dDwjENuoFC1nZ7wFiSu1o3WrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(366004)(346002)(136003)(6916009)(5660300002)(54906003)(9686003)(6512007)(82960400001)(26005)(8936002)(83380400001)(186003)(8676002)(4326008)(66476007)(66556008)(316002)(38100700002)(86362001)(6666004)(2906002)(478600001)(66946007)(6486002)(53546011)(41300700001)(33716001)(44832011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17O2OJJEDVQ/dDQU6/kWtSLRnzSo7QdzIY3C1bRFdiKsLMMojeJraX+y5Sz4?=
 =?us-ascii?Q?sWGnhYkAbvkc5SB3zsL9bkKLi5aBlyePnXRNvXL+CBtw0FPZlbeC9MoQ70+X?=
 =?us-ascii?Q?GfcYg/92aNhGtwT3iQVYSx/NwPaJ9bwuO3rtI8N5PqNx+4doK40j+YJn73P+?=
 =?us-ascii?Q?qZ/KIhcnC3nmd0Zt/WwhJsZmUjBg96tmK5Tz5hi5A96fivakhPaKzs69F7cH?=
 =?us-ascii?Q?VGs0MH/5J1a8C2C6Og63OGtnae0DiOvt4P2Nz42dxGPPGsmHCNqElXTYeg8x?=
 =?us-ascii?Q?rmFY4KXGG937mXsYKlq588gQOnGXd1/ZncOTCkXYt1zDIbhRAThBRez929Oj?=
 =?us-ascii?Q?5rN9OcQJvD7JXxdCTZlyUxC9xu9vERdeNDGJdFZksUF0u7KGNawUtLjUDimf?=
 =?us-ascii?Q?KFx+trUYbzVfkFk7FpIflM0hMqnyUpejq79DQbwtAq0jsFpCOeGsA6dEXD5f?=
 =?us-ascii?Q?AdItdHD5HLEOHdVx5sEBJaxdFnFIr4xZxz+lsxkiKLqlP9uUx0KXoxBEA6xD?=
 =?us-ascii?Q?rnLpFFbckaXGXTvTGqlEUOTF92LAxzqlsx5vTFPy52Mh0Bo1sOIr6uqqXZlh?=
 =?us-ascii?Q?LYHvYUoFbmCG+InrMjtQhpb+l8jYJHgPfHrjzLKqGVl9GTLxiIKXYKRlt+Pl?=
 =?us-ascii?Q?yjBxEXS1cB4MxUQIzbMq82TI1WXIqxEoFZ3cBuf2pm/yNCwyHPa7JaxPnCTV?=
 =?us-ascii?Q?FhR1QRj5jicxdPMMQ9ZC9JncD1k90okXg7ahh8UUfAT+aBn+BBEm3ArYZXXL?=
 =?us-ascii?Q?C/fLreNVzHxORoLYkTHFJNuJ4h3hWrCv1dBNvlxlc82gGQOd44740DdGNGXF?=
 =?us-ascii?Q?DCOzlWsIVsmVkl+G7kDOQovsUbebpQkSRT5MAL1eUfAtFMeUeq2Necor5hMe?=
 =?us-ascii?Q?xFjVj/8lyXmCmzCWQXIv+6DyuMQGt9+TiVO8zGfsbxeKxXmL2xjdkUZuhrQP?=
 =?us-ascii?Q?vMokhd2i07/vnTXwR3V61LbUlEAk1M50vDvvEctBp2Spcc7bF9FXni8biezW?=
 =?us-ascii?Q?fRfT6KGZbEAUFoRhCdsuOsAKO1UGvUBRhlvHTE0hwnaQe6oq1aSugzkX7f9p?=
 =?us-ascii?Q?Osx0Lf+dBQjW0aarJC9DHMQ7cXff9YGdmnOeLnJ2C5GbLD+OHEn/KFKgYF6t?=
 =?us-ascii?Q?KNRLJ6P5UUoHo/nMwHDGv/VVrId2csLpaHtuHat/iW26v9IP9rhXsz+aN0eZ?=
 =?us-ascii?Q?1PsA4ALSdG4vcgRLNZaeUJoRC3cUYcaIt275lUNByVA7uBVoM+NeCkFm8g9u?=
 =?us-ascii?Q?yElZ3KXCk3Hul9C5a1yixrEEsbk5DRE7jUZbF3qfzimNCVflBX9LcjLqAdzM?=
 =?us-ascii?Q?2ApoEiWhpkQGXNey9pOsb9B83QsNKAAo+Beoywmi8zhHExcR6cQCNwIxfHVw?=
 =?us-ascii?Q?BqzfYcxrCOpBdX2pSz6OKtGhjyac+45g0j4C/QrPJF6ww8aBhS26gRC90U/P?=
 =?us-ascii?Q?RBKmabXgk+0kkyaHJI1CmE/2VrysIm6w/ns/mwoe4yHtiF9ZkMN7nZDCwdYN?=
 =?us-ascii?Q?gOLvO8LFwfVQP7F3PvPCmS4Q05g25QAcIg5bkv7ZWJT43FGx+qiS0a7K5pEX?=
 =?us-ascii?Q?L5uMWPMbotlOxMtC/Bp7aQnhhIKNA+JL5H+rdF2G/ty0QNQP8PFB+yIo+m1Q?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dcf8a8-1ca5-4c6f-e485-08da80be555e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 02:06:59.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l9QAcRYrj5LZQPCyij2MeANGfKgPjz7uvh0+lUxG9uFBPjP1CvR0ORQThJqD4FjvW9NTLxqxqt4f9EigAXTtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi John,

On Wed, Aug 17, 2022 at 03:04:06PM +0100, John Garry wrote:
> On 17/08/2022 14:51, Oliver Sang wrote:
> 
> Hi Oliver,
> 
> > > v5.19 + 0568e61225 : 512/512
> > > v5.19 + 0568e61225 + 4cbfca5f77 : 512/512
> > > v5.19: 1280/32767
> > > 
> > > They are want makes sense to me, at least.
> > > 
> > > Oliver, can you confirm this? Thanks!
> > I confirm below two:
> > v5.19 + 0568e61225 : 512/512
> > v5.19: 1280/32767 (as last already reported)
> 
> ack
> 
> > 
> > but below failed to build:
> > v5.19 + 0568e61225 + 4cbfca5f77
> > 
> > build_errors:
> >    - "drivers/scsi/scsi_transport_sas.c:242:33: error: implicit declaration of function 'dma_opt_mapping_size'; did you mean 'dma_max_mapping_size'? [-Werror=implicit-function-declaration]"
> >    - "drivers/scsi/scsi_transport_sas.c:241:24: error: 'struct Scsi_Host' has no member named 'opt_sectors'; did you mean 'max_sectors'?"
> > 
> > not sure if I understand this correctly?
> > for this, I just cherry-pick 0568e61225 upon v5.19,
> > then cherry-pick 4cbfca5f77 again.
> > so my branch looks like:
> > 
> > a11d8b97c3ecb8 v5.19 + 0568e61225 + 4cbfca5f77
> > 1b59440cf71f99 v5.19 + 0568e61225
> > 3d7cb6b04c3f31 (tag: v5.19,
> > 
> > did I do the right thing?
> 
> Sorry but I was not really interested in 4cbfca5f77 and I see where that
> build error is coming, but don't be concerned with it. However, for
> avoidance of doubt, if you have results for vanilla v6.0-rc1 then that would
> be appreciated.

for v6.0-rc1, it's still 512/512

> 
> I will also send a separate patch for testing if you don't mind.

sure! we are very glad that we could help.

> 
> thanks,
> John
> 
