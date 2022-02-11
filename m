Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACB4B287E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiBKO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:56:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351135AbiBKO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:56:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED41DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcg4fSuXYMSPYcE4nqJi+vodXDbE9CDrgDfEodB7n3189X4Sek8IB9bpxx5hMBLSptrvVLQrMfzInKpNi8Ngj+ISBr/8YV/iMLDWWl4xN5oLK+vOpX7TdtAaKA31LtrLJgy5eaAM9N9hPR3nCQT+MgiEXojkw4QFEYsQZflOKu61LgEafsB0UF3dgv80Cnl+OZhdt3INHKBcCKAf17WR9mQTmeOGPbKleBdOT320zmCiNTcr4EjLuhJqaVuPg9ptMj9FXhK10JIx/agH2CYxNBmSvzCH3wYz7ZJRY9MpqLMbjBSXMYngQ+o0GcApv7s91Q/WLawZZlhfLsiHRuY3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39/dtFS1KJB1wc32SHEYD5VDlZuABcJrrmOv4h93bec=;
 b=D/PvZZgYESokc8wPl3gohiAIDuyEvV3WOaHL1xcL+4OFZpOvRejzEIU2BNz0jUFnTzQSvpt5AkAHwI9luO5dtzzu3hCdu5H5Vd26szKsitYDSNaap5ty0ojwLooa/qMc/1De5xJcKU+KBrv3cR3F9KxFgZOva6HR6BQUq8xfMu47GkVwotnapKWggJzqkPnClPaNypdCrd5JtQBwz3AB31aorJMv5OSs9Gb2lF4wPOzYIzpb58xXHu0qtjtKqQwBQomxbgj+IvlA7ff41OSqA6VrB6WnjneJ9NMV6bfmkmLC/c5Zh9gb5nj8xmttBgTfc+y+EZBq6qRmf7GJhj3/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39/dtFS1KJB1wc32SHEYD5VDlZuABcJrrmOv4h93bec=;
 b=zhH8xnhLh17/ZrVGpt01mUcRs4aw7taUFLJNEkU/TtdwhRzFe9fCwy1deZ+acjMuQqf79Y4rbQIzCbqSuztnhSnw0KghiqoRhzhi8cVhE0chCofwyo9qX4zJSoIIj8eQ1eq2tD2o02kyfVdGLy3f5GPM3ah9ac5R4y547q0qtUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 14:55:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 14:55:56 +0000
Message-ID: <568d9945-ed0c-90a7-d9cf-a5662f1dbce2@amd.com>
Date:   Fri, 11 Feb 2022 08:55:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
References: <20220211053652.64655-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 1/2] x86: Use CPUID 0x8000001f to confirm SME availability
In-Reply-To: <20220211053652.64655-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:805:de::42) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f5cd31-aa97-4fff-f18d-08d9ed6e9bb7
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54392E05090F2F3A8871FC5FEC309@SJ0PR12MB5439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 945T7c0HhfzfJh6O3UKQYgfjLALn9wDn3upxGaScCeQtk2ORiymzH0GlsyO5Tqn0nx1jxuX0rO3geAIq6kxCQf9xeHqfcJ17R5UCI2ZJvMp+/cocbOmo56IgaHipkoBZRhzGxmV7p6g4wjQC4P4vGL5NJrA1TeXKCJgLmfYvN5dhDrGCNu5+m2M7/YW4Qbgb15hOnuMAvqxbLNwzTqa56vMPe2nB3JXxnNcJXF0/xiBSpfpoDkXHmASqeXzHCvhiaU6ozyjWxW3cMeAeO+7qIvwyfpyiM/I03Eq4eRMRapoOdm9IL600YvMX4LZLlpvYueoj/oe0Dge5bYGMgg0neVrnbLouykt4DFt5iyExvzPLcwK2seZRHBO6soUV3L/1i4cdZOfK4/GXIvXMAXRcwzF1ALPkxGyneoT1vG0shjejQO5YqbWT4cjsERXdsKoLf236bN69vQFp7Ur3mp9hQ0D/oCixdi4BEQ24RdgN9vRuxXRMpZptwo7GXch7S5inVC0JF+5tuoObWvFIXdScAbITDqRbanlhtvu+XxzNfL6vFB9zjvp8fRKGRhdorK9e9xeK/QUfkSVlwWO2WSxZV4SZTwBwVEDn9qkEVKHxpwqSPHpQUj3vNfZfxbQ0VSrFFkV5SAVhZp8jNOr9M8/Q7RjsMMxIkLQ3V2ZWSiTSvuoaQXeH3D6/9aFtCja926ZVqa5QEMzOm0Fuxm+6XA3tsH4zl1UNZF+kxOSNvT7Qmlo5pz6ZfVGPMZ7hpoMiM/xf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(6486002)(2616005)(31686004)(508600001)(36756003)(83380400001)(110136005)(53546011)(66476007)(66556008)(54906003)(8936002)(8676002)(86362001)(6512007)(316002)(26005)(31696002)(66946007)(5660300002)(4326008)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERKcUp0YlRQNWpld25MTDV3RG50dmg1Skg5SGNacXNhNzNsRk5qOERPZXRO?=
 =?utf-8?B?ZzVQUURGcFRweWRjMGtaUnc0T1htZmQwYng3MWhHMWVjOUZCK3JaRkM0Nk9D?=
 =?utf-8?B?V3NnTDNGYkRsOXEycW5wSVFadHpCZGZCT3lnQUNiLyt6RkYvMjJCd0FXNTZ5?=
 =?utf-8?B?TXgyUy9WdXRNWitsOHJWYkh4R0VZSzhCaUJuNkMwNDZXU2RhellRV2pJakls?=
 =?utf-8?B?bmUzNkI4OFlhS3FGQXVZekJGTVJCRmVReS9EaUVxQWVwV0l1aWVwamlmUk4v?=
 =?utf-8?B?SVMrSGxiWlI3bnNpSFl2QzgvdzhqWkVVWTRaTkhKMkU0UTR3S2RSeUtMU254?=
 =?utf-8?B?WVMrNjhBSmtpRVdoanVMeC9BU1ozQVNpMFpoQXRXWEo3RVBpOWlwRTV1eVdy?=
 =?utf-8?B?bWVFbXhwRkVlWVVWNEV0dlVVeHVFNGxqNmJ2NVNkVnh3VVNsbU9TL2xuWGha?=
 =?utf-8?B?dG1mVEltVW43S2hVSXFRbVRQc0pnWGliTGN0QmQwUXhtbHo4RVFjTXlXTXpn?=
 =?utf-8?B?UHl4WVluZU4wQmJMQURSNUowZC81djd4VjBaK3JwWHpXZFBORUpOYTIyRk9w?=
 =?utf-8?B?YS8xcjlLb3h1d1JQRDhyQ0k2ZDFEUWJTS09FUmo4QVJhSFhLM0pOb2xZclI1?=
 =?utf-8?B?WkxVUE40cEdEbktSb2ZLTldtRVRtSU9qVUd4ZzR4Rks0RDhQcHliU3dvU3V5?=
 =?utf-8?B?T3EzYlcxMi8zWGQ5ZWlBZ3pLQUVIcUMwemRDcUFVN0hvcmpNWkVaMlpWVTlK?=
 =?utf-8?B?Q01DWnpIQlBDbDFyRGx0aFZYYVZmempZM09Sd0hUYW5VZ2dzVlByZTE0c1lN?=
 =?utf-8?B?NmhtRmE4WkdscjZKZ0EwNUVkeDNQRFV6RkZkQ3Y0ZzdPemtGSEVRWWMwUXJh?=
 =?utf-8?B?VUVWQUFGMUtpU3Y5QUY0RkZJd2gvUzAwV0gxRDlDWEh2UXZ6aDhPYVdZWEZB?=
 =?utf-8?B?VHZqV2J6blFxUmdDWVljQXlXdHJyL0pDalQ3dVM2WkRTVzArWENOYnpxMFU0?=
 =?utf-8?B?ekhRRnlnYjhxOWx0aGVjUUU0Yjd5OGxBUTI3TnBLKyt2VEFVZksyTmQ1bzBl?=
 =?utf-8?B?cWpTSXJoSGV6MmVNSUdlWldCTytlQmxqRkg2aW5EMmtOWHNQc3dJd1FDZ09J?=
 =?utf-8?B?bG42WkpsTkh3WVhjSGQvY0I1U2Vsd2NkaUdhUWlUVG5EaDhuckgzZlA5QkJu?=
 =?utf-8?B?dEJJdlo2NnVEUDRLY1RLZkQvc01GdS8yZEljRWJvSkJ1Vjg1d3FUQTFwcUps?=
 =?utf-8?B?OE5xVE1TK0J3Z2JwYlc5RVVtVlA1Yk5zWGtKZDhwVGdqcVlUajdkaHE5UGs0?=
 =?utf-8?B?NGxEbWUxSk85aEFVM0JuaWJGWllMUnNHeHdCQ1FtTG9lODNKSzZGWHFtcHJF?=
 =?utf-8?B?WXl1Vnd4eDJWZldFNnV5ZmNLQVllU3Rnb0p6SVh4WmREeWNyTFFWTkF1Rk1O?=
 =?utf-8?B?RFR5SlpQYndpTWk5dGFJVlBRa1VLbnhUQUlsT0xQalpzTVpQNGQvWVRDMlE5?=
 =?utf-8?B?Nkx6RjgrVVFPS1E2eFZuam55T0RoNjNSUE1JdEZ4ZmNoczV6Q0ZrOTVzLzJD?=
 =?utf-8?B?cmoyelFDSzhFT1VSUm1DT3N3RlU5amhGaWpxbU1iNkIrOXNjcVdmN3dvaElH?=
 =?utf-8?B?NmMwb0c1RnA2TlNqckNKREJQSEZDM2dRTGMwL0ROVFlMbjBpTTF1RGlqcG9R?=
 =?utf-8?B?ZFZ0VGN3VVJhRGtyZDdWcGRoSkhGTzY1MWxsSVl2akFaWCtRTTB6ZmRMaUgv?=
 =?utf-8?B?cDBTNWtFaXBlejBnSmlZK29uVmpIUFUvVHNBWVRGSjFzc2J5TGlNay9BSGxZ?=
 =?utf-8?B?VThidVZXYlVJR3Y1Q3gwajc0SzlSZWJiWTRXVWRLVDljcDl6R1c3SFdCRndE?=
 =?utf-8?B?SHRCTXRIb3VkbHBPMTR6WTVCeDhRbHBQZVJSQml1ZjVETVBGdEw2VXJEWGlU?=
 =?utf-8?B?VnBleDJFa2ZsZ2pUZ0MrUzhITTNpVjNlaUNzdldrMUlJU2tSWlZBdXkwMEFR?=
 =?utf-8?B?VVhWKzhDTFJoZ2ZzTnFFcnhPU2FyQWRjQkRMRDJJK2tPY05lNDk0THI0c3Qw?=
 =?utf-8?B?bHJBdXlFYTRXcmFzRmpKWStWa0R6YS9EQng2RDdQQW11dE9uMEgrVGlNbkMy?=
 =?utf-8?B?TFZMQ08vSUtWZjdnLzNGTzRjeG1aanpiQUUvK0NtM1cwSVBSTHhOakM4c0l5?=
 =?utf-8?Q?Ktc58kwMB08jOUbl+Bu0wYo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f5cd31-aa97-4fff-f18d-08d9ed6e9bb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:55:56.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20HGI9B9jn1vCH42vfHzV0Fc9l5dNuEFMf2tBI5mQO/8OiVp9Ze1FrG03wgZrVk88kL8IOfN703Ht+fWOGd7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 23:36, Mario Limonciello wrote:
> An upcoming change will disable the X86 SME feature flag when the
> kernel hasn't activated SME.  Avoid relying upon that when determining
> whether to call `native_wbinvd` by directly calling the CPUID that
> indicates it.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/kernel/process.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
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

Please test this by running kexec and alternating between mem_encrypt=on 
boots of the kexec kernel and mem_encrypt=off boots of the kexec kernel to 
ensure there is no memory corruption in the newly booted kernel. This 
testing needs to be done on hardware that doesn't have the 
X86_FEATURE_SME_COHERENT feature.

Or if you post the generated instructions in this area I should be able to 
determine if the change is safe.

Thanks,
Tom

>   		native_wbinvd();
>   	for (;;) {
>   		/*
