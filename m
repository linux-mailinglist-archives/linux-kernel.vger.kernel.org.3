Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DB53F351
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiFGBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiFGBXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:23:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7D271
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654565017; x=1686101017;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sTzoaIRLlEtr7mwpaUkmNVxTrStUpjh2/03eT4p427c=;
  b=B0uGpaAKM3rnrvBnypjtp5fvjUtRb4tZ35WyM71qTglcxi6Ahxdv1QYl
   e6wuvQUIivv8PaS4UYuM/CS59B/D3/7fwaCwSGYiW70RJPNJIPscUKMlR
   iL6AigXrHwRKfVHgYm+e/52RHsGiixhbsBmT0OjceBAdwKsOXQo55xzUf
   irDPywvGI+17q5jvpye6Y4ew8dzwRTiyGRUOGS6Hbn55gf9QGakrjrE5i
   pubnSgrpiQiK9JGc558oJIZM2BntmNPFrbUJjuETzn6QTo6UaSoWJaWf+
   8SU5GelGM6OgqwKPTR/URkXnz9PX7JTg1ir26Y7yJaofTnIabGZ5KP2ga
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257145615"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="257145615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="723114302"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2022 18:23:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 6 Jun 2022 18:23:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 6 Jun 2022 18:23:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 6 Jun 2022 18:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUKmJlBu4WDTLBbinAPlYL89iXpCa/BaJezD4tVIUlCsjgIDSDAOq02sXfwdBsLtyXu4mt5/D3+owTuk0qc68GTEUWMOY3mYnvR4TTG0YNO2esO9SZ7D3+WSCRk6QglFWDzmekO9vIPWeeS3ynMJ4g/5B4zmxSURbDtB809Ig2JlHlLSU1kTQocy0SFxKozzA9I0OKJqiLTAnwhixQ8yKXo+udfUeUZedtWTcLjhCKzEguR85ysUOMIsUAnRYQWfd1aN6ad+c4G6d7XymScwTkF2XoWKIP+KpIcL07MiiEWtvyOLMrLDB+FKM/uy8/eCRqLsRuuZC5OsIvodbOJd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf8k6w7R9MOZ6etKhRm0N3PyNrR9zKVBCRASniwOMdo=;
 b=MOfRV2C6yFvHFwRi/QbnrCnpxS6KDmQITB/a0zYRGzRiDul8l3q554cNWSsRv+pHdaaMyhIM3HKtdOCHeViVrL9DsEdONeutQXsyCK01ArdNyrmp2sZeiX+qSkY0iwX+TI3wcCOG6FJLcM3y7dTpomc5CBEX0RfM2Twb7AItNK0ZloSixdA7XLmrRj3rfZeZ9BK8uzgVMmUD9iuD4/7pHvQyEDjiRXlYMlCRYO5MGQhD61yQubW57iKo2F++cO7ApSDYsemHnyH2loXJC2+sOcGP8M3et9ztIQrbcMVXrhPaXQYQ7NSL4MIR9jH6MPxlGdX+0jyKMP3fC4VsMcyi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM6PR11MB3724.namprd11.prod.outlook.com (2603:10b6:5:13c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 01:23:34 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 01:23:34 +0000
Message-ID: <e10af318-f39a-9bf2-ad3f-f7c9b3acef84@intel.com>
Date:   Tue, 7 Jun 2022 09:23:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/34]
 arch/mips/include/asm/page.h: asm/io.h is included more than once.
References: <202206070754.4xoqt9p4-lkp@intel.com>
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202206070754.4xoqt9p4-lkp@intel.com>
X-Forwarded-Message-Id: <202206070754.4xoqt9p4-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d110e7-36d3-4ff3-fbd9-08da482456ea
X-MS-TrafficTypeDiagnostic: DM6PR11MB3724:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB372452581FC3399AAC424EA3FBA59@DM6PR11MB3724.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KANfDsRB342nqq+WmIGRZu5A7nr1ppig4BG9J+2dtc2w8XEuWZowlc9AlAUqnYIZ4oM7l+lOdApIPmhMyfYteOSEjbE0USBbD+R9RYL9jgFmSUe2f7PnuYlt+2qq7LH0zwXYvaP5AtYc9Vbvp+nVj0ZtS8SAHZsS1HZt/ZzIKl36LBwbY8G24Sl6SOyXDicapiAzaf89NIHqPohV3cDUqgMooD09gYQCHORjP0TbhPD5fcmfKBhZkXfiXLsR9k3Jqnb6dYwz7x11nsQagoSS5rvdqIqadyPNe1fsAxyHnpJgnk9DILlETTZngzAt28wqlEoWNL/OpJCHnX9oEaG3YUp8NiLAmB8bFR8Q6mXGh43Ts2cmQRhqd1gAz18xI0NFilWmDjZ3OBxyvatpuuzMOvVovNyUrjaeG25IdZtC8jqbLsT7ticB25mhslThc/YeUan11X9hg6vxfPihk7UBeRQfsLul5sDlEgsRmRlHFIdo78HrmmB+LpiAg7eru/tZ/P1Nj1zs9fu3CIYw8v3cqcAcA35eexnIjyoG97NmrIyMSxu3v83SswPTdVmpjQUtL5U8YcvXkKjf4rZ2Z4lvXlwK4MRbIO9vFRxu9z0HClgYqFe+4io7NJLshb+A3bDiTBP1dqLogBsoTA3ssUBYE3Jua5V1w2CVQzCmfambKsqJTQLYjS5j6ZTYDJAyuQ8rXqEwfNCQRXf+mzwpJPKm0tXlLgl05fhFK4z0LTaUR2yIuR4TyS97qomGsX974IXX6fNiNBzXRutZWo6kg8A8w+V/7/j6iW/q/1apopmxtUd5qmhY+RN1E92XMZbD0GcR3nBG3aJFvtMhstGm8Le+1fS5wzo4sCIm3BL9lxRK3s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(5660300002)(6666004)(316002)(6916009)(66946007)(31686004)(508600001)(66476007)(66556008)(8676002)(4326008)(6486002)(186003)(966005)(6506007)(86362001)(36756003)(31696002)(82960400001)(26005)(2906002)(2616005)(4001150100001)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFmWDhkeWd2TzNYRUp0b001L2E5aTh0azYzc3Z1V2FNY0dVZk5ud0M5dlRH?=
 =?utf-8?B?NmNhcTY3Wkh2QUgrZnpTYlVydHgrSFhVQ1F5VTM1ZklMSUtEZnY1QVVIbnIx?=
 =?utf-8?B?YysxVlhYNGdhVlpCN2huQ3prMGlvNFpRM0hMbUg3enF0KzJKcExTbE1mN1Mv?=
 =?utf-8?B?TjZ5RjZQd0tmWElQc3BuR1lMdFMrVFU0V1UvTUczMXZubTQ1eGt0ZHBMQmNG?=
 =?utf-8?B?VmIyMnFjVTU2MlI4UW5abm8vaHNsQzUvQWhaZlV6ZlI0VkVEWHZONlVFcHpM?=
 =?utf-8?B?V21XaHpUbk1uSUNUaFdUMVV1VXpwN01WUWN3UUdZUEhWb0dmSlVVai9DSEh6?=
 =?utf-8?B?R2xrd21sZERDd1BxYTNDdkk4bVdnMGJEbTM5WnlUTUVPSmxtWVptQ2VJOFBy?=
 =?utf-8?B?Yyt0LzZTcVRnK0xXUllYUG85dnExOVdsS1FNekgyYzJQWW9FSlEzSjFPYzRM?=
 =?utf-8?B?d0o2djJTeU94YmhUMzFwSWlLRCtrcHQyeHZPcmNEZE4zTXhQQ1pOSm8wUUds?=
 =?utf-8?B?WGx5S1V3azFKNlVoczdDR2hxL29JQjVqY3MzdW1qdHVYQUNKWkIrYTl3ZGM4?=
 =?utf-8?B?UEd5RGErTWcrd1ZPQ2ZSRW13OFlBTE9LdmlNZ1lSV09PYkdqRjlrWXgxU2VL?=
 =?utf-8?B?K2c1bCtpSFFYSlFjM0xISDMzSHZRbnRJdjNvVFZmUnphVVF3YUZLMUcrbUJK?=
 =?utf-8?B?RVBRZkVRS0NVOStxb3JFbUpIYlZlUGl1eklHWWFXQlNFRE1jYWJONVhkZGxO?=
 =?utf-8?B?dFV6Tlh1Tm5zRUR4aFNraklWcFJnMFVqVnRFMVZxamMrTWdpMjBWalVCQzZE?=
 =?utf-8?B?MFZDV0pmZE5COGRwTTdPUXNvTnBBa2k0dUFyVlk5dDZTakNhRGkvMlJ0L3I4?=
 =?utf-8?B?NXlvczBQTkpmckxnaUh5YjRKRWN5OEx4N3Z4MTlnUjg5Y2w2S0tlQm5pS2hx?=
 =?utf-8?B?MjBTY1lnaEc4R2ovTFVTTW5EZXpQdmo3SG1obmdqS0hVM3lKYmc4c1RnU2kv?=
 =?utf-8?B?RWkrQmFPVk9rUWZlTGJBeTBVeUJNdVRHM0xGZWZnWlhNNytHb1pWZTZtTjJr?=
 =?utf-8?B?N3FRYmlKUDhJRUF3WkMrM0JNd1ZNeHpQelVjQ3NWd3RFb0E0VnBjWG96Wmhx?=
 =?utf-8?B?eG16b0dOU3BWSzQ3R0prREswcFl2aEpsV1hIdURoMmQrRkNwcmZtN2FNQVRa?=
 =?utf-8?B?dWxjOFpzT0JlQWk0a2NzRjY2YkRDTEhHNnZhN3RXSlRjelE5MWtPclMxQ3Ru?=
 =?utf-8?B?TDk1RUh5cUg1UWdRc0pWaUlqY0NFR25hbFVTSWZmdk1ZUzZ2SEFTL0MzSjZL?=
 =?utf-8?B?T2JRN0o1bjNBZVFwMHEvVXBUOGZvS1hJaWg5S0E2bTNvT3BKd3llanVmeFpa?=
 =?utf-8?B?dTJFUDBuSjRUTDdsZ05PZkQyYjA0ME12RXlGUzRuVVplV3F3OVZCK2xydHA4?=
 =?utf-8?B?Nmg2cERid2N6SCs4M2ZST1NtUGVQZUU5czRMdmJ1VzFoaVhPdnl2d3dMUjZa?=
 =?utf-8?B?UkZORmZDQm4wWm9EN0NodFJWSDJzQnNkM0lJRFBJbnEyYThzMFRTODhKRDdU?=
 =?utf-8?B?MXU0UHFyblY5L0FRWWxJRjFDa3RFdEZ4U1FYRnk1S0V5SVN5ZndnQ1JUOVBW?=
 =?utf-8?B?dVhFeHJ4NzZCU3IzbXdxYjQ0bGwxQlZFOVZMRklNbmllQUMxcG1sRnlOZ1ds?=
 =?utf-8?B?aDVnWUZIMGhNM0xwZlNFWXozakN1NHp2d3RTSzR2elFQQlVNKzAyYlFWNlNl?=
 =?utf-8?B?K2R3TkdYalByMmF2L0JzaXNBNmRieFI0UEZvWk1JQi9Tam1kbmxISFhHdWhO?=
 =?utf-8?B?ZXNwQytMa0tHejVES291RGZUVUZhcDRIeGRYblJYQWtFbm9OWjd3RkR2L1Fr?=
 =?utf-8?B?MURuWHJ2Nm43WG5yQmM3NzZuSlp5ZTRKVGJDU0h4K0FtMDNQWDkrUjB5RWgy?=
 =?utf-8?B?QlBsSmZTR0NkdlNPak1nSHdRcFllRXhwWjY1a25DMGRzSEJUV2JrUHdrZytG?=
 =?utf-8?B?WjJ6R2RITlAzdmZibEtLRDVXR1RRMHlnMGdsVXYvS3hQREJxYktZd2tRcFJn?=
 =?utf-8?B?UGxUZ2p0cGkvTGVVa1pkWVRITE00eHlZRGJEdGZIYU1MWEVWLy9kSWxXK0dI?=
 =?utf-8?B?eHBndEJib2tXMTBRd2JiR0tmMG43M0Q1MDJWUkcxZ1IyS1ZEZlJTYjN3a0oz?=
 =?utf-8?B?Lys5NEFnUzR6TkUrNis5d2R3T1d4MHp3bDdhcDBlWDRBRzFwUm1Jc0k3c0Vn?=
 =?utf-8?B?cG1sOUNBdGcvM3hhcWpQWE9XdlhheHMzcXY4d3o1U0RwcmY0NnNSRW5GWWtq?=
 =?utf-8?B?YW5ZWjNrY1hvb2RIbktwQThsMWRHUGMzNFBlRDFZOWpIVE9IT2p5S1dNaXBr?=
 =?utf-8?Q?9OAyYFnACHjrukb4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d110e7-36d3-4ff3-fbd9-08da482456ea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:23:34.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKyLtIJ/UcIYDpVobVZAxOW6eanlDJFlTDdAmrm7n/Hbj0xZUFzt/M/nmFdzy1ezGU+fgiuGI4MArVujVSWtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   1aafd4ba7b78b4ac0013a48a35252654852cb7ab
commit: 528ddc725d2f4c648357c9323487fb3f9a639cb6 [26/34] MIPS: Make virt_to_pfn() a static inline
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> arch/mips/include/asm/page.h: asm/io.h is included more than once.

^1da177e4c3f4 include/asm-mips/page.h      (Linus Torvalds     2005-04-16 15:20:36 -0700  12) #include <spaces.h>
99502d94c3649 arch/mips/include/asm/page.h (Nelson Elhage      2009-07-31 16:58:17 -0400  13) #include <linux/const.h>
75b5b5e0a2627 arch/mips/include/asm/page.h (Leonid Yegoshin    2013-11-14 16:12:31 +0000  14) #include <linux/kernel.h>
75b5b5e0a2627 arch/mips/include/asm/page.h (Leonid Yegoshin    2013-11-14 16:12:31 +0000  15) #include <asm/mipsregs.h>
528ddc725d2f4 arch/mips/include/asm/page.h (Linus Walleij      2022-06-02 09:59:18 +0200 @16) #include <asm/io.h>
...
0d8d83d0447de arch/mips/include/asm/page.h (Paul Burton        2016-08-02 11:40:57 +0100 199) #define __pa(x)           ___pa((unsigned long)(x))
6f284a2ce7b8b include/asm-mips/page.h      (Franck Bui-Huu     2007-01-10 09:44:05 +0100 200) #define __va(x)           ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
49c426ba445f8 arch/mips/include/asm/page.h (David Daney        2013-05-07 17:11:16 +0000@201) #include <asm/io.h>
5707bf6bcecd8 arch/mips/include/asm/page.h (Ralf Baechle       2010-08-17 16:01:59 +0100 202)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
