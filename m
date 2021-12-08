Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4511046D07C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhLHKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:07:34 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51358 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhLHKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638957839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGiKdSGz354UWYa3Q/+tQ5yMu/Q0HX6tqfSQqE8h0Z4=;
        b=dKlXr2gejcvGA/Z/imq0NOhvxikzVh//3bsdXvsXgtYK7M98HD6NULuyNvzwmdXuJroxQZ
        3oWhU0EKW8507fEHMxOZOte7LuPMog0Ete2CMNY5DKI0j6XWLPdqHUThaCjRPfO8DimrNn
        Ngz2vAsNP7q6tCLZ2NjAOgYxdOAcLbE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-Zpfm9H2wMGqS7VudlUk5Lg-1; Wed, 08 Dec 2021 11:03:58 +0100
X-MC-Unique: Zpfm9H2wMGqS7VudlUk5Lg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l67Ansq19cvg/0bRLrtphI1698vtWi9QP+PvA7U00l9gFBCX36/UosA+0UOfPHODZzzHdi9BvNHukduZ5miw46DyRbDks+hHaMXkNe6dgkwLQGItIlZXztSX9y5+MGsdZDjjwqbIpSPmKWqjUmxyjt5uUwczBf/mcR6K/n2VTBe5HU6iCnpm7Dk+OjLuxyNJCnY7DPz6Ma8qjnYPBr5LTalgAOYf9OFhcNu78mtq66DRbYSlBXrX7g6HXLKOwwx7vWJYmCPJi/JnN49aYMZALwMej9aUo2SiDYq/lDuMJA4Psiqe0yA39FMd1dooNnVcxnl7vQUlqkUFqmNa8mKXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l64VxZsaslE6k7iHJkAVVCZUFcp/TALdTTTLuH5y6lY=;
 b=H77XX3H9OuaIIbjoOpdDTtxtSvOvamnqbqwkyORFoRGEoL5+wI/OZxW8CdvBWfG+Q5NeETYWiZqVgyk40O7MzwsUL5vrGblX4moAEzyyzRjMWy6FcSboTPesp93xoawJtWJKalX+gH6gsTeLOfoCeXroh5U8RV76N8OdTJ/2j37GDNvhMVXYzoulm8jHnivIjtuvD6QP5FwJwJZqM3mGN5bVP/wdIB/ocnekS9qFznmCsaL8qEs6wykFoxxHzi8IGSR+wIxCvc+rSH9j58QPvJz0ndPOJO9exdlCSwAIX/AjfQ4NZuLoTCyEAgedf6I4c1+/eoFBc+ngaxs6P7HCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB7PR04MB5401.eurprd04.prod.outlook.com (2603:10a6:10:82::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 10:03:56 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 10:03:55 +0000
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
Date:   Wed, 8 Dec 2021 11:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM6P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::26) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from localhost.localdomain (2001:a61:3b82:1901:9d6b:5ffd:1b6b:2163) by AM6P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Wed, 8 Dec 2021 10:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 666c0641-bcd7-4034-2862-08d9ba320bad
X-MS-TrafficTypeDiagnostic: DB7PR04MB5401:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB540172C2692BDC31F19F0529C76F9@DB7PR04MB5401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk0xdoYhdz5KO4CWFml+nIRyzfiDme+MW8EMhKpbvaBtfyng8o36igNMDhcbC/1MMASJNXWlxtGWopxgvRX5s10MSME4wyG6TH0/DKstGKLEQkOMuyxsIc8qvJigjVHjV/zi6TBqvFKXPhXTf3Mai36UNgnlbd01YU2YNiYJj4KFznf1u5+brGNpl+3BRoec53CHYVveKjUYhqQ9VAsrAi34OLxn850d8leT6PCArYjXLbLb3AJJKzXOXQv7Go4AzCn6xuF8FxpGCBXRBKlS0J9xPTdALcZUlbYYe693uw+yTyGOZLr1NAVmjD1sbpKN8yGrqr4yxVdWS5BRvThnjgL0XAN3Kk0Qv+1XKRX9ihkp7Nt3qcO92ZEQ18C7xA1bhyB5ZS/4mlD/wLD1Hy1/LCIELdbpTTyjQfMHf3M7+7QEtBtmZpuIY6XQWKyMjkaRnXfNtdmsL9s73uHdr4Qq0dkyuNFeAdSz6BLC1czPA936O8m3AXw6948UVP14AdiWMUDWQ/G1C1fFGefmWm3AEaUAw9kYgQfc4VePgTYT3Z9pLcu1NLqyle9umyFoZZYARVJPup5b/FPDx+CDN8PTMxURubpVz/z9IbWHJuvIyxTjrp/Nb79+3g3x/Do5dZG/ag2U+ewzwTw1KtC3z/qHxiULrMVYBWJrDNDma91o5Yls6B4SkXDMz9LgvNsZTL2xdeiiGtehr9Wh54mKPRV1DpxF/UzjeJ9ZMZmAYqTyEzwKPCiYBc2YZF7DAQYFuKTO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(31696002)(66946007)(36756003)(66476007)(6512007)(110136005)(316002)(921005)(6486002)(38100700002)(8936002)(86362001)(31686004)(2906002)(7416002)(6506007)(8676002)(2616005)(508600001)(4744005)(83380400001)(53546011)(5660300002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSbsMZQ6eRSuHieze1d2TzGiraK9oYFEAxHZnRYv9mF7ZMF5HqqxW0puObll?=
 =?us-ascii?Q?3M0RBVFIZkVRQz85YTZwbFrVN87Y1MzfnG7TBKfoQzB3b+6FEjHqwiKapjze?=
 =?us-ascii?Q?0942/i2ECUAXRZoMDbLnmu5rcu/eheeHB5XxbQQsUA72UAShR/AeYoWLiwm4?=
 =?us-ascii?Q?erLO5W3U+OIhdQYd0SO3RKu0Y8NeFEj5PpinZ1KjclGHZMb7uvX8LpXSQH9C?=
 =?us-ascii?Q?8HiyBgp6kjQpMhvRsQh1JndbqeJqCbisv1nODhXN33CDaE4fPuU6w2LhxbGq?=
 =?us-ascii?Q?Lw3b+a47gRe+l32wQT4U8allE3LniAtbQNQwdOqbvdbuNQGdCacHXJVLCZNE?=
 =?us-ascii?Q?H/ex7Dpyw6QxSTViDSBxmDxwHRfEdBdFYtP1VY4LNpOZn/eVDWnV7OeP1TMN?=
 =?us-ascii?Q?QpR0L3jcVPSq9l0As2Ru4vwiclWqaw7IFw0K5FNAZ/+q+5cpCJsJ2W07irrC?=
 =?us-ascii?Q?7VB8SWKv+tPBmRvyhlh3OGtsxipzmEOpI2tcZZ6WM188O0ZGBEC8tW9UTniW?=
 =?us-ascii?Q?sAqxnRFBShrTCso/EUV38GiAei0JiSXTcQMcdLZ5maUwQyqD90y6tMB0FlAM?=
 =?us-ascii?Q?xR8YKa/daNMrnSr272eJ/aRXLw1Et7L5l0pqvGXpMtQ+e32KUbMV96HEVABP?=
 =?us-ascii?Q?G9gReIHWsAzqytsZIEVgSbzn/9dbba19BbWnMppQK+5sSMWSW/l0dd064V1L?=
 =?us-ascii?Q?Kgf53JwnhLzSc6D2P17U+LiYIErr8CNDhVeN499C5dj2gFrQ1i8YZC3+LNeQ?=
 =?us-ascii?Q?L5wVPNSXlU7uPkKwPIkJzgcUhmDxkLi7uh1jkhtpV+t4Ps2QD01AasJ/7tTr?=
 =?us-ascii?Q?WB4YFcII1FlzgN7kEtRp0t2lxM0x5M1CKp3Ul8D+LPP0BJ8TildmrxWkn5QX?=
 =?us-ascii?Q?alTfQT1jGvWyaLxRLUxncXlvZMXxNcuQ98YhrDGaRJOX1xBm5njkw2nQN+ZJ?=
 =?us-ascii?Q?vgHjZKSbTg3ITuHnLgsagvdKY6wKnaqhiuLvkFG0YsIvRqEb5Iw5h5ZOD+9P?=
 =?us-ascii?Q?ww1NXGkGI85hVkwA0hZ+keqcaWlFgAuQOLjGdkb3Jn70LA3nFDkZffjB87lJ?=
 =?us-ascii?Q?eVQx2ElSU3fusYGG/nmSGSQzKwGpHTOZ3v2rI1fMHDlJL5A4MCulQ8iKV/sX?=
 =?us-ascii?Q?A+1n9uVfrDjHKvJQvUhzVEJpen5G7lDNgOjX+lIy3FdnsQKCd6VERrxhCak1?=
 =?us-ascii?Q?qdoMC5uPIUTD7NxrZLGe+Od80MjluXl+spO6t/b0oP64lZhfaTSZpX7tEUdo?=
 =?us-ascii?Q?Uiii2n694C0Rv3/Lb1h4RPTFx6QR4rGgF0yEDAKyh+n7OZjB2WccMYUkBU5W?=
 =?us-ascii?Q?6ZBkR1PNk+qaEQAHrkVBFpfLqpP9o5R/UCjM/un1IT+Kr+tM4FQVgRSQIAzn?=
 =?us-ascii?Q?0q2lCytSfi7ICzc1t/dY5pKjYctXa2yYewwY1WmIMSkROS9JY6PzCl3aCgAF?=
 =?us-ascii?Q?nXe0o/ESa9S9XuuBBqXPy6CpQN+rGC7MsUAwvfG+AapoM/h3TjgigY2yqybt?=
 =?us-ascii?Q?8JlaeioetPsd2t33uWCtTeAP7BCwiV72pf9JEsDFh1d7q1lLscDu5nV8KDi2?=
 =?us-ascii?Q?ijGYn3P1rRyraFR1Id18o6fAoh6EipHqWqPe6gQk+K8ZU8FBTSH1Kwz0VUp5?=
 =?us-ascii?Q?24d7aeD2OdAOUkfeqUrezTWsIRS/j5vHzj3kQc318bE48/gvf7FdZ1vugac5?=
 =?us-ascii?Q?+Z97zoetpSHN7c9VpoQaXA2kAsk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c0641-bcd7-4034-2862-08d9ba320bad
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 10:03:55.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjNwDPU+Fo5eJSrDkyYILtEf0YU0E49c/+Sxh2PqZ1gJLokiOXmSSrjs0IL78N4Np2uCGcW1Hne3BV6xNXUJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.12.21 10:39, Yinbo Zhu wrote:
> The remote wake-up function is a regular function on usb hid device
> and I think keeping it enabled by default will make usb application
> more convenient. This patch is to enable remote wakeup function for
> usb hid device.
>
Hi,

I am afraid we cannot do this. It will cause regression.
Consider for example the case of laptops with touchscreens
that will trigger a wake up when the laptop is closed.

=C2=A0=C2=A0=C2=A0 Regards

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

