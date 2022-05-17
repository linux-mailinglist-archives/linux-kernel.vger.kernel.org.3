Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C9529B29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiEQHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiEQHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:39:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD249928
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652773044; x=1684309044;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EuQUJ4ntQWTth6RVAZZsyQWpvTdOw17Gg03O6anopkc=;
  b=OOfcDSZhO3kAzk90ES6WMgLIUZOk2AkP93LEtfpmhLmqt9nXOqdPqgYw
   4r9czuGqHInDBAQlSYa23faTXkrp6QLdNa9ZWU6gZ1eu4lM0Cbk4PDvtY
   35oqEJ5lJvRkQgLp4GG5Xn2FGeBOeqXE25d9w4jCxfeWknGBLZJ4mt2Iv
   YRzYM9Tr+mhpLULKgfF5g/cI4NvsWJ2o4VML1T9KaLNUTsvylN4S3BWtx
   6zyjo7HYPI72L/A52pPkoY5ANfOzZQZIgtB1gDdolDHo2DUaz3xgU7oFu
   ZbkCyIH9hKHAemDiMxvOHFfywQ9Xq+qBt/JkmohGYLTj2J1TxFnqn1bqn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="269921955"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="269921955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="713740364"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2022 00:37:24 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:37:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:37:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 00:37:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 00:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boe2PV0tqZxsrp1NjytWsUeJ2KNlyn8zSNqQ/xRgdVttzl4rE+OOWvOrpRFIA4nMNgmTyokVzUr0pFpy+IfrsS5vRXnZ2MNaYdHZEuiQ78Njd9phCaUcHMqlfVRViLrL1Rhtjyi7y3FJf8JunH2QZpepOxa1CZPtIxHJYEj85GSZJvftr+OAjyLDw23kKV8qDifDsHKWPSzML/Nf22VqBQD0bKiCWJ2uVjWDI/iZCh0Xu+ddZegVppUWZbvMI0M1zs6TbnIKngn6/V3x8/dS1U82QSkbo6gCANK7KHVYjBS62o2oGB98h1s4mzzWzw9xj2XzKc0+M31+6ECgnFJ+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC63QTat101Tl1OxNrZeQ6/30p69QG4xA5FwytbPGCY=;
 b=I8TmrW5S27/zG+81KmoRHqwLp9z3dDwX4Cy0hf/FX/rnp1oKHE7X+NmyEb/4lgPUfPjsAFjc2s2xLRFYO1NYLVXEVieFy6/CbncEXI1Iu4/GEbNcwXLfqIJdGvU6xWS3nv4xFCTANLlNvuUXjj3CUP3ZfnPi63ct/yeFmURtpomLKm+saJEsPA+zd017zy8UtQ7WzwT0AVhHrK1rZd+zVM1xp2N+pxVPn+GDvrbhtSIq4oFf9bFbO+LQ2R+ce2a2R7GazQqTbeYXbLOrhFCU+cz/fVyBT5czFEKGeYS4/16AKISizeutwv4uynnKNCCvTuAw4j2XvrWvftzTdCHkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 07:37:21 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:37:21 +0000
Message-ID: <1d5d45eb-d2bf-25e5-78f9-d9934d007e53@intel.com>
Date:   Tue, 17 May 2022 15:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: kismet: WARNING: unmet direct dependencies detected for
 DRM_GEM_SHMEM_HELPER when selected by DRM_SSD130X
References: <202205170208.Yt8FevjK-lkp@intel.com>
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>
CC:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205170208.Yt8FevjK-lkp@intel.com>
X-Forwarded-Message-Id: <202205170208.Yt8FevjK-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1a507d2-ad28-4ea5-a2ec-08da37d81409
X-MS-TrafficTypeDiagnostic: CO1PR11MB4817:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB4817C259139AF30C5EE14BD6FBCE9@CO1PR11MB4817.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJTPDQlXWZueME/vNS2JvAZIA7Vknx49rAGV/c2ZZUOQrCwe4ZKIYHLN4JXIoDe3XONbBniV/TYuUR3hdnwRt6rQ9xcab2N/2DWiJAvozBknfP1RsS37XnLniePO23FbiAORaLmCD47JxKQ1LfYED8Zx8G9G/w7Ip3FB7XJw6DOcG0Fn0vUuOr+tCjrD4FV4XSHhugfnO0A8lJ2/txXr0mJyw573UN7+4f0vGeWB0LTxsAGebsZ49yyHLEB1gc2qzhEq+ELWVSMGfkDfapqF2TTIGeSCJyO+4sIQLbnuEzzuy+r+bgZQtctmiZk5O8IlHIuvH4DhVLUhztsV/kVk3kK0ixZq3IpSWFh5CglEeHTs6dswevjVk7BLWPY64cpcA3ab7Oxiebol9dkHv4KBslsZ+BscMn135+yQk6bZh2ODRSenhe/7e0Vf4fRFvP3bi2E64euGs3WLwGVMWv0z2LJJ5cClGBjwgSujDEcYLPAMoNUW9YN6UUfeKGl6A8d27QyWkyoiTloCLfIvWvDdMThBlwb6vpGCq9xuiAJVvJ2HaOM08wU9r5E84z3AsyLTvuNH4Ieov+ldUD1kkF33D9DddZ+H52p/ZU9mGplJ59yVHy2bRadnLscDMbdZcUAv0zFAqXr+D018bgnig1w/QwTQYuHDOA8lRqSSV9Gmh2DXqP57aTkXtZa/wyTdQOEmEB4oC+illR8RKgJ9uN4Sh8BP4TidwZmKQhXF7OztUMCw3NamH6fUX+68MskG0lCjfFHF5DNIRXf+fwNLBXoSdswo+8zQNtRg88If7ygZSsd3u3uggXghd558zXo3MWYqKQHinl6K23aBR7wczeAqljz0gxSuItKEk7q6oByE2Y8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(6916009)(38100700002)(8676002)(186003)(82960400001)(54906003)(4326008)(86362001)(26005)(2906002)(83380400001)(31696002)(6512007)(6666004)(6506007)(5660300002)(966005)(8936002)(6486002)(66556008)(66476007)(66946007)(316002)(508600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBvNjBIMzgzUk9rZ3ppZkJGMzRURCtEdFZhQUJXZmRaQnFhRVZMdlJLN0V3?=
 =?utf-8?B?NTBaU2MveTFpZXQ1WXRnVzdPNkd4UlJvakNDY1JHVVVyYXVMc0cwUEh0b0dQ?=
 =?utf-8?B?dWxlOGJxWmxHRkFsSHZxZWNhK2E2SGh0ZndVbU94S2h0cVZpYTUzL3ROUHhO?=
 =?utf-8?B?aDBFTmc4VzRjNEhpVWFZVTBqMHQwL3hHYkE3dkFzV1ZUcXRqZ3dXVVhvcEow?=
 =?utf-8?B?Z29xS2VXUlFRemFEMWZrTGpHMHBEbm5DRHNYQWUzYURnVytWRTU4QW9sYjBG?=
 =?utf-8?B?Uk9JQ1NNclVpYWVGdjduYWxFZEppdXVhZ2JNUkx0eDZKT2x5VVNjY3dxcFJT?=
 =?utf-8?B?WUpiajVvY3I3Nm1DL1RSRExndmxtSytVRjNiRG1tOU5seXBvQ0kxZzBRQUhD?=
 =?utf-8?B?bmQ5dEpsOHJBWE5uS1NRd0psc0c3d3gxbFZacGoydFBqdDF1TW91ajlvT3NJ?=
 =?utf-8?B?b3JOME9RVEpsMFB3L0Vja1NmcndtYVJMM3BHUmdnU2Y0ZkhqT1c2bG1CMVV3?=
 =?utf-8?B?dXNHNWZ2OWJicWV2cDFsWlF2WVlFQVExcVErVXdRbUFucm5zYXllMEFJZUZp?=
 =?utf-8?B?Rm8rWjl6Q2NOcnJGdDFiSU8zWmlQYVdOaHphQ3krMzNtY1hyZUZLR3hBZStO?=
 =?utf-8?B?bVlWVnVNSTlBbkcwSU9LLzNVNHpNZmRzOEhoaXJXNDVQQmoxUmhscittSFc1?=
 =?utf-8?B?bHNHaFovc3hXdUh5WDJYTzFFVkhXTEVpaXpnSGYydEZBREtDVGpmYzBHc2VL?=
 =?utf-8?B?YUlOSWRpTXo4K2ppK2hMQjY1WmRuSlNyc0pEbUVtQitSbFZzSG1HaXo5UGRo?=
 =?utf-8?B?Z2tMcnhwTERQUFc5SnY1SU0wTG1hc05VSHE1NWhoeFloeEgxZU9td05PSzBC?=
 =?utf-8?B?OWFISm5SZWpGNXBDRjVjZEJBWUt2bktVY3dKQThiaTByb3AzNFk5K0pKS1Ju?=
 =?utf-8?B?MDY0eEdiVXFWUEk4TUFEOWs4eCt4VWlsY09kYmtnOGlkblRPbnVMNXBlYlA0?=
 =?utf-8?B?cHdPZlVWZTJDWXQzQVlnTkJ0RjZmN0ZWRk4wNytzZ1E0Y0djdzVINmNSdnVm?=
 =?utf-8?B?Z0xtRFBYU0srZVRNcldSNjRkWi9hZ2t5MGZoU2lBdktuTzJ3THNJK3FMd2hz?=
 =?utf-8?B?YnFwdkUzelhNU3kyQTlySUN5SnZDbnBkTVlvRk9EVXo4eXoxNTBjOWJMWkJs?=
 =?utf-8?B?Z2U1bEE2d041b094dm5pMHVzTUNkbzZBTy9DRUFwR2VGMVhnS2dqSlRIM29Q?=
 =?utf-8?B?YUQyVmhqd0tFUkR1NW1mSE9PYzU5VkFWMjEwR2RTb1NzNHVyYWc1c0dsMER1?=
 =?utf-8?B?TnpaVlJ2TU5iVjBUTjdyalM2Y1lvcGpvS3VwOUJnNUhPekJCTVI4R2hlZGtL?=
 =?utf-8?B?clU5S01oaFkvejYxWEhKRnptMVpjM09lVmRWR0ZDaVhBZXJ1NXc1eXZiWk1z?=
 =?utf-8?B?dC9hVmVaYU1CSHZ3VGxScVNYbDdlSVNGbCtWVHlhMldqcHFpZXFtOVVka1hq?=
 =?utf-8?B?c2lzWU5PSFJiSDFUQlZ6UHAvYi9EUDNnN3UrUXFYQWdBZkRMTVVySE8yS0RM?=
 =?utf-8?B?L1c3OElRVzZkQUpiZkFxTDdPT1NyMFpOR2VncVhRZGE4R2J1Z0dNT0tZTGkw?=
 =?utf-8?B?T3M3eWxKemh5Q3VnSVJTSnJ1OFdVUFFUOEdsOHhhVDZPbGFTejFTdVJiWFBH?=
 =?utf-8?B?NkdkcTNIcW5LaVAxY21ndTFQTjNsbGZVSzhjbU9lU1dyV2k5aWp3dGRtNnBs?=
 =?utf-8?B?cHFTMGU5bXhyb1B5N2VrR3NHTmoyUU9FWHV4RWVFRmFzd0JIbjZFaUJabi8w?=
 =?utf-8?B?R1VnMmRBU3pQdUZkOFBuemptb1NUeG5jUnJBR250VTJWUVE4WWMrSHRGcnVZ?=
 =?utf-8?B?STQrUi93U2dpcTNVM0hvZ2tmR3I5WWsyWUlWbmhqSEF2aVVxUmkxZmNHK2Na?=
 =?utf-8?B?MHJvQW9USFBlWm9lb3UxUEo0d1NWdGl4TTNJRkFHSVN0N1FrR3pNeDBiMmZk?=
 =?utf-8?B?cWs3VjROZ1ovbTVaZFhuSEEwUUlqdzRqdzV3YUcvMUZLdm85V1UvcjF2dnJt?=
 =?utf-8?B?R21lNUtrWjQrbjRQUVhPcEd6ZG1EVlY2dytidVBYc0RacFlzeDBpTzlJcVo0?=
 =?utf-8?B?S01hNnFLMFpiMTRtL3ZoSm11Uk5jZUZicUpwbzNTZFVRZ2tuVWgvRXJyUjU2?=
 =?utf-8?B?b2l6ckdCcXlQQThDUjBnNlBlYm8rQ3RJSlBjKzJCUlJOaGhiYTJHR05XS0px?=
 =?utf-8?B?RktFUnY2Y2p2cnF2b2o2OUpJZ3F6dDhRWXNrTjNBL0gzQkoyQUJGL3FsRm5U?=
 =?utf-8?B?cVZXZ1Z1UXBpYWFaYkxsSGNseFhDZlh5eDJiK2VKWEpRbXZFNTJuRDVoYVUz?=
 =?utf-8?Q?M2IbhQ6wTjakHmaY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a507d2-ad28-4ea5-a2ec-08da37d81409
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:37:21.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5Yze04DK5wsRhE6KjnwNJX5c2OzoGcJghCTi6ssjcueSVlrlwMY/U8RWoEsNOOKx7m6wRFiFNWxfjzyxC/Bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
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
commit: a61732e808672cfa8c8c6028bcf9feacb953ef40 drm: Add driver for Solomon SSD130x OLED displays
date:   3 months ago
config: (https://download.01.org/0day-ci/archive/20220517/202205170208.Yt8FevjK-lkp@intel.com/config)
reproduce:
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a61732e808672cfa8c8c6028bcf9feacb953ef40
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout a61732e808672cfa8c8c6028bcf9feacb953ef40
         # 1. reproduce by kismet
            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
            kismet --linux-ksrc=linux --selectees CONFIG_DRM_GEM_SHMEM_HELPER --selectors CONFIG_DRM_SSD130X -a=riscv
         # 2. reproduce by make
            # save the config file to linux source tree
            cd linux
            make ARCH=riscv olddefconfig

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


kismet warnings: (new ones prefixed by >>)
 >> kismet: WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER when selected by DRM_SSD130X

    WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
      Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
      Selected by [y]:
      - DRM_SSD130X [=y] && HAS_IOMEM [=y] && DRM [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
