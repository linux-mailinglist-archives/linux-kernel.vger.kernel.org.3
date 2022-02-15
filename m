Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA054B7168
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiBOPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:55:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiBOPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:55:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDBB9E57A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:55:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhtmoesgVM7rpMkdX7FW7c3XJdrI47c7zR5EoThpwZYzdPqEwFZKO+Z4bbZSlUwHnFMK0J2PpGRx87kj8QZI3le1S2Z4V4gvzqpcWQ2yvTfQ5px05AwI2PwH96Gx1VTXu2zKKiOZ9iiEDmBz1hd1lA44lC6GO2GZ31As+hnt1hl6BXr0WdOvYBcTNrKR7zSWBWzVTro4Ix8SzybPNNTeQTrQarYkT06eWQ5uZxGi1vvwyuFuutpkPG9/B2Zo1ISHz4PbUc6VfxI86NJbiJnfnuoJhhKARMZnp+MN4K3sdvrBSsRfzxHDlrLIm3glhEojcv1Q2sT04M/ttNCiLa+Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaYR4KDmPPndEVbOkA3IK3zsU9jj4yeDHJbAqOVnmK0=;
 b=YAzHNEKLhI8YKDcgTeBs5QkFTPs31Rc6aIF6quxRAoyQoZ54z0fa9FpMuaBRMx2TM6subHZPuwzFbDQXlpXJRuxvHuX92qN79amCwTbVz+htaYlfi73C6ddZ+FNE4sD0GIOH/MDkWIvrhYU6lJYwQ+aFqOOwc7DNvPqr8ttW2baMlPdOuDau21RN9/tS4vYfw0xkNL6eU9QJELEcSCkZYH9H0Iz9+3ItPHxyMEeuQSz65EVsUF5GXX+7dhwoqZtEKO0hDoGEzSAf+px4VJiGYpmvwSE7GnaD6v3/BRhEbZsSsNXTu9wbzt+ZSX/lVA6//XZeI5vWn2oNj6pRINVAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaYR4KDmPPndEVbOkA3IK3zsU9jj4yeDHJbAqOVnmK0=;
 b=iHm9AQbmt5fbRgsc2huTMLP9THmKj43dP8S6pvRecQkV+Z+nxdOFaaWT60snFgu77/0kkN9lUJQSZAfKsSdKPONd4lEpNOCkxNuXciZxz4u/qfxocaxWMZBKwEWUvNbH+O8iL4S8nO24hi3kRqUhKF+a329c9eJCxsIm2z3KM/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 15:55:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:55:20 +0000
Message-ID: <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
Date:   Tue, 15 Feb 2022 09:55:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic> <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:610:55::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd0a0e4-0c24-454b-1bdb-08d9f09b912f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42835B3F18F8DC3BD1239C3AEC349@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMU4JoFhNkUlc+AVLRf/j/2qbYry2n1A7JFMi3JJ5QuCHCXbXVTqYZx/Ca48pD6xGHT3NvC/TXJ5VWfIodT6xsU4BW0DdQ0i6wUXUp+Qn++LNX/kx41LbY1bdLB1+s+GakVTRDWj98VM/8i/JpaEuUQzVYHfkb+7R83aRyM1KB2/ny/uqbKm5Vjfv3KEsWc8kpwEyLMfcFhvkVf7aqXBOkiRSmFo1pQM+IoyGVzn/CImtlw1qRVyeFu/0BVEsUWGIV9UZP21D5AfgiGasFnBgMYGI3ea+mUxw2DAdk8MYXwFOitDQIHqV83ORyxpeseP2ELci1qMWRixtr3kXikPF7/FqdKtfhcJxlVFo0hQ0adkd8TOIlcScSxWTVbQcsPEWUuqq8bzsv117T+zTn91kXJ5EVEchLEkXfjgeo/4Qzu0kaJEBHS1SrIrgX5G9QbiBRcx3AhO6bbe8nfdRNlmJtvN11pWLIyc/u3J7CrKFTj8q+agTUEoXCyn26ILkK3tRaUAMbXtKYLARGIsJBiG9Hc1IhT8+bMAwX5PhTMRfotXuNt3stSsrVApwnGhAUBj4oM543AmuMApAx1VoEQeOuru8VhyIyvEhjgJ93Gvrt+zyWKsdYpf9FVxg4NChN5c9njWsBVuE5dFPfwogDT6soakZNq48qWzkzS5DfXVnacVdrslKYcvrPwlGztATa38hROHLm9u/FhE5lCKEpfBv5VfFaEXCHdDNKhRxbRNd5EHxPWJ1RgN4u/hNVXyxwB/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6512007)(53546011)(6506007)(83380400001)(2616005)(186003)(26005)(508600001)(31696002)(8676002)(6486002)(66556008)(66476007)(66946007)(36756003)(31686004)(86362001)(8936002)(6916009)(4326008)(6666004)(316002)(5660300002)(38100700002)(54906003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHUxclpTa2ZmMWZTMTFpaXNXZVBwY3lCblJjcVZGVXVNMC9uU3BZWTkvNjVR?=
 =?utf-8?B?ZTduYUFqaHRUTXJmWm83YVZESVBWS21sU0NhV2xWcWYwYkx1aVVacVZvQm9t?=
 =?utf-8?B?NSs3VEs4NTgrUDA2NEJldWlyckJPLzBiaEpqZUw1Qiszem1NMlozdzB4cWtG?=
 =?utf-8?B?M3lxemJxbEtmZW5FVE9YUlNpU3VkQTRyaW5SZU5MNEVlVmdhMzBwbi9Wejha?=
 =?utf-8?B?Y1F4WlNVZ0RncFl6VFc0NXFsT1pCbGx3RlZaOVhhY01EcW1yMHpZMWZWbTVJ?=
 =?utf-8?B?aXZ1TTNmS3FsWk1mT2d2RThVL2xjQ3QxUDIzeHVXdjgwcmNFdzRsQlBaZS9O?=
 =?utf-8?B?NTlGSWpnNVZFelk3U2NRcnVnTWp6WVkrOU5tYU44SjBqRG94djcwSTdHODhh?=
 =?utf-8?B?WmIrWnYrTE03VnNSSHovL2tqZ2VSVGg3L2F1eVFNZ2paV01UQXVLZ09TYWdo?=
 =?utf-8?B?TTNXWSs5VFAxVDlENlpoRlc1T1piQVBtNnRFTStDQUI3dFJVZzdRZytpTDV0?=
 =?utf-8?B?S2NHSFNVVWl3aDdaVVdpcmg0RlZJYmNEcnVudjdzM0g5VGIwdTNvNXZYa2Fo?=
 =?utf-8?B?bnNSNUpMZjN4MTh0S0hMczM0aTNINU5PVjhYbEJRTGlJbE0yQUJoSFk1c1J2?=
 =?utf-8?B?UGMzU0lPWEtRUStrODVFRG4xVWdrYnh0S2J0ZGxGMk15ZXdVT3c1MzhNV1gz?=
 =?utf-8?B?Tk80TDExUk5xclN2eEowOW0zcTI5eTgwYW95SmdXTWJ5R0k1eEFyVDMrWFpC?=
 =?utf-8?B?SFVNeTFyQ1RLOHpWSE16NmRyTmtLYXJpZW1wNXdUYWE4MkEwZTExN2RuL3F0?=
 =?utf-8?B?Ym0xbXhDY3dPUnZaUnRxSnloVElIYlMrUzJPNWlBc1dkZ29SK3N4QTlkeFZ0?=
 =?utf-8?B?bGF0L0FDUlhuUlRkZTY3dSsxZXV1dFhqQ2NJcXI3VmlCV0pIeFF1VTk4aWdv?=
 =?utf-8?B?ZjJZUktGY3pFS3VwNHl2YUszN2lvNlNmQm1pZnEwVi9SM0RTVTlJSkhiSXlo?=
 =?utf-8?B?YllvOFZqdWRsZ01kY3hoT3ltcmdKZktFRHUycm9iMDZ2dXBZLythWWExTGlw?=
 =?utf-8?B?UHNKNU9xNFJGYmJ2ODRUMzkzMzlNaElIaEJ4cFlSeGxCNGQybWluSU1IeVF2?=
 =?utf-8?B?dERHRlY3dUpwc29lK3VaeGNqUE9pVU1HeUcvdEladUxLRWwvU2VRU210U0tu?=
 =?utf-8?B?bm91UWRncU5hMk96M2ttYUVMVkt6VStNWTlKSWxURTFTU2JUYWgrUjlhcG52?=
 =?utf-8?B?WFdQU1NOS0F4eWpVcHUyZVpDaW8wcHp6UkcwZHVHM3VaQ2VNMzFTUTNHcG5i?=
 =?utf-8?B?TWRCbnBOZU01NkZud3VrRDQzTVRGaEVrakp3QjF2RVU3MkdWeHRXb2JnWlFn?=
 =?utf-8?B?MDRFeFpvUC8veWt6SFFMZ3l3SjJ0RllZZEcwell1eWtEYjVTZ1Z4Rzlzbk5L?=
 =?utf-8?B?dW42UDU2OXFMRjRpd3ZvTk8yL0E1NDR2TkdPc3NpeEJiTEJJTCtid0VQaHVC?=
 =?utf-8?B?UG9FSk1iWjMvMFZyRGlTOEZ2Umg0dktFT3lxd0V0NDQ4alA5c0ZHRE5ESUZW?=
 =?utf-8?B?QUFvYmc4MS9KRkRMQkNHcGd3RnozMlVpNitPYVdKazFxdEtrV0N1SWpxMWJj?=
 =?utf-8?B?QnJyVWpqVVcwUlBGbzJ0VzdoT0VPQ0dvVzVNT1ZOSUdaaHpmQUo5QjlhVWZQ?=
 =?utf-8?B?T2pzUkdpSm0zY3dydW8ybUZleC9qSUlRQzgwVm1MaW1KUmFHYk93amRDQXkv?=
 =?utf-8?B?eUo2cGgxbmVlZjVpdGRaTXd5Zkt2aGJ1K0phbUVwQzJtVmRzUEFCNGNqZ2hz?=
 =?utf-8?B?RENNVlA1OUszK2V2cVJJdVhtYmczYU9FNlhHclEyclNNMUk4RXN3YWVIVHJW?=
 =?utf-8?B?dTZydStHNi95ck5INlNvT0tKM1ZncC9ac0t0bUk4amltY1o5MjBkZTRKMjFV?=
 =?utf-8?B?NmVUTUNuQ3FYT0MrQVYxMjR3dkxpMGROK3V2TnlQNytheFRkNVRjaW9aUGd4?=
 =?utf-8?B?YVNaN01TTnUvZVZEVVBzQjhMSnZ4bVJGanBHMmJUdlo2MElnV015QzhQbVhl?=
 =?utf-8?B?TVVqVFJCcFBIWlNRN00vUUpycFJBTXlCVjJJckxneGFFMElCN2h4akRSeThz?=
 =?utf-8?B?ZkNBdkl4RmtiVzc0MzVkcHpabEk1Mkp4NDdTcWJueVArdmtjekZCbGxTdWVV?=
 =?utf-8?Q?zSImJL6G7/G4nTE+o3N/DtE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd0a0e4-0c24-454b-1bdb-08d9f09b912f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:55:19.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5jJe3pu7m6QjGpXMp98KKRG6Q0AClbxMTv03ittsWnRsr4fnJWiSfAwqaOaidLBfbr0b2gUkNybHDomW73pmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 09:41, Kirill A. Shutemov wrote:
> On Tue, Feb 15, 2022 at 08:49:34AM -0600, Tom Lendacky wrote:
>> On 2/14/22 16:09, Kirill A. Shutemov wrote:
>>> On Mon, Feb 07, 2022 at 06:28:04PM +0100, Borislav Petkov wrote:
>>>> On Mon, Feb 07, 2022 at 08:57:39AM -0800, Dave Hansen wrote:
>>>>> We can surely *do* this with cc_something() helpers.  It's just not as
>>>>> easy as making cc_set/cc_clear().
>>>>
>>>> Sure, that's easy: cc_pgprot_{enc,dec}() or so.
>>>
>>> So, I've ended up with this in <asm/pgtable.h>
>>>
>>> /*
>>>    * Macros to add or remove encryption attribute
>>>    */
>>> #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
>>> pgprotval_t cc_enc(pgprotval_t protval);
>>> pgprotval_t cc_dec(pgprotval_t protval);
>>> #define pgprot_encrypted(prot)	__pgprot(cc_enc(pgprot_val(prot)))
>>> #define pgprot_decrypted(prot)	__pgprot(cc_dec(pgprot_val(prot)))
>>> #else
>>> #define pgprot_encrypted(prot) (prot)
>>> #define pgprot_decrypted(prot) (prot)
>>> #endif
>>
>> A couple of things. I think cc_pgprot_enc() and cc_pgprot_dec() would be
>> more descriptive/better names to use here.
>>
>> Also, can they be defined in include/linux/cc_platform.h (with two versions
>> based on CONFIG_ARCH_HAS_CC_PLATFORM) and have that included here? Or is
>> there some header file include issues when trying to include it? That would
>> clean this block up into just two lines.
> 
> Well, pgprotval_t is x86-specific. It cannot be used in generic headers.

Ah, right.

> We can use u64 here instead. It is wider than pgprotval_t on 2-level
> paging x86, but should work.

Hmm..., yeah. Maybe unsigned long? CONFIG_ARCH_HAS_CC_PLATFORM is X86_64 
only, so 2-level paging wouldn't be applicable when an unsigned long is 
64-bits?

I'll let the maintainers weigh in on that.

> 
> But with u64 as type, I'm not sure 'pgprot' in the name is jutified.

Maybe cc_mask_{enc,dec}()? It just sounds like cc_{enc,dec}() is actually 
performing encryption or decryption and can be confusing.

Thanks,
Tom

> 
> Hm?
> 
