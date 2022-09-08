Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D15B11CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIHBHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIHBHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:07:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACEC695F;
        Wed,  7 Sep 2022 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662599258; x=1694135258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GAuPa3vrCp8x0XzQVr45o1CQkbBwpTAKhkb+x6rf7eI=;
  b=Zp2Yv9Dstg3I/SxF7Mo275iLPaDHwR2OwR3Ia6bgeR7c06kCWtysCsDr
   klwj9MfM/o0+2Pzo4nAP7YIcstib8GVdnLJWmJJD50ACuUUbL8Objiku9
   3miLmMDj8nSCSTfOdNtmAaJhqRLj2jobxIVzZgJKccJZNVdtQsLc1o3PA
   KZexQ3p+w5qz7XkZhD/XXoFMXm+ut8obXi78TzLWNmofxsrEdqMapV2Na
   8X4jB502xcKwI/VsZ5/xw23vTxtOfJOCcL7rK3b84tPunnhvk6LKG0zYo
   YCpcgYY1H8eO/K/lgqbM5h+07wvhRqVuMr4xib5vfNmwHdlsoCV9FZ9uF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383328302"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="383328302"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 18:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="565741133"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 18:07:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 18:07:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 18:07:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 18:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcVdhchafDzl1n/WwplvbFYxHM0cHdmfY5ulrRvr15KNbjrm6DaYL8FYtcju3Q0yfPlewbctwBYzYWDSUrbNidrHewU/7O2dBoygxW6o+0ATHgCaG8K77EcbiABFabXW/SdCOrhJGkiyw1pqcfTuIrCNsQcNG9YKHMG7LWisXN08RgSi7f5JSf4Q38NZ8Ul3wTjNk7g/AaTJ5G1b96Sp2EoBeHz1nWZrt583wuRNieM8EqaSprZ9cdJXv98AftFMFpEyz7+jC2JyZRKUgZEV++4Ky5Ad3LHewmuKdmDbKCt308l1unH/Yq5PWVdDGpEyEZGqZMMbXU+STroG0W7PNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y3tNKfRfqXRn+KMQqqmoiPbHlOyC5TVC5DKg4w/mvQ=;
 b=PBztHRNqkSEtFmpHWulATxyORUnAwf1DxOJ6G8B7muQRwgwSrTN377HpyuQkUWp4Rcuol52Mqa40Q1Hklf8gmHQ1M8RpypQiXn4RxxmhOkY0w+u+LM9kQZe1udQBY2Mq+maIJ2WmK1m6g6fkZNK3C9qL6Ie5Jqcn9UPBqDSyP/ByUCobiN3dJ4gHoFMuPti/O7YjObARzLrdyakseobho5WSSzska1uKU8YFBX6sdW/yZubeCvmXumVjGA+vg4GzLPFNn414mhKVkJBxGsTcvSzSYZxRDKmCPZAEm/uLUp+1daE++gPNdkcpPJUf8ockR1SYGqX/SzYze2QtpxU8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4315.namprd11.prod.outlook.com
 (2603:10b6:5:201::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 01:07:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 01:07:34 +0000
Date:   Wed, 7 Sep 2022 18:07:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e88ff95-e3c3-4eb4-ab1d-08da91368315
X-MS-TrafficTypeDiagnostic: DM6PR11MB4315:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMyMxil8ZJvJDxvAUQ1r8+nPhNez4pfxWDprBHDOPTH6VGVi6CnKpYxDX/klTa+j7FzBmxv5bQs2C1MZyELxrbR2JtinhTq4fcsfI4rlftG+eLglLkSHn2lIGxQx8aOkhTxmqwhvVO0AFXMPejH3Wj2wvlaocrowG409A3g7BWKwURHGI5mClErVGj1CtrZED70HH0sNP5dpWHIR4VSM+0trZVmCefmjk5GcdvqwlCDXo+c2AqhSBfQSOOwvAUT4lmKy/n1P7D/8zcQxgEKc7PmAD6hJTcx2ZckGAg0wDS9vls1dgJ2XIpInMSCnyhla6/Bclo65Gx8+oQW91tl5t4MTg3xDJLHxug9xONH8Bwi8Zf6DbkWEBNIK+ubhpYun+0kBztZryR7zOKeQUskXnVtUZHfREwMDio3o1eUA3bAmi4wTV52vXQhnPk7r4IEOyEHSOL6lGmsfvPH48azbG4SCpCuosmgKfsSYDf8pdHicj3xFslbJV/bQGBa++iBeepoH1fZivGQWQ2Htx1arF54gNSWS5bi15PjjeWWuetaz8GsDUjJU+l77vRzCTS0hNfsJHB5HlE5ZdWDu0pksoQLhuvZVWzAe/PNiefOJUQOOBXFoW2wMhrHo5/gPHQR1Ac8hToz46ZgsGxuCun2DIjPdAwfe3keAsDSOPqWoLB2bEnCzU0h7lVc7G86KJrAr7ZI0/iZN+xbpNP1CpktZZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(8936002)(4744005)(5660300002)(7416002)(2906002)(38100700002)(41300700001)(82960400001)(6486002)(6506007)(478600001)(6512007)(6666004)(9686003)(316002)(26005)(110136005)(83380400001)(8676002)(66946007)(66476007)(66556008)(4326008)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oixaxejqYGP6Xfvjww6ZSFsPnYmhFwecMrutr7jMpftnvWPWxUDfaASRGICV?=
 =?us-ascii?Q?TuW2YNGjcK71RhdOkFEPzyI5mQMJzidJS11h3+hXXNOXMYce1KHal10Te86L?=
 =?us-ascii?Q?jqHj8QIrdxTX1jlnJpotsKewHH1uuVNLmGQzQtF3bkwN/Als8lijXm6U1EIO?=
 =?us-ascii?Q?EyGCK3H9LAxhQx+0ws0W+EzeSBb+/GoDgAYsuW0ApT4ULkLAHGukkZWJvfwO?=
 =?us-ascii?Q?kCBfYNUWFzPBCoGQww4js5tebGsUxYGoxSGV4dxER8fxUpRU6bceFyPOS7QD?=
 =?us-ascii?Q?ZZ79A+TTub7ReCc4VvJnMC+TGcw8lBEmQrMgjsCOoE6DUBr9c3oZ13wwjxrX?=
 =?us-ascii?Q?dUvAuyGTiKH03ZKc2u9ElMSKzaaxw0pb6bTun694GwolPrQTxdKInWoK8tYT?=
 =?us-ascii?Q?Y9Qod6H2Eom05LD/+mbDyGbdxcTCgKrPuEMQWv4Z3X2nlVVHL1IEpCy8JTtd?=
 =?us-ascii?Q?al1XTJjrshCMPej6ANw8ymJlwTV8TLopWAfYOHJN4ftiLUV8hKwXJPieh8yh?=
 =?us-ascii?Q?EC11rOnlyClUaBIE0SFNLtc8X0PRHw+vhJ6tUUfh9VoFXET8ZkAI47W3qdAY?=
 =?us-ascii?Q?OQDON0KBdybapc74nW1GSloQMoaWpTS0yYeZyxcBmPuw29ouTi8GShbAbisd?=
 =?us-ascii?Q?siXKKR3O3ZBuAr2y++1VyXvGGDQ5RKkn4Qdaedyxn+2Em0JF/4STsv7f4zUb?=
 =?us-ascii?Q?6SvCjVrVT7rfREuEO5uWfFUKjRlNTw9Vgla3G5XO7RNnY3BH3k89opikklIR?=
 =?us-ascii?Q?8xOmyAFM/UYxjw8pAhGrzYQN8uOSjsdGAgMwzKOY4rlOYIaUth0P+L7KxviI?=
 =?us-ascii?Q?8g6zkqZGxcM1tdK6GCwwDFmevviHcqHJbQk+wdjKS7B9pY1i36jVrBq730KS?=
 =?us-ascii?Q?TUIMO0LFtJJYIvQxlIfiv10LSwFrJa44BLq65OauMxFhgLt9WXLwGuPmiy74?=
 =?us-ascii?Q?xHuIoWoz1U02z9eBz29jbtkI8Pt/cNjsO9lU5MEJ64wuPamD/IugWTfsQhqQ?=
 =?us-ascii?Q?63xLvjU8AUy83Ci6PJPD/21KgpztAR0d1O0iMoLx7g7JJ5PSmasJd5EF/cW5?=
 =?us-ascii?Q?gk8lj/Oea5hEhfBj/vqtBfkCznC/ecA4I0uedaSyve8brcZ4woXKr0X4K9MI?=
 =?us-ascii?Q?+bkNEdXaA9FWc5vo7IrtSfV/hPp/twNK0Y8Ra6qRgFV+NmoBvN1iusY2gLFd?=
 =?us-ascii?Q?5vI0BsWXEtRrNceszlxybZBpN4eXNurRVBTNs3ODn5Ba3dIqYqsdS/dQiA3J?=
 =?us-ascii?Q?ryfAWsHPV12cDFtX7ItKPJHEE29tF0FUaYlnD9LCXa9LQhURbPi1cmUsJJJw?=
 =?us-ascii?Q?2Lvx871qDlAg9dAW5mYDsPjvTSpO9WIZ42lkWDba80vExch5j8eZWfSzTHaC?=
 =?us-ascii?Q?V2s3hph8gIwlGxHBfVe1ikAx/ve0GofbGtw1HJPp5OU89A5bILi1LDrIXkQb?=
 =?us-ascii?Q?sBra1ww85Uk63H6TaQFuilvz7MsaCiwR0orGHccq13GucE6vawXlzw4HIcU9?=
 =?us-ascii?Q?wD8LQGX12T/NWxsOwUyP+3k8DpE0PcWFAZnCd6TzxJ2nwlZ2Fxg1DIE+Y3gv?=
 =?us-ascii?Q?sBvwIvn6uk9/erF449QgIGs0alByPJ17Hf40nvrRMxNR+DgfHuBJyyKfLEAu?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e88ff95-e3c3-4eb4-ab1d-08da91368315
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:07:34.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKovOfM4s1i7T/YZk+VG8LXePdlsmfnZ40wfvv3TGlAdig31tg/Vr2AwB5sO4cLYzuZ0XkvWcUadpHzFEpmuDkDeLVRDOWAYsYRZa8hqww8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4315
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

Andrew Morton wrote:
> I really dislike the term "flush".  Sometimes it means writeback,
> sometimes it means invalidate.  Perhaps at other times it means
> both.
> 
> Can we please be very clear in comments and changelogs about exactly
> what this "flush" does.   With bonus points for being more specific in the 
> function naming?
> 

That's a good point, "flush" has been cargo-culted along in Linux's
cache management APIs to mean write-back-and-invalidate. In this case I
think this API is purely about invalidate. It just so happens that x86
has not historically had a global invalidate instruction readily
available which leads to the overuse of wbinvd.

It would be nice to make clear that this API is purely about
invalidating any data cached for a physical address impacted by address
space management event (secure erase / new region provision). Write-back
is an unnecessary side-effect.

So how about:

s/arch_flush_memregion/cpu_cache_invalidate_memregion/?
