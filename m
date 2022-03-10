Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88324D4559
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiCJLIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiCJLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:08:44 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6A26561
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646910460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUJg+1N/99gLUDTZmBIvhtrnbauR8YxWljXSIATBjIo=;
        b=G4R299EuewSRABsjAt3XfFr2ieSs2gQsKhIP+kgvsRdeFyV9Y+d0aO3dNqllQ6FVxH5a4N
        HbuU/3trQ7E8IAyWnL8FMs21dyoC3PWjT2a2hbMf8WmCS0cLPuKewX3AOa0DeQvJzcFa/H
        ftSQgQwgWVD7T9pN0DwX5k6STqn1l6M=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-Su6MX2XlOa6Y4lqsBsDqEw-1; Thu, 10 Mar 2022 12:07:39 +0100
X-MC-Unique: Su6MX2XlOa6Y4lqsBsDqEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWvZdqzkFUnn1on4QZ41eC3KKGcpWTKqNjms+kYk38IkPWmdTZH0UXINfFZUFcleD0tscGlXj4InWeVUNqTYIlPYduc0wo9l6YueoLg4lELmjmeZ/3LkivymghaGstag3VoJbqQsr5Jzh01rZFCrTyI9mu8sEevZrMudYQr+DmlGRQlx0aaFl3l7E4aNL6w69xUZuCq/Vrm8svNj1GOOk6jBhHNXMf+hLoTtoahZYarcPV/8ybZOCH+uaiJEX4pUYkYY+a9LiqK3Z93yEGmTo+3N3y+gKJfm28/ysEtdHjYaNxGHZVp1LW4Pe8dgGXx/+85RdoDwROTBaUwmxpWv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUJg+1N/99gLUDTZmBIvhtrnbauR8YxWljXSIATBjIo=;
 b=T+GsGyngj24u4IbfBcq4A2PItevBLwHsNMPs0dZPFOrNhFcfURzKPC//q5VotaUWmToksgOG6uRlFkmODvrG5Siud4nfodistrqyEZedqCnIL3TRbq8jFidIgRXNwA0pSZgNV5pBETnnNxdash5dbyrCPMAeJB+O/H143HBvwEajbVFwt3v4lEcdZtjs26jqLOTCOzXuFnNSn2SFunadPszrh7sP76yRPVSggYVKfhRRej/qVLVOY0ziZo5LLGstk24ivd2Yj3wZzOexFGalEwa8A8Qcgt3RBKj4oq0hc/DOIuYD6qGRBGFJ/6MPiyDAch7Azj9oDk7+o3k5rieGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB8PR04MB5610.eurprd04.prod.outlook.com (2603:10a6:10:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 11:07:36 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 11:07:36 +0000
Content-Type: multipart/mixed; boundary="------------IZrTjA0T4QpV10hoEQid9cq8"
Message-ID: <602855d8-9c9c-ad0e-3aab-06befb0c343c@suse.com>
Date:   Thu, 10 Mar 2022 12:07:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Oliver Neukum <oneukum@suse.com>
Subject: Re: [syzbot] memory leak in usb_get_configuration
To:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
References: <000000000000351b8605d9d1d1bf@google.com>
Content-Language: en-US
In-Reply-To: <000000000000351b8605d9d1d1bf@google.com>
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d658f61-ec73-4356-dfe7-08da02862ea7
X-MS-TrafficTypeDiagnostic: DB8PR04MB5610:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB56108966E329C529556A8482C70B9@DB8PR04MB5610.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfxwvNHw7Af+NtK+Pv+KKQwMpb8FsTfLXPL9Fm968oVegBgIuh7mVi0BGvsjdeZnVBrZbb2rEVSsd7U179MlfQ59NDbvKKCcVIWwCnJdF2GJRnYXwfZEVA3szC+deyDyK23gHn3rMqRgn5aCA94nd017pVsmgqd85PuIVsHShsQQlsf3hJpnbKztMYKAOwjGhAaGZ0N0sWFt7O0/5jyBr+58Jh+Bjpk4wQ9OHuZf35LGt4SjJ0sVjZiqh0o+mHZK6xjeOAGACCtGZ/E3HtPLd1MIArdHC5QezIN56yemQYuxmyrw7I21hk0Kdz12hmqHTLi3y3owClsBeGIY7C4ER/5ht5dsZ0110SI8g3burwREyBCOo5eJCFq5hiD1K8J2ucXnULnM0JD5xxJ1IQUWdwSO0g6B5PxJ1x7vM8bWv84orZkga1AG8RuBUIwsOI9iyFEcOGn6TA5yMidWksn3DxaTDqLlKRI+o83YT/iwyBYfPP/m63scBNQPbw/EwuTmIK0RlnfsjT6q7mVLFrHfQ0j1U3K6TsIDM1LPU5T8XSxJ5hP7CGyicq3Mi3HeFdDK0x0xVKp5pAL3BwKVkpnVgPuEp3vPAC9Sldbipg+eNdmzwkFvhVVYBrWfbUOgThYiW1lAWlfBcb5s1r4B6oEUOmPo7ZNxDf9krAh4m/nXOWgRwyIJDKNmpM94YMQtM87sLquQc/9Qu8vSbGm0juCmj+W15KpJaajwYls2s4qYbNn8C4Sxb8ly531latoqp65YOVijDU+S+INkZVdnmTLv4b+IzVkn7jl0W+9rUNg39uBgl33obYfF5x3r8nm38iRe3/WqWQe+dbIztYeRVJgvCIpGsUIRLgj1GvJeqtKvtjl7n41cCPsjLOobsS1MuQIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(235185007)(8936002)(8676002)(38100700002)(66556008)(66476007)(6666004)(5660300002)(31686004)(66946007)(2616005)(2906002)(31696002)(508600001)(86362001)(6512007)(36756003)(186003)(33964004)(6506007)(53546011)(316002)(6486002)(966005)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJaVGNxemxrenJ2VS9tdjFac21ReS9jWUxDOU5HM1pYemM4RHNNVmpmcjV3?=
 =?utf-8?B?RmZwS0tQT0NUeXFhbkRYb2Vvd2NHWUVjalpDN0ZVR0dET3F3NkprZ01VeUxL?=
 =?utf-8?B?QkZNa1hyalM5a2F2SWJuRHkybDZlaTlRWlptY2draW4rVnVUVTlITUlxdlZX?=
 =?utf-8?B?VmJiVyt6SW5vdEswQ1pKQnlyUUdTUmRXMStnbVFzd3J4RytpNGsrd09JQ3o1?=
 =?utf-8?B?Kzc5b3BoZjB1M21TSUpCanRJZUp6NThOYUduL3FzNkVuOHJHU0hNTTNGclAv?=
 =?utf-8?B?OWkwYTB5WU5DR2dhUnRZNXUwc0hMUVZTOFFEdXFkazlWUVFrek41YzVKNkkz?=
 =?utf-8?B?UFMrYVQ3bjZHcTM2N041TWRMVWpIVUFXcWI0UnBITEc2OENrVUFVZFYycmYy?=
 =?utf-8?B?Y0dZVm0rSGdkcHhMcW5kWEdwOTZTeVl5cUdDQ0VJZjdIelFWbkxCY1dVR1ox?=
 =?utf-8?B?bFhxSFROZHJBVi9rY1R2QjdTLzVweHFCbmlDMStxK01PWXdZSFVLVTJQRzZa?=
 =?utf-8?B?cHVYMEFSV1RRa2ovb2RwSGpGZDEzMVlueS9UUWZ5REY5TDJ3Y2tzNDZBbE1R?=
 =?utf-8?B?cHM2aklybE5uZkJkUjJML2wyaXRnRGhtdmtmMFBMWjI2YWUwUnlxd2VmV3RH?=
 =?utf-8?B?SXRmVDRTWTNJSzZRY3ZWY1EzYTNNcFZBbDc4ZVhxQThIeUlsMjgzZFNmdDk4?=
 =?utf-8?B?aTZBUTlrMWFocTZnWVZQUThDQ3FVK0I5UWJzS3FvUTNiVm81VGQrbEliRVh3?=
 =?utf-8?B?QnAxMGQya2dEMFFGRFpia3NwWVgrTjc2NyttSVJOaTdhSTFKRllRcm50M0Z1?=
 =?utf-8?B?VkVxRWEreHd6aVhLbHZ6OFNKakhSR3JHdWcvTlNGR3JWbVFzQ3dvdHhJdmtn?=
 =?utf-8?B?S0ltMTZzQnlVL2h1TVN6WWw0Z2YvQU12dkhJR2l4cm1ROE1xRWo1WFFvdVhi?=
 =?utf-8?B?V3RUeG5laUtqdDVxVVNDcUdLME52cVUzVjRhWjVWK1RadGVsUEh6SFl6WTU4?=
 =?utf-8?B?c21VK3RvSDFXZG9hMk4vUW9FMS96Sy9ZbUhmRTVpQVEvejgwT2dpZWhOMDBS?=
 =?utf-8?B?QXQwY2NPUlEvemJwMHNwL09MdzExUzR4aXBzUHNzRHhYamppMUFtWUVTazc2?=
 =?utf-8?B?U1Z6Rkpjd0xTdkpDeWVyYU1LRzlDUEdlV0wvNWh0cDNhamRkeHdPNDJmTjN2?=
 =?utf-8?B?bnhlTjdvSCtuaUgrVDJSb3NEaEdrSElVMjU5SWRFWTE5ckYxaVZEWWpkeDY0?=
 =?utf-8?B?QktHakQxRHZDYWUyTnRicW4wSlgvTklWeXV5WGN0ZlVGWjV0T2EzbEJLUmtq?=
 =?utf-8?B?TGpIU2tkUk8ycjJPMy8rOXBXS0ZtM2JhZDZMZWlIZHNWaTBUSlY5VFNSNzV0?=
 =?utf-8?B?NWpQOEdVTXFyR1hUNTFGNC8yTTQwOWUvcUNhSlF3UktMYjZWVVVtZE9aOXYw?=
 =?utf-8?B?VDkyVDBiYU00QmswU2k1Qk8wckl4M0MzZGE1bmorYVpvOGxPNUh3c01xKy9K?=
 =?utf-8?B?T0lKT1Q5ajhTVGJOOU1Ga3BabGwrUVZYemVWYTRBbXdyWHJlekNZaGR3S0Zi?=
 =?utf-8?B?and2TXhXV3pscUljQmRCcXd0REtuSE1QcWRZSEJoekQ0R2I4UVFWYW9ZNWdl?=
 =?utf-8?B?aVFQOVpkbVNyYTNobXZFZ09XNzV6TjRVT1RrYTdIZEVSNStMNis1Z0lvN0FY?=
 =?utf-8?B?S0hpK2hXUDVTMTBsWFMzRVpOdzNSVDhaTEh3TTlac0dYU3pnaWZST3dWRk5p?=
 =?utf-8?B?eVU5ZThuR0lQV0RGWnpDSU1FbmlrTXhjcnFzMDgzSFltTVZ5cTY3VmM5bFVr?=
 =?utf-8?B?bG9xNWRzamt2bUFkcHNJTDNYMGpjTzlHdXRCUGhEN1d1N3Bia1FCekZlelU3?=
 =?utf-8?B?ekhzMVJiM0MyTm5zeTVwMXgzYTBXWThLaHZzQ1ZISlBydy8vMGJ1aHpXQWdS?=
 =?utf-8?B?ZUsxZ2NmVFRBZDl1ZXVBWWtUUERsbStJeDN0SWp3R1JneHI4aTgvbFJuTXJL?=
 =?utf-8?B?U2pnVXhla1hhclVkVFAwMGY5b2pmcldlYWllamtTQkVSeGhGajllTzd4UzFp?=
 =?utf-8?B?OVZNdEFBRTVuWTY2TWdxcWhuSytQUjhVeEpienBBZzdrazg0am03UHNKMENN?=
 =?utf-8?B?VlN5akRXSUYvYitkRlF5VEFLRzIrR2o1SVMzRklUSk0xckJRaGZYZ3pwdnZG?=
 =?utf-8?B?VDlYb1pSSTkybW1jdy9GQk01OC9tcjU2Y2dCK1BWd01sNkpQK0lsSVJIUlF0?=
 =?utf-8?Q?aJqP1xHBcoQXdCmy/OV6oL5l+wabOPU+0bjL8OW4bM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d658f61-ec73-4356-dfe7-08da02862ea7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:07:36.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49qRNbNwMwwHr2167j1yXziTzmeCBS0Ps6N1HLej421r5ON9benS+cOR6lwVM6C5TL8zIek5gIRKe0bP94Yq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5610
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------IZrTjA0T4QpV10hoEQid9cq8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10.03.22 00:54, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
> dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
>
#syz test: upstream 0014404f9c18

 

--------------IZrTjA0T4QpV10hoEQid9cq8
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-USB-hub-fix-memory-leak-on-failure-of-usb_get_config.patch"
Content-Disposition: attachment;
 filename*0="0001-USB-hub-fix-memory-leak-on-failure-of-usb_get_config.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ODU2MDlhYjBkOTVjNzUzZGMzMTI2N2IzYzRkYTU4NWMxNmUwMjc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUaHUsIDEwIE1hciAyMDIyIDEwOjQwOjM2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gVVNCOiBo
dWI6IGZpeCBtZW1vcnkgbGVhayBvbiBmYWlsdXJlIG9mIHVzYl9nZXRfY29uZmlnCgprZnJlZSgp
cyBvbiB0aGUgZXJyb3IgcGF0aCBuZWVkIHRvIGJlIGFkZGVkLgoKU2lnbmVkLW9mZi1ieTogT2xp
dmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9jb3JlL2NvbmZp
Zy5jIHwgMTcgKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvY29uZmln
LmMgYi9kcml2ZXJzL3VzYi9jb3JlL2NvbmZpZy5jCmluZGV4IDQ4YmM4YTQ4MTRhYy4uNTQ4Y2U1
Y2E2ODQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL2NvbmZpZy5jCisrKyBiL2RyaXZl
cnMvdXNiL2NvcmUvY29uZmlnLmMKQEAgLTg4NSwxMiArODg1LDE2IEBAIGludCB1c2JfZ2V0X2Nv
bmZpZ3VyYXRpb24oc3RydWN0IHVzYl9kZXZpY2UgKmRldikKIAogCWxlbmd0aCA9IG5jZmcgKiBz
aXplb2YoY2hhciAqKTsKIAlkZXYtPnJhd2Rlc2NyaXB0b3JzID0ga3phbGxvYyhsZW5ndGgsIEdG
UF9LRVJORUwpOwotCWlmICghZGV2LT5yYXdkZXNjcmlwdG9ycykKLQkJcmV0dXJuIC1FTk9NRU07
CisJaWYgKCFkZXYtPnJhd2Rlc2NyaXB0b3JzKSB7CisJCXJlc3VsdCA9IC1FTk9NRU07CisJCWdv
dG8gZXJyMjsKKwl9CiAKIAlkZXNjID0ga21hbGxvYyhVU0JfRFRfQ09ORklHX1NJWkUsIEdGUF9L
RVJORUwpOwotCWlmICghZGVzYykKLQkJcmV0dXJuIC1FTk9NRU07CisJaWYgKCFkZXNjKSB7CisJ
CXJlc3VsdCA9IC1FTk9NRU07CisJCWdvdG8gZXJyMjsKKwl9CiAKIAlmb3IgKGNmZ25vID0gMDsg
Y2Znbm8gPCBuY2ZnOyBjZmdubysrKSB7CiAJCS8qIFdlIGdyYWIganVzdCB0aGUgZmlyc3QgZGVz
Y3JpcHRvciBzbyB3ZSBrbm93IGhvdyBsb25nCkBAIC05NTIsNiArOTU2LDExIEBAIGludCB1c2Jf
Z2V0X2NvbmZpZ3VyYXRpb24oc3RydWN0IHVzYl9kZXZpY2UgKmRldikKIGVycjoKIAlrZnJlZShk
ZXNjKTsKIAlkZXYtPmRlc2NyaXB0b3IuYk51bUNvbmZpZ3VyYXRpb25zID0gY2Znbm87CitlcnIy
OgorCWtmcmVlKGRldi0+cmF3ZGVzY3JpcHRvcnMpOworCWtmcmVlKGRldi0+Y29uZmlnKTsKKwlk
ZXYtPnJhd2Rlc2NyaXB0b3JzID0gTlVMTDsKKwlkZXYtPmNvbmZpZyA9IE5VTEw7CiAKIAlyZXR1
cm4gcmVzdWx0OwogfQotLSAKMi4zNC4xCgo=

--------------IZrTjA0T4QpV10hoEQid9cq8--

