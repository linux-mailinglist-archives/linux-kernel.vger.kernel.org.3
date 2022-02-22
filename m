Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85594C0172
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiBVSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBVSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:36:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254EB12771;
        Tue, 22 Feb 2022 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645554937; x=1677090937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eM1rzVuhGquq94L2yPLLJX/ucf5kT+p813W4AG9KcI4=;
  b=VgwMgL6Denpo4Eiw7sq3pE8UJMJGLhCXw9znyy++7dLyGBlhKkcAaQCD
   ExyJctCs7PiSrLMVC6rQEFup2P/nu9bWPGvsSuOm33FbKGdFaGlFlxNL+
   nY4eVUq9osj3nMSCGCExFnkG9jsKa4XyJ/3jvTteHud7f3gYCDfU8z+hd
   SX4NTB005hPCL+BS5M1XpolOLyI4xPVzCfF9xDjIbOrsxZ4AOGXQ48Ek3
   3KgpKGQ96yjKnkf8F3VJ/ZsMtXFfp+SODNL1+8P7TTIjlNrvWra/Re5pb
   l7QCPjEaG2E1n8hkz6FtJES4eY2uEoDLxQZOppXcc1pLFeStF1ktD953P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231752645"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231752645"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="639004482"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 10:35:35 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 10:35:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 10:35:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 10:35:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX/OXlu+bpmYm/RjwSkbEhz6Q5PtTVMWjWtNmBc08QdiKmHWMDMF7110oDdKYtfx9u7s3eEqWuTJcnzN2Psi4NrvA55h1YXKdjKFcVMUXS76RayBK3mMQUz5CsQy8RC9g8fe7CSufmOG5zpX6aucIuDvh+PsJkQS9dm+7D2CooM35uhNeAejQQgeCTRm88A7jA19G7Mm5mMTbFl5gNeXhrBDndglfYhrujsT7RfElixhTEOtYWLc4kGcm3iisEdJn4dyQimgX10rOJzelpHPQvgwyc+fU/K7wccbDedeGM7c0+S/GKiv2Y7Lhe1aOGcvesFDoj+Qt9musgMsFjIs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A7ftiGl32V0C6Ty+RxeGB6BUuNnoDeAwzaHAQClCX0=;
 b=WTXt/5GFujRxjRU6euGLK+KJHQLGPf8h4d1G+PrmcesJlHLVyylp2wmUrvgKjRdUqZwsu1N0WyRTNVRuOJYAL+pMTnzlUSHzAix0zqx6Rys9lRBffVd2dw2hn059IlGcQCaP5pUXaZmW8RTfo7wkDlLwslRJqT9WN9vNLReJZH+Xai/YHtQ5AZ0/QP9yH8JEOXDy37gOGLZ32JY8EVGEVjvXVZYfsraWDHJ9Ynh+JGsFuH87v8RNBVP1IA6JjKnN3/XdDKP8uMBu3zC1BrowUOxjgPr/EEKiszi/RTQsWZJ2IH6sFrkur9uH0a06IOEivx7Why1kyqJdfarQy5164A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB2656.namprd11.prod.outlook.com (2603:10b6:805:58::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 18:35:09 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 18:35:09 +0000
Message-ID: <d6a5c304-d448-5f0c-6367-26dcba872db3@intel.com>
Date:   Tue, 22 Feb 2022 10:35:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YhLhoMFPyOFZ2fsX@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69f4102-77b3-41ef-0a0e-08d9f6320e20
X-MS-TrafficTypeDiagnostic: SN6PR11MB2656:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2656AF23AAB42669912E261EF83B9@SN6PR11MB2656.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FGpau4LUYRnGhRK391gxLiI7g9CjHLELDOb1fsy33DwhOEJqE2WLkiYRGrZSMRD4Gyss7H+Z2qlcs3tgpYkoSWyCVh5l0Kx+xGVjMnk+ELzOOj1KUl8FyqVXwd+9M6hoByoVTq5ZHOXTt5BSonLEBH1ATKV+DPToi7wS1wf/fFwKUiD2S3sWtR71La4jpPK6PoQ1ODVaplDPO2sTSMLtLDoUy/9ge+qICutExX9UnGJO10xDGphBaeQEUcnB4Ig11kzOW5fYVafMwav2ektgDpQ+F1M8H9CwBwza7o4F4zcjmaXThSmvVVBxbB6EVqTZDfq0uM7uDBqU5TPcm598IYaiL2O4LA1z54mhf4dIuEl2JceUUNb4jl3nZ3T3GUCwD1YMiI80itCutcW+icz0k4zGwo+f1ZFBkALejuZYzJt3QHeUtNYG8fzs43PIYnckAWslx2fCp8cj8RJlMi9SzOb9ljmzz3jCpqXw6AvFloDnAkKTl3BvNqEtfh+BUXSrWzMHAqEUdxKlTUpXLQsAtbk21oolGikUyYYVTc9OH998n32f52onJdPM4ozK/Aik71ONf/9dktuyMEA8GZtir1Dddh8jbhcPKP+5ruj/Hb/M3JpIeoV44eITRvcZvxTeBd37iFpI8I5B4aGUfEijAS6r0amm4Kakz9u2LCJYgAXhdPOWzWPSLvI4ELS/Gsdcfvu7VOLR4RMRaLNpdCmwgxzPytyjayVG6aBOCVApyOBY8/RMy2GZXh5TY4RRaGL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2616005)(6666004)(6506007)(6486002)(6512007)(508600001)(31686004)(2906002)(38100700002)(53546011)(8676002)(186003)(5660300002)(66946007)(4326008)(66556008)(6916009)(66476007)(8936002)(26005)(316002)(44832011)(31696002)(86362001)(82960400001)(83380400001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFaTVliYUpYOGprTDk0d21pQkFNUGVTbTJianpvMUVSUFhqNWFIMXp4RDIy?=
 =?utf-8?B?REhBK3o4Rkd6VmlKNjE3YXh4eVZXc0tZbzFXd21nampIbWJMMFliSkp0Q2JV?=
 =?utf-8?B?ZldqQnBHd0ptQU55WlpaRTVmUnZCL093dXNnbW1xSmQvZmVyNWIvMndUaEhN?=
 =?utf-8?B?MEE2QWF2SFQxOHQ5azJLMElPMmRQTnUxNFRyaGErUG9oNGUxNXhJTUc1Mm5G?=
 =?utf-8?B?T3BoeGQza3NTTi9xSk1wd3BKeGZPZG9RdkJyaWtDNkVIcFpyUzFQZEtYZFI5?=
 =?utf-8?B?YWhSbkJqdVUvWXdYUE42ZHI0RzhnQ1BtNlZQRjkwZkZEaDdEbnR0eXlscmhH?=
 =?utf-8?B?YWNSNnlTbkJROHpzU2tvYUNaeVZvVEhGYURlejM0N20xaFpUTG9EZXJnQ0tQ?=
 =?utf-8?B?TlNIYnlPVWRNOGV5RmpvY1piTXdnU1Z6WEZrZmZiaTdCSjZVU3N1ZTRJRDFT?=
 =?utf-8?B?WmZTazdIcHFlWnpWVzVzeWNLUlVDQVgrVlR5VmdSdVFCN0Q1Q2ptMm1SUEpX?=
 =?utf-8?B?QitaYXVVMURQTVg3c2tKcXVrVmxaVUVmckpQZ1FCWDY1N25GNVMxTDRTVXcw?=
 =?utf-8?B?b2dPejJPODkwZUExaDNjUkp3ejhvcUc3Y2UvY3M1RDlFMFlkTmc2UUduVUla?=
 =?utf-8?B?WVpsdnJlV09TMUdDZm5MaE1XUUwxWjh5RFIxbVg4Q0poRkRJcjcxUzNWY3Er?=
 =?utf-8?B?T2dqTE5JNTF1Wi8vZURzZlg1YlR4NDROVFczcWNqdU5HRFp2SjhVQ3AzczZL?=
 =?utf-8?B?cnVoV0ZDb09sbEl0Y25mZnhIZ2VrK3hUQVF3bUV4dE0rT2gzWUtERFJlTENB?=
 =?utf-8?B?NEFKcnkrZ25NVGZVdVVaQldKL3VlKzZ3QnpxNnJGcmFsZ1dGZHByY1ZzcGJ5?=
 =?utf-8?B?MVZEajRzTVZwVUJqcjFYNEdjL01VMEpVSVRuRENJMHZMem5pT2FUQjZiK3V4?=
 =?utf-8?B?cjBmbVNFNmxQbGh3OHlwRkgvNFpoV3g3dmxQZ042RUp0Q25wR2VVZWtxQUNj?=
 =?utf-8?B?VjlDNWY5SGlQbjdpWktrOERodFlYWTRsTUJwYThsQ2JualJUVklQZXBpL2NY?=
 =?utf-8?B?MEIxVGN5aStLcGJNN1NHOWpqUjdHZURjTW5oUEdlSEQyWHFUa0UwbWJIU0tJ?=
 =?utf-8?B?UXdpNFYwK0RqaTROL24xRXdXeENXelk5WFFVSzFyTzZxQUg3OEVNR1Z2T0No?=
 =?utf-8?B?emhSRitvd3JzS3VrTDIxY2FRWUsyUk1SS3hTSkl0R09rK1A2MFhVTzhFYTlq?=
 =?utf-8?B?WnZWRE4xRTBnMVo4TDVtQlZSS1NLdHVGSXlTQjR1Rm5sanIwcmc2bjhWOXhN?=
 =?utf-8?B?bC9WQ09OOUhCNXRrdGwwSEwvWFJ1MFA3V1hndGo5SytsMmJoMm9razR1MUhu?=
 =?utf-8?B?NFl0WjdpNWlYRmRERVluTjZCWmJyOTMwQ2p0ZytLYTNSZ2xpV0dUYk5sbHdR?=
 =?utf-8?B?eGJyV1RQU1NVRWFpZkFudnd3alcwRlRETHpsbXZXVjRTazJaU252eWdSZFp0?=
 =?utf-8?B?bmNtK05rUkp5MDdXUmJWV3FERTdMb1RrNXNhQStiWk53bSttVG0ybzkzS1dM?=
 =?utf-8?B?aVQvdVl2ZXNrV0dFYitxVTlyTkkrdWVCT08rQWFaM0V5ODZiZEwvNklsZXBh?=
 =?utf-8?B?M0piazZ6ZUk2azBoQ3NISHNVODJGdGdrQnZ4eURHaWRKckZCam9kQmdvek1F?=
 =?utf-8?B?dUhMUGdmTkZqS1E1OVp5L0N4SDVWQ3haSnk1QUlpRXFzMjNlNnpxWHgwcWJG?=
 =?utf-8?B?d3lDRFc1WUJ5UGNRZTF5TllDZVVVdHZPM1RFcHRCaHNWRGJMejJWMjg3cnVV?=
 =?utf-8?B?eXRMQXpXeDFyYm8yR2trcDVkZ1hqNlJRSnEwaFFQYk9HYzJMdEFVZktTeGdh?=
 =?utf-8?B?VlpqdTBjajVIRFoyNjRDUGdCU00wdmNOV2JmU1RuRmZ0SXIyd0k3VG1iWklT?=
 =?utf-8?B?R2NLVGg5eU9SS1BNRmpnQml0ZG9jOTJQTlJ4UC9ac0Q1cHZkRVpXNW5KT0ZQ?=
 =?utf-8?B?aXhNL1h5MFA4ZW5MclNJWkZGZ1ZKdENiT2hrMmJhT04vbGRQaFVlNk8vWFpK?=
 =?utf-8?B?bDcvam5MSEsxS3Y2Z3J0V1pOU1lyRS9JNFJjWGliOVZTbnYyN1FPZWhienlx?=
 =?utf-8?B?dHR0MnBYTzFiTkVkTFF3dGFnTURrRnBzRkp0bjNPV1RLcTNORWFRY0NrSnVu?=
 =?utf-8?B?SXBFR2FsSDZ2YUlnM1pKSHBjNXMvcVlOWmcxK0ZYVmVXYk1JYUZUdDloL0pT?=
 =?utf-8?Q?1IJWo0PQ+b8W81GAK39JDI4lRgfdQCGeR3LPUyBkWo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69f4102-77b3-41ef-0a0e-08d9f6320e20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 18:35:09.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBw/d5oP+WmNwV1r4mIAh55d9iQAIdAdA69nR5HlG3hLrOOGGGBlrFTXeIHMGspYIfR0pXF4ug0JrQR2YoWy3B55ECIYgXW58XNfNYOpNq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 2/20/2022 4:49 PM, Jarkko Sakkinen wrote:
> On Mon, Feb 07, 2022 at 04:45:38PM -0800, Reinette Chatre wrote:

...

>> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
>> index 5c678b27bb72..b0ffb80bc67f 100644
>> --- a/arch/x86/include/uapi/asm/sgx.h
>> +++ b/arch/x86/include/uapi/asm/sgx.h
>> @@ -31,6 +31,8 @@ enum sgx_page_flags {
>>  	_IO(SGX_MAGIC, 0x04)
>>  #define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
>>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
>>  
>>  /**
>>   * struct sgx_enclave_create - parameter structure for the
>> @@ -95,6 +97,25 @@ struct sgx_enclave_relax_perm {
>>  	__u64 count;
>>  };
>>  
>> +/**
>> + * struct sgx_enclave_restrict_perm - parameters for ioctl
>> + *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
>> + * @offset:	starting page offset (page aligned relative to enclave base
>> + *		address defined in SECS)
>> + * @length:	length of memory (multiple of the page size)
>> + * @secinfo:	address for the SECINFO data containing the new permission bits
>> + *		for pages in range described by @offset and @length
>> + * @result:	(output) SGX result code of ENCLS[EMODPR] function
>> + * @count:	(output) bytes successfully changed (multiple of page size)
>> + */
>> +struct sgx_enclave_restrict_perm {
>> +	__u64 offset;
>> +	__u64 length;
>> +	__u64 secinfo;
>> +	__u64 result;
>> +	__u64 count;
>> +};
>> +
>>  struct sgx_enclave_run;
>>  
>>  /**

...

> 
> Just a suggestion but these might be a bit less cluttered explanations of
> the fields:
> 
> /// SGX_IOC_ENCLAVE_RELAX_PERMISSIONS parameter structure
> #[repr(C)]
> pub struct RelaxPermissions {
>     /// In: starting page offset
>     offset: u64,
>     /// In: length of the address range (multiple of the page size)
>     length: u64,
>     /// In: SECINFO containing the relaxed permissions
>     secinfo: u64,
>     /// Out: length of the address range successfully changed
>     count: u64,
> };
> 
> /// SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS parameter structure
> #[repr(C)]
> pub struct RestrictPermissions {
>     /// In: starting page offset
>     offset: u64,
>     /// In: length of the address range (multiple of the page size)
>     length: u64,
>     /// In: SECINFO containing the restricted permissions
>     secinfo: u64,
>     /// In: ENCLU[EMODPR] return value
>     result: u64,
>     /// Out: length of the address range successfully changed
>     count: u64,
> };

In your proposal you shorten the descriptions from the current implementation.
I do consider the removed information valuable since I believe that it helps
users understand the kernel interface requirements without needing to be
familiar with or dig into the kernel code to understand how the provided data
is used.

For example, you shorten offset to "starting page offset", but what was removed
was the requirement that this offset has to be page aligned and what the offset
is relative to. I do believe summarizing these requirements upfront helps
a user space developer by not needing to dig through kernel code later
in order to understand why an -EINVAL was received.

 
> I can live with the current ones too but I rewrote them so that I can
> quickly make sense of the fields later. It's Rust code but the point is
> the documentation...

Since you do seem to be ok with the current descriptions I would prefer
to keep them.

> Also, it should not be too much trouble to use the struct in user space
> code even if the struct names are struct sgx_enclave_relax_permissions and
> struct sgx_enclave_restrict_permissions, given that you most likely have
> exactly single call-site in the run-time.

Are you requesting that I make the following name changes?
struct sgx_enclave_relax_perm -> struct sgx_enclave_relax_permissions
struct sgx_enclave_restrict_perm -> struct sgx_enclave_restrict_permissions

If so, do you want the function names also written out in this way?
sgx_enclave_relax_perm()        -> sgx_enclave_relax_permissions()
sgx_ioc_enclave_relax_perm()    -> sgx_ioc_enclave_relax_permissions()
sgx_enclave_restrict_perm()     -> sgx_enclave_restrict_permissions()
sgx_ioc_enclave_restrict_perm() -> sgx_ioc_enclave_restrict_permissions()

> Other than that, looks quite good.

Thank you very much for reviewing and testing this work.

Reinette

