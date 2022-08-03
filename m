Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B824589454
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiHCWRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiHCWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:17:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A333A16
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH91NxLsVzthvufFYf4gm08w6HkXJhBOXd4tyGuqhhP9ia3Jv2T0gqQ/e7N5mDBgASJYxY8erUMYgDTzxM3jRgMD7FKZoyAJX1yz+RDOh0rKxrw1Ke/cfHQfRrlgJtl8bys51LW8UuxXyeo/38OntknzR/gGzaPxlv0z1rgK6BgZ9OgLGladh4WlaJHW6CDWaLASLvDWtoG1rNAG1WZ7AQh8E8PGmLSmj7eJTQyDU8yt5Y3CSBFJxU7DzP6ya8G1+sjGyYRzRIJiKIlRUmnlvAI4rkDjej7PwV1OH99Xm33LknTxhnumbacje3bRCsl9LzYzD17PNXSrWQQAzllZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBw84SmyyqFiDTXBN6Hf6HWkz/pg30BP+Wyoi3ucCq4=;
 b=eOrDQYc+ZFB5147L3MXQNhatwCO1xdKWlb/R2qUvPye/0i/qL3SYNxWqyWtyNv4s9IgrNDN5459tj0SP475zswnPP17VFBzPoEzffMX+rDMcmrfa/Fj+PoYRFN1lpXygd3IuTvmSFfEj9NdoVtiRn5fvHk//5iqn4l3kUnFCa8Hv84Kq+g5gcJsxKrN4dBN+SXhux7aRftii4SAW1+bF3l796D6/EgKEN83Ssl8NfnBtnHIBdWeGwdY2borXm1z9TitUH9aJSaMM9Lx9IZz1c6214AfzIsNe4SpBASlv9lI/0VE3hrSjqa9p/AKJP56oUym5u+vztB5sJ55ZV0/ZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBw84SmyyqFiDTXBN6Hf6HWkz/pg30BP+Wyoi3ucCq4=;
 b=CPGmij9/1lLz7OLlGxP68e8ORoPGYp1r6J0LftijJH13wNPfs1XPHKkACjk19AOHj1w4ZxB0J5NYz8W8YH0ejASPed0w5pzuQNf+jfY/2ANeWIoGGJkLDtDmr1g3xFi78SiKpT3LoTxgR4f2+MHQuyAtxmJrh43tfAD/YQHmdq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 22:17:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 22:17:08 +0000
Message-ID: <6ce25644-6e0d-868f-01f9-2b9dc4c95ab5@amd.com>
Date:   Wed, 3 Aug 2022 17:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
 <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
 <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
 <3cf239c8-ccc4-d112-fb42-605661816cf0@intel.com>
 <b33876b6-96bd-afe0-3523-b51b8628616a@amd.com>
 <6b492245-f25b-1019-0728-7c77a54a7540@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <6b492245-f25b-1019-0728-7c77a54a7540@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:208:15e::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e271af37-d3c5-4f58-457b-08da759de795
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeqS+z0arlpQqxYx8XEYe7fV5sntzH0CqpwxLKJ0a/VlEhDAUuBv7XKvf1FR5frXkHGvPxO5Rt2EGy5y3cV1uj7/b1Fapa7Ny1UssEW6BGTrJL0btvIYriIPr7D728gO8wl2xden+1/Ji6GI7mr1CbpUU0se5rj4xM63l0tDb87M+aMRC/ETN8cB8D27MMLAzuDsKsMZh/dkN0in5527fvtnBW5PZlnmTnH4tMxMKjh2/SpexmI7QUyRULHQlX49fNpnqP/4YUwRdQB47TxdfxV0SkGWx21TKogEk1IKTVygVBIzLsHR4lfLfDL3n2jNjTUAmmIusTqA4zZUqHoB6tTC7Qow42Cxs5nvS5GFVj64vh8AGQwNJlOY1hSjzPcL17oz/zx4Dyrad4eRghGPI3/r5DzvJ8Kvwh7Gk2z8ruQo0FqgZoY33D4yc7GxNUsKZGrY0xEzNfFeaG/vgPT+Q+p25XyKcoeN6gRsaIpcKE2iHCdUYc663BqJ7p6l2fWBtnJN7uxYiZIfsyOUCN8wqOU/9wOfZcgHJFDIbtQXxVgjtFFaZnnVDsnh05vTb5ScjljH7tV/zqJLA+czECAIde93OMrIpwV9vgp9b/UlZmsThDblhoCYao+/C9Dx3/PpD0VMtYDJvltGYjlCsWCHZYa9E87NFx2tP+z7NGXWmZKx3qmru+SFKenTao8DS04T93aRPy8/k/fgTspI2TYsdhMgtIwALmnXEtkduqQcgZWCBLd22wex/63HK2fkwuIKF/wp6XjlcTS2ZCunU/+pqOEaM3rPYyl7lOFSY7ZaVEylFVHi7X3Vwk6IVmyHZjiDLjivPY0nWX1bV4tmX7LQQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(8936002)(7416002)(31686004)(38100700002)(26005)(54906003)(53546011)(6512007)(36756003)(2616005)(6506007)(186003)(6486002)(83380400001)(2906002)(316002)(6666004)(4326008)(5660300002)(478600001)(86362001)(41300700001)(66556008)(31696002)(66946007)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pEc3V3dWQyTHN0VEZpbk5nd2MvSWlVcmRhSlRkVEV0YytVSEFHdU9YOW96?=
 =?utf-8?B?VXlvMTcxdUFuVVBPUS9JRFozV3dFaFJMalZ1ek5kL2g2MkZ2a3BIcHJLRDlR?=
 =?utf-8?B?V2pPZXBTMTMzYUFtTkplRHRVNFdYVzFlOVhxZFpsZlZtYnpxeTNWU0hPZk1L?=
 =?utf-8?B?THdQTDVVak5IYnRabEIxQW9WUUk3d21qTWdXS213SWVMQlpINDk2THErY0sy?=
 =?utf-8?B?UHBtVHF3TC94aEV0YWl5V2Z2UmJQbWxmNEJ2b3RmejZMVkdZa0hSWmpDYUlm?=
 =?utf-8?B?bjJMSDRsVjAxUlJkeWR1WnppbkJMNnNsTXUveTNZVk81L0JqN2FrTURiSzE4?=
 =?utf-8?B?bUsvNU1yR2N3Wk5kZ200NHZOb292TEZLV3NpUnJUUFdxUURHWit0bWRBT2Ir?=
 =?utf-8?B?Wk10TGdLbFFxaVp2MEYyc1dycmtjQUJnTVV6cXZmaExDckM5TEI4d3p0VUF0?=
 =?utf-8?B?dTVnZEFpdU11USthM2pHbmpmclNNTmVpcXFDZVQ3MzFGTlkwZ3piSUQ3R1Y4?=
 =?utf-8?B?WnJEMUtoY25weG95S3M4TEFzbTh1QUVuazJ0RmcvMVVEd1JQazMvMEJOTkZz?=
 =?utf-8?B?WVJSSHlBSEwwVTVLUWx1UVl3ZnZhU2tQV2JJN3NpUVhkSnFxWm16SFhXMS9T?=
 =?utf-8?B?WVZMYzYxSlg1c2ZTNktlSDdCL1NmUnYwY2hVbXRGS1FBOCtyMUZ0YzNNZkw3?=
 =?utf-8?B?eHo1Ym91djhyTHBXQUtCd1JWTHpQMnhkYk9kZVNsd0FzWEhnQ2JhVU5adE5h?=
 =?utf-8?B?Yi95NjJLNE5KeEJKV0FJQWJmV1BackJqaTJjSHVmYzhJWkxuRGgxaFM2NEpv?=
 =?utf-8?B?RWxHOFo4cWFOTXR6VmN3UHVpTmdpN1ZEU2kzL2hZQnAxYWVkVXpvWGZaSEJX?=
 =?utf-8?B?aHk4cFNDSUhOVnNwWW9EYllPODdHTG9lUXYxc3dKYjM5QXRQYU1SK2kxYy9I?=
 =?utf-8?B?U2hiNWVkTnVMODkxbGFjczBjWm95a2NTa3A4ZXdPTm1DNWJ5OEROOUVsdjNs?=
 =?utf-8?B?cUlnN1FtdUhVOHQybjd1dVpVYUpPRWlIei9uOUtyVnFPNWd6aDNNNzBPZHBa?=
 =?utf-8?B?c1VvOFJJTGF2aFdnZDg3U2pMTkpwNTFCTHRibnl6K2JLWk14dTNOaW5ZWEQy?=
 =?utf-8?B?ZTZHV0VWa1A0U2pSN0V0Q0VpdFArR3E0WE5mdWNoand5TjNkeXV3R1lRb2JT?=
 =?utf-8?B?bW5tUWY5enpIM1FxSU52L3I2N09QM202ejlvZ0k0Zkc3Y3B6R2ZabnNKMC9m?=
 =?utf-8?B?clFHWGxYY1h4blgrdXprNEpKamdOUHlyM0dmRnpaSnpaRzJTZFkvYkJONTRl?=
 =?utf-8?B?MERXQUd2Y2RJcW11S2F0MmUvS1ZGc3UrZk9EcmpjejJZZ004SUJpcjhRZWVG?=
 =?utf-8?B?RzZySFM2L3FQZENGTXJqdHE3YUsyUDd4R1NXR2djUEd0SlhOOGFFNWthbTNy?=
 =?utf-8?B?Mk5YTGMvcUVHamxqcFFDVEt3ZStmb1ZLOG5qb0pDZk5DOHdnRW5rWVl6RWZU?=
 =?utf-8?B?RHlRVXg5T1VEWGhFNUVVajhBa3dNMDNOcTA4aGwwQ2VJdTNqM0wrZUgvd0sy?=
 =?utf-8?B?S1R5NmhRejE1WlE0TGlFZzdVSzh2SVkxYVRBMWh4My9EZGRRZGVORXVBMmlh?=
 =?utf-8?B?QU1sNXdSb0Q2K1psTlZSS29lWkg2UWJYdFVOTk9CVDZZWFdDOWcrZTQ4NlV2?=
 =?utf-8?B?ZHZUbU1QVndaNjFVYUltdER0NWNjcXFrWEVScUY4QUVmVXlXR3Rwb0xWK2Yv?=
 =?utf-8?B?NkZHMTFVVDN3TFByWjlDbk1DcktidEluZ2ZLclFhdUgxN25CNUdIV0l2NFNv?=
 =?utf-8?B?Q1M3UWt5cGJZc3JkTW5VZzFaVkc2SGNZUzNacndsRU83NDcycFA3aFN2K3Rl?=
 =?utf-8?B?QXpGUjlBS1F1cHlTaURQNnZXTDhUNnU1UDNsK3hCaWJOcG9ZQWZOV3RyaTd5?=
 =?utf-8?B?Q3lBYzREdnFxbkVGY3pKd1JqVS91TVRvUERESzlmbFRpck5RNVdlZDArRCtV?=
 =?utf-8?B?bFQ1Nlp0dTAzK2F2U002eHRzdTRUV1lFQ1NkZFg3V1N6Y2RLazBIcFlpdEhK?=
 =?utf-8?B?dVNPVE9BNVd4K3lHMHJRSnE2QW5lTC81V21JN1ZkazV6Z0EvNlFMUUtLN2x3?=
 =?utf-8?Q?uvj9JXUNIQ1m7fQ4yQyGayXpA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e271af37-d3c5-4f58-457b-08da759de795
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 22:17:08.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkpGCl9GxmL5IMbde2jnqBjTE6NNTIquoXdouayDEoSkmuTuoIimjAoCRkT8vnar8Ho9CS/GV4FsrtOJiUmJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 16:48, Dave Hansen wrote:
> On 8/3/22 14:34, Tom Lendacky wrote:
>>> Also, private<->shared page conversions are *NOT* common from what I can
>>> tell.  There are a few pages converted at boot, but most host the
>>> guest<->host communications are through the swiotlb pages which are
>>> static.
>>
>> Generally, that's true. But, e.g., a dma_alloc_coherent() actually
>> doesn't go through SWIOTLB, but instead allocates the pages and makes
>> them shared, which results in a page state change. The NVMe driver was
>> calling that API a lot. In this case, though, the NVMe driver was
>> running in IRQ context and set_memory_decrypted() could sleep, so an
>> unencrypted DMA memory pool was created to work around the sleeping
>> issue and reduce the page state changes. It's just things like that,
>> that make me wary.
> 
> Interesting.  Is that a real passthrough NVMe device or the hypervisor
> presenting a virtual one that just happens to use the NVMe driver?

Hmmm... not sure, possibly the latter. I just knew that whatever it was, 
the NVMe driver was being used.

Thanks,
Tom

> 
> I'm pretty sure the TDX folks have been banking on having very few page
> state changes.  But, part of that at least is their expectation of
> relying heavily on virtio.
> 
> I wonder if their expectations are accurate, or if once TDX gets out
> into the real world if their hopes will be dashed.
