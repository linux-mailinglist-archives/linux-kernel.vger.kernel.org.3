Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB84E9066
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiC1Irf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiC1Ire (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:47:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C88552E02
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648457154; x=1679993154;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=03EaA1Bpv2SfcSllGkZAA0IaPfURpmu9JknCDGhDdok=;
  b=YCgEM4zcZAQS3ppcfAOTcLIZI0l8g7JUb9+k+sDAhxO/q5j+ggumQTyd
   PiMZVUGsCOCuDtZ17Q8dB2YcB6B45lWkQsDyuNvkoEOpdu35CqBD3DK/v
   n8C5GCblFQoGzrwgLpC0k2caAhcx5OtTLspGWb/FMHBkBcnFkXr4MfRL6
   d5ayeE7wRyPZrDTcrng1p1aH2I5IGysku0F/EAlIWAEkYjqdxnSeufIxw
   K1ZmJt3yI38AWtyms5izDMzZaRZWb0vnhDIN0odHBNnxwNz8DCgeiEwX3
   uheaLE9Y/j0FqaV6Mo69wdyFCRHOhneee34GCIECdFdzgIqjCyei3wfjO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="283835582"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="283835582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="502437729"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 01:45:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 01:45:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 01:45:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 01:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWTYCAqyipOtyevRIpnfr+T4iMXsLpaBFhmAUdwiVXWlDe2yuvtRxjcaerPZBcXDeWixrDT3jzlg8ahfaNK34oJZI8k2HjLzVXkK80uVzXm6gttWZdpxLmQYE4fPkSYCCv7yreCoGwGir7f9Q4rEGqlKV0Alftj5ZrtFXPbsi2Nj7223Ud5yUR6xfrxXWmskAZRWtr7nyh2sr4Wub/R7GM6Z+lxJH9unhRJXGM9bNqc/MhrPgFykATpHYgD0g+I/d4avHd7+Z+A2x7Zbo9NtERQLm8qnCEK5oJ5lg/7Vapy3O/qzGpIR1Lj+huO2nUTTFU6gXNsoJg0I6a9LClXIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGjGxad/Ea2lLYSHpihr16tboV6CPwZjt3C42yBPUbs=;
 b=VyASC9Af0kUBvZKP2eAa8FShyj0pQAz2sb8fx8tE3BLz6qfEeZR8cRU1ivIbhNiWS0lCi67e4Rpp7gnZeA2SFpT5aPelqrcN/DnB3Bvmj5Se0yVSySylJ25D4tlXkyOpFedVKcZZFYrxUW2xSv7VZqDXQQl6Y1Ms3wDNZ7deSYwevOR6CIzEb3pFvUTYOA6/hGWawazf3YfpjihoZQvGJxGaatwypfF/QvOq3Uerfl1jD4dIYUJwXYPgeI/c4p07JGFOIa2Kcs7qfafapkufouvGZuOlZLNC1nuM2uF3kaHP+xA01vo5A/Gri5I/2+9GeCJSZz7FZmbWHJDbnFf1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 08:45:52 +0000
Received: from CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::d5ab:9ec0:b0c7:7bcb]) by CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::d5ab:9ec0:b0c7:7bcb%2]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 08:45:52 +0000
Message-ID: <cc33131c-f9df-6a03-7002-de5c281e6c06@intel.com>
Date:   Mon, 28 Mar 2022 16:45:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: [device-mapper-dm:dm-5.19 126/130] drivers/md/dm.c:1471:2: warning:
 Value stored to 'num_bios' is never read [clang-analyzer-deadcode.DeadStores]
References: <202203242338.J9k787ls-lkp@intel.com>
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203242338.J9k787ls-lkp@intel.com>
X-Forwarded-Message-Id: <202203242338.J9k787ls-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 731e99c0-c6ab-4170-4a7d-08da10975d4a
X-MS-TrafficTypeDiagnostic: CO1PR11MB5124:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB5124BA4BFE5EFC9A60BE7B82FB1D9@CO1PR11MB5124.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZmNpYEwDphTXNFpQGJYGdZeckIZyVUmWXFazHAYmwVIxxOXtjFPHd1UkxkY3AIdoB7PV2KDH6pY5WiW14BlOokB8Eu/MIBWBKaDr/D8GNVjeltMLMxKAZ/gOp8jhIU/YsNYG8WaqbIG5G3UseJLUG+x7d1Rs24NTkjrLSPmIsjzSznIKzDfASPcXCb87ejUZ3YEA8FywK6uBGr8OmL9W1Wa6al5oCgrCkDkALbh2xQMx5SFhiKJatVZaMlxJgTf0BmGbw6CU6tmV5CmIKG1zdU4FG8xkoS9bbGqDJuW3qhWT8do/Z0Wf6RJlJXylTnn+GSgWT4UqUzhqNr+2o1ZKcuoIp+YK/j6tQnrD1BxuO5cF21FSXbrCWnGOzL9Rzb+qtYgjsuY8/db0u2t9/xCtWcvmfabaK6ZOD25VOISmPJwuOJrw7tYlZMuj5Z1rp/n8eL5FkMcgtgGdQ3KR1gPqZqFF4pW1drGBNOMt+CONDq+wQs3hf50KxWUSCqUFepwezH6EHlLzSg/FxBnyJilc4vnhUth9DSSx7IWQ8AEKGr76lvb3NJ8JBmX83IjrOg3fQdzLVdLcbX/ssjbvKkDJW+q5cOF17npPF3ZGzFBHlQJQx+ir6bvrNB4oQ9BWmYjBvPF/jIQ/GG7DVk1Ks8uiC2izv8d8kwgTKgPxSyLKGZ4M7deMMiAM1kXBBXWocjVr5XWC5Rq4W9rylf7USFIihi4HpS/LlvpHgzzf2JbLRWxJ/Lhhd+oirAoj1DDdIa977FBh/usdSaTL595680J+VRnNHZCHXDCBSpNupvbmnkL71yAPC/45cukgHG+hFB2UjphUBNZ2bNMTx2WPKST31yJR42HGyNX63WhDYRDF4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(2906002)(86362001)(6666004)(31696002)(966005)(6486002)(2616005)(508600001)(8936002)(82960400001)(5660300002)(186003)(26005)(66476007)(6506007)(6512007)(38100700002)(4326008)(8676002)(66946007)(31686004)(6916009)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9EdGlrZUtzcjBWV0xIN0JteDRxSU56dk1BSUhlTFlVaU5YSC95dDlUbmRB?=
 =?utf-8?B?eURNNmZFajMvUlNyUDc3WXVTaXF3YmVycW1mYnJlN3MxVDVxNVU4dks5bDV2?=
 =?utf-8?B?TDdVK0EvcFQ4L0JQMHVwSGNtQ1ZvTXNxekJOdEFTK2R3bGNKRnAzeHh1OU14?=
 =?utf-8?B?aWVTRDY0ZEdsNnRXZjM5ckU5TEE4aVk5NUswckYzTDJ4d21PKzVJdm4yVzFG?=
 =?utf-8?B?MFpUZWFKdzJuclVaRmNFTlF2b2NZK3g1eTJwdVdKNUhENW01emFVVitITWdn?=
 =?utf-8?B?TitvS3hQWi9iQjN2YmY5MlpWdUNTSTVseExTN3ZIenlJdkxHMmZLZkk0V3Vk?=
 =?utf-8?B?WjdkamNGcUJiaDJmempFdmVRRWYxVEVXd0NDaHUzdmVGbVBkUlhGT1FDV2ZV?=
 =?utf-8?B?eHVJaDNaMjhyNlpDdjVoc3NreFlVclV6UzRid2tzbmpHSG9IYnlaYTQ5d0p3?=
 =?utf-8?B?UU84TTZ2MzIzNFNpQUU5TFZjdCszdm11WUl5M2N4Y3htUnQwNkppVTlLYkFJ?=
 =?utf-8?B?ajJVZjdNSldzLyt5YkpiaTFIMG9KUCtYVlp5LzlTaUFtVlJlSUwwZ0IwdlND?=
 =?utf-8?B?aC9RRVVhM3lIZ2FXSUdvQm1OWk45MWRvY2FKKzdCQlNhRWs0dkdVLzY5NGRV?=
 =?utf-8?B?MndlOUJNOW5sQWNqRjAram5zWmlmRTh1UEhlcGpEZnpwNEtyUnhtSVNJM2Rt?=
 =?utf-8?B?Sk50cmNiaHBOSW1vMDNNOGIyZEVYL0VxNm5LekZoelYzNHowZ0tpWjg0KzZL?=
 =?utf-8?B?WXduQnl6OEYxYVlFbU5KOTc5SnpFMHdlUUNPcXRaK3AyMGpQYmYydUNQTmp2?=
 =?utf-8?B?cnAxMTU0Q3V6UUFrZnc2Z01vT3FFdG9uK0M1MmRlbllKdzZ3Z3pPaE9xRVZK?=
 =?utf-8?B?QmhFb2FBZUdaeUFza3pSOVpEckRVUVp0endFb1lmT0lvcDN4S3RXMm41WE00?=
 =?utf-8?B?YnFVcGRJdVpUY0V0eERFTnFLbEJhM1ZKcjdzMUhZbk9aVW5KbjhIWnNBRk1W?=
 =?utf-8?B?OU1SQno0UkduNVFBc3puaDduK0JjSC9Xakd4VXpPVkVXdUhHZWdjQ2RPMTFS?=
 =?utf-8?B?SmFLSDUyL1JOSjZzd0p3TGx4c05ua1BkRGcvTnEzQWxyN2l0UnphSmt2VTMw?=
 =?utf-8?B?d3hkT2R3a3ZrL1EwbHZYSHdPR0FLczVwamFEZkpVODVDbW5TWS9WSnFlWE9s?=
 =?utf-8?B?TDdENVE3MmR3ZDlTL0FpOVNjV2ZZclhURTJOUUxUZzcxaHJQWURNampEQ25J?=
 =?utf-8?B?SmZpWjN1dVdoby9vKzkxR01HR041OTcrc2NtbW9sdmY2V0VmVlRZbUdUbVhi?=
 =?utf-8?B?aVdWREpqWFRhT05oWjlnT2FIKzRPR3k4RFhPdHZ0ellaczZtT2FLRHU0VER3?=
 =?utf-8?B?VHpLK3kxL3MvT0xGV1NteUFESWRyUTNpQTRwdHk4cnJzcnZOc2tDSml2UHp2?=
 =?utf-8?B?cFdFQjE3VFFUbGFIMmN4WTFHM1dwOEh0V0tqZnVIWjJVUER2UG9IYllmdEJ5?=
 =?utf-8?B?YXpsdjNVZnRGUXo4M2ZES2hEZWJWMWhwWXBveFFMQ2hMNzVXN2UwZ1d0c2dn?=
 =?utf-8?B?d1E5bm9qYXdkU3ZkbGJuLzFHSWZnSVFQTGk2NW01c1VneDN6Y2g5RXVhQ0hY?=
 =?utf-8?B?UHc0dUpkYng1a1QycTZrejBnZDJWdGpFRXN5ekZVbGc3TTFWWXV6UVFFMGly?=
 =?utf-8?B?RWhKUmd6S1pNcWhRa1VjVkFrSGJxakhtSVdKQXQycFBNMzRIcmhEUGRwanM1?=
 =?utf-8?B?cXpHUXk3MTRCc0c0b1dqUTBwTVEyODBzN1Q0UnFvYUVDQ1lOUlFNTU8zUUlK?=
 =?utf-8?B?TFdOajRYM3IxSWlzeGdkemM5SlNsTlNHb1hJTnpBOENVRGFUeDVqOC96elkw?=
 =?utf-8?B?MHJjM0RsbWU2MnVmc1A1amhlM3pnQVJUd3pRa21IczBXZXRtMUdId1AwUVNa?=
 =?utf-8?B?OU1ENThzT0tEdms1QjRDelh1djVXb3FMbjZkSk4yZ0pZNGZ4WHJDejB4MnFx?=
 =?utf-8?B?cko3akIzLzJyTzFvajVqbzJ3RWxwSEtFZzdMdU9HRWpiR3RDcGxsbSsvR0My?=
 =?utf-8?B?OWJjeW5RUnlMSENHN1hlZHh0ZjQrZTlEUjVnKzR5blkxUElDc2pST2tWUHdC?=
 =?utf-8?B?QlNocXN6dFFjNzJNbVNmL2NTMnpmOHhYdkl3ZkQ4WWxIa2RzTVJ6U0hZcURD?=
 =?utf-8?B?QmVkN0hsOVJpMGZXaDlqZDZ2ZkVwT0xKWlVtS0RneEFYbFg5MSt2cTVPMVFI?=
 =?utf-8?B?Vjd6NStwb241UUtvNG54RjEvaENnc2ZNVExkSlVoMlVFOWQ1eWxnWGZ0TERq?=
 =?utf-8?B?K0ZmSS9qY3JzdTY0RnVZamZyTkREZS9GWkR2Ym9ob0l5ZDNSaG9HcDRLZmJN?=
 =?utf-8?Q?esNX8enJuIhwOY5A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e99c0-c6ab-4170-4a7d-08da10975d4a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 08:45:52.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5rsMnvG326MICKW+Ugyy6+GHmScM6iUtx3TKS4Z4rORyLrtrrXqb8o0yELHA84Z5a9Xq29FTFjZc49zJaCZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git dm-5.19
head:   d245a9c2bd77a40dab2f3393c4a413820dd6004d
commit: eb4cbc43473c35198e18c9b7b82e7a26fa6e5401 [126/130] dm: optimize is_abnormal_io for normal rw IO
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220324/202203242338.J9k787ls-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=eb4cbc43473c35198e18c9b7b82e7a26fa6e5401
         git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
         git fetch --no-tags device-mapper-dm dm-5.19
         git checkout eb4cbc43473c35198e18c9b7b82e7a26fa6e5401
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/md/dm.c:1471:2: warning: Value stored to 'num_bios' is never read [clang-analyzer-deadcode.DeadStores]
            num_bios = 0;
            ^          ~

vim +/num_bios +1471 drivers/md/dm.c

568c73a355e0b8 Mike Snitzer 2019-01-18  1462
0519c71e8d461a Mike Snitzer 2018-03-26  1463  static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
0519c71e8d461a Mike Snitzer 2018-03-26  1464  				  int *result)
0519c71e8d461a Mike Snitzer 2018-03-26  1465  {
eb4cbc43473c35 Mike Snitzer 2022-03-22  1466  	unsigned num_bios;
eb4cbc43473c35 Mike Snitzer 2022-03-22  1467
eb4cbc43473c35 Mike Snitzer 2022-03-22  1468  	if (!is_abnormal_io(ci->bio))
eb4cbc43473c35 Mike Snitzer 2022-03-22  1469  		return false;
0519c71e8d461a Mike Snitzer 2018-03-26  1470
eb4cbc43473c35 Mike Snitzer 2022-03-22 @1471  	num_bios = 0;
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1472  	switch (bio_op(ci->bio)) {
9679b5a7ec400f Mike Snitzer 2020-09-15  1473  	case REQ_OP_DISCARD:
9679b5a7ec400f Mike Snitzer 2020-09-15  1474  		num_bios = ti->num_discard_bios;
9679b5a7ec400f Mike Snitzer 2020-09-15  1475  		break;
9679b5a7ec400f Mike Snitzer 2020-09-15  1476  	case REQ_OP_SECURE_ERASE:
9679b5a7ec400f Mike Snitzer 2020-09-15  1477  		num_bios = ti->num_secure_erase_bios;
9679b5a7ec400f Mike Snitzer 2020-09-15  1478  		break;
9679b5a7ec400f Mike Snitzer 2020-09-15  1479  	case REQ_OP_WRITE_SAME:
9679b5a7ec400f Mike Snitzer 2020-09-15  1480  		num_bios = ti->num_write_same_bios;
9679b5a7ec400f Mike Snitzer 2020-09-15  1481  		break;
9679b5a7ec400f Mike Snitzer 2020-09-15  1482  	case REQ_OP_WRITE_ZEROES:
9679b5a7ec400f Mike Snitzer 2020-09-15  1483  		num_bios = ti->num_write_zeroes_bios;
9679b5a7ec400f Mike Snitzer 2020-09-15  1484  		break;
9679b5a7ec400f Mike Snitzer 2020-09-15  1485  	default:
0519c71e8d461a Mike Snitzer 2018-03-26  1486  		return false;
9679b5a7ec400f Mike Snitzer 2020-09-15  1487  	}

num_bios will be assigned in each case.

0519c71e8d461a Mike Snitzer 2018-03-26  1488
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1489  	/*
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1490  	 * Even though the device advertised support for this type of
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1491  	 * request, that does not mean every target supports it, and
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1492  	 * reconfiguration might also have changed that since the
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1493  	 * check was performed.
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1494  	 */
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1495  	if (!num_bios)
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1496  		*result = -EOPNOTSUPP;
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1497  	else {
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1498  		__send_changing_extent_only(ci, ti, num_bios);
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1499  		*result = 0;
e6fc9f62ce6e41 Mike Snitzer 2022-02-17  1500  	}
0519c71e8d461a Mike Snitzer 2018-03-26  1501  	return true;
0519c71e8d461a Mike Snitzer 2018-03-26  1502  }
0519c71e8d461a Mike Snitzer 2018-03-26  1503

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
