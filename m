Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D85A8978
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiHaXQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiHaXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:16:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E991037E1;
        Wed, 31 Aug 2022 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661987755; x=1693523755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U/Sf2YmDZ8An+trF6UOVGCu+TZ/OSvjWITNbofvCReQ=;
  b=hgy05I5HRWAAyyGOeL3L4BawLn7kK771nURr7BADfobSQHeNQHifdbWQ
   ebSR+S/8HqCCQ43h5DHA+otPOGWQBNadKbQDsrecdUwAmT/zIznk4kDhO
   5hx5dlY1uzOoQqia2yppR4Gxf6a9cWrZX81IutAx3Ag8QTXWMjBRMfZxw
   Qaroq/FWznu6j8d+Frc/O/zqniQjlYHurD4JB+UVPtlCTzAy9xKpOPcQl
   YHIwWIF3gGoR+dxFaLPfsCNouC/8TW14djkKMyIWzxFGOL79d4v/Ji9f2
   MLA/INOkkSTUlrfrcwSuzYcu91v+tODk4WvDOECiqEXv6l5IJRF0KLbd8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296353630"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="296353630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 16:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="673568821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2022 16:08:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 16:08:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 16:08:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 16:08:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 16:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOQYkbcYOJADMVagofat2wznQcKSue2ZjsX+yJpjM9QKa0QS6HMe2sPTZ0A6/M9mv/hUsn6pSpLDjIaLPS+vJmdpM7MoE24FYXGp6emb/mJSVi1hZ3KEwJnaHcDdQwu2uSX1ORXoiU9b2aMJF8M84LrF5qWmcsGsnGapHQq940KP/L2F79eRXWQbBz5hhkhbxcOJXEYemz3yIuv+2t19i7U6/nEkdvw8CfFli2keRIRFGwmV5CrXF/oL96yUwk+gQt3tpgNzjfRSSLGWtxpqcPM5upTsgGVKHRHjLypDN2Bt5SzDnIQNdssZHMjaDBLnYyxOXIIdFrZ1tPlR37miVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBwatmfRoC9XOV0HsMcGrEZIOtC8FGQXpYeI7HndLVY=;
 b=ebCNjbliJbNBOt6aNy/DK2rJv8JwMOzM+gtcylU4opmv32cu+1KjNxl+WnqbnQMEEwMhgvMEO7JARANKwBImaro6a0qIqPI29j/r39lf3vlcBKSXOaTcbukr00/UfC6ufRerzxtiIViBM2CxMyPWofCc90gWYefxQS2xHcQXC7wkgXM5bPONBMJVbBvZix5jHLCn++UxwRj6jHw93TxKNh10v1bM6XbDynxA10uO+03UjOlutgMHIgKVfLCgCN+ClwoTYo61WCEj2b7jjnjmwVgSVxcwiiBGnMuBA6B79zWb9ZHM0BeBJYZg21Ci/BS/WWClKCdTXlfvixSgAGub5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 23:08:26 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 23:08:26 +0000
Message-ID: <a3fd8d2d-72d0-ba13-ef77-caff2b239867@intel.com>
Date:   Wed, 31 Aug 2022 16:08:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Content-Language: en-CA
To:     Evan Green <evgreen@chromium.org>
CC:     <linux-crypto@vger.kernel.org>, <dm-devel@redhat.com>,
        <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, <x86@kernel.org>,
        <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        <bp@suse.de>, <dave.hansen@linux.intel.com>, <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <kumar.n.dwarakanath@intel.com>, <ravi.v.shankar@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-8-chang.seok.bae@intel.com>
 <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
 <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com>
 <CAE=gft5VajfoAT6hVxiCzAMYiDV+pHRbC-F7s4+qK94qa0og5w@mail.gmail.com>
 <6f2dcc0c-99a2-8698-13ae-d5cbea9945b0@intel.com>
 <CAE=gft6sO85RBpfdXnR=_r=KGmVrx0mnBOHK7XadNk00gDr-WA@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAE=gft6sO85RBpfdXnR=_r=KGmVrx0mnBOHK7XadNk00gDr-WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8c5ac4-4a09-4787-056b-08da8ba5b5a9
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4896:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJnHBJEbz6R/0wjAXjsXzrfIK7G8gO87sxoHMQ4ZS7ntIzpcnDkkJOtgOU3nDqO5f6wtgJwlt3ISVCKv17bOCHblfNSjUaeHmHzPbJ4soARXYHoVJFpWoyBXhmKpVqVQ7nPifaVmqWlfR8n/ywkDSqv+Vqju649/6hlMD2RqzMvPBqhF3FZng0nGZCUJDum/4uWqu9Zda3/6yf/NYtU6EWJGFPoP0oGcULRr2jFCcmonssbj9cx/RCFQVRHSc5hV8ViPybJ7IVYZfNhjfzLoQYm1B9pgoy8tnULQRq59dmbFVQmrEPM/Xu/0YDJvT3PzCMIAgF4RslvqTvD46rb2nzAH+GtD3MLyyRju/xMWkELHFC/UXFsBPlg7kCiXKhDrwrjnm8kFDllnq8ozcbmCe5/BpZQe2EqciFRE+h0mCb3RoDhoIRUSwvxcTfkhhAAHOAoMxQ1mBuLoJQ0RflePyDoGLEn3lya2tqZw4NzSuw11UCMfxK+EgRpSxpKV5y9oxiAjLsjK9Bet7SIqcLrcLAcNNbNZj5ZL1sFndQjGj8G2LmORZWwxU9wbv1EsNA/2NI7SH6tMqF2RGm+LJVvejbCgyAvaSt2pLR8nZhYk9jRwFKncel+FEHYeLi4A+8G8y8xGXdjLViSMMTmRPvwEAM/eb7ZjR+bktzrXZQqEZXILKmFgoJHeoenPhxbgp7vixdLujWjef7dGjqIZ2+fnWpxSzYA9fB9moFgge7qgjqbT7YJdsGuQvqmFzu0xwf59jSfJYMpC/+pKDDnW9l7XhlNJNA87DVdLRZxGWydOebm2eE/PSbcOKnI52T0QxL2NPOGpH9/9CoNboqirhHcjZVRwBbc3RRabkAVjABYvp/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(376002)(366004)(346002)(6916009)(31696002)(2906002)(36756003)(54906003)(8936002)(7416002)(83380400001)(6486002)(41300700001)(966005)(478600001)(6666004)(6512007)(26005)(6506007)(53546011)(86362001)(66556008)(316002)(31686004)(66946007)(66476007)(5660300002)(8676002)(38100700002)(2616005)(4326008)(82960400001)(186003)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzA3dnpjcFB6anc5NTJaSU1zVHUyNFRDRDM1V1FCT2gycjVLdS9TMnhhckd2?=
 =?utf-8?B?dU9Ld3BkcFVyVjdEY1NsMEhSbGMxc0RydkNNMWlYZ2hFbWlVMUUwbUNzamU4?=
 =?utf-8?B?MTBBMCtYUHpTbGI3R0cxK251NEM0d0tXcHVjRzAvVEJyQ1FJQjU2NitLeERQ?=
 =?utf-8?B?U1ZNN0RkV042QmN0U0E5ZURNTG5wc1VpM2ZVUGVOWDN1YzRyYi92SVYrbGQx?=
 =?utf-8?B?RVd6cExlZ1liTGRocnFNMTBFaUFjdDcvK0xBMmprcGdIVkdOOHpHdmJ5QVYr?=
 =?utf-8?B?eDJaVEJDK3daZnEwZW1TOVdML1AzN1BJeVpFZ0lnK0h4cFdVOE5vUXQ1LzNy?=
 =?utf-8?B?dUpaamMxQytScmF1K2hmbFBaQll0U3UzRzlZZlprZEN2WmdOSllNT282cjhm?=
 =?utf-8?B?cHVPTnpxMGxvTDkvS0VrYUgzTlpwSkNvZEJBRDhSR241T0tSQXVJYVF4OVRp?=
 =?utf-8?B?ZzUvaEdlSmt4T1VXcFM0QS9WOGRmK0tOdGJOVnp2NE90Z29zck1wZzdHNHFi?=
 =?utf-8?B?dGxSd3lSa0Z3aG9rczBjcHhoYUxlaDN2UDRrdXYydm4zM3k0QUdyeHJXOXlO?=
 =?utf-8?B?VEF1VmtYUzZaWFdCWUgxbFNLemg0Wm5LNmgwK3FzZVZXeGRxeXduUEIvdy9s?=
 =?utf-8?B?Mzh5YmxvRzBKRXFaN3FvL2ZxQ09YYjF4MU1wVWhweVFIbDd1Q0d5MmMzS21v?=
 =?utf-8?B?aDd3OHF0bzk4c3IxTzJ1Y0hTMFpsNGNPZTFsZ1Z1SUtNQW8ydzN1OU0relBD?=
 =?utf-8?B?YjAyRndVaVhGZzIxRHhESFZRNm5JVmdVMEZpQWVjcVlBZmp1RDJOWnV6S3VN?=
 =?utf-8?B?djBQNFpOeDMxc3pKdXRpSCtnYTBQbTNTUU5ORnBCZmhmWVM3YncyWWkvZXhL?=
 =?utf-8?B?RVg0QmQreTI1RlVacUZNcWpPdUpuWHp4bXZZWmlGVVg3RlkwckpOOGhBVXox?=
 =?utf-8?B?T05Dc3dVOGQrYjI0ckZjYUh1VUlNVXpxN2Z5ODYwWi9PaU1qei9TYllyYTBH?=
 =?utf-8?B?WUgwaldQY3BoanRCbUhZTmwxWkhLem1iMFdMTFZHenljdzVWckxqL1ZiUlFI?=
 =?utf-8?B?N3JkOVR2NDZUMnJyWkY2VXBtYTREampPMlBkY2ZnaXYwK2FyTzI4UW1YSTRH?=
 =?utf-8?B?czlxelJsZTdCY0YwQS9DREVOMlozQTd1NUNxcW9iU2J1Q2tUNUJZUWdFeUdu?=
 =?utf-8?B?ZFZodWE5L29IMlFiTnBldVFIdlIweHpLdFA2anFqblRMZEM2MjFUTlV6YUdU?=
 =?utf-8?B?T3BzRjJwUTVCUWltV29jeHpKZUQ1cFZjRkk5TDQwOUpzU2xJa0krQVY3SGRI?=
 =?utf-8?B?YnFhUjRHbjBac0MvRTUrVng1dzdSR2p6Qld5NldxL3V0NjdvUGRDRjlIK3JM?=
 =?utf-8?B?SUNrM2xQUnVYVDJ0N1VQMU5KbnZZNXNmV1JKUndWY1l0Tm5xWTFQbTBCRGFB?=
 =?utf-8?B?dGgzRjBqRTl2VGVuL25wcXJuT2pMUjkrUmEzRXVJOUdPVnU0VWk5T1N5bmpy?=
 =?utf-8?B?L0lFMEFtZ1dOWHJKekJjZmU3Kzllc1ZZNmdCSmFGZ1RnTFdZYzl0cnJYME5M?=
 =?utf-8?B?d1VLaUZ4VmZRbi9GVGg3YWVnR214TkVycDlBaGo3dktpL2xMbjRqbFIybWJa?=
 =?utf-8?B?Q0w3NmJMQkR0R0VrU1U1eVEvWVhSVXN0bFhNTXBwTnJzNVBiSGVJQWozQmoz?=
 =?utf-8?B?bzNwbzZ1NGhnKzhhSkZ4eEdDSTNidEJWQ080MlVrMUpGSkE1cStDNXJqbGQ0?=
 =?utf-8?B?cXVWUmRKT2pxaXFmOWlxbW1ybGFaVTU5Q29FcW9zWTQ5bFN5dWtodm5wanJS?=
 =?utf-8?B?V0FKK0RHQk1qeTJNVVo2cE5FcVB2czlIUzVlZTdGWUlmd3QwSW1HaCtYS3FS?=
 =?utf-8?B?QUkzRVZwR2U4VFdYR2cyWWtkSEd5RERHSDF6Smg2aENmbVVRWGNwVEF0Y2Fu?=
 =?utf-8?B?dXIwQkxoeWJVMWpQV2ljVnVPUTJpTW9YanJjd1VITVY5dlpDYzFGOU5wWXhu?=
 =?utf-8?B?OTBGVFpzK2tsNlZ0STk5aFdoWEJTRHE1NjJGRSthMnJ1ZityQ2RENnQzQkpU?=
 =?utf-8?B?Z3p4SFZPd2o1Wm5GMjZCRXcwQTdwR0JnTkJBdzFwRWVNWGpSTm5pNjN3VFlP?=
 =?utf-8?B?czNpRjFJY1hyTHpTK1Fuenl6eG1hWUhiZXFqQTBVbFZRWi91L0JMVGtFQmtX?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8c5ac4-4a09-4787-056b-08da8ba5b5a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 23:08:26.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH8RFdZjEiktGbcz/qJdvLWfd902t2b1ywr8ogrQD8vcLGUISjcHaOy+ix8SFULOrSADjp4xGtt1tSnxkJncTPlLGZzOr0uQrPmSuJKk48w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 8:31 AM, Evan Green wrote:
> 
> Here's the log I've got that pointed me down this path:
> https://pastebin.com/VvR1EHvE

     <3>[43486.261583] x86/keylocker: The key backup access failed with 
read error.
     <3>[43486.261584] x86/keylocker: Failed to restore internal 
wrapping key.

Looks like the IWKey backup was corrupted on that system.

> Relevant bit pasted below:
> 
> <6>[43486.263035] Enabling non-boot CPUs ...
> <6>[43486.263081] x86: Booting SMP configuration:
> <6>[43486.263082] smpboot: Booting Node 0 Processor 1 APIC 0x1
> <2>[43486.264010] kernel tried to execute NX-protected page - exploit
> attempt? (uid: 0)
> <1>[43486.264019] BUG: unable to handle page fault for address: ffffffff94b483a6
> <1>[43486.264021] #PF: supervisor instruction fetch in kernel mode
> <1>[43486.264023] #PF: error_code(0x0011) - permissions violation
> <6>[43486.264025] PGD 391c0e067 P4D 391c0e067 PUD 391c0f063 PMD
> 10006c063 PTE 8000000392148163
> <4>[43486.264031] Oops: 0011 [#1] PREEMPT SMP NOPTI
> <4>[43486.264035] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G U
> 5.10.136-19391-gadfe4d4b8c04 #1
> b640352a7a0e5f1522aed724296ad63f90c007df
> <4>[43486.264036] Hardware name: Google Primus/Primus, BIOS
> Google_Primus.14505.145.0 06/23/2022
> <4>[43486.264042] RIP: 0010:load_keylocker+0x0/0x7f

But, I don't get the reason why it hit this. On the wake-up path, 
copy_keylocker() is supposed to be called.

I added some printout in there, and it looks to be fine with me:

     [  218.488711] Enabling non-boot CPUs ...
     [  218.488794] x86: Booting SMP configuration:
     [  218.488795] smpboot: Booting Node 0 Processor 1 APIC 0x1
     [  218.490634] x86/keylocker: restore processor (id=1)
     [  218.491186] CPU1 is up
     ...

Thanks,
Chang
