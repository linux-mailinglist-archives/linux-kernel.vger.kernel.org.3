Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD24BEAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiBUSgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:36:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiBUSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:33:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9E15A19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZsMFupn0V6oIN1Ykzovyn1702cpitZ0EcXkZjCotHvuMP0z9CmI4TTqwdC2PLz0bsjp+bfJ+mMMrQsI+Ghz+XLJAlDzEzRGBQdIqnPKFfMzmH9VXfmlxeTCJqxT7fLtJjcZAzpIJBF3NdDBjzmzcRcHU7DEDGJqr2+qxJqv9qyC86ZBy6OU/AW5h8TEjw0S1BJgO9uflZCeQT1f1mYa9x2VTCG57cJ/MUmuM0MnhjNxVcWqmQs3pVZQJJkUXjmR3c0M95Cr3BExO3FKAveKjMjLsrPnrwKVQaK4XfEU3aGU7sSjxjSo6K6WskWQi1N7ICCbjAQOCajdpnvOUxwzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLP3vGDXYd9fnkME+SAvcCv9zuj9cv+HkN33iKjP1wo=;
 b=AYfghgmhwOjbFmpXB6R9dXqwwoOhWlOnMt/z0TP2V7cPS6/wlDJ+jNrYEcr8/NAJjARXDBGXxrLCrv4sUyHgtYOi5v0mlqaqMGQZ+KBZUTW74qoKzuYRYkLhUNFALpV19BsTLY+sSdvd1N5uk+1mdekK7caj3hnmBXKiOPuTJPv9NClAXaOuKl1yu6+OAHK1JdbkWHMkai1cprbr53ey+uFLf7hxWUyrs1278cFCPjRTuiMOenoKXfLrXPV3lraLYBpxkFNogTBaseVXuV3cfzrco8kF8hqBlssrp9xkSdouLAgeB0pcHjO18wbf4PGR803A8aj+17du0oMcKz65Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLP3vGDXYd9fnkME+SAvcCv9zuj9cv+HkN33iKjP1wo=;
 b=BkkczsvtF7BY17mOHjRyYhk6Dq+Joabx4sKa/yrokkSDgM5C9kZjY6zEWEErlGjvzf2IeDt7X2nAdmPeYQKcBmlIrdHUrFwHZ8Dv058pqlXmDWaLps72PYTVs66368j3Y5v6ql+R3mF4kSNU7AkzreSZCkpABqT/z2eKQ5lIfv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 18:31:43 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 18:31:42 +0000
Message-ID: <0c0a4199-1318-5290-9d9d-43bcb9017228@amd.com>
Date:   Mon, 21 Feb 2022 12:31:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>, bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:610:4f::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da6abe5-b2ac-4b81-4575-08d9f568685e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43775C7655CCC3F477DD0A62EC3A9@MW3PR12MB4377.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+LdvIZ+C1fTxxQp+m8vmq6H/SzrEmcZRV1T0A91UuAtYgpEO5W4dvSJrmnfVlmrwxBCdyyFZ4hMRNYG15THkkGxwIECT5mG+vjHkgSS06XAqP2QlEmFZ0zJX0O2MT6wbTPjjgjcXyYZZNTbMHmjpV9Kk0meiYfhSU+zC2xnf/f1Rnb5RbsTLccIVAClCjYoTIAInuGM8KscKH0IZt5IheRkjgH7gFXsatIcXs/hnwrQt1kX0v7yC6rMYFSpLJKdBFlr459Wwb0fb1qZeyBMSQ5lvTZ/clETL6nW09z2Tqh3Z+RQZmUb5zLzl6e8dcMyFpma1nrYBp85LDmLV1wwdTLAkbAgXs/wUKRF0TJi0Mtu+OvgE+ypWpqtRnHO/5k8Me79nSZwqTojt/piWu8R3w4GfS76TJMiTaoaLm3uomKIbcE6mAYms2KSEp2NO9yj89SFIAeXFWVrYAyMBkdzW+/f4UHnSGGkPhpRGM7IbpzXkRaIK8Oz432V0hm/4SCZVZtOU2nGZd+yIith2RW4gnkh+qBw6+Y6uCL6/nzBJdlgMH+3V4apUd2YDa9NAS8H+yPQOSa0kFxF7h/gZwcHgvYtqU2afpMZmV9GlpZOPRcT83VhawHY4ygojXjyJzqNN9xm/+NzUzZ+Nvw3SU/PsF/o4ULIojRyPGyPfEYhmC+CM4+cxgK8Y5VcNzQBh5LZljWrU/kmvX6aZ0b3DcM6Gp+Yp8X4hyFvatzO9M4/5dWQ7RfYlDiAq1qFOD9RUZM+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(316002)(31686004)(6512007)(2616005)(2906002)(6486002)(186003)(7416002)(5660300002)(8936002)(66946007)(31696002)(8676002)(6506007)(4326008)(38100700002)(86362001)(66556008)(508600001)(26005)(66476007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZubWx0WWt2WFlReEdUZUtDbVBCNEdWNGZwaHhzcG8rNHpOQVY2Y3BvMDJ6?=
 =?utf-8?B?azRFQkljUWV2Ulp6d1V3dEMxa2N0MVpSaHZiOXZHS0tJMytWeGgxOUVyQUQ3?=
 =?utf-8?B?bndkS29EK2VXeCtDV3VDYnFoNnd3N3hFb0pOWXROOFZRbFZWck9SNmM3RFJh?=
 =?utf-8?B?WDRpdWVaTmUrWE12REl0T09JZDJWQUtwRkxDb1VmYXpjZHc4Y2d3WDZ4YTV5?=
 =?utf-8?B?SXJWczNwWGdrSlNrMnBwekZ5bUYxd005K2p5TnFjQ3M3d2cxRDRTek9kcVhG?=
 =?utf-8?B?ZHhaVUhnSnBNYjFCdmdwa0NZM1dHSTBjd0NoTWEwbnR1M0w4VS9jU0dUakFH?=
 =?utf-8?B?RndmamMxNWgxeTRTdVAxMFI4eU9ueURwUHpVZ01QbnJQU2hsZjB5NmltRGNC?=
 =?utf-8?B?RGhPU2hiaVZZcmxRRzhJMzhLOTZVNk1wWGRNakg3R2EwVkN2VnNXSHBtMWRY?=
 =?utf-8?B?OTlmVCt1SVVUTkkxUXZYQUpXcDNXV3k2Qm9pUGRkNVVxbXYreWNSdmpFdW1W?=
 =?utf-8?B?cE9EWWsySHQwblAya1Q1M1A0czRuVUhTWWVGVG0xSnh2aU1zREdzTTZqaEVS?=
 =?utf-8?B?eDB5ckxiTXJXSElnUlBZZlFaZXVIUTNzaTdMZ2c2ZEdMbUxFb2VON3RrWFRm?=
 =?utf-8?B?N3NGVTFhdDdYREdhOEhDUUJPUUxUOTU3MVU0bUdWZWxSd1ZPZnZsSWFWMG41?=
 =?utf-8?B?aGlrSkg4S1NWUlFsTEQwWXo4TktJVitaM0hWOVVtWEltNzZQZmIraTg4bzIy?=
 =?utf-8?B?bEpqeFAwRmpqMDB1ZkFTNUk2LzMvNTlJc3liZDJ1QjlTSm42UkZ1Z0ZLNzli?=
 =?utf-8?B?QXRTYlhkdVlGck1JU05iUkdZaGpGbzl4L2o2L282ekJya0ltL1hrclUyanpF?=
 =?utf-8?B?RW1YdW90d1gvL2hUa1pYTEFsOGhmWDNPejJpZ2x3SmRUVVdhSEE3UllHSFV4?=
 =?utf-8?B?TU9NZVRuaWxuTUQxb1FVSGIxcmNrT24vVDR4UzMzTExIWm8wejU2UmNmanNv?=
 =?utf-8?B?S0k5VjBQT0h3NGsvMkE1ZDFLTmgreXpZQmlDaDlyNFBwMC9LM21GV25LRHNX?=
 =?utf-8?B?ZmNVTmZ2aFhQblkrTjJHQ1ljeU5PQ3gvbjV4MzRQNG5uZXJtK3JCUzhnRSt6?=
 =?utf-8?B?cTEyc2YrRWNVZDFKdTdRMnkreHZyaWZObm8wTE41T1VtS01wb29XTFBSRmJP?=
 =?utf-8?B?dFRtUlE2RmVmcnBDTWhlbkMwVFlpVEQ5QUQyTTh0clByL2dMSzBCaS9mZEpr?=
 =?utf-8?B?dm9yNjJSYVRtTFRuWk92dTAzZ2FaQVlIM3NHMGlMeVZZL2VpblE2U1dBQTdG?=
 =?utf-8?B?b283dDZGRk1Mb09qS25vZUFHUUV0N3d3aUY3Ym5hZzVlS2RtcmV6dTlkbk1L?=
 =?utf-8?B?NEN3bmpvQ1dDd0E4VmM3QUJhRXFiZmh4aW9oOTlxaWNyVWhDVm80WHJFaDdj?=
 =?utf-8?B?WS9Hd1VzcjljRG9mdkMrMTl4QkFOMjN2bDF2WktKYVVVQStRNzRiUWJhSTg0?=
 =?utf-8?B?dkc3VVAzcHppZHVaeVl5azBnR0djaUYwWURydU9WYXJZeUx2cnJBUU9FWGpu?=
 =?utf-8?B?LzUxcjk2NmQrMERXVXZxV2kzencwSFc5bFNINlkwNFFrMGJKSXYyOUZBc3NE?=
 =?utf-8?B?dWNkWkxzWFBFUG9NcWJjQUgxYmNjdmZ3L2s1S3RYekNWZ2x6QkQ3NXhTVDN2?=
 =?utf-8?B?azl2bFJOd0ZLbFlGUDVtc1BTRkE5Q0FDT21NVEdqbjFUeUNxWEN4U2lxaCtG?=
 =?utf-8?B?a0lhaWtnLzBaWTZxZXJHcGROYVlDRmRRV2U2azNBdzJjUCtmQXB0ZWlFUjN0?=
 =?utf-8?B?WTdKSmRhUUZmLzZXblMrTFBiYVJwUklpT3gycnpMeStEODc5Vkp3cFZKU3Jt?=
 =?utf-8?B?VXlZR3BBU1ljbW9BYktQcmErd0Y3bWhqT0VSMGpKM0tJUHBMU1dIOGNHYUU5?=
 =?utf-8?B?emNyb0R2NVVjTkNzb3NsMTBnM2xpbytXNW1YT1RNMVE1MVYwSmtJOTF4a2p2?=
 =?utf-8?B?cHlZbTlacUhUcEpuK1I5VzRMN0hOS2lEL2hVY3FNZzcyMWxrNnhEL0xRNFJU?=
 =?utf-8?B?N3JEREdaT3V0L0U1dFlPelNvZHN1RnM3akdIZURrelc5S1FYcU15N0x2NElF?=
 =?utf-8?B?d3djZTRiL0lvVSsyNUcyanRRaXBUMmpWemgvY0NIODkxVFJLUUxIU0pUUmlu?=
 =?utf-8?Q?mWJ2+GqmBP+1F7zT4z3lCuw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da6abe5-b2ac-4b81-4575-08d9f568685e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 18:31:42.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcOwpZpyDjrdBxdaEFzWAP6m/kenmZo0fA0Qg7geyAeTHXKxbDnHuU58CspypbuU+z8cgHvP/cMnUWrzXlQTUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 18:13, Kirill A. Shutemov wrote:
> AMD SME/SEV uses a bit in the page table entries to indicate that the
> page is encrypted and not accessible to the VMM.
> 
> TDX uses a similar approach, but the polarity of the mask is opposite to
> AMD: if the bit is set the page is accessible to VMM.
> 
> Provide vendor-neutral API to deal with the mask:
> 
>    - cc_mkenc() and cc_mkdec() modify given address to make it
>      encrypted/decrypted. It can be applied to phys_addr_t, pgprotval_t
>      or page table entry value.
> 
>    - cc_get_mask() returns encryption or decrypthion mask. It is useful
>      for set_memory_encrypted() and set_memory_decrypted()
>      implementation.
> 
> The implementation will be extended to cover TDX.
> 
> pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
> cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().
> 
> HyperV doesn't use bits in page table entries, so the mask is 0 for both
> encrypthion and decrypthion.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> @@ -84,7 +85,39 @@ bool cc_platform_has(enum cc_attr attr)
>   }
>   EXPORT_SYMBOL_GPL(cc_platform_has);
>   
> -__init void cc_init(enum cc_vendor vendor)
> +u64 cc_get_mask(bool enc)

I was a bit confused by this name, expecting to always get the mask, but 
it is dependent on the input parameter. How about cc_get_operation_mask() 
or ... ? I'm struggling to come up with a good name, but plain 
cc_get_mask() is very confusing.

> +{
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
> +		return enc ? cc_mask : 0;
> +	default:
> +		return 0;
> +	}
> +}
> +

> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index eb7fbd85b77e..fa758247ab57 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -603,5 +603,5 @@ void __init sme_enable(struct boot_params *bp)
>   out:
>   	physical_mask &= ~sme_me_mask;
>   	if (sme_me_mask)
> -		cc_init(CC_VENDOR_AMD);
> +		cc_init(CC_VENDOR_AMD, sme_me_mask);

Since you're adding the if statement, you can probably wrap the adjustment 
to physical_mask within the if, also (I guess in the previous patch). Not 
required, though.

Thanks,
Tom

