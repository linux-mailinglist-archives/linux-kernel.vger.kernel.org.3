Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7615A79E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiHaJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiHaJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:16:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDD76978;
        Wed, 31 Aug 2022 02:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDHJh/hJTZK27LcuqbqHRiVLrnBljYSQW4RJ351QVK8ZIEiyZui6WFzya2k6sav94T2W+k6l8eQ18dMjeputbpWIjC7YSYyV57GcGClteQCTUEuc+7WPrOAnOdF5KeEhBypOS+nEi5FJeJ7PU3ZECS+R7OIErsqYmpCI6mkmxQMBWubF6hksguyyvvHtmdmqfxWjTFVomH7ZOjqyUQLm8hQHgxKOWIDK9l7iEIEWgKvEjjI/Bq0nuzuCNttUfoo/aBsRwl/ycRGFSZ1605uWFsJWwgZ05l+MV1WP71AG0XMwNR3+o2XKzX2wgDjH5PFnX4SfWtdHNPZLl7G4LdwSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94MoMYpOxma+6U14NzayCYpzuhxu2DZg0pqg3bljBFM=;
 b=d9x40enUOMZ2BXLldH81QEvz0oh3QFnRjsZhzmVrPtwoNcpxBEGOOaBcUQ8FUnDukCiymxslI1JYWPgwU4OjHWDpnMkTp+vb/jgfUbEXcBHqO8nA9ViKANp1env7i5l4A9yk0z+j400SN71IX9QvA83mdFteQLmPHrjYGIsPlmuYF/xEZZajbC4tWChJew61jWSe1rw+dN6mE1PZMhKBRSclMGgzuHjIQEXcvdl1iN4ZKP532jp+/ipopCnvqm+NLU6a63Mga7aeyyTo7Dy/zq1qKipf7byPsuS/lj0gnmZHIvdpP5m9Y2mk/EUP17zcIeS1mn4FqgICYQ/AE9cS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94MoMYpOxma+6U14NzayCYpzuhxu2DZg0pqg3bljBFM=;
 b=N+swkpI8qLGsFuhnNR9T9Thq4i9Tou70rVO4esTK10TgBvhXqaWU9F522FMRK/l2DxoSKdZ5oEQaB+CNJPobSTXIYK4mwfRGVEO5orSvBctBnmDWbwJ6QTydvhtPkJxf3FBD1DIDAprHj412EwB7BR16kHUVIsm7LMXltsm82yeAcK4todsrcEfLO7j2jCYgldP2d65YpsMN0uu2N1sE9NqnxcZZqLk0Ych9Uyfw2REN4ccHUv5C8NvydhIVsac9Veo1AxIRLWt1O0WjrBriQK2lM9zK2fm+IYv9CfgJlyvg94H2UFciDYFzKTKeu3o9uo6HmTc52vsEjiGyacVVgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 09:16:27 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::805a:6e4b:58e0:4d0e]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::805a:6e4b:58e0:4d0e%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:16:27 +0000
Message-ID: <60a08cc9-a96d-9453-1cef-a440527a79f6@suse.com>
Date:   Wed, 31 Aug 2022 11:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Content-Language: en-US
To:     jflf_kernel@gmx.com, Oliver Neukum <oneukum@suse.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
 <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
 <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0060.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::31) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c89b390d-5b32-4b53-22a0-08da8b317b58
X-MS-TrafficTypeDiagnostic: AM0PR04MB7172:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2B3qbkjzl+vHx9sRbvPVbJgVEKwv9OKxWGRDUfLTRjlBKds1H0+H0tIjiTQkrA6QVPItpRGTfrksYmguFqIHouk2gMyTfeziV0olkoMALZsvRow0yEqKTzUJpMdHpXhpI37/fyVyyGg8fJUMAKo8JC1k/jpzGKs4RHGurlCiQn6WmShIsBAsCgBrC3CCZGoR7ryfc8zea2d84EvEzLu7t5cIDoeHvREYU3GweR60foqtbQBovawsdwFTdobMVdRvDWH48pLa4CBryCAPHIciSn+p4jCj17/cQmMX8DbPkcA8KhjpPY6aIYDgwKbQkWjbVR2mJezA2uA1qRVzFjcHQKO5D4NOZJPwsDYPvbxaq0T0oR0qgxH5mh5sQ24dTjFBDnR6E1MsXZNP7G7M/Pdrr1T208H9a+2TQkdFoOV/EPsDMRZLi17iB0LiJMgFY/SCcKl8AR4XDNLb+AfhYunt+4mb7OrtkvdJ2lFNZZ/0UdGz7EED27CeWdOmq7QN8r4iTv7dWuKczfy66zYL8+mn3AzWpWHAYUrybvv7lyBaBQfEhwW1KXpTcNe08tjuk+QdNqAlXfbtJUygmWXjON6+Jj1i/vIN35FXhwLOEWpYlSgHMwbofIUEc2mj5miw+5a81OAn9t04a/n1cRUSns50h3pbaeZDMmnR6+QGotajQR2oLJz3dt8C3mmL5wDrcAxH5aK/MDUIEjp5lLkuWkLcdfxqWO6e/KjNFvz6hMMaZ8bkhQk/AEjM0wZ7gEsNEb/70PesySi3XqVwu89pPkSmSaEEBeHbe45WcQxkspqgeHgt3iB8muJdxQHYouhYloT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(136003)(39860400002)(376002)(6486002)(66476007)(5660300002)(66556008)(478600001)(8936002)(66946007)(6512007)(2906002)(83380400001)(6506007)(53546011)(8676002)(6666004)(41300700001)(86362001)(31686004)(31696002)(38100700002)(186003)(36756003)(2616005)(316002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJzeXpIWGNvcXU5YWJRN2hycnA2Z2hKZlRHVWhEc2sza3N4SEZza0duUVpO?=
 =?utf-8?B?V29qUGp4MG5XTk1OWXNKSndWamtUL2V4czFIQXpaeTFGSXBzRGJ1UzJtaktO?=
 =?utf-8?B?dFpnT0szTE5IQ1Z4V3AvS2xVakFicTM5dG9oWFhzNGJvSlVWT01LUkZzVFh3?=
 =?utf-8?B?ZG5CRC9KZFNhSXBGaWdkT21LL2RVT0dLU3ZqODJVZSsyTjZ5NzVEOFNnWmJB?=
 =?utf-8?B?eVBRY2JYc0QzcUw4eUVZOUNIK3liRHlEUnIybGJUTmlEc3Rxb055a0dBU0dG?=
 =?utf-8?B?YVRUQVkrR0pGSXhtSEdnZ1V0S0E4K1lyVFA5T0x5OTQxQnBpM0IvbTVxUC9u?=
 =?utf-8?B?MWcrZVNYQ28yRnhrb1RBR1JSdHJmbXlqRW1pT0VNaVhLNWQwUHM4a09ObHh5?=
 =?utf-8?B?Zi9YdVJUY3F1d0IxRmJTVlJUWHF5dFFndzRDNk1Ua2Z4RWhZay92SnYyMWJQ?=
 =?utf-8?B?azQ1eGR2L2FUQU9CY0Z4bEl0ek1zd1NPdC9nSHE4elRDQW5qYThBVUJTWmN6?=
 =?utf-8?B?MGZEVGNrNWhiMG5hZ1crTmpwZ3hCUHdYMTFxUUZ1UHZ6SXU3MENIc0d3NEhq?=
 =?utf-8?B?a0hFdUtCWG5EWE8vOU9jZjFvUzNZcFJabVc3VEFyNm5FSXlHQ2pVVi9zc2Zl?=
 =?utf-8?B?T3VHbDlKZzFOTlRWVDE3aWNaVStsVDFxV0QrUlNpNllOckdybkFOcjdzMjV3?=
 =?utf-8?B?SDJsQ2F5RjRnRGRTanR5Z1ZwVVBldkNqakc3L282YzZ3L2g1dzZGK3k2T0t4?=
 =?utf-8?B?bHBhNGVNNyszMzg0K2dJaTBqR3JtbWVaLzhIUTladHkwY2VvL2l1Z3pvYmsy?=
 =?utf-8?B?TGQ5MGppbC9XMTRGSllvSXNmbEtkYzQ4ejlTdHhFMmkzOW0ycjZYKzlqSGJy?=
 =?utf-8?B?M0FxYkZLOE9tN24zQTFmV1g0bWpXUEtOQjNIdit0RmUvKzlObXljdFJsRW5B?=
 =?utf-8?B?TllyMktaNXBHUEdGNGdXMXJWS0xRc3g3SjdFZVIwVHVNOTBlWTBKaUxKSll4?=
 =?utf-8?B?STF0UklxWEc4bFJoUWpwOVppNEgyc0h5MnZtcEVxbGhtWUpkRUNBbUNOZ0Vu?=
 =?utf-8?B?N1BCckI2TXNNM3B4aW5VZGh3QVZRQVFUcEpxZ2pSYnlURmh5U2QyV1BVZUNo?=
 =?utf-8?B?QmdBQUpSSWtpZk5seGNzTzhqSHlyRkdpU3dhWEg1R2dueWlzYVNBV29adklQ?=
 =?utf-8?B?dVhxWXZxNkNWUzZQSG1FNEFodFNmQzlabWJ0MkhvbE1wTnc0RmVjdGdXbXln?=
 =?utf-8?B?Q0RzRU1SZlRBYWJzaGRPUXlSTmNua3JTdEhMci9nYmdFL0daWDVHeXdRSm5T?=
 =?utf-8?B?Q0M5VFBsb2g4T0lIZ0dBL05mczUrVklYdkR4NjNtRXZjbnZwWk8rRFpxcHRt?=
 =?utf-8?B?MnpPa1RBVFRLK1JRdVZIaU1BMW5uRXV0MDNyTEc0ZitESlB2WExmSGxic0hu?=
 =?utf-8?B?NjgwMkFRbk1MZVBXMkpBc2lUOUlsZGtmMjhyeVRHbGJpUDRzVVlJVjZzTHpI?=
 =?utf-8?B?UnAzYTVUaFpXZHdWZE9ScjRUaUJqZUhpU0JNNWgwRjZ4aVc1Mjh5cnVtV0dJ?=
 =?utf-8?B?dU44TXE1UGY2U2xSWjdVK204SFZqSGI2RE90R1ZheEVXK3prU3lWbk95dC9o?=
 =?utf-8?B?UjhrejEvcHNjRjRsK1JNNEV0L0FPWDhDOVNtUGtPVzlTRC9YQjgwbnkwaExG?=
 =?utf-8?B?VjVsN0NvQW9jRFNLWk85TXN2SXpLVHR0UFJPd1NITTRnVGNBT3h5S3pVU1pV?=
 =?utf-8?B?TDkxZ2crVlVIWkZnakJZWU5CZHJXQ3VlT05WcnhIZzdRSWR6eXBJZEp5SXVB?=
 =?utf-8?B?eGFBNGpkR2lWYmtzUFYwT05Cb0tiMkNYTjJoRkdMeC9EUTI0UndnYkltYlFo?=
 =?utf-8?B?bzF6RGhMVmhNRTlySjM1MDhHa3VodDNZREdQa01TMklHWjF3VVpoRVIyRi9k?=
 =?utf-8?B?NmhlTXFhUjB4L2ZYdHpyQWNxQnBRb2xNMTJOR0NoVFdFUHAvZXZnb3VQL3h1?=
 =?utf-8?B?NlNjNmd3WUFmM0Nuc1NiQ1p5aVBtL3RGWVc2U1pnRkdhREtvK3lveFNtYjZP?=
 =?utf-8?B?UmxJYlAzUDVZRFp0TWpkWVdKeFdPNFhWd1k0bzV6amhGR3I3OTNDUkEzZUJF?=
 =?utf-8?B?aXF0UEhCSUtla2w2ekhXTlMzdXVXUnJyTU1ZaldHaWgxYnpSY08yQ3dOTEVL?=
 =?utf-8?Q?9RcOUU2d+UkACJiV5mOY9/A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b390d-5b32-4b53-22a0-08da8b317b58
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:16:27.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jerG5ASeO8sjT+eT8uJj7rxvJJAPrXebXRyCsqfXl6Vr8G7zLit3d+ll3cCcSrbjgWpvblfGspuih76r0JL/Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 21:50, jflf_kernel@gmx.com wrote:

Hi,

> TL;DR: the two VL812 hubs don't behave well when suspended.

We need to know the exact nature of their transgressions to inflict
the correct correctional measures.

> I have always kept keyboard and mouse on the USB2 ports connected to the Genesys Logic hub. They work there without any problem.

So they work even without your patch? We should make sure we are
absolutely clear on details.

> With WoL enabled in the BIOS, there are only two wakeup sources:
> 
>     $ grep . /sys/bus/usb/devices/*/power/wakeup | grep enabled
>     /sys/bus/usb/devices/1-6.2.2/power/wakeup:enabled       # keyboard on GL850S
>     /sys/bus/usb/devices/2-1.1.3/power/wakeup:enabled       # net
> 
> While suspended I can wake up the laptop with the keyboard and everything works.

Again, with or without RESET_RESUME?

> Moving the keyboard to one of the VL812 ports moves the wakeup source::
> 
>     $ grep . /sys/bus/usb/devices/*/power/wakeup | grep enabled
>     /sys/bus/usb/devices/1-6.1.1/power/wakeup:enabled       # keyboard on the :1019 VL812 (USB2)
>     /sys/bus/usb/devices/2-1.1.3/power/wakeup:enabled       # net
> 
> 
> Now here's the interesting bit. Without "usbcore.autosuspend=-1" I can still wakeup the laptop from suspend, but after waking up the keyboard is gone:
> 
>     kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err = -71)
>     kernel: hub 1-6:1.0: hub_ext_port_status failed (err = -71)
>     kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err = -71)
>     kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err = -71)
>     kernel: usb 1-6.1-port4: cannot disable (err = -71)
>     kernel: usb 1-6.1-port1: cannot disable (err = -71)
> 
> After that the port to which the keyboard is connected is essentially dead. Replugging doesn't help, I need to shutdown the laptop (powered via the dock) and cut all power to the dock to get that port back to operational status.
> 
> With "usbcore.autosuspend=-1", everything behaves as it should.

Do the keyboard and the hub suspend? Is this with your patch or without?

> I'll run some more tests out of curiosity to see how things behave in corner cases.

While you do so, which is a good idea, could you restate your current
results in a more precise way? We should have 4 results for each hub.
It is not the case that RESET_RESUME has no effect if you give
usbcore.autosuspend=-1 if the system has been suspended. Hence we have
the cases of

no RESET_RESUME/default autosuspend
no RESET_RESUME/autosuspend=-1
with RESET_RESUME/default autosuspend
with RESET_RESUME/autosuspend=-1

	Regards
		Oliver


