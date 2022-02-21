Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA4BEB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiBUUFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:05:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBUUFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:05:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6022BDA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Wgrsv6zVUnLwNXQ0E704w9afno0Oye584bJ3fQrzlq+9Vl7Si41Nb6gf3VOvgqke8XwSQbYs+uOs9loX+yrwsbJ0buH6C97mobAHGifqyClWyiIr3wuilmV7tYmhfZHrWWdeDzbjWOiNFLY2Pv2wUvLAivlC5/NT0dhiMtMEjyJeJf7AU7nBkNjOm2TKmRJ66Up7QpocLkp7ST1gftbHPfE5d4cUfETX+WsGoumOC6JeZtK3zwuqqZtLptdPYmsJa0wy1yWWVAJ9e9is563ui5OLX3yLxlqOFuyvXnQJ3zhWxkgSATm8jWSZYdjWMtzqHpdDPUZsuj68Of/r+NIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRGQ5zWFxQ7n4BDvuz6/Z61xjTYnIMqB2eACUV1TZts=;
 b=BT0prp6scFLbQV86b2rYIRnuHxjnPQsPmC4I7hr5R1RkyT+8o/ECsqV6Lh1JCcZFHM5awPJA+EL7LVABo9+2KeaF8HbYgkPwnIEIphT1JK2xPLV8zGuDAL/oulR5nn+OZj0MHirCgXkzXUeIKc2pmUBrWycaUDkgLdYRDzT8y6JgMbxjYtcr3mBoG5SL6pgZwo/D5NuwrJfQODGkIiH1fTcqS575deJ07il5Lo6imxC3WSsN3uW7la9MgFJiEWJjREICg/1n/2Hi9+fihKt4+OnLhco+3UaMwJtXyCD3Pn4gORcBC8/0WYyJSOZ5i9fFxzGb/M+BF5mX37Gf402gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRGQ5zWFxQ7n4BDvuz6/Z61xjTYnIMqB2eACUV1TZts=;
 b=uakONlo8NmtaGm07K8lUQL14S2Ul7p9cHsQLKKcRLkX1wAoW7gFlC/fBh+bhc75hC6e4JqG/sUVg9j6H02lM/vC3T4Ahem3MkIy1DTgZgv64fhfck6P+MCs75vH7+RfFXmAo20gyD1MQIgW64J12j0H2GWCD3xhMV7M1Stl1pJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY4PR1201MB0248.namprd12.prod.outlook.com (2603:10b6:910:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 20:04:37 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 20:04:37 +0000
Message-ID: <8bb2e660-f92d-a501-57ea-61138dafed28@amd.com>
Date:   Mon, 21 Feb 2022 14:04:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3 16/32] x86/boot: Allow to hook up alternative port I/O
 helpers
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-17-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220218161718.67148-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c151431-3f0c-4380-2245-08d9f57562b9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0248:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02484E2839A46E00C30E8FF8EC3A9@CY4PR1201MB0248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHGD8xFJe5oXyp6jtJrqztrBoMHkNTzxB/Xz7+zMc8Me94go5j5D0oQR8QPrIAOYoyWWkFrQWyXLptS5Z6G0utIc3JF6Y5D0KkSRIMvKaq99pwem4zveCLV9U2PlDw+wqyw2+kzwWUjFdynKdMY1xQLnMNjIDYnv5jUOaxi5K+gvzJ4z90bIBRmiQ8V1C6vz4Mfgu1J0wCtRthZ1GVDtkOeDhLkuvsXrSH4TPjJAqvQPOGWhjjUHpEKIXsNa6IcvB5G1Sslpl6dgJoUL7OkzV3NQUCnJPwcFXWGbzF0BkySq7hGy3IlyX3zuG0C+6nxufwOV+lC0RVfXgWN14KwiySpblXtFGC/2UC7/pd9Xdw8o56CaqB6sEpS+fFzf844YDcIy3OvAamEp6dcVPTNqUDED/05KK/uhhdoAiHYXEPhVUClVlh8aTdDXNXFHRJbYWRbFlXgVZUwjE6wECQI47aX+FlVtXTSqLBpeLvqysrT+v6bgX+Ph/FgxiouC3Yw4Xa+nnOy4KWXbBagnbyKp5zcKA/K29BqdYdInnxsHhOW9tkhp5X4EGxPlxPGZhw+l81qYIp5mpNWXTf7EzS4xAWIWNjGt0J+GUy4teEtCDM6R3MN6oQrtImNIIaPKvQS65FckaH7w2Lpod2p1Uli9MnnxndQrs0N8uzEfFKIohcyaMefivANAp6qwTQczl4dgHABmCJeXujSWdHo7XXKBEhSsf/bhtFgzardW9y5gjYPfjCi3KRcqZ4T87yaxK90dQWuU2dlsK1+RKZVZYDiYS122vLJs3lAPD8oTubkmaz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(30864003)(38100700002)(83380400001)(36756003)(7416002)(5660300002)(31686004)(2906002)(8936002)(6506007)(26005)(2616005)(6486002)(53546011)(186003)(6512007)(66946007)(66556008)(316002)(508600001)(31696002)(8676002)(6666004)(66476007)(86362001)(52103002)(158003001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlENklVV1BmNTJnRUo5c24yTTRYNDJRQnY0Y3FTUS84MXNxUGJFRTlSRkZO?=
 =?utf-8?B?WjVnRDJPUlVRRDkzTkxtY0dQdHIvN2sxUXBTVy9vRzFLcGxCUmU3bm9vc3Fs?=
 =?utf-8?B?YWszSVBXS1dyd3FCR2tyRjdyR3B1S0x3NzgwTUxPcUNjYVhPNEs0T0lIVzFC?=
 =?utf-8?B?UDl5UlA1TXUvQU9qeXltSEdrUDVxU05pM3hzNzNTWXh1U3k5RGh0VERxMGl1?=
 =?utf-8?B?YlRmMVZ6bjBMZ0dMaU13dVIvZzFLTE5kRmpPNFFrM01UOUQyWU12VjA5OHhD?=
 =?utf-8?B?WXdzUjhHcnNRSzhoODYwWDBiTUdPQjZwSHp3L2JMdUNiOTRVQ3JHT3pyVUsw?=
 =?utf-8?B?dm16VkplN2RnL0tGWFp5OGdtYXdCVFl5U0JQM2FHWkRqNUJnVFVhbXZTK1Bw?=
 =?utf-8?B?YjRLOXJBV3BlWXdGMUp2TlBUK1B2N2JMSUZqNUY4eEZ3L3ZTNVdYaDJUNjF0?=
 =?utf-8?B?QmpDbHA1UVUvaVMrMDl0aFYvVnRtWTFlelNtNEUvY2NHd0NIOUZhNEtmM1Q0?=
 =?utf-8?B?T1FERktIekpOazZkcDlWUmd5a3hra2ZhRTVNZDNxbDhoVE5iYnRPZkRBb1Qw?=
 =?utf-8?B?UDlJdHF2bER1QmtFai82UVMxRTZGcWJLc0w1S2svQmQwVzFvRVhtV3FpYlVK?=
 =?utf-8?B?WTl5VlJQelpBRkZnaDF4SDRQUUdBakY4TklJd05kMkd0RlpSUFVFc2JDMmk1?=
 =?utf-8?B?VTkrUHpTTkk5Z3R5Q21sVWNHN2hMakgzNmQ3Y0kzelVremRtN2dZOWE3dnor?=
 =?utf-8?B?RWhiUEgzcUIwK1Q2RTAyZWU4SjVKeW5XNnlsVGFkL2k1dzVkQUpXZTFKZyt3?=
 =?utf-8?B?T014aGZnTmkwTS9LeUpOMEdPS2pUU1ZBdWxMUGtXT2gxaXpLNW4wamxSVFgy?=
 =?utf-8?B?WEhaMEVxWU5MN0QxQXNxWTNYekFOck1jRGoxV3BIN1NWSWVYMzN4SlkyNFk1?=
 =?utf-8?B?QXRlU1FzVnlJUWtLZXdqOGNkb2VOTGRkT3M2OUxQVWU3TENreTJaTDNpcFZ4?=
 =?utf-8?B?M0dyZm4rZCtDTzZsRHRNNnBvRDBxakpRc282a2RPMFAwbmZQOWh2WkdsNDhK?=
 =?utf-8?B?MXFyekNlUmF0Nk9Mcm5lSGtuRHpFMVJmSzlHaytpdnQ1a28xZU1pUXVNNkgx?=
 =?utf-8?B?Rkk5Y2RZWWtHcFlvM0Q4QnZCRmZ1eHg4R0xjL1IwRGJlQWN3WUJuNEFpZWxz?=
 =?utf-8?B?OFBTa1Fhallrc0pIb3pYNFBqeVJ1Y3l4RWNKRXZnWUpyK1N2UlkrUWhqRnh2?=
 =?utf-8?B?M1hnTUhUaVhmdTRTUEl6a0E4a3QzZ0IyT2NMQ0s3a3lISXpXY05nYWRpUlhk?=
 =?utf-8?B?cHN5MDh4aDE0MDdrU2FBUk5oUTN6QlNVcjJmdVh4aUg4TnBBQTI0aVhJdE8w?=
 =?utf-8?B?WFlYVkZOVlY2eUMwM1lUZkRZZHQ2MWdla2wvL2MwcTJHVktnTERYV3VjN0R3?=
 =?utf-8?B?Z1luZ2JLcEtsQWkxdHVFQWlyMkREMXA4VlhocURiUkJQM29sOFBUbTQxYWhU?=
 =?utf-8?B?czBodEpSbEdKZWZsd1RwK3ZYSVl1YXJkY2FPVk1ZZ1E0M2xDMEFxOHc1bENJ?=
 =?utf-8?B?NUxLMFVBSjNweEFDbUlOaU0reGFweXlieXVZMVRYT3lVVFhsa0hpcjlZaVRS?=
 =?utf-8?B?bGRFNEVCWkJDS204U3dka01jZTlVc0dYU1V3cGdmOVJvd0tPWFBVS1psRG9Y?=
 =?utf-8?B?cUlHVElMTzFHa0s5aUQ1NWlkV08zUTF2b1BqdVNEdjZma3YrWG51YWYxYkc4?=
 =?utf-8?B?SkpvQUROMUljNjZoV2FHTll3Y0RBSis1QU4wNEJOS25sd1lkYWxQTXZWSk9N?=
 =?utf-8?B?Um1xelJyVHdvZDhMSUVVNEl2cy9iWjVaVHViT1pRSDlZV1BRbi92S3NDS0th?=
 =?utf-8?B?L0FBdGNGNDA1ZFFOM0hDSHpERUtVUXhYdUh4eXFIYklxamd2KzhIMUpOYTgz?=
 =?utf-8?B?MDN0ck5XWWRQQ3VKZGhnZmcrY3hPUnB1TE1QU0Z5bkpuZklaNG9QL0RIcVJ2?=
 =?utf-8?B?Vm5yVkY2WDdObWpMNXRDMG95QnJGcjI0eHNkaEpmSmtCeWg1aHpyTDF0QXNM?=
 =?utf-8?B?NWFzVlNUcFU0a3M5VjJzU0lsNThWVlpxR0ppUjdXZlJaTHJkcXQ4ZDN1Slh0?=
 =?utf-8?B?a21GbjhkbVhRWjVKbjJ6elNMYkVDUEZYUGwzN0tTSEhSTHVLL1Z5U09Ddmdu?=
 =?utf-8?Q?69zdx0Xuf5voCTk9htgCBOk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c151431-3f0c-4380-2245-08d9f57562b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 20:04:36.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suV51UYly2sjJT7C4kXGZRNABbi4ebqTiWxlR9LRCijs3j6n0dynow53ZKBd9aDifnNstZzocQUnFNpIvfMx/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 10:17, Kirill A. Shutemov wrote:
> Port I/O instructions trigger #VE in the TDX environment. In response to
> the exception, kernel emulates these instructions using hypercalls.
> 
> But during early boot, on the decompression stage, it is cumbersome to
> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> handling.
> 
> Add a way to hook up alternative port I/O helpers in the boot stub.

This seems like a lot of churn in order to get this all working without 
taking a #VE. How cumbersome is it to get #VE handling working in the 
decompression stage? Can you build on any of the support that was added to 
handle #VC?

Thanks,
Tom

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/boot/a20.c                  | 14 +++++++-------
>   arch/x86/boot/boot.h                 |  2 +-
>   arch/x86/boot/compressed/misc.c      | 18 ++++++++++++------
>   arch/x86/boot/compressed/misc.h      |  2 +-
>   arch/x86/boot/early_serial_console.c | 28 ++++++++++++++--------------
>   arch/x86/boot/io.h                   | 28 ++++++++++++++++++++++++++++
>   arch/x86/boot/main.c                 |  4 ++++
>   arch/x86/boot/pm.c                   | 10 +++++-----
>   arch/x86/boot/tty.c                  |  4 ++--
>   arch/x86/boot/video-vga.c            |  6 +++---
>   arch/x86/boot/video.h                |  8 +++++---
>   arch/x86/realmode/rm/wakemain.c      | 14 +++++++++-----
>   12 files changed, 91 insertions(+), 47 deletions(-)
>   create mode 100644 arch/x86/boot/io.h
> 
> diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
> index a2b6b428922a..7f6dd5cc4670 100644
> --- a/arch/x86/boot/a20.c
> +++ b/arch/x86/boot/a20.c
> @@ -25,7 +25,7 @@ static int empty_8042(void)
>   	while (loops--) {
>   		io_delay();
>   
> -		status = inb(0x64);
> +		status = pio_ops.inb(0x64);
>   		if (status == 0xff) {
>   			/* FF is a plausible, but very unlikely status */
>   			if (!--ffs)
> @@ -34,7 +34,7 @@ static int empty_8042(void)
>   		if (status & 1) {
>   			/* Read and discard input data */
>   			io_delay();
> -			(void)inb(0x60);
> +			(void)pio_ops.inb(0x60);
>   		} else if (!(status & 2)) {
>   			/* Buffers empty, finished! */
>   			return 0;
> @@ -99,13 +99,13 @@ static void enable_a20_kbc(void)
>   {
>   	empty_8042();
>   
> -	outb(0xd1, 0x64);	/* Command write */
> +	pio_ops.outb(0xd1, 0x64);	/* Command write */
>   	empty_8042();
>   
> -	outb(0xdf, 0x60);	/* A20 on */
> +	pio_ops.outb(0xdf, 0x60);	/* A20 on */
>   	empty_8042();
>   
> -	outb(0xff, 0x64);	/* Null command, but UHCI wants it */
> +	pio_ops.outb(0xff, 0x64);	/* Null command, but UHCI wants it */
>   	empty_8042();
>   }
>   
> @@ -113,10 +113,10 @@ static void enable_a20_fast(void)
>   {
>   	u8 port_a;
>   
> -	port_a = inb(0x92);	/* Configuration port A */
> +	port_a = pio_ops.inb(0x92);	/* Configuration port A */
>   	port_a |=  0x02;	/* Enable A20 */
>   	port_a &= ~0x01;	/* Do not reset machine */
> -	outb(port_a, 0x92);
> +	pio_ops.outb(port_a, 0x92);
>   }
>   
>   /*
> diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> index 22a474c5b3e8..bd8f640ca15f 100644
> --- a/arch/x86/boot/boot.h
> +++ b/arch/x86/boot/boot.h
> @@ -23,10 +23,10 @@
>   #include <linux/edd.h>
>   #include <asm/setup.h>
>   #include <asm/asm.h>
> -#include <asm/shared/io.h>
>   #include "bitops.h"
>   #include "ctype.h"
>   #include "cpuflags.h"
> +#include "io.h"
>   
>   /* Useful macros */
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 2b1169869b96..c0711b18086a 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -47,6 +47,8 @@ void *memmove(void *dest, const void *src, size_t n);
>    */
>   struct boot_params *boot_params;
>   
> +struct port_io_ops pio_ops;
> +
>   memptr free_mem_ptr;
>   memptr free_mem_end_ptr;
>   
> @@ -103,10 +105,12 @@ static void serial_putchar(int ch)
>   {
>   	unsigned timeout = 0xffff;
>   
> -	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
> +	while ((pio_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 &&
> +	       --timeout) {
>   		cpu_relax();
> +	}
>   
> -	outb(ch, early_serial_base + TXR);
> +	pio_ops.outb(ch, early_serial_base + TXR);
>   }
>   
>   void __putstr(const char *s)
> @@ -152,10 +156,10 @@ void __putstr(const char *s)
>   	boot_params->screen_info.orig_y = y;
>   
>   	pos = (x + cols * y) * 2;	/* Update cursor position */
> -	outb(14, vidport);
> -	outb(0xff & (pos >> 9), vidport+1);
> -	outb(15, vidport);
> -	outb(0xff & (pos >> 1), vidport+1);
> +	pio_ops.outb(14, vidport);
> +	pio_ops.outb(0xff & (pos >> 9), vidport+1);
> +	pio_ops.outb(15, vidport);
> +	pio_ops.outb(0xff & (pos >> 1), vidport+1);
>   }
>   
>   void __puthex(unsigned long value)
> @@ -370,6 +374,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   	lines = boot_params->screen_info.orig_video_lines;
>   	cols = boot_params->screen_info.orig_video_cols;
>   
> +	init_io_ops();
> +
>   	/*
>   	 * Detect TDX guest environment.
>   	 *
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 8a253e85f990..ea71cf3d64e1 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -26,7 +26,6 @@
>   #include <asm/boot.h>
>   #include <asm/bootparam.h>
>   #include <asm/desc_defs.h>
> -#include <asm/shared/io.h>
>   
>   #include "tdx.h"
>   
> @@ -35,6 +34,7 @@
>   
>   #define BOOT_BOOT_H
>   #include "../ctype.h"
> +#include "../io.h"
>   
>   #ifdef CONFIG_X86_64
>   #define memptr long
> diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
> index 023bf1c3de8b..03e43d770571 100644
> --- a/arch/x86/boot/early_serial_console.c
> +++ b/arch/x86/boot/early_serial_console.c
> @@ -28,17 +28,17 @@ static void early_serial_init(int port, int baud)
>   	unsigned char c;
>   	unsigned divisor;
>   
> -	outb(0x3, port + LCR);	/* 8n1 */
> -	outb(0, port + IER);	/* no interrupt */
> -	outb(0, port + FCR);	/* no fifo */
> -	outb(0x3, port + MCR);	/* DTR + RTS */
> +	pio_ops.outb(0x3, port + LCR);	/* 8n1 */
> +	pio_ops.outb(0, port + IER);	/* no interrupt */
> +	pio_ops.outb(0, port + FCR);	/* no fifo */
> +	pio_ops.outb(0x3, port + MCR);	/* DTR + RTS */
>   
>   	divisor	= 115200 / baud;
> -	c = inb(port + LCR);
> -	outb(c | DLAB, port + LCR);
> -	outb(divisor & 0xff, port + DLL);
> -	outb((divisor >> 8) & 0xff, port + DLH);
> -	outb(c & ~DLAB, port + LCR);
> +	c = pio_ops.inb(port + LCR);
> +	pio_ops.outb(c | DLAB, port + LCR);
> +	pio_ops.outb(divisor & 0xff, port + DLL);
> +	pio_ops.outb((divisor >> 8) & 0xff, port + DLH);
> +	pio_ops.outb(c & ~DLAB, port + LCR);
>   
>   	early_serial_base = port;
>   }
> @@ -104,11 +104,11 @@ static unsigned int probe_baud(int port)
>   	unsigned char lcr, dll, dlh;
>   	unsigned int quot;
>   
> -	lcr = inb(port + LCR);
> -	outb(lcr | DLAB, port + LCR);
> -	dll = inb(port + DLL);
> -	dlh = inb(port + DLH);
> -	outb(lcr, port + LCR);
> +	lcr = pio_ops.inb(port + LCR);
> +	pio_ops.outb(lcr | DLAB, port + LCR);
> +	dll = pio_ops.inb(port + DLL);
> +	dlh = pio_ops.inb(port + DLH);
> +	pio_ops.outb(lcr, port + LCR);
>   	quot = (dlh << 8) | dll;
>   
>   	return BASE_BAUD / quot;
> diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
> new file mode 100644
> index 000000000000..8a53947ef70e
> --- /dev/null
> +++ b/arch/x86/boot/io.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BOOT_IO_H
> +#define BOOT_IO_H
> +
> +#include <asm/shared/io.h>
> +
> +struct port_io_ops {
> +	u8 (*inb)(u16 port);
> +	u16 (*inw)(u16 port);
> +	u32 (*inl)(u16 port);
> +	void (*outb)(u8 v, u16 port);
> +	void (*outw)(u16 v, u16 port);
> +	void (*outl)(u32 v, u16 port);
> +};
> +
> +extern struct port_io_ops pio_ops;
> +
> +static inline void init_io_ops(void)
> +{
> +	pio_ops.inb = inb;
> +	pio_ops.inw = inw;
> +	pio_ops.inl = inl;
> +	pio_ops.outb = outb;
> +	pio_ops.outw = outw;
> +	pio_ops.outl = outl;
> +}
> +
> +#endif
> diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
> index e3add857c2c9..447a797891be 100644
> --- a/arch/x86/boot/main.c
> +++ b/arch/x86/boot/main.c
> @@ -17,6 +17,8 @@
>   
>   struct boot_params boot_params __attribute__((aligned(16)));
>   
> +struct port_io_ops pio_ops;
> +
>   char *HEAP = _end;
>   char *heap_end = _end;		/* Default end of heap = no heap */
>   
> @@ -133,6 +135,8 @@ static void init_heap(void)
>   
>   void main(void)
>   {
> +	init_io_ops();
> +
>   	/* First, copy the boot header into the "zeropage" */
>   	copy_boot_params();
>   
> diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
> index 40031a614712..4180b6a264c9 100644
> --- a/arch/x86/boot/pm.c
> +++ b/arch/x86/boot/pm.c
> @@ -25,7 +25,7 @@ static void realmode_switch_hook(void)
>   			     : "eax", "ebx", "ecx", "edx");
>   	} else {
>   		asm volatile("cli");
> -		outb(0x80, 0x70); /* Disable NMI */
> +		pio_ops.outb(0x80, 0x70); /* Disable NMI */
>   		io_delay();
>   	}
>   }
> @@ -35,9 +35,9 @@ static void realmode_switch_hook(void)
>    */
>   static void mask_all_interrupts(void)
>   {
> -	outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
> +	pio_ops.outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
>   	io_delay();
> -	outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
> +	pio_ops.outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
>   	io_delay();
>   }
>   
> @@ -46,9 +46,9 @@ static void mask_all_interrupts(void)
>    */
>   static void reset_coprocessor(void)
>   {
> -	outb(0, 0xf0);
> +	pio_ops.outb(0, 0xf0);
>   	io_delay();
> -	outb(0, 0xf1);
> +	pio_ops.outb(0, 0xf1);
>   	io_delay();
>   }
>   
> diff --git a/arch/x86/boot/tty.c b/arch/x86/boot/tty.c
> index f7eb976b0a4b..ee8700682801 100644
> --- a/arch/x86/boot/tty.c
> +++ b/arch/x86/boot/tty.c
> @@ -29,10 +29,10 @@ static void __section(".inittext") serial_putchar(int ch)
>   {
>   	unsigned timeout = 0xffff;
>   
> -	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
> +	while ((pio_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
>   		cpu_relax();
>   
> -	outb(ch, early_serial_base + TXR);
> +	pio_ops.outb(ch, early_serial_base + TXR);
>   }
>   
>   static void __section(".inittext") bios_putchar(int ch)
> diff --git a/arch/x86/boot/video-vga.c b/arch/x86/boot/video-vga.c
> index 4816cb9cf996..17baac542ee7 100644
> --- a/arch/x86/boot/video-vga.c
> +++ b/arch/x86/boot/video-vga.c
> @@ -131,7 +131,7 @@ static void vga_set_80x43(void)
>   /* I/O address of the VGA CRTC */
>   u16 vga_crtc(void)
>   {
> -	return (inb(0x3cc) & 1) ? 0x3d4 : 0x3b4;
> +	return (pio_ops.inb(0x3cc) & 1) ? 0x3d4 : 0x3b4;
>   }
>   
>   static void vga_set_480_scanlines(void)
> @@ -148,10 +148,10 @@ static void vga_set_480_scanlines(void)
>   	out_idx(0xdf, crtc, 0x12); /* Vertical display end */
>   	out_idx(0xe7, crtc, 0x15); /* Vertical blank start */
>   	out_idx(0x04, crtc, 0x16); /* Vertical blank end */
> -	csel = inb(0x3cc);
> +	csel = pio_ops.inb(0x3cc);
>   	csel &= 0x0d;
>   	csel |= 0xe2;
> -	outb(csel, 0x3c2);
> +	pio_ops.outb(csel, 0x3c2);
>   }
>   
>   static void vga_set_vertical_end(int lines)
> diff --git a/arch/x86/boot/video.h b/arch/x86/boot/video.h
> index 04bde0bb2003..87a5f726e731 100644
> --- a/arch/x86/boot/video.h
> +++ b/arch/x86/boot/video.h
> @@ -15,6 +15,8 @@
>   
>   #include <linux/types.h>
>   
> +#include "boot.h"
> +
>   /*
>    * This code uses an extended set of video mode numbers. These include:
>    * Aliases for standard modes
> @@ -96,13 +98,13 @@ extern int graphic_mode;	/* Graphics mode with linear frame buffer */
>   /* Accessing VGA indexed registers */
>   static inline u8 in_idx(u16 port, u8 index)
>   {
> -	outb(index, port);
> -	return inb(port+1);
> +	pio_ops.outb(index, port);
> +	return pio_ops.inb(port+1);
>   }
>   
>   static inline void out_idx(u8 v, u16 port, u8 index)
>   {
> -	outw(index+(v << 8), port);
> +	pio_ops.outw(index+(v << 8), port);
>   }
>   
>   /* Writes a value to an indexed port and then reads the port again */
> diff --git a/arch/x86/realmode/rm/wakemain.c b/arch/x86/realmode/rm/wakemain.c
> index 1d6437e6d2ba..b49404d0d63c 100644
> --- a/arch/x86/realmode/rm/wakemain.c
> +++ b/arch/x86/realmode/rm/wakemain.c
> @@ -17,18 +17,18 @@ static void beep(unsigned int hz)
>   	} else {
>   		u16 div = 1193181/hz;
>   
> -		outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
> +		pio_ops.outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
>   		io_delay();
> -		outb(div, 0x42);	/* LSB of counter */
> +		pio_ops.outb(div, 0x42);	/* LSB of counter */
>   		io_delay();
> -		outb(div >> 8, 0x42);	/* MSB of counter */
> +		pio_ops.outb(div >> 8, 0x42);	/* MSB of counter */
>   		io_delay();
>   
>   		enable = 0x03;		/* Turn on speaker */
>   	}
> -	inb(0x61);		/* Dummy read of System Control Port B */
> +	pio_ops.inb(0x61);		/* Dummy read of System Control Port B */
>   	io_delay();
> -	outb(enable, 0x61);	/* Enable timer 2 output to speaker */
> +	pio_ops.outb(enable, 0x61);	/* Enable timer 2 output to speaker */
>   	io_delay();
>   }
>   
> @@ -62,8 +62,12 @@ static void send_morse(const char *pattern)
>   	}
>   }
>   
> +struct port_io_ops pio_ops;
> +
>   void main(void)
>   {
> +	init_io_ops();
> +
>   	/* Kill machine if structures are wrong */
>   	if (wakeup_header.real_magic != 0x12345678)
>   		while (1)
