Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A974D2912
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiCIGnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiCIGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:43:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED3EF090
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646808170; x=1678344170;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PZFCpVliVmVZGp+ZnjdIPWr0qsO5kjXUFX+fMu0jSyM=;
  b=NUez4ePH16WpNGAIulAMTTmRRZ0+4qjkK0bZIXspsYZaxZSewATgnPN0
   W9wenSOHAGZeLMvbiRI2Yu8AxMtREH+wazLBAw/xwE+wJf+lFSFm12Mcx
   BV0CSiW3KVcTr9MrczDi7hm3e5sC+kZFElESB5WoDwejDsLDzYG4iRi2+
   WC6fkQSSMXfo4HMmVwjhbJ5mDzSjqUIzFhrfEy39G4MJ9/oZyotMOJkul
   kJ+Wb2FqBCGq0TLKwMJccs5S3QfWI8cztMNmqUCFX8kFdBztrdgcdeaBZ
   HwdqK7ZHDOzjLh0lJTjVil5WOU0mhk2uyyJrvwJvv7a6NH+1Shew7zj3+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315619410"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="315619410"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="495738680"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 22:42:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 22:42:50 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 22:42:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 22:42:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 22:42:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZpFbvxPJ+1SUiz/VVMnocC/JZlroTJz+WGPX4RDy2Y6TzEubWV79sC8VBHQgLFpESb+ihNlRp4F9Z0RS8gQ892SnF+AJJp0kjX13JNI0EZNZHhtHTpOvgjLW6b1DnpP0mwVPDG0AiSJUJSwzvKSMIFwOjas/yCMDjtI6ljLeuKDbTyyxEFDGvYUWAMJ8+dxK3HSBWW0xUEyI47x+nxoTtNzE97Ha5zTy54aPoPlReZSyKCG67lkXtb07E/w9gN7TtosbNX1jvaQgzkZKzdImWnfLP0IxHgFegDIpF1iZkca8J3ztR7m1ly8DoRttU3PQEONyEtribf1Nq0oCvizgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTmqzHo0xMGfSdGIcHmYmeG+iqzNwQrbACdKLjoNTtY=;
 b=kbVIY6IuoTCgWdyFYdi9/um8wJkjIeC+78zy3eqeO0jwYwdjc8OuWMPIRC+i8R5eHXfVXmHu7aJl3K8JcgCigzGMKVYX0aNEu2xtv9kuVpUM8OXNRlj7b5N6wgzv4+dJKCgyTQ6Bm78OgYDqlv7aIhdfpQDLGC7FlUaFbfKQiaqBgTPg6BNLbLcWDaY2xi7KmnlixUBwS82z6jSwFVM6Nt4KSocz6wZVWm6DflRSUpOyEWxU+tBeT8VHuL5oi3lxCfVTmO1mmfkhLCOWQnfFyvCFj1cG0sgjI7WBcey156pbq0ujI7OZ4DX0ZbTPb66xx9mTo0HSXyauwLWFxdvsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SN6PR11MB2896.namprd11.prod.outlook.com (2603:10b6:805:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 06:42:46 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 06:42:46 +0000
Message-ID: <7ca30935-f46c-41c7-b784-b3416a2f9234@intel.com>
Date:   Wed, 9 Mar 2022 14:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: kernel/trace/trace_eprobe.c:777:4: warning: Consecutive return,
 break, continue, goto or throw statements are unnecessary. [duplicateBreak]
References: <202202242119.TGICeJoI-lkp@intel.com>
Content-Language: en-US
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202202242119.TGICeJoI-lkp@intel.com>
X-Forwarded-Message-Id: <202202242119.TGICeJoI-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:202::23) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06101d3e-af2b-4d8e-e4b2-08da0198053c
X-MS-TrafficTypeDiagnostic: SN6PR11MB2896:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2896EEEB9640BD7EADCCECBFFB0A9@SN6PR11MB2896.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/VaRbeLL1nxZI089dtcosM2o0mRqqzPiHjgzrrIp2gQCtRX6bxci2t3V0qW/mcGOqGVjPlWjgS4DrrUNAkNhzxtTYr28bT4uTZnMy2eatbIdAvUFK4MzugZ+di3WhZjYSPalP2d6cfuu604WXfRY294ALPnTV6+W+mm8AQ6nTFWWiRgtWPTnuE/BCTBjxJIV82sW+AbofVudq5OCfSYqodgPHgAGlZUyDAtCwKHJ4FAQAzzVmOWQGVqVO5uuXa+gJGNloD94b/bsTiENG9yY58qqkAIqfegzXKnAPe4qoYKxW3jLjbDxJ1L4is7Z9DFY7AHwDJHdweWdLP4gJ7HQ2PaO3HmR+wSHxYZ7RRv+wlFbp9ddYypeVpS97AFPaNTGiufRJXg6EeYQZsEeG9i1Yw+KTMd1VZHSOzygi6LikAoPPWeolkKLv4c0+Br9nS7+xloTBoZUG7TSNDPEafIQNnSy6uamClyc/7nEwpn11MghW/ZEo3mxKucApjzkx+cmvhPjRohkHjzcaBdjisiO8y9wpYsTrwwAsb5O4exIdykbzl7mt+tDTvHh05XWdzxT6yKHKlXbn+1ZxEBwmw/DwB8Kq2EsNtBApLrysgsoFAjnolNyt99ta15G0iDAMwssRnrcohfAAhVRvxg24XotPJvA2nJ+wt3dsLGQXuCEWvV/QUwQCBMFZCgbEloTH2hi2cR+WfEd4oK/b6IAGaPq2bfJDzeqxRifr9Yt+I84HHrfJyw87AHZZv3yrZ9oowlFECyIFZKEeA8iJJ8iJLiZ4UQy40N6py8b8OH5eh10Yp4AT6483eYXkwTVmQ50pO5OtWuaneLc1ncIPCBd198uzmZtzfNK94+WKxFepnmIfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(6506007)(8936002)(6666004)(5660300002)(2906002)(6512007)(2616005)(38100700002)(82960400001)(83380400001)(31696002)(508600001)(86362001)(31686004)(316002)(966005)(6486002)(6916009)(54906003)(36756003)(66476007)(66946007)(66556008)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VlQ2xsV0ptUEh6eXZkdDgycmNYeE5DWDlUSlJ2Smo4Zkw4blBkNmtBWlJn?=
 =?utf-8?B?enZhbkpMYWlkMHlMMmV6SDE2OHZ3T3hSUk9TMkxOV0RhWEJJbWZ5WlU1MmYw?=
 =?utf-8?B?bmNQVjJaMWZqV0ozS2hTN21KL25tOGVzSVhzeXVjaEFLUVRNMFUxM1NzRWVj?=
 =?utf-8?B?dUVJZFdtRUkyVkxCZ3E1OHp4VnRmSEhKc0xSMmFTQ1FUcWVJQ2ViU2JFREJz?=
 =?utf-8?B?a3hzb2hOR1k5bG9GVTBQM2ZTakNZZ0FxZlRzV0JRRnd5MTdVdWNFWkppQzlk?=
 =?utf-8?B?Z3NtVU8wZ2w4MTJ1ZlpZYVozUldqRFYzeitENEVnVXc4T3BuM2FIR21vUm9T?=
 =?utf-8?B?RkNVRDdDM1dMVW5Cbm1GS1prdTJKNndvRDVnVkpOOVprV2tuQXNqVFpJUUtp?=
 =?utf-8?B?NDJQNWFGSnZwdnJJYWhFQnF6dGtUdEpEN1RPeTE2MlZHWHRzRlhWTjVaYkgv?=
 =?utf-8?B?RUwxVURNckdwRGdudkFGSFBpRTl3dnQ3Tng4YnhKbzNMaEJWUjd3cVpjakRB?=
 =?utf-8?B?UndKazZQbWRNb09VRFhUc1hoUEJMUFIvRlFJRGhNeEpkOGRRZkQxcEM0azE4?=
 =?utf-8?B?MzJFbWtPcFQ1R2JydzEvVGZWbWpCVmpoNlMvYlZ2QXE1YVJBU0tVY2s5cHFt?=
 =?utf-8?B?TG1Mc0c1YURWREFFeXpUbWh0YzVibUllbi9VTGlOWGRyb0k2ZXpiN0RYS09B?=
 =?utf-8?B?eEttc0s5WStuZG5UV3VVTGFBbVBnWTFGWGtMQ2ZqSkFOeEVzdjQyZUlpNjg4?=
 =?utf-8?B?QjhkaG9kRnlXMVZiMzFnYWFHVjNsdUpxT1krc1RJcitxTS93VXQzbExmMUd4?=
 =?utf-8?B?eGNFTUtYKytRTHhwSU9QNHN2UmtYZGd3dmpNYUdFSHVKdnZOVjZFNmRxMUtC?=
 =?utf-8?B?SFUwa3B0R1BWUEl4OFphY3FBaGZMSGVKd0gzNk9pekRScW10ajJzNzlSQ1pM?=
 =?utf-8?B?blEwUGgxR1FSdUl2M0dVTkFKbFBNb2dNK0lFT292dFJIMzJjT2dFQzJneVNS?=
 =?utf-8?B?MVdLRnIyUFJrdmxWaElYVzhDcnVEYXcrK056QzljdUFOaE4vaDJMNUVnN0xV?=
 =?utf-8?B?TGoyNTRsdjJEZ3R6R1hQZGtSRlNpbU1jM0J2U2J6L2Q3Z2tITitYT0FJQ3Y1?=
 =?utf-8?B?SW1ia1hrM1lpaktkaGZnWVlmMzduQ0xLd2JDVnJMa3JjRVdEejNKU2FQYkhY?=
 =?utf-8?B?MTl0dVRsdXg3TStOZHp4RjNLVUZSblBHVWNhaGdkOEtDSjlLZ0Q5dHhGRWhU?=
 =?utf-8?B?TlRXU0RUTnVHZnhJaDBDM1pPc2lmSFJHUi9CKzFKc2N6NWUyc24yZnFHZzBB?=
 =?utf-8?B?VE85YlJ5dEk5UHBCMExpYzRzNFgvNkRydXpEVVpDVm0yZFdNSjYxODlZdTZs?=
 =?utf-8?B?WURvdjFUVXBtclZKcWNpS3kveWQ2RzNlMTdjSDlCMFMyQm15em9oK2ZtTWJL?=
 =?utf-8?B?RHpmVGU4TC9VcWovQTVKYi81c0Fid1N5U1kwU3JORjZPMEdneldkMkppa2tz?=
 =?utf-8?B?SmdPRG1SN2tuQzhtcnh0b0gySytDbHZyTWd5T0kwSlNFUFRzU2wxZ0tLaDFj?=
 =?utf-8?B?eGQ1M0pTZjAvRzFTcDRWck9zRFBmM3ZaTHRSYjBhNkRWVmt3TXdPWWhCVkYw?=
 =?utf-8?B?dE1meDR2NXRveld6aFU3ZXZ2STNuMHhjTjd6bHEzTmZtdG1xaTd6QWVEUzln?=
 =?utf-8?B?K2ZXdER5Mk4xL2k1emI1RUYyZ0kvR244Y3o1TEpET0o4RFZhMGlXR3JDc2Y5?=
 =?utf-8?B?Mm1TY0dxQ0g0cVZQc1oxQTJzV0hzVkVvWCt0enRaUzF1Qjc4VExxdFZrMkdI?=
 =?utf-8?B?VHZ4QkZyWXJxa2pKNHFuc2xERGVrRXpsZFZuMEE0MllWMVNNdXhzaElGcnlE?=
 =?utf-8?B?ZXRyVXI4cGlBWHBSOTZ4S3JUSVlmZ0NSNzVHRWZTZEJBTVBvNHptc1ZKbXY0?=
 =?utf-8?B?eTBZK0ZGTXllK2FWR1VoNmhNV2pzNXl4UjFadVZRV3lKTjRPdnRzc1dvUC9F?=
 =?utf-8?B?WVRqZ1Z0YWIxakhrL0ZtaDdjQlpQMTUvbFUrTGpYQ0JTMTZjcmFsT2JTTUw1?=
 =?utf-8?B?QldKN1ArS2JObk1BS3FSbU5qMmw3VTdJMFNHSjNkYmhqdWp2V1kyMWxHaE11?=
 =?utf-8?B?VFFCa0FveXg3VnFMblJMVW4zRE16YWJWdHpZUThBUGUrTHIvamdQL3hUMlRF?=
 =?utf-8?Q?NLF7xGMfuPq0ULCsaRvf160=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06101d3e-af2b-4d8e-e4b2-08da0198053c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 06:42:46.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O43nErGma+wy/80V84I6A5bN4fN4AdJbMg4Rpt7NBWESYJIH0WOI7gxgIMFTcyNnEu1EpW58oulhxpHwaio0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: 7491e2c442781a1860181adb5ab472a52075f393 tracing: Add a probe that attaches to trace events
date:   6 months ago
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> kernel/trace/trace_eprobe.c:777:4: warning: Consecutive return, break, continue, goto or throw statements are unnecessary. [duplicateBreak]
       break;
       ^
    kernel/trace/trace_eprobe.c:780:3: warning: Consecutive return, break, continue, goto or throw statements are unnecessary. [duplicateBreak]
      break;
      ^

vim +777 kernel/trace/trace_eprobe.c

7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  754)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  755) static struct trace_event_call *
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  756) find_and_get_event(const char *system, const char *event_name)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  757) {
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  758) 	struct trace_event_call *tp_event;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  759) 	const char *name;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  760)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  761) 	list_for_each_entry(tp_event, &ftrace_events, list) {
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  762) 		/* Skip other probes and ftrace events */
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  763) 		if (tp_event->flags &
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  764) 		    (TRACE_EVENT_FL_IGNORE_ENABLE |
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  765) 		     TRACE_EVENT_FL_KPROBE |
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  766) 		     TRACE_EVENT_FL_UPROBE |
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  767) 		     TRACE_EVENT_FL_EPROBE))
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  768) 			continue;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  769) 		if (!tp_event->class->system ||
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  770) 		    strcmp(system, tp_event->class->system))
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  771) 			continue;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  772) 		name = trace_event_name(tp_event);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  773) 		if (!name || strcmp(event_name, name))
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  774) 			continue;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  775) 		if (!trace_event_try_get_ref(tp_event)) {
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  776) 			return NULL;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19 @777) 			break;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  778) 		}
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  779) 		return tp_event;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19 @780) 		break;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  781) 	}
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  782) 	return NULL;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  783) }
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  784)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
