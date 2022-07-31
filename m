Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C817585FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiGaQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGaQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:39:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A303BF54
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659285574; x=1690821574;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XJ1ppCVamMQWcfW5rMm0L565YSSVAb2LZ4rzd6H15hU=;
  b=ZngIaoQdaHLFDzR8R+oBpdS3Otcab5+PcsM+fxjKJX4680Ci/6YntYv6
   XCChrlKOoGHULEMCpqYWmRBN/nGPZtuaaI7mQorev29HyKTX3e7ghvwM4
   PATIjzFoN6drZ9gWCmr0YYM/iT7QTdN/cK+60prznQ+QYvqehF3zVYIlt
   W83Be/mfhuLrMyZv2z2CoSx9wIrs0MHc+0X6kPas4jPALpkShngpmzfd7
   c0/iJgwbvM16iHd2DM7GionFOr90osajtltD4HJF+G9EwZSfijQgMa8mn
   FO55ZYpYiEXbVmXc7AKrWGepJ7MSvhLoE0zKcbBVN52BkRoM9eskdgSZ3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="290217210"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290217210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 09:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552270068"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2022 09:39:31 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 09:39:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 09:39:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 09:39:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 09:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlVUsCrUAeBEYhjmy6UnbIRLkVxaf+4rafEI5fLvGc4SmkcNRngUzvlvMYdcsrUl+PjqUWcPP2bbeq4FVNTILntIZfVnDH+GX54P1lHjkJ0xOuOYLTVDkh8R1030j1tclQmvEOPfwQT1cOPhBHL1uesC7HXh0R2XAkF1pc086o31b3CUOqmqk8G3L1AgO5D9GtKsQo3BMWBW9YWdP+wkDW/aDwCTFFDO1AecQ4BEpUG+04SXmy00LT8O8USRfL3hfQoktIcxm2tqWMj3BGU5rIVlAr7zJMdCkY8SOQD2kWLn/0AOOB5KJ2lJRL9rkO+2isOjoeHNFBheigNAZRZtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3tBrIPEUB3QsdipyMZRqBZ+UW5K+jSAi3eV5nocTx8=;
 b=U2aBUQCtEvTaAtDqfwLeS3yLaK4eA3FDA9Aoefpk9Ou0j1nEMA17KUfMqtd7kv8oIja+7BtJ9Bss9aUpSK9ba5OCwKxnYaEXjWzEY20EGraZsbRZTj9A8YDbPhcExHZwYzAaj69Xy4/Mw2pTQx2s4VXppaKjjD7dl9vTwAN7Be+fKDTgbokL/rYljx2nBXk0/oJxNH5WBP1g/bnJMU0MMv1T8J8h2rAwSqpP/UqUbxEpC7A2ZmCj4aC6XmTacbJd4YnXbWyLt49ti5YOuMBJORFpVvAIJVMqcc1uCi4vXUEOWXI/9mDdpMeAUo0llSYctZyFID1IiKf5Qs2i3r+kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sun, 31 Jul
 2022 16:39:29 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%4]) with mapi id 15.20.5458.019; Sun, 31 Jul 2022
 16:39:28 +0000
Message-ID: <c5eccd77-efc9-fae9-dd8f-6ae55a36b540@intel.com>
Date:   Mon, 1 Aug 2022 00:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [atishp04:kvm_perf_rfc 20/24] arch/riscv/kvm/vcpu_pmu.c:
 linux/kvm_host.h is included more than once.
References: <202207170053.sH7IEl7J-lkp@intel.com>
Content-Language: en-US
To:     Atish Patra <atishp@rivosinc.com>
CC:     <kbuild-all@lists.01.org>, Atish Patra <Atish.Patra@wdc.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207170053.sH7IEl7J-lkp@intel.com>
X-Forwarded-Message-Id: <202207170053.sH7IEl7J-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ff501f-0f1e-4f6a-9af8-08da73133caa
X-MS-TrafficTypeDiagnostic: MN0PR11MB6134:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9Q9TfZT0wVqYunuwkUw8IdnfXA14NtW5nEEIN47NrWLwITh04sCI6vIrY0UcI78E2BLzkxyWVOIS/g7CHYSdfSmIuSdMM1pL7qqCUv70/x1D//GfUa+FsN7WVYcTAtCSoLX4hgkd9YWvomgLn/DOZkMheKEAkjt/c9iaHu7VsOBsSiITO5LiJNhtmOcQ3USJO7Jkz3kTBg5O9J7k1exkS+W0Se6AC7TBErOnhMhUl4sk1yxZ8lxBe7N8vV7NOcO1ampuV0v74fZS4b0cJV7IhW/bsQDDW4mXuMC4l48R5Vj1owfY6fDBFafUU8svVFHMaz2qc+6hZJADW7EUC5klpzsO7VmGUS7rNqYm9DCb0IXKtjmsYTkuE3lox4NebgIL7PCj9BBEOReaZrzVzejP3rc4XHEoIC34voQ8ykN7/dbacZ3lflfwzVQYAn7aMK/Xu+4amRgTOR5DCJXHYEANAgN2BPTPab28eKptlvPWcKlx9fJYx4gZ6tRSBcScXnUVA6ySeYluaB0h/6pCEqrzzsjnyZQLz+kOsEUb0dgFxObL+iYT6cF06rG/TyfLwFKio40XQBU6inkkQ93S632wsgdbiCExoBevTwa7W1fuPwfbQNpqK8JwMyPFzBNgTaSSaUz7GP6FtYbGEdJcsmxeJDcGC+ip+/N6+UEynbLvi/gBuZhfv13OoNzylxB4lGRkom4axV9JR9wyQtaMNH90Vm+cIeaXB2m9wiYvxt417AA+L9j3YdeFzJowSXW0DZwx/hjBYwa3+WcFiBNba01wiIFAsAzlvjRswI8kefD+Q6Mw2MnhZR2Gs82Ws6YB2mM2d2yxxKT1ejMs0ImHtJbRTRu8XgpunUIoYp/D4FG31FDyZBTDAq+Pg1nbOpSNMskQ6eCFxz6fw/pPmfycgwqpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(2616005)(4326008)(66946007)(66556008)(86362001)(31696002)(66476007)(83380400001)(186003)(2906002)(5660300002)(4744005)(38100700002)(8936002)(82960400001)(6506007)(6486002)(8676002)(316002)(966005)(478600001)(36756003)(6512007)(26005)(41300700001)(6916009)(54906003)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skp5UFVFNm16VEFsT2dYalRZMFIzN0Q0bEF2QzM0U09zb3NEME5sZmFxQ0Jm?=
 =?utf-8?B?bXp4elVmWUF6bzN5U3ZLM3RCYk1idFoxb2lVajJHTlpweDRzSzRXMFdPTnFu?=
 =?utf-8?B?cmdWUHlUeWhuVTJXVDRMN3RkclRDOW9SelN1bTZETXhmOThXUlByMklEa3dI?=
 =?utf-8?B?VENPRmN6cDRvNG5FTldDS3R1ZFdwS0txcU1vWHF3WmhYeklJMlNHWlpNY1U3?=
 =?utf-8?B?TS9VOVdQM1JGQ3c2NWxDOWdzUlc4Rkw5Q0lsSEVEdG80Q0xNUXFqT0xSMGtC?=
 =?utf-8?B?eUpkbmhCdzk0VEZsM0VmbWZTdkpxNHdvRlJGOFdVallRY1ZDQUM5TlFJWEg5?=
 =?utf-8?B?T2JrSWxndUY4T3ZOeC8zbTV2eU14T0dQb29Na20xSU5WbHpRTzlrQldONkhm?=
 =?utf-8?B?TW5ramxoUFdTNktuUXZxL0Q1RUhaTmNDd3ViSlFUWUlkTktSOGE0SGpOclNZ?=
 =?utf-8?B?WFNvMXRTMHg4dnB0UzNuNUE3aWZ4cnBpcDlNdEE1dmVaRDFNcXpieGU1bjZ0?=
 =?utf-8?B?cVZhZWZMREtzN3E4dmMrbSs3WTBJOWJOQ1QwNG1wVDFuVHVYakovVXB2K2Zu?=
 =?utf-8?B?c1Q2cFpheHh6Z3pjLy9ja3JTYStucWpTVGFsRWZ6c05sY3dlOWsySEtmTkRw?=
 =?utf-8?B?dEcrU0IxbzhyNW9DSmxMOUNUbEZRYk5uNHlHZFVNa2hOOXlHNTdOZERkRkEy?=
 =?utf-8?B?SW5FQlZVQ001TGk3V2Y3THJablJHYVBHdHl3cDhtTksrQ1Zmc2orUkcvaDNI?=
 =?utf-8?B?SjNJRjlrallqZGlnaG45aTArUmkvN1laSklERXlMWlNNcGRRSlJ0Wkl5V2ZI?=
 =?utf-8?B?b1A3bGp2QlhVUE9rU1QrWUt5RHRFcE1sUUJrWXhUZk9mRUhrUUtOYXgwdGJP?=
 =?utf-8?B?RHFlSUk4WUpTdCs3RGJRbXlFcWZZUzJldUY3L2hjSExaN093dkU4OG9HNUE5?=
 =?utf-8?B?cEk1YWpFRXUwN2thY00zM3U4RStFTWZ0ZHZsV3kxb0MzWFBxdjZFTEZoTW9a?=
 =?utf-8?B?aS9GdzJCZVFaN0xZcVFUeHVlalRBNWxJYzFxZVlqZ0RpNGhGK1M1Y1pEajky?=
 =?utf-8?B?NGIzVTdRNk9NZU4rVDl2VVR6dGcwTldaTCtvQjVMMjc1YnNSU0RvYkkwUnpL?=
 =?utf-8?B?cE4rVDhGOXM2clY3Z2VSaVdXaU0yVUpMb3hBUmNXaXVCanVEWXlVbzZJeDNL?=
 =?utf-8?B?ci8waHhUL1g3UFJtaXN5RGR4ZHNyZENIYW9zQ0Ivc1E4VGM3SHY2UDY0eGt2?=
 =?utf-8?B?Q2Fic1V0ZitsTjZaeE1BbzhSWFVqUzdSWSt0STh1S0tYODR4RG5Wa1lsZ2VH?=
 =?utf-8?B?M3BCYU1hNFZvc3JhdXJDMjhab2RjU3BGWGUzcnFQdkY1NU5xZ216ZktNTEFr?=
 =?utf-8?B?a1dDV1drUmNGN1kyWDhqcFNLYk5GNk5tMVVNaFRMa0hjNEEvSHlHUDMyblc1?=
 =?utf-8?B?c2hKK2dIbEFhYjUxN0Yzb2M0TWNDT0FDSWNNb3hZUnFuMEZJSDc2ekl4YldF?=
 =?utf-8?B?RFE0Z3haSjZxZzFmek55YVo3VTBJTG85ZDRYdEJpN1hGK3RjVHhxSXJBdi9J?=
 =?utf-8?B?aXdlTC9LOHhWRVlhWjB5US9ETHowaWRHeFVaOVZlS2xTZFNQb2l3bGg4cTFl?=
 =?utf-8?B?aEJmN2EzNjNSR1Y1WUNiWC84am9FNy9vbTJlT3lTaDhRWUlLL3JlRVBUNitD?=
 =?utf-8?B?c09pRUJnbVdDNlVaeFVRcytBZjliRkFxaXJhODMrd3luOWxUVmp5K3FyckE4?=
 =?utf-8?B?a2xteGVweFhCYVdtNmRqeHMxUWpQRG1GZVo0L0NIYSsxREZpcnUvNmFTVDdl?=
 =?utf-8?B?bmZFd0dLU3JidGpBa0tCMlZ2SVhZYXI4NVVHOWlWY2s0aVNPazV3a3JFYkNu?=
 =?utf-8?B?cE5aanBQVHU0UklXOGlzM29Pczl0T0N4RVdvT0tsVkVVWDl6MldOQXVTUHZP?=
 =?utf-8?B?eVRPbyttbWF6ZEJhTFNnMWNhZEFUdU8yK1dtMm5wRC9JMXZzYVBaVXVpcG9n?=
 =?utf-8?B?WVFkL0NEeUs0UnYwYXJhT2hIMkxWdWN3UEh6SnhaR1dsVlAySkM0WjJBazZZ?=
 =?utf-8?B?ZXRUcW5vQmEwcU56MU16ZmZaQ0s0Rll6c1V6NE5sQ3ovbVJZWHFlMnNKZkFL?=
 =?utf-8?Q?LJauw6IXDoeLdPmeFjFSzeuu5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ff501f-0f1e-4f6a-9af8-08da73133caa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 16:39:28.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vdNXoK46uQPnKoBV9mgQgsMcM4Ke7wg5GbMzMv3wF9MwQg6ewTnhd0GfpZ/doLtMDpP01wtEVHqE8zWH0FkxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   84a3fd7f92957f64c411595a9efcc2eed18db2be
commit: bb00c153861bc5d86bab2b4335f3f0e1ca970925 [20/24] RISC-V: KVM: Add skeleton support for perf
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>

includecheck warnings: (new ones prefixed by >>)
 >> arch/riscv/kvm/vcpu_pmu.c: linux/kvm_host.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
