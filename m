Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC854B6F04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiBOOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:42:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiBOOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:41:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE8DF97
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3vpJcvmefnUjRmw1YnYbOlAbdvjFYvtPVNZbc1rGu/8747nP4uEL8jy4M/cfal0J7jPWme97HIz6TaTy64R/I7itTT4347DYe1quWDrlI8Z661FY2SGeRjjHTbWXWRnYwLO+w+N0QQnArxfeYeNSppmF5o4yKCxSp69LhT71p9+pxocF1V72S584qP6Nr3BFky74NfauYgX+BmNuFoGVBK2vfYJ/Fs0QFfUHzwHT4izpvnoivNkyepyQFaAM9ULBI8GhC12m0wbblGrIrJlJP7ugiVsjPH1/c3bQjPNXmrmdEkVDNbt57tImIaWtz2CKUJOuOAjo00u4wDtTpJzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZRVxyDAnm+AtJvR4g+Lc2iNWzKhfP6rPkBkVkSVzDg=;
 b=OwuMU+LLfzNGu1ZoWf/EDmTCyS+oz3srvyG0rPBYcHv85caktW1xItxp4Ia4p/oAvViiiAQXm9uq2yjXwLJSQzjC5/vGMT2N4jfLWUkK082LaXfbDIfPBSS6z5ywHkNiuAV5vK/RUV6PuykddqIHL8MtZFAbY+b32YY7O+a9ZwO1OTDj61tRHtFO3Cpv3N0cib2qNNcMioKhlAcKpYijgwIK5PkcJIdu8kMATWo1G/POfyuW8Nodsm9kxRR6XjwESKRPVwST3TGr2LStNFdrc6KLT8udCOpsJG9/kTpTAP6ZDpW1Uw8Y8zU+f4uHgZ5RdD+DGvd8nwvzducBU5slTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZRVxyDAnm+AtJvR4g+Lc2iNWzKhfP6rPkBkVkSVzDg=;
 b=FOhkkRqIgaTUonkGnsVd9fKnN+qCLKK37It8wJ93dNcgwYA28ft4pWR4jdbPclL9xiAZcUMsaCoG4VRNOUuHqhw/EJE/cgh/Tijs1WsQ096tX24ObVzLzx6EFM7yd27ghGwh24JGAO+U2gZcXqPp4zql1joIiDvsJiZUJbIHr/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 14:41:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:41:46 +0000
Message-ID: <6f0f5ec3-6fd8-159e-a213-1eb060ec4212@amd.com>
Date:   Tue, 15 Feb 2022 08:41:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] x86/cpu: clear SME features when not in use
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220214235801.238260-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220214235801.238260-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:610:e6::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47db617c-7859-4f0a-4bc4-08d9f0914a79
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50743CAC5C054443379B1804EC349@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7FVjwXNDmE3nbvAAfrXqRu4/NCO/4FlnSWpy7JlCxitB7MJjgB4tZxdjcnGW9Pp+q/1/KCWFw+ewMvShsaqSP1n3NoQ7xf7HlOVY6pDdQNs2mrjM//G6lw0BbTTEeqzzSsY0LbXZSrkxRzcIV++7WG8Yb7BciKwmGc9InXzFK+pdPc/FqTrTPKeYh5BKo6cNA9f8DxUZESZMUTwEG8IvHFbBJH+hs/A6siM2wFdsoM9gr6ItutHnKmewc+HvV4qYzfC/xJesnLeavtgZgn8nI6N7UTzlwZsYnTZcYJlUw/gihWrBgig2BX5slWrrdrtccOhQCsy1K2mpEqCdlJ/CupxJbIs7Ee/xy4k2WpiP5xEbYjHMS5dXHqAjfDt43/JOSd6cRbMab0uxpBU9ohmcGYUoXgnKElly0TD2d+2rDG9sCjLPsZyve1Ru53J2SJjWqR8drKL0F00fQohB50psZgom5tGpvLSakIj7J6luq1fkADC4wJJLcx7Zy3oDAQU9vjl1G6Jsw5IDJFE79kEF0gtGwF0Zd0x5JY6vwfXvPz0p4H4amUtRUyfiE1tI2nkvn2sU5/NRgDlchowEeVZQAmQYj6XWhvmt58Q3uZOOzhUMG6juzAVg/10qlyT53gnmrjeOdSQiTuv+m/T0Odx8L47Fr2eFS1tpisAjZ4Qhatovwf9Qt5hTsbZVxIts6bdibVs+BGZUpn227tkoRt8w5OJk9vOc3DlFItNFEZTeF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(36756003)(53546011)(2906002)(6506007)(66946007)(110136005)(38100700002)(5660300002)(8936002)(31686004)(54906003)(4326008)(66476007)(66556008)(6666004)(2616005)(31696002)(508600001)(6486002)(26005)(186003)(83380400001)(8676002)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpnV2U5MnlmbTFlMGw4UUpqSVBxeE9CWFVIRlljWDJzU2hCVjlMSDlERVNw?=
 =?utf-8?B?M2Q4QXJrM3kzNzFZdUs5MjBITVJKMkRUVEVmZkY0Wlh6L1JZNWRrVVBsYTJ4?=
 =?utf-8?B?K2NYZXNvY2N0OEZvS1Jpamw1UVhIbytlVVBpdTdBUVhOUHdGZ0dxMDNPZ0tp?=
 =?utf-8?B?NGJ3NGQycTZuaTVjV0ZRajhrMnNWKzBHaitPUjd3aS9SQS9UWFJiRFFjcHlj?=
 =?utf-8?B?ajNVRTFTWGRHV3ZJbmZDYnc5M0EzMXBEd0tDQXdDTUd0L3pWb1JsaW1wb0t6?=
 =?utf-8?B?SGtnbGtLSnVVblhDZ1M1NHZZRjFpM0pjZnVOc0VWSnFhZ0VwL0FhR3VZdXZw?=
 =?utf-8?B?TVNVVTByN0l4aDM1M3B4MzdCd2laak5XWGRjRVhmeVlyV2hjTGhRcGhjdHA1?=
 =?utf-8?B?TVhrNWEzWEp5Q1ZMYlc2TE5wQkR6ZUYrYjN4djNDOXRaQ3NLaW5UWmJEY2pw?=
 =?utf-8?B?M1daYUFUSUxVbklLbExGa21UV3FXbCszK0Y1ZFBaSjhPdlhlcFdtMjQ5MUlO?=
 =?utf-8?B?cGdteWtMYXo1a3dKZmlSZEhBclAwTWxjQzNFbDlqRTlDVHg3ZmR5R2Nua0F0?=
 =?utf-8?B?U2x5T3QzWm5JdTFmMEFRVWhyaW5ockdoY2hFY2hpYmlTSFIwd1YwSVFJajNi?=
 =?utf-8?B?ek9HMnV3TzVmWERuVUVZMDE1Umc1K3pLTTQ4bCtCUDhsSTExbTByYTlmZ2Nr?=
 =?utf-8?B?bEp0M0EvRVJIR0J6S3pCbXNzeWoyTkNZaUVITE1KL1JQQk9VcnpTTWRPWXdL?=
 =?utf-8?B?WHRsTzluNGJ0S2dvakRGYnJyd010QmszalgvVjluSlBYdmRPRk5xMEFaeTdQ?=
 =?utf-8?B?OVRGZXowNjNhVElEVWZ4ZXZ3SGpXVDR6VkFYWTJZaDUxeVlBZWtaUVB1di9l?=
 =?utf-8?B?SXV3ckZ0bTZobDZSRUxTSW1aYXk2ckhmc250anphbDFkcElnWU53Y2l3MWpQ?=
 =?utf-8?B?WE5WdUQ5RTBvSGJSV3gzakR2WVVRQ1NmbGZnT0hsWEc0NW1RVEo4UFo1UkZY?=
 =?utf-8?B?NVlCNTNON0FvUlNNTzR4QUJuMTVhcVlqRUt2bnk3U0ZRM2dRK1FrZGxxVk9j?=
 =?utf-8?B?ZjJDYzNpTmRKSy9TTGo3SVFaMi9IV0hOTEJxTUJUK0d6K1REeGZ0NlN6RmFV?=
 =?utf-8?B?YjhRY3MxVmExS0ZHY01tMVpXTGJWVzNWY1h0SnhlKzFmbE5RNlZqb0dtUnc2?=
 =?utf-8?B?M1hoSkxiT2FIa0gxTmlYbWpySG9nQys0YUlGU1pvYUY5M29KNWlZeFlTaGlD?=
 =?utf-8?B?SURpQmdUd0gzdHRNZmwrZjdFTGl5czhVS256RFhESVZMR3VYSStDUVppejVL?=
 =?utf-8?B?SVE5SlVCMGVrSXpPSVoyU0VTUThuQVd0dURyMG00cWtEeUNqNXdTRVFhQ014?=
 =?utf-8?B?dzd4citMRWx5bjAxNEZsakJCZ3hieEtwdXkwZndoa2NEUlViTTJOdnhPZHpE?=
 =?utf-8?B?alorY2VMaVZRU2RmQXpHVUN5ZjRtMngwRzU2NjVjSkxyOFh1RWlxanBpZllv?=
 =?utf-8?B?U0lLdEJOZVZja0NxcVFlbVd4SEZHRk1MS2VOZXZIcXZNcTdDNjRZOTFlQXlW?=
 =?utf-8?B?ZkJrdUtJOStCdWlrbk11b2l2dUpqd0k0cUl2VUo3SzlVRklQMVp2bDBTOWNl?=
 =?utf-8?B?MktxMU9iR1ZzZ0RiZDh5S0tnNnRtS2RMUVVpUTN0cUkwTVh0TVZlTTNqODRq?=
 =?utf-8?B?b1JhZ3ArWmR3K0l4QmVCeHRIeFAxemlrOU9va2toODFhWmxUaWcvNGJDMnRO?=
 =?utf-8?B?TnB4SUliYVJuUDQxNVVDZzJkT1hDK3BWai90MFhCNEJMdXZ3QTdZdCtFRWIy?=
 =?utf-8?B?dEZ4TjJKQnZrTWJ6WkZlU0RBZi84ditIVGlGSmFwb3J5OE54eFpQU3pqa1Nk?=
 =?utf-8?B?c3JJR3lmS1YwT3FVbUh6bzU4ZVJHNVE2S1FQZGpzKzZSaVVZRDBEdGM5TDFM?=
 =?utf-8?B?QUE2SjY0c1pVOG1vUnZXdU9sTklQL2tCWjhXQUlKZnljTEx4Ny9RNnVTdkI1?=
 =?utf-8?B?QlU0VHUwZGpISHlVT3NQQ1B5UDBKNG4xdDZaV0dmN0ZmK1huS2dwNUdhRDZE?=
 =?utf-8?B?VHVKU09sc0EzRHN5bzlzS3M4YWdXVHQyMXRtd3BzYXpyWkd0eU1wNW9aUHFm?=
 =?utf-8?B?TmZFT0lVaEFtdkVpRGVCRE8xZlBQaC8yRGlicjhUNFl2enhpMWF4NjQ4Y1pY?=
 =?utf-8?Q?cCoqie/hrsp56BR5JHaJJyM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47db617c-7859-4f0a-4bc4-08d9f0914a79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:41:46.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrrJC9NDZF52xpM7887jWnU+2HbB/wlQt7ZjgJbOgF00mlHdHLFSR3d+zRxj/NAVeS0Sol5RQlf4qMD/zoGmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 17:58, Mario Limonciello wrote:
> Currently the SME CPU feature flag is reflective of whether the CPU
> supports the features but not whether they have been activated by the

s/features/feature/
s/they have/it has/

The plural stuff appears left over from the previous patch that was also 
working on SEV-related features.

> kernel.
> 
> Change this around to clear the features if the kernel is not using
> them so userspace can determine if they are available and in use
> from `/proc/cpuinfo`.
> 
> As the feature flag is now cleared on systems that SME isn't active

s/that SME isn't active/where SME isn't active,/

> use CPUID 0x8000001f to confirm SME availability before calling
> `native_wbinvd`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from v2->v3:
>   * Drop all changes related to SEV, these will be worked out separately.
>   * Only clear SME flag rather than all flags if sme_me_mask is not set
> 
>   arch/x86/kernel/cpu/amd.c | 3 +++
>   arch/x86/kernel/process.c | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 4edb6f0f628c..8421b9d9f552 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -607,6 +607,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>   		if (IS_ENABLED(CONFIG_X86_32))
>   			goto clear_all;
>   
> +		if (!sme_me_mask)
> +			setup_clear_cpu_cap(X86_FEATURE_SME);

The block comment above the "if (cpu_has(c, X86_FEATURE_SME) ..." should 
be updated to match, too.

Thanks,
Tom

> +
>   		rdmsrl(MSR_K7_HWCR, msr);
>   		if (!(msr & MSR_K7_HWCR_SMMLOCK))
>   			goto clear_sev;
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 81d8ef036637..e131d71b3cae 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -765,8 +765,11 @@ void stop_this_cpu(void *dummy)
>   	 * without the encryption bit, they don't race each other when flushed
>   	 * and potentially end up with the wrong entry being committed to
>   	 * memory.
> +	 *
> +	 * Test the CPUID bit directly because the machine might've cleared
> +	 * X86_FEATURE_SME due to cmdline options.
>   	 */
> -	if (boot_cpu_has(X86_FEATURE_SME))
> +	if (cpuid_eax(0x8000001f) & BIT(0))
>   		native_wbinvd();
>   	for (;;) {
>   		/*
