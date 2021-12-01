Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37234656C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhLAUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:00:32 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:18561
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245473AbhLAT7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:59:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKlffnDMsBSprgtgcnfHfz7ErAYyfyc91XwlfgAB+v5jcYwy1DIdN7e3UTfI7aE9gDXi/CE4SgZU97DvBNsjHl/0CCC711eYOivcoUgFhBjxec7/n2Ly99f5MUj9hUR52BvlAFeZiRIHucaBhFvTlL84JKB6fE0JAgbxbDYQ/7XiFmHc1iKBFvIBQU7lY4AgIcIBzoA0oBmYT8PqZt8Pd3HFBLmdPaqO5pih7QCSIuKR2RIsf/7oeAA91XTbBsJIZxhu0KwFQ+apBDU+Lr4PJDrBbLlJ0/rTtccfBRO+HWBfks20t4O71QYjOPwZtKfLX+8Op0SX/cEJRaaIh1FbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k57VZEr4IRxLvIfm+UBjhqGi1DQR2WsOVOSGkZ9jgJw=;
 b=N5lSHYF+FfL0NPoQXrOh+6p/iucBbWin4yM2sGciYZbF8zBIkBYzcNcLStEfxiBxtk1Imgjb/6Pm0JLejN42y1qzD5AA1gFPTFL2Df70g4Ra58tmdOq5ugbrEmF9Mig/kUuI6yCI8+/Iz5N3wQ4IcQVMM09e/G6pLWoTtwxb8ocLQdoki9z8qE6h3hg7oh9anF8a1sOK3RUCG5kusDPzCU+QtYqVVej8SAaNcp15JSXV5uR2DNzHDy6M4FKjuV52s6PUmT6GF/xzFimZ7MIBca0DMHJcWRzgvTec4keHfNOl197+fsTPtHqelUtDG9ANkbTn26Ij1MqKM6wBNWLoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k57VZEr4IRxLvIfm+UBjhqGi1DQR2WsOVOSGkZ9jgJw=;
 b=HGJ1gKiZAQj0LLothh72v274VYpyRbkGpQB40xoUTjjk4Eh1wD2rCm7CnTy6xQ3DeciJzL0ZgKaBxp5CO9hvoYanQvYdU18tI3zymZP6NGBv9VCtfOq41X8RdRHHL2cAUBFKoq8BkiB3nvpXiDMZ9RbWrZcrWkd0m3M3TD3e+uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 19:56:06 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Wed, 1 Dec 2021
 19:56:06 +0000
Subject: Re: [PATCH v1 4/4] x86: Move common memory encryption code to
 mem_encrypt.c
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211116004528.2928887-5-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <80579c46-3d29-f33b-9102-770f0c1c64ac@amd.com>
Date:   Wed, 1 Dec 2021 13:56:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211116004528.2928887-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:208:e8::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:208:e8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 19:56:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e2248f-5e8f-4745-0fa7-08d9b5049c69
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-Microsoft-Antispam-PRVS: <DM4PR12MB537412C68513DE04B6F7B95CEC689@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwbWrhG2Y60KkDseHrXT4/SxVMXZf1Ndu7bvtUW6iTW4fsgSFaJmvoZXoHECi1zoO9IzE0yNVDsL8RIqoo6G3cFK40QpItED3TR8P9xGge3WalSG9EltYo1wXjO4wa/I0jBXld5WRPA8w7rtUBuBsrR7MX7qKXN7yJ8oPAqU5v/5KMPRoaCcBl5ngNqWDXhSbnyrLLJ5G4+OZyt5ErBG6M/qRsaEK8a3r8140lGGdcHuuGuPas/AvvmacTgVQtjHBUMnSnnclG/kYVZGO7u3s0j/xKk6h0uAimKEMaeGxZMYUE+xSA97cKpdInmOLlH1kMwRUf56bkTrs2y688o/jnerImprACdHecXv7ZuruBfXXsTTb+Z/0jemJstPGTiO5JVpgg8ZR1lDxffUYvI6s5w6K5OLLG8TJACbGVkiBgCUBd6ZFzLKB+B0W/M5kUtGCFxZZGU1s9NBsNjOlEoytBM6hCtu0EwE1/zrJ0uxpw+05dRWzsrE05ObWU1vXmr7h3e0eRNb8ca1R8dH9b6ocRh87rixOeqUiqx0yuUlZ56eBLciIxM7P7KEi0cLmqv198RqIT1ke7JfP6pV9IoBL0XG/HI2COL734hb1ehz2IISPXxCRgxIjvCpJPbKwvGkmrDZAaDkc9rp/yKK/lQ721+jcjOor461XcxSlaVSisu0q9WewA2f9LciH3TNNYXbCcFvM72QyvLgWFH2VkrwCoJ9PjwGWnFxeWGrqXK8aS31M1Q+kP+eryQJj1/gvUYe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(5660300002)(66476007)(6486002)(66946007)(956004)(8936002)(31686004)(2906002)(54906003)(66556008)(53546011)(8676002)(26005)(36756003)(31696002)(110136005)(508600001)(186003)(4326008)(38100700002)(86362001)(83380400001)(7416002)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS84R2RTcjFtZ3JSc28rNEpoRVp0b3ZQZkhSSnBXNDhhWXBFV3NBdDZycmUy?=
 =?utf-8?B?MDJCcERHTkxOMWRLU3hvS3hoMEJvSG1BYkovdFFkalAwYlpOd2FwYlVUY2gr?=
 =?utf-8?B?SlZPcVVhcEprd1FlQUM0V3NEYTRWWFlqbHQzaUZBbnNHSU9PM3ZiUkM1QkVJ?=
 =?utf-8?B?c2NVZGpiZURVdUxrYWlMU3JRcWgwejJuem50NFBnQi80N25tbm9wbGR5S3hD?=
 =?utf-8?B?a1lUU1l6WmNPZUdzL0hDZXlrTmkwb2YxRUtONmNRcDdHSFhaSmpZVXlhaGFx?=
 =?utf-8?B?QWYvdEtUVlJXbkdnak5tRTMxZFMyYi9sbGxPSzJNVVdsODhDbFZjeVQ5YldI?=
 =?utf-8?B?QWt4aFlTK201T1l5NnJGV3dLemVpUWxsUi9rZ2ZxUkp3dkU3YW1McUg3MDZQ?=
 =?utf-8?B?SzlRc0c0Zkw4aXdFcTJQV2R0dXY2MnRBNWtCM1ROdDhhbW9lK1U5cWZ6YmJH?=
 =?utf-8?B?Tm9UTFhwbm91Zlk4aktyRldXYVE0azB1TmlvNFVwbmZmcHhKTUJpVG85Y3Yw?=
 =?utf-8?B?aWNuaXhjMFhYdXA3YlFpRlY3cDJDTGFZSlgzcUpTa3QrNFNtcy9ZdG5yMU1U?=
 =?utf-8?B?R3dIMWRXT2MrdkUycU9kVmYxd21sN2FUSGozUmt4eHNOQ0RTVy9JeEpOblBl?=
 =?utf-8?B?VnE0ci8zVTRQaEJjNWdIY2psUEhkMXkrQ3UyMWJoS21uT2Z1TDR4VVBaOEc3?=
 =?utf-8?B?c2sxcjVQei9BREordTcwWGRmLzBld0FUMisvUDNjVjZNamJvUGxaY2cvdnNV?=
 =?utf-8?B?YW85b1lyQVNQcHoyTFJTdXB4QWx1R09TS2tvc0FFRlZhbEFQRytqTmdha2FZ?=
 =?utf-8?B?THJMbnMyVDV4azlacWx2NWUvYUgvUE05ZEIvbFVHN3RaamRTRndKdzZIaVdP?=
 =?utf-8?B?b3dhVzc5ZjhsV2FvZDhjcFp1bFlyeml6YVhkb1drdlVzWXJrNm8xcXJaRVAv?=
 =?utf-8?B?VjAzSFRvS243b3pHcWszTTRpZVd6S0t6NjNaS0FBWWEzL3pFSzF6TDB1QWxF?=
 =?utf-8?B?d2lJTDRXdHZMOFg1Wnc4ZVFRYmVKRnhDWDVvd2RGZVhHNHdIcGRsZUNEeWFo?=
 =?utf-8?B?ei9GU0R5ZHBseGxhVE9Wd0o2blp5dTY2THNWNjh3cXgrRWpBWEhzeTM5WFlD?=
 =?utf-8?B?VG92K1VrZEZGUlQrQVJkL2M0OUxxTmdaWVhMbWJ4R1JFcWQrZHZ6bkdBbzZz?=
 =?utf-8?B?ZUxHckR1YTd2VWhYeE1GQlVPQkxpU1dkY3ZDdWNLbUdaajZxckxqTmYvbHox?=
 =?utf-8?B?cDBsNTlrSFBnSUZwWVB6Sk44aEo3SVlwQ1FwcDVQWmpDREw3OEVic3NQUkp6?=
 =?utf-8?B?NWFiWlFBZEdJUU05R0NYM05BWWx4dkFBUkFzUW0rcE5ZbVNCQUJjOVpoMGFF?=
 =?utf-8?B?anNxQTJtMlp1NVlHbTJKT1pJWnZYVnFlb3grYVlmUmtFaWlCaTF1cFBqUUtZ?=
 =?utf-8?B?YjN2QWJuaWJWN3U4SWNabUhPZHdHZzNNR2NucSt5REY4VW1rQWxnYkMxOERi?=
 =?utf-8?B?ZUtJTVlQeUs0dlF5MUZ3Y1k2U2xjeTNxMHhkd2wxaFlMVStFa1NRUGpWejZS?=
 =?utf-8?B?ZlNIaWdQaXo3WUptdHVrL3AvanU3QUl5cjZFckQ3NnNUV2RRVkpXVFkzZTc4?=
 =?utf-8?B?YnVZbWJaMUU3N3pCakVZVVBUeVJ3SHg1c0h6cU5VTk95YTFWTjRhQlBmNmtR?=
 =?utf-8?B?QkVHS3hsRlFaaGV2QzVWOWtXb0VtUTgvT3JOUTI1OUtBR29hSFVGNG8vY3pv?=
 =?utf-8?B?cjdrcUEvUWlIUGJUVCtNNHJ5Q04vN3BkbzdRNlJwTWFJaXRHMVZSYzdnZ2Z3?=
 =?utf-8?B?Mkdla3RCdDRteFB4VGFVeTNFUW1WejJkL1o5M2MzR2M2RnFxaExrUWJ4RFdQ?=
 =?utf-8?B?RTRMc3Rhb1J1VUJacmVhdkNwQnEzTlgzcERCZnRDdkp2aWUwNVN0dkZra2Rh?=
 =?utf-8?B?SDhaRHdzQVhvTStOUDZob3JvbTFVeDdzeTZNOEJGeUxCTm9iRUJVZnR6UVdD?=
 =?utf-8?B?b3E4dFA4eWxRRDU1dVJnVGFKZ1pYTWgzSlZMNkhidWdQN0RaRnd6ZEZpSk1X?=
 =?utf-8?B?b25ZczdBQ2J0a1RucWttU3lWZHZkZVo2NWdaOWlBUTdLMGl3ZTVvaG5naDJQ?=
 =?utf-8?B?R283dGg4OFg4bFpsemROVitMWWVXdlVmY21tOERRN0RZd3NJdGRvOWNHcGwv?=
 =?utf-8?Q?CBIc+8jn+c2kP8/rPoV8ufw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e2248f-5e8f-4745-0fa7-08d9b5049c69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 19:56:06.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbvbgyY+qcNCDPPRB7koSPWiX+fWpXMDlxvmUicbdYVS3EJFdjdS0tX0DQoxtkE7CRZscnQllrQws2E6+2BlGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 6:45 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> SEV and TDX both protect guest memory from the host access. They both
> use guest physical address bits to communicate to the hardware which
> pages receive protection or not. SEV and TDX both assume that all I/O
> (real devices and virtio) must be performed to pages *without*
> protection.
> 
> To add this support, AMD SEV code forces force_dma_unencrypted() to
> decrypt DMA pages when DMA pages were allocated for I/O. It also uses
> swiotlb_update_mem_attributes() to update decryption bits in SWIOTLB
> DMA buffers.
> 
> Since TDX also uses a similar memory sharing design, all the above
> mentioned changes can be reused. So move force_dma_unencrypted(),
> SWIOTLB update code and virtio changes out of mem_encrypt_amd.c to
> mem_encrypt.c.
> 
> Introduce a new config option X86_MEM_ENCRYPT that can be selected
> by platforms which uses x86 memory encryption features (needed in both
> AMD SEV and Intel TDX guest platforms).
> 
> Since the code is moved from mem_encrypt_amdc.c, inherit the same make
> flags.
> 
> This is preparation for enabling TDX memory encryption support and it
> has no functional changes.

It seems strange that some AMD specific function/code is in the common 
file, especially print_amd_mem_encrypt_feature_info(). I'm not sure if it 
would be better to wait and move that and mem_encrypt_init() when you add 
the TDX support, since you'll have to update mem_encrypt_init() to change 
the check anyway. Just my opinion, though.

Thanks,
Tom

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   arch/x86/Kconfig              | 10 +++--
>   arch/x86/mm/Makefile          |  5 +++
>   arch/x86/mm/mem_encrypt.c     | 84 +++++++++++++++++++++++++++++++++++
>   arch/x86/mm/mem_encrypt_amd.c | 69 ----------------------------
>   4 files changed, 96 insertions(+), 72 deletions(-)
>   create mode 100644 arch/x86/mm/mem_encrypt.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 95dd1ee01546..793e9b42ace0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1523,16 +1523,20 @@ config X86_CPA_STATISTICS
>   	  helps to determine the effectiveness of preserving large and huge
>   	  page mappings when mapping protections are changed.
>   
> +config X86_MEM_ENCRYPT
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select DYNAMIC_PHYSICAL_MASK
> +	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	def_bool n
> +
>   config AMD_MEM_ENCRYPT
>   	bool "AMD Secure Memory Encryption (SME) support"
>   	depends on X86_64 && CPU_SUP_AMD
>   	select DMA_COHERENT_POOL
> -	select DYNAMIC_PHYSICAL_MASK
>   	select ARCH_USE_MEMREMAP_PROT
> -	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>   	select INSTRUCTION_DECODER
> -	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>   	select ARCH_HAS_CC_PLATFORM
> +	select X86_MEM_ENCRYPT
>   	help
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index c9c480641153..fe3d3061fc11 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -1,9 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
>   KCOV_INSTRUMENT_tlb.o			:= n
> +KCOV_INSTRUMENT_mem_encrypt.o		:= n
>   KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
>   KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
>   
> +KASAN_SANITIZE_mem_encrypt.o		:= n
>   KASAN_SANITIZE_mem_encrypt_amd.o	:= n
>   KASAN_SANITIZE_mem_encrypt_identity.o	:= n
>   
> @@ -12,6 +14,7 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
>   KCSAN_SANITIZE := n
>   
>   ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_mem_encrypt.o		= -pg
>   CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
>   CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
>   endif
> @@ -52,6 +55,8 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
>   obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
>   obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
>   
> +obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
> +
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> new file mode 100644
> index 000000000000..5ae4b3d7d549
> --- /dev/null
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Memory Encryption Support Common Code
> + *
> + * Copyright (C) 2016 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#include <linux/dma-direct.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/swiotlb.h>
> +#include <linux/cc_platform.h>
> +#include <linux/mem_encrypt.h>
> +#include <linux/virtio_config.h>
> +
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	/*
> +	 * For SEV, all DMA must be to unencrypted addresses.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return true;
> +
> +	/*
> +	 * For SME, all DMA must be to unencrypted addresses if the
> +	 * device does not support DMA to addresses that include the
> +	 * encryption mask.
> +	 */
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> +						dev->bus_dma_limit);
> +
> +		if (dma_dev_mask <= dma_enc_mask)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void print_amd_mem_encrypt_feature_info(void)
> +{
> +	pr_info("AMD Memory Encryption Features active:");
> +
> +	/* Secure Memory Encryption */
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +		/*
> +		 * SME is mutually exclusive with any of the SEV
> +		 * features below.
> +		 */
> +		pr_cont(" SME\n");
> +		return;
> +	}
> +
> +	/* Secure Encrypted Virtualization */
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		pr_cont(" SEV");
> +
> +	/* Encrypted Register State */
> +	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +		pr_cont(" SEV-ES");
> +
> +	pr_cont("\n");
> +}
> +
> +/* Architecture __weak replacement functions */
> +void __init mem_encrypt_init(void)
> +{
> +	if (!sme_me_mask)
> +		return;
> +
> +	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
> +	swiotlb_update_mem_attributes();
> +
> +	print_amd_mem_encrypt_feature_info();
> +}
> +
> +int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> +}
> +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index b520021a7e7b..2b2d018ea345 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -413,32 +413,6 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, boo
>   	notify_range_enc_status_changed(vaddr, npages, enc);
>   }
>   
> -/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> -bool force_dma_unencrypted(struct device *dev)
> -{
> -	/*
> -	 * For SEV, all DMA must be to unencrypted addresses.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return true;
> -
> -	/*
> -	 * For SME, all DMA must be to unencrypted addresses if the
> -	 * device does not support DMA to addresses that include the
> -	 * encryption mask.
> -	 */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> -		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> -						dev->bus_dma_limit);
> -
> -		if (dma_dev_mask <= dma_enc_mask)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
>   void __init mem_encrypt_free_decrypted_mem(void)
>   {
>   	unsigned long vaddr, vaddr_end, npages;
> @@ -462,46 +436,3 @@ void __init mem_encrypt_free_decrypted_mem(void)
>   
>   	free_init_pages("unused decrypted", vaddr, vaddr_end);
>   }
> -
> -static void print_mem_encrypt_feature_info(void)
> -{
> -	pr_info("AMD Memory Encryption Features active:");
> -
> -	/* Secure Memory Encryption */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		/*
> -		 * SME is mutually exclusive with any of the SEV
> -		 * features below.
> -		 */
> -		pr_cont(" SME\n");
> -		return;
> -	}
> -
> -	/* Secure Encrypted Virtualization */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		pr_cont(" SEV");
> -
> -	/* Encrypted Register State */
> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		pr_cont(" SEV-ES");
> -
> -	pr_cont("\n");
> -}
> -
> -/* Architecture __weak replacement functions */
> -void __init mem_encrypt_init(void)
> -{
> -	if (!sme_me_mask)
> -		return;
> -
> -	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
> -	swiotlb_update_mem_attributes();
> -
> -	print_mem_encrypt_feature_info();
> -}
> -
> -int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> -}
> -EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> 
