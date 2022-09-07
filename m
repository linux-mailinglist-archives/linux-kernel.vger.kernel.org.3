Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D75B0A99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIGQrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiIGQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:46:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E6A7F134;
        Wed,  7 Sep 2022 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569203; x=1694105203;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ic+HHyYfjRPqCmvqJVT2ZJJR88ySxXWA2/BMrB79yvA=;
  b=N3DY7tq/gFJd2dMg3+clAq+pGVKrjSzmuIxf7khQYD6gmMyfM/idKqzI
   7vV/FES7lbxQ4jMRAJIWkccEcmizsgkjcydfQPNn1ENkEJSsVBrrQM3mV
   EaFcXOaVkZ71EZtBfgzwrvOf0fqIooSqiuzPJFO6j4Fh0UMhAsf3t1189
   gAJp5NWTXlMrU4p51Zco4a51mQuXdg6RZnA6sI9R0edG8lUoFYe72vYTi
   iG5leI7qSpphJdG42/mlQdKHpmgf/4qM6/KFWBHbVu5JoDyhQJNFgehmn
   rr1jeRVMOg03EMXauYEIyByJAYLx5K7Ob1k2b7JXahEX89Z9G8wy3wJq2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276671018"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="276671018"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="718213029"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2022 09:46:23 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 09:46:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 09:46:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 09:46:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 09:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2da8fsn+i9mBP5crlSi9NdM1wSuipEfB2JxBq8NcXROZoCkun2Km9eVQvVxW8cyf8bhsSddVgkiWiEhZurNylwWFsfDaOzt0K+g6F+AtYchicGM3tEI//MU3dTb4k4u781+Da8DCX45Wp3u1PZMUAVjNFg4TbBi5oGj0Lq164DWrAnvZVs4tvbxHo6nZdrc9CH8RJulgT9e+iR7oGtbqZycKDunFo4PTUFD9LDf/FIRAuHFAAFSjoOhHqzh/whedvwRnDzfQZ1LGgsswNMn4QznYYsgUuxjIJ26g563cseD3bMT4mVsm2a1CpCg3FnYWmckrXxc47no3hb/SuLDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic+HHyYfjRPqCmvqJVT2ZJJR88ySxXWA2/BMrB79yvA=;
 b=bcsMTYMiGfzZY+8ecL8I5usPN0LRFv2ftXFQODCefC3iHGlFmKShn12BXc/gFX3J3y04aGVyRBX64ICVlZQJW1Yuz9GHUAB6OTB6CIxEVvk/IRZ1YKdklY1OInMuYKTMZGR/si4t2d0UiF6lh9SUIxiGpSMRHxtqEeRZGB48CD5J15yPbYPB4lua1HBIZCbtFxfqlQlbTFIy6m3axhiTXwi2TPosWyup/Z2LEZTSurPYGAvnCNd8+BBy5SNh5MrSCl9kqLntLy29Dg4FFdhGDejGSjnXsCskN5c/tFRdtXP/4EAeioicAnukhwBqjC8ml+fmOtqHrlhnssnKH7ytJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5790.namprd11.prod.outlook.com
 (2603:10b6:a03:422::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 16:46:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 16:46:20 +0000
Date:   Wed, 7 Sep 2022 09:46:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <x86@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <bp@alien8.de>, <akpm@linux-foundation.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <6318cad97f5a1_166f294a7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <20220907143603.d226eyi3uitlcmi5@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220907143603.d226eyi3uitlcmi5@offworld>
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10c48f5-bd97-4f11-019e-08da90f07dc2
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5790:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oO/2yBsElZPICANdmFv3+ZsiKgGKwjw4JmohxdRufut/c83OH5DF5HbjADeu51r4xDGUe3ALUoVYo1dAsF6DdX+7r/u5FhyIZO+K35eZFNNfVLAlwxiVauymX/7tUf/cCy0+RFIadn9hvUHMGAD/t1bLjeZmv/anwamu6w/XC2MaAbz/TdMhODLj+gaJgG6ELDZn+33BDMfMjhwRXiyjkTamJek3N6BQOEpspBs8Fg/6ilMTGBTJFvrwQS0MCRt6ZZxtUFbXPypLnpnOxsMJY2Fm5JaFYYIZDfC6Bk2yZHX8JWwIV6w7+rwmWvS4tb1LKLTsQ7tnnN+AaW26MIkTleddnSNNCD/AOzE9/6mqFJ12iAaGBlirHmpVExbAmGhCqMHVdzGAcnSejGiXbg70r69BsxoBv1VXsDqXBl4sQCOK2Vq7TchrTu9byGIkTHlEFJNQ2N06nPSYjHwvXRyWzkig2J7Spsp0hGgoju3420LBO4T91UGHz4yRIj0NKcyrJjYH6U9+P1Nk/uxd7trlyz3DmpqUAQ65cvXeS+2GhHcthbhd2dNS+aZn4egXBsTjWhhaaWc/OFgAxnZf7pIw5g0pm0YfdnvXSgLLJCDfnmi2oK74G8ijDPFyws4Hq6bikt7I2AalXPul1MHCV58R4JmM3IDwN7EAvHGnRy0JRd8dWepmOdI+bSv9CvcrBbEwveyYa2S2sPjy08Cvd3LI+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(376002)(136003)(66946007)(478600001)(66476007)(8676002)(4326008)(41300700001)(558084003)(8936002)(5660300002)(6666004)(7416002)(6486002)(66556008)(2906002)(26005)(6512007)(6506007)(9686003)(38100700002)(82960400001)(86362001)(186003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aseJUUTIRwQxgmojZAToCQus2Vwyq79rYh/2VBFpZDPgowSE8FDev4lOagmE?=
 =?us-ascii?Q?00SSvJiaDzT4OhhabDWz6j8Y2BEOgdFhSy6d7/fs+qV+n6mZ8atENYhTc0EJ?=
 =?us-ascii?Q?XgAvygjtFe3IqVB5z7WBxLRFf9XX6/1N+RRqGyLnV18j37D0y83zfEBNcEi3?=
 =?us-ascii?Q?5MFJsWhsUEF3NxOzBFPFiK+HU4hyYrOvTgNCE1eaVKRVFBcC8ThL9pJuFLBM?=
 =?us-ascii?Q?ilysya8EqIGhkOnTKRDdzlS5UjFo8hQ+ZKWN+Hrb7MnBvvzDKppM4StBKR55?=
 =?us-ascii?Q?FhexorYoWykYEgImTJ6UCG55d7q/Ow3j/Mm9MvFWNu44cxQ6kOLd9Oa6lRwC?=
 =?us-ascii?Q?OLiT1lG4oD77Q83GCEe+2XS1LrtHYFrVkdtNNwjm01GE65wqQpaLiPa5Svjj?=
 =?us-ascii?Q?5SiBmBket5Q3QvhceYlk3YvVpepRcd/R2x22DRUmYlHLA7RQNrHh0N8a2FX3?=
 =?us-ascii?Q?RxvxoA1anhzL9G2zi80ADNAQignKRsHMtG51F+C4G/C8VXoDpJ5QiaS+i5bU?=
 =?us-ascii?Q?98x6c0cIS+m4uYZc6kKGmw7hgrBYO6VY/0pP/T7hkkSHJX3NqbTnl/A0yXBD?=
 =?us-ascii?Q?2oadI70AHv4OPlHe0q1WrqSLpbYKCzbgbgpeLeS7pQzP1jVGWXVHdyBtl1fK?=
 =?us-ascii?Q?WiVjQnuQ8WIDACOLI2tLzFXtYwh3LjhkfwuoZYSb++QvN/Ko7DDVWELlC/Qf?=
 =?us-ascii?Q?na0UfrsFihpgCT7PXHdZSvC5L7/zUxn0zp210hAmiMKRiUTOCSPbWvXNDjpt?=
 =?us-ascii?Q?9LvJ3AGHPGrfBchDqPG7AYC8pxlu7zt8uk5goiW63PDbSnnmgkg7zFnADd7p?=
 =?us-ascii?Q?ZyFMSA5F9cMAFzSHzSI5QrvQlXF87XdqZz7UPcdzcGWcjTFQLKEe9kFlHfan?=
 =?us-ascii?Q?edpoIWZCFfHxS3xnLHnRHRA6sSuQ416LQBwtULtgk7e5eDp0kdAn6S35h8Y2?=
 =?us-ascii?Q?KtG6sTaJ9evKiG2G5demvNXZuNjSlcYH+wb8/+JXD5AycWtKnnItoZb/gsUo?=
 =?us-ascii?Q?F6FSgbt5eVYOpNaMTjZkp3heGDA68hyn9H8GwQmHitlfkojsBNfmnj9Jatgu?=
 =?us-ascii?Q?yuK/8buHNrtSgekJhmmwoxFpzxojx/jk90GB3G56PVMYH12yLUFgmTv4IxoM?=
 =?us-ascii?Q?//qq3W1QpVjUvxjfKXkZ3pC6XbElRjqVrcVgqxSTaCIdkndIBOCCijwlOAbj?=
 =?us-ascii?Q?ROIKpoPmkgW7DFOS6KE+ONWVrS0frKnQwwOvGR6laCpvOINh76eeebN/pq7M?=
 =?us-ascii?Q?F9DsL/qBrfQVyUmuob7lK8lWsCNt+whHdKntqgRhLapG9ljhIQmGBuRiJnT7?=
 =?us-ascii?Q?V71RvC39V+SQJDBvfkjiYDET/BO6e9QAumTC2I1I6/xJD/hdSv1u+nFJ5SeP?=
 =?us-ascii?Q?qfEv8xi3DU4FROt04+3FMvnPF3DNvaoFuHrtvvvZX8+/UJQRp3CE65IaYKq/?=
 =?us-ascii?Q?9gEnGuRMDy7HVZOnginz6/Qpv0zmVI+28Blc3yYuSlnJvJPn5AsDWtmz+s+d?=
 =?us-ascii?Q?tYXOPpsztH8xhcr/25B9MVr2gMgIPc74/JGVShQnxRy/5k1PfUXW5vB6xi+C?=
 =?us-ascii?Q?F+BJML5itk2FHhSD2OLrcHaKipYANCw+2cUpoghhSaza9T88twGboAGQxfGi?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c48f5-bd97-4f11-019e-08da90f07dc2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 16:46:20.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBoB9YCyZZOD2lS0kL5Dx1qaXK80pDHNU3S92ikTwE5/RFBL/6aTC+H+seVQv1weQdJXjIRD2w3P2Ght4mcPWNWVjJl8fVGr4sRLO73gRIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> Not sure the proper way to route this (akpm?). But unless any remaining
> objections, could this be picked up?

My plan was, barring objections, to take it through the CXL tree with
its first user, the CXL security commands.
