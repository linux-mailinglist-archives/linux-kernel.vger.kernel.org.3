Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC34AC0FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391063AbiBGOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391016AbiBGOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:08:35 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B961C0401F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAGbmdjwLzOuEEUibP1iPBRso0z/Ef/9eYi96SwwzaP9Gr4a7Pf8zeDEf5OXT85VTXuYf5kO4conCDjJT5Ee8+9C3z8cye6HOMEER1Y6hjuh1S7q+8LGwzkqJClSYdK7TCD+vdIxhizU4i60Utn+AS9J/Uzh0iHb2JNp77aU8f5tJDyqlPl+GFnXOEoebbNZAZUV0U/CK1+enO/khh+CJdY3qNURhIS0nH9rs38iCHWQEYVCWBuU8ETjWV/GNAZX+djuNKV8Ayw5/QXqYVEObH9+/lZWstpZGIanEG8eDcMepqCzbpOaRRjBxLMdRUP7iBHoFXpTZbZ1IdchQ74XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYMfBfu3FYWtNzL30FI7HuisMpHBQE0rBdpzOve3j/M=;
 b=aCPVQ3KE6pqOdGN6nrbqX/sWBZn+racRLTOilg4vQpbDsuP4Bes6brIzWi61aRlhaiXtxxjMxeYoOqmx1/Jima6mh+09xG/YrDTROT5wGQoOf7dYZrx9FA+Qn94k5JDg5zGn0Oe8L8XNH4Pi9qKUUFFKXHMSzMIZcSf9X/LdWe1mXCiocFccO00QV9ykPvhK1qrNoDC6DUOs+4b3x96OyvxGqdEKzZB4m2mbaF6GsmchZycTyHgSwKeKZ25GsuQRQuwDxtbAeuiTKYbcrKshQ6GS/wXVptncaN+EFDrg8Sh4/3qddP4g/Y3Z8hpkBLRsNuGxaifWHoSP5iUBtvafeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYMfBfu3FYWtNzL30FI7HuisMpHBQE0rBdpzOve3j/M=;
 b=j50c/8HweS9yZYQGvJabCkyqw8BIGbvV4pOUPRs8iA4kK+F/Bj8Ewox8pF8eKor8MEYck5+LNpjhlMrpuJLWawLxvl9P6SRE8s2haDQuUyDF/NL4f9E8j0v95JBvEUuNyhD1TZREHDmEqWwDnyJTBce2qqWntpn3kfEa0Q3AjSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 14:08:19 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13%7]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:08:19 +0000
Message-ID: <95d1475e-fc30-89cf-19a7-4f125f5113d8@amd.com>
Date:   Mon, 7 Feb 2022 08:08:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 26/29] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-27-kirill.shutemov@linux.intel.com>
 <871r0mvyqr.ffs@tglx> <20220204223153.l2g3lpm4hxknwsof@black.fi.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220204223153.l2g3lpm4hxknwsof@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8450e3ec-7a77-4c7c-0b34-08d9ea434a8f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4239AE229EAC34DE7E6F767BEC2C9@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Lm2z/2wMXstqOXr1Pd81VB7WDHBbty2P8M/bCBtNb3wUUG8+NLUj+c+x8lbK6OM4HB6+O+CEfPw+z84fXbmShlL05H+yv/N/YukrHZIcwvoTorekkt/qc4Qk2p5bdboJwRUNff9xpaH6EiDuNOcbkDb1H0QOxJE4banvvMzWs1Z/qigTD89ZMxXBFurArqGjP9IrWhLzov13fihNzgEzEkBelPwnr2LyigHldT3xLzzzG6s/3uviKDJBK19O/PGLj5jcz31Zo/RdBj3rGdOatfPFv8gkod5njs20oQCcDWfLkenwbE3ojWRHBOLkeRojfhR5evMDAij/QEWL6YRc+Ks+ukpOHBXIxyGYSQqCcfEpFsc1ZBAsrquTveFtEf+M0uKwNxIxofhYg/UdHcGIi1fqh2N1aXv6O5Oelysl+ocXszXGEQkEQFn6xBgiphJfWUqtZzhnZr3woi+ak5c1OofPHOWI12wWBfws9/8NcEkMvh5nZjooOgX9ZorZ2pd8WDIhj80KPbwDIGW+/rFSSHcvlw8ayDANIFlqjUKl7ddIwSs3oSV7ZK9GnVvw+Vxq9GzqiKgT4veyGHPbaXI5/3qsa6N+sDlGFp9McnzKYaF8RoDiyNdRu8urEMpRFzjalxPEwakqbssE10s6UTVRjvZW3Vg7bFzYRbG4q6Q9m9hWCZ7RLZtVQ+4QDza7Dbw4H22Q/CLmgGAVJK534AEpNSCemH/grIJ4GuhYMebmsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6512007)(86362001)(2906002)(2616005)(5660300002)(186003)(83380400001)(26005)(31696002)(7416002)(36756003)(6506007)(508600001)(8936002)(8676002)(66476007)(6486002)(38100700002)(6666004)(66946007)(31686004)(316002)(66556008)(4326008)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXd5WXFza01OVXRrempKcEhZeGUrOVowS1U1VkRvRnJDejdyY3JoWG5lQ0Rp?=
 =?utf-8?B?RFRrWjdiMTBRbUY2QURHOWhTYXdBYzlReEo5SDZPTVBZTTZ1dUxGOVlHMWdS?=
 =?utf-8?B?Y2psWnQvYjltUFZGM0U1SjVtb1JzOU9kR2FHKzdISnNTZGQyVTF5cnRYZGFE?=
 =?utf-8?B?Z1N1WnFIaHFjbFNFZU1FTVVML21md1lDUWh0UWxEZEJpalZQeW05VURkYURI?=
 =?utf-8?B?MVFhdmJCb21HdkI1UGhMcHd3T3djbDJiUU5rMDBCNWI2U2JZcnA2b3VCZ1p2?=
 =?utf-8?B?UXJCZ093UnVNOE1xL1kzV2xvWUNqL09UckpBdjZmZ2ZuOU5USVc0MllDZGF1?=
 =?utf-8?B?NHhIaVVPU05YTVJXWnRHOW84dGdYYzMxQURnZFhpWFluY3RsaEhyTmt4NmtF?=
 =?utf-8?B?TU1wYTlYVEM1RFVpbjQrSzA0MFJoWWl3ZXV0UnN3Ykt4RFd4V1dmVDB0cFc0?=
 =?utf-8?B?THZHTlhpbXV4eDh5ZC9iMS9EMUZNTFgxV0xVNDJEMkwxUVFLRkFlMlk2c2FC?=
 =?utf-8?B?Z0U0Y0pQbnRyRUIvZzV1VHorRDZSY1hZQzZiL3FDaDZVK1VOOU5pZGlFQWdl?=
 =?utf-8?B?YnpObEo1SlA1aXl2RDVwQi9BTlZSOWNNT3pucTIrUTlYUmI3LzdvQ3QvZUxB?=
 =?utf-8?B?b0hzajVaYmxCOEw0dTFBdGo3UmQ1RGpFN0lmM1NhMmR2S1NqRDA4cldQRHNw?=
 =?utf-8?B?VEhjaUJxRXpOV2dkaXM0QkJ5cGdDb1pubVI5ZUc2Mi9tYmEwd3RvaDhXZXZO?=
 =?utf-8?B?SzJaaEw3OE5CZUNUTXpuT3dvZEJENzBqd1JVQW1GeEQwMXZRWVIrTTNFbmxS?=
 =?utf-8?B?eXltRzF0WDZBTTlaeS9QMGNaVTJ6MjJvWVFnbGxqdWFZSEhWWTNpa05ScnEw?=
 =?utf-8?B?a2JaZHJYbi80Mm1JOW5qUk1sZk9rbHo1SUJJWGN6WjZENmprQndhc1labFVQ?=
 =?utf-8?B?emo0dUtHS0ZLSkZOTXZzVHZhNTBLKzA1VmdlcGtmNnJFOFZ3RWhSZU1CZVJm?=
 =?utf-8?B?MjRUa0xrU0VsZHFrdUt2TWxGN2NnSVpxYXNSais4TFVJQlZKZ05ZU3NYTnps?=
 =?utf-8?B?eVlyS2VyQzhZSlcrTEVEb0QvSkRkZHI3ZDV5K0s1R25SUHZqaVF5d0c1UjJR?=
 =?utf-8?B?ajhOdm5tNHRLQmFaTm9Fam5MVXZueUMzVU5IN21iRUNoNHRLUHNxK0JPT29w?=
 =?utf-8?B?ZnNrRzg2K0RMd01QcXI0WUo3YWJUUXFZVTkrTWdwcUFVdlZiaU45QjRMQUdV?=
 =?utf-8?B?UzZUdnFsaW5ITlhwWVozaS9ML3VJSkhTckdTRGZtYzVoOUhJZW5aMFBGSnpG?=
 =?utf-8?B?NXpIb0U5cW5zVXNQenhEeU5tWXpCN0VKSllsMVRGaytUcGc0SUF5TUFsRTlE?=
 =?utf-8?B?RjZ5OFZ4U2VSWWs3SXRqVUc4TGdRYy9xQS9JZW1HTjFiTXlhdHdxL3FYQ3Jx?=
 =?utf-8?B?Y0hpekdSSCtITXdvai9aUENmS2IrNmJVSytGMG5QcHVaMHZDclhxUGRGL3Fa?=
 =?utf-8?B?UTFaK2Erc0tMdm5MSjcrMmJYb0dhQklsZmw2MHNscEdzZklEQkNndlU3ek8w?=
 =?utf-8?B?dWdVSGE3Tysvbm1QSmZSK3ljVEVPRFVicG5wcHQ5VUxvRExwWW1YM25pVG9h?=
 =?utf-8?B?OWpWTnpWMnQxRGptR09oZkw0b0dqM21obHdteWh1ejJTUGtPa0JYeTJxZlRi?=
 =?utf-8?B?MEVERkdTWFBtbCtSZ09LMi9pV0hxTE94VnNWeUJZNWIxK053NDFMd0dBK1lP?=
 =?utf-8?B?VldxTUhLRXlGYXhycmk4czc1U3BKd3gvcnR6d29naWhPNS94OEN0WVA1Yk9o?=
 =?utf-8?B?WVBaLzhIakZSVUZnNW1lak9sYXhpd1hQRmtUU0NBSEhIZlZTU0Y0S3F1akk4?=
 =?utf-8?B?YmtMRzlTc3g1RXZLcVowVzhYbHRhK3RLUWdzUFh3Z0hjOGFVdE9ESVh2SUlw?=
 =?utf-8?B?ZE1IdVlxamtFOVgydWhKMzg1ZVMrVUdraGJGaXJFMSt0WlU0dDZsdWV6ZUxa?=
 =?utf-8?B?a1IwV05NLzVwUDJQT1U0WXZkQkRkcUJUeWltWEVkWVdqeHg5RGNGbjhLYXh4?=
 =?utf-8?B?UVdEMDIyb0xrbUlidDhTbUdydFI1Q2xnNWtyNllCSWVaWWNreTVDNFZaWFE3?=
 =?utf-8?B?WHRJOVJzbjhmRU9HOGNxR25NZ3JlME9STlZmUmZwRFE2Mi9iODlCa1J2ZUlT?=
 =?utf-8?Q?qqWhKeR59zLLvt+NYIohR40=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8450e3ec-7a77-4c7c-0b34-08d9ea434a8f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:08:18.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3OBMyaqNVVQOVZuY/xaUXf08GqcLStnhqC0M253wNJ0hfFfdg7Kq/50A7y9J3kNBvP3n3dyig5gpD2cWFUFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 16:31, Kirill A. Shutemov wrote:
> On Wed, Feb 02, 2022 at 02:33:16AM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>>> ioremap()-created mappings such as virtio will be marked as
>>> shared. However, the IOAPIC code does not use ioremap() and instead
>>> uses the fixmap mechanism.
>>>
>>> Introduce a special fixmap helper just for the IOAPIC code.  Ensure
>>> that it marks IOAPIC pages as "shared".  This replaces
>>> set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
>>> allows custom 'prot' values.
>>
>> Why is this a TDX only issue and SEV does not suffer from that?
> 
> Hm. Good question.
> 
> I think it is because FIXMAP_PAGE_NOCACHE does not have __ENC bit set so
> the mapping is accessible to host. With TDX the logic is oposit:
> everything is private if the bit is not set.
> 
> Tom, does it sound right?

Correct, FIXMAP_PAGE_NOCACHE => PAGE_KERNEL_IO_NOCACHE, which does not 
have the encryption bit set, so it is mapped as shared under SEV.

Thanks,
Tom

> 
> BTW, I will drop 'if (cc_platform_has(CC_ATTR_GUEST_TDX))'.
> pgprot_decrypted() is nop on AMD in this case.
> 
