Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0F46B6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLGJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:19:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:53248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhLGJTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:19:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237764989"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237764989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 01:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="479461905"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2021 01:16:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 01:16:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 7 Dec 2021 01:16:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 7 Dec 2021 01:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afI6cIwwJlVHWJGoeGSlNrXgANIyaWfQZP0rOHyWtFlElQE5YlEIDwJGuNvTCu9kbvSB+gZNKcaHhs6frY/kMgeZoR3G/QU6nMhPA86y0fx0/JqV1l+kyPGVvTCN/Evj8me7KU4CYkMV1EpefXa7YZw7JhhoE0DUDzfmm2pB3qHziI7aWS2hj9EGhIusU8f5SaTcqQbMWB6KqKI5XMgry3fvy83d0nivpF2V5epo7dHsoSdxzsloDepRjjIt3c3VF6uNEbat2uFjyZLhILu9uwkpL9LdeFNCa5mhvCggbPQA9nwJOzgjBML/WWZoXoag0w0NFUo8l5MTQSvyGsll1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56oNf2eD9gxr15Y2cxO9DpcmI+dln2QPKflO3J/sTs8=;
 b=EQhJDlbIvTWMw7hUsJvQJAqnAeQC/TOFkZLA6EJdauayxUkz+Ze02N5kFN4/6u+3SbdIffuGZH+cuEcg5iww9eROuj5NTLcgeSsv2XE3ztWXMEQgrrNhee0DFEQfaOK+V+UK5PzkIYMvMqnElR4zQDYj+z5CTB3j+n1odLyMQ73QWaLvzoaAatJalLXJuzGlu1VsJDnccKxEC5yU3G8jy7hRuBupTUdRQNiYirA15ZzVqI0Ns7QQjzT+oedtOVIioU3l98WtT0ppO6U8QyXuipcIFmjIwYokoL6wHN/7gKSJhGJzb1s/34Kr5ze4XHGRAV0q3njz+Dsk7ZQP0lbRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56oNf2eD9gxr15Y2cxO9DpcmI+dln2QPKflO3J/sTs8=;
 b=vgk6fOSQdbr7gjav8MtLpMZ4pQGAALC7O3LsB/jnpSp2iskFbCbOQhWNSDY6z797HKJNV5mcxJj+i6NPHcwkXsS/CLMgIot/yW2QRu5OkOXZtTOuORm2WF8xVT0QmHGJFGT12IDOYjN6Hp3papO7mLSg2Ik7aApyvpYBYQu839c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5646.namprd11.prod.outlook.com (2603:10b6:a03:303::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 09:16:11 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Tue, 7 Dec 2021
 09:16:11 +0000
Message-ID: <736272c1-4d41-55cd-b14d-c4820c5bcf8b@intel.com>
Date:   Tue, 7 Dec 2021 17:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:124:2:
 warning: Value stored to 'speakers' is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202111300439.S9nMj4kS-lkp@intel.com>
Content-Language: en-US
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202111300439.S9nMj4kS-lkp@intel.com>
X-Forwarded-Message-Id: <202111300439.S9nMj4kS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.143.18) by HK2PR04CA0043.apcprd04.prod.outlook.com (2603:1096:202:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Tue, 7 Dec 2021 09:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70935e89-f1fe-4efe-e507-08d9b9623581
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5646:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5646EFA594A0AABD2847656BFB6E9@SJ0PR11MB5646.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xACCo2XjFMK0InafF8ZWaHiH+Illxs0GRfJ6B1lJrHWgr/1xfrs/0krExPR9MejIF4b3u4XGDtnXajBajYmKuq3KvBKYhOINjWTWaC1nLWoabQRkmAG3wIRtOYoYRb3c9vnNKoRhE9vVFFJszA1BX9eyYiDQRqYpxgLMUtRpL4ihu7CfYXWN+xmBEU3LV3pkTf186Xl/0vOkzLYPPy8IML47yOcKPJOpPMHmp59K7HfhBiJBF2Cp3Lh7NH+YMmOKVLc/sSJvzkC+IbL6exeS5WSQk12rb+9oMUBg9Yrrr5y589HotJIPZCW2syOX1cEjVRLp+ZVWnEnzFO/hKzVG7kSoKTVVBv8AABMNeQuZhGyVYgdUPBQL9tVrQ7oJM4GNQBrAAlxCjyM9/+2U38CRmDRDLpxZ1H22fzy4wnte2DDjI6MI/ZW35ENIuxv+OrUdcvrNK5EdR6EmdkjPVKByAIlOivOjBv3shCAL1KlzheLIw9b8OyAAlCsWd9jzKaeAe0c7Hgd2rWI/GW2rcCnkfyqepoJPdMr9wScBf/jZ/HFIEQXE006cDe233zRsZH54LWr1sdw2mKVmdO1pe2+ZsPEqq/WnqnhGGc1St/PyBAMBkRnh8fe2tsg3OghJhIPn5DlPngaRIz1dBYXzKQNeUa2gGShsgBxiEDSNpAUBxrhH9+0pMHj6I8JOz3dn6KCQnzRMooXYOOD2ZNLMHEauwrZHbYEY5nc46JU4Qq9nIx8mvuMMcsKyKyVpT5xbLpDVIbI0bWEQ8FrOmJBDKX368qwCqPV+9JGJhu9r8qfoGhKYv/Kt9TRZ2hCQI9XFnhQXmUHxGHNBlSBvehzUGGCbhcDAVguyzdofpsfJl5Cqbg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(2906002)(54906003)(6666004)(36756003)(966005)(31686004)(31696002)(8936002)(16576012)(316002)(66476007)(66556008)(6916009)(8676002)(66946007)(83380400001)(508600001)(86362001)(186003)(6486002)(5660300002)(26005)(2616005)(956004)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhnOUZUL2x3YWw3Wll4SHBaNmVsUFR5Yi82M2RHUWI3cENtN2NkUnZUTnIv?=
 =?utf-8?B?aWlheXVMWE1jbS9GaW9WUXFQVEphVHFTbzRBUnp5RTBUbERmeGF1Z3cyRnJa?=
 =?utf-8?B?bXJGanZVeDJKQ0tUQjlKRjBOWDZZcW03U0k1UlhuWERPT0M4MWZxME9IejVG?=
 =?utf-8?B?TXo5RktQSXA2ZzFoampwV0Y5RVlpOGJnN21WTGxGRnF3MUNaNmVRYmpGOGE0?=
 =?utf-8?B?RW9uODdsemdIbVQrQTZZbGRRMnl1Sm5MRHBHSFBETjhYemR5aVc1b0Mzd2ZS?=
 =?utf-8?B?MG1CN2JSZ3JUajZUK0hzWlV0RHNkYXlKc2dkK053VXFIWXprZFMwTFM0b1M4?=
 =?utf-8?B?eEtidDRNUFQweVdSWm91SlRoZ0hiMVBSeVY1aUdOOUx0QVpZa0s1MTNhZldZ?=
 =?utf-8?B?VktoV0ZvbE91OUF0MGE3YjhRRCtsQkZrWTd0MmJkZXNvaXVFVlBFWGVacVZq?=
 =?utf-8?B?b2F0aXZRSll6a1JpR0RVMzhGWU9EWitrQXZ1TVhXaVA4VmFDbkZDYS9SV1g0?=
 =?utf-8?B?TE5BT21hOFE4Mm4xcTdGUmVtSFlka3Uram9TTkNkYWNJdjBaL2pQYUZHOHdi?=
 =?utf-8?B?dU5acXcvc0F5ME5iL0Q2ZmJ3VWEvK3FLcW13WFJZM1Z2elZhcElGeVBKNGZG?=
 =?utf-8?B?RC8wZCtJeXdEdUdteHkyWlFRUnVPZlFjVVlkd1IweEtpZ1U4NkpVR0pTS1lZ?=
 =?utf-8?B?MkN2aVI2SEQ3OXdxcUVEejJ0dEExbkNxT0lIM3dQY1BCVkszZ1NzUkE1WWVk?=
 =?utf-8?B?aDRPWVJEdTI4Z2g1a0JuSWJ4Yng2WHpYNlZYRThRRHlVb04reWpRNS9GVEZl?=
 =?utf-8?B?cGFkbVJvbkhYQzFDSXhsdk8xOGZRU3ZOcTdXZTNoYnI1MzFXQld1bWZQUGVG?=
 =?utf-8?B?YnltVWJ4Tzl2Ujk0U3ExbjBMWm14R1puUWtiS05nY2JkTlFEVTNMTEEvTHNN?=
 =?utf-8?B?d1ZoVklhUUF3dVV0dnZ2NTFqVzZ3SDV5c2sxSXA5RmQ4aG1lQ2dMSlBydmh4?=
 =?utf-8?B?N2xnd2REOWd0d2ZSUEFjaDg1N1Bqc1g5L0lqQ3l3YlFtMU8yc3dONFB4cWlm?=
 =?utf-8?B?bzU2TUk0VWdBN0xVTDVCc1NEaWpVWmVOS0FxbFlrRVJEaEI4M0Q1V2N5YUsw?=
 =?utf-8?B?STN0MzFlSXRPRjAwVnZ0QXRJRWYxaGRMM2ZkT3daQ1dHSHd3VGgyWFlsSy9M?=
 =?utf-8?B?TUtJMXd0eWZHNE5jTzlGTmJydmlzRk9SWGxIVlY2b010YVE3bXh5bk56VWFZ?=
 =?utf-8?B?UEZwRy9uc0pWM2dnZm0wQTJPZnQ1SFdkT3JnQ0JDOHZsZzdyUngrQmJ3TEUz?=
 =?utf-8?B?aWRuRXZTRUhBZG5vSjJScHlhTkMwbVdrQ29HNUYwUE5lV2tYbjZGYU9kV0p4?=
 =?utf-8?B?cVVvTnYyRDdPYXZJWjBoaHJFbkU3MjRFRW00eEx6enRzd2ZkZ1krQjNIVHhY?=
 =?utf-8?B?UWVodmJmbitnTklxazlyK1MydXNSbC85M20yWFlyZExqcGYrcVZra0MvTEhK?=
 =?utf-8?B?RU1rcEtYZEdZZzYrbE5FNVQ5cmVUb3FHd1NwbmREcXJFdjVYanhEd29pZW1Q?=
 =?utf-8?B?SDRURDFVTUdEQ1ZhaCsxN2kzck1nckN3dlkxTHFwc3NJK3JWd2lDRnB1elZX?=
 =?utf-8?B?d3pSdGI0cytydy81L3lkSVpVaHFkWmpRQ0pwZDd5eWx3WFJZMTNBOGR6V093?=
 =?utf-8?B?ZWowalZsYUl5eDdPQ09aL3l6T2Z3eUU4WGtzWWpoYmZTNWgzajFsOGsrYWpZ?=
 =?utf-8?B?RkJNeVNNTEJUcDBkL2ovcHRhTXMwcEczVFVOeVhpTUhwUjZRYUV4SWU5Y24w?=
 =?utf-8?B?RXduMll0ZkQ4ZStCUTZRZmlaSzFLWTc5T2tTZjZmNVlIdVlmVGxUbTBNWk43?=
 =?utf-8?B?aTBBbVVhbU04enBDUXpBVmpRN2JGeE9kU1I4dlZQSFVWNk9WMVo3VG43K0JW?=
 =?utf-8?B?ZmRJR3lCNUt2czh0VFE4bFdKMUFEdS9TSU9qaUZIckFoWGdPd0VDdWhoNG1j?=
 =?utf-8?B?c1hza1ZPbmpiS3JSeDN0RlRpYkRua05JcmxuZllYNW9PcFhlUnFGMkk2R0xY?=
 =?utf-8?B?S1RDUzhYUjR5bXdCRlY2blkvbDhPRnZoQ0lUMkNBN1VlU2hkNGwyWlVnSW9j?=
 =?utf-8?B?YWJ6WWNOYnZqS05oRWp6VXFYdVRON0xmdjhMcm9LMVhNWUMzRE9EMnRhL3lL?=
 =?utf-8?Q?e+KJlrMQW+rId9/c3bxcDYk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70935e89-f1fe-4efe-e507-08d9b9623581
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 09:16:10.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK2mCu9hcFlqgRnxEj3kRjcWtPMcnontMqgP1wz/YFAPJEt044ao56ItcQqtyL6a4J8UtCPFUpVZiYEp+yTCtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d58071a8a76d779eedab38033ae4c821c30295a5
commit: 61452908a79ec936660494fb4b9f2a35ee42e6e0 drm/amd/display: Add DP 2.0 Audio Package Generator
date:   3 months ago
config: x86_64-randconfig-c007-20211128 (https://download.01.org/0day-ci/archive/20211130/202111300439.S9nMj4kS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61452908a79ec936660494fb4b9f2a35ee42e6e0
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 61452908a79ec936660494fb4b9f2a35ee42e6e0
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:124:2: warning: Value stored to 'speakers' is never read [clang-analyzer-deadcode.DeadStores]
            speakers = audio_info->flags.info.ALLSPEAKERS;
            ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 >> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:125:2: warning: Value stored to 'channels' is never read [clang-analyzer-deadcode.DeadStores]
            channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
            ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/speakers +124 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c

61452908a79ec9 Fangzhi Zuo 2021-06-09  108
61452908a79ec9 Fangzhi Zuo 2021-06-09  109  static void apg31_se_audio_setup(
61452908a79ec9 Fangzhi Zuo 2021-06-09  110  	struct apg *apg,
61452908a79ec9 Fangzhi Zuo 2021-06-09  111  	unsigned int az_inst,
61452908a79ec9 Fangzhi Zuo 2021-06-09  112  	struct audio_info *audio_info)
61452908a79ec9 Fangzhi Zuo 2021-06-09  113  {
61452908a79ec9 Fangzhi Zuo 2021-06-09  114  	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
61452908a79ec9 Fangzhi Zuo 2021-06-09  115
61452908a79ec9 Fangzhi Zuo 2021-06-09  116  	uint32_t speakers = 0;
61452908a79ec9 Fangzhi Zuo 2021-06-09  117  	uint32_t channels = 0;
61452908a79ec9 Fangzhi Zuo 2021-06-09  118
61452908a79ec9 Fangzhi Zuo 2021-06-09  119  	ASSERT(audio_info);
61452908a79ec9 Fangzhi Zuo 2021-06-09  120  	/* This should not happen.it does so we don't get BSOD*/
61452908a79ec9 Fangzhi Zuo 2021-06-09  121  	if (audio_info == NULL)
61452908a79ec9 Fangzhi Zuo 2021-06-09  122  		return;
61452908a79ec9 Fangzhi Zuo 2021-06-09  123
61452908a79ec9 Fangzhi Zuo 2021-06-09 @124  	speakers = audio_info->flags.info.ALLSPEAKERS;
61452908a79ec9 Fangzhi Zuo 2021-06-09 @125  	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
61452908a79ec9 Fangzhi Zuo 2021-06-09  126
61452908a79ec9 Fangzhi Zuo 2021-06-09  127  	/* DisplayPort only allows for one audio stream with stream ID 0 */
61452908a79ec9 Fangzhi Zuo 2021-06-09  128  	REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
61452908a79ec9 Fangzhi Zuo 2021-06-09  129
61452908a79ec9 Fangzhi Zuo 2021-06-09  130  	/* When running in "pair mode", pairs of audio channels have their own enable
61452908a79ec9 Fangzhi Zuo 2021-06-09  131  	 * this is for really old audio drivers */
61452908a79ec9 Fangzhi Zuo 2021-06-09  132  	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
61452908a79ec9 Fangzhi Zuo 2021-06-09  133  	// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
61452908a79ec9 Fangzhi Zuo 2021-06-09  134
61452908a79ec9 Fangzhi Zuo 2021-06-09  135  	/* Disable forced mem power off */
61452908a79ec9 Fangzhi Zuo 2021-06-09  136  	REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
61452908a79ec9 Fangzhi Zuo 2021-06-09  137
61452908a79ec9 Fangzhi Zuo 2021-06-09  138  	apg31_enable(apg);
61452908a79ec9 Fangzhi Zuo 2021-06-09  139  }
61452908a79ec9 Fangzhi Zuo 2021-06-09  140

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
