Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047D56739A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGEP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGEP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:56:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C010F3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlZ/aPlnkrnQiPS4KtMzYWgEh2HFKLz6m5vJNzrPzmNd04uSsBmxfIjIxcMqirteqmRKpDgQnfYh0G7l4j3LiYj5B/OKgrCC9avGC01MjngpFdeLLJh7xQ+pM8V3aE3M1Nm6FdGss7DVy6DK7nXlGd8ge7RAn884m7Dzrs+RomnWuAbMmvLn1vHbxE4ZyVKkR4/0CRzYCOqPpHn6arPpRbGdqv7RzFqIxT6+tZS2ixfEmFLakv0JtGNmCgT4wvp8Pe6MGC3sVVBDxZgr+xFOPPCsNLQQfet/D07fCUENRG0qAXuPYN5TLjFeSOgFw2oQwbXFO9MN7YZAxfwvSoTW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjMyEbqYPvaU75TqQFujOmryjN0HbAjJDuVylj2I6no=;
 b=iBBE19kEcwR2Vd8VdwFbYF2lKr935SjvQBtRVYZCCtzY+IN2+//9VLvpq8xMuvu+ohKP2Ctcgaqv0hby1VLJwzL0XNGPDnaOzepOmQFObFa8epq433IkoJE2pecj6blxIFjDCODQSqj40vkxl8Uz13yjAaqMdIp1DIOT79anI5/E7noez8M2H2VE0/FGcLsXtuucrlE+W+NcWZX5sBNjcEQMsjtwy9ntBT9oUQWiBzTTW6Pbr4jxt57ENg4u1YPZmjAfVRn3kj2ueaGNzehk9zoTaQNrm+VCpcp9fsOkJJ9B8icTH/JyTX4tFqllWzvlWZi6eyhr8pZ8ffrVFBzmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjMyEbqYPvaU75TqQFujOmryjN0HbAjJDuVylj2I6no=;
 b=yI1Nl/4eOz99TR2EN+142nUWT+Qyz1UWXjRosYAbu/Z3sbM80FId8AnaGuMOn/hHZ9a5X06skNMhrozQTzbBJjeTWgnDXMGbhoqpBNO+6Bptaw+UoQoX3OrctqZTpoCdm0dn8zzx3Bx3p6jZDBKnSz15MMQNPuuapD0P4uq493kPH6B1yH44ETOjlE5w/SgxiEvHzkY5Zgh3CV/kJeAOaBGnb1dNZC9zH7aA5IL7R+uILh8RNhc3C6qL43Do42ONJ5a/Prc9G0oWuUQ5j2Eu+Y8dnfk7D5k5I2g+gB+29jTXRo30nJ3g2vwCuULs5ogNPViYPdd+w/0hq4btAOx7VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM6PR04MB6552.eurprd04.prod.outlook.com (2603:10a6:20b:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 15:56:39 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 15:56:39 +0000
Message-ID: <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
Date:   Tue, 5 Jul 2022 17:56:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YsRTAGI2PhfZ5V7M@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0034.eurprd04.prod.outlook.com
 (2603:10a6:206:1::47) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c671b9b6-8487-434b-a49e-08da5e9ef23f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nBrJZPhFGposH5ympZzqUM5Y5xpsknH6nLnEkoiLwFD9fa24NcPygDUUvHlfROoEHVtMt3i6XxGCdKdIKgtNu67+sEryF71Kc+lHmP31vLuTcrb8VxkeNeqZ1RiRMlu8JegXNNlFHUX63H/Nh2ZG+wQYj0CMUODpQK47fnhIC9ORnA72iLmaN8aKi2BzeimJNNTyQa1K/og0UR4O/WJJFy3RocNF5T1wmgXK8noWri/UbRE8446EfJc9dr+LOHEG2HrwR4lzZPgHfkFR7H5SFVTurxwNAP29FU/4lRHQ2JyO1MH1jlCpAThTVEj/gNqNleMtBedwaTkVTiAi09nCUe/+hkR9ny9ma2vNIYA9u9FTnrM8rbImLF1z8XRRXYrshGlo2uQIC6TmKwZkZUA1KEdb/SoJNQIvs9dtqHzVEDmi5VxJQjPZB9h8/86S5L4UpFi7rqF0s1BUvfi2xDjkvh8shrtOBlY2dxPe171oRckIwqHZRkLSydJT1QCA6YKfLiWGY2S/fP+kw/k+K8tqXBNHCeSjKtOW5RRrFGfw+LaOPL7w+7ra2JZcx3xNg+xuGmD7ZDM+IRRIWzg9CQU68Q/cnLk9pn40E7TsGxsmDwADx1B9Pew9RN8JzIUwlTQAE7SI17kMbv4ZEIBmQuPUygOAfMwKBiELHfg6IInzIjLp/RXizEcCJGggEvROomAPNQrAOu6TV7btO1rtl8NFXSBC7OUAmSJsy5hFtDrbTNzG5U01tXRZqFVhWdEuvoxTHyYTtpuboDDMmJ7Lvm9c/BU0cCoaLns1dwYcemXSYhFI1s2LnxhG6YELPH43tKBaYUy8fkV5MIhb+oFuUZmAYvckFn5fruXbZo6yIJbi94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(186003)(83380400001)(31686004)(38100700002)(6666004)(41300700001)(66946007)(316002)(478600001)(6486002)(8936002)(2906002)(66476007)(6506007)(2616005)(5660300002)(4326008)(53546011)(86362001)(26005)(8676002)(6916009)(54906003)(31696002)(36756003)(6512007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVHbjZOWHFRSGU4Z2NmK1RtRkhQZDZiM2ZXVzlpdklnV0xWQkYrK0FJSXIz?=
 =?utf-8?B?MlhkMXhoVDBwQnJxeEtac2FjK00wbHNaNnRCY3hiSVdYVEx0MStYcnFkNWZG?=
 =?utf-8?B?OW5wcVR3bUliVnVGUGo5V1h6R0hXaytjNUQ3OTV0ZnFFbDhIYnBVWk95RnE1?=
 =?utf-8?B?WnVlTzg3c2RmNmcvQkx0R1dUQ3g0SGYyWnFuajRYNk1LeC9nK1FqT0s3dk9D?=
 =?utf-8?B?NmhESVJtQUVNQXlhSnNVWXFocjlHRmhmbnA3RDBXcXpjSUxRemZrMlczK1cr?=
 =?utf-8?B?SWZwWEJvRkMzZlZlUnhTOGdiS2w3bnBDVktEa3RQL1lZeUNmVEtMT0w2V3Vm?=
 =?utf-8?B?Wm9OM2NUL2RPV1pyTnBiTlRzUjNGaC85RjVscDFKYjdkUlJkVUNhbXBMSzNo?=
 =?utf-8?B?eGkwUVk4ZXp3Vkp5RTJySG5SNGord2RabVNVYkg2d3RUVzlHaE1RM3NiVHJP?=
 =?utf-8?B?TFRkRW1FWEF5RllrQW0rU2tYdndqRlVBNDh1d1E4Ly9PTFhJRVhQMDlremJF?=
 =?utf-8?B?VXBIVkpnTTgxTEcrMG04RGE5S3ZFSzZ3eXJERUMxS3dDVjNqU25LZW03QTQ0?=
 =?utf-8?B?TkpxVXg4L0pSYjZzZDJwZFhXRElCNWthQTFIc09YMytxUzY5N0hUQ3EvUTVv?=
 =?utf-8?B?bTJyWjRXQTlSTW1ZanlKR0JqM1pXL1dGU3l1eldhWWphMGU5SGRPRndEcW1j?=
 =?utf-8?B?VmVzVWlhQ3p5UC8rZDdhREY4Tm9wNTU0RWxBc0cxL2c3NStYSXFQd1ZuQTlG?=
 =?utf-8?B?ZXV6cFp6Tkt1eS9kNmtpbVR4d0Y4SDlmSHRST0FXclJNVnkwaWx4dnVQbkh1?=
 =?utf-8?B?SVk5R1hxSml1enovcytSdTlNT0R6THk1R1dwbVVKeVBrYUpnU3RmK1V5bzVs?=
 =?utf-8?B?S3pXV21hOEFOdkVLYXZ2cW82aWJSdzI2eEhWTWgrZGlaKzdjSnZnc0hXUDVT?=
 =?utf-8?B?ZnR4NFVlVjdJUG1zbXdUSE5ldUdjQ1owcUdtZkRnVVl3bkVMelg0cnNjd1JY?=
 =?utf-8?B?ZnAzeE5GZ2pnOUk4MEFINFZKNFd6SmtNNGhJTFpmN1lNajBoLzh0eVRLWlVD?=
 =?utf-8?B?dmJlVWlLVkduSGRnVEFMZ0N1cE1zSDM1OXF4ayt1RWdPb3lZdDhBQ3hmbHVn?=
 =?utf-8?B?YW5uQ0hPSldrR1BvYXpnKzJrSlBFNVYwbEFBNk50ejdUK3BCYmhJaStyU3Jy?=
 =?utf-8?B?TFdLWjhrS0hFRmRWQ3JMWjNiRzVONkJEdUVCRVRZVzNlMUttMC9aQjVTNngy?=
 =?utf-8?B?UjNZc29wc2VQc0g1KzdoNE81VlpZMXdnd1pwWWVyNWVmcmt4R2VNVlNJNGNy?=
 =?utf-8?B?dm96ZTRwODVJemx2dFpPRXVLcGUzbEw4d0NSaUdsOTEzTXdaZE1iU2VqUXRB?=
 =?utf-8?B?STlBUGl3R1lwdVQ3REVoeUk1QzhhVE1MRFdlYjV4UnczNTRvbDJWd2F3cUNH?=
 =?utf-8?B?WjR4QzBRbEhVTmRrWCtrTzZRd2wyRXlWTHBDbG5SeW91ZHNWTERuMzVFM1Rt?=
 =?utf-8?B?WWtEckhZanBrL3ZWM0xieDZZaDRKem9PZG1pOVNkY3IwSkdUVFlBckdEN1N1?=
 =?utf-8?B?WDBoZUxjMWhNRFhxU3Rkb2tnNTNKV0d2QUZKaFBBRnFkeFpwWHBVbDZ0YWtP?=
 =?utf-8?B?RmlUTVZkNy8wZ3RRSmU3VHZBSG1XeFcyS3hsYXB1V3NKSnZtWEZhMlVwM1B4?=
 =?utf-8?B?T05mODE1VWUxOXRrNXBibFJMVm1BcUtPakRJYy90VVVCUURkTys5SnFQQWxh?=
 =?utf-8?B?NXBqMFZIK0V0K3MyeEJpclhQeEUvOEtTRGZwclZ3OTA1Sk1tNGJqTDJWU1Er?=
 =?utf-8?B?dHF2VXdhRzFCb1Q5eFRUZlliODJKZVJYMmd1NEkrOE1lbC9VQWRxNDJoeGRR?=
 =?utf-8?B?SEZkOE90K3ZYRmpWM0pZaFp3S05TR2QzYVJSUXR4UEZpbzVrczJDUXZVK1VJ?=
 =?utf-8?B?TzRyZGxsMWJsMEFkNWc4SUNsaDBXL0hGaFc5ME5HUmY5L0d2eGpEUTI4R3Nq?=
 =?utf-8?B?WWl2YjJhV3JCc1IyaTZ4TEwzSi9Rc2tYQWFiZ0xsQXQzaEZiZ0h6ZXYxeTFS?=
 =?utf-8?B?ZU1JcUdybk5hNURmeTJpa2RXQWJ1Tk91SVdta2RpaXlJWC9iS3ZkUG96WVJw?=
 =?utf-8?Q?02F52fNzM/vlJgIYpSKXSK6m1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c671b9b6-8487-434b-a49e-08da5e9ef23f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:56:39.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhSO+smMmAB5qE7JdaKbv119E4Ynaei8gIxxtgY8+BQ1WdkhgLWS4RvsorVC3CY2qMYVQDTEn1xqn/E44GEz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2022 17:04, Borislav Petkov wrote:
> On Thu, Apr 28, 2022 at 04:50:29PM +0200, Jan Beulich wrote:
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -62,6 +62,7 @@
>>  
>>  static bool __read_mostly pat_bp_initialized;
>>  static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
>> +static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
>>  static bool __read_mostly pat_bp_enabled;
>>  static bool __read_mostly pat_cm_initialized;
> 
> Why yet another boolean var?

Re-using pat_disabled like you do in your suggestion below won't
work, because mtrr_bp_init() calls pat_disable() when MTRRs
appear to be disabled (from the kernel's view). The goal is to
honor "nopat" without honoring any other calls to pat_disable().

> Why not extend pat_enabled() to reflect the Xen case and explain it
> properly above it?

I can probably fiddle with pat_enabled() instead of with
init_cache_modes(), but when making the change I had the feeling
this might be less liked (as looking more hacky, at least to me).

But besides the "where" the other question is: Do you really want
me to limit this to Xen/PV, rather than - as I have it now -
extending it to any hypervisor, which may behave in similar ways?

Jan

> My comment is likely wrong because I don't know what the Xen HV hides or
> doesn't but you get the idea...
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index d5ef64ddd35e..a8f1a02f9bc2 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -92,6 +92,13 @@ early_param("nopat", nopat);
>  
>  bool pat_enabled(void)
>  {
> +	/*
> +	 * Xen PV doesn't expose the PAT MSR to dom0 so the proper init path
> +	 * there cannot be exercised. Announce PAT is enabled in that case too.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !pat_disabled)
> +		return true;
> +
>  	return pat_bp_enabled;
>  }
>  EXPORT_SYMBOL_GPL(pat_enabled);
> 

