Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3D5978D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiHQVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiHQVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:18:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0B5F22D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4rMoGPjUB5xBqILf2XXA7mWSbyDlCUi1VdA7sNEDPJ765f5BhRTpnksqZwj6/kMipn1iTsA2Y7PotBHVWm+944Q2jkwmvGTGcDIgI2jJaQ+czPV9yJh1EyTHY2QQFbIk5w+v9TMq9oiRmFndrrJNSMEjYXO3Ss1yKdhKbxOlb+j+C9xDNkiMLnJJnOCs72vbtu2+acwXO2iHZ/M6zGm1pQiS++92so3K+D2wcUVuAfoHcJsAs3fFYAh4PS924m5Bq8xRc8pkxUe4f32H8edJt7LlrE+NhFwlCngRmW/DVh1tXO2XpRT083ykPb992uODUxAnGTnGRvt+QiE0BIiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgjFfnCITCnT7oKChzK4lQgfG1EoPoOSf/hii9Gge9s=;
 b=KGRqFmrccnIWs8OnDJUOI/bAmp/h/HkIjKlTQc76MlbrNBp3xGrDrnYSuQXa1NcJz+feyRpflzxgMSFz62h3Wof7QVidyytnVFRD10DhwHYAzZj78Z841NK7K8+5ObF6hzGvy0gHneZ84nf9hHIVBwBOZtyzniLHrd9Nw8ywan/T0kywtRQ1xjtY5pDYplofGgkzzQACtMtgeQ45TOH8Efigm5c8UJCCg3pQT24N0BUgwmtbzOoySRs1mnPqQ1+00ATs0z5QJnvS6m2cBpsRzGBs/Djcr1+3QjHXREH734idj3KXxyBNyJWwyTuvRWDrTmHLr20LjvzNSJEoi0NpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgjFfnCITCnT7oKChzK4lQgfG1EoPoOSf/hii9Gge9s=;
 b=U5wXacybEawWIN/yE6aO87tvxRsQlNeTvIctxJrioLXaW04N49z1h+BtNcsGXfsiIUzfG0cdWqvBeCTeNUPoiPuZXIbcOenC8SUnHQ4V8oahK0q35IK0QQc05rGOr0E4pFGlOEUo7pAFkBBwvIw7FxIfZgB6yDCbNTS4TKRgp/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Wed, 17 Aug 2022 21:17:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%6]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 21:17:57 +0000
Message-ID: <97badacb-7477-5a85-d089-4a5156b57e30@amd.com>
Date:   Wed, 17 Aug 2022 16:17:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1660579062.git.thomas.lendacky@amd.com>
 <9017076fe1050b8a38d5ee8447b827a5c41c4e72.1660579062.git.thomas.lendacky@amd.com>
 <Yv0ScwQ0LGkPM+VV@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yv0ScwQ0LGkPM+VV@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:208:32e::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce7d4752-2644-43d9-8ce8-08da8095f4a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a76NPwDki0oipjbXtaNOXcfi16N4nOB55ZVF9LAgwZDrVPHr4wDyGhO8RsL6vbllmtskQgr4p67U2tgv/6yltVORQLSnauJwqM3teEVFni7h2WBmH7LUpqwvjsiqLY2JfIOS5a7Z9wmj9tRhjHUQpooB6y7az+cktFu4WiQDMVumce75LP3gMPpEijYLFdPQx4Kx45OepPpwBLpLZcO0ACrAbi5K/e4R0vnumwhgTlmhCZZjtYqyPyJpOeZCo4iQUUyeJ+FlQVxfnJn6ZYn4yfShmCtL0kf2idroftryj2/FzKGjtp2kjBHEeHlZGkFLhEOZa71eh+v5uOqg664rzFRur2XIGDoAe6nTO+lfPmh4SsV9mzIlyhs3nXEOXyegjnDVf5wwy/tW8nacHVs2OgQ6aP+hdiT0AcK4XYv3zwMRO4sIqB3Fe+jowyTpHEkkLfOW6nXXmQQA63BvxVCCaY/yuCnQZ0OAC7/FOzmg3NUOs9DNmkVokhcqpLQvyfe9lIFlTS7Biw/7Kc3uExOBMIt/JhGVRJvk9RbA5/rKZcdLb+B+zD85YBGgIi7SBXk2k0neffG30EBan6gz9C0IlZt+Dz2Gi5nsHXlHXtgPLaaVg+O+vbmdI3Ju37Zawvhwkp0kpISI6kY5VWSGjNxTwfpL1qVeVmzPQ1BpSIbYP0C6p6N0oihJK0iduLbVfhA3wBljPf2nlvtAGLU989v6aQPGXcpynn+c7mhEMB94TPJcZx10gPp5Rc7H21Abk8VoW9v0lTFPiDf0bu9yFp9wU3fB9H5oCe8mRoCi0V4H6Z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(31686004)(7416002)(8936002)(6512007)(6506007)(186003)(36756003)(2616005)(53546011)(26005)(6666004)(38100700002)(316002)(66476007)(66946007)(2906002)(86362001)(8676002)(41300700001)(4326008)(54906003)(83380400001)(6486002)(5660300002)(66556008)(478600001)(31696002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVBalU2MkNUSXg2UXF1NmJSbHlXeTNVR1ZKVjlua25FOUluY00raEU0T3lS?=
 =?utf-8?B?V2VoYkp5WFg3Nk1pL1JTZFhHb09KUXFVS1I5U2J3R2tRdVkwYmF3TU1GampI?=
 =?utf-8?B?ZXNOMzRYdmNaUEUwMEkxdGFlQlVzQUdXRE9ERkFFaklPZkg1RTNXQXAvRmFF?=
 =?utf-8?B?eWx0N3YrWlMrMGxqbWNDMWM1MkdTcDIrdi9MUUlLNmM4QnVtbEhsMmtCMjBY?=
 =?utf-8?B?MWpiUG5YN2g4cVg5T1VKTTNYZkcwYUsvV0dubFVwTjlzK1F4WVdxSkFOYUlS?=
 =?utf-8?B?ZmxUQ1FmT0NQR0FSTm51SGJQNHVsNnlMd1oydFE1U2ZtWmFUN3BOZHZGNzZm?=
 =?utf-8?B?NU1UOFUxYk5YNmNCUUxMZERPb0JyTTBUNkN4M1pSK3FucWxKN2Z5WVFXWVJk?=
 =?utf-8?B?U0Zta3p4YlVkNS9MZEJyaE15cTRTVXpFcEQ3Y0NyVHNPSUwvWGhWSDJzakVy?=
 =?utf-8?B?cHZESjhaUFlPNUVqZDF5UThHMzBseEttTVBWblBPM2xkV3lFaXB1VHN5bUxZ?=
 =?utf-8?B?akh3L1B4V0QvNGE2bTNJdFBWd2lNem43SVQ4MW45NE9Jd25GbTA3K1NNcEtw?=
 =?utf-8?B?ZzlDZTk5dGdUNGowL1VzVm1HKzNlb0gvYndiTGRVelRhSnluejdydzh4U1h5?=
 =?utf-8?B?ZktRdUUxN3VKYVl0dXE2eHcvaXpDUTdZckVRdVBFRXp5U0d5NVRFbnBzcmNo?=
 =?utf-8?B?YkZoN3ZaNE5GaXEwRlNyeE9TbHVPNit0THlSc2dUNmNaZUczbSt5eThkRE5P?=
 =?utf-8?B?bW9NZmVWYTRHZk9nR245SlNGZHh4b1dCYlNhelprV2ZGQkQ5TU1hKzZKK2VT?=
 =?utf-8?B?NWlEbXRHMk52TzFYN1lGTkkwdStXbTFZazFGZXd1bngyQ3ZnamVUelU0QTVL?=
 =?utf-8?B?U1AySEk0UllrL2h1QkxuYTJHSC9oSzZCY2R5VWVNM0pYYms2Y3ZJTnpFUEt5?=
 =?utf-8?B?RXZsZDR1bzN1MTEydFFkaWtBWis5MW1ZdjJ5dUx5TVBQd3Z1Q0lkdDdMcTNk?=
 =?utf-8?B?Ym1MN3dvQkRsSDVlZEFPbm80YXJpekhGV1IvT3hZdGpCVGIyOEovYVlMZW9Y?=
 =?utf-8?B?MFN6WGJzUFA1TEx0b0JjdzVvOUxySjlTWDVhYXlNNG8weEIreWNIMDZuSEcv?=
 =?utf-8?B?ckwydllLbmpDNFgrZXRnS1ptMGhUVXpHRThJZWU2SCtCZlZqM01vZDZCU2Er?=
 =?utf-8?B?RGJGU1gyd21YRUhoeHZUNSt3K0diQkZwNTU2V1dleXRidmZzTkNhTUFjaE9K?=
 =?utf-8?B?eUlGMksvQ010NnRXaE5QV1JBWEt4aXFKVW5MQVJVbXF4REF6SVpOL0JmbTlB?=
 =?utf-8?B?OHJjTE55NTFLSTRCVGZKTUZrZzVhS2FKOW5qK01Vc1dsRlJjTkpUZ3lLY2JK?=
 =?utf-8?B?YWsxSFR2eGRqSHFlbDEzTDIzWGs0bk5HTGpZeUphdGZUSHdVRVFid1crSW1K?=
 =?utf-8?B?K29janZLNFVJQkRiV3NSa1FqZDNHLzl1RTdqQlRMMFlsS2NwcngwNVVuaTh0?=
 =?utf-8?B?elBFVlhTNVY1VmhGd0dDMkRhMTJ1MDZSVzJTanVvVjBGcWNoWE9kajFQOFJY?=
 =?utf-8?B?ZGpZMks3aG0zVjVrVkNCSWtTUldmblNWVStHU2o5MVhXL25QOGdPajNZYjRn?=
 =?utf-8?B?ay9wSDVPUjRUbkQxZXBMVUp1eWNCY1A4dWJyL0ZzeUNZaUxQOHdKbW9yazRl?=
 =?utf-8?B?Q1VLaFMzZXVHd3VQNFV5eldsYjdSL1BMWlIyZ0NXaytQQURaY3U2TGd6UGhK?=
 =?utf-8?B?TWVGZ1BzbTBmcHdHYm4zR2RKcGp0eWMwOThkM3dvUkVObzhqUG92Q2VCMm5U?=
 =?utf-8?B?VlkzdiszR0tXbFFLRllvVGpTWmx3TmQ0a2JDY1V2NWpyYnFYWnBaOU1FenhR?=
 =?utf-8?B?N0p0bllkU09uSEYxUTVmV1g3RG4zdnZEaWVrV0hhVlgyZDU2bmNlbWxqbVQ5?=
 =?utf-8?B?K2NVQWtReFdKOThhVnRQaGVQdDNNYXlwYXZ3cGZlaHRFS0ZBOHh3SWVVOXlt?=
 =?utf-8?B?OWZLVFRrRmpINkZSSmcwNjRkSU5xSkpPM3JqLzBaYXZkSlhWK09ibjBlUzJX?=
 =?utf-8?B?R2JtcURJMnBJZkt2WXFUTTl0eDRweEJVbUxvSERIWUR2eXFya2NPbmlBbFps?=
 =?utf-8?Q?lk4xtTcAtSKkcWTviumTFmHNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d4752-2644-43d9-8ce8-08da8095f4a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 21:17:57.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Anogzk1NSG4ROxJw4Re9+1YGxW0k/FIPPz5r0Q0Er/29GkHsl68TCi2ZQBpk8moTROW9Ulnqt5KYfDW4AQEIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 11:08, Borislav Petkov wrote:
> On Mon, Aug 15, 2022 at 10:57:42AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index c05f0124c410..40268ce97aad 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -66,6 +66,17 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>>    */
>>   static struct ghcb *boot_ghcb __section(".data");
>>   
>> +/*
>> + * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
>> + * been created and registered and thus can be used instead of using the MSR
>> + * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
>> + * which only works with a per-CPU GHCB.
>> + *
>> + * For APs, the per-CPU GHCB is created before they are started and registered
>> + * upon startup, so this flag can be used globally for the BSP and APs.
>> + */
> 
> Ok, better, thanks!
> 
>> +static bool ghcb_percpu_ready __section(".data");
> 
> However, it reads really weird if you have "percpu" in the name of a
> variable which is not per CPU...
> 
> Let's just call it "ghcbs_initialized" and be done with it.
> 
> And I still hate the whole thing ofc.
> 
> Do this ontop (and I knew we had a flags thing already):
> 
> (And yes, __read_mostly is in the .data section too).

Cool, will do.

Thanks,
Tom

> 
> ---
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 40268ce97aad..5b3afbf26349 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -66,17 +66,6 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>    */
>   static struct ghcb *boot_ghcb __section(".data");
>   
> -/*
> - * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
> - * been created and registered and thus can be used instead of using the MSR
> - * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
> - * which only works with a per-CPU GHCB.
> - *
> - * For APs, the per-CPU GHCB is created before they are started and registered
> - * upon startup, so this flag can be used globally for the BSP and APs.
> - */
> -static bool ghcb_percpu_ready __section(".data");
> -
>   /* Bitmap of SEV features supported by the hypervisor */
>   static u64 sev_hv_features __ro_after_init;
>   
> @@ -128,7 +117,18 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>   
>   struct sev_config {
>   	__u64 debug		: 1,
> -	      __reserved	: 63;
> +
> +	      /*
> +	       * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
> +	       * been created and registered and thus can be used instead of using the MSR
> +	       * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
> +	       * which only works with a per-CPU GHCB.
> +	       *
> +	       * For APs, the per-CPU GHCB is created before they are started and registered
> +	       * upon startup, so this flag can be used globally for the BSP and APs.
> +	       */
> +	      ghcbs_initialized : 1,
> +	      __reserved	: 62;
>   };
>   
>   static struct sev_config sev_cfg __read_mostly;
> @@ -762,7 +762,7 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
>   	unsigned long flags;
>   	struct ghcb *ghcb;
>   
> -	WARN_ON_ONCE(!ghcb_percpu_ready);
> +	WARN_ON_ONCE(!sev_cfg.ghcbs_initialized);
>   
>   	/*
>   	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
> @@ -887,7 +887,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>   	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
>   	 * since vmgexit_psc() uses the per-CPU GHCB.
>   	 */
> -	if (!ghcb_percpu_ready)
> +	if (!sev_cfg.ghcbs_initialized)
>   		return early_set_pages_state(__pa(vaddr), npages, op);
>   
>   	vaddr = vaddr & PAGE_MASK;
> @@ -1268,7 +1268,7 @@ void setup_ghcb(void)
>   		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   			snp_register_per_cpu_ghcb();
>   
> -		ghcb_percpu_ready = true;
> +		sev_cfg.ghcbs_initialized = true;
>   
>   		return;
>   	}
> 
