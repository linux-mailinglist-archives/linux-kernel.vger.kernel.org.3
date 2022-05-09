Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4A51F2E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiEIDZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiEIDU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:20:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F0954A9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652066224; x=1683602224;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y8hg6Z0pQCwm2AuOSpnqS1eCmmZZk+J4VXWO1w3mZT8=;
  b=TFuprq1/bLhkBmWVak6vu+ei10NPSZfSeIGYdr5Zv/u6pDNJMrfW2b1F
   y5MNBg8LglC3/J15NrwM9Bspjedu4XBd9hzchs4czJzM6IKCwW8F2MOP6
   QVsS3pCfkG3xRyaU4oXVDj44+2ygN+IQVNm5wklXCnYnBBA2xPjsZaGOd
   talIJFFEWtht8jnFAeXHHjSc+I251yr0gC7qs4JfRnX8QglCgNQqhk2H7
   NoeJzPUDRv2u6I+jDKZc89BMcSNA2GNG8p3eVlN66ooueQy1oWBRztR1f
   qkJTkSDflsjaP7P1Ufv63gOJnVm781LCej6IP2Yv8VYCRCNiWsuVMjnIg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268845394"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="268845394"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="564826027"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2022 20:16:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:16:25 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:16:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 8 May 2022 20:16:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 8 May 2022 20:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHl6SD0jwEGaWvbuB3tJRwnXznwIFJERA49zWRpGSXIT3fVbWisCsRY0s+E4Mo5FJYqMrZSXgEwW2Jobchi1Fc+SMfCpVhrQKaPfxIKlglmNdnTGR6qCpsRT9l4YXKiHu+cHPTAHvvGaKgBMEpbZGLYeIuFUhrmoc7KagE220mo9g7j3NhCwGjCmW6Oam0c+A9josPgZnhmCM/Lg6Fu0KHZAccRtM1MdOam/hA3cW7wPG1buKQFwlIpG9rcuM/QTOXXjBFcwToC8vjxw+4lyhq+75cjkY3zXAkj7q1u4MhBxcUXNQhukEpfEh/vB/K/WEgYWKWWW6M6OHwR+6OtuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoRInyM4uICI6qPkFEa+lAkLt+ziueZ8kyTeyPP+DI8=;
 b=FcJdgjvReI4zlig6HyQeTgfwiw2QoL66CyFD/wV+VtwEzIdqENsudH3Uucnqf9nb8h7Fd6UOAzym/gpyIPbdEkQSEbf1RzTDSGgZ2jZnW4DGgXGupa+9jdhW7mJeveRSHakHsscfLOS7oRxoktUA0TEG11vnxzsma3YNsUotD3f8J/pvI0Wb8uqaffM1C921b2Y01wfn9eB6BAsR4lZeyOnrmDTZQr+IwSWU5D1oMUWe3mytQ5qxXkG44qwmZ414zhaQ1xoWh9zWHP8GnU5lDPZC4rLXXMPjIKBh4b3+aL0WRxacux3RDeV/l2Yd6lmU/Qnt7Ls86sbF1/a/EYgYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 03:16:22 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 03:16:22 +0000
Message-ID: <225cbd32-09f4-3052-32f5-c61bca07c829@intel.com>
Date:   Mon, 9 May 2022 11:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [allisonhenderson-xfs-work:xfs-5.19-compose_pptrs 25/32]
 fs/xfs/libxfs/xfs_attr.c:556:21: warning: Value stored to 'dp' during its
 initialization is never read [clang-analyzer-deadcode.DeadStores]
References: <202205081904.eWJa1zBF-lkp@intel.com>
Content-Language: en-US
To:     Allison Henderson <allison.henderson@oracle.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205081904.eWJa1zBF-lkp@intel.com>
X-Forwarded-Message-Id: <202205081904.eWJa1zBF-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d434135d-6a78-4a88-ce44-08da316a4adc
X-MS-TrafficTypeDiagnostic: DM6PR11MB4564:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB45644B8AFFD2073673EDE24FFBC69@DM6PR11MB4564.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZidESFdNPDBL8wZWO2jVDgL6Z2nbSV20AXztGG3AIpwmg/RQLjmmf4i02Xep/Z6a9pWCXSh+9+ScFPX80oOhg5OhooOXBANCfhRyID8nXeZ2LmnUo4ex0/e+rIPZ1mjlu1e0VPwooSzJk6sgXcoH9YQ54gmNNKAHBrF2S6a44cLWtoLYZ/rDQ45b8xRUYzysRqJf87/xPJLtK9IFOcjORCuyEOKGvUKKTUZtdk2I0ZUQaS4NXAXdHMeX4zA33EJM9GxtZLPq7HwHm2ezyvgJnJBufNClSui0x6t7ZZI0bS64Kd11i7kDkyGSxhb7LatF9x4W+2f1rJC3aza4VbmrQT4KBRdVeIyHEUT4Ebl2hEcAzEWgFu9ZBHE1za2c5Qy/LyP2SfSjeg8rVvzIcXwo0SFudbhu1HwKwOCuUsd2u77yFnvCDR64nT2vKVgXoeaKqY9YI/iaCsA30oFWSEMOfW6XIF8TrTa635TgMGsbyERGP5gEm5ktHW7rtKkIYewCXXY+Y4YA6roUvCql6JQyFPeawpZhoegl0ETfmVxHbS3zMoS+i1eLbeQgW7q+hwQZ9thy5bCoDxTOJ/FdCHFfRP8DGAidPfblmcuNysSgiu2W8pMk8czUFhLpoRX77BZo+pH8CsprpWROSvorhqtoLwoJ07vwq8QOBh5PfP6DMgZqphPW3ZzBXPbh4XitQ42n6QQu4Ltr+Zq08v4he+6rijLG3nJEpXol9ud3LkjZMr85Y2oMRBg4AFIEdB+fE/hLsesujEpITqvCHWvPeIWE3cPQT9/1NgTGxg1fIxoHJqVQFbJ/RNhVBk5KnKHDxM3AHzqWkbrXAbkdgI2ymvB9vxg15VtPr8zK8rA/90E2dng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6512007)(2906002)(8936002)(8676002)(4326008)(36756003)(4001150100001)(5660300002)(86362001)(66556008)(66476007)(26005)(2616005)(31696002)(66946007)(30864003)(31686004)(508600001)(6486002)(966005)(38100700002)(54906003)(82960400001)(186003)(316002)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RCS0l6OFo0aDRML2RSRWdjclM2elM3eUd5T2o1T25UZTJMWXpPRHVZRjNu?=
 =?utf-8?B?ODNxNFhPRXhJbEN6V3JQOUx6NDlQL0xLMEkvOVg4OXdnM05QZWxRUVhKQTVz?=
 =?utf-8?B?TmJtUXpCVm95aGhmLzNHejJWQkRmVTQrQkRnalJpOUhadmFyRG9YZWJPVjZQ?=
 =?utf-8?B?eWloNkVtaXBqaWVvamxOVVZEVnFibHZhN3pTZWNsVWJLRmpKMWZ3b01GZXRF?=
 =?utf-8?B?d0NlNXRoSGM0ZkxxRkZtM05mM1Fjbi82TlZTeXhCMTJSVnIvWXFBLzNnWlE0?=
 =?utf-8?B?WVJIcDI0UXN4cDVsaU42RnYwSFBsUGpxR2J5VnBIQ0VGd21sZnlMS3BZNkFJ?=
 =?utf-8?B?bFN6YWJzZXRNV0QzdEdYUXpyaFdQT2NZUmkzdERzdENQQXVZcFNCZ2VoamY1?=
 =?utf-8?B?bi9sS2R1WFFyL3RiU3Y1TVF3UzFqT3EzcDJKbkF3T0Y3YTcrSER4bE1aZkZM?=
 =?utf-8?B?SjViTDdmZ051ZnpnenNZelRrWmlMRHVRU0Z3ck5XVkd1RDhpRlNHWHZqcm5x?=
 =?utf-8?B?N3dlTjZrWEE5WkdCeE54dGdFUlVTTmpZS29CcnVVbENJWnhRVks5NEtza2pn?=
 =?utf-8?B?Ynp4UGs0WjhaM0hQTUc3Wm4zVzZldGtvVFAvc2ZlZkFoRXpQbnhHZnFSWmxn?=
 =?utf-8?B?MkE0NnI0cnB4YkhNWVJ2dnJuWG5GQ1N4R1U2OGZUaGhKYjdKaUZ5cGVyMHpl?=
 =?utf-8?B?NjhXaSswODdjVUhrbDMyU1VuOHBmSlJoVnBkRFpYOHNrbFl3ODkzT0VnSmxL?=
 =?utf-8?B?Ulp0WmdvUzgvS05qLzh0U3ByQUVuVGwzd3lFcUM1cEQ5MUtXdzdHdkxnbmZO?=
 =?utf-8?B?dVhCWlNob1puemFEcVV6aUZIbS95RENERk1ZeDJ0bGNwd2R5b1Fna2pxeU1n?=
 =?utf-8?B?cWoxM1kyTENLTzdITXJtZTBITHJtanJkYkNhSFVGdHlFWGRLNnNzVlpBMC8v?=
 =?utf-8?B?dGY2YiszdkdQUU1SMVY1bXlGeFhZaWZXMXRxVW0wQVcvUkNnR2tTOGdjTkRU?=
 =?utf-8?B?NTIyRXVrVU1adlBHR0ExYUNHQ2JBWk41b21EbUZFY2Z1TXF6WVVUN1puTU5t?=
 =?utf-8?B?a1V6K1R2bWdhK084cG91UEN3cHd4MEh6K1ZYc0gxM0xKZStmT3g5UThvTlhj?=
 =?utf-8?B?UGREVkQ2U2lldlF6R3FFV2RaZnloeGJVSFJxOTA3cW9TU045Z2lyUDNMMGQy?=
 =?utf-8?B?MHpuaWE1MEM1WGhpTU1oQmlUcVQ4amNvK3g0THQxSUJua1UyVUN4bEErOS9T?=
 =?utf-8?B?M2NKNnZocS9nN2lIV0NpRDlaWUhIdUp6ZUtKbVU4amoxN25KeTMweUNDeTRS?=
 =?utf-8?B?czVSUUtNTGRyWVhpVXJ3bXF5Qm1EV0pVcitncjhtUnJTU01wTWdGUmVic2p0?=
 =?utf-8?B?Y0xnWVBoOFlVMEdjbks1V0JmOHRuY1dyYzJvaG5pcXBTUTNpUkt2SmpENUEy?=
 =?utf-8?B?QU9RUTdmR2I4L08yTnpIVGNFaERVcXI0SDZBQy9nMlJqRnBNSGhCRzdVdWxa?=
 =?utf-8?B?YU5NQy9oVzljVWVkMmxzR3lGTUJrZExHbDdkNktQaXRCOWZDSHBoYzdGa0hQ?=
 =?utf-8?B?RS9jUkVLZktmQU1yRC9GT0FFcWlsMDBKYkc4MG5helhHOTBxV2lTUkZ4eWF2?=
 =?utf-8?B?S0FTM0hSbGgvelE4NVJLRk5nUGoycnpiMlIzVkZmWUpXNFZsampTNHlEaWpo?=
 =?utf-8?B?aG13WWxseFF5aXNZckpTRHlOYm9CeU1NU2ovL3hQS2RDZXNQR2hPSFl2WEt0?=
 =?utf-8?B?eCtFMkwzdkpoTU1nb2h1bnlPay9WbUVZU2pVM0EyT3k4ckRIaUlPbVpkWjlw?=
 =?utf-8?B?RVJhK29HTWxTWTFXYUZkRHk3KytXSkZ6RmdmOVhoWTB1YVZHZm9waVZ5Y0Q1?=
 =?utf-8?B?bGNpN3V1Yk9pYWJMalQ5MjRCOUJQUE1YNWR5VytzT0JLSzNmSjN3TjVZci9P?=
 =?utf-8?B?dllsS0ZubXZhaGpGS3VaOWNzOWZHc1d5M3VwQ041b0ViZS9sbXd2UnVWR1p3?=
 =?utf-8?B?bnVWMk5QM0paekkvaUlROTR4T3RNc1BrdDMzVE10NGIrZDM2eSt0K01renZj?=
 =?utf-8?B?WWZyWURRSlFVUU1XYlpXRjFCN1RKN1VhU1BVd0NRdUZndGNKSms2cmNienJ6?=
 =?utf-8?B?clpsbnZ6WU9ETy9wKytxT2xjeVBFRnY2S3ZPbk96NTlwZld0R3BuTXQzbTBk?=
 =?utf-8?B?dWRJb0VOWmpybFA1T3pFTDQyUERSejM3cFErcCtwd0FZV2RIWlZMUFBGT0Fu?=
 =?utf-8?B?TFNtbS9iT255OFhrNU5lRWh0MW11cGhybmVma0srcDhmS3k0aVh6ZmhnQWhO?=
 =?utf-8?B?VytBWStuSzFOSEh3cDVDdTV5WUZQeWFGdS94cktyUTcvTkxLSU9IUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d434135d-6a78-4a88-ce44-08da316a4adc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 03:16:22.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH7r4X0L7s5diZPnvzQpzg2KK2LwkM6dyMdMEAjb05q/FZd/xedEHNRPmyIryDWpMX0e/OO+xJdxUd/fqv2iHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git xfs-5.19-compose_pptrs
head:   74ecccf0e89a132c2490f3a63661c535974c6a08
commit: 7a5d447970de2d3b003b9015e2bce3bf0d15e3db [25/32] xfs: parent pointer attribute creation
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220508/202205081904.eWJa1zBF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/allisonhenderson/xfs_work/commit/7a5d447970de2d3b003b9015e2bce3bf0d15e3db
         git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
         git fetch --no-tags allisonhenderson-xfs-work xfs-5.19-compose_pptrs
         git checkout 7a5d447970de2d3b003b9015e2bce3bf0d15e3db
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/xfs/libxfs/xfs_attr.c:556:21: warning: Value stored to 'dp' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            struct xfs_inode                *dp = args->dp;
                                             ^~   ~~~~~~~~
 >> fs/xfs/libxfs/xfs_attr.c:559:21: warning: Value stored to 'mp' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            struct xfs_mount                *mp = args->dp->i_mount;
                                             ^~   ~~~~~~~~~~~~~~~~~

vim +/dp +556 fs/xfs/libxfs/xfs_attr.c

e683cdbb8baf82 Dave Chinner      2022-04-14  542
db1a28cc591c1a Allison Collins   2020-07-20  543  /*
d56c93997e96ed Dave Chinner      2022-04-14  544   * Run the attribute operation specified in @attr.
d56c93997e96ed Dave Chinner      2022-04-14  545   *
d56c93997e96ed Dave Chinner      2022-04-14  546   * This routine is meant to function as a delayed operation and will set the
d56c93997e96ed Dave Chinner      2022-04-14  547   * state to XFS_DAS_DONE when the operation is complete.  Calling functions will
d56c93997e96ed Dave Chinner      2022-04-14  548   * need to handle this, and recall the function until either an error or
d56c93997e96ed Dave Chinner      2022-04-14  549   * XFS_DAS_DONE is detected.
db1a28cc591c1a Allison Collins   2020-07-20  550   */
db1a28cc591c1a Allison Collins   2020-07-20  551  int
8f502a4009822a Allison Henderson 2021-05-21  552  xfs_attr_set_iter(
133b4f4350cc51 Allison Henderson 2022-04-11  553  	struct xfs_attr_item		*attr)
db1a28cc591c1a Allison Collins   2020-07-20  554  {
133b4f4350cc51 Allison Henderson 2022-04-11  555  	struct xfs_da_args              *args = attr->xattri_da_args;
7a5d447970de2d Allison Henderson 2022-03-22 @556  	struct xfs_inode		*dp = args->dp;
7a5d447970de2d Allison Henderson 2022-03-22  557  	struct xfs_buf			*bp = NULL;
7a5d447970de2d Allison Henderson 2022-03-22  558  	int				sf_size, forkoff, error = 0;
7a5d447970de2d Allison Henderson 2022-03-22 @559  	struct xfs_mount		*mp = args->dp->i_mount;
7a5d447970de2d Allison Henderson 2022-03-22  560
db1a28cc591c1a Allison Collins   2020-07-20  561
8f502a4009822a Allison Henderson 2021-05-21  562  	/* State machine switch */
100ba63970eed9 Dave Chinner      2022-04-14  563  next_state:
133b4f4350cc51 Allison Henderson 2022-04-11  564  	switch (attr->xattri_dela_state) {
8f502a4009822a Allison Henderson 2021-05-21  565  	case XFS_DAS_UNINIT:
7a5d447970de2d Allison Henderson 2022-03-22  566  		sf_size = sizeof(struct xfs_attr_sf_hdr) +
7a5d447970de2d Allison Henderson 2022-03-22  567  			  xfs_attr_sf_entsize_byname(args->namelen,
7a5d447970de2d Allison Henderson 2022-03-22  568  							     args->valuelen);
7a5d447970de2d Allison Henderson 2022-03-22  569  		xfs_bmap_set_attrforkoff(args->dp, sf_size, NULL);
7a5d447970de2d Allison Henderson 2022-03-22  570  		args->dp->i_afp = kmem_cache_zalloc(xfs_ifork_cache, 0);
7a5d447970de2d Allison Henderson 2022-03-22  571  		args->dp->i_afp->if_format = XFS_DINODE_FMT_EXTENTS;
5a7bf541843b13 Dave Chinner      2022-04-14  572  	case XFS_DAS_SF_ADD:
133b4f4350cc51 Allison Henderson 2022-04-11  573  		return xfs_attr_sf_addname(attr);
5a7bf541843b13 Dave Chinner      2022-04-14  574  	case XFS_DAS_LEAF_ADD:
133b4f4350cc51 Allison Henderson 2022-04-11  575  		return xfs_attr_leaf_addname(attr);
5a7bf541843b13 Dave Chinner      2022-04-14  576  	case XFS_DAS_NODE_ADD:
5a7bf541843b13 Dave Chinner      2022-04-14  577  		return xfs_attr_node_addname(attr);
3f562d092bb1ed Allison Henderson 2021-02-12  578
b8d9a2124c0193 Dave Chinner      2022-04-14  579  	case XFS_DAS_SF_REMOVE:
f589c4f3a7a7d6 Dave Chinner      2022-04-14  580  		error = xfs_attr_sf_removename(args);
f589c4f3a7a7d6 Dave Chinner      2022-04-14  581  		attr->xattri_dela_state = xfs_attr_complete_op(attr,
f589c4f3a7a7d6 Dave Chinner      2022-04-14  582  						xfs_attr_init_add_state(args));
f589c4f3a7a7d6 Dave Chinner      2022-04-14  583  		break;
b8d9a2124c0193 Dave Chinner      2022-04-14  584  	case XFS_DAS_LEAF_REMOVE:
f589c4f3a7a7d6 Dave Chinner      2022-04-14  585  		error = xfs_attr_leaf_removename(args);
f589c4f3a7a7d6 Dave Chinner      2022-04-14  586  		attr->xattri_dela_state = xfs_attr_complete_op(attr,
f589c4f3a7a7d6 Dave Chinner      2022-04-14  587  						xfs_attr_init_add_state(args));
f589c4f3a7a7d6 Dave Chinner      2022-04-14  588  		break;
b8d9a2124c0193 Dave Chinner      2022-04-14  589  	case XFS_DAS_NODE_REMOVE:
b8d9a2124c0193 Dave Chinner      2022-04-14  590  		error = xfs_attr_node_removename_setup(attr);
b8d9a2124c0193 Dave Chinner      2022-04-14  591  		if (error)
b8d9a2124c0193 Dave Chinner      2022-04-14  592  			return error;
b8d9a2124c0193 Dave Chinner      2022-04-14  593  		attr->xattri_dela_state = XFS_DAS_NODE_REMOVE_RMT;
b8d9a2124c0193 Dave Chinner      2022-04-14  594  		if (args->rmtblkno == 0)
b8d9a2124c0193 Dave Chinner      2022-04-14  595  			attr->xattri_dela_state++;
b8d9a2124c0193 Dave Chinner      2022-04-14  596  		break;
b8d9a2124c0193 Dave Chinner      2022-04-14  597
020dee1bf99e76 Dave Chinner      2022-04-14  598  	case XFS_DAS_LEAF_SET_RMT:
020dee1bf99e76 Dave Chinner      2022-04-14  599  	case XFS_DAS_NODE_SET_RMT:
37e7bb8434f8b2 Allison Henderson 2022-04-11  600  		error = xfs_attr_rmtval_find_space(attr);
83c6e70789ff37 Allison Henderson 2021-04-19  601  		if (error)
83c6e70789ff37 Allison Henderson 2021-04-19  602  			return error;
100ba63970eed9 Dave Chinner      2022-04-14  603  		attr->xattri_dela_state++;
f1fdd499537724 Dave Chinner      2022-04-14  604  		fallthrough;
020dee1bf99e76 Dave Chinner      2022-04-14  605
f1fdd499537724 Dave Chinner      2022-04-14  606  	case XFS_DAS_LEAF_ALLOC_RMT:
100ba63970eed9 Dave Chinner      2022-04-14  607  	case XFS_DAS_NODE_ALLOC_RMT:
020dee1bf99e76 Dave Chinner      2022-04-14  608  		error = xfs_attr_rmtval_alloc(attr);
8f502a4009822a Allison Henderson 2021-05-21  609  		if (error)
8f502a4009822a Allison Henderson 2021-05-21  610  			return error;
f027184d93cf76 Dave Chinner      2022-04-14  611  		/*
f027184d93cf76 Dave Chinner      2022-04-14  612  		 * If there is still more to allocate we need to roll the
f027184d93cf76 Dave Chinner      2022-04-14  613  		 * transaction so we have a full transaction reservation for
f027184d93cf76 Dave Chinner      2022-04-14  614  		 * the next allocation.
f027184d93cf76 Dave Chinner      2022-04-14  615  		 */
f027184d93cf76 Dave Chinner      2022-04-14  616  		if (attr->xattri_blkcnt > 0)
f027184d93cf76 Dave Chinner      2022-04-14  617  			break;
020dee1bf99e76 Dave Chinner      2022-04-14  618  		if (attr->xattri_dela_state == XFS_DAS_DONE)
020dee1bf99e76 Dave Chinner      2022-04-14  619  			break;
f027184d93cf76 Dave Chinner      2022-04-14  620
f027184d93cf76 Dave Chinner      2022-04-14  621  		goto next_state;
83c6e70789ff37 Allison Henderson 2021-04-19  622
020dee1bf99e76 Dave Chinner      2022-04-14  623  	case XFS_DAS_LEAF_REPLACE:
020dee1bf99e76 Dave Chinner      2022-04-14  624  	case XFS_DAS_NODE_REPLACE:
83c6e70789ff37 Allison Henderson 2021-04-19  625  		/*
f027184d93cf76 Dave Chinner      2022-04-14  626  		 * We must "flip" the incomplete flags on the "new" and "old"
f027184d93cf76 Dave Chinner      2022-04-14  627  		 * attribute/value pairs so that one disappears and one appears
6e971e92677394 Dave Chinner      2022-04-14  628  		 * atomically.
83c6e70789ff37 Allison Henderson 2021-04-19  629  		 */
83c6e70789ff37 Allison Henderson 2021-04-19  630  		error = xfs_attr3_leaf_flipflags(args);
83c6e70789ff37 Allison Henderson 2021-04-19  631  		if (error)
83c6e70789ff37 Allison Henderson 2021-04-19  632  			return error;
83c6e70789ff37 Allison Henderson 2021-04-19  633  		/*
6e971e92677394 Dave Chinner      2022-04-14  634  		 * We must commit the flag value change now to make it atomic
6e971e92677394 Dave Chinner      2022-04-14  635  		 * and then we can start the next trans in series at REMOVE_OLD.
83c6e70789ff37 Allison Henderson 2021-04-19  636  		 */
100ba63970eed9 Dave Chinner      2022-04-14  637  		attr->xattri_dela_state++;
020dee1bf99e76 Dave Chinner      2022-04-14  638  		break;
f2d5674061121e Allison Henderson 2022-04-11  639
f027184d93cf76 Dave Chinner      2022-04-14  640  	case XFS_DAS_LEAF_REMOVE_OLD:
f027184d93cf76 Dave Chinner      2022-04-14  641  	case XFS_DAS_NODE_REMOVE_OLD:
83c6e70789ff37 Allison Henderson 2021-04-19  642  		/*
6e971e92677394 Dave Chinner      2022-04-14  643  		 * If we have a remote attr, start the process of removing it
6e971e92677394 Dave Chinner      2022-04-14  644  		 * by invalidating any cached buffers.
6e971e92677394 Dave Chinner      2022-04-14  645  		 *
6e971e92677394 Dave Chinner      2022-04-14  646  		 * If we don't have a remote attr, we skip the remote block
6e971e92677394 Dave Chinner      2022-04-14  647  		 * removal state altogether with a second state increment.
83c6e70789ff37 Allison Henderson 2021-04-19  648  		 */
83c6e70789ff37 Allison Henderson 2021-04-19  649  		xfs_attr_restore_rmt_blk(args);
6e971e92677394 Dave Chinner      2022-04-14  650  		if (args->rmtblkno) {
83c6e70789ff37 Allison Henderson 2021-04-19  651  			error = xfs_attr_rmtval_invalidate(args);
83c6e70789ff37 Allison Henderson 2021-04-19  652  			if (error)
83c6e70789ff37 Allison Henderson 2021-04-19  653  				return error;
6e971e92677394 Dave Chinner      2022-04-14  654  		} else {
6e971e92677394 Dave Chinner      2022-04-14  655  			attr->xattri_dela_state++;
6e971e92677394 Dave Chinner      2022-04-14  656  		}
83c6e70789ff37 Allison Henderson 2021-04-19  657
100ba63970eed9 Dave Chinner      2022-04-14  658  		attr->xattri_dela_state++;
6e971e92677394 Dave Chinner      2022-04-14  659  		goto next_state;
6e971e92677394 Dave Chinner      2022-04-14  660
6e971e92677394 Dave Chinner      2022-04-14  661  	case XFS_DAS_LEAF_REMOVE_RMT:
6e971e92677394 Dave Chinner      2022-04-14  662  	case XFS_DAS_NODE_REMOVE_RMT:
37e7bb8434f8b2 Allison Henderson 2022-04-11  663  		error = xfs_attr_rmtval_remove(attr);
d56c93997e96ed Dave Chinner      2022-04-14  664  		if (error == -EAGAIN) {
d56c93997e96ed Dave Chinner      2022-04-14  665  			error = 0;
6e971e92677394 Dave Chinner      2022-04-14  666  			break;
d56c93997e96ed Dave Chinner      2022-04-14  667  		}
83c6e70789ff37 Allison Henderson 2021-04-19  668  		if (error)
83c6e70789ff37 Allison Henderson 2021-04-19  669  			return error;
8f502a4009822a Allison Henderson 2021-05-21  670
100ba63970eed9 Dave Chinner      2022-04-14  671  		/*
6e971e92677394 Dave Chinner      2022-04-14  672  		 * We've finished removing the remote attr blocks, so commit the
6e971e92677394 Dave Chinner      2022-04-14  673  		 * transaction and move on to removing the attr name from the
6e971e92677394 Dave Chinner      2022-04-14  674  		 * leaf/node block. Removing the attr might require a full
6e971e92677394 Dave Chinner      2022-04-14  675  		 * transaction reservation for btree block freeing, so we
6e971e92677394 Dave Chinner      2022-04-14  676  		 * can't do that in the same transaction where we removed the
6e971e92677394 Dave Chinner      2022-04-14  677  		 * remote attr blocks.
100ba63970eed9 Dave Chinner      2022-04-14  678  		 */
100ba63970eed9 Dave Chinner      2022-04-14  679  		attr->xattri_dela_state++;
6e971e92677394 Dave Chinner      2022-04-14  680  		break;
100ba63970eed9 Dave Chinner      2022-04-14  681
e683cdbb8baf82 Dave Chinner      2022-04-14  682  	case XFS_DAS_LEAF_REMOVE_ATTR:
e683cdbb8baf82 Dave Chinner      2022-04-14  683  		error = xfs_attr_leaf_remove_attr(attr);
f589c4f3a7a7d6 Dave Chinner      2022-04-14  684  		attr->xattri_dela_state = xfs_attr_complete_op(attr,
f589c4f3a7a7d6 Dave Chinner      2022-04-14  685  						xfs_attr_init_add_state(args));
e683cdbb8baf82 Dave Chinner      2022-04-14  686  		break;
5d954cc09f6bae Allison Henderson 2021-04-26  687
e683cdbb8baf82 Dave Chinner      2022-04-14  688  	case XFS_DAS_NODE_REMOVE_ATTR:
e683cdbb8baf82 Dave Chinner      2022-04-14  689  		error = xfs_attr_node_remove_attr(attr);
f589c4f3a7a7d6 Dave Chinner      2022-04-14  690  		attr->xattri_dela_state = xfs_attr_complete_op(attr,
f589c4f3a7a7d6 Dave Chinner      2022-04-14  691  						xfs_attr_init_add_state(args));
8f502a4009822a Allison Henderson 2021-05-21  692  		break;
8f502a4009822a Allison Henderson 2021-05-21  693  	default:
4a4957c16dc674 Allison Henderson 2021-05-21  694  		ASSERT(0);
8f502a4009822a Allison Henderson 2021-05-21  695  		break;
8f502a4009822a Allison Henderson 2021-05-21  696  	}
020dee1bf99e76 Dave Chinner      2022-04-14  697
020dee1bf99e76 Dave Chinner      2022-04-14  698  	trace_xfs_attr_set_iter_return(attr->xattri_dela_state, args->dp);
6ca5a4a1f52952 Allison Henderson 2021-04-12  699  	return error;
2f3cd809196381 Allison Henderson 2018-10-18  700  }
2f3cd809196381 Allison Henderson 2018-10-18  701

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
