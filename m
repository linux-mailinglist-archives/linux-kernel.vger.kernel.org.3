Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B405083FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbiDTIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376917AbiDTIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:50:26 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029501900F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650444459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQnDmP0nUdAwnB9g+ISUcHiZ/HxphpMbLyEL2Ra8sj4=;
        b=KbykIpuB58tsTlM16UHD4LEyGfOSX3Ct/vQj1MFeYKZOXYCrqnGmhCI7Gh7zQHJ/OFrh0t
        1o+VqqgLOQ/pvxHre4KvGKKPW9CPugo+8ByxJ46naC7RXOjY6dNw//25jExBcIyG/q7nIH
        OaqJ3KEuYbOCeopTGoPI0ut5aIXWmFs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-92iwyWfGNxC4N0MKaXx9_w-1; Wed, 20 Apr 2022 10:47:37 +0200
X-MC-Unique: 92iwyWfGNxC4N0MKaXx9_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM/eyMTV3qqth6OCVm9THpnfiHHH64pYOT0DwMf8qDHwAvagofjY72Zw8hXv0+Wzvr5CgJob9Ckw/pY1B24hb76vQZa/FUfDUxwaZDasrT8upjMX02dOl3tJ0CWBP9eUvdZRhFkpzzSKaNuXZ0nB2v4Pj5ya/kAqqZAfH/Pzfyw57r26Qebtc/78FGF9W2wDr8n5US4zeuih1Sm7yAt3yr/30NVJ4DZk1OzyhAfLyV9+k+uwcbG46v9dGxmoMBk0ytttDbmtYZAephY05+eiz3OMQDmh4DKVzeLOeMhraJsQ319bE54RkPHoFDEfiVBiIbwDUzkWtHOZUwaMYI66eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGecOPNi+hVqcN97fXUOCvr7CijOLk9cVzM207WWta0=;
 b=cOcEo1/7YM6ziJnjc+vWPPpaLO0KUfyBxvdwrWYVBfcgzmoJTeR6Ts9k+JDHASimPrmpg8MmAvgGu5j666NevPYtwKuvvgZUN8j8++JuYxhXYe3AHsS6zN9jhzOCFObcaMyo+vJmz7mLwYbOosoXE6+OZ/awskhYKhry43AlgSmC6Wk3sW9Chlo3iUfzy9Oi/KUfA9aWdTV/opBG0zdD3SbP7wyEadtv2+9Tv7BWFkAALdb+Dhk8MrbOM000uSO2MIcG9U3UtMVaZbSW2OBJp9FQ4RU3CBejuaDwekNeoqAsEZ22KG7hfi8P0g9IofFT7/ksAim9hmTj962dU5p5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by HE1PR0402MB3417.eurprd04.prod.outlook.com
 (2603:10a6:7:7f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:47:31 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 08:47:30 +0000
Message-ID: <95e1bd39-b159-f7a1-f51e-115dd0e60500@suse.com>
Date:   Wed, 20 Apr 2022 10:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] USB: Quiesce interrupts across pm freeze
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
CC:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <9f2752b5-8717-8ea3-1462-69bcfe42bb0e@suse.com>
 <Yl7Iz/lGk3fITzMK@rowland.harvard.edu>
 <8321b2c6-5bdb-2853-6812-50cd4e4d1bc7@suse.com>
 <Yl72GjATzVoJpSlA@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Yl72GjATzVoJpSlA@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::24) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1dc4d29-f343-4a7b-087b-08da22aa6784
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3417:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3417505354E0F9E85943AA1CC7F59@HE1PR0402MB3417.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pthv6QpstBQSGEutzkUUfLroRTXRFV0xU1bqkS9n6T/KH56PWzEAkyGc7MP7tz5xhjHB1MWAcikVgJ8AypeuB0oejZqAmgU16eHeahLYLHBgWk5y5tv5X6ruW5M++jUAXJbPVOsuC+b+6EIztZJAjF0hyeS6qsTjJeYYR3TIlUdX7tPjmTRv7gyR343K77m/TD+fL07x/mClJSctRxrLRr9G+1ndO5r8yDEl9Zcv4NTWee3s2JcuopPG86mJWrEKx+Hd+mguQOFDRrO3Zf8KVhWxodR0su2wwOUH1HOBzaq9HgDt1aD/ZJGvPZgWjVS0Ch6Y9IoH9NSC8iLgE3hVvj15uUXSJxLCIdtGGv4b5lHcLjNkU1RRRKOnkVT2Ozc8QRatSKWEZ8SzXhHl2PWsHHoZ0EkGP5307Y+jX2LWV9lkt9k1wJc2U+3zEVST4RTN4jyPEvYMNrmv7Tz9rkpOEsgWL7T+AhuOPu+jTLeZ0kkAtnk14AVdjJr7O3SqHhog4vqwr+Dxz1DtLs+3pStxiKDn9UEiU86V67AiAKC5BJl9g/mfSR5qj7c2nfAIdkdeJYXmWEr/K1DIbS6/PU6f/MZf4Cwej6KQhy5mcR36aGFL4aXk36BWLAfjlOLGNEhozpBBryS8Sp7Oq1rAVIZvE3WOQYqUECbyRCsSlNi4pi3FXBWl7v/XWpC+7/3JJOzB4aMf4/iTX4ga6Tle3BOQPD2hlhKEWq0opq70D1XDL/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(508600001)(38100700002)(83380400001)(110136005)(8676002)(8936002)(6486002)(6512007)(7416002)(5660300002)(4326008)(186003)(31696002)(2616005)(66946007)(66476007)(54906003)(6506007)(31686004)(6666004)(36756003)(53546011)(86362001)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VFQyiLAo3322/62rXHiLt2dOng+RAjgg7gf8bTrk5jFeGpEO15VmnZCQDC8E?=
 =?us-ascii?Q?ZYeYJ715HZH68ypdByfA0jzGfDj2y9ypQ4Q3WWEmSbPSd+zbKixk1K4oV+wW?=
 =?us-ascii?Q?D9DFKvXwQa8KnggLSVZsxZb5ngn/PvoYwma3xzN8hTK0fH7yIhE062JSDenj?=
 =?us-ascii?Q?myACeTCcl93lqhOxQ2wHbJylRvHHB9XpYbk8rU8PRFVbN4ZhxVoNf8htgBaw?=
 =?us-ascii?Q?0koHDsc8fnmaG9hTiAiww50Ed7Bl8PubNKxU/D7DrhaLcRUe+cZ53vIxnnx+?=
 =?us-ascii?Q?O6QYdbLZWcqAkcZ8nIkO2VD+zbC9/r5n1016Sh5JrykbMn1tA3cqD/oZm9LO?=
 =?us-ascii?Q?rDL5F94H/F15cDaa5YMDZ+oAma2ssf27zSeq02U9DUaIUjMiYwb/8o+ccLWG?=
 =?us-ascii?Q?887TOszV7dLd8Te6vxkZ1dVcfWWuUA3TMNNZplQqut49L1Y7MdtdQ5y9/pto?=
 =?us-ascii?Q?RRFewRZo5+DAGQQXIrK7lllTmFqq+LL566WqoA83meIPFpahAO7LXRYyIQnV?=
 =?us-ascii?Q?8zZYH8YjtIVnkILqCFoEzw0dc31A5AvXVL2RS5J43s06E5CqrGZkdI3ELyBA?=
 =?us-ascii?Q?XTxUqrKES2LR9Mr2uRH+wMvnW0u0WDYDeJprDeAqp6GsCaysHrFToKfKTJUZ?=
 =?us-ascii?Q?hxKZXj8PYk89tfrr6M4wAkmjFFy1whmymquMdO1snz6oI/Jne51EOthsATRx?=
 =?us-ascii?Q?RhjlNu/mvec5dK2xGWQf4ituRqoyHFa9uCVI2ZUDANG+Ho7vChAJQEY3/kAb?=
 =?us-ascii?Q?oAkyygvZrnX6Siw05XuzNfE0Pk6OWfNlTwyWcBH0M7QqRQ31UdLK2jE97wAN?=
 =?us-ascii?Q?zACPANI2bCLW4YnGLLfz9SEMBIFgRisNByp2P6vWTjWcW+AScwjmx0Yw+T7x?=
 =?us-ascii?Q?sL/FrMCFNuQ7KUbMLfNE7IdmXlzeczsX/YZz+ERSf2GlFJg7v/TGdkfFUOX2?=
 =?us-ascii?Q?OJY4lLoOJsXJ1SpiDOWlAXicTYbTEWCTo2wjoJU+KwWCOynnr3ekHzcd9YKC?=
 =?us-ascii?Q?EfTPb9KQYwRci6EKiloBtCLcBmV0FXLQjZlW7Le3lwXWGaCufgIxMotDcB2N?=
 =?us-ascii?Q?4SGUxyDOqI4Wcwvzs77UDIqsMAQHqXeT5pswtTtuArTNk8RQ1JyJiDXqshvk?=
 =?us-ascii?Q?ganfVm8JeSae2ab99zpspy8hSxaYd8vvzdLk8wOytT/dw/BlGL7q+avJq105?=
 =?us-ascii?Q?0lD1KNPDiQFfyrfkadoQDme4gMwreItptXzk3Sh5SwhqXQaVyGVlLoax3Y88?=
 =?us-ascii?Q?bnTx9WGo1cVMXN9dDQNUtfo6dLfXGJCcrkuV0HyqmJOVGGE9m53ZZOCv34g5?=
 =?us-ascii?Q?KBObM4flwo7CfYaG7rpGVnLEiPcZbjQzzf5CXruVzEZu7PpiYim5XJvDK+6e?=
 =?us-ascii?Q?hSegGx5gWazM/n1rLAaLn9G43KvGXgDPITrI5zBsKf25V/IUUJq4kBeghJ4u?=
 =?us-ascii?Q?4TdJ9dhyW0+1Mwt4l1DN1ZGvMVeQeAAv+0ew63kpjjYfeLIWEeDA+NDG3iIS?=
 =?us-ascii?Q?tOsTrRTKCOApsvzIHnVOxXzo8scWU7EwfglWnw6mdXydrwWa9rnfvJUmPRRU?=
 =?us-ascii?Q?4hRkNeodDUYmgfm+O2+mrWh9Kbc8DgeJwt5omoGvM+blx1tPH+bkDlukVVwz?=
 =?us-ascii?Q?JWuEP2FH1JvErLpJGrw9gqQApPXE+p+LKFw77aipLZ8hlYQSR5fXvrgMIpzz?=
 =?us-ascii?Q?bYexd4wpBUK+fO+nP1/HIZ5wdwVcsFzxWi9T05TdnrdQVVvkFqYHQuUylJ3s?=
 =?us-ascii?Q?E9pt9cmJMOutlvkN/363Jmp0oUqBF44jEZRh6SmlfYpsYUmunoFfKjFq43nO?=
X-MS-Exchange-AntiSpam-MessageData-1: gYBvb/ue+Pwg5Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dc4d29-f343-4a7b-087b-08da22aa6784
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 08:47:30.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wElMwABTH3s45VQif0m7eu9QDI2/kfT++430WtOdQiSxv4p2bCwsup0If5KJx/8I7Mt5DcdFBTYXigYmKOLfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3417
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.22 19:49, Alan Stern wrote:
> On Tue, Apr 19, 2022 at 05:51:38PM +0200, Oliver Neukum wrote:
>>
>> On 19.04.22 16:35, Alan Stern wrote:
>>> On Tue, Apr 19, 2022 at 09:05:53AM +0200, Oliver Neukum wrote:
>>>
>>>
>>> The THAW part of suspend-to-hibernation is used only for writing the=20
>>> memory image to permanent storage.  I doubt that a malfunctioning HID=20
>>> device would interfere with this process.
>>>
>> True, if and only if all goes well. At the time thaw() has run writing
>> the image to disk can still fail. In that case the devices will still
>> be needed.
> Consider adding a mechanism to usbcore which would allow an interface=20
> driver to request that the next time its device is resumed, the core=20
> should perform a reset-resume.  Would that help?
>
>

Strictly speaking no. We already have that in form of the RESET_RESUME
quirk. The broken devices we are talking about here can do runtime PM
perfectly fine, if and only if remote wakeup is requested.
So we need that flag to translate only in freeze()/thaw() resulting in that
behavior, as opposed to every pair of suspend()/resume()

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

