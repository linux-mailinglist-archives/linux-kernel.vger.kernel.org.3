Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28DB49DB48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiA0HQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:16:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:56968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbiA0HQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643267793; x=1674803793;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/nR4stVG1jB8AQO88obrOdjyvL42keSMgIBuNHHWjA=;
  b=YMIXGelC6dB6D6Ea0Oen84qnRj60J7R21WKDhOSOxBxs5hrj9pqg8jRM
   /VVqqB1LmZQJqQfpl8BLIGO0pe7EjaeRvhwWjpNvi+6Ei8kShD8OV8b54
   qEwrza+O2UAIW0G1+GgRUYR/GiDHdqq3DwZTZR+kTMtOFK8DuZvhJ2EYm
   fETpCES9smJVv9z45rwYK4utWa0swYShJ8k6d/ItV3H44Qh0oseRv7ya2
   7l/r6+SWGLLp9we8jra+Pk9pZjP5CB436HS6BW/ht8u/8VmRDNG7QA4P+
   vCGOcHYQUWuisq/3EqNoMny+11tF2hfF9w76+sNAt1hPnL27t/EmkkaBA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307486881"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="307486881"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:16:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="535516392"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2022 23:16:32 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 23:16:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 23:16:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 23:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD0M6U875Ee0QvQ4jJTSaz6EIZlt54MKSbyap83bQN3VdrA0xdJW5MCDXE0wCdZVpfjHrvSvj3AdScxrCfroyRu1WMBdsomrqJGMPhpCGoEwj+SPCo+uuBFVy+/2f3U7uZI6KcGqQX0KBvBItR+Xe3pNxlyv1puWz8ZV746NUFp/RR0pYEjYjBSFcWIUZUwh0G7evB1pza5IylU7uxItcZ0fANJODBCsO3GU9NwqnMe0Qi8GB/j+u6iKYJoWmKMADEzZoh159KCrOvNL7An9NOrqrSTtU6XOM6kXrqU7X3KwJMUzCfoXRlxYwd4He2Y13x3vvPqWcLehwl5rKfpI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5O73W7aJxy1tFAfEvbDy5IzBq0cvN24dX+Jn7EvEiI=;
 b=MDsVcW85yatMKKljoy2U6BX836e1oNmMLojwdcTE+uG7UAK33adm993iTKiiOLYb6mk/Pe5Sv3pZKIkNm8r7WLJHWitJFaaUjHjCnuehgAOAwEvJ6F+Tjwe/uDmCgu1ZRMGuATGDE+wD9AghkMUbT0lZgt2r3kAUPkz/OaTm6//29nEVxVIqc7rHQjvPMp2s9JgZOyOU8qCRXDLRSNgBeOczvJ1ifGzCCqZKeYOIaz5iT+CRTSDQ/uuizvsA6bHI+nsJrW61XiUrC5zKz4E61nb/TKqKY3Aw6+dWifucS7zzwcQDRx1r+MzYCatDL7DUpgHExvrZ02oL0rbns1Uycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 07:16:30 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:16:30 +0000
Message-ID: <200de1bd-0f01-c334-ca18-43eed783dfac@intel.com>
Date:   Thu, 27 Jan 2022 15:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: drivers/net/ipa/ipa_qmi.c:128:14: warning: Value stored to 'ipa'
 during its initialization is never read [clang-analyzer-deadcode.DeadStores]
References: <202201270925.F8g9FeNj-lkp@intel.com>
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201270925.F8g9FeNj-lkp@intel.com>
X-Forwarded-Message-Id: <202201270925.F8g9FeNj-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:405:14::24) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c971b5d3-dbda-4e04-e03d-08d9e164f039
X-MS-TrafficTypeDiagnostic: SA2PR11MB4793:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4793ECF104A45D70F40401C2FB219@SA2PR11MB4793.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0C2uXNqsLwDJ//hf6ESLlqRco50EwCNb8Kv/MSDIk51VrQbn5dZFfMkbO1hQ50pvfr7faXpKvwa1LIyrkzoBYZ/pu8jH29wfvQcS7lWO9BCMg0c7S3nztQxRrVgX66WZH4FPgva7hIwcQvyc443oQb5ZMn8Rf5WqkXyLLH3ONig+rkSazcx9gRKpgOeIaJrxx7bEKH0jRKl7KE+4pQmQphI4cVF/3Ox9Dk5ZeJboa+7o7iMWbzzw7gANLHBPUseW/I9T+raPyL5EvDVD/Z6HyRJFtdjceyPuTVYUZ2P540bO866oG8wBkJfTY57KA7fXLws3dBWZoNHKASyuWh15ivD6yfMzPOlwnSLM+C/GyBfxTKbeBIsg84MPB9DGpvGxIsAF9alUMufoRHpTF+4iqSVeTRKiFFksef1aJ948fLhSxWRGWMlgFMgFPCOPF9PElX9UGVte+HFuu9Q9xBXD8aLrK+Eh0J6xF2D227oYkQMsb/L2wthuiaxRQPhz9PbkBn1VbzCX0XgTYPvrS5IuKhq7G2Hl/DD14KH/IpGBWCCMsXkcrxBmut+zNyXk72okI9jagP0rG3EkrUOmpiW87JY9E3Q09BYyc/H+D0cB3NR7QuM+oiLGYhKj1Wx/U/+9KpgkflFHsLnA201Wt2IF91oDlnr/xiBAsqhUD9xDtp9M1x9ZexlMRAHaBUNRmOnWYgdahhDG/lgMPFTrFu17MjQTfw4F/JSHcv2WihAWlxvbAeludQO7CSFTPLHrt12qBvIA+9uxZoR32LwA6MzyhuFF2ko7Pko5HXDXAYmCfCW/BzUiXJwmmxMge4mKGrpQQXEsnK8ISbqrkfvxFvxMKoIoTEkAAdBCkZXPM3usYuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(6512007)(6486002)(508600001)(82960400001)(6506007)(5660300002)(26005)(66556008)(6666004)(83380400001)(186003)(8936002)(86362001)(36756003)(4326008)(2616005)(6916009)(31696002)(966005)(31686004)(66946007)(8676002)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5vdHhOeWpaaDZ5dVgrRGcrUzgxblAvS2lnUGdzemVucjUxZ3BidnJWV3JV?=
 =?utf-8?B?MzVieDZ5KzVwdjU3T1oxNmNScVpONGJZR3FXNEY4WlRKeWs1dS9GbFpucmp2?=
 =?utf-8?B?MWowUHdVSnpMUTB4QWhYSmdNRDg0eElnd01OOFdlaFBPalRpSVpvcTlSa2Fw?=
 =?utf-8?B?ay95V1FsQ3BQMmp6ZnBsZC8yVTA4L1lWMWlSdXZCM2ErN2pNQkdsRmhPR1pK?=
 =?utf-8?B?MmxVcnlobUpEbVZXMWE3dzJQVmNZdFBJR2ViOUllRE1PUTlsV2hEcDBHRlJm?=
 =?utf-8?B?eTNDWEljTnhVL1M2TEUzc3V5ZWFMZEVsNTRGREhGOFR4ZzFaNk4yWFBLSVpp?=
 =?utf-8?B?Yk1Bc3NYSkxPMkFGdFNXVlVUUFdxbmlkKzU1NkllWlZmcUk2KytrYyt6a2lU?=
 =?utf-8?B?UmFyQUpoM1JJWHk5STJyS1pnNHAzSWFzSnpCQjgvSFVJS0NyVzdYbSt0VkVB?=
 =?utf-8?B?YXBOdmxLenpaS1JiT2ZpK1JvY2Q2THNhWVFUSXk4MlBGQThVRThkS3djUkQ3?=
 =?utf-8?B?M2NZQ1MxTnBqcXFjcWpRV3NUYXJYVkpZMnJiNk1kdThDRytaUkJiTzJNUy9T?=
 =?utf-8?B?bjYrbzFQcXhtN0JlSURBTEUwRHBQMkZwM1l2RG1QbHREK2J5V3lMV0JmVHgv?=
 =?utf-8?B?WC9Pb3M3ZWVNSHQxbVVoK1lLN2NCRFJQR1VnR05iOVBZNWhWbzUvTUFZS2Nk?=
 =?utf-8?B?OXJsc3BEbUttcFpnQk1nRU4zOUFjSjhIcG9DRnRSdzhnOHNFSzRwblR6R3E5?=
 =?utf-8?B?bEgxM1NZcVl5ZkJmZlh0QVpzcWRiRkxhWU5tWWJGcTdCNUZwb1VDRjMyZE5o?=
 =?utf-8?B?c1dvQ0FiK052TEt4d1IzQU9mclhncDY5T0ZWb2M0d1VRQkxhYmhQcXRJS0xS?=
 =?utf-8?B?TEZGTEhmMVJMYWVSZVhGNjZZS1IzczRhLzhNZ2FNYi9TVHhWVWhpMG5uS2Z0?=
 =?utf-8?B?YnNIU3ZGaUM4QUtVQjJ5aHR1L3JlUFNIQXIrSkdXdEs3TERFNkpDVlV2QXNJ?=
 =?utf-8?B?bFJsZkRxcHR6RHVQZ01sVFdrMDNXLzBCS2RSTmRWejdoVURZTTF1VVdFYTc2?=
 =?utf-8?B?U2RrOE0vdmJPZjRqbS9ydnhxQnNIeG93eEJqVGJ3cVdQdGhsOHBXN0VhWHB2?=
 =?utf-8?B?QUJVOUVEL0s4QjR5S2FYQUtKdXVqQnE3aWQ2Q2VDU2RuMjM1YnFRcUV2dlBq?=
 =?utf-8?B?NWpEQnE4TEo1MFhwdllQOHpRbEFvemRqUmo4SngzZTNleU1qUEw0aVJQQkFn?=
 =?utf-8?B?V2U4TFlKbUY5emt0LzlDUmQ5MmFuQjJIKzFvR0U4Tng2VVZmN3RvajNJU01K?=
 =?utf-8?B?R25DOWlENU9Qdzl5MDFBQkRKRDJsY1hMSkxaZnc2L00xQnRyZml0eHdnWElu?=
 =?utf-8?B?cVYvenNDeVV0Vm9hZ29NNEp4U1N0NG1DenozRGc4OWVlUStmL1poV0ZpWVRH?=
 =?utf-8?B?am1EZEVTYkl2M095dWxBS1I4ZWxKYkgwblFzaE1ONURuK2U2OHdkSEdUbTNo?=
 =?utf-8?B?N2EvU05leE9JQmJTSmdTYTEwZ2RlNkFBVjhaTVJFWXNpcG9xMFZpWDQ1azBy?=
 =?utf-8?B?RUNIaFpCQU8xTlRWK1lDNXdEZzc4TmY2ZjBxZVJ6VE5vUnZ2R3FrMXJHdXRO?=
 =?utf-8?B?aU9mWkYzV3dHWW90N0JPWElMd3FibUNQTDlJYzhkNXA4QXMva0w2ZytGSGoz?=
 =?utf-8?B?Z0pXdDN1S1d3OWZlT2NwTWFndkkzRzlwMjltTXlQNVVGSWZySTViZVA2VDlp?=
 =?utf-8?B?WXlWOXhMbUQ1VzJ6OUk2SWYreFBPbmF4ZWFxVFB1U0FtaklYS2Z1SkU1aHIz?=
 =?utf-8?B?M1RuVENkUHgzU1JENGdLSEFadkV0U0ZCTlhEK2djMjlINy9aZElkc0FUVklw?=
 =?utf-8?B?cTBlbG9BeTNaSmlJTTVKdkxmb2JpWUt1ZWtLTWFkRHAxNGRaUWNvNmNBUHk5?=
 =?utf-8?B?aDFBOFo3NWc3eUdkN0hwb0VwU2xaNCt3RnpCdUM1Q3o1TmlRVHZyNmxnUUpw?=
 =?utf-8?B?VUlYbDhpNWFnb3BJSWVoK3dFelZDRE9VcmdSSjRUdXVZeW5xYWlrdlRzaER4?=
 =?utf-8?B?OHZIbUJhaFg2cFVjR25rWmxkTHRQcmFvVndDRkF4T0ZZKzZCREhMcFRGZFFO?=
 =?utf-8?B?NTgwK2tsNzh0Q2E5czFUZStrRlp1UmNVYS92L0FubU1GK2JtRkxqSDZDUzRD?=
 =?utf-8?Q?Ztjp4vNGT+PbTFCBfPXSATc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c971b5d3-dbda-4e04-e03d-08d9e164f039
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:16:30.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM56Dn1fNK+08AU4ZEa3DIXvEWcdf0xrT5mXH2YDZl1KH2HDxN0qyj9/2TNBDo9mTKOj1e0KdedpY4OqzSYxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 99e75a37bd0af8eb8a0560f48091672b1b6d9218 net: ipa: relax 64-bit build requirement
date:   10 months ago
config: arm-randconfig-c002-20220125 (https://download.01.org/0day-ci/archive/20220127/202201270925.F8g9FeNj-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=99e75a37bd0af8eb8a0560f48091672b1b6d9218
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 99e75a37bd0af8eb8a0560f48091672b1b6d9218
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/net/ipa/ipa_qmi.c:128:14: warning: Value stored to 'ipa' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            struct ipa *ipa = container_of(ipa_qmi, struct ipa, qmi);
                        ^~~

vim +/ipa +128 drivers/net/ipa/ipa_qmi.c

530f9216a9537b Alex Elder 2020-03-05  116
530f9216a9537b Alex Elder 2020-03-05  117  /* Determine whether everything is ready to start normal operation.
530f9216a9537b Alex Elder 2020-03-05  118   * We know everything (else) is ready when we know the IPA driver on
530f9216a9537b Alex Elder 2020-03-05  119   * the modem is ready, and the microcontroller is ready.
530f9216a9537b Alex Elder 2020-03-05  120   *
530f9216a9537b Alex Elder 2020-03-05  121   * When the modem boots (or reboots), the handshake sequence starts
530f9216a9537b Alex Elder 2020-03-05  122   * with the AP sending the modem an INIT_DRIVER request.  Within
530f9216a9537b Alex Elder 2020-03-05  123   * that request, the uc_loaded flag will be zero (false) for an
530f9216a9537b Alex Elder 2020-03-05  124   * initial boot, non-zero (true) for a subsequent (SSR) boot.
530f9216a9537b Alex Elder 2020-03-05  125   */
530f9216a9537b Alex Elder 2020-03-05  126  static void ipa_qmi_ready(struct ipa_qmi *ipa_qmi)
530f9216a9537b Alex Elder 2020-03-05  127  {
530f9216a9537b Alex Elder 2020-03-05 @128  	struct ipa *ipa = container_of(ipa_qmi, struct ipa, qmi);
530f9216a9537b Alex Elder 2020-03-05  129  	int ret;
530f9216a9537b Alex Elder 2020-03-05  130
530f9216a9537b Alex Elder 2020-03-05  131  	/* We aren't ready until the modem and microcontroller are */
530f9216a9537b Alex Elder 2020-03-05  132  	if (!ipa_qmi->modem_ready || !ipa_qmi->uc_ready)
530f9216a9537b Alex Elder 2020-03-05  133  		return;
530f9216a9537b Alex Elder 2020-03-05  134
530f9216a9537b Alex Elder 2020-03-05  135  	/* Send the indication message if it was requested */
530f9216a9537b Alex Elder 2020-03-05  136  	ipa_qmi_indication(ipa_qmi);
530f9216a9537b Alex Elder 2020-03-05  137
530f9216a9537b Alex Elder 2020-03-05  138  	/* The initial boot requires us to send the indication. */
530f9216a9537b Alex Elder 2020-03-05  139  	if (ipa_qmi->initial_boot) {
530f9216a9537b Alex Elder 2020-03-05  140  		if (!ipa_qmi->indication_sent)
530f9216a9537b Alex Elder 2020-03-05  141  			return;
530f9216a9537b Alex Elder 2020-03-05  142
530f9216a9537b Alex Elder 2020-03-05  143  		/* The initial modem boot completed successfully */
530f9216a9537b Alex Elder 2020-03-05  144  		ipa_qmi->initial_boot = false;
530f9216a9537b Alex Elder 2020-03-05  145  	}
530f9216a9537b Alex Elder 2020-03-05  146
530f9216a9537b Alex Elder 2020-03-05  147  	/* We're ready.  Start up normal operation */
530f9216a9537b Alex Elder 2020-03-05 @148  	ipa = container_of(ipa_qmi, struct ipa, qmi);
530f9216a9537b Alex Elder 2020-03-05  149  	ret = ipa_modem_start(ipa);
530f9216a9537b Alex Elder 2020-03-05  150  	if (ret)
530f9216a9537b Alex Elder 2020-03-05  151  		dev_err(&ipa->pdev->dev, "error %d starting modem\n", ret);
530f9216a9537b Alex Elder 2020-03-05  152  }
530f9216a9537b Alex Elder 2020-03-05  153

:::::: The code at line 128 was first introduced by commit
:::::: 530f9216a9537b58cdc2f967b5cd78f5dafb34c4 soc: qcom: ipa: AP/modem communications

:::::: TO: Alex Elder <elder@linaro.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
