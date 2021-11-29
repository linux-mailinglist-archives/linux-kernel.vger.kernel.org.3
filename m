Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70BD462364
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhK2VhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:37:15 -0500
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:42388
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231414AbhK2VfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6fHguyJVMeryoiE/ReL4oIM0n3MeQ3ME4A46V5zODUaeLb7TMA2Vlg8DtqRKo/g3SfTicuk7c4oK4FR27Hpfm2RO2aAg4y+riYsJ1Mmrnx5n9K2mhNvPniB31vuXIAbHBBy8bkU4/oZ+nHyS+jcqFsyrVTTUFNE1YZOiC9R0JXSyiQFY0cpgGYGrs11KAHJ4PpdVUWyumX5s5DpgAkENlH2DJrJ0fNA6gt02zfaABVz6TPQPVTdM62DdvKrjXRHL16z5lnrHzHKWm2ox32/0Z+wVDiClIepIwcBkjDMtNxi+1qVWlnHM4lOupyYYW9yUsemzODo6pMiTeQk/g7oFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3jFOBHwYikGhjKNg4ZYMMlDqvQFt5Cw75JJ6JmAIqQ=;
 b=WYWx8jSeGsFt5RN/Pt7E/0mcrbMQmGb2GY506Qm6qCTksbeTfn0rbDGEuKB03UZ+XRn3NwjrH6WP1mez91w52BzT7A0s7I7LyvTE8JeVyQtnmu8GLnkeARS+ofcvlg3tgUxIk/tdu+zQ+gwPKzszlpVJRWu/7j9HLTfg1A2QqFRxF5dhZq7p/R2vn1ITaFav7nOYH1xvTlf02joc8Vu0PXo1A0tkGZSukeemJ1QS7btBHqLq7qcNyyx7DFZ+M5l1Z8+e1RqzSw9yIZ8gdXIVMePwvLfy7+KBfCIGZsQu/6nFKfrfKX33hJpintPcflCB32/VJoqIW4KvKN557zuLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3jFOBHwYikGhjKNg4ZYMMlDqvQFt5Cw75JJ6JmAIqQ=;
 b=yDXr7JM7I6sArJRapkeOwa6BmGgbwfR3rfzCXwTc/YA2UMUspHUigdsfSmudHv4TJGJjQp3ndX5+fpmgGdpi2BijVORHHYU5T4n6i0on7ha0ZS/mwC7p03xH7lSU6yCMAZQv69e1QjErYgeLTkX/yzlFbdNa68ufuVH54+wde5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 21:31:55 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Mon, 29 Nov 2021
 21:31:55 +0000
Subject: Re: [PATCHv3 4/4] x86/sev-es: Use insn_decode_mmio() for MMIO
 implementation
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
 <20211103154555.23729-5-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <acf1be97-dbc9-2165-e57d-278295c1d6de@amd.com>
Date:   Mon, 29 Nov 2021 15:31:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211103154555.23729-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:fc::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 21:31:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01566b2d-860a-4b30-000f-08d9b37faa83
X-MS-TrafficTypeDiagnostic: DM4PR12MB5358:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53588012EBBF82DC289D77C8EC669@DM4PR12MB5358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PT9MhhuV7bUr/e1W13w0LRsEVFxVHlMJifxef6c2LUtbTB90ntpKkZkpSteMN+j+eZGAIXro26L8DX3jk2QtI31n54EMlu+oKi5TdB8noutdeeOHjE/sAELJ8Iqx41rDUpMujyyKBfv63pOz2uuPaqTupoRuF890QUIjnRiZrfu+vhhv+kiiQFkrCKLeYuuvW+bEVXm/0Z6cde4V4Xj2ZQCh193+AcT8VW5FGyPlES0nvlBBsYnYlXsyIWRVR8Idm6bShlmI5RTgzB2jyeFIv1jbByTzYtrobwzxJmcF607YgwOBQfmVVEkUAgRdrqoyyK0FyNvgyxFV3iVS9CqN1QBOCUCG+zswmdsENeb4angReNjQ+3Trd1XiDXrS4hfuZKpIIH7JqwyKpXA4wlXBR5yyuJTIsz7033PyK9/D+UsVbOTJf4c7LSQrStN28wdZsZpcHVtnOSeqKOmofyLHoI+Zt2wchGH5y5XK69dt/C+P8QUWA/aXiuxZtWxaivBxEj84iJTZvxOxXpWbL8HYj3P65duUQS/5HMz5qL2l9Bd7Mel1tp45DoHrFmM2rnFqDj0G12N6hTO2xxHdTkcwvPinxCu0FnX+/OMMz3tPbxTyDk0mf1XMgGuuDjaiZ+v/wt1W8X7Mb1N8i/Foj+1umtLq5ab6XVu3PM84RRVhx398psvi4w4dOMhhvWkn4H1M3Ua19dpEC/XdbelHfNmwXcYu1Gu3iD4hjGIKIoaT9Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8676002)(956004)(4326008)(2616005)(8936002)(7416002)(31686004)(31696002)(36756003)(86362001)(38100700002)(54906003)(110136005)(66556008)(53546011)(186003)(6486002)(26005)(83380400001)(2906002)(316002)(16576012)(66476007)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZmcms2WlEyNVVudWZuSWc0akM3TXhuOUVRZnJXSTBLbTIweWgxODhSeXV3?=
 =?utf-8?B?eCtocE1oYjNlTytpWHk4aEIwMDdMcERCanVHQzBHcjE5elN2cnpSMlhDWGdR?=
 =?utf-8?B?bDV0bjFKaWw3OVA3bUxINDhEY0QwclhJV1hLc0tPazZzUytqWTh2VDVxRUxN?=
 =?utf-8?B?aVZyTVdubjN0Z1dxOG5MSmJaRFdkcDRSeDVPUFViMUV4b3k4bVJESmhPRGly?=
 =?utf-8?B?MmxIaGFWY2xPY1oveXpQcWZKZUhydVQ4ck1yUUJyRlAyZVNqZE1ZSVBoWHNW?=
 =?utf-8?B?WHRSYVVGbitlWFVxcnY4TTRrMElLK2w3OUNLY1Q0cmthT29FSTVFeWR2WDBY?=
 =?utf-8?B?R3FaYjJxMXJ1YWc4dllCYXpXK3hPY3V2bmtqUk4zSzI5aFU1QjdmWXFDSHdU?=
 =?utf-8?B?Zks2eFgyOHNicFhGdGJWbzFuSWFDZUdqbVlBRXR4VUVKdVZHaVdGWWFLOUpx?=
 =?utf-8?B?OTh4bDZzYmdGUHhwRXNFRTdpa1hPNDhKbU8wcmU4MVEvMFQ0THV1N08rSVNi?=
 =?utf-8?B?OHc4RXZwQ1JZeGNYWHoydkFnTjFPQkpSajB2TmhLSnZZSHBUejI0RStwUlR0?=
 =?utf-8?B?U2pYNkRFc09uLytoeHlHTmZZNURXUFVLMS83U3ppTnpmSGxHUnJiWVFSZk9Z?=
 =?utf-8?B?Skc2dDFlMUZ6YllMUncvalNuamdHc3lleUhRUGFKSTVxdzlaZlRRQzBCVFVv?=
 =?utf-8?B?bDVmUDVUZzJ4WGw4TktnYVk0TE5FZlk2WmJUWTZRMHZ4T2ZUc0VsWjZxK0hI?=
 =?utf-8?B?Z2RMRlRoNnYrZWdRMG1zU3RZQjVBVG5zOEFCeVRkeW1oVjdkWFMySTBtaDJV?=
 =?utf-8?B?eEEvUTJOUlN1MnRlREZ1ZUZGa1FpcTNPMXlZNmptaFNSL0F2TkhEZWExSXVm?=
 =?utf-8?B?WDV6NU9mY2RYK0liS1laZVRITTlKRkdEY0RHdk53L2ZlT0Y4WGFaUHFkZTU0?=
 =?utf-8?B?Z28rVU94RE5GNTk4Q2psRWVMS2xaWTVKQWJvRmozYzNpSUhCMWZmSThBVkJP?=
 =?utf-8?B?ZWN2YncxUWl4N24rd3FVZUNGeEwza094RE1NMG1kSTh5Q3p2YXkyRWRVelM4?=
 =?utf-8?B?UUtzaURFZlp6Y281UHY0Z2JpbVE3WHQ2bFBrMEtHbktzMER4RlpYSi84M3VP?=
 =?utf-8?B?SGZIZjFqOXJ3V29QcUY1OStRSEVGVTQ2dENTZlQ0bUdFeGxLVXdzamwycUpB?=
 =?utf-8?B?aVY4ak5ma3FyNXRDeit4V1NzMUtBaWFianR0REpYc0oySkN2MUNOVUQ3VlZ4?=
 =?utf-8?B?Y2VQTEx0VE1jYkhEVlBBMFF6MU5VcXp0YU0yYkZrUVd2a2pLdHpZUTNVdmc0?=
 =?utf-8?B?WEdZZzF4aFJVTkJpSmVLSzBtcVhZNENPWGx0RnNnMWFuZnR0clNsVjR2cDBp?=
 =?utf-8?B?NVptZ0JCdXB0Nm9Hb2Q5ZWhUTkpZSnVpK2drWE13S3QvMktNYVdpZzROWkV6?=
 =?utf-8?B?UjJvdHVhbDZUZGlPMEJldWhySTc0cmJYczRYUi9VUWRVMFJMSWRWbXNkN0tu?=
 =?utf-8?B?dkFxS0tkYmpxa2JsNUhoQWwxdGhjcUF0cE1INUlMaVdBOHpiaDFXb2Q3MFBJ?=
 =?utf-8?B?ekVBRUdGVVZrV05icDRYemhEOWdtaDVxRVVpQTFtZXVCRVBaV28zRzRxSG5r?=
 =?utf-8?B?WU40TG1QTWszOHpZOTI2N0h2TTRFZGpUNjRjeXMxTnJiYW9aaTR3Rlp6U3V0?=
 =?utf-8?B?YWZORzVVRnl1WitrdmRTK0RLV0NRQjZtNzA2WWY2Z0xIZHVBaDJRWmxKT2Uv?=
 =?utf-8?B?LzBQVGtBQ3FzSTUrM3BLNlBLLysvV1YxSTFVZUFwUnNzNXNFN2tNYjJ5TER2?=
 =?utf-8?B?VCtESjZtRElQRXRwVE5MdGhObEFGUzA0WDd3QnQvaGNHeFZod29UcUNTdkZC?=
 =?utf-8?B?bjZJb2p3eEg5RDJWbi9zdDlmN1RaSDRrSDdPMUwzUUVUQjlvRlQwK1B0YThy?=
 =?utf-8?B?STNRSjVROXpjNG0vcThjU1FDY0Y4cVJzdmwxbFg5M20zbU40NUxpS2lSb0tZ?=
 =?utf-8?B?WXpXbDQrcmlXaUJxTnJCY081VkMwYVBTZ2NUVnpxMnYrWVVYOUl3amhidy9h?=
 =?utf-8?B?d0VQNjBxUVRmQ2YwWkNXTkN6Y3R2TC9jRjk2MEpmckt5QmpaakJURkYvSUVO?=
 =?utf-8?B?YU1BdFo1S1hORW9FbVhDdU9Sai9RbWtTOHEvaHllNkM4U2d2cjhxeEg1Vkcy?=
 =?utf-8?Q?uVHXHbtILY4vz1yaYYpMQfY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01566b2d-860a-4b30-000f-08d9b37faa83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:31:55.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tojsDw7+Rzxg+UkF2U+b5uUYIoRhESqSUZpWitVhvNJ1H10t8SSv+3uctWFnsS7rGZrZ4eMiRj8xOF6A34/YQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 10:45 AM, Kirill A. Shutemov wrote:
> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> 
> Switch SEV implementation to insn_decode_mmio(). The helper is going
> to be used by TDX too.
> 
> No functional changes. It is only build-tested.
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/kernel/sev.c | 171 ++++++++++--------------------------------
>   1 file changed, 40 insertions(+), 131 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a6895e440bc3..8fea7ea67c67 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c

...

>   		break;
> +	case MMIO_READ_ZERO_EXTEND:
> +		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
> +		if (ret)
> +			break;
> +

Can you keep the "/* Zero extend based on operand size */" comment here 
much like you do below with the sign extended operation below.

Thanks,
Tom

> +		memset(reg_data, 0, insn->opnd_bytes);
> +		memcpy(reg_data, ghcb->shared_buffer, bytes);
> +		break;
> +	case MMIO_READ_SIGN_EXTEND:
> +		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
> +		if (ret)
> +			break;
>   
> -		/* MOVS instruction */
> -	case 0xa4:
> -		bytes = 1;
> -		fallthrough;
> -	case 0xa5:
> -		if (!bytes)
> -			bytes = insn->opnd_bytes;
> +		if (bytes == 1) {
> +			u8 *val = (u8 *)ghcb->shared_buffer;
>   
> -		ret = vc_handle_mmio_movs(ctxt, bytes);
> +			sign_byte = (*val & 0x80) ? 0xff : 0x00;
> +		} else {
> +			u16 *val = (u16 *)ghcb->shared_buffer;
> +
> +			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
> +		}
> +
> +		/* Sign extend based on operand size */
> +		memset(reg_data, sign_byte, insn->opnd_bytes);
> +		memcpy(reg_data, ghcb->shared_buffer, bytes);
>   		break;
> -		/* Two-Byte Opcodes */
> -	case 0x0f:
> -		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
> +	case MMIO_MOVS:
> +		ret = vc_handle_mmio_movs(ctxt, bytes);
>   		break;
>   	default:
>   		ret = ES_UNSUPPORTED;
> +		break;
>   	}
>   
>   	return ret;
> 
