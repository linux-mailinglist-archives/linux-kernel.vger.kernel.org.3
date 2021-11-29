Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE946235C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhK2Vej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:34:39 -0500
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:45570
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229991AbhK2Vci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:32:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lal6eSufOHcBiON7yyLhj78H7ag5FstIPN4nxOGMREGzYiW4zmHUktvlCJJKfunj3rMb8x6a7sY/vXRZpG/KyRQ7WYJglonwrMBozqXdk64HNm7WzHDIhycgtYCI6ngEZUaC5/qjpmppjpWGs7pGLudvZFH1OfqLSgBYVBB9rYOmrwKOj/qSloJ5Ux6qkLsNUldrD8r73A+F+EEg8r89uBZEi6aEonP9aozCm5OScaG0Y7wm9B9wlkHV8wMbNhhSgHa6bX+bJGdNZc7OxJgWRhWgwjUOKNJlFvC8/IAWqNhyETYtVGF8kuAM6P2QU0FcdyAi5r/tahHJMvHzTYyfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHXkT8KyBnFXgn+KknRh2WDiGeLTpJPnSUXVAshGRTA=;
 b=QI9C+a1r4nsSl69WVntOVGFU8UDjjEGtv2fo35/CIhBeIHdyDkai16qyCEPIBFrMunfKRM0rSHi+VYX1dq/2B+oGqE3/cmOojsKG1Vt1VlPXhP2/hDReOnqyABZTBI3oWn0XQE9s5OvrBvYtLY29VVhQp5pSgTtdENmdQOTZ2hxzLX094VhdxcCr5AnzqW1NBaBEgfq/N5N60qxbIpYkK9j+2J7OhMP+T3QBhZ+SLCNcKxHVei7TOrgI9claTCpNyXdzvX2qcy+40yPWoZW6kF7Lv9zFYPfENQgBYiweVtvxz19QEPvEc1qvKw5im01OPSiPz4xbQFxsccC/oiZMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHXkT8KyBnFXgn+KknRh2WDiGeLTpJPnSUXVAshGRTA=;
 b=1xO1AAYF8coSYdto5VWfUqTKACgrDMUnK4sNIIRLhHwPnOfrH0hhzKfPf2EYRBLYvmgGknb53IvpIq4HmmzV1b4EiajMKtbA703jLHtgwnZVA7A7iyXSUPQW6MJSDxEXQRKCepi58Ngk7b4qnOEUKezrdGpfz2ukRvn1OA8vsA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 21:29:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Mon, 29 Nov 2021
 21:29:18 +0000
Subject: Re: [PATCHv3 3/4] x86/insn-eval: Introduce insn_decode_mmio()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
 <20211103154555.23729-4-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <27eaafcc-ee35-716e-bd96-95167c1f764d@amd.com>
Date:   Mon, 29 Nov 2021 15:29:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211103154555.23729-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:208:1a0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 21:29:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99eb31a6-47b4-4e69-6ecc-08d9b37f4d1d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5312:
X-Microsoft-Antispam-PRVS: <DM4PR12MB531262E1EE9934FD06FA1945EC669@DM4PR12MB5312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8xadin0BivpnB965stIL78h7BerKMO00y40ZZ4QG1eTtBRiACHXkmyPhGwJzUd/MNifRmDov/Nfx93IoY+ZlMGoVd2Iy5JtaMCmNZg4CU87aepI/NMH5CE5uD1aQSGAGsMFijlo+fvVQzE9smRH4w+hA7TrwVktX06vzJ18WEYrgdE9T86335wl2BYTIAcYzkHP3na+xUi/Ci12ZbSRQzpwGuDWA/UixatpapSFpPLKqxwcBSbEiFu3bUDcWSZ+RK8wsH1DKURH2b2PdkxpSPNwittz2CNQaWsPLGQ67cN/8RHy+hG/TPiHnkJ/fEdKAVBD1il6XShyJqfalU+qvhhZErLwFhqbfE/XEIt5O+63Ie4R0PuJhRAHLrmtT3cLr6LFz2pKZsCIgNt60VLVgxq7vKbLh4XSAzQ3/yht2bu40krUv6Y9qQLbUBPyq/tvpAn4Pr0rx7gaOnn4Cvh/GJNVzOLdBzryQXztw6z43RpozEYmZnh7H/4xv3LN7ljC1twDqM6+vPozNwzt59ABCbNMmdE028Fx4+WHpW71utVX+wRwL3kAlBXJh5DsAPZcaSAhzRFfJ18ZtxBz9w56oi9JUfq+SH33fFlADcxtG3RRcd81Mf4CctAOUY1XwiHHeE/n7Gknb7qtT71YeXvCkXecYyqog3MTH2Yg4aYv2ifnOrOSvRhRPhRvhFsF1V7nzMO+vRidoQ8QpnXIRc/ebChD897jEqX+8fmjlYECxUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(86362001)(8676002)(83380400001)(186003)(31696002)(53546011)(8936002)(5660300002)(2616005)(38100700002)(66476007)(66946007)(66556008)(956004)(16576012)(316002)(2906002)(7416002)(36756003)(4326008)(6486002)(110136005)(508600001)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFEYnJYTzdYMThvNjBBR3lKajNrWWl4THozQnlIU3ZxVUNDS3RkZTk0d1BF?=
 =?utf-8?B?aytjckJKdXo5bks1aVZUU21aUTM3ZlAvOXpadlpRVWx5WkpRNjkxMzI2S2cy?=
 =?utf-8?B?eUJzN2RHeTg2cFNaWU1HMzExLytSVkcyeTRURklXa3hjU3liTXhmamhzN3Y2?=
 =?utf-8?B?V1lPaUt2QjBQaG51VHlKaC9mcWlHWmI5aU1vNDBRalpacWg2Q2JKdjdhdGVv?=
 =?utf-8?B?dGs0S1FOdk9jeGdKQVJ5Z0xtTVpSUlh6cFpKVmwyOHpZK3pHRDE1cXpKaHhl?=
 =?utf-8?B?bjIzNDJSS3hweUl1MmZGeWpLcTA2QnVKTWRQdWFCYXFaS0JoS21VOXo3Z251?=
 =?utf-8?B?cndmRFNTM01tWW5qKzhPdkk0cDAyQitxekV4cklmL3phT2pKQ0pPSWxSVk40?=
 =?utf-8?B?Z0kyVWQwV2w2Umt0dGFTUDRWdmc3cm8wYjVTVDl6b2NEd0ZUK0FrUGFkci9p?=
 =?utf-8?B?TkJNemZKVjhNODVmM1JiMnZjYzhoaXVGWWxQVDY5TUxUVmEyU2lvU0VTaU5K?=
 =?utf-8?B?Z2Uwa1VmQWRrVlNFMk5tVXlyYTVaeGQyYjVOQTdBVVk2bURyMXREWDBqclIw?=
 =?utf-8?B?eFFJRjhtWGVTK1E3cjBORndLaEo0VW5YcnV0aGE5Y2VHYmhVSTlLdjZGV0RB?=
 =?utf-8?B?aTR2dUtkaTIwL1hqSjgydXNEcWIranVDK3JJR21GbGh5cXlmMXlqRjBKbkZS?=
 =?utf-8?B?MUVZdHRzTFIxeVpnSWdMUGFyTmpoQUJUWGJBSzc5cXZMd3htM3Q4S2pUbHdL?=
 =?utf-8?B?TEUzcjIvR0VIWXQxS3dERXhqbWZRaUF0QTU0Z0ZMa3VFb3owOEVYNWN6K3My?=
 =?utf-8?B?VkM1YUk2eHNzVlkzVHpQU0tmNHhhbkNvQU9MVUV0WW5OaW91blBJTSs3Znk0?=
 =?utf-8?B?MUM3VDU0aVRpdnl1MlFKL2R3SERpQzhQK0huR2tsVE5xbzNXckRtN2N3VGtE?=
 =?utf-8?B?TzJJQm1HaWdIWTNHNEV0YXZWd3RFaGZvQUM0WGc1L3g1NlNSMFJkMC9TNmcw?=
 =?utf-8?B?aXdtQUpLK3RMTm54ZU8vTnUvckUyRDJKZ0ZyeWV4TVdJSDNMVEdnSjQ2cDlB?=
 =?utf-8?B?NGw0SWVsZStVTlJHQnRsV3orWW4wMmttOHlNTTBzcFhIRHZaK3A0V0wvMXky?=
 =?utf-8?B?dzIzTjJ5TUdzczdsZ3kzZ0x3NHFrTGZkVGN6L1RrVDZ5eCtBbm1qL0Q3S3Za?=
 =?utf-8?B?K0hoSDh5TU1kSG1MUHdvOW14dUpKcytsUk1IMEM5L3c0b2JSdjY0UjNTZGM4?=
 =?utf-8?B?blh3SUNxZkpxSW1XWndwMjkwQUtKeW0rNnpaRytCVzV0UVlMelQxV3l2a01V?=
 =?utf-8?B?ZGFwY0E0azhrVE0zT3hPbjJNRDV4Nm0ySGhyUFFUMVNFM1l6QUxJdWwzVTNV?=
 =?utf-8?B?Y0JoNWllUmJYQmJSVFVhaGtFY0p1eHJJWnljT2FBcldIMlJwb2wyUThpeXNT?=
 =?utf-8?B?byt4a2t4dGhTdGN6R1krdlI4ZEhBN2hpS0tLRWtsbXZVREd1MUR2Wm5oZG9H?=
 =?utf-8?B?ak1vWHpkRTNIajhGenFWTTJGeDg1ZDhKck1mZm1QNEttUzA2bUw1Y3IvR2lx?=
 =?utf-8?B?Q1ZLd0lwOEttVlRmZTJxMFlkclJVVG5YWnpJV2pFTmRZTzB2NHFBMUhqRjFH?=
 =?utf-8?B?a0JmY3RTVzJ2QTN0MW9sMFVhZ1NQeCszdjVjdTNnU2tFVTkzZ24xSUVYR3Y2?=
 =?utf-8?B?UDZNVFEwZXdMVGM5KzB1dm0wbitnZW5CME5RNTBBM3ZLUXRFVFR6UXBUQ01Z?=
 =?utf-8?B?SUpKazJ6UE9hVi9NcWVEU3h6ZTBWeEliWklwNVY5bEJzdElnM2JVS3Y5ZkVR?=
 =?utf-8?B?Y0Z2ZWJlbVJnNi95UE9SM1FVWDlpMHhQNzFlclBWVityQ1VnQzgzU2xTTitj?=
 =?utf-8?B?N2NCTmxJc1ZIdmkzMkdmUmlzRGxuYWFudHN4SkZJaUx5eFpnZTVxdVozTXMv?=
 =?utf-8?B?cFduaFV6dThtc2F2dS9ZRUl5TkxFUkxIWkk1K2FLczE1S2dkV08vTUFNSHgy?=
 =?utf-8?B?Q2xsclQreUxHcVRxYTAwbTdDcGp5QmNZb01vbzIxYi9ndmFuUitueWUxbi9h?=
 =?utf-8?B?VlROL1Byb09vcHVYSEJjSkhJeW1NdjUreWlCeWN4WjdBVzVaWWFJL09iKzBk?=
 =?utf-8?B?cFRuVTNab1dOYU1jaEF1R0pmaEZwVFRlVHhyQkNYaHFVMEFuNjNJem04Q05w?=
 =?utf-8?Q?PlUrwgpeO6TJCuQtDZrNU18=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eb31a6-47b4-4e69-6ecc-08d9b37f4d1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:29:18.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pGmHAXScO0081NiQs5cbiTTMTt/lsfhRsvfPr+tAPK24PKgBs4DSmk7Cg4bBXDU8AIUp55L5onZLWd4mAPxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 10:45 AM, Kirill A. Shutemov wrote:
> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> 
> In preparation for sharing MMIO instruction decode between SEV-ES and
> TDX, factor out the common decode into a new insn_decode_mmio() helper.
> 
> For regular virtual machine, MMIO is handled by the VMM and KVM
> emulates instructions that caused MMIO. But, this model doesn't work
> for a secure VMs (like SEV or TDX) as VMM doesn't have access to the
> guest memory and register state. So, for TDX or SEV VMM needs
> assistance in handling MMIO. It induces exception in the guest. Guest
> has to decode the instruction and handle it on its own.
> 
> The code is based on the current SEV MMIO implementation.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/include/asm/insn-eval.h | 12 +++++
>   arch/x86/lib/insn-eval.c         | 84 ++++++++++++++++++++++++++++++++
>   2 files changed, 96 insertions(+)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index 5c6869565fb3..010d31726d06 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -29,4 +29,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
>   bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
>   			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
>   
> +enum mmio_type {
> +	MMIO_DECODE_FAILED,
> +	MMIO_WRITE,
> +	MMIO_WRITE_IMM,
> +	MMIO_READ,
> +	MMIO_READ_ZERO_EXTEND,
> +	MMIO_READ_SIGN_EXTEND,
> +	MMIO_MOVS,
> +};
> +
> +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
> +
>   #endif /* _ASM_X86_INSN_EVAL_H */
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 385232a67281..ffd040c1c97b 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -1560,3 +1560,87 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
>   
>   	return true;
>   }
> +
> +/**
> + * insn_decode_mmio() - Decode a MMIO instruction
> + * @insn:	Structure to store decoded instruction
> + * @bytes:	Returns size of memory operand
> + *
> + * Decodes instruction that used for Memory-mapped I/O.
> + *
> + * Returns:
> + *
> + * Type of the instruction. Size of the memory operand is stored in
> + * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
> + */
> +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> +{
> +	int type = MMIO_DECODE_FAILED;

Wouldn't "enum mmio_type" vs "int" be better here ?

Thanks,
Tom

> +
> +	*bytes = 0;
> +
> +	if (insn_get_opcode(insn))
> +		return MMIO_DECODE_FAILED;
> +
> +	switch (insn->opcode.bytes[0]) {
> +	case 0x88: /* MOV m8,r8 */
> +		*bytes = 1;
> +		fallthrough;
> +	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
> +		if (!*bytes)
> +			*bytes = insn->opnd_bytes;
> +		type = MMIO_WRITE;
> +		break;
> +
> +	case 0xc6: /* MOV m8, imm8 */
> +		*bytes = 1;
> +		fallthrough;
> +	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
> +		if (!*bytes)
> +			*bytes = insn->opnd_bytes;
> +		type = MMIO_WRITE_IMM;
> +		break;
> +
> +	case 0x8a: /* MOV r8, m8 */
> +		*bytes = 1;
> +		fallthrough;
> +	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
> +		if (!*bytes)
> +			*bytes = insn->opnd_bytes;
> +		type = MMIO_READ;
> +		break;
> +
> +	case 0xa4: /* MOVS m8, m8 */
> +		*bytes = 1;
> +		fallthrough;
> +	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
> +		if (!*bytes)
> +			*bytes = insn->opnd_bytes;
> +		type = MMIO_MOVS;
> +		break;
> +
> +	case 0x0f: /* Two-byte instruction */
> +		switch (insn->opcode.bytes[1]) {
> +		case 0xb6: /* MOVZX r16/r32/r64, m8 */
> +			*bytes = 1;
> +			fallthrough;
> +		case 0xb7: /* MOVZX r32/r64, m16 */
> +			if (!*bytes)
> +				*bytes = 2;
> +			type = MMIO_READ_ZERO_EXTEND;
> +			break;
> +
> +		case 0xbe: /* MOVSX r16/r32/r64, m8 */
> +			*bytes = 1;
> +			fallthrough;
> +		case 0xbf: /* MOVSX r32/r64, m16 */
> +			if (!*bytes)
> +				*bytes = 2;
> +			type = MMIO_READ_SIGN_EXTEND;
> +			break;
> +		}
> +		break;
> +	}
> +
> +	return type;
> +}
> 
