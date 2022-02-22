Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67264C042E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiBVV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBVV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:56:51 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26551A2514
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Jf7rfMRfhgvbQv5MHtPENw7fUDexBlcdXShTmFnsxJBLLoNG+ZHp8unj+YezFXmO49LkVxF02KR2JexRsdSQJaKA7tpNyvoTNDCjhL+mHGgVtmxJRldBWQn6OtNPqs/awXR2ip+490ix321VRufWbji+LviUsDbSBTwbwpz4Cq9O/9U5fYxVW+OfVv85Oowa76qyrZoZOyUJ8AaUj+JL0VEsCg7fSkl2iNGyESrj4+gfdb87PlmZLtzzYXq8biSl5ipEL32gwm+CTyqmbcHvZqUBjeDzweT4Sqi9bjGkHr8rnBbcDu68F2cbyzb90EdbujzNu64v9dy+hMumRXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7BUx+VvEtLA3hZ3ceaMDav9+6FtRYIULfyh8wafpSo=;
 b=FMNUWnzGUs4HsJdSY4xvT2Wf/z7kuChTbykoTB9PgwnLcRb8w9NQeaFbEfPoJPlbKknXlsfff8O9bEPBlxaDSyEFUolAhv8yO2cMMFNNjWPWDnM1yCJClNMZ4fccgoKqRBGP7nBGvCMV6Emtw0nUuk02QnJyQhxYYXVD0Ip7ZmJr28h9lhU/HC4WndBpjEh6cR05CLFy4vbtJ0z8C2+kEZ6H3xbvkfw27S5/mZx1pWelm/GDfvureo0wv8reCf3MRNN0PYPCChjruqYTLmCIS9P2k9dFfeope98W67rSLUYgXieXafBpLBNqm8ex62pba3uyxQGAxgtd/rsqWgcCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7BUx+VvEtLA3hZ3ceaMDav9+6FtRYIULfyh8wafpSo=;
 b=n9kIOwd3zb5y9EGYmi/zwFe8q+ofa66oRq2GeV1YaNzHLVTEQNQFwyZnzMdjz0tFZjrhA2FfxgD7Xsr6sm1Cz/mza7h2GmdKCwfRlV4SyKVidkcoNGZnsiyY4cLpFDvVfrjlF9PYrMiwxvV6yVgIGaFIn2buoCzfiWxZu/4iTTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 21:56:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 21:56:20 +0000
Message-ID: <f7d67a3d-072e-b21b-4656-83da84bd1489@amd.com>
Date:   Tue, 22 Feb 2022 15:56:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] x86: Cleanup and extend computing computing API
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        brijesh.singh@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:610:b2::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eee9440-dcff-4564-0899-08d9f64e28d7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638B03737FDBABA52B3FE25EC3B9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4JIBP39UK5ryE2n5+x8CPYvkQems59+Tkw88ALd5lT8d88X0kuaARF0wD0XQ05TXh6I3nj0P2zZ8ggCBIk14+OgoVQvtmAPRfzfj0w/KPVmvnAfkcUiSf9DRz2uVZcYFJ09CtV57nba3FPe6jkt544CQJpg+G4/+EmSSx+4d/OsXSDhJYwsl8fW6V6JIGLq1QQ27LuQHQ7zDOQBrzXt+PIx4uSIPUDJcdW2pmiuZuZLfqqpclMyi/d0VP0zlzZSwSEsbm/TOsUYH4UlcVUSl+UOswaHhsYwAbCdlsmNkOhUMA4ZTmZXuBzJ+Ezi5UQdumNjEw9DquCfKqMboapkgqYsqu4bfpO6D0fFqTIny7cDJTjVV4Z/x/dYfOf5BmskIJvnjDMb2tibFPe9/aLEC9iZvJlygM35TN9de+2wtZkZ5q4s+e4cG2Sr5CEwrzz83yG4eemre7m8GX7BxSSDNvlBuKJVlHHy8mfOSsuvXiKvqdrwx7sHYWDaPtiulPnFxu25r08xw/yUHCvuGycrRMNXllmnkwhT16pHnpZZ0WlDLZr6w+nnW5DmnUuYLIRp0U/fobYfUNa9QKXb98IIH7JebHo/w/CdcESgRpkBN1jj5TpZ0Wo8vuRnZpEgT5DV2PWJTQLr4ZayyvDHrW0s1Rea2Z1znxb9WFyv7+T3CyaxDOFvjsmupSuxIZP+YHded2hmkb84crU2JTJqAl3H4PqB771DiCX20NGFtUsyp11MYldN5hNZ7H5iB8xrHhwA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(6506007)(6512007)(5660300002)(7416002)(38100700002)(508600001)(26005)(31686004)(36756003)(186003)(2616005)(53546011)(8676002)(4326008)(83380400001)(316002)(31696002)(66946007)(66556008)(66476007)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FHOHVpZyttZk1RZHZBMEoyWm1GZW04UTdEVDdmM2tpdlhBNW13clZnNHhk?=
 =?utf-8?B?YmwyZlpDaXpSbWpVamFPVWxxMmZ0cEZ6MEZ1U1RpdDJrNFYzTlZYd2Z6RUZF?=
 =?utf-8?B?SzEzVHgwYUNvUU4wL3VyTVZMSzhaUDdYV1pSWWcyanl5eDY5cDkxYkNjZzlK?=
 =?utf-8?B?TStmWTBGZlZSMEo3NjkzeVdyeE92a2RhOXhrMEdIa2pvTUp3MkluM2lQYkgz?=
 =?utf-8?B?RStzbzg1OUkzUUR3N3lWUmJRYkI5eisvUzdoc05BdDB2ZGs0bUJkN3c1NlBO?=
 =?utf-8?B?WE9rVTdiM2tXd1Z4dFhEL3dPUmpYaHR4eXEwWHFmWndYRDduQk84amo3TVdz?=
 =?utf-8?B?QVErd00rdFBvUkdlMlU2VnhYbzVLc3dVbmsxREkxN1NGdGp3bFhJTXlTcmcv?=
 =?utf-8?B?U0RkZHhjZlE0a1dOdjZsYTV6a1Bqa3pjYnl1R2lSaUY5Q3VHMVBtbm14WmFZ?=
 =?utf-8?B?ZCtqS2VzY3czNHIrUkJYV2pxb0hiUGMycWs2cGNPM1pIc1lQbm95eFBnRnFh?=
 =?utf-8?B?cTRXWE1IVjZBZnlUM1FhMUVEVDJzWCt4V3pleU1GWUk0SFdxb0M5dXJsTk9s?=
 =?utf-8?B?eHB0SkQvMlI2cVRlWGVPdnJEbXNjc1NtdDNsU1FOV0ZWRmcrb0RVdENxLzMv?=
 =?utf-8?B?Q2lDZ0k2VXVvRDgxTXJvUm5mYTd3ZjdzUk9DNXNsSmd3MzcrdFJlNFpPWGZZ?=
 =?utf-8?B?UCtXS2NhZHd1SkZPU3BMT3FRTHFMNmRXcGdtZ1BmOW1PTjcrNlVVckN2UmdF?=
 =?utf-8?B?UVVaNHVZM2I2S2U4WHlpYzFRQXFIL0RyY0xRTDQrWmZsMVVCcFZCQ1RPUWVR?=
 =?utf-8?B?dUVYUU4rZzdTMFR0NzhvSGVkNlNqdDV5N3BaS2tSakFhTG41aFFWQUtyK3Ir?=
 =?utf-8?B?NU03VXltR3dUV1loTFNNV1BhZGJ5VGFickJIMHNudGROZlBiZFdNbml5UWht?=
 =?utf-8?B?VUtRWG40MDdqTlp4cVJtOHg5clVGak1GWXR1MnQ0RkVOQjJkOFBvdVdEVnZM?=
 =?utf-8?B?SXg4MkNPdUtxUVMrWHVsY3hCYnRzWlVINzRvci9jR3NqS1Y2KzRyRE13OGZO?=
 =?utf-8?B?SEhVU05QaWVoQ1ppUjNXNitLeTIvT1F5ZnRhVHltNHRUVXVtMHJGZExFTWxB?=
 =?utf-8?B?VXlnRnF4d1NiTFU1N09lL2E0UzRYM1BwUVhFMFFvLzZGdEhmV0pzUFI3ZTM1?=
 =?utf-8?B?c3lIclhKVHFKbDY5ZnE0d1RLekNrY20xWDFMMUcyUzZpaHMwdVRJQld3anZa?=
 =?utf-8?B?eXdwei9sc0ZkS1BMTklXTXNUVXFCWjRYT0N6Mi8wKzRGeWJtcnVHeU4vcGlT?=
 =?utf-8?B?eTdqR21HeUIrQjRWTkR3eDRoNFJHK2FFa2xCZVpJZDZNcVk0eHBHZlZOQld2?=
 =?utf-8?B?azMyenYzb24veS9EaENrdk0vZFJDTmRoUVYvdVhJT0kvYWVDbjFaNmJyRjg3?=
 =?utf-8?B?NFBnYnM2endobEdma3A2elpzb1RTU3BQQU5yWFpISlBGN0plTEhkMGdNVXYy?=
 =?utf-8?B?M1V0UGNXVzQ4SnBlRnRISEVaNmxHTjdoQXQyaDZEZVpXR1NFR1VQR3dQZWxV?=
 =?utf-8?B?YWxJUGtvbWs3WW0vL1dsUUpDWHU1Uzk3ajhITmliMmRHV2JRRWM5MnptYnFp?=
 =?utf-8?B?aHJ2aWFEYVdDQzh2OFhzNmpyeDZqL2pSYU5xQ0p6bmlsQmlMcHpLR2g2d2dm?=
 =?utf-8?B?TGN0UzBmY29xeE9sZVlyMmlPYnZIWTA2b21SbWx4KzJQbVRzd3BYK3h0YytD?=
 =?utf-8?B?dkpYSXBtVSs5ZU80S3N1bE5MUjhwWHFrcytwV2djVDdPRmlvRmlabG9CRlJW?=
 =?utf-8?B?ajF5M2JJT2lkQ08rRXhKbTRpQjhNQUloYXdUVkJLbm5XMGltSWRvUTFVVDVY?=
 =?utf-8?B?SlZzY3kxU0UwL0xqSjlWYlpPSXg2OXdUMmxKY2RQM0MyU2xXVzUvbWNIUE83?=
 =?utf-8?B?R3VXeVdlVDBwTVRhS1hHSjZSNVhSeGFoTk1pVU9ZbDlRWm9FM1gxWDhqZHBX?=
 =?utf-8?B?SEJKQzBnZUwrTjNCb0RzUjF5ZytOL2xEUXBIaldQdXUrOExQUTdzQ0NYTGZF?=
 =?utf-8?B?cGtXOEtRVHNFWUltcnI5UWhsckFwRDJUUTZnNTBpS2VxSTZiUE9VU1BiZWpa?=
 =?utf-8?B?N3A0UFlmVmEzSmdYcUN6R2l6dy9zMmhsRzN3a2s1bHphR0xtb2V4VXZBLzdP?=
 =?utf-8?Q?bB/hnxio6PLCfAP39EyuoWM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eee9440-dcff-4564-0899-08d9f64e28d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:56:20.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR5bQHHHErroIthqp7r+PGB836gkilJSMD3kGR5Xx4Zi2QAj5ELP8nEML2AHGvgUygFZ0akR8/JgpFqUXYDlPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 12:57, Kirill A. Shutemov wrote:
> Updates for CC API:
>   - Fix for HyperV when AMD SME/SEV disabled;
>   - New home for CC code: arch/x86/coco;
>   - Explicitly declare vendor of CC platform;
>   - New cc_mkenc() and cc_mkdec();
> 
> Kirill A. Shutemov (4):
>    x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM dependency
>    x86: Rename cc_platform.c to arch/x86/coco/core.c
>    x86/coco: Explicitly declare type of confidential computing platform
>    x86/coco: Add API to handle encryption mask

For the series:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
>   arch/x86/Kbuild                               |  2 +
>   arch/x86/coco/Makefile                        |  6 ++
>   .../x86/{kernel/cc_platform.c => coco/core.c} | 56 +++++++++++++++----
>   arch/x86/include/asm/coco.h                   | 32 +++++++++++
>   arch/x86/include/asm/pgtable.h                | 13 +++--
>   arch/x86/kernel/Makefile                      |  5 --
>   arch/x86/kernel/cpu/mshyperv.c                |  3 +
>   arch/x86/mm/mem_encrypt_identity.c            | 12 ++--
>   arch/x86/mm/pat/set_memory.c                  |  5 +-
>   drivers/hv/Kconfig                            |  1 +
>   10 files changed, 106 insertions(+), 29 deletions(-)
>   create mode 100644 arch/x86/coco/Makefile
>   rename arch/x86/{kernel/cc_platform.c => coco/core.c} (73%)
>   create mode 100644 arch/x86/include/asm/coco.h
> 
