Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADB599556
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbiHSGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiHSGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:24:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A15C6FFC;
        Thu, 18 Aug 2022 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660890257; x=1692426257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TXHYuzrq5M3f5qMLGmd88G2MPPM/39L+ScCEmD1LJ0U=;
  b=nl6HMV7p/6sl/7qtTxVDDW6qpkZLWfQFB3bPPeFB5gIvK3EJV71c+9pW
   wBZ9DBz1AynCc6P+d5S1AHidWcpY6+rbV6VhoRRmzbO9DnwvKAYg+iqQX
   cyw9AeR15Kx0XDS9Vgh037XuKwt2pRNkl5xJEiDWAN4nK+ACOyE86agfS
   q6cXgCiGeFb8rcP95XN3wPEch2meQdhZ2lKp54h2K+YDo+ZlxDqs7Z8F8
   udGyJn5aV78FHdwt/9o8m+2trdcj8X5CA3QI2fYrvejAkWz7ca/y0BNpg
   9y5+/lwZ66B+FljW0JZeS9NVprme+sxeukdGE4tHukSTfxYShyLtnmtAU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="356932660"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="356932660"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 23:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558831798"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 23:24:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 18 Aug 2022 23:24:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 23:24:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 23:24:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 23:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYtpEiQNVGHa6V8s0X2BMPw89MPvmJMWz5Na1fNVyhhaYljbvX0TiP9iA6ZqD5v/i5gB6T4GBXHPn0iGvCMOc0BCZWAQ1rsYBBAoaHf+wv9KxnHdqauP1VKy/ksIhj+M+J9L9cX55UCqgPvZXqbA3jUIsxxtJjwTXOKPz2w4OmM6uVRjAAHNrwAtfkWgi1OzOsxnCHj9NzXeEcnqBG/+wXbor+I7aSuVLYTFN1MipwqQvyjrG7zkDrZtmmV1dcfR+xIH/FjJPH8TFbUjFHX1FRNK51nuOtybq+weNeVOF+SZi/fjqnUxgfEh+EeClYqCwZ/WE+9hQrhp1ZXjaKPutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/OqUX3NfCoKTu+whozAqOIgr+61JAW3MNEKk3CiMMo=;
 b=OXEyWfeQd6660fw3FCr1FDgBqX/Wk994595UVjWmY9wSVzTcf/bzQqNgV4C5uA1V0upXwkUtQJ8qXyOOSOrf4+g2aVDhQELn2gG4G3VkCrvKbeha1p2UiVIWeTe/TsN1RKMeAXNN2vWcup0koH6n8H2Xyrq0afE9VcGefdJuEn29RBIEUFUetrfNyi6aEYsEA43kSP4YJNanYeTnvwOnVBiJKTx4OzBBGmrW7qZXXMjhFcXEaWroHlvMBUGjmSknTHZoYdzeZ4Tk4Huj8bTxy6DJOoFBIzlzK9wp3J4WvdLxcJ4yUBZs27cihI/FmCghySbZXVlpa6CeOlMtz0UpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 06:24:14 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 06:24:14 +0000
Date:   Fri, 19 Aug 2022 14:24:03 +0800
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
Message-ID: <Yv8sg3J8PLD56osY@xsang-OptiPlex-9020>
References: <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
 <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
 <Yv2euLFLjl8bEaeI@xsang-OptiPlex-9020>
 <d1b1d434-059d-4d76-5fc6-092ab9ba6e16@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1b1d434-059d-4d76-5fc6-092ab9ba6e16@huawei.com>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83fe48e-bb02-4e08-b961-08da81ab6f81
X-MS-TrafficTypeDiagnostic: SA2PR11MB5115:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBkS1F+szl4JhynU1Z8G++So/xkDpN+mLwUm2gZOza3zdyIJTaN3j+e6I/6yHuYYQcHi5Qyl6YZ2BSmnO2kDICamy27u7lDgxnyprS0RK/aU1A7dEJL4Z6RQri3p4W50d8sKR7HrXjT/uBnznREv2i+oZFu/PeNx/5rLMI+Ge5xYGhPbGmK6Q7yJiYct/hmbwkBv5vTTS8Yfpqfrrt1WbsjtI8TN4txYpmavSWBEFr3qWndpoNLVbW4jklQ5IEqxC6F6/ZEEylggRFk+TZ8L29ze5Q64jVIMoKHb+UTYmbpEovfGCAOkFvCzia7KkQBYZHS3ISq0vT3BUMUg8aemkp75UmJcKq+//y0kpcAfQA8KCSOZ7wqeVp56H5Bi3lnzu9bjHvrKftOPrigX4w7E1rd/FqbTTG00PaI4bac3J1/lffYI+W7MxjK0tYx2mZUdkQuXaRRb/DjOfEe16HhKV1fc1Bw7hlEzHPk/OtzRvlGiibA+wKejwrdxKRstcmpEQ4TTUp1UFOA75qegQvzTbLqXdLLkSSW+CsSL6RVDywBYLb1kcDxDS8w2YNNExHiV3Ygo2O4tKduFLdj1P4rW1Yp0vv+YrMTOdoYS9FfBvCd3c5j1U4RcUwIyAZ9WA9Mc9QeGnzWzvwc04WgpEKTDhjX/f9JWOuQ/NguhOqkHn4xRgCklbynQ/HWi8eJucEu+tRpOdTu/1fAB7n0VY2Up4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(86362001)(38100700002)(186003)(5660300002)(8936002)(83380400001)(4326008)(66556008)(66476007)(8676002)(66946007)(33716001)(2906002)(82960400001)(4744005)(44832011)(41300700001)(478600001)(6486002)(26005)(6512007)(6506007)(53546011)(9686003)(6666004)(316002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/FcUlYpGDMPVSmuwSGwQc6QVZUweWBjJhVm45H6qVqB6p07jItBio9ZTsTy?=
 =?us-ascii?Q?x0z/uVkGa2xGTwGh1yxL/msiSOCy5cs8kBUjeOcsqqlmH2VPRx2A4PY0ylHk?=
 =?us-ascii?Q?cnO9zxjOZR3DZbixj7MHzLUk/E2qEh1ee+WCBU3kS1W4wlKGNBoAn6gZQrAn?=
 =?us-ascii?Q?TOxtPZS2uz/hPoZ8H6DQ+jPjutHTzS04or4POGWvK/LEHW69pb1yDtz4h+gK?=
 =?us-ascii?Q?n6yvHA6vZIX7Y7JUQjNL8VpWwxz86MZYnWU98Uiv3aDnLMaIFGU54iXRtO1z?=
 =?us-ascii?Q?pIOhokF3bxlCijJ0R+X6ZOze+ItB7p6zpjjWLFUhcNdU3w2w2HNKQhhuj5WX?=
 =?us-ascii?Q?fxCTyWGaQbUtGnhZvNFNk7337xbFvTFIX236U/FzWHKTboDkqXJ+H/d/F2Wl?=
 =?us-ascii?Q?P6rUma7AuVWhl+/5ksMv0BDkLt6tRhmj+b55JmSGf1UjHD/0Z4Q6Cn/mkWI7?=
 =?us-ascii?Q?0iWmn9+Vs4Vn4R/yImtz/U6R0Xsz5dDPquLJoZoBtunaHMvFSVdLrhJ0Wgwo?=
 =?us-ascii?Q?nwG3B2EqDUIi/Kc3z0dUwOlLuO1JNwB4thxzzNTD1kJJtFD0eQkhzvJDkhVh?=
 =?us-ascii?Q?c7IxFK8CTHzGwiF27w8jHk7ynLukIA3OQocFxoGklZdUGPFQMn9bt0OOBAXT?=
 =?us-ascii?Q?5yQzclPdYXv4KUcHxxJVeuZk6U3jJZjCflr2qZB7TSfv0fmNDsChv4Gn05fZ?=
 =?us-ascii?Q?7Afr+ajDh8yFEdokxZCMDkqJyZvFpps3FszUFKrVqEOXHsnWLK+efvZTI7jl?=
 =?us-ascii?Q?UvM3NyBGl7rimXlMGLCsiF3WH4gED+NCmzgO5rVjLj7ZuHmswc7Ph8byEU7K?=
 =?us-ascii?Q?f2CshcgQtpUvH35DLY0yO1HfMk1n+lHWhjg8f3ONEICYwLpfXj0quP1ZIoCs?=
 =?us-ascii?Q?tXOS4rhO6Y4IKng1qOZ4ffwo0rZMoTTxmiFpYXVy5hqBZxszyb5lirzbuOWg?=
 =?us-ascii?Q?d0TfrEZgCBUVmdBiVhFI8CYYYZ5O2vGA/rHHW/dRg3EGjcEv1x7z18/zT0l6?=
 =?us-ascii?Q?P43/Thnh1scSRkMgwSfcyD5wUdUHLPS6jF4GlPn+aTSihaLXmuOIgbgUOYHE?=
 =?us-ascii?Q?/cnUNXrg5AwmR+rM+38Fg97jy/oRxx8zoK/5xfCLSqyAaOu5OW8UqWvsDzUA?=
 =?us-ascii?Q?MPwXdlZOVm2AspJsdTCwyTTKpjuSvTOI9io4TFNyxS2zZaPw1Obo1PClPLgT?=
 =?us-ascii?Q?81VXI+/5sMuyBA9TkDeJSONmifS2Zgibt/hBxgpKhnMeed5VZvrXI12+Kr/e?=
 =?us-ascii?Q?byg8sa7ZnPlWIiFdnbBNb1YccpelWrGPoutgMhwVwanefrCFSO3aaEkL+zT1?=
 =?us-ascii?Q?xjbqkjHJWDFRtlPvcOBnHynVETBE0Qv+34PVCGT6xPYmcE3ABa/d99gLuMLj?=
 =?us-ascii?Q?SH58UJJFpcScZQsUkgpH4ttM5FZmf5W3x0NxiT1cAYiscaeHhGo4G5o8nkz7?=
 =?us-ascii?Q?TRO6NnFdmvJbLVAPpM0/ADhJ7vWmAszrOtJRHKW4iLyDm7g0PoUFicamniFU?=
 =?us-ascii?Q?2iVGXDmZP+XCKlo7d/teYYyHH6ARMCpbMC+ivWWY6g2fbD/LTwHJt+dhkFmh?=
 =?us-ascii?Q?H27g/8CR3NbaHCagi3k9qrHlUQVL1DllElUNTHhFdRCaiPDC/qnljupP8DaC?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d83fe48e-bb02-4e08-b961-08da81ab6f81
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 06:24:13.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+RvRyR92OD1QnD03dFmu9MCqq1pQ9EkCxGGc5AsMPO3AkvaI3u0aSjv1ktuf2sZPoXWpzkf0Y5IZXeu6W+e4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:28:30AM +0100, John Garry wrote:
> On 18/08/2022 03:06, Oliver Sang wrote:
> 
> Hi Oliver,
> 
> > > > did I do the right thing?
> > > Sorry but I was not really interested in 4cbfca5f77 and I see where that
> > > build error is coming, but don't be concerned with it. However, for
> > > avoidance of doubt, if you have results for vanilla v6.0-rc1 then that would
> > > be appreciated.
> > for v6.0-rc1, it's still 512/512
> > 
> > > I will also send a separate patch for testing if you don't mind.
> > sure! we are very glad that we could help.
> 
> As you probably saw, I sent "[RFT PATCH] ata: libata: Set __ATA_BASE_SHT
> max_sectors" for testing on top of v6.0-rc1, and I hope that then we can get
> same performance as v5.19

yeah, our test confirmed your expectation:

stress-ng.copy-file.ops_per_sec
v5.19                 - 26.85
v6.0-rc1              - 23.03
v6.0-rc1 + your patch - 26.94

> 
> Thanks,
> John
