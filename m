Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51655DC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiF1JHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiF1JHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:07:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70117.outbound.protection.outlook.com [40.107.7.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62F1277D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqBp5HYw4wgN6jo/zte7G9oAgl1HLy3Jvv4O2ZZf7iXUOjHcpBe8iw1knSxG21rCCvwjvVYsQ+WR2vfG+JluZSdKMZ792ZCKKVM5344QLFt5aIqbSHcGx3XdNDl2yb9Fw/DtVtbmAvwhD1A37Tf/D4ycQGd6pRbtqNkH5Q4EINyBDhKXLgNSJzhPfo8K+Y/BzLPzGiAYlDzDGmKOgYlUHqPAblhZlkbrsDkBAaGgE5g5gO4FDBaTlgGYkp2pNl8jeKy6g1PQkwMiCZqtHP/yP+jtGW1vcmsMO+2k9Yt+x3pV0RcJDWNP8+fGq+2ELz7u1IU6M3Tf+lCEpZ9f8CPRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZU7TgShkxCIolXONrNJ4R5Db7+escX0r5yxhh4lMwU=;
 b=UquZ0i27vgSn73vjgvIXVd/vOgnq9295LlZ7fqdYnQW476umiWbIPOa0bXxtNNSM6XtKwANs30SQ7LkEQohiZfxqE+ucvMUorCH/AqlMlGQxap72EfrzYuLcv2nmL2DNkk45rIMRIIoNTih5l5E9Pbtj8B7MM/PYDNuRHPiwWJGGo1xuwnhQl7haNsDc3cEcZLW7Xskb1+Jm+HXmzIhZUfvQJcRvsWR+6f5Z/mgNQoW1fiKt62vx4Lk+CeXXJ/Etv/8G8y2P5ertdP8fNmtBCHC3ftsQp+x7vhV4T+uJaDGcUEwql3vMDdC3upi3sb2WGKGGA4930u+AySWapEwkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZU7TgShkxCIolXONrNJ4R5Db7+escX0r5yxhh4lMwU=;
 b=OZ8RGWqWycbbzWuiZ5AQbFGB9tuSMEyEpTExpw1jtHen+k9lgkZBg3fTZPojG01Zx+p1a34YiVEU76di52GVABdw8ZU4umGUZM5q7WczkplrooIyIPOeJ0frgX10VberUlrsPUHx7ErKxRPpLt96vSZW4L5H4ronm43DngIbCzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by HE1PR0801MB1691.eurprd08.prod.outlook.com (2603:10a6:3:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 09:07:07 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::60dd:9fed:c95d:e54%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 09:07:07 +0000
Message-ID: <00e716d9-3ef8-a3b2-e1a9-26ddaadf3ea3@virtuozzo.com>
Date:   Tue, 28 Jun 2022 12:07:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220627085838-mutt-send-email-mst@kernel.org>
 <20220627191910.22734-1-alexander.atanasov@virtuozzo.com>
 <20220627163714-mutt-send-email-mst@kernel.org>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220627163714-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0601CA0006.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::16) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfbab786-0d52-4148-9a92-08da58e5938b
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDmfAPy3snJR8SKXIkC+McVk6+6yV8bE4jAXm3P3KA427DV1oxdu+V4DNajpw1uulAJd9ywOoo+zVKDH6JINpi/mPiqvQL+UugX0B1c2qpzkVaJpX/vtKJgToA6emzS1w8WaXF0IU15gb/VT8YAATmd9RvNSagicLCtv4ZEayXi4m3l4g+m27o0wfl4P4votta7UrkcoOs98gNGyTbOXYYQHWv9H1MaxOOYhyS4kFzlj7pvxHR4Q1Ssmy+ewyqyZ47CcIoRExJpyBlv+POEbFxckk09FSKkW5KzxsVDMXNnA+l4Oaf1hpC3YPYpoK9u9TeyXQb9pYJYvaaq49D9yLBvhDGhri4+GHI+w11Pv7p0OKeDr8oU+gjjcMLo42zsKpGrWRfwVB5I5aXgTF+zd/6uHRKlfwTQxHYUIgraA0QQLxyvvuOiAyKiNRWVuV12xH4wJuQVb/JXefME96kDC9xqyWZh7awQTS8z2zuxUTmR5jN9i9iF1ChBwgvCMV73v4/8xdlcGBvxahIBaodObngPaiks+RIFZoGFUTGorZFogWyKRk0qQS/asezIj4TwnSX7BCYMw8VBtnvZ0kvceuKydH4g9ADBhkM0tinzeXfSbcWZqtKN2KBNWM0tCNgJ3SFyvWiMFP0dtC1viZuXDT5/0TNGYpnIIKNFqCdWs53g9Yd2ewmg0Xrqecjj3IT16p+SWoAKCGOsMw4ELJV/pZLZIeUD3ZRixUjSyN5Jkuude/Vh5WeUvH1n2jDowNJ/8BO39OhWKR5FOt+rfx9a22H8FCKyaMyv6Xb136ZpN6SaBQ8Zok5yjxzhlCo01mIftwjUJ4306e0Ae26c7UiLXy+2sMfXtKPpWCSJhXh1DbLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(52116002)(86362001)(26005)(8676002)(83380400001)(53546011)(6506007)(4326008)(31696002)(66946007)(66476007)(66556008)(6512007)(6486002)(478600001)(44832011)(8936002)(2616005)(2906002)(36756003)(38100700002)(6916009)(5660300002)(41300700001)(316002)(38350700002)(31686004)(54906003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JvdjNOSFdzUVd4bWZqbWw4ZXhWKytyd2x0OTlweUYxWi9lZzNMYUd2eGJI?=
 =?utf-8?B?REUvbzFBcG1LbUVjR25GMk95RkFERDNxMGwrZDlnN0Y5VFRxRjVvRHFNeHBK?=
 =?utf-8?B?bTd1NEhxRktsd3RUT3hiSE1YZlhWNGlEWStqc1FpVEZ3L2pkSXprLzNnZ2dR?=
 =?utf-8?B?aEFsL2ZPZGYxekRFVVdnYWRYUldLSTBXdm5YWFUxS0pXa0lTSmRlaUM0L2h2?=
 =?utf-8?B?L1ZTWjE5dFNhOVN4VmpGWmNmeFdNNjRYTEoydm5GS3daTW9LTHdSbk0vWmgz?=
 =?utf-8?B?UzNJR3lieXN6UE0wb29vMFl5TDFmNERsNjdPT0YrTnNGSVVrS0d6bGt4SGM4?=
 =?utf-8?B?ay95RHNJb1pkdHpxS1dsa3Q3a3VHYkZoUmdwRy80NS9PWVYxcjArMXRTQmIr?=
 =?utf-8?B?R0dMMkZaYnNPbEdMeFJPSjN2bHN6a012dEh2UWZ1STJHa2RFd2syeDdaUGRw?=
 =?utf-8?B?S0ZyUC9BMm80T282aDVuMkp5b2pBV3c4bUtoN3FiOCtPem9yUjZEaXhLMUMx?=
 =?utf-8?B?dzJXWW1XOExtNEtGYjVRcUlaNXBocDhwWnRNQ2ZwTzVVWjkrcG1rYjlmWHNC?=
 =?utf-8?B?S3dFbGZhRW9QUGtNd1JVbFJ1RWxGTFlleVE0cFFFZHJkdFZaMUFDVHJNZWhr?=
 =?utf-8?B?eml4QkEyMzhLNEhDem9QaDVHMG44a081YURSY2t3RVJlYm1TYytqSk10QW5S?=
 =?utf-8?B?KzhlQnBWZUZ2WTRoUWlDVVJPVWp4MFlaYWxxWW9qTWpWTGlLNmdOVFhYd3dX?=
 =?utf-8?B?QkltSmZYSjVPOGFZTkFwMStMamZpL09kMEx4VUxOUXM3T2puMGtHUDNMV2x0?=
 =?utf-8?B?cEtMajE4cGNpOU9pK1UxZjdJczJLRjQ2T1NwalY3V2phUkJGQXhiMWhwK0xO?=
 =?utf-8?B?OUhUWXIxSzFKN0VPbGozOE1laHM2WC9kQW8wd2xWQy8wOXMvcThScnJnTHJa?=
 =?utf-8?B?a2ZwZi9TelJJcDNNQkNzTEMzTjRPNTlPNVk4b2tUeWh1bU53b3Z0STNLQ21x?=
 =?utf-8?B?aFk4UVgzZkppaVlBcUdHVUlHUWw5Zk1pbXk3eVdwbmQyRW1BZ1RrMWFaaHBZ?=
 =?utf-8?B?dy9rdEpteXJRZWFYRXVldENTdXFZdGxnTHl5TWR0dm15anJ0WVhURHBzRFRY?=
 =?utf-8?B?bi9WN1hkNDJoS292T2RDMmFVYXNyQS9ONDgzZldveFdRQzFWT3VTTDJvcFNE?=
 =?utf-8?B?aDR5RFo1R1lQY1FWc29KM1ZaT1FCd2ozd3QyM3Z5ZVgxR1lJL09pVmppdVVs?=
 =?utf-8?B?aDFBY1J6MmJKcnFoZzlqQ0xXWmNhRnJkWkNZZ0tXZEVmRUVrNWgvcTFVUVNH?=
 =?utf-8?B?NjVzemJ4Tlg3VXFxTWppZldWRkp1UVJBdkFyOXJRa01NUFJXRkRJL2JmRmdI?=
 =?utf-8?B?UEJ6Q3RYUnJrL2RFZENWVy9JMXNFa1NUT25aUk0vNjJOVVVhV1B0cnh6akE4?=
 =?utf-8?B?OG1ydm56anA3Yk5NVGJSRkloeGJXNEVZVXpIMFErOVR1enhjMHFHTUVvWjVy?=
 =?utf-8?B?bWNaUWErZ0lyaHJRQXEyT2VtbWJzd1BEZnV1SVFGL2EzbXZqaWU5WXpKcEFP?=
 =?utf-8?B?SlBodlZPYm94Vnpnalgva21aaHFZSlhJNGdxbEhiZXp0R011bllHRlRhYmVi?=
 =?utf-8?B?aXZwN0J2Rk5KQnJkT01jQkRiU013TEY2WjcvNkcrdXRqdWlXV3A3MGwrQlZ4?=
 =?utf-8?B?NlVkOHlnVG00RFJxOGNHdUNCREVmNVlYZnI4SE0xaFFwUFkvMUhzUFhZOUdn?=
 =?utf-8?B?L1B6RHkwWS9lUTlpUmNvcXZYNkNTaUFzM1ZhMTFFTDlwL1ZnRjMwSkM1Mldl?=
 =?utf-8?B?aFJTQy9sVDJFUE5rUkdBRHJEQWVkek1NUWVMRG56TzUzV3F0b2h0bEh5dW0r?=
 =?utf-8?B?MDBBNFBtbWNtc2xtWXNlQVo0Y0tIZVNZNldUWkRHM2ZCaENVVDlOYzBueGVT?=
 =?utf-8?B?dUYwOTY4b0pEM0cxRHM5c1hPdXNKQWFzcUtPM2FzV0Q2VkNDbWYvNlZxT0FR?=
 =?utf-8?B?ZFg2bVBoSy9DbUtsSE5NNGl5aExRbEFWb3ZmditGMHFYQjdSbWxqTjMyM0p6?=
 =?utf-8?B?RXdGUzFxYm96TVA0V0dXcEhLSE1hNGZVZ1JJa0NlVER4UW1JMEdNZlAzZXRG?=
 =?utf-8?B?aEpUQzZ6TlJURU52S2dJUHVyMmdKaWRQWHMvTDR1WjYrcDVHSVJ2eGgrdnBs?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbab786-0d52-4148-9a92-08da58e5938b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 09:07:07.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlhhWTd58N9acU4onv/ty0njV0Hdjiy/Kb3PiCUz1UYCmu9ogL3WObEiNbgkGG2OJ6S6B0qPHBg7AymkVxJXbz2+fTfaow9hWAIVKkA7oNM/xLHboh/AuuZVmPXPocT0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1691
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 27/06/2022 23:42, Michael S. Tsirkin wrote:
> On Mon, Jun 27, 2022 at 07:19:09PM +0000, Alexander Atanasov wrote:
>> Allow the guest to know how much it is ballooned by the host.
>> It is useful when debugging out of memory conditions.
>>
>> When host gets back memory from the guest it is accounted
>> as used memory in the guest but the guest have no way to know
>> how much it is actually ballooned.
>>
>> No pretty printing and fixed as per coding style.
>> ....
>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>> +{
>> +	struct virtio_balloon *b = f->private;
>> +	u32 num_pages;
>> +	struct sysinfo i;
>> +
>> +	si_meminfo(&i);
>> +
>> +	seq_printf(f, "%-22s: %llx\n", "capabilities", b->vdev->features);
> why do we need this in debugfs? Isn't this available in sysfs already?

Yes, it doesn't make sense to have it without pretty printing. I will 
remove it.

>> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);
> I suspect this function doesn't work properly when page size is not 4K.

It is the page size used by the balloon and it is always 4K and not the 
page size used by the guest which can be different.

/*
  * Balloon device works in 4K page units.  So each page is pointed to by
  * multiple balloon pages.  All memory counters in this driver are in 
balloon
  * page units.
  */

And the code agrees with the comment. To be consistent the file must use 
the same units.


>> +
>> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
>> +			&num_pages);
>> +	/* Memory returned to host or amount we can inflate if possible */
>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> I don't really get the comment here.

I will try to reword it to be more clear .

     /*
      * Pages allocated by host from the guest memory.
      * Host inflates the balloon to get more memory.
      * Guest needs to deflate the balloon to get more memory.
      */

>> +	/* Total Memory for the guest from host */
>> +	seq_printf(f, "%-22s: %lu\n", "total_pages", i.totalram);
>> +
>> +	/* Current memory for the guest */
>> +	seq_printf(f, "%-22s: %lu\n", "current_pages", i.totalram - num_pages);
> Are you sure these are in units of 4Kbyte pages?

The guest can have a different page size, so a conversion to balloon 
page size is required - fix in the following patch .

-- 
Regards,
Alexander Atanasov

