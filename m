Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3262A589221
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiHCSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiHCSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:18:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8E10B6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuwLwdMj9s3kfrbWs4YFhkulX9o7pfpRDFmJRpMQkR79Z/eBATnvhMPLomQC6j4Zuxrc8EbFgA55ccqVydQXnzIfKCH/N6Blcjr9Jh0y6NsJVHqFkC+HxyQovomRwRXNPrsB3g5wAPl5dvRdFoAuM86jLJY0xym7lvKKfHHUV1DltKDwd184x9NLh/bvSIXLLEY0fvLM4k3rtK0fQND3WoLCr29ra0ND1uLTrk5CgBjFN6+MCWMHr8uz4TXU1m+4P5J7+uezKJn5xtn2AO5zgMvf05OY3QV5HcDFhsW3YCW0qE2LCg0LTV8QuT9LgFgm5BIGymFUTr/KCiyZBzCIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVgcaVbY5gD+xYJkeyANjGt4rwGJQ+tYRX2EmlW50Ow=;
 b=UQ3XOYQC0NAX0jxQHnFGqP1DYWeWYIF6qsMw+d0I93ylNBQ7hRzMAgK0tfb2LX/1nPqPp3RFsy7B5wl7iBLLu4JSnhasFcTYovhiLUMkszMPqUhoHjyXFs0NKh4494l28xVsXXW+X8Qbkyim7O6Z7bEwY8m7f3cvJxJMxxKUxUeBi7/JS1N+VYVfCLbkpxXZIszN3yS5W6gcJlHTEe09dZcGdsQlQAmcArZcN/Jinbio3QinJqOD8lKJzfwfPwUe69UBWPxZes+1tOd3HK3oSKrGtMOOG8kj7O1orjfA080l4c/ciyllnVtz5FyqlPUQyYYqTzyQOdpvp7UFsc85xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVgcaVbY5gD+xYJkeyANjGt4rwGJQ+tYRX2EmlW50Ow=;
 b=u6SibimYFq/NmCph/EwL/Pk3XXBYGZ4bEot8lfvsUZVwSKLfO8uly1BmOf5KTB+Up2gKzZeB90mKNDuxQOrkkiUtXab06o4rw2deZkQqQdRj0QnlCnZyf1Wg5wo+boUjj81O/NdwjccMHs7MrroBFudcQlWJiA9PcEXlWGK+tMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Wed, 3 Aug
 2022 18:18:25 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 18:18:25 +0000
Message-ID: <1da55a62-fea4-c6f8-079b-bc38515520e1@amd.com>
Date:   Wed, 3 Aug 2022 13:18:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
In-Reply-To: <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:610:50::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0acc9aec-06d7-4b4c-6910-08da757c8e28
X-MS-TrafficTypeDiagnostic: DM5PR12MB2392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhvpQDwGEMp3r2MwqoOMzDnzYAkWA15Tv70N73/6WMhoQubyiedtm2R8sWSqJkFcsNBolIAITVzBFIhoXJdR8sSmXhHGGi18Th3DTN0JAkqZJoxkmSqZI76GAhobgWIugbs5Du9XwHCks1JASNpwtq7ekvfXBhNIVepkinJHUSqrPYAFK57zHSX7+pOLO6DN8cB7heFVG21Ghb7Uir+15aIC/D7HO+wwqyEif4+g+YrGFSdXN5YpPiBQ9N+IqyiQEvOtLH6CM/pI54F68B8gFKpfZ74DYgr61gTBy2f+vimTqtiHTDz6KAdFhtdUIxMK15RiZdBa9REYAuOphFFrwm3ZcxzL/FxpASF5d4V7h1Ng9x4nctrnJG59KjsFwZg0UBv/+bwp+o1Xg+3l+1nzfI5ncSeO2lgxx2ok5Qc8PtAP3US1rJuvA7Ok5PqhSHakjEKkB9+dPjOoTDnX+gU4VoaguwdceTx+Li/ivLOk0XjYqL2St7ondI+ufOZ9fI9JMl6aOb3j9vLvhIz1SbJTLGxnObBhLQ+HxihCnIXUFizr4oxK+gxUTeJ2fJArzXyPvYfHkZGdwlbysejsEZhNwHjrjAxm/IGwDoHfilnDMpgeF0lXmwvFNzvy/1ct6InwPSEUMHvAK0iK04TgzKhsUQfn0d+3g3DzI4ox2XHkyrHdHILO1d45imUounzjcAdL27J1JyzlTNjjAxhI56Le7mnIn2nqq3Ln3Dru8imrcB5bzvxxVesLHVdbLTq4ex+uwhsem6TWbMZZLzsSNFnfppPGrgkK+3V27k0cU5sMgw9O6tZMmHWgodovnuAchtBEcOSkYx+l9c5vP/vdW9smyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(41300700001)(36756003)(5660300002)(31686004)(2906002)(54906003)(7416002)(6666004)(83380400001)(478600001)(53546011)(6486002)(2616005)(6506007)(38100700002)(8936002)(4326008)(186003)(316002)(66476007)(8676002)(66556008)(66946007)(6512007)(31696002)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldjUnJvY0NXYjBUcFJ0T3NHQ3BRTy91bW1JRExmMjlwcXlRUkxiZjU3YUpE?=
 =?utf-8?B?VnE2MUZXTDMrNkM1MnBScnYwcnFqR1FwY0l3RCtMTW15K09LN25iYjdhUjRT?=
 =?utf-8?B?S2h1TkNucGcvM012YTZJSGV3UWlnZ1FrVmFacGpucExYRXU1c0lEUWM2OGtZ?=
 =?utf-8?B?c0ZhekY0Z3VjL2krWjN2KzdCTTBORk9ZWUlRYkJhWE5qM2RvQXFaOEZxQUo3?=
 =?utf-8?B?QVBUUWk3YWluZHFaK2svRGdlY2xiU1YzQkNhMHQxSm5heE5WYngvZ2dJVG1x?=
 =?utf-8?B?YkZCc0dmQmN5YXpnaWQxWTFOUE9udk82bUR6TWFIdENTVkN5cDRlSkt6c1JO?=
 =?utf-8?B?U0JBUlppM1NVWVdZYTB4STB3ZDdUWllJNkd4a0UzMkpQT252ajZuaDdrdTZL?=
 =?utf-8?B?K2dFZUhiSFYyZVh0T2hkRVdxMWNxa0VxOGZ3WjNhZGpZdjJQNU9yM2xZNVA2?=
 =?utf-8?B?Ymp0TERramVjOTg3WTNsVDdqK2Jtd1loZEF0RlVNaG1YRk5aenIxWkF6TDZQ?=
 =?utf-8?B?K0dBdlBBVDZxemJjaDhZSlBEa0VkRng4R3EyblBzaHlFYjBqSWNjVU9EZ1pp?=
 =?utf-8?B?aHpJSGRUdE1ueWVCQkdXZzh6TW82b3RwR2c1ZlFnNmtCR1phZkpiaFFvUzJC?=
 =?utf-8?B?UkJLMEZyQ2liNUhLbmhlWTJ3SldyVTMwVWZ0TGxiMDRnQ3h5L0FhdU9ub09U?=
 =?utf-8?B?SnNsSUc2eTc2N3craElTNXZRS1VJRWFKUjllVGttTWpXZmY4WUZHeGxJSTY2?=
 =?utf-8?B?ZGFPSlVMQ2xQaVN3YUxzaHQrMmNNemN3Q0w5RnJXMWVzdXRQUUJqTm5zZWJM?=
 =?utf-8?B?eWVUaFBsVUJ4c0xmdDRWZTlRa3hYcEJVeDZrbko4bDU0UlFvL2dwMmE2TEhR?=
 =?utf-8?B?NjJIMit6bWZrUnp2TEYyRXczcys1OWZUVys0Z1A3ay9BR3hnd2V3cEFJWUpF?=
 =?utf-8?B?U1NOcEJqOHhOQUtTQVI3Zi9xS0Z0dFZZanJXZVdaREpHM29QUlBtTG5xZm0x?=
 =?utf-8?B?NlhLM2RVaVZYMy9sL2h3OTB0d2FhNVVLeSt3bVNiWVRGbi9UeWR5aGZEVlhD?=
 =?utf-8?B?bzlQcHM2UVhVME5Gb1ZSS0hVeDhmT0NXVzFuR1lPbHpKcUVTSGpkelo5bVlm?=
 =?utf-8?B?Y2FXbGZZYzl6N1ZTYXRKN1kzMkNuNkVVdVYyZ1lhYUo2WklBWmZ3THpoYlJC?=
 =?utf-8?B?eDhDdjRVK1V4R1pYNFNVb0paQ1BHdEZFQzV0cFBmdlp4NVFlaHZ4TWQ4WUxv?=
 =?utf-8?B?QXVCK24rTVEyY1ZEd01oVE0wYmtlYUVnTWovNDJWVFVYREJuek5wWGxxUXBu?=
 =?utf-8?B?blBLSFV1NllBd2hYK25jWCtQK1A5bGxWYms5OGVGdmhWNmZwTEUxWGlFUGVy?=
 =?utf-8?B?UmZkdzIyT3FvZmFzQ3gwTnM4THNoTDBKUkdRTEk3Vnh2OE9id0FiN3FKUDBI?=
 =?utf-8?B?SWZ4dkdldDJKM1QvSkRydysvU2VkU2d2RGNDOXVYREtVZ0ExYkFUd3h1bGJ4?=
 =?utf-8?B?WGQwZ2hUKytnOEI2Ris4d1lNMEV5M2wydTBiU0dTSGM5VW81ak9aL2hkTHFO?=
 =?utf-8?B?RGwxNlVUTWVMRUtwVHZ3K1VXTU8rM2FqbFFNQ2cyQkg3RUFaUFdWZ3JJNEY2?=
 =?utf-8?B?YVViU0Y3emJ5VUdFTU9QY3R4TWJ1ZVJ2V04yRk9vb2ZvOThTTjhXVWRraWRY?=
 =?utf-8?B?N0NpVkpiTk1ld255eVZ1ajNubjlRdUJSNlBzYmRWenp1WW5lNjdLTUo2Mklj?=
 =?utf-8?B?Ny93VFVvdnRsMktTWkdQMnJYeENaSTQvdTdGM01ZYWtSNnU4aFdqMXUrU3Nl?=
 =?utf-8?B?ZGsrc0dBb2tSNVl0THlxQUJIZXRXRmNwQU1UZW14TmkwT1hwSGlid3pDUjBs?=
 =?utf-8?B?R2N3Y2JFOFU0UzM3ZjMyQ3lzR2pWZElkaFY0aGljRXB5ck1BbFB4WjhZRUtK?=
 =?utf-8?B?Y0dQNWNROFV0VU9qYUd3YmdoS1ZscWI4OUx5MU9tZ05YeVF0OHRBei82VGZH?=
 =?utf-8?B?dEZpV2gzc1NjcnlJZnlrTDFJWlRZazRtTnhCeTNoNS84UzR0UXRJdlNmb2F4?=
 =?utf-8?B?NzVSMnVRWWJnMTlhaWczQnV6SFR6SnEyeUVpUHBZVUc5eTE1UVBlRVo1UjFX?=
 =?utf-8?Q?QnpGbAA/SqyXV5qvaVVItGfzw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acc9aec-06d7-4b4c-6910-08da757c8e28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:18:24.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgE3rkEfQy1m/9Sz6XkZInN4QemRiJ/KfC4l+266HN8YU29K6Q31dV+Fj9xlpTQ8+CZcBIVvqvn+XHhnioNwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 13:11, Tom Lendacky wrote:

Of course, I'll fix the subject if submitting this for real... ugh.

Thanks,
Tom

> In advance of providing support for unaccepted memory, switch from using
> kmalloc() for allocating the Page State Change (PSC) structure to using a
> static structure. This is needed to avoid a possible recursive call into
> set_pages_state() if the kmalloc() call requires (more) memory to be
> accepted, which would result in a hang.
> 
> Page state changes occur whenever DMA memory is allocated or memory needs
> to be shared with the hypervisor (kvmclock, attestation reports, etc.).
> Since most page state changes occur early in boot and are limited in
> number, a single static PSC structure is used and protected by a spin
> lock with interrupts disabled.
> 
> Even with interrupts disabled, an NMI can be raised while performing
> memory acceptance. The NMI could then cause further memory acceptance to
> be performed. To prevent a deadlock, use the MSR protocol if executing in
> an NMI context.
> 
> Since the set_pages_state() path is the only path into vmgexit_psc(),
> rename vmgexit_psc() to __vmgexit_psc() and remove the calls to disable
> interrupts which are now performed by set_pages_state().
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/kernel/sev.c | 55 +++++++++++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c05f0124c410..84d94fd2ec53 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -66,6 +66,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>    */
>   static struct ghcb *boot_ghcb __section(".data");
>   
> +/* Flag to indicate when the first per-CPU GHCB is registered */
> +static bool ghcb_percpu_ready __section(".data");
> +
>   /* Bitmap of SEV features supported by the hypervisor */
>   static u64 sev_hv_features __ro_after_init;
>   
> @@ -122,6 +125,15 @@ struct sev_config {
>   
>   static struct sev_config sev_cfg __read_mostly;
>   
> +/*
> + * Page State Change structure for use when accepting memory or when changing
> + * page state. Use is protected by a spinlock with interrupts disabled, but an
> + * NMI could still be raised, so check if running in an NMI an use the MSR
> + * protocol in these cases.
> + */
> +static struct snp_psc_desc psc_desc;
> +static DEFINE_SPINLOCK(psc_desc_lock);
> +
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>   {
>   	unsigned long sp = regs->sp;
> @@ -660,7 +672,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>   	}
>   }
>   
> -static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
> +static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
>   {
>   	unsigned long paddr_end;
>   	u64 val;
> @@ -742,26 +754,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
>   		WARN(1, "invalid memory op %d\n", op);
>   }
>   
> -static int vmgexit_psc(struct snp_psc_desc *desc)
> +static int __vmgexit_psc(struct snp_psc_desc *desc)
>   {
>   	int cur_entry, end_entry, ret = 0;
>   	struct snp_psc_desc *data;
>   	struct ghcb_state state;
>   	struct es_em_ctxt ctxt;
> -	unsigned long flags;
>   	struct ghcb *ghcb;
>   
> -	/*
> -	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
> -	 * a per-CPU GHCB.
> -	 */
> -	local_irq_save(flags);
> -
>   	ghcb = __sev_get_ghcb(&state);
> -	if (!ghcb) {
> -		ret = 1;
> -		goto out_unlock;
> -	}
> +	if (!ghcb)
> +		return 1;
>   
>   	/* Copy the input desc into GHCB shared buffer */
>   	data = (struct snp_psc_desc *)ghcb->shared_buffer;
> @@ -820,9 +823,6 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
>   out:
>   	__sev_put_ghcb(&state);
>   
> -out_unlock:
> -	local_irq_restore(flags);
> -
>   	return ret;
>   }
>   
> @@ -861,18 +861,25 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>   		i++;
>   	}
>   
> -	if (vmgexit_psc(data))
> +	if (__vmgexit_psc(data))
>   		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>   }
>   
>   static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>   {
>   	unsigned long vaddr_end, next_vaddr;
> -	struct snp_psc_desc *desc;
> +	unsigned long flags;
>   
> -	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> -	if (!desc)
> -		panic("SNP: failed to allocate memory for PSC descriptor\n");
> +	/*
> +	 * Use the MSR protocol when either:
> +	 *   - executing in an NMI to avoid any possibility of a deadlock
> +	 *   - per-CPU GHCBs are not yet registered, since __vmgexit_psc()
> +	 *     uses the per-CPU GHCB.
> +	 */
> +	if (in_nmi() || !ghcb_percpu_ready)
> +		return early_set_pages_state(__pa(vaddr), npages, op);
> +
> +	spin_lock_irqsave(&psc_desc_lock, flags);
>   
>   	vaddr = vaddr & PAGE_MASK;
>   	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> @@ -882,12 +889,12 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>   		next_vaddr = min_t(unsigned long, vaddr_end,
>   				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
>   
> -		__set_pages_state(desc, vaddr, next_vaddr, op);
> +		__set_pages_state(&psc_desc, vaddr, next_vaddr, op);
>   
>   		vaddr = next_vaddr;
>   	}
>   
> -	kfree(desc);
> +	spin_unlock_irqrestore(&psc_desc_lock, flags);
>   }
>   
>   void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
> @@ -1254,6 +1261,8 @@ void setup_ghcb(void)
>   		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   			snp_register_per_cpu_ghcb();
>   
> +		ghcb_percpu_ready = true;
> +
>   		return;
>   	}
>   
