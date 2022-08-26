Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB15A2F79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiHZS64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbiHZS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:58:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF636EF2A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxM6s96+0QF9tK5Yvu7PDuCEsCF7VHtqe3EQBRYRHiM76n7IQ8KHXcZwQ9j+mTV0w1BV3VJ0UUTI+20Cmp0oI+u96+Frj0boN8DM3w2KyxyOB3gUEqfE+60EEMbCM1dtygNOdcgEaaD39tnrgwYlCxVVKQMZkMo8mGAAlFWV3XUlrrcXprO367jpZwuWLcXSg8gKDKbx3fKuy9+/VPVv7bt2nTjiV4w1cqk5L0JWkFxtfRI9Q086ABr5aGxtg1g4LvzrDb0AnshHwyz9PqRWv031tnXhTSa8dRcqpzJyEJeeiAOndpuiTCIgl7GFtUTtglCJ5ystmQLF/Ntk1bjz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWaXVn1i/cMWRr0s/Ts0gUxd5Iv4yWzp6FsCyRfIbZk=;
 b=J1LydXy3nwCbxr9X+nq6O4xF8WM4fmBjxi+9EOSg1LzaN6KrZInJJ+T9pwm4dCkSduLvbd47PBIunlNhvOPN729eydBMfg+w+pGnteqh0ZRtI888MeO7eLQvv12MCVu+Era2LAIopqPiOtsCSed58+l4zzKtIZwiGtf6AXQIZpbSc6xo/iIkPNTDpmbX82fKmfqaxEBJtcdIBjS6ZBvJ4zq9smW2l25a/U+wjyjs/j+m2Oi1WnLbi4xmEvDlLlk73pDSweo2lhPRRuWj+vPJH8THQrB6e7smV28MeIXI59qpktxZNvbwIjLMAeIGsPsNA7k+atG/AO+rXzSckERj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWaXVn1i/cMWRr0s/Ts0gUxd5Iv4yWzp6FsCyRfIbZk=;
 b=dUy3LAC/0H79gZGRRjspravu5TzpZMdI9PY7Vgz9xeK02XHo1/Fkiz85W851fEtQOF0zULkQL/y0BKuojoJh9BhSaxa7gHj/cNcSNQJ6xhoqJbPN0dGB++WUUtUA5S6GWSunEZX7itkKA4c6oqBjxypDZ6qo3GsfV0LSH40CRHtsFzXICQudkwMKfmfJkQzv8d7MseEOcnH2j5yn/H4X38veB8SX/nZtmoBDyFxzTZpqJAia95577RBT6qFAedbquYtE5lphl70SiYRBaNK8TwW7CtWUX24lCrZhqos3zqhzW67raLgF9NbQN+QKPceYm3n4ACTj4+r2Kq0c1Ha5UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by HE1PR03MB3146.eurprd03.prod.outlook.com (2603:10a6:7:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 18:57:58 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2%4]) with mapi id 15.20.5504.019; Fri, 26 Aug 2022
 18:57:58 +0000
Subject: Re: retire_capture_urb: Corrected urb data len
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <68a97d61-21bf-b45e-f6ed-c0906dd4b197@seco.com>
 <87ilmfj72j.wl-tiwai@suse.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <9d41eda1-1172-ea60-dd87-b3e38a529170@seco.com>
Date:   Fri, 26 Aug 2022 14:57:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87ilmfj72j.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0df0c8-c09d-475f-9655-08da8794e481
X-MS-TrafficTypeDiagnostic: HE1PR03MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tE1oaB5KnoZYOC9b2Vc1fDcMuKitVa+wH4NvShBKH7FXHXsUZb0jpnh8tvTnxnocDkLuUMGLVcTMlNA8E/C0vXszLLn4QtT7fOx92QRJNOlJkdbRloq4uapWrdgvfD5o8oInMDoWYXbAzQ5qodu5DEoOg6BNQMngF9GfkUJkQHiJE3Z5MEbcZjXUN0UBY0b7XBXdNscvVzlhe1U+o3N+dlxj581dva0WlNcIsRRn8m5XbjID/UohMkEhN1TnCnlIsr4ZlmlD+aYV0DpGhKI+4cB/FduZORJZOQJyH+K52YdgND6Sc3klvlH5ncfLDcblD2Q7Mhv/KYdId8KeNuwjCYxxmBm5e/k+VUjpkDonVAx0+ZMbuSupfSzvcLy6k0E1rf5l9ryz2PDvWpuiyieXqZQvXNrecV08bovhZE0uHohR64m+rAFtbIzKh6PwL9HlEPM0UkxRNrc6twdRfwsW4g43739GDXv8ZOA87LbfjmR4kprRAKBrTfcdshDkzPJJ+YuHgoGiYjBCDgkqnYXJ9kbAXENYHyidWgUfQjTYizTgnqEBFi75IBqG8yAy0bz4T/J2HkMhWUtdVy5nOK1k52NLO4xhYUWKV4Asy5WPz8NYOXzojt32iOxMFVNEnsc1h5i+ON6ADa+qrlAuVSXUP6xpt0EY8znFp5eI3J1a1Qqp8E1Nf+yK34EauCeLr+jADwUC1fR4pheJVc3bx6LaybdkDb8dnD10PIqNoFXIAEOZI1gceMac5Ahnrd2A81odljOcctQ0aiyaXwZzVK0MSxYv2osfaVmx7urmnPIiYHRf6kecPik+xofGjGV2TsJzBW5380sinuFDpg+scO0fIto//f4OVHmJzXW0AopnkZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39850400004)(396003)(136003)(366004)(8676002)(66556008)(54906003)(86362001)(31696002)(66946007)(83380400001)(44832011)(316002)(6916009)(38350700002)(26005)(38100700002)(8936002)(6506007)(6512007)(41300700001)(2616005)(966005)(6666004)(30864003)(6486002)(52116002)(478600001)(36756003)(66476007)(4326008)(5660300002)(186003)(31686004)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNNZnNROXI5TFV5MUUxdFU3RlgweDlsZ0c5cEY4RVRtNFRLL3QyK0lENTBM?=
 =?utf-8?B?TlByOGprR0lMOGErMjlzWGpCQUxvblI2anE1NEdnTERLb1RGRmxzcnI4bnZ3?=
 =?utf-8?B?Y2ROOGNUK3Q2TDM0ZGJraFhOenpxWXNibU5rREhJWnB2bXlaNndzZXYxNWY3?=
 =?utf-8?B?ZTkrU2hHVEVFUFZOYW5oY2owc2w0MzJxNjkvSHdMblJCN0RFa1lpOGJwT0NV?=
 =?utf-8?B?VFV4bkdoUWhFQ2RUbFo1SnhiVitNRUV4M1VrQ2hJMExpZnRibDRndDRZSENQ?=
 =?utf-8?B?NEt5MStoaVRwbVF0bVV0QU9nOGtYSW5jWi9pQWYxbFd4aEd6YWNuOWQ3TU1p?=
 =?utf-8?B?aCt5VERRZkpNd2xWZzltd0dLT2kyUTR5VVdRNnBHckl2MzJwZnNmblFudlRm?=
 =?utf-8?B?b3hVamRPbmJWNVRDMHFmVEYrdlpValRyS2hibmY3NnNWcDR1N1dqR3owTy9K?=
 =?utf-8?B?RE0xcE1Fc2hacUdLRVpHZ0xoZksvTk5nL3pTS1N4aHY4NnRIZkdjUEJvRU5j?=
 =?utf-8?B?U1pweGlEZTVvR1llc0NGN0pmeGdVa0VLRlhxbEROUm1STEczREFWV3BXS0RT?=
 =?utf-8?B?Z1M5bGNmdFpmZUppMWw1OXBwWjNrRDhxeEM5VUxvSG1PRkJJQVI0c0thNWd3?=
 =?utf-8?B?MGhPU2JENzFVVFc4bmpadGdOdHhEbElnMEZzV0tCUkxKWTdsUEMzK2kyZG5i?=
 =?utf-8?B?ZXVTMk9nYkFRQ3Zxc0hsbUEyb3BvL0xJMk1zOXVkb3JHaWVKdy9zc3RhZnA4?=
 =?utf-8?B?MGxwU2NYMlFIUUFVUW1ndm5URnV1TGhXd3hJQk1NRjlyMFBiekNUZEswR0lk?=
 =?utf-8?B?OEpYazlvM0tRUG8wbFNEQWpmZnd5TlJvTjlUMUFzVFlVSlJ5Um5DWGEzMkVh?=
 =?utf-8?B?RmhvS2VQcEprc01GampBWEFGQjJ2TXdzRGV4ZXZVZGc4SFd4Vjg3MjJxUkRp?=
 =?utf-8?B?dzl1MHhQNDcxYjBreXgwWmVLZGp1MkFKZUo3SFRMZk02YzRBUnZnQXBoUlZV?=
 =?utf-8?B?YjcxSUxkME96czBMUFNSZmdrVDVGdmFEc2sxaXg2MVlFYmtRUmpzMFRNZ3FD?=
 =?utf-8?B?dnBhck85OVFORW9NUlp5UVdEcjRVNlhRaWhvQ3FEeGNwV1F0VXFkSjhiWEls?=
 =?utf-8?B?NEoycm1VUTVUSnh2SUNicTM4dWJ3ZmxqeldWQnJ0UmJnK09CRUxIeFdSZWJ2?=
 =?utf-8?B?Tll6ck1OQnREdDB6eGRCNHN6MGlyeXlTbG1NNmVpbzA2VU9ndWVweEdKUXdq?=
 =?utf-8?B?WEtSellBR3k5dkt2SlZhUHZGenNqTnRQUEpIZEZCUWU0Q1E3YjdQMysyVzMy?=
 =?utf-8?B?VGMrUUVadzlVcjhKY096OW1xTmVjcnBWK0UvdGkvdTFYRXA4Tm8wOURVcUU3?=
 =?utf-8?B?dko3UjlMUzFWTWJQbTNlSG1yTjRiNlB4WTJqUWtZTkRHNmhqeHk5UHNPemsw?=
 =?utf-8?B?bzhHV1NCMEVQcVBRTVhNTkxseTEwL2FCZ0tZNWNodWxpeDRkSElnMXYvTVFN?=
 =?utf-8?B?RlhseDRsRW5uV0dCMUVHeHpQSTZKMDJ1ZHlYOStRdVlBQzAza2ZqQnBaeXlU?=
 =?utf-8?B?UExDd3NXZ3Z0eWtIS0VndExUUzFnWUtPWXd0Vy9sa1Z1WXMrWCs3ZDdGbkE3?=
 =?utf-8?B?NmZFcExUQldFODV2SzV3bGovekdnMnVYNHYxUTYyNXR4Z0FqVStxdHd5L1l5?=
 =?utf-8?B?OXIwSEFqZmU2TGIzUzlIcXBSZzZRYmlzZXdxVUdJMDQyVmlZdS9nMi9Jelh3?=
 =?utf-8?B?elRWcFhaRnppNzVUdjI2V0pka3FKaTBHWjRDajRqS2ZHN2hqaVErNU5rSzV3?=
 =?utf-8?B?SC9OZUp0OVlzbXQvN3hoM3YwaVZRT3RrcWlQU3daRlh1QkgwZ2VWU1dZR3ZV?=
 =?utf-8?B?cFJwaVNFUGZYYWZBM0ExUlZaTjRLVit4MS9kZXdCa0gxczJMSm1JVFEyUjVx?=
 =?utf-8?B?R0RQVXFHMWxjTzhnbTV3M3NKSFkrVFREMUxwVDIrN3lmcGFHYWhGa3VwOWxi?=
 =?utf-8?B?ZWV0Q1hBVS85a0s1b3JVdEF4a1RLZEViTzhkM3BqNFlmRmp6cEtYTmhCUi9T?=
 =?utf-8?B?TlpsVEo0ZS9JUlhhZEozM3l1TlR4clhuNE4rWWhyYlVqVHBwUVRvZVRVdTMr?=
 =?utf-8?B?cElVcnZ4SGU4VlZVNlBUZlhTbHlXVy9xRGcyM09WUGpwakhGbHhKeU1QdWth?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0df0c8-c09d-475f-9655-08da8794e481
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:57:58.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0c7AOLs44loUOiNsiTNxMhTiGGzSgmdF4U/jD4PGuQGdYJHwa/cztst47khdcq2JcF5mmXrGa82T0n4vZf8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/22 12:36 PM, Takashi Iwai wrote:
> On Fri, 26 Aug 2022 18:22:24 +0200,
> Sean Anderson wrote:
>> 
>> Hi all,
>> 
>> I have a "FiiO DigiHug USB Audio" sound card (1852:7022) [3]. I have had
>> no problems with the audio, but I did notice a large number of message
>> like 
>> 
>> retire_capture_urb: 4992 callbacks suppressed
>> 
>> in my dmesg [1]. This is caused by the "Corrected urb data len."
>> warning.
> 
> What exact values are shown there?

Unfortunately, as detailed below, I was unable to turn off ratelimiting.

> The problem is that your hardware
> (likely a buggy firmware) returns the unaligned size of bytes as the
> data.  Maybe it's worth to replace dev_warn_ratelimited() there with
> dev_warn() and take all warnings once.  Then we can see what kind of
> values are delivered from the hardware.

I'll have an attempt at that next week

>> The patch adding this warning [2] makes it seem like
>> this warning should be an uncommon occurance. However, based on the
>> number of suppressed callbacks, this seems to be happening at a rate of
>> around 500 Hz.
>> 
>> Is this buggy hardware? Or is this a bug in the driver? Does there need
>> to be a quirk? Or perhaps the warning above should be a debug instead?
> 
> There is no quirk for that.  As long as the device works with that
> workaround (except for messages), we can simply add a quirk to not
> warn but always apply the workaround silently for such devices.

OK. I wasn't sure what the correct resolution would be.

--Sean

> 
>> 
>> I'm using 5.15.0-46-generic. I know, I know; this is a vendor
>> kernel. However, I went through the commits for sound/usb/pcm.c and
>> didn't see any major differences. I also previously saw this issue on
>> 5.4, so this probably isn't a regression.
>> 
>> --Sean
>> 
>> [1] I would have liked to post the actual message, but I was unable to
>> figure out how to disable ratelimiting. I tried setting
>> /proc/sys/kernel/printk_ratelimit to 0,
>> /proc/sys/kernel/printk_ratelimit_burst to 5000, and
>> /proc/sys/kernel/printk to 8. However, nothing seemed to have any effect
>> (except that the callbacks suppressed messages were disabled). I find
>> this very strange, given that the callbacks suppressed message uses
>> KERN_WARN, and so does dev_warn_ratelimited.
>> [2] https://lore.kernel.org/all/4B28A659.6070303@ladisch.de/T/
>> [3]
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               1.10
>>   bDeviceClass            0 
>>   bDeviceSubClass         0 
>>   bDeviceProtocol         0 
>>   bMaxPacketSize0         8
>>   idVendor           0x1852 GYROCOM C&C Co., LTD
>>   idProduct          0x7022 
>>   bcdDevice            0.01
>>   iManufacturer           1 FiiO
>>   iProduct                2 DigiHug USB Audio
>>   iSerial                 0 
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength       0x0182
>>     bNumInterfaces          4
>>     bConfigurationValue     1
>>     iConfiguration          0 
>>     bmAttributes         0x80
>>       (Bus Powered)
>>     MaxPower              500mA
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        0
>>       bAlternateSetting       0
>>       bNumEndpoints           1
>>       bInterfaceClass         3 Human Interface Device
>>       bInterfaceSubClass      0 
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>         HID Device Descriptor:
>>           bLength                 9
>>           bDescriptorType        33
>>           bcdHID               1.00
>>           bCountryCode            0 Not supported
>>           bNumDescriptors         1
>>           bDescriptorType        34 Report
>>           wDescriptorLength      58
>>          Report Descriptors: 
>>            ** UNAVAILABLE **
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0012  1x 18 bytes
>>         bInterval              32
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      1 Control Device
>>       bInterfaceProtocol      0 
>>       iInterface              3 FiiO USB DAC-E10
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (HEADER)
>>         bcdADC               1.00
>>         wTotalLength       0x003e
>>         bInCollection           2
>>         baInterfaceNr(0)        2
>>         baInterfaceNr(1)        3
>>       AudioControl Interface Descriptor:
>>         bLength                12
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             5
>>         wTerminalType      0x0605 SPDIF interface
>>         bAssocTerminal          0
>>         bNrChannels             2
>>         wChannelConfig     0x0003
>>           Left Front (L)
>>           Right Front (R)
>>         iChannelNames           0 
>>         iTerminal               0 
>>       AudioControl Interface Descriptor:
>>         bLength                12
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             9
>>         wTerminalType      0x0101 USB Streaming
>>         bAssocTerminal          0
>>         bNrChannels             2
>>         wChannelConfig     0x0003
>>           Left Front (L)
>>           Right Front (R)
>>         iChannelNames           0 
>>         iTerminal               0 
>>       AudioControl Interface Descriptor:
>>         bLength                 9
>>         bDescriptorType        36
>>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>>         bTerminalID             3
>>         wTerminalType      0x0605 SPDIF interface
>>         bAssocTerminal          0
>>         bSourceID              16
>>         iTerminal               0 
>>       AudioControl Interface Descriptor:
>>         bLength                 9
>>         bDescriptorType        36
>>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>>         bTerminalID             7
>>         wTerminalType      0x0101 USB Streaming
>>         bAssocTerminal          0
>>         bSourceID               5
>>         iTerminal               0 
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                16
>>         bSourceID               9
>>         bControlSize            1
>>         bmaControls(0)       0x01
>>           Mute Control
>>         bmaControls(1)       0x02
>>           Volume Control
>>         bmaControls(2)       0x02
>>           Volume Control
>>         iFeature                0 
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           7
>>         bDelay                  0 frames
>>         wFormatTag         0x0001 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                26
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            6 Discrete
>>         tSamFreq[ 0]         8000
>>         tSamFreq[ 1]        16000
>>         tSamFreq[ 2]        32000
>>         tSamFreq[ 3]        44100
>>         tSamFreq[ 4]        48000
>>         tSamFreq[ 5]        96000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x82  EP 2 IN
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x0184  1x 388 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioStreaming Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x01
>>             Sampling Frequency
>>           bLockDelayUnits         2 Decoded PCM samples
>>           wLockDelay         0x0002
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       2
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           7
>>         bDelay                  0 frames
>>         wFormatTag         0x0001 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                26
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           3
>>         bBitResolution         24
>>         bSamFreqType            6 Discrete
>>         tSamFreq[ 0]         8000
>>         tSamFreq[ 1]        16000
>>         tSamFreq[ 2]        32000
>>         tSamFreq[ 3]        44100
>>         tSamFreq[ 4]        48000
>>         tSamFreq[ 5]        96000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x82  EP 2 IN
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x0246  1x 582 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioStreaming Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x01
>>             Sampling Frequency
>>           bLockDelayUnits         2 Decoded PCM samples
>>           wLockDelay         0x0002
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           9
>>         bDelay                  0 frames
>>         wFormatTag         0x0001 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                20
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            4 Discrete
>>         tSamFreq[ 0]        32000
>>         tSamFreq[ 1]        44100
>>         tSamFreq[ 2]        48000
>>         tSamFreq[ 3]        96000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x03  EP 3 OUT
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x0184  1x 388 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioStreaming Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x01
>>             Sampling Frequency
>>           bLockDelayUnits         2 Decoded PCM samples
>>           wLockDelay         0x0002
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       2
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           9
>>         bDelay                  0 frames
>>         wFormatTag         0x0001 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                20
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           3
>>         bBitResolution         24
>>         bSamFreqType            4 Discrete
>>         tSamFreq[ 0]        32000
>>         tSamFreq[ 1]        44100
>>         tSamFreq[ 2]        48000
>>         tSamFreq[ 3]        96000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x03  EP 3 OUT
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x0246  1x 582 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioStreaming Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x01
>>             Sampling Frequency
>>           bLockDelayUnits         2 Decoded PCM samples
>>           wLockDelay         0x0002
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       3
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0 
>>       iInterface              0 
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           9
>>         bDelay                  0 frames
>>         wFormatTag         0x2001 IEC1937_AC-3
>>       AudioStreaming Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             3 (FORMAT_TYPE_III)
>>         bNrChannels             2
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            1 Discrete
>>         tSamFreq[ 0]        48000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x03  EP 3 OUT
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x00c0  1x 192 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioStreaming Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x01
>>             Sampling Frequency
>>           bLockDelayUnits         2 Decoded PCM samples
>>           wLockDelay         0x0002
>> can't get debug descriptor: Resource temporarily unavailable
>> Device Status:     0x0000
>>   (Bus Powered)
>> 
> 
