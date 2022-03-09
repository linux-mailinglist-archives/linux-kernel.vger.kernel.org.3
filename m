Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56D4D2AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiCIIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiCIIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:31:26 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60126.outbound.protection.outlook.com [40.107.6.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2610FE416
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbABCA/OchszCCwY3eiK9D65+pw7Oe4Y3zM1+tblDXtNcifeujrQzkFEDsdfn7Q9b2kK/AeA/ZYG9qhKyTIATdBmsJVMFNtktKNJXwfSAM9yj/iunVbO+9Z+BCpPmMSdofPQ9qpi3dSi2Vdt7uC0LA+/LfX/SOiga+1eCvxsPQAGQADeUMNTIntcIe3JY4ULcmyFtGhZI1mls7ImBGHxed7Mpl7gwUiDipQiJUZRYSoPoEsSf397yMiqfsNuyw2zlr4s/ag2CwLZunTBHAUl5FGyhkY9JORUqJu11GNkY2zeFBuPmLejQSwV7jn7nCXW6UObdeqooQINcWQDN4NrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNlANKuiHwgRY8fBNFZS4kxkAeS50m6grGkHEOcUlKA=;
 b=Zn3lDX7qFPPb4Jg18AsoGDtnrTURlE5zQIrSxAyQJNZ1pK/O8+o/AJfVBCQ0RgUi4fjSWbc/TSoILDDxHr0mk40Qsonc6XLy2GoQvjfjit+Zt+9aayoO154aP/Cqp0iEQjixfi9rDfD/QszjpbyOvDSACUuM+HYoflkIrmiaZlozeZeKQ3PUn1ondrUsc6HtICZsNC8qBrMZyKxzBIdO2OnKjEOyu9X8EmvYE250RUEmtoupYfRzfRuYT8L6JbfDhNb5qKVthSLUMYDULdgJ/8jEC0jXTDCf0dZ3fczjFYVoinE9/vtsbOagCEkuY/EOosq8p38Nv9NpEcAhrs0KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNlANKuiHwgRY8fBNFZS4kxkAeS50m6grGkHEOcUlKA=;
 b=a4jvDM5OjLL9L/oT0ifLrPTxM0+xKoQPQSJoDjDt3spw6mkuRr25LaQoiQ1UodTydkV5PcxmNDxhPibYI1vQVUjytPGAXtQICKhERLo98q5y1syy6lqQ6Y9B4wXaAR3jXQmsEXrZR8BBJQKRsZX+Y0EVBVX7lx5SdyFLf7L2EAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR0202MB2975.eurprd02.prod.outlook.com (2603:10a6:800:e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 08:30:22 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:30:22 +0000
Message-ID: <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
Date:   Wed, 9 Mar 2022 09:30:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor.Ambarus@microchip.com, saravanak@google.com
Cc:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, du@axentia.se,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd686528-e5a0-4475-4562-08da01a70d56
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2975:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2975619845B2486F3F365655BC0A9@VI1PR0202MB2975.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFAqijKzR05gBbwfBeKI1IrtMpFVt0r/hif6wTWiOpXJ5wVKmWwUBUZ17uhY3hMrWntY93aiJ1IA7sf9GptxaO5h/hYYP81m9ecroTigIiUj/RP7iaNKs+pAwITuc5DAptnecT5Obg7h0T4xAPuKsC5NlpJ7znXsCZwZ9Fr2e6WezDQVswa2OemZSoVZqM7YkgxQlLG+WATbWjtVrc+gb8iQsyhtdy3xBg/X5u4Ei0vLXWwlJ5iOAcP20iqizOUJyh+NKsjj9mpvR0rHdKRxaDX+C4JwBoMKMiRuU/JNQRxNCICqhYaVxHeNFDrK1HWkM+9zTbTBRDdbssluehSm8wJ5Kk0Z22ws4ZOy98Py5CWshSMGgL0R5Pskh9BZjAXQNNODcft8Xx/QwLBNBH0ldJ1NYGp8XlH72TLnKyb2AAyYeScgz0bvfzDGKoy/aSq2WCN4tL+ouJg6XDylP7TBOQWGhm07Wa7K4bgsRKNnfy6f7tLz1vh2ec5oYY0ED8rGYHwbEBY2lTYs3iQwYIXtXkN2mz6ophOqkrbkx/4NJTRWtNYJoOFWnz7QEGnLWj0X2l6AVtLJwfAoioTsfPV9d9b94C1xN/anLENksXF3SDDZ/wK3FHvFWgT66+hAEWePPeU/rQo2irqIcDmJDDI/ZvcpEuWyfry294A4jt1boKmY1NDOqRj4/Zj7QAsZpS9gy3tO6oplsniXV8/cgsG7aPSo90lcDlauQmk+vLz/EL/1rzZcHNuJaJ5eNAj47K9dFQOQF0zU2o8EYLUWifbL7k0P2bduioi66jKU4VJBzhMaGMJLKHWqfvrKk524arm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(366004)(346002)(39840400004)(396003)(6512007)(2906002)(508600001)(66556008)(5660300002)(38100700002)(2616005)(6666004)(30864003)(36916002)(26005)(186003)(53546011)(66476007)(8936002)(6506007)(31696002)(86362001)(316002)(83380400001)(36756003)(31686004)(6486002)(966005)(4326008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhiSFBWZFhZN1pkaGRhVTlycHUwK2Q3OGFLNmMwcUkxeEppelM0SnJ5NnA1?=
 =?utf-8?B?TklzWThiWnQ1OHVCT1lTM3JvamF4SFhtSkdkVm9rK0FKU3FPN2dVczRnZWl3?=
 =?utf-8?B?MEczcENWR1RsdnMyMWY0SndUTFAzV2czNkxra1RYN1VDTklUN1R2dUpLcklB?=
 =?utf-8?B?dWNseU1uTk8raU9YYzJTYU1LNG41TjBMSTMwU2Z5US8yM21va3VBYTdtaGdV?=
 =?utf-8?B?bFBkOGM4RDNCVkhsMkpMcDRXVWJodXZhUVhhRkxmSG04WUtZalFCQnNHcFgz?=
 =?utf-8?B?cFVXRjlxU2QzQ2lGcU9QOS9iaUtncXNBTElYYjljWmt2VUMzcVhydGJyY1Jw?=
 =?utf-8?B?NTFqdWxCRytDSnh3ZDVPWExQR2Q5STFoaXpBa2F6RXFoblRvRjF2WVJCRmRL?=
 =?utf-8?B?NEZUcTltSnhhM3VnUCs3czdLOVJnRUU3alBEMHQ3NHBOYlB4Sk5xYTlEVWtZ?=
 =?utf-8?B?b05yMlZBN0lQMUFRVlpOK0gweEhNWmgwR0x1LzlETk9NZTBMdEMrb090OG1G?=
 =?utf-8?B?SlpEV3ZPZ0lQVEJWOWxtaTV5QzlUV1JQanpPaUQ0a3BkM1hBd2ZER0FUdTNn?=
 =?utf-8?B?ck43V2hlbkZYbmMyb3RYZXFPZFVtK1VmeWJONldjb3ZYOTFiZXgxYW9JUHdT?=
 =?utf-8?B?cXVFSC9EcC9FSXplS3ZMN0JpaEwyQitVcnBlTlJuWEw2dFpMWjMyOGswR3c5?=
 =?utf-8?B?ZGgxQTQrajlmZHhvbWRTKys1aFh5MXlTQm9TYWFVUjBpNGxlOVRHZWZGNUZx?=
 =?utf-8?B?Mng1bVVuSkhwdXk2eWQvUjBWTFdPQVN3L3krZWU0NDZlZkR5dWhXN2lWM1pG?=
 =?utf-8?B?Q3RhSFYzS2dCNWR6cVRzeHMrRnpaY2p6VzNhVTFkQkN5OGxtTEFpdHEwbUZ3?=
 =?utf-8?B?VFJtYlJpZTB3WGE3Y1ZvMlo4YlpNbTYxYTg1UkJIR0dLMEwyL05BSENIeU9E?=
 =?utf-8?B?Uk1WektWL0k5N3lOZDh3K0hNby9yMlNnSDdmeENwaDR4T3hwcVVYSDVFQjU2?=
 =?utf-8?B?MWM3MGxsNVlyLzFvVWVkcnNTUmRtZXVrYVplTzN0Rkltd2l0QjQ0anpaelJE?=
 =?utf-8?B?eVhDSlBydjIvLzJmL2h3azgvU0ZweVBHOG5iRmhtYS9XcVhvRmZoc1djdHRS?=
 =?utf-8?B?US80Vy9Rekl1MGoyL2RGd091TlZZQkx2ZHh0VEhCUXpETmRQR1BPOGVMUHRK?=
 =?utf-8?B?M0lNRFpwaDY4MnQ2RFVHYUd4UkFPdVR0b0htOEpGY0JjYlh1cVNFbUNxNFFp?=
 =?utf-8?B?dUw1QzVkbjlacHp3WnJhNzFLcTYwWWdtbDBxbVNGN2F6VVdhZlVjbG1jd2Jl?=
 =?utf-8?B?WUtLdEdJWUxmTjNkN0RPdzhtRW5jSHFqaytVV20yUENPQUplbzJ1K2ZLb094?=
 =?utf-8?B?RnJ0TUdsd2J3bllVMmg2c0lsczJENHl6KzU1WHRZMmRRYjVPcnorTlNrUmVr?=
 =?utf-8?B?WWhaZTR1Mk0rZFE3ZHJKNUFhMEZrT25OL2VYN1A5eUdFNlVsaVg1SXh6NnYx?=
 =?utf-8?B?L2R5QTBHMjdXYWNZVytDUmFkeUR5RlF5bUd6ZnNqeGlPNCt5aDJEMFN3RTNM?=
 =?utf-8?B?OTU5eXJKQUNhb3ZXcHpIS0F0dm1RR3lxL3pDdVNsZWF0b2ZzdEZvMHE3VWgz?=
 =?utf-8?B?U0JYTGNHV1Z1aWhDcHhySkMza0E0RmFtVnI5WVEvVVVZNE1admIxRnpaeWVM?=
 =?utf-8?B?c25jQnI3RXRKTlFkNG9uQ1dQMHlOY0lacWlxZTI3NjIwM3V3a1hqUmZWNnBp?=
 =?utf-8?B?ZGwrNFZDaWFCaXM1NlA0VGdHaXZTSmZsTHoyV2plSVFCYjlib1NYWWlSYzVI?=
 =?utf-8?B?ZUlSTTZ2Z3liWS8yODF0cWNZQ2hOTW50VlNseHdsd3RCY1oyNHF4Z2ZuUEt1?=
 =?utf-8?B?cWIzcmlRaGV0N014blVSQmpwYWg0d0FiYTd4NHdpUURDUndJRmlnMVJWMGt5?=
 =?utf-8?B?d05sN2NRNTI0RmxXbGFrUFNqcUgyN3oycVRNV2hQQ0JXYzdISFEwa05JMktD?=
 =?utf-8?B?SXpCQy90N1A3Z2ZmUGljZUxYQ3NZaFAyNytvQnpSelZDNUl4Si92SnZFUTMw?=
 =?utf-8?B?RWRmakZoc3NBTWR6NUc1SHhlcS9HL2w5SXlOdWRYNzhtV3ZVanZ4cG9jK3hl?=
 =?utf-8?Q?9odQ=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: bd686528-e5a0-4475-4562-08da01a70d56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:30:22.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGzzn50unMCGl2Itt8ZlImWaClsW6OK4QN8+9utH3XYDKVAkCM6hA9jM4k+Qyfp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-08 08:55, Nicolas Ferre wrote:
> On 07/03/2022 at 21:32, Peter Rosin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 2022-03-07 12:32, Peter Rosin wrote:
>>> On 2022-03-07 10:45, Tudor.Ambarus@microchip.com wrote:
>>>> Peter, would it worth to do on your board a similar test to what I did?
>>>> I'm thinking whether the source of interrupts matters or not. So can you
>>>> disable your USB and use a mtd NAND stress test as a source of interrupts?
>>>> mtd_stresstest together with scp or hexdump.
>>>
>>> That's not a quick test for me, since I don't have modules enabled.
>>> I have located my SAMA5D31 evaluation kit, and I think I will try
>>> to get that running instead.
>>
>> Hi again!
>>
>> I got my SAMA5D31EK board running, using a freshly built at91bootstrap
>> and u-boot according to linux4sam.org and using the cross compiler I
>> have used from buildroot 2021.08, i.e. gcc 10.3.0, then using the
>> dtb for the ME20 from the original post and the same kernel and userspace
>> as I have used previously. Now, that dtb describes things that may not
>> actually be there etc etc, and I will try with a proper dtb as well
>> tomorrow, so this was just a quick-n-dirty test. I also added mem=64MB
>> to the kernel command line, to mimic our "Linea" CPU module and get a
>> bit quicker turnaround in the page cache.
>>
>> Anyway, with that setup I can reproduce the problem on the EK board.
>>
>> $ while :; do cat testfile | sha256sum; done
>> 5a939c69dd60a1f991e43d278d2e824a0e7376600a6b20c8e8b347871c546f9b  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> 250556db0a6ac3c3e101ae2845da48ebb39a0c12d4c9b9eec5ea229c426bcce9  -
>> 874c694ed002b04b67bf354a95ee521effd07e198f363e02cd63069a94fd4df8  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> c3a918a923ff2d504a45ffa51289e69fb6d8aa1140cca3fd9f30703b18d9e509  -
>> 1577ed72d2f296f9adc50707e0e56547ecb311fa21ad875a3d55ca908c440307  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>>
>>
>> But apparently only if I have an FTDI usb-serial adapter attached
>> while I boot. I also start to get good hashes if I remove and
>> reinsert the FTDI adapter, which is interesting.
>>
>> $ while :; do cat testfile | sha256sum; done
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>> ...
>> *snip many dozens of lines*
>> ...
>> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
>>
>> It's of course hard to prove the absence of trouble, but it feels
>> like it is working from both of those latter cases...
>>
>> (for the "real" case the FTDI usb-serial adapter is soldered in,
>>   with no easy way to make it go away, so it is not as easy to do the
>>   same test there.)
>>
>> I'll try to reduce the number of local parts of the setup further
>> tomorrow, such as the dtb mentioned above and the rootfs. I was
>> hoping for a binary download of prebuilt parts, but some links on
>>
>> https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3xekMainPage
>>
>> are bogus. E.g.
>>
>> ftp://twiki.lnx4mchp_backend/pub/demo/linux4sam_4.7/linux4sam-poky-sama5d3xek-4.7.zip
> 
> Okay, that's a bug in the TWiki page.
>> What's up with that twiki.lnx4mchp_backend "host"?
> 
> URL must be:
> https://files.linux4sam.org/pub/demo/linux4sam_4.7/linux4sam-poky-sama5d3xek-4.7.zip

Thanks,

I ended up not using that anyway since it didn't reproduce right
away. So, I went back to something I knew was workable and built
a smaller reproducer that isn't depending on any of our code. I
uploaded it to github.

https://github.com/peda-r/sama5d31

I make that, then flash it from the output sam-ba dir with sam-ba 3.2.

$ make
... *snip* *snip* *snip* *snip* ...
$ cd sam-ba
$ .../sam-ba_3.2.1/sam-ba -x prog-sama5d31ek.qml ttyACM0
... *snip* ...

Then on first boot, I append mem=64MB to the kernel command line.
Also, since I no longer have anything else that accesses the serial
ports I need something to make them fire USB interrupts, hence the
"cat /dev/ttyUSB0 &" etc commands in the below transcript. I have
also bumped the testfile to 50MB since there are fewer things going
on, and thus more memory available for the page cache.

I have the ETDI serial adapter in the top USB slot since the udev
rule that sets the latency_timer to 1ms is written as it is; it
is based on what we use for the soldered in case on the "real"
hardware. It shouldn't really matter, I can connect the FTDI serial
adapter to the other USB port and set the latency_timers to 1ms
manually and still reproduce.

I have some trouble getting the network going on the EK board,
and I plan to dig into that next and check if I can also reproduce
with the scp load. I'm not too hopeful thoough, since I fail to
reproduce even with the "cat testfile | sha256sum" load when FTDI
serial adapter has not been connected all the time since boot. That
makes me think that the issue is there for the scp load only because
the ETDI serial adapter is always there on the "real" board, and
that it will be hard to reproduce without that adapter in place.

Cheers,
Peter

-------------- transcript --------------

RomBOOT


AT91Bootstrap 3.10.3 (2022-03-08 17:40:20)

1-Wire: Loading 1-Wire information ...
1-Wire: ROM Searching ... Done, 2 1-Wire chips found

1-Wire: BoardName | [Revid] | VendorName
  #0  SAMA5D31-CM [DD4]      EMBEST
  #1  SAMA5D3x-MB [CC3]      FLEX

1-Wire: Board sn: 0x480002a revision: 0x620803

NAND: ONFI flash detected
NAND: Manufacturer ID: 0x2c Chip ID: 0xda
NAND: Page Bytes: 2048, Spare Bytes: 64
NAND: ECC Correctability Bits: 4, ECC Sector Bytes: 512
NAND: Disable On-Die ECC
NAND: Initialize PMECC params, cap: 4, sector: 512
NAND: Image: Copy 0xa0000 bytes from 0x40000 to 0x26f00000
NAND: Done to load image
<debug_uart>

U-Boot 2017.03-linux4sam_5.8 (Mar 08 2022 - 17:40:32 +0100)

CPU: SAMA5D31
Crystal frequency:       12 MHz
CPU clock        :      528 MHz
Master clock     :      132 MHz
DRAM:  512 MiB
Flash: 16 MiB
NAND:  256 MiB
MMC:   Atmel mci: 0, Atmel mci: 1
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:
Error: ethernet@f0028000 address not set.
No ethernet found.
Hit any key to stop autoboot:  0
=> printenv bootargs
bootargs=console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(bootstrap)ro,768k(uboot)ro,256K(env_redundant),256k(env),512k(dtb),6M(kernel)ro,-(rootfs) rootfstype=ubifs ubi.mtd=6 root=ubi0:rootfs
=> setenv bootargs console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(bootstrap)ro,768k(uboot)ro,256K(env_redundant),256k(env),512k(dtb),6M(kernel)ro,-(rootfs) rootfstype=ubifs ubi.mtd=6 root=ubi0:rootfs mem=64MB
=> saveenv
Saving Environment to NAND...
Erasing redundant NAND...
Erasing at 0x100000 -- 100% complete.
Writing to redundant NAND... OK
=> boot

NAND read: device 0 offset 0x180000, size 0x80000
 524288 bytes read: OK

NAND read: device 0 offset 0x200000, size 0x600000
 6291456 bytes read: OK
## Flattened Device Tree blob at 21000000
   Booting using the fdt blob at 0x21000000
   Loading Device Tree to 3fb42000, end 3fb4b8cf ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.17.0-rc7 (peda@orc) (arm-buildroot-linux-gnueabihf-gcc.br_real (Buildroot 2021.08.3) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #1 Tue Mar 8 17:48:36 CET 2022
[    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Atmel SAMA5D31-EK
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000020000000-0x0000000023ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000020000000-0x0000000023ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000020000000-0x0000000023ffffff]
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(bootstrap)ro,768k(uboot)ro,256K(env_redundant),256k(env),512k(dtb),6M(kernel)ro,-(rootfs) rootfstype=ubifs ubi.mtd=6 root=ubi0:rootfs mem=64MB
[    0.000000] Unknown kernel command line parameters "earlyprintk", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 54160K/65536K available (7168K kernel code, 325K rwdata, 1344K rodata, 1024K init, 104K bss, 11376K reserved, 0K cma-reserved)
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x3ec/0x524 with crng_init=0
[    0.000000] clocksource: timer@f0010000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 115833966437 ns
[    0.000004] sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 130150523873ns
[    0.000056] Switching to timer-based delay loop, resolution 60ns
[    0.000477] clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns: 14479245754 ns
[    0.001100] Console: colour dummy device 80x30
[    0.001189] Calibrating delay loop (skipped), value calculated using timer frequency.. 33.00 BogoMIPS (lpj=165000)
[    0.001241] pid_max: default: 32768 minimum: 301
[    0.001504] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.001565] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.002635] CPU: Testing write buffer coherency: ok
[    0.003882] Setting up static identity map for 0x20100000 - 0x20100060
[    0.005538] devtmpfs: initialized
[    0.016983] VFP support v0.3: implementor 41 architecture 2 part 30 variant 5 rev 1
[    0.017461] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017533] futex hash table entries: 256 (order: -1, 3072 bytes, linear)
[    0.017699] pinctrl core: initialized pinctrl subsystem
[    0.019515] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.020668] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.057473] AT91: PM: standby: standby, suspend: ulp0
[    0.057529] No ATAGs?
[    0.058784] gpio-at91 fffff200.gpio: at address (ptrval)
[    0.060184] gpio-at91 fffff400.gpio: at address (ptrval)
[    0.061631] gpio-at91 fffff600.gpio: at address (ptrval)
[    0.063128] gpio-at91 fffff800.gpio: at address (ptrval)
[    0.064739] gpio-at91 fffffa00.gpio: at address (ptrval)
[    0.066585] pinctrl-at91 ahb:apb:pinctrl@fffff200: initialized AT91 pinctrl driver
[    0.080562] at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
[    0.082434] at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
[    0.084762] AT91: Detected SoC family: sama5d3
[    0.084805] AT91: Detected SoC: sama5d31, revision 2
[    0.085672] SCSI subsystem initialized
[    0.086186] usbcore: registered new interface driver usbfs
[    0.086329] usbcore: registered new interface driver hub
[    0.086466] usbcore: registered new device driver usb
[    0.087663] at91_i2c f0014000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    0.088083] i2c i2c-0: using pinctrl states for GPIO recovery
[    0.088224] i2c i2c-0: using generic GPIOs for recovery
[    0.088698] at91_i2c f0014000.i2c: AT91 i2c bus driver (hw version: 0x402).
[    0.089833] at91_i2c f0018000.i2c: using dma0chan2 (tx) and dma0chan3 (rx) for DMA transfers
[    0.090295] i2c i2c-1: using pinctrl states for GPIO recovery
[    0.090433] i2c i2c-1: using generic GPIOs for recovery
[    0.092266] at91_i2c f0018000.i2c: AT91 i2c bus driver (hw version: 0x402).
[    0.093647] Advanced Linux Sound Architecture Driver Initialized.
[    0.095756] clocksource: Switched to clocksource timer@f0010000
[    0.118209] NET: Registered PF_INET protocol family
[    0.118510] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.119613] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.119704] TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.119761] TCP bind hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.119809] TCP: Hash tables configured (established 1024 bind 1024)
[    0.120102] UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.120186] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.120498] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.122255] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    0.123405] io scheduler mq-deadline registered
[    0.123457] io scheduler kyber registered
[    0.136138] brd: module loaded
[    0.149150] loop: module loaded
[    0.149846] ssc f0008000.ssc: Atmel SSC device at 0x(ptrval) (irq 21)
[    0.151507] atmel_usart_serial.0.auto: ttyS2 at MMIO 0xf0020000 (irq = 24, base_baud = 4125000) is a ATMEL_SERIAL
[    0.153485] atmel_usart_serial.1.auto: ttyS0 at MMIO 0xffffee00 (irq = 34, base_baud = 8250000) is a ATMEL_SERIAL
[    0.705038] printk: console [ttyS0] enabled
[    0.716182] macb f802c000.ethernet: invalid hw address, using random
[    0.751175] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 42 (d2:e4:fe:11:9c:b2)
[    0.761741] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.768332] ehci-atmel: EHCI Atmel driver
[    0.776581] atmel-ehci 700000.ehci: EHCI Host Controller
[    0.781999] atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
[    0.789730] atmel-ehci 700000.ehci: irq 44, io mem 0x00700000
[    0.820024] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    0.826275] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    0.834597] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.841838] usb usb1: Product: EHCI Host Controller
[    0.846697] usb usb1: Manufacturer: Linux 5.17.0-rc7 ehci_hcd
[    0.852481] usb usb1: SerialNumber: 700000.ehci
[    0.858200] hub 1-0:1.0: USB hub found
[    0.862177] hub 1-0:1.0: 3 ports detected
[    0.867560] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.873824] ohci-atmel: OHCI Atmel driver
[    0.879375] at91_ohci 600000.ohci: USB Host Controller
[    0.884635] at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
[    0.892287] at91_ohci 600000.ohci: irq 44, io mem 0x00600000
[    0.964328] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.17
[    0.972650] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.979859] usb usb2: Product: USB Host Controller
[    0.984686] usb usb2: Manufacturer: Linux 5.17.0-rc7 ohci_hcd
[    0.990440] usb usb2: SerialNumber: at91
[    0.995541] hub 2-0:1.0: USB hub found
[    0.999369] hub 2-0:1.0: 3 ports detected
[    1.005896] usbcore: registered new interface driver uas
[    1.011436] usbcore: registered new interface driver usb-storage
[    1.017508] usbcore: registered new interface driver ums-alauda
[    1.023564] usbcore: registered new interface driver ums-cypress
[    1.029629] usbcore: registered new interface driver ums-datafab
[    1.035731] usbcore: registered new interface driver ums_eneub6250
[    1.042038] usbcore: registered new interface driver ums-freecom
[    1.048095] usbcore: registered new interface driver ums-isd200
[    1.054109] usbcore: registered new interface driver ums-jumpshot
[    1.060291] usbcore: registered new interface driver ums-karma
[    1.066174] usbcore: registered new interface driver ums-onetouch
[    1.072367] usbcore: registered new interface driver ums-realtek
[    1.078434] usbcore: registered new interface driver ums-sddr09
[    1.084463] usbcore: registered new interface driver ums-sddr55
[    1.090482] usbcore: registered new interface driver ums-usbat
[    1.096513] usbcore: registered new interface driver ftdi_sio
[    1.102376] usbserial: USB Serial support registered for FTDI USB Serial Device
[    1.110721] atmel_usba_udc 500000.gadget: MMIO registers at [mem 0xf8030000-0xf8033fff] mapped at (ptrval)
[    1.120587] atmel_usba_udc 500000.gadget: FIFO at [mem 0x00500000-0x005fffff] mapped at (ptrval)
[    1.132265] g_serial gadget: Gadget Serial v2.4
[    1.136785] g_serial gadget: g_serial ready
[    1.143169] at91_rtc fffffeb0.rtc: registered as rtc0
[    1.148247] at91_rtc fffffeb0.rtc: setting system clock to 2015-05-16T14:19:33 UTC (1431785973)
[    1.157038] at91_rtc fffffeb0.rtc: AT91 Real Time Clock driver.
[    1.163257] i2c_dev: i2c /dev entries driver
[    1.169663] at91-reset fffffe00.rstc: Starting after user reset
[    1.176794] at91_wdt fffffe40.watchdog: watchdog is disabled
[    1.182495] at91_wdt: probe of fffffe40.watchdog failed with error -22
[    1.190832] atmel_aes f8038000.aes: version: 0x135
[    1.196145] atmel_aes f8038000.aes: Atmel AES - Using dma1chan0, dma1chan1 for DMA transfers
[    1.205373] atmel_sha f8034000.sha: version: 0x410
[    1.210437] atmel_sha f8034000.sha: using dma1chan2 for DMA transfers
[    1.216976] atmel_sha f8034000.sha: Atmel SHA1/SHA256/SHA224/SHA384/SHA512
[    1.224567] atmel_tdes f803c000.tdes: version: 0x701
[    1.229943] atmel_tdes f803c000.tdes: using dma1chan3, dma1chan4 for DMA transfers
[    1.237747] atmel_tdes f803c000.tdes: Atmel DES/TDES
[    1.243284] usbcore: registered new interface driver usbhid
[    1.248839] usbhid: USB HID core driver
[    1.258067] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    1.264472] nand: Micron MT29F2G08ABAEAWP
[    1.268447] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    1.276874] usb 1-2: new high-speed USB device number 2 using atmel-ehci
[    1.286322] Bad block table not found for chip 0
[    1.293124] Bad block table not found for chip 0
[    1.297723] Scanning device for bad blocks
[    1.500885] Bad block table written to 0x00000ffe0000, version 0x01
[    1.508187] Bad block table written to 0x00000ffc0000, version 0x01
[    1.514569] 7 cmdlinepart partitions found on MTD device atmel_nand
[    1.520869] Creating 7 MTD partitions on "atmel_nand":
[    1.525983] 0x000000000000-0x000000040000 : "bootstrap"
[    1.532203] mtdblock: MTD device 'bootstrap' is NAND, please consider using UBI block devices instead.
[    1.543914] 0x000000040000-0x000000100000 : "uboot"
[    1.549845] mtdblock: MTD device 'uboot' is NAND, please consider using UBI block devices instead.
[    1.560705] 0x000000100000-0x000000140000 : "env_redundant"
[    1.567241] mtdblock: MTD device 'env_redundant' is NAND, please consider using UBI block devices instead.
[    1.579007] 0x000000140000-0x000000180000 : "env"
[    1.584771] mtdblock: MTD device 'env' is NAND, please consider using UBI block devices instead.
[    1.595462] 0x000000180000-0x000000200000 : "dtb"
[    1.601194] mtdblock: MTD device 'dtb' is NAND, please consider using UBI block devices instead.
[    1.611800] 0x000000200000-0x000000800000 : "kernel"
[    1.617732] mtdblock: MTD device 'kernel' is NAND, please consider using UBI block devices instead.
[    1.629150] 0x000000800000-0x000010000000 : "rootfs"
[    1.637058] usb 1-2: New USB device found, idVendor=0403, idProduct=6011, bcdDevice= 8.00
[    1.645340] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.652514] usb 1-2: Product: Quad RS232-HS
[    1.656687] usb 1-2: Manufacturer: FTDI
[    1.661074] mtdblock: MTD device 'rootfs' is NAND, please consider using UBI block devices instead.
[    1.673740] iio iio:device0: Resolution used: 12 bits
[    1.679427] input: at91_adc as /devices/platform/ahb/ahb:apb/f8018000.adc/input/input0
[    1.687403] random: fast init done
[    1.694695] ftdi_sio 1-2:1.0: FTDI USB Serial Device converter detected
[    1.701699] usb 1-2: Detected FT4232H
[    1.707813] xt_time: kernel timezone is -0000
[    1.712672] gre: GRE over IPv4 demultiplexor driver
[    1.717681] Initializing XFRM netlink socket
[    1.722278] NET: Registered PF_INET6 protocol family
[    1.729303] usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB0
[    1.738202] Segment Routing with IPv6
[    1.741969] In-situ OAM (IOAM) with IPv6
[    1.746187] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.753545] NET: Registered PF_PACKET protocol family
[    1.759611] ftdi_sio 1-2:1.1: FTDI USB Serial Device converter detected
[    1.766611] usb 1-2: Detected FT4232H
[    1.771399] usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB1
[    1.783894] ftdi_sio 1-2:1.2: FTDI USB Serial Device converter detected
[    1.790948] usb 1-2: Detected FT4232H
[    1.798470] usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB2
[    1.807567] ftdi_sio 1-2:1.3: FTDI USB Serial Device converter detected
[    1.814557] usb 1-2: Detected FT4232H
[    1.820308] usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB3
[    1.843413] ubi0: attaching mtd6
[    2.648198] ubi0: scanning is finished
[    2.674329] gluebi (pid 1): gluebi_resized: got update notification for unknown UBI device 0 volume 0
[    2.683623] ubi0: volume 0 ("rootfs") re-sized from 90 to 1940 LEBs
[    2.691016] ubi0: attached mtd6 (name "rootfs", size 248 MiB)
[    2.696764] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    2.703703] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    2.710494] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
[    2.717454] ubi0: good PEBs: 1980, bad PEBs: 4, corrupted PEBs: 0
[    2.723582] ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
[    2.730822] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence number: 1391204677
[    2.739970] ubi0: available PEBs: 0, total reserved PEBs: 1980, PEBs reserved for bad PEB handling: 36
[    2.749603] ubi0: background thread "ubi_bgt0d" started, PID 67
[    2.758960] ALSA device list:
[    2.761952]   No soundcards found.
[    2.769813] UBIFS (ubi0:0): Mounting in unauthenticated mode
[    2.882936] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "rootfs", R/O mode
[    2.891290] UBIFS (ubi0:0): LEB size: 126976 bytes (124 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    2.901241] UBIFS (ubi0:0): FS size: 244936704 bytes (233 MiB, 1929 LEBs), max 2048 LEBs, journal size 9023488 bytes (8 MiB, 72 LEBs)
[    2.913292] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
[    2.919115] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0), UUID 6AAC8EC5-1B1E-4E71-9F6F-EEB719E02AFC, small LPT model
[    2.935358] VFS: Mounted root (ubifs filesystem) readonly on device 0:13.
[    2.945679] devtmpfs: mounted
[    2.951449] Freeing unused kernel image (initmem) memory: 1024K
[    2.958144] Run /sbin/init as init process
[    3.303513] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 70
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [    4.159275] udevd[97]: starting version 3.2.10
[    4.193870] random: udevd: uninitialized urandom read (16 bytes read)
[    4.226640] random: udevd: uninitialized urandom read (16 bytes read)
[    4.236763] random: udevd: uninitialized urandom read (16 bytes read)
[    4.325369] random: crng init done
[    4.353551] udevd[98]: starting eudev-3.2.10
[    6.162090] ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -16
[    6.214815] ubi0 error: ubi_open_volume: cannot open device 0, volume 0, error -16
done
Saving random seed: OK
Starting network: [    7.090546] macb f802c000.ethernet eth0: PHY [f802c000.ethernet-ffffffff:01] driver [Micrel KSZ8031] (irq=45)
[    7.150491] macb f802c000.ethernet eth0: configuring for phy/rmii link mode
udhcpc: started, v1.33.1
udhcpc: sending discover
udhcpc: sending discover
udhcpc: sending discover
udhcpc: no lease, failing
FAIL
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Starting sshd: OK

Welcome to Buildroot
buildroot login: root
root@buildroot:~# cat /sys/bus/usb-serial/devices/ttyUSB?/latency_timer
1
1
1
1
root@buildroot:~# cat inittest.sh
#! /bin/sh

echo "generating random file"
dd if=/dev/urandom of=testfile bs=1024 count=50000
root@buildroot:~# ./inittest.sh
generating random file
50000+0 records in
50000+0 records out
root@buildroot:~# cat /dev/ttyUSB0 &
root@buildroot:~# cat /dev/ttyUSB1 &
root@buildroot:~# cat /dev/ttyUSB2 &
root@buildroot:~# cat /dev/ttyUSB3 &
root@buildroot:~# cat runtest.sh
#! /bin/sh

while :; do cat testfile | sha256sum; done
root@buildroot:~# ./runtest.sh
abd6ded5a6eb1467e4b48909bfae35cea2191d417c3f27022954cee103c334ca  -
98d03c79185168cbff6dc8db32e931061aa9e7c35025b7507f89faa208e12b6f  -
1464940fc3cc527f89f153ec79ae7c8c892948ae013e6f54fba64664930e9ec4  -
98d03c79185168cbff6dc8db32e931061aa9e7c35025b7507f89faa208e12b6f  -
326320e5a50777f8db772b6d06ac1beab246c32c66c75cefc0ace12f73394d68  -
d79664b5e2d461ce6617be24c1fbeab551b8fed0501e596ba09f1977b0fd70ee  -
c362e254b14024fc46c4f18d7d10dc9424688c4d842ba6672361da12420a58fa  -
be35c862a57e8a751af8517f3dc6f257ba1f18157b643ca3e8919f827e37e241  -
98d03c79185168cbff6dc8db32e931061aa9e7c35025b7507f89faa208e12b6f  -
087eba1b603365320c9379391521791c5cd2ddce9a77e230ccb5bd67b2e856d0  -
22b6b0eb1d9428360fcd930c47bc41e566337a824bd66c5a468bfdf8adf89b36  -
^C
root@buildroot:~#
