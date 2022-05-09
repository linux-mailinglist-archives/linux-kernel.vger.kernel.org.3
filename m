Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB151F327
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiEID5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiEIDxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:53:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759422A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652068192; x=1683604192;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cZtdzkWPXbSsjaq/vRpRyKsD8+k3HL01CBVoDTbyQoE=;
  b=aW9hfl9rrI/dsotYGQplFeY8VcGaw/wQn1QXnIleylKqr/LsI3FDHGJ/
   kua5ggXu8WBPGCFF84kmOqTetAlej/F5TPb0Zs5fc3DbZcfg4eqBvugMy
   KSp5vwUA1RxO2MIK6tDevoP04uk8E7elJkvtrZcSbLGpC5o2w53XivAge
   u83pii4A70rWLWK3+KQQQJ+HEbJ4da6hS91AFeLhJ2MhSYzgyhCzW7NyF
   v685rDJgfgopB/qZjjE51KlCqPoMgLo1uZj20zZO5fVMQj9LgYCc1heLr
   Ti4qeHuhjF1yybD76bvBcbLS/SllcQEiGFxchplqluT/uS7Urd9lzt0TW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355358228"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="355358228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="519012428"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2022 20:49:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:49:38 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 20:49:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 8 May 2022 20:49:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 8 May 2022 20:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN9dKomNNktPflOYTFC0VCfgpHruSYmp3RnYRPXSbTjhrYQtE+3eEx2HQbkBfqjOVbfHvInpxipkqBswgIwtzPDUmZj8DBu0vQQLuCJONWzc3AmSxOPmL629pj3gTKTYjX3S9Qff8AfEeijnaGylscatzexjC1jFj50lr1GYwTsUlQ4k1itBZDfxsDhIq6knk2b1uwxaEsfS6kAmZb9Asjd3sJyn5sttaS/KqirKOjFVKdk41gWsrVs6TMxillxySPI+AN2iIQvF0Iyv8Qv7aQhSskv6jckoKwWCUyOCf+lJUVTlDjMCVhcfGzA2kIL6jcX8LyqyxH4sJVmrw364TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N6mJqMjLkrBMKR4tFGLrd5MT/gXYKkcfPWGO67SGD0=;
 b=a1XaGNKi0BJANWDXOSIwKs8Ot9v772LTFeHjMppz73Do2AQii1HUBChuFG+kIqZW4DLjxsE1wr4eJJ9NTlwzyx0sA9sxqv3ZIM0MskW2/c71VQdXXuu0PuJ9i18WVU/NaNPB6peH3Ucvz5RboFnErLQcoH6YiKgXomMwViajJZxFd2aQ/D8bJxhiD/8F81y4g67/e+UAVpvUoWeSLbryyoBW9qoB77aDlMfl7V1fFA9t0AKkebqHlgmCTSgSIewlGTekVcVJFHPxpD+U7BPj3ErJPlACnCkIg2jPvh2SN+hC1LQt/Qr72W8ZxhvrhQKomAoRDhm0HMywKZV+WwKupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 03:49:36 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 03:49:36 +0000
Message-ID: <2dcb7dac-0c01-954a-8640-5d5a92e52b80@intel.com>
Date:   Mon, 9 May 2022 11:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [intel-tdx:kvm-upstream-workaround 219/361]
 arch/x86/kvm/mmu/mmu_internal.h: mmu.h is included more than once.
References: <202205072036.6EWBogQv-lkp@intel.com>
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205072036.6EWBogQv-lkp@intel.com>
X-Forwarded-Message-Id: <202205072036.6EWBogQv-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:202:2::11) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5af592d-212b-4e2b-4f1e-08da316eef9e
X-MS-TrafficTypeDiagnostic: IA1PR11MB6194:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <IA1PR11MB619498F5A0513C912AF347E0FBC69@IA1PR11MB6194.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asWrrd2pWpc+bBIGF+pHlBun/tUsf1RhjullkKIx6xWulQ/uYDU7YFevlr5HaMEaoJmP2IcvXOJgKSS+MKQx2U8EhYtuytyoIz738Or3awP3Efks8rfv2tRlMZp7yTC2wQg+l4i5Iqbl6zSEdhJZC+/Uj2CQcGBCsL5YgUFE2vM5CpZVlzNkgWZ0q7aZgF1pm+vxuf/NdsPVRa3IelYPL2kiJY9sq48sbUxfx+O6d30n/2wb4viA3tJ2BmNVQMry6nGwAUe8uNBSGmQ/v8U8hpI1/g9ieDbvQZoG4K+CL72xo/5S8cQVdxGGX6NCKE3OVklsVBsJzn2QZGJjDswBhEV06zYgWUaYXJGBVTrKiYgYwYhicRbKyUtd0M6l3VYMIgoXBnsTbcdcEz3lXJBFdfQhoE53MvdYBBlnMKlrLx+H/JdO3eoU1zr1uolTFrygtpoMt57q0+MWHmEeu2DeVG/NiYlM89mXrj0E75rutjT3KYWfoOvF5a7b7BcZUZfpuQb47AWxFHBy2lu/01ds6M5P1M2jm1cQBVyqAJPhMdGxIHW12gX7952J37eM2TF12mKcOQKXr5vsq92sC9WEFVZfA7xMYbc+pnP+vwdR007D7fOpwhZHktO+7q5wB6DSfnQxiyVk3g9tja42M0e2oRwUq8S5AqMsFTlyk4WnP1mWX14Czme4s5hPHRWBydWdk0FCKnLU0YZ6xpqXe6P5f4kxsSBM/TY4gEwwP87tkVLpL4JgXHqePZjxgyBny43I5qgPZzcasF6xnEwWpbpkoWuvjPsZyoo1zyulpB22DLurutzg8/NrfEIay70+74+3TGdIjQCQec6Rdohu8cW42oP7vbaJBSIrUXEw+YDR6hE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(6512007)(26005)(82960400001)(66556008)(66946007)(66476007)(8676002)(31686004)(8936002)(4326008)(6862004)(36756003)(5660300002)(6636002)(316002)(37006003)(4001150100001)(2906002)(83380400001)(6666004)(38100700002)(6506007)(6486002)(31696002)(966005)(508600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJNRGhnc0VqT0hPRno0WEpqL0k0UFVFQzV6WkhyeXVGZ1daTzREYUZEeE5o?=
 =?utf-8?B?YmFwdDRoczN6L25rR2p1U2NGSUkxRGdlWFdIN3FnQ1h2WWN3TDE3MURULzBs?=
 =?utf-8?B?eEErM24zWEV3NWd0RFJnU2tnWTlFbi9NNVBRUExaemwzcUVTVWxrS3NTOFBT?=
 =?utf-8?B?SVlBVWNiSEZONWNKVHhFaDd4QnhEbEZZalhoZ0x6R3cwNU9CLzlSbHd6cVY1?=
 =?utf-8?B?ZzBZVURCL2wyTHJ6dTVMYU9hSmEyUGIrNUh5MXd2VVhpNjlDRy9QVWFkeCta?=
 =?utf-8?B?emh4OHduaUFFMlZNK2ZRS1FtMm4xUERqb3h2dFlSZ0xSZWF5cXVMbnZMaVlB?=
 =?utf-8?B?NHJneTM3Z1NXNDRTREFFcHV3UjNhMkFQNERxQWNGQ0FWaVE3UWEvNm03anRX?=
 =?utf-8?B?ZHpiQ0pENjlielJSekw5K2plREhFVndoZmF6QlhjK3V6Y0tXRTg3OXVKSXFL?=
 =?utf-8?B?NzlvS0pwcEVzS3kvdzY4VmMwM1p4dlBheEtDTFR1eHlpNmZvQ1FhbldpNUVB?=
 =?utf-8?B?NTd5VjU2RTR6SEVXNTAzTnNLc1Y0S0lWN1Q3K1htY0RmQ0V0dVlaall5ZTM3?=
 =?utf-8?B?M2lGOFJUOEpjK1ZGendFbER4czlFT1dQUm1pcGl4V2pZKzdiQ25mNENEVktx?=
 =?utf-8?B?YTRkSnRqSjNDbXRRdHpIR2hWOStZbFpraUpQNUFoUXQ1b1E5clhpbHYvdm1r?=
 =?utf-8?B?WGEyWmxPa1A1NEpJUDRFUWV5SERUSWIwWDlTVjFBanhrcklIaUtiN0Z3eDlO?=
 =?utf-8?B?UTl4NUs5Z05NdTcvQ25VYlNOT25OcGpkUkxmQml3Nm5jOGs1SkkyU0J4UmNk?=
 =?utf-8?B?bmZUTHpaZGJyTjRRSVIySXhqU1A4aFIyZmJHdzUzVU9ZTzBoSUJhUU8zMlV3?=
 =?utf-8?B?c0I2U1pocGx3MDVRMGtwc0hFNnIrcHRhV3JYOG1LVjcyanBoYmN2NmFvRHM2?=
 =?utf-8?B?d1RhcHZ5QU44WFlmR0tkQzdVODRFNk0zYVgzcXRVK0E1dWNuZDgwUnZsOWlu?=
 =?utf-8?B?RnNrQUErU3cwNUFDbGpDMW95VWk5NklHSjkzZVFESUlsWmRXN200MmJ1UGts?=
 =?utf-8?B?Q3lUVnVzakZjclAyMHdrUElYckFhOTdPUFJ2a3dsaHB5a0oyeTBocUxNdWZ4?=
 =?utf-8?B?cWVzc3BxUzIya0FhVldNWDhrWVd1ZkFFQmlzRGZHTlB5U2p4YUVYR1Nmalc4?=
 =?utf-8?B?NDZ4NkRlSWJnZ3NqQmsxblFYSUtQRTNvUFlsTlRMNUdBbFpXZjVJQVZYa3lk?=
 =?utf-8?B?cUMzc0hoNi9aVUU5ZjJHRCtYK1lrUUVyT0JSbHZCSm5HOFZUbVljOE1lU0dH?=
 =?utf-8?B?SityZkE5ZTBNOWQxQjVZQTJ5VDFBK2xXM1FBZXl3YzEyVmEzSHlTMHk1dWJm?=
 =?utf-8?B?dFp5WkJsN0RuSDQ4ZzEwSmpnRksrdm5oTU9YcC90a0dieUUyaVMzaEZrWGJ5?=
 =?utf-8?B?YkgxQTVLcmRSYlg4L3JILzZscm5VKzVoK0QyZlN5LzNvbzhLNHpDeGpnOTFa?=
 =?utf-8?B?OVVQSXNDMHJKQVNrWVkvcEtyUjlheGNYSEEwZ1BxQ0poNk1ReURLUlhhRmw1?=
 =?utf-8?B?MjdBR0V4K2c0TlgwNE5DazVUeG5uSlJYYU9Pd00xMm0vTWtxYmorZzBPSjNT?=
 =?utf-8?B?bUxNakE4SjNzY1RzbFBFUTJXUUlWUFVNamdTZ0NPSko4Uit1bjlYUFBZcGZY?=
 =?utf-8?B?QnVubzBTenkzV0F0MDMzYnh1QW9DQXFXUGVxcm5BbmRmY2d0VzIzTVg2cTZK?=
 =?utf-8?B?b2lkbUhSUW16NVZzWEtPV2Q4K3loQUc5Zjl0N0RyQk9FN2JzQUkwelRYdUFO?=
 =?utf-8?B?ODJ3dHo3NTUySnN5dGl4aDkwcFBBeG5xUFlIRk5ybjJYWWUrWlNnVTFUaDRs?=
 =?utf-8?B?RGw2ZHptNXpwSFk2eUxRS2d1S1h2TEpLYmx6b1kyenREUk5OVlNxYzEyWmdS?=
 =?utf-8?B?b20xZy81dGFOd0R4SWdWT2NQMmFEUGJjVWFkWWlaNER6RG02elk1YjVTSFRW?=
 =?utf-8?B?SzdmR0dZcGlHVlFEOGlHTUJaVVdpNTZLaGhRRWpsdCttNG05ekFVZklkQith?=
 =?utf-8?B?VG1zSEgzazdWeG9nYjNqQ3U4VS9Za3BFSmxMZS9YMmJEZ2taTVJXblVwMnR2?=
 =?utf-8?B?U3NQN21TUkc3WHB6d0V5R3dERWMycVc4YmprUXE0YnpxZnNVQzAyVThDNytp?=
 =?utf-8?B?ZUJwMkVYcVd2R2YwUTl0YytkanVLbHM5cHo4KzZ4cWxNNzJ1Z1R5dWFNMkNn?=
 =?utf-8?B?SVRSQTN2dDF3ZW9vNzAzN3E0UGlIVWsvTWpzR3U3RjZTcXpPQ1Npemx3dFBx?=
 =?utf-8?B?QUQ5L0FwTGxWTWtEV1ZyZHZxamxZR2R6dzVmK3FkTjBkQVkrSmkxdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5af592d-212b-4e2b-4f1e-08da316eef9e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 03:49:36.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un7CIHUwtgn7aBxQOZydEA9Efqw+gjwnGpXI1XZuYSlmEafCUiXZBknc0o0m8zxg7Fedl1M4msHu42rjifJ28A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   3b5b338cdf10dca7a2435d1f86b2dd9f1a3ad833
commit: 9be9dc86983ab1ffdc679c1ab5de025d1487dc40 [219/361] KVM: x86/tdp_mmu: Ignore unsupported mmu operation on private GFNs
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> arch/x86/kvm/mmu/mmu_internal.h: mmu.h is included more than once.

6ca9a6f3adef9 (Sean Christopherson 2020-06-22 13:20:31 -0700   1) /* SPDX-License-Identifier: GPL-2.0 */
6ca9a6f3adef9 (Sean Christopherson 2020-06-22 13:20:31 -0700   2) #ifndef __KVM_X86_MMU_INTERNAL_H
6ca9a6f3adef9 (Sean Christopherson 2020-06-22 13:20:31 -0700   3) #define __KVM_X86_MMU_INTERNAL_H
6ca9a6f3adef9 (Sean Christopherson 2020-06-22 13:20:31 -0700   4)
985ab27801646 (Sean Christopherson 2020-06-22 13:20:32 -0700   5) #include <linux/types.h>
5a9624affe7c7 (Paolo Bonzini       2020-10-16 10:29:37 -0400   6) #include <linux/kvm_host.h>
985ab27801646 (Sean Christopherson 2020-06-22 13:20:32 -0700   7) #include <asm/kvm_host.h>
9be9dc86983ab (Isaku Yamahata      2022-01-24 11:17:01 -0800 @ 8) #include "mmu.h"
985ab27801646 (Sean Christopherson 2020-06-22 13:20:32 -0700   9)
653230043fdb2 (Isaku Yamahata      2022-01-26 17:43:10 -0800 @10) #include "mmu.h"
653230043fdb2 (Isaku Yamahata      2022-01-26 17:43:10 -0800  11)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
