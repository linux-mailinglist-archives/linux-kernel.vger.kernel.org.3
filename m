Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFC529AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiEQHSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiEQHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:18:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5848316
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652771905; x=1684307905;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5TsKJzOzc9bnUC4rCNumvQfeBOf+AI6Io5nZF/0XTQ=;
  b=CDVh31Nj7SOpcwRH3GhBCGyL1zks3m7dw2xYOQf0sv8vBKU72GZcZnkK
   lR5i9zt+1QS8zOUj/xK9FM0PooheCw8TisJtmMmaTOffcvjuIzor4SphZ
   9iGQkJbYQew7cmA1tdjBFV9KzQ+0fDwVpkEnrjyhDnAfQjiDJlFpgtTv0
   BqKzBAkqDXBu7a0Zavoe1n7V/H1YyVAPd7/NdDN0p9RFYec20x3/0fXiR
   NPpO0mwTUYRu/szBSeIDACP3V1ZS8bnEpZOgy4WdQAJWuWscNnOmRtacL
   qO+DYDfUS84AWLzsQTCYk4vQRWnmdLpFdWNCDjRLkpArXZlucSIa7YZQt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331708543"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="331708543"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="596984908"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2022 00:18:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:18:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:18:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 00:18:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 00:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEkZwfDAySoc09dnv9br6ZBTIjR8nyKeYcJzB6hElQj0/2D9qqwdbKQx7kNcFaOWs3L/u+pNLkg9BJhNXZ7aCBYmEAAO0ZQ2JykuRUbdgSuUMBX2Td344EkIGzQIhvhZ8liv+DW9REz2BjcooynusxJbh51H/OBLU/R6cignuizaKahWgqPJOcnYNmqdpJi0C5zwDxnCLSfNSq/pAt2qYT5lFlqwJawEc5HY0OZUYJHUGQ0IxFNzw9M6zXos9+F24oRW2ywmS8mdjR81tZUhrZoYZXo6U4L8QU7LCQ1GVfhzlnR0c1PHM5wUoe8hS0cxry3MTR4A2appgONIxauoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hd2CKx43y7W/PGxDkIq0uuYoy1miTzDVaCbk5uuEKI=;
 b=P8WBlkeQBKVXEjlAEELnHSDTMIHUQOJKrcQkg9tVE0ADPUxQM+tLrWwuLzcM1JqV/D/NYZkJV6WcgOZykBBJ53RbxNMNmo6nnQfYX1X9agkomYdbEv6sa5ekkvMepIeITojtN5CiwGefF7MAZnjmCn/Adb+N1L+N9rFUYbD9nwI3mSacLD/StL8qsfULp55jm7qyyXiJdwb+TLA8oLpjof775KJ6RCJ4RIcjus370Uzpw2tNyUkuF+6lQeOYUd/dHbeNYy2LFUrJTDUqdRnwVyvmIf2I4qDpmooSS6W1Pluo9Y2n5Rz9iwHk7/hO5N0ej4bQQ3WT/PzmBFmnvqh/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:18:21 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:18:21 +0000
Message-ID: <70a880bb-2f7c-c997-113e-247cdd93269d@intel.com>
Date:   Tue, 17 May 2022 15:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: kismet: WARNING: unmet direct dependencies detected for
 ARM_CPU_SUSPEND when selected by ARM_TEGRA_CPUIDLE
References: <202205171011.KEWPLwnA-lkp@intel.com>
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205171011.KEWPLwnA-lkp@intel.com>
X-Forwarded-Message-Id: <202205171011.KEWPLwnA-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac8e3f5-e763-43db-794d-08da37d56c13
X-MS-TrafficTypeDiagnostic: PH0PR11MB5878:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH0PR11MB5878BDB9DA69C011BA9E34BAFBCE9@PH0PR11MB5878.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAoSA3otlBQFFyaLmkexMhRd0P8WpwB6ykxrvxqPQjFxq+XNuh3END9n5NUN931Bqj+EI7D+Mt1ofVV7JKN5uWX0rYO3cskgqsnWdxXJFRf8h1+FN6Bm+slHHGjK5aoskEdMnuDUX8MUx2P97wCbj5GT/HxWey7Rg5jl8ewkM8oHflYMdffHuaphlv9xlYyIhVmXdecs/Br6tQXr49zy3A+T0E2U78rrWdBPavr5FODhb/cg+OVc/6eWQtimEjto9SySIcQbU/3Wxoy9frFgGuiXnsGBdkDynWo2qEt0CqrOAQBVGlOQwtW8XgjxHqZBoBJLAz8zTiRc194rCFbR46rNsw9gxh3XKGAcW/1TEoAZ+y0yhZTcDsye11Zh+dWTPw+2DLxebs6QRIDcrWIvL3Qxu9HZ+RFOw1uFvpsl0+4Zkjw5sgYi6IpXoq6EYCw+18AvdxaNtLP8vgxYld3+NxIci1mPPyhl/eNmv51wehkZRYXD8BPhMiwwADtuMFBEIgsGKaqseV8UfYOl5AZXi7bl4yk2+xLVGAvK2Bm0oJbB78mL/KpudUhZ4w53qUilT/0DMMooxxg2uwhQ5xu1ERSfW+Xnr4AKHlldVtoBVIwpEM9Fv3mXOl1pVU2hszVXv4l4MNV86ux+DuEzXsXNwCaO7bxerLT0vrXqwMCV/ybF6oNGqEkOw84g0OVgmyUezQCM7yYvMgBJKEJe5hGT5p6M/AxOSLpFTPGJSuwEul0ChvV6QICduwWn/FjURKoIJYz+lg//VPBDvAzIoAEeGqGQQ2ZuuLghTv3G2+gEMvTf5eZDSWMfI6EvmTurdCoRVNbQoiQ263+3uoMS7KQROjo19+wEVbUmAUnakQzI+j4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(36756003)(2906002)(6666004)(5660300002)(66476007)(6512007)(83380400001)(186003)(66946007)(31686004)(2616005)(966005)(508600001)(8936002)(38100700002)(6916009)(54906003)(8676002)(82960400001)(6486002)(4326008)(66556008)(26005)(86362001)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3o4dE11MUtTQzU5YmJqK1JBai9FeXB5WmNVaitBcDQwNDltM1NnZE9vSkxU?=
 =?utf-8?B?cXB6Zlk1cVJySUZaenVqZDhEZWJPTXlKbSsya2xUT2w5QzhueFdnblNHRENZ?=
 =?utf-8?B?WWQxUGYyMG1kcHJrb1F6VTJDUkg0V2NOQWZPeHZXdU5NdjBwVVdCa28xbS90?=
 =?utf-8?B?Z1V3a0R5bS9OMDhvL3kwdHpweWpRVUwxMk9TZFdDNXdERlNzaFlobUlxRG5B?=
 =?utf-8?B?WDhGL0tKKzJSVmpBTzBBZkt6ZmU2VnNZcE14N0VGZEFGZVdSU0JUckowVjlG?=
 =?utf-8?B?b3JobG5JZURGSHNBR2NnOWRSMGM2Q0k5QllDRlRMMHNPMnR4NllmUVdBVjZu?=
 =?utf-8?B?S25hcGdJYzA0aGJtaGtjRjZ6dFVnSis3MWcvQkFDWVBJSFovbHlPNklxTXhE?=
 =?utf-8?B?TjZKRnZzYTQ1RlhsTXdlLzdQcCsrTEZmbk9RMnNGWTlVdnFFL3AvYitLSG9O?=
 =?utf-8?B?aUliTlk1eDRPbG1JUlBjQ3NTL0ZyOUVNejhJWjM1OWVzeFBtU3RrOFMxczFa?=
 =?utf-8?B?bGhjeW9NUnlGRnFoWXluKzZUTkt6d1RuU2tqSVFWM1hzckFNeVkvbHB4T0pB?=
 =?utf-8?B?T01xa25HNGZCZEVlSVcvaFUvOHdOS3ZpZmg4YU9iZWRORml0Z2FaSlpJYkRM?=
 =?utf-8?B?Q1M0NFdRMnJTZFhkYkVVRHFWTDNYTkc5RXBudGluTUh2b0c0ZlZPTGdRQTlh?=
 =?utf-8?B?WnBEZmVFUTRtNlp0dG9DWUp1YllUUWhxMEQzTGV0QWRDdEJ1N2QvTDhDaDUy?=
 =?utf-8?B?THpFdnJkSk1PYnB5V0Q0aGtaaWpUMDZNQzd4NC9Vdy83TVFRcTVlZm9XVEcr?=
 =?utf-8?B?Lyt4cldKdVdRaFBHR0I5WkJBckVwcmdod3pZYklIbHZCN0FuTUlZdWdIYzd4?=
 =?utf-8?B?Nm5jYTdZVG1SZnd2TVR1aEp0M2hTbG1kcVNiMmRhK000UVFzZER4VGllbjZK?=
 =?utf-8?B?dWI0ZDkrYUViNGtyeFZobThCejNoYkRpTDQ0Qm85elV0bmtSZVVObDR4dWtq?=
 =?utf-8?B?YnQybnBWZkJZREhVUnN0U0wrWk5ubEJGVWtQZkUwU093V2JLQmVvNCtwaWx4?=
 =?utf-8?B?ZEhRbXI3NzlVa3QrS2R0YXBuOGpmU1hhazZWVy9yWk1qdDNBNnFLMllTV05P?=
 =?utf-8?B?SE1hQ2dRdlN5SG1VSnJGSmdINDlCY1ZDNjBvSU1kbm9tUjRtb2xJWXo2SjVE?=
 =?utf-8?B?RWFkaWNOUFNUaFpPaVZJMGhpQXIrTWRtUDFRcXh6RWtXZW9lSG1PaEp4YXdD?=
 =?utf-8?B?UVdXT3Q5cDdSN1dwRlVZUXVzQWhFbHNkeHhGK21WeDVMcWJobUo5eldObVhp?=
 =?utf-8?B?MFdtYnJVM1VWZk1hZE1CUHlXeVprazlDaE5FNXFnWDlNczkwekVHbWc5dnhD?=
 =?utf-8?B?WkNSaXpDNWV5NFRGbjlhUlFBMWwrRkdSMUpzZk5tWUU5bzZ2NUVrQ1BGQ2xJ?=
 =?utf-8?B?eHJ6cTJzVkVGb3hHODlJUWZsSys5MGZuVEVaRXJ1eEk4YlNRSVN0SWkxdDdp?=
 =?utf-8?B?K0FQNUxPeE9heU0vL3JhRC8xbkc2eUNDNllsR0s4TklDNTJYUnAyYWNKb2NI?=
 =?utf-8?B?QkFnaWpzZ1VuNWVzdVlxQ0l5bGI5SGhKMWFRbjdZQW1XaGltMzZzeGovTE5I?=
 =?utf-8?B?SWM2NFF5WGV3eW9YWVVWcjhna3lmQXZpTnpoaWJpVGdDV3MwSzJxaTEwNTlF?=
 =?utf-8?B?U2dobldaQldJLzEvSEpLTUorajkvZmQrQ3R1WHV6OFlvYVFOUEQyQU8wRE9q?=
 =?utf-8?B?Y1Z0U3VMNWpBM3U5VnhiOEtPNjY5ZHBJSVRzNDI5c2lVOUl3clBpTVRnaUNr?=
 =?utf-8?B?d1JZY2dLNWtOdmQzeXorSXhEQ204VXRhelRjV2Zrdk04S2JVdlRoMWp0V0x5?=
 =?utf-8?B?UEtOWlpXaElQNUtJQi9EU1ZjUFJQUk03QmVMTEdlUHI3b052UlFrWWJCS2V5?=
 =?utf-8?B?M2tFWmJON3lEREVEYlorc082ZllMaHJva1AxUVFyVy81Y3NsU0JtMFhTeDMw?=
 =?utf-8?B?c2ExdCtrNkFhbGFhZm9QZFBzbXZ4czNpVzJEVkxPRW01eG84eThVbTVldVJC?=
 =?utf-8?B?eTNwZE8xTHVQMUl3Q2pyb25GankycFBWb0V4Rjh4ck9Hakx6S29CL2M5Uisr?=
 =?utf-8?B?eUVMQmtjT0FkQmlDZkJWSXE3dys2ZjQyZ1hQMjIwbW9sTGdBK1pQWXI0N2FQ?=
 =?utf-8?B?ZVdEZTF3QnBhUUw3MDVWdXRweVhlVXVOd1BBdFJSTW5oTU1XNW0vZ3M5ZDVq?=
 =?utf-8?B?c1NMNWM1QUtwYTl1WS80VmxvUnJrZjdaRU01L2lmR3lnWWJyTSt6M3RtV0Vv?=
 =?utf-8?B?N01lY3M0cGRDc3NzaUFIUFByMHpmR3dTZmdMb0Z0UFFmMDZpZUcxRXVsVkxx?=
 =?utf-8?Q?Xf94h/b5XzRQ6w94=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8e3f5-e763-43db-794d-08da37d56c13
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:18:20.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N4AULqabpZQJVEUKOWnbvkc/WVoJv9dptnAnd30vWQFtUozRa2bypG90vPeyV1Kx4m6+qWyGh1HejfhMEiReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42226c989789d8da4af1de0c31070c96726d990c
commit: faae6c9f2e68e62687636a7d6e0517b3bf594add cpuidle: tegra: Enable compile testing
date:   7 months ago
config: (https://download.01.org/0day-ci/archive/20220517/202205171011.KEWPLwnA-lkp@intel.com/config)
reproduce:
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faae6c9f2e68e62687636a7d6e0517b3bf594add
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout faae6c9f2e68e62687636a7d6e0517b3bf594add
         # 1. reproduce by kismet
            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
            kismet --linux-ksrc=linux --selectees CONFIG_ARM_CPU_SUSPEND --selectors CONFIG_ARM_TEGRA_CPUIDLE -a=arm
         # 2. reproduce by make
            # save the config file to linux source tree
            cd linux
            make ARCH=arm olddefconfig

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


kismet warnings: (new ones prefixed by >>)
 >> kismet: WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND when selected by ARM_TEGRA_CPUIDLE

    WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
      Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
      Selected by [y]:
      - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
