Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863F46B64B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhLGIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:47:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:4841 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhLGIrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:47:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218216143"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="218216143"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 00:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611596271"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 00:44:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 00:44:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 7 Dec 2021 00:44:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 7 Dec 2021 00:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1Z3fmX1xxyWzyzBA50cXOKtH8GUNk/Se3/AX+u2+c3s4jQhJ+xVVv5wcwhv80fcjMdieYpkVz2XlofqfBIivQlf3nGXO+R8QA9vhvQx7Cuo3YRScaWQi6HIglaICx7FgUCFsmfpuIcroC3cC8lEOyERoA17NS/JxnjnJUq18h6gr8MVDCmFSSALeWs38M05txFXmu8V3FOHpHW3vE5zyDTASSsO8vm36xmgHf9ovIwNyRKKLB+MJ9i0wUmhCoYOUDMzH2LRuXPGWOWIpIKyZqfiiSHoD9tdEPD9bKao2NL7Fp2l83tlQ6CmH1eY0v2olO576ON8Y+GqlHcZGdsIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kaHEe/k309lFNAqk3vqT7I+Vsiq8tAHlE6plfDAyAE=;
 b=GtO4HqUZF3gKMzMit6buHVmaHUyxFFIBWf0cZiit/7WybsV62VUMl+UFnIQ0RuanDODdU+q0ums/0pdqetUa+cocxT7qeBS0FEwz3n9/l/q1rQbLGbc0HBZ6j1MHMl0cOi3BvDDgsao1m6Tv6473VI4zcEnrWrfk49dvHPFT638zXtwppjvg4eE4F67x+biMeb1MPDCevhYmrcE8Cxleglriq9DVjTKr9l+YgdAIbjOdZSeD69Vssil3l/eNc1LhQTjE7Okn+OmuWejPOOoc3kdHkxP3dyXg8Vd/SpOS6XxHB345VMsz8JaJ4G9KuP/e6n+Zf+EI6shypbHbY7xqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kaHEe/k309lFNAqk3vqT7I+Vsiq8tAHlE6plfDAyAE=;
 b=PijoaPeG+vEx5Z9639+/o4aGa9MmOaU9epL4m5Uqa0/SE63ktukMtrbQhfLKHZOtJKbQZ77NEehRc22GA/s04iNAi5EEKzVB408GbTP2gFb4k3qG0hqaGOnwRdw1rRyElU/mscKFOgnU0qoFtrWfmqp/Xq0xQJAbr5ph3nSMFAw=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5680.namprd11.prod.outlook.com (2603:10b6:a03:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 7 Dec
 2021 08:44:04 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Tue, 7 Dec 2021
 08:44:04 +0000
Message-ID: <c2dea057-3a95-36f0-b4a0-73525ef1c322@intel.com>
Date:   Tue, 7 Dec 2021 16:43:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 24/30]
 drivers/hid/hid-debug.c:1029:57: sparse: sparse: obsolete array initializer,
 use C99 syntax
References: <202111290200.V12OhjgD-lkp@intel.com>
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202111290200.V12OhjgD-lkp@intel.com>
X-Forwarded-Message-Id: <202111290200.V12OhjgD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.143.18) by HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:44:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f856e2d6-d94a-4b9b-9a20-08d9b95db90f
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5680:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB568098D96B76B11D073FD133FB6E9@SJ0PR11MB5680.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOetHVg1YCc4uBUtKXKJXZ6suzenfqRA70IQlsSLnSvDoVJVrmz5dUfWudRheEju3wSlDag41qmcYU6FrinAXxdWAZYyMFQs1aLAhyv1R5Wai/4lxuMM6EvtDUWi/pLW1uelpZDzocPjnw3NSg0Tu5oNbQh4mn8epLMCDnMtFhCftAw8H4YJZNGQFJK+yWdiLOP54GMxFtKe+usaNQzONX+GU3DmS/EVb3J44DDGabJTM5fN+H7b7Zk09W+99LVR5vRWv5rudrI8R7Tki3r1FlATR+ByVm9h4Jghj87g92F7ut2ssr7cIxY33n7GncNlXeVmQSjaw6HdLzzqaqYwPYxJnppaHXi5mroRPnFsgGN/I9XyaZ7CBZUZMdhznou35I1kIod50avHOtOJ+ioYi4x8VUBfYPcDGPt3776EBVomegq44IW0FJs187dgoO8UC35d9zwYDV+xX4Y1y+5HXxQWdfXNhRsvXezVuSMyFOD4smzgLlwMKRTOqTu0Cv3YpAs8vXCGcwVVWJgRt2WSGLQJycPdy3dSOEBmLEcYIizyMgxEQIrhxgP0hv9E2YsaOaH8/JHd2FXEc4PWLOIGV4NBSvAkqd7Q8XkJdd+vpb0HMk48ekDwDQQrzLrcGzbOE+UDv0pptrgcii9xDQ7yaH348EBqRzxXa4uZUQ4jZ/a4ItYgbSs85FSRGKeZvfd0mKB6HaZ2EG1Ly04FowMGCaNNzc0oAC/RdVE0jU04/5a4X+utf8jqpYIVnKYh6MuYJJw5lEGkzAEl1wY7eYn3rl9cL7EVAxc4R3yL2gM92R1iTt/QIGf/HipJ2V5isJcnp0lMD0GOLb8+Ps+6gGRkw0csxUUmh/M4ZqYg0Vjj594=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38100700002)(6666004)(4326008)(186003)(36756003)(31696002)(66556008)(6486002)(2616005)(83380400001)(66476007)(2906002)(956004)(16576012)(31686004)(966005)(8676002)(5660300002)(316002)(66946007)(26005)(54906003)(508600001)(82960400001)(8936002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDJqTDNDeVVvRWFTU0FjUCs0QTdWOUVqbThlUUpSZGt1dGlXQ1pxd0pRbGJu?=
 =?utf-8?B?c2UwUEs0aXFhajJQQTN1MWxxbkFiRVFEcnRLcU90dlFxanN3YU9PS2MyMWZ6?=
 =?utf-8?B?RHc2ZjhPMDhVZ2lGQjVpSlBvOXR3dHdDSVp2anlUMkhBdGFnYklhMG9nM0dW?=
 =?utf-8?B?RlcrY2szMnYvSlB4T0IweC8zS3pKeE9WM0l2N21tQy9vN3RPSFAxWG94N0pV?=
 =?utf-8?B?cy9VMW4rRDljK3g3WmlFWC9XeWpEaGJCMW90WW9ZazJsczdBNTJsMXFpb2F4?=
 =?utf-8?B?R0Y0cmhIYmNOS05QcENrTjViUWMyT3o5T1p0YUs5dlJkVDFkSHEvcG1IT0o4?=
 =?utf-8?B?MjlCZVlhT2hVNXBZMjVuRlNYaUwxaUxBZUdDcGc2QkYvdEhSMUZVZTVaQkFN?=
 =?utf-8?B?M292MDcwQ1dEdHFValJRR0VhWGlaU0laY2pCZ0ZWT2FHWUxnWWdqdnFhWmE0?=
 =?utf-8?B?Wmh6S0JKOHF2K2R2Y3JSem9XeCtMUlVxN0ZKL3FpNWlqcEFBb0F4ZjF3UFl1?=
 =?utf-8?B?SWN0TGNpRmNPSzl6RGtmQmxPOTAxQjIwRVhnZ0R5M2txUW5qSEFhaVlZRXRw?=
 =?utf-8?B?c2lmTmZoSmVQcFljbG1xWUgzb3RBRUhCSEVtWVFRTVVwZkxVUC9IRk81UjZj?=
 =?utf-8?B?NzBkQUZ4UDd2NzZXNjFHb0V1UWhaNjY2a2ZUQnhrZlVYZWVWVGN5azRQZFhD?=
 =?utf-8?B?d21DZGlVVUxLYUY0MjUxWGZJUGZNVDg0bDdUeXgxQ1diRnhEUzVTbSswMXBU?=
 =?utf-8?B?bkdOSUlmZFluclRPV2ZqWk82eTBLZ1dOQnBPVTJGSHpxNEdWMW4xQ0lEd2VO?=
 =?utf-8?B?VnBvOEdYVEllQnpualh1OXJlU3BNV3B3dlNlKzJyNmdUbVhTajBMbDRTMVIz?=
 =?utf-8?B?ekVYWHlJTnVTdEc4WmNUa09sbERldWluN2EzcEVhOWh5bnllcGtMSmRXZzJY?=
 =?utf-8?B?dVhTMVE0cGtrL0pxZDVQTURyTzRIYW5WWkV5S0MwUEpsR3d3ZXRMaE9QRThK?=
 =?utf-8?B?a1E5Zk5IaGtVWXYxZFpSUm15dytYMFBmVzVweSswdEhGQ0NJOGdVejVqbkYw?=
 =?utf-8?B?Z3JnOENUR2pnTUNyS1ZRMGM5eGJOTXZSc1NyTEVsVytFN2tCRlB1U0FjRG5N?=
 =?utf-8?B?d3QyRzFOaEpyM3Z5eGxrNWgxT1JHdFdwOHVzWWRGaW5QVTFtaHVGMm9CVXFH?=
 =?utf-8?B?K25ZNmNTTEQ4VHM3alZwR0VLVHI2MXBtR3Z2aEJQWXRHWGxpdituTnE2K0dD?=
 =?utf-8?B?WWMxdFJNeGJnbEJlemhIeHZuOXMvc2l1dWZrMzRESXEvSVVpWmNodm8zT2lF?=
 =?utf-8?B?SEtqazV2WENQVUJxOHBvbXk1KzNIVVhxb2FRN0pHTERVWXBEQmp0bkIrVjNi?=
 =?utf-8?B?ZTJWTmY1dnk1SVFGN2xrYm4xRitlVUcrRkxsRWhIVndBSU9VQ3p1MEFMOWRk?=
 =?utf-8?B?b1kzYWhnVllJVWVJOElMcHViZXJmVEpxeFZBVGdPWVhSQ2JqZWNWOVVTU0Qx?=
 =?utf-8?B?S2gzRHdxdTJuaUliOEc4MXRMMDYyZnlvcEVTdmVIOGpOMElST3J4RnJRODNO?=
 =?utf-8?B?bkkyMVJKZ21TYlpDaktkT3NhektNRlVGSklRRFZ6aE1ZeTZ4ZXVPcXFVNngr?=
 =?utf-8?B?YmpZUEU3TGFzN3A2c0UyZWpFQm1OREl2ZjZMejlDQ3NLcDBLV0kxNWMzcDBH?=
 =?utf-8?B?ZUZRdDR1TFdUdkRjZzJIRmZWdlJibkFZcXg3VlQ0MnNKMmV1ZVJTbjVkNlFC?=
 =?utf-8?B?bEdwSzNqcDdPQitjT1M1VjRoYXFwdVJ6YjhUbmpZWFM5c3ZFc1NDWjVScDVw?=
 =?utf-8?B?QXpHbytWNTlYRHZhdStqOG9LNkVQK2VUZE02TmFyWjJGMzRLRUlrTjBTbTd3?=
 =?utf-8?B?WEVWWmtyNkpjbllsTWh5QVVaeklxelY2NlYzVWJmcVBqWFhYK2x0QnMvT3M5?=
 =?utf-8?B?b3dQR1FJKzBzMnVvRGxMcVM5alZXK3g0RGFpQStIRkU0alJVQytVdEg3eFhm?=
 =?utf-8?B?U05vRVYxUHNyK1o5NDArSS9uZ2E0dWRuamxtaklXVWVXbHV3ZnRBVmtxTGZP?=
 =?utf-8?B?V2xiODlNcnhJWW96WktPVG0raCtoR05kZVlQMzRkdng1dGlSUlRQaUNCenlu?=
 =?utf-8?B?eXN5bklnOElIMDArdTJteUtubmdwVlFZOWlKZ0JRL3Z3YlpzRTVTeHlzT0xG?=
 =?utf-8?Q?XArtJkbgUXtoPvHLJsPkkcI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f856e2d6-d94a-4b9b-9a20-08d9b95db90f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:44:04.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsqqoG8IDmBYauTcleIDFAq4FINgEARI2NyGvJach14l/0/2Jwkc/H6TmmLKMMBMliEqluUV4TEie4suPxensg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5680
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v2-bpf
head:   241207b4769fca049dfcc4dbde0bda92e4f67027
commit: f6d52d17b96916ae3e76774b1aec80d638dbf46c [24/30] HID: debug: Add USI usages
config: riscv-randconfig-s032-20211128 (https://download.01.org/0day-ci/archive/20211129/202111290200.V12OhjgD-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # apt-get install sparse
         # sparse version: v0.6.4-dirty
         # https://github.com/t-kristo/linux-pm/commit/f6d52d17b96916ae3e76774b1aec80d638dbf46c
         git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
         git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
         git checkout f6d52d17b96916ae3e76774b1aec80d638dbf46c
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
 >> drivers/hid/hid-debug.c:1029:57: sparse: sparse: obsolete array initializer, use C99 syntax

vim +1029 drivers/hid/hid-debug.c

c080d89ad91e98 Jiri Kosina     2007-01-25  1025
0ce1ac3b3ca0f4 Joe Perches     2007-09-26  1026  static const char *misc[MSC_MAX + 1] = {
c080d89ad91e98 Jiri Kosina     2007-01-25  1027  	[MSC_SERIAL] = "Serial",	[MSC_PULSELED] = "Pulseled",
f6d52d17b96916 Mika Westerberg 2021-01-22  1028  	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData",
f6d52d17b96916 Mika Westerberg 2021-01-22 @1029  	[MSC_PEN_ID] = "PenID",		[MSC_PEN_COLOR] "PenColor",
f6d52d17b96916 Mika Westerberg 2021-01-22  1030  	[MSC_PEN_LINE_WIDTH] = "PenLineWidth",
f6d52d17b96916 Mika Westerberg 2021-01-22  1031  	[MSC_PEN_LINE_STYLE] = "PenLineStyle",
c080d89ad91e98 Jiri Kosina     2007-01-25  1032  };
c080d89ad91e98 Jiri Kosina     2007-01-25  1033

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
