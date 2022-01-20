Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5399349459B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiATBqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:46:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:51861 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbiATBqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642643213; x=1674179213;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5nNrwOpg9zJKaWyW22GwarsdnXWo9qNRJyZlWyHf/c=;
  b=GhR0z+l5dHBsizOEtMr9mChQJ5RfoO5eWLiiqlHY77tQnxGbG5YtK1mg
   SLfR4zCgdqR0r4FxpkIw7IX3sXh3MMBwnvfLDHG30cQ9imDRqVOav6zNv
   HQvWjZSaVaGVJsKpITVUFSKLKlB2a8dhju5GuHc+89izCoAj7inF9FHHF
   fnF5V00VrKnwVxxIK83u6+OpUOj/fw+aZTTAfqqrAmNZqXNo7FyobXGVl
   EZCLpX4FGI1QKeNaOxwC14ZRw+W0kNG4AJiJFkAMv4eX+9JnWqf8I5tBz
   ZAHUa/1nIHmzKrSOuAcgIM9qWGArnzO1wzEjfyePSEEWQNWHAAlSY3DCB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="242807753"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="242807753"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 17:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="493256658"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2022 17:46:47 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 17:46:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 17:46:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 17:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR9VZsU2djYaJuRGQYmXFchpa6r7lW+dhrDC7pbjpQbOBugD8VvcjcixDQ+TlD9p2Bf+gIViGgxqzkJ8oFw36CkvMZ7FEmLkr2Cv9PU7dONEr7MDYeQoYc75Z0E1q6lT+8YMuqAjCwvziPfLpGfChXOYKJ8G2yJNJf9MktGLYr1/LO2dimQVwmFh63ekwQm8tYJ7n2CuGeExMQkmPDVEV+ztHDHsE3wvEeMiLN208ac0VKOMlSDNzreVCpa/YhV5bsNtc64z+mydASWPl/wKcZCBq/ej3QNUVYowOuxS3mAsRS7I/jq9yFZKI3X8bOAY9Fudg1hKzUaKdaaZFc/rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP6YQJlD59JzSBpOtlnvegllcaMaYNjqOxwAGxKJxek=;
 b=hMGUugWNpWdU7ZpmcWp0W3hCor0bzLHJy9ng9luiK7Cmqvd+fP/kdQiKiivYBRcgmvWkxiYMG/dt5Ls4RhZbW917bVlJoxQ2WKPf8pQJmTVe57ha+ld6dRlyBtu9GNDybM8VPD14CEpMsYroyzWdluarZhqsgptsxUOMtWbNvK+YxoEtwn+vCg+3KYK2B4iFpuTNyz7oXiAQLMdPqVBJ8o+JFuE5hxvkwdAkga83b3he0IfyZ3Hlt/4KTvLLNUQmAseuAnXvll6UG+8zEbXtLA+SP4sKabbGramIuc6VqyZTtbC40U4a6DoMh0pQQX1dFPuafqokAzMNFAjNvlQHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by CH0PR11MB5507.namprd11.prod.outlook.com (2603:10b6:610:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 01:46:43 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:46:43 +0000
Message-ID: <39230575-13ea-7384-71bc-2aac1fa2edb8@intel.com>
Date:   Thu, 20 Jan 2022 09:46:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory after it
 is freed [clang-analyzer-unix.Malloc]
References: <202201200359.lTk9zHg4-lkp@intel.com>
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201200359.lTk9zHg4-lkp@intel.com>
X-Forwarded-Message-Id: <202201200359.lTk9zHg4-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2babdf-70a8-4131-3322-08d9dbb6b5c6
X-MS-TrafficTypeDiagnostic: CH0PR11MB5507:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5507D258EB411A06F2C761BCFB5A9@CH0PR11MB5507.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzihLD9K8fffTswvbGNZsAOstFJYWSq+wV50fW2rL3VTnqQDvJBDG0vC4E88Y8NHuv4CvRjb0Xwy0XZuB82VIbaSyJILOhRSsuYTNANIBU8+Hhpjzd21rSj87LZlPXGEXpRebEzMAvo3zKjgKvZG4QBfsUi4g6WCyDNMScDh8IpfAQMHbwaVQKdnt3t21XHUI0ey43F6jUao92JPQcNqGRAZ3gRrwOKKXV20fSmXNerMSHvVzlQ2JCrCEo37uJ1FRjygB2YhT6kR6jd8Gu0t+vrFxTl0kR2oz4ADTF3sHtARTB/cbXlVl+N0s9SFmTzFRKL9di6tWWTRNTUyjRc0Lu7ARMnLGQFeSpBWssLMdtkYJZXNmjTIm12TlweKyvNHYNChvykYSt3XpJq47u923zqQqgLT7Kc571AnMimsD7jk+kCIhSN47MFd1rgaLL5TKuZWE7QAZq8uTI/K4dcPLcbzA8fscrRSwl5qvoR5Qn0dR1lsYjZoOp0mIErgXZjLw3xxKypKiE78v8Y/fbhDH28jtq0H6YauRvPh7UIpyW16mKi8OmTtj6a4UQyJVQYSdIQ9SFsgUHk7CjpbJ3uSYKV2M+waLoNG+Ld1fv0IKFryZoCfTkaTty5KXsk5lA/9alE/z7zAunQwFaeMykAregA/5RTAEO2TI6sgHU+uCYJtkpu0LMsDjX6+PxWQdzrO8wOdjuZFaX/XsKlJVgn5bXZR7paf1IXTvMoI16prOm3RH6jfYYNztYaS99p92pegZPdLQPXSIZnuAc0db1LQQIais2mTpKPaKxKORWvxoLa9a2wwZZj7eIGEqZWtcN4X8MvCnYT7JlwbnNH/CU+jfvce6APKlqTRZ3R2r9BQqmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(186003)(6506007)(86362001)(508600001)(83380400001)(66476007)(66556008)(66946007)(6666004)(31696002)(5660300002)(54906003)(4326008)(26005)(6486002)(6916009)(31686004)(316002)(2906002)(38100700002)(6512007)(8936002)(82960400001)(8676002)(2616005)(4001150100001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZOaStrRW15RzNDYzdpNXU4WXlHeWh2a0RnSE1Nc0R5VG9pRVUxbS9PRDh4?=
 =?utf-8?B?Wm5EaVJKb2N0TUVUWW5rd3lOTWNDT2UveDFwb25SZGlCcGVtcnMyK09CdjlV?=
 =?utf-8?B?TGpIamtJZWM4QnpkY0xPdEFoY3psOXo2djRFMllMMkdlQmR3UCtIRkxaQ1p0?=
 =?utf-8?B?S3M1VTY2bmdvOS9nV09iMXhpL2FPN2ovQUthMHB6YW4yL0NCZmFXV3JjN0cw?=
 =?utf-8?B?cGN1S08wNEl0YXBVNndYTjRQd3Q0YzFlcWxMRlIzL2h0ZmdvSGFLL1gxZlZm?=
 =?utf-8?B?MjJDSHB0NG9SZTQvSjFOV3U5UTdDbC9ieXM2bU0xdXVKYzZMNVVsQ09CNDVC?=
 =?utf-8?B?bnY0bS8rWk54aXR0MXpJYXg2VFNGM1lVbTF5SUxNWkliTTArekhRQUdwZE93?=
 =?utf-8?B?ODV1QTlOQU15OXppT2p4ODJHcGxnOUVWVjhjT3JGUzJkRFFtL3ZScUZ0RHox?=
 =?utf-8?B?TTRpdjJYTTZoTkJpLytBMjg4b3MwM3JteDE2dWJDTU5yNWxUTVluODA3bFFt?=
 =?utf-8?B?cTY1TzgyUk95U3o5YVgvb3YyZ3A1NzRTY0ZhWHRTNE41YTBFOU1xaytLTExO?=
 =?utf-8?B?RVlyUmh0UkJKaUZ0dXE0ckcyUU1JZW12N2tEVkhXRGVmOC9kcUE4eithVGJE?=
 =?utf-8?B?UVd2dWFubjJxU0lJbjdMM1V4VFRqS2gwTmtNQ2l4eXNJQmJvbTR5dWxtMHRm?=
 =?utf-8?B?dXFzUlZHMmVkV2xMWnMxT1FMUWJFWEI2QlJvQWpGRUI5bFJJRlhsbkhRMlR5?=
 =?utf-8?B?eTYxMGU4ZXBxeWUrR1dFQm8xczdIaWZROGxnTStiVUV3ZzRWZk1lUXg0ZDN5?=
 =?utf-8?B?UzllWWR0NjFFd2pLSTg0bzdoZEFJdnJMQzhYOGtyMitPUFVFNnNFWmc3NStK?=
 =?utf-8?B?TVl5WGs0R1lDamJpM1pFdnVkT1lEYnhqVjFYNmxsc2RieWxzTEdwRVZmcFl6?=
 =?utf-8?B?K2s0dG5yUGNRdEVERXgxZHR0WldTWVFGTnlONlhEaXZQTE9aOEdtV3BqczBU?=
 =?utf-8?B?SlNvbkxCbW5iMlQzL25HSjZmSGd2WCtqT21zRHN0Z2NJTjd0Rmh2dWdqelUw?=
 =?utf-8?B?ckNLb0NIMDd1a1ppYWdsVHozMWVVUzZhL0dNWGRFRlNJMHBVTm9JNVFBbDhS?=
 =?utf-8?B?ZWptRVNLSllZWXVwOTl3TXlBU0x0OStlRFh0NkpPTXNwbW1xSEk1ekdmeEdn?=
 =?utf-8?B?bnE1UENsaWM3VjhNK3MwSzlsMGFmNUJxS0NSTU51bjY3d0R5SkdLSkIvazVB?=
 =?utf-8?B?dE1zYXdKUjhKNzlmNzg5UFVlVFJZR1J0bXlrTUFwdnRKckdPaHBQZUZLcDdn?=
 =?utf-8?B?eXF5YVo5Zlhsc0doakhoblZmUitrV1dKbjdleWsyOU0vdzlFWGZmak9FdVdU?=
 =?utf-8?B?ZysvWmIwcnNuUHFrbFZ1TjhBdVFqK2NNdVB0YkYweHBGVDRjdE9QdUl4K2J1?=
 =?utf-8?B?ZFpxelM0WkJ6eWc2R3EwWWxBdlhtK2RwbWhKMTBvenU0VTBKeGdnc3c2Rmhy?=
 =?utf-8?B?eXEzR0NnMzNlRFR2ZHcxbHdsTngva3Q5c1BuTDdVa2hISXhhVVhjOTFONHRo?=
 =?utf-8?B?TkpkZWpIb1hOMURNUlp1K2J4RVNYRFBUMk0xMWxUV0ZRbzRtUjM4VjAyemNT?=
 =?utf-8?B?MExaVUZjU0ZiUHlzbGlyMXVqKzJuN2NGNEltRW5vU2d5NVNpTE9TT3pVYSt5?=
 =?utf-8?B?L2ltSHVUT1p1V3VRMFFhbUh1YklRVWlTNmRVcDVBZWd0ZDlZdFNMaCtsRnl4?=
 =?utf-8?B?eDJ2STRxTjl1UklxYXYzRnZBazlrcEdIbHpRN1YralJpK2pheXpMbStKcCs2?=
 =?utf-8?B?dzUyeTdDSTBhdXY3bUxQSy9KZG5WbjFlcnpGVVROUjAxMGQrQ1FuTUR1VjZ3?=
 =?utf-8?B?WFNpUVl0a0MyZ043ZnJWTmRmK29IK1NvaVB1ekkzdk1taUJSV2EzTzdEWk5E?=
 =?utf-8?B?TDBQTHJXK0VqMTJtNzhkWmpUaFdiaFd0dE8rbFlYUFQ1bndJUHZuaFVMYUlz?=
 =?utf-8?B?TWpLNTkwZUVlM2tBejVIQ3JrNGdRWm9ZQktwcU5OMmVlb1hMVXkvQ0QrUTdQ?=
 =?utf-8?B?MUNJcHlENVczdFBDSC8yMHBWajdRRlZZc1c5NFQvR2dzRmZNd3kwaXZ6MFlm?=
 =?utf-8?B?YVpVZkZTdlAxMkFhciticUFxSXJLQmh3K0MxRHB5SHltUkFPbFE2dHRHVjNH?=
 =?utf-8?Q?wRqOuI/4i6nVZNxAolAI0Q8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af2babdf-70a8-4131-3322-08d9dbb6b5c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:46:43.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxoaw9O1vWJnuLD/p5iDDheVTufIZdzfWLxZ8XGj1WI6DLx0wLJBGwEUmsezGmske8rm/wIR/Dqdp7KbsSPDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5507
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
date:   3 months ago
config: arm-randconfig-c002-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200359.lTk9zHg4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 9645ccc7bd7a16cd73c3be9dee70cd702b03be37
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
            return &psc->hw;
            ^
    arch/arm/mach-ep93xx/clock.c:151:2: note: Taking true branch
            if (IS_ERR(clk))
            ^
    arch/arm/mach-ep93xx/clock.c:152:3: note: Memory is released
                    kfree(psc);
                    ^~~~~~~~~~
    arch/arm/mach-ep93xx/clock.c:154:2: note: Use of memory after it is freed
            return &psc->hw;
            ^      ~~~~~~~~
 >> arch/arm/mach-ep93xx/clock.c:484:2: warning: Value stored to 'hw' is never read [clang-analyzer-deadcode.DeadStores]
            hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 >> arch/arm/mach-ep93xx/clock.c:612:2: warning: Value stored to 'hw' is never read [clang-analyzer-deadcode.DeadStores]
            hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +154 arch/arm/mach-ep93xx/clock.c

ff05c0330b9880 Hartley Sweeten 2009-05-07  125
9645ccc7bd7a16 Nikita Shubin   2021-10-18  126  static struct clk_hw *ep93xx_clk_register_gate(const char *name,
9645ccc7bd7a16 Nikita Shubin   2021-10-18  127  				    const char *parent_name,
9645ccc7bd7a16 Nikita Shubin   2021-10-18  128  				    void __iomem *reg,
9645ccc7bd7a16 Nikita Shubin   2021-10-18  129  				    u8 bit_idx)
9645ccc7bd7a16 Nikita Shubin   2021-10-18  130  {
9645ccc7bd7a16 Nikita Shubin   2021-10-18  131  	struct clk_init_data init;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  132  	struct clk_psc *psc;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  133  	struct clk *clk;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  134
9645ccc7bd7a16 Nikita Shubin   2021-10-18  135  	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  136  	if (!psc)
9645ccc7bd7a16 Nikita Shubin   2021-10-18  137  		return ERR_PTR(-ENOMEM);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  138
9645ccc7bd7a16 Nikita Shubin   2021-10-18  139  	init.name = name;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  140  	init.ops = &clk_ep93xx_gate_ops;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  141  	init.flags = CLK_SET_RATE_PARENT;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  142  	init.parent_names = (parent_name ? &parent_name : NULL);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  143  	init.num_parents = (parent_name ? 1 : 0);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  144
9645ccc7bd7a16 Nikita Shubin   2021-10-18  145  	psc->reg = reg;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  146  	psc->bit_idx = bit_idx;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  147  	psc->hw.init = &init;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  148  	psc->lock = &clk_lock;
9645ccc7bd7a16 Nikita Shubin   2021-10-18  149
9645ccc7bd7a16 Nikita Shubin   2021-10-18  150  	clk = clk_register(NULL, &psc->hw);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  151  	if (IS_ERR(clk))
9645ccc7bd7a16 Nikita Shubin   2021-10-18  152  		kfree(psc);
9645ccc7bd7a16 Nikita Shubin   2021-10-18  153
9645ccc7bd7a16 Nikita Shubin   2021-10-18 @154  	return &psc->hw;
ff05c0330b9880 Hartley Sweeten 2009-05-07  155  }
ff05c0330b9880 Hartley Sweeten 2009-05-07  156

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
