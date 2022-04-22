Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF350BB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449338AbiDVPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449334AbiDVPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:18:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96252B0B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8sC6OOV3rgUZL4xVQEyrKV3lt5DEGuVYvUXmEO1OUEc8nI3uVpj/338ztEELGn1mY/KVMLyZvsheFPf3Apw2Dg01hmS796PoHPeIKZz3ZM3hPzj4Xc70GcDg73gGIsv16Yq1BK8+hMRKuHVs5NMy2Cova9GC4Gr/Ral+bFaSPWOlCEuJzFtxsL5XAGiwnaggcdQBlQ+ttsXn+2xSysiQlHrhFGdNu2l/tOuC54GIb8su1IKACsKTM71VX29rPvSp8nRJUJ0f6nPIB4Nq5+J6cMYIFioCNu9lq1g1kYENvUy/cCW6mxpqCJaUiGyFf8/jlhzQwvaT4xUIRTU301bmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHdUW4zm39quwIDXvV4hcvGX63HxhXyD99+3RSL8Rlk=;
 b=bJl+2A6CYUX7+SDYxK+LswIp81ffXOsX8TUPvhnx3/dW7fn5JWVuj/L65KA0JJiad9m5M0MIGcmOULOjT3GKIxPjOqr3p3WzInVer8N/8qPxM5UG/fQG8lApo2xnSUos7WsStOKa2wduH3OGtY3IYwv7IpcQ5bXYqBkwBhs/nGPQS4lcDAPHXGUKwSOYZSlQS31Z+sWpNSlpzZUy/SQ9if9ZEg+RxQ7hNbtAgP8SXwRqW+2YTkHcXBc/NUEjHDUc0dSRpddt7MhIQ+qxowe6DSYnKS2lxZDH4/ElY2qcA4KtkYUhfntVaU61kz/xTrLHQPe3JwjeKNQtlg6P81NLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHdUW4zm39quwIDXvV4hcvGX63HxhXyD99+3RSL8Rlk=;
 b=oFnb+xNiEX6juiAQNWQijW4U2u4QR+8pOTeDBeEWs2ihglLkb7MpsfQI3J6vmiN/BWtt7W9mPU8tQya9DG0cWVVjwaN3ZMwpKA2kBlP0OMgS3RIIg0bSlSAftSENXnkW2DahEc5d7dJuI0PrwczjmjbofBf1kOI5dyXFhG0T2L8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 15:15:11 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:15:11 +0000
Message-ID: <c3baaf5d-db99-f432-125f-9884b57b40ef@amd.com>
Date:   Fri, 22 Apr 2022 10:15:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20220422135624.114172-1-michael.roth@amd.com>
 <20220422135624.114172-3-michael.roth@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/2] x86/sev: Get the AP jump table address from
 secrets page
In-Reply-To: <20220422135624.114172-3-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:805:66::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be47bb20-9d70-412f-003d-08da2472e4e3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02200626B83FE65A75801E0BECF79@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8UHFnRoqQJwyeC570WIHfgyM2legRTYOMrKoE+6V8kTkqMMhH+S6zOJrZPmBUjCfIRqwqpuw8oC8wepn/jeXrPTmtk7TAZLdDcqkis8axcCwtisDWZsM55wtKJsPmuPFeCPC5Zg1DaJWAJBRo7aRvSouuUUoFjEmN0ikmPSAe9tRHhlgXuWnByzgDKcWyhDkk136ss7G18XgmTWnGDI6syyQ3VZICGQBDaSNSnVTgs+rSFEy4EPrYDbQ3dRAW5jrYcsha80M6CwVutkGqNaUM5YKTdG8J+3gUEGePWqpLgp9CQSvdhK6xxAYGn9Xg0+dNlC48AGFT6dUGNTOXgw0zHnTBjWmlMCEGsAlkp7CzRbg5F7vLUSnTkddTt5uHqze6JG2C19Clw3Kx/whMO51zJTo8mx9NnELPF+oed/LHevgTMXy1NF1b2MjmgCwA2uKIKthLWRlJ40/zet8pZdjsGpD6xqGvjaqSBoC1BFRVo7v1tBtz7uoo+Lo9yxGv+wsWxgnwJmvVrMow1kWQDzUIA0wSwSfYL1mRNNPxL7oeiCdc5X0rYeDSNvfw3JOMu8grOgIAbPniliyfgjkZmnsm/EuuFF8Yv4ziTtpyXtQA025qS2L9DwKIRMhUufa3W+iP7vfrfP6Ubt2J60YGW/B3U5VAgxdDfMRyqUQDXxk7w5ZhTuzzqeIMEpOOnRn0Ggr4wJkrX0eyYqQKWXtamdGj4LrtG2eX94dIvsiFPUfnwdJn8pqgmhW5vUFs2UzOIJ7IyeeQ6owVgYTaAepLTgTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66946007)(316002)(186003)(2616005)(31696002)(86362001)(66476007)(36756003)(6486002)(66556008)(2906002)(5660300002)(54906003)(6506007)(83380400001)(31686004)(4326008)(6666004)(38100700002)(4744005)(26005)(6512007)(53546011)(8676002)(8936002)(7416002)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU84SEhSd3JJWGlQQlpzdisvUHNCZTlrZmkrNXE3cjVEU1p6dm95aGhKNkhJ?=
 =?utf-8?B?S2wydFhLUzFSaFluamFEUm1BWnJzYmMybThZTlRMd21wcmNoQ2NKbWg4WnN3?=
 =?utf-8?B?bUFiVXV0OWNUZUJUcFcyQnFoNWFrY0N3bmR1bHVIbFRSRTJ6cnNhaFVWQTNu?=
 =?utf-8?B?bTZYQUkzWnppYks0c2hhMEFkMWVYeWk2NFNGbWxjdlY5NEZGWXRZV3RxNjRZ?=
 =?utf-8?B?NmlrQTRUV01ibTh1N2VvbkppLzFGTVBWM0w1cVRPK1huQThKVlBISXQxTUl4?=
 =?utf-8?B?eHVjS05Jd09hcWxpYkZSRXRieVRuamZ5OUZVcEF1S3NXL0VLVXlqRTZ6V2wy?=
 =?utf-8?B?MHAxMzFIN1MyQjR2L1hhNzM0NjRPbVcyRHlKaEZPRlcxWHlUOUR3ZFdFWmdp?=
 =?utf-8?B?bm9nbEl5ajRTSXJrNGdieTI1RURDTDhCRjdPN2hnZ2sxdkV2R09jdGgzNDBK?=
 =?utf-8?B?RDRETmRoSHlhWWdqTXFSeVZDdkw4aXZ3WWtNUzhia3lFb3hzUnh3ZUI2OE1u?=
 =?utf-8?B?UkU4OHdFa3ZyVlkreVlnM1ZSUUd5aG1KcWZ2M0J2MGVwOUpqekxscGFSTm9m?=
 =?utf-8?B?NEhvL0N3YUFLOGpsdDZqeFVySG5vNE1zN015VlRaUXBTcmFJVG1lK2QwTzQ4?=
 =?utf-8?B?U2xnNGEvb2RSV0s1MHZLc2M0WHlCQm1zZnAzbEhiYitPOUlmK2wva29VY2FW?=
 =?utf-8?B?UVo3VEZRcXI2TmJFc0dLUEs0M3V3Z0RmZGxkdUkrSk53dXFsRXZML3Q5UUo1?=
 =?utf-8?B?bE0xaXMyOUpYL0ZGb29vUUs4WUhLUTNETW1HRTlqRU1hMjZRTGRpTmdRWXc3?=
 =?utf-8?B?UUYxN2E5TUdvY3NvdWVURlo2d1FmTVNPbjdlc0FpTUc5L2drdHNwTkw1STk4?=
 =?utf-8?B?QTYyZXpaNWZ5WXk4UmJTME1kNVVsUCtjYjJ6Wi9hY0RHcVgxT3habXNPVXFR?=
 =?utf-8?B?SlRrTG1rWG03by9zSlUrRG1KSys2SURlVUpWYjB2bldPOUtWNDMzOXdaa3Q2?=
 =?utf-8?B?ZHkzcjNwSlA0RlB2NDlqV3ljSlY3ZmgySDFPUWZBb0dUeDRJditCL014TDFn?=
 =?utf-8?B?eGZweFJJL2dzZVBUeFF0T0hjRTJqMXp4by9meXpRK3B3Z2F3bXhqWk1jdXVJ?=
 =?utf-8?B?WVppVnR3eGNnUy9BMTI5Q21BRHNxZGhUakM0dVdhUXUraHloK3VQbzg1cHRC?=
 =?utf-8?B?MzdIWGFRb3VQWktHSXhyS24zL0hwVmFYS2dzSWV1SW9hcEdGWUJ1TU56eXBG?=
 =?utf-8?B?d3dZQll1RkdmaDJPbEptUlBxRWNGMStrTUg2eWI4blJWcXNtMHVyR1pjY0tG?=
 =?utf-8?B?U1V0S05LR1NOcFlvNk5BejhsbUtudDdmZHliaEgvWFFFQ3VkMlFocXdKQUsz?=
 =?utf-8?B?N0R3Umx6aXpFQ2RsWGdwTHlESTNheWp5TjBaUzhGc2FQZjlURWdXRDJ3VGFQ?=
 =?utf-8?B?NXlCQVRJdjc2Q2JUd3g3Q3FneXN2SkNtOXlOWFZUc2lnZnJXczI0WkdnSTRD?=
 =?utf-8?B?YjlWaWxyMEhVYm5VNHFQaWExSGhNYnI4eHY2TSttbng1Z3UyRUtkSUF1czZS?=
 =?utf-8?B?bDhESFpWSjVzNTdCcTFGb01zWGdadE1TMnBtWWNDTml0bk4reWxqdkpGV3Ax?=
 =?utf-8?B?bk1aMFduNkh0TlBvQlhKMlMwRUFyZHZjdXdOSjNoeGx2NG9melJWZERaVE9i?=
 =?utf-8?B?cFBzVXN3WEdDcEdscng5cHdMNFFkbjI1UGNpK1NlTzhVM2RNSklFSENyVTd6?=
 =?utf-8?B?anR0R1U2dHczNkdGazF3SU1tNnN2SXRPR0NkMkc3MmNuL1Y2Tm0vTHZLemFv?=
 =?utf-8?B?anFzTXRtalE2bDNhUnRsRUhaU1lhcENLS0RhVGlyOTRMa3N1L1dDWnk2bVI3?=
 =?utf-8?B?M3RPOEIvSHdkNnkvS3VjMHBDRFBoNmtuMktrZzdQT0M3MnR4ai9USWh0cVp3?=
 =?utf-8?B?Q2IyeG45c29wZ205YnpqS2hqOWhvZnR2a2RodGI0akpiTmZUd1Q1V0ZmOEZO?=
 =?utf-8?B?d0FaQlNZczhreUxyUHg4RW1EODBGdDBTYng1RGtEenNvdmlqUzlvRkJIOTZT?=
 =?utf-8?B?VnVHR2grcURRTzFhUkVTOEJXNWErR0llR0ZUV09nYVdtTUNkVWJ5WS9MQld0?=
 =?utf-8?B?YTJwb0Q0SVA3bmZDNkVaWnBoQkM0bFVWQmtuSWJlS0V3TUZOcmkxQzdYYlFt?=
 =?utf-8?B?S2NITUYzRzcvKyt1RmU0M0VxdTgxbHFSTGNXbzFqaWJ1cTRBenFqdnlZQ2Zp?=
 =?utf-8?B?VHo4eTl3cDF1T0J2WEFBV2NtWmxaNVVMS1FpdlkzQ0krS3FUcVlBZGFwK1dH?=
 =?utf-8?B?eThKRUFnTENPMkROcmt0a3p4UW1vT2UrYmErL0pkMnlVTHpLQmQ0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be47bb20-9d70-412f-003d-08da2472e4e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:15:11.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ktq+Gvim+/hTG5bfxdhFGimwx37KS/BLxim1D772NCTmkGtCTZMZZlKmwwfcF7dD+tE+AEYxIS/6UdidgSAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 08:56, Michael Roth wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> The GHCB specification section 2.7 states that when SEV-SNP is enabled,
> a hypervisor must provide the AP jump table physical address through

I missed this on the first version. It's not the hypervisor, but the guest 
BIOS that directly provides the AP jump table physical address, in our 
case OVMF sets the address in the SNP secrets page. This allows 
communication between UEFI/BIOS and OS without hypervisor involvement.

> the SNP secrets pages.
> 
> Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> [ mroth: improve error handling when ioremap()/memremap() return NULL ]
> [ mroth: don't mix function calls with declarations ]
> [ mroth: add missing __init ]
> Signed-off-by: Michael Roth <michael.roth@amd.com>

With the commit message change:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
