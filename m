Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF952D5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiESOMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiESOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:12:17 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4068F87
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652969534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsQJaLOJH6L+4i/V5NCZ1wNV2L2J1zKAHxp+VPeegqI=;
        b=Hh0YJ8ZZxEML8QSc/GLoSvT+g5Inh5U6KhbzXIzt3dMe+k0RyxDuAShQFVffR0FRopISoW
        AqUThzfHkWT96+X9IF/Dcuu068Z1X+0qFAJq2KjqMhfkNAyptX3dwS911RG/jDScy0zR0+
        0i6gLmuq3c3/3r2+h/xIOLVWSikfeJ4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-N9GCGLQzMxaXhfvPtsGRnw-2; Thu, 19 May 2022 16:12:13 +0200
X-MC-Unique: N9GCGLQzMxaXhfvPtsGRnw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBiMWnF8Nh+wpH47ouQhiYCneb2krGE3yZsB/N8igZVZ+c/eFrLpzwfQGlgVGT/pZ+7hIP3yamc4yO/Yfk/7sn9XiZonSwvFNh6KFeawrzgPnQaXXHiwOqF6E4G8dY5Snq7pNM22Z/1ujgxKOSfIRDcxFqYrY9t5W7lHZw7ScFzfGMcoQONUIvD1AVIyRw4qKlKbQKRFLCW2FG8E7LYJvKG+cTUXu4Xp/pbd7Z+KfbcmpVZwAnR6sJPWKozn8OBiGJ48AbTDmVrOkGVXkBHqIemncfynFUH62YmvGE4uhB7cI5OKtV5gZmZzqiWU6l8F34EOFmOt10RU4DM/zCAY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QaSf0OsR3k7FmpvB1htFwIKyLa0EmtSGQPNN5T75GA=;
 b=XIOVYLFxy/yqqqgE1mXed2BrNcDzk4AaBO+Mthhslpp1aGTsyul37dk8u7pwZHejedNAgHij0nqdrRzj+1AqO53ZtkV3KCBBX/rZljlJCuppIvpUHICvM/GThB4Q20c6g0+d7FUnEzLwJRyTQDO12r/IYWsBRhXTxE231u7/77wJ+ya06KDK8uKV7qOHBKQ3sB1XU1t4xmXvePqgQkYeE/ektcQ9bD6TfrZqnmUqGrEUX1QIhL2Cfxo9Em+kYco89sa7xBmn/jA5GoZdgaOmNG7WXW2KDBBcbEbW3jhwh/ASigDlVNzUTWLoV4zwlJ31XrrHk3dXY6KLnbqY6Mvc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DBBPR04MB7819.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 14:12:11 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c%11]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 14:12:11 +0000
Message-ID: <43e7a79f-5ee2-39d2-c86e-633864472e9a@suse.com>
Date:   Thu, 19 May 2022 16:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] usb: core: Call disconnect() only if it is provided by
 driver
Content-Language: en-US
To:     Dmytro Bagrii <dimich.dmb@gmail.com>, gregkh@linuxfoundation.org
CC:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519132900.4392-1-dimich.dmb@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220519132900.4392-1-dimich.dmb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::19) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63046ed4-5d1e-4631-8952-08da39a190e6
X-MS-TrafficTypeDiagnostic: DBBPR04MB7819:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB78195F4EE75875D4B2469A1AC7D09@DBBPR04MB7819.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJDNEcgem1q2oz/qO0g8EtAkdtUYqaXlFI+3WrdUfuGlE5ekHx8Rizf2dEQVeBVXAQsfQOWpkAulBQHLpTKr9fC7v/hIPLL2PecIqwUMo5GQ+ZfZDrRXaGZC4iGkw3ypdX9yzdjTQFPUb+4wdD6I3nV4pWPQNITXbiibLVLOiYoDcHZarFey3EK99cor2GDr+1jQSNA5h0AE4jpMnGh4IOFZ6jIWsJzFtn9jla4rlNjI3OSuFzgeuigCW8eSk+tctY3tE1+HikOfryKfyqGGbAxhrrkxIyVPTLCyO5RWb6VWs/NDA49AX4KtfA2CvdoZnscKwmwTqUjBZuHcwIKc8Ljwq4mBt1togUprHY5KmDp/fXyaRjBj2v62udoiYb4dQC+4b94+O4Z+1HmPRzAZ8XtVty7pf92vFI0n9T30xT2XedOPLXCCj5WN9lDTqVc+LEkxiAZLK73eXnxxf4ZyKUjVRUn5DUyKzG+OHrg4J8mXei+0gLK9YyaPj48uEoMh+Wj+lb3mdEin5AdgEVih8W3WE25kakf6Nv5nilOFrWpMTiVadrevhVWhrooSl77vtHJBDzKy6sAkM/KsVvWyuVie5TztOVLA3Aba+z7+Uxkpv9t31iTzJOpoZA0XqX3B69Q8we4jecHDmdFkv3mxb08wI4C7Sl4Ew4HYE3dEi1KpeQo3u9E5Iu9DWJDWL+kWJmhMehXLxJMCr9RJGU9KF/3+8ALzbFNC8pCLdfy07q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(508600001)(66476007)(4744005)(86362001)(2906002)(38100700002)(66556008)(66946007)(31696002)(6506007)(4326008)(2616005)(186003)(8676002)(83380400001)(316002)(8936002)(53546011)(6512007)(6666004)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PVMnEbo0UNkc/9RgT7kMbPHG+hEGfrtWDIP8DF/Nw4CoqogaUfDTvbepwYH7?=
 =?us-ascii?Q?CCYpizyMDGHDGb0GdK19D01L96dndqUb5gw4/s8DphAuVjvnHyCIq7VDnCqS?=
 =?us-ascii?Q?LqB+uEe8GfTLyiLTEcvNUVSDHQIePVcZfRdYeecRh3N3fc1ji27GuPsHusA5?=
 =?us-ascii?Q?pxOuImAfSORDnuJ0TB9YezIeHbJaeBvdUru7OkrIqikINCrbVmsA5/Jy1nFs?=
 =?us-ascii?Q?Ya63cj4orIielHSLn35kxIP6ch3f9w8eplg3Sv93tHjxZ97J+XyAMf8VxD6k?=
 =?us-ascii?Q?vPcKkZn92m6b6Xo4hMZH0fLuxPe0o5sUBZOGjTrc1RgPruK+cR92Bo5XkqYV?=
 =?us-ascii?Q?+IvywmkaYmOcZYpFcHjBgzGoIpDD94vXeBmaECVjGXrS5dW/iXPyDyFEFOni?=
 =?us-ascii?Q?ilFIROKLuIFj5PCbW+iM5UuI2XLnoFHyQWX/KSFZFcYmuOpmbZTNyiAG2/As?=
 =?us-ascii?Q?S8eR4YsChj3Fdm6tR6ka+CRaq3JJbvaIkVCAppF9wC/fiE+QRsQ+RMyW+uyE?=
 =?us-ascii?Q?Uekw/b+5yXh3scLZzfCxCLN18dvRvSNCThgK+94xCQpw3cHIRYBTKcYWcKU7?=
 =?us-ascii?Q?RtZO+8H95+1TMH4ysKUEO/pJ6KpXOUtdF1GxSxynI3RZDZnrIovuknQhcaTC?=
 =?us-ascii?Q?m6fl9DmMBiMvptdJkjcHumuKnxsPZVbe3dyZO9yH/bIed9+V19+cjUJg/pOq?=
 =?us-ascii?Q?+xzTHE6RLYgjWKElV6bIIJ1gXY1F0bQV6KCm4OoP+VKRuJ7v5++AwDSOErSF?=
 =?us-ascii?Q?twfpY+XFtUKzP1XVUfwY+E3piFGh6charQhrgMYW8NhuyKWBPbhoYZvOdVD/?=
 =?us-ascii?Q?8AG0yt+BcuK88pLjy4FmiTiyhxDmkvJy6Cz3OWM7MJrBYPEBjNrH7CebBXQg?=
 =?us-ascii?Q?Hvm9PQjIVeIkwY+uCL8qkkJOHyI1nqZujWLNFifk2ErPAq+yf8q6Bb6qlLJz?=
 =?us-ascii?Q?ds0OC/gGvgcDmUoL6ugl/kEnnOGqRPZpxYe8rfvyoXi6Na6DpxK4yuzdFu8g?=
 =?us-ascii?Q?th3Ez1v9iJOXN3IFPldAyqbVFg1yLtGGJZm+KkeE5T2PBCixl4NJFTvjKimV?=
 =?us-ascii?Q?4Vu+0kCtq7t+ixfNe88Oqwdg6/0kKBu1aCxYZ3J8Gc1HRwyms5MRbsxKyAo7?=
 =?us-ascii?Q?F47xCR1QU0CbefacIHpNtXQs1gotilbXx86l+DNwF3F5ldUtl7QWftN7cNaf?=
 =?us-ascii?Q?+DtS6w5gICqxUY8L8UjJAEZa37AEM47CzcpMiWKQ4HQlZNvQfFx6zcqrJCXo?=
 =?us-ascii?Q?/cbukPiBMwz7NW4IYsH5G70mqe6lb3y3SfCilSaLq4A2+p2SnD8XFGNX4S2K?=
 =?us-ascii?Q?OFmXDBHR7Yldt97NeFrOOuOYb5dBM4HY6KfYxxPTbN4k+LCVnfHNnKEvopvG?=
 =?us-ascii?Q?6Fe/HakbkOJvQAiaj/oERT4S/Ubxnm/zStxGAC7X5+hgBoiDm73H3hgxtb5w?=
 =?us-ascii?Q?VxbqUi+mwdtQCV+6R/SZCQnO1KOYGo5nhxkzbzvY+KL1iGJlWwKPSSn5FxFB?=
 =?us-ascii?Q?baSNTyaE1jPDQ7buf2mui99lkuRFvOFVN4JdlWgIQOFXZ5hYQe00zvv3RXBf?=
 =?us-ascii?Q?UXc7P7Tp3axY5VUcd71DA+eyEDyQCSSPz+rcIiKtHb32JBoycpSMQw02lzRL?=
 =?us-ascii?Q?EhtGSyh8jmt+9/XQFhUabzdPjB8C4mngAkZVqOA/R36D1qyVIjncLwHSOMaJ?=
 =?us-ascii?Q?V1KSprSwuoW4l3wHktqPeE8YUIROBcNbEF2i1DLnE54MykZvVWLUbZbtYzK2?=
 =?us-ascii?Q?MyGf4vMqorQW83xhEu+KRQGXARHUuQ35VJ5L+U3wp+A8Xzp6EDBw6EAYs2ge?=
X-MS-Exchange-AntiSpam-MessageData-1: xcW72QIp9eFPnw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63046ed4-5d1e-4631-8952-08da39a190e6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:12:11.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1/G5VGsZPO2HIBEc797cnNSfmcuUwyhc/lI2CaEBCXgzB3hjUf0wXYEi03479td+gL0R64t3wG4niNHxcEWFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.22 15:29, Dmytro Bagrii wrote:
> A driver may use devres allocations. Disconnect handler is not needed in
> this case. Allow such driver to leave .disconnect field uninitialized in
> struct usb_driver instead of providing empty stub function.
It is needed. disconnect() means that you have to give up
ownership of the interface and must cease IO. That cannot
be done with devres.
I am pretty sure that a driver without disconnect() is buggy.
disconnect() is the one method that is really not optional.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

