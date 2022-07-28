Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62E583BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiG1KV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiG1KVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:21:25 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2116.outbound.protection.outlook.com [40.107.11.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A732EC4;
        Thu, 28 Jul 2022 03:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzQ9UXCfWmG7ONoblVAJw8f2ZxADZRFA4BbwXYpnio+NKzxmR6p/dCGD1mB64hZASWe/gpPcp7ydM8URoEQj5be+Kge9MErFT5KSI9bwL3UWsdQLqeUXu0umx6SaZvRKFheYbhpIH4QR5HCXI5k0En/dHEGECAqksKiN6B1BG5xG/M2PZueDwQy/vvXUkYagGQthK4Rud+6IAvMxrUeaTTgY8SKMM7rGRFVRQS7UH2BAEh0eLo46ipVDzaZPhw9MsrxX+F1Vm+nJhh96wF2BJBd31RVt4v7RMe0DO39QqhfRYDBVRXCQoQrThSxvTpMWuj/+m7CiuPRWBNERlmrS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd7LNDfI+5j9mne/9KHunktk5hz0heGolaBNYn8ITdo=;
 b=BpJ3fvVjy/x2NSUEMV2slw7rhJiJ7y5pyI2z7ImqVA4ZpoyfgnKVy5xrTofenfxc2UQbKr2ASr626mOKfFcmMkFt5wbmq6iIrFTJzVUpa/ila/dSQE3Vexfvl6UhUHqj2Dk36cTvfXkKDJ71dCtFdRHIbSxWrlUB5iSNzdCi4BVaHYpO0glc7c30wiRkE8uTADSX2Lu9aGBv2MPN67paihPYjT25JvJrNQUnL1i5+edxQUg98oZdH6gEW+B7Bj5TmDWVfz01xE6JjHbirlgHAwspgnysv4LMe6p6K7clzoeYCj3xNWHhrdKapvsRd9MW0PZZCXcwAz0gg04d1GSxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd7LNDfI+5j9mne/9KHunktk5hz0heGolaBNYn8ITdo=;
 b=pnIkiA2d6xAO7/AkwhtnDnWWH3LfIiia0wiir69VTq9S2TRtpaa/tyLQVx6uPQkRcBqVKSHCkpfKdYY+XD8RYBAPdRkcys+mV0v5xOfDtw2o1N+um26ov9JnTiYpbZd9UT9FWryy63Xfsxwe6Pn5AmrTUEfP0OYfgV7mvCt16oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB4146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 10:21:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a%5]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 10:21:21 +0000
Date:   Thu, 28 Jul 2022 11:21:14 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Olliver Schinagl <oliver+list@schinagl.nl>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <20220728112114.0000003a@garyguo.net>
In-Reply-To: <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
References: <20210414184604.23473-1-ojeda@kernel.org>
        <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
        <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
        <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
        <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
        <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bda7fe6-2977-42fd-9b6d-08da7082ea4e
X-MS-TrafficTypeDiagnostic: LO4P265MB4146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yQrR8DXJzoBwQgc5aorf5K2IXA36ETNnxKuPCLCZTTg27K01nzLnYIyIB838IZF+HeMeybn3w/nnFmNb19DU101AUcpS+EYQL0bk+daruyTivO3iJcgr3Wk12om1AVXMsqxIOGhgrsjONzorJffDr5GSJ4/27wHrW594RbNU/148gXxhUBNgWIWJfC1xZxpB8i1XlUjBZkoewSOztoHSO3xgm6pGpfwf05lvcGkH+wb/9So/+wu7yu3hAdF08Ibl22hwrn5JYJKDpP9JKw4nU8XQT7qRLlXtgnLXA1vYnZy9+rH7IA71rOIGXHzn5jvq8gxnBQhDhZNd4X/hY7VsZYbMbI/1BrxavGwwmLwkrDxbIcyerrGzdWL5hbqJCGwwtkKa1hG6M8Vh3WAiyh29gNEHOIArsRK+3GeuS52SkZMkB3KOOXefAHORrqf2XKDDu+Bbi0qMySFoolu6yfMV9Rcm6dbmSkcyDDfv2jnSoveEeCREDcG1qWHeSSClqzFIGgjJoX+LfTNs5DYr3xo7NkuB8oJqGW0Gp7ebxztsm9n/0q+Z9OyVelPUKPPOiMwot1bFFmzJBAnUBIPzMG+ihaGQFavQSBq3rQ40J85lZPUMUAe70G1yqkOvacLIZwnIakyBA+gTaR7ILaMd9OgxOpVBAcE+V0WcX0hpoD6py7NX3h9ESxRAvU+NRi7xRPnFLmYvIo2YSyNpmk2TBaqoFHuNAxYZ2Gxj+60EDHI19E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(346002)(376002)(366004)(136003)(396003)(36756003)(186003)(66556008)(66946007)(66476007)(41300700001)(4326008)(5660300002)(8676002)(6486002)(8936002)(478600001)(83380400001)(2906002)(52116002)(316002)(54906003)(2616005)(38100700002)(6512007)(1076003)(86362001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlDeX/rWCkc5HHGTIjVPDGJ7JuvAtiZBlHoZLscQnOLdDK8eE4GBdfeP7+A+?=
 =?us-ascii?Q?usKQr7k2lob0BlIeozvDg8otcafuvoRIwUHKvjT4g7TiVdvyfQWH8i9XU6f+?=
 =?us-ascii?Q?2h+HidTwQ4Mt+msW+UV5n9rTRbS9wRwf449ZlZyvkl5G8ofhSBij/Q0wj5tp?=
 =?us-ascii?Q?nHCTIKTs4o2hVOwWVHFTeDXzU2edERDTUB9QbQRZnB8TmmlVyc5vF4OP9qDN?=
 =?us-ascii?Q?ZeWGTo4c5wJBzFkJwD5wuJfKAFW6AQ9IHkpyrPSwIps0jGn61WT/27MMmTAM?=
 =?us-ascii?Q?tfJUBQdt8KfCwqz0/VfHLeOxhUf46yY9zzUED19eEPRIwfZNXpTOJ7NI/5lr?=
 =?us-ascii?Q?FHUNT9WHz7b/Zk/Xd++m/aR+Lth5iIAUt3vwDumYC8ygzBDT9Ja98nCiKrm9?=
 =?us-ascii?Q?NdP1depdHEI6g3l/Knjk5phDYcxJ1NeNoax8aoNSoecIiavHaXk+ifaKC+B9?=
 =?us-ascii?Q?IYzP67ijMp5V/rlQKPb5M6uRyi6eIjdJXVxpx2OUgXNOc1KgwNpK+rpaoTHk?=
 =?us-ascii?Q?p7PKyXTevacGxHV3I6ZOIqW19ztSxhd4Uu9+xABpR7/jNmen56S7EhgLlURa?=
 =?us-ascii?Q?66mhAP38k5xhIsjecvNrppviAFFpHI+YcM0Tho3UpZsdgxA/YP6MNXJRNyUX?=
 =?us-ascii?Q?nb0CqmNZO87zSAjB+qyntAfK/w80FMf/2DWXXvv79flbQXk5HhEpvMjk6fmf?=
 =?us-ascii?Q?B6Fof9eKeg62QaNw4x5Y7owmJPLZphNP3fxvSXxpn1KEy0rT4NaFSI0GjGVb?=
 =?us-ascii?Q?VKu9gHk+EB6Ve9G9VYu0wB3f3K0qrdVVMdcJVP4G/a5k5QZJ1ZCxuzAKZbOD?=
 =?us-ascii?Q?hbPTRUdQXLURPrrEQHq0L9UYUSVsqL59naetjpbwgJxKzMr7k/cH/1WmMzZ3?=
 =?us-ascii?Q?08UVicpoRqga2+aX49LYS8t2v1LrYbEIgdBQA4BeUQAb4pH8mtj7mymebcjI?=
 =?us-ascii?Q?TcmP+b4V+SoaEDorPl/ducMFdU1kBzsbvl32HSaj36mNj7KFsqThJZ3PMZcl?=
 =?us-ascii?Q?N+2qXURIYnBIOSsiU040GNNn00rc5PdMNn1453knMX4NOloTik/aYQlqi/E9?=
 =?us-ascii?Q?WwEKwt5R3gA6yulk5fCLExEAF2qFFrWsRCgURaQ5bxnqtJxJCkdnoJyv7hyM?=
 =?us-ascii?Q?yIlDPtgWcczGtScCRT3TMYhrFR8MF3qJaugj6C/wAFcWMJ2ZbiGedpRpjZVd?=
 =?us-ascii?Q?ptq9bx58n5xYUfi2nPA10pMnT03VbHcb1tTpC5PSQgLIK6O4xm9osApwICap?=
 =?us-ascii?Q?6chlW8f87HkcSh48naEmLAyibqaljEfYaFoxxft3eEg6WWW/Cn1tONQofS8Q?=
 =?us-ascii?Q?wiwnopAiJXTC5JcmS9LmzRSRZ0ycAhR/Q+8isFfcGfmH1u39UYMuuHq4nr4D?=
 =?us-ascii?Q?GBlzaPmJhj9jgIYeCsUE4ub1bi3+rYf1w6UepL/6/eb3ef84Y2WB1NR080cy?=
 =?us-ascii?Q?1HESzH6F5U2Gso96mcR/ofFsSVT0+g+Nlaod0ZFkg/XExIUgdscHOjfoV8sm?=
 =?us-ascii?Q?X3+qKy15KDsF7HrP6IyeLRHTc30aSjbgXlnkedVAtfrnFVui48msuxAfxkhr?=
 =?us-ascii?Q?uHB9evzaIOi2Kxgw+rBpI2kn7xKjKZw1qXNXt/eZGA1qNoyRJ+fvodjyKmo8?=
 =?us-ascii?Q?REVq6v0ehSNroc3vB7F45IIy65KdPldfmPe0kIBQ0L62?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bda7fe6-2977-42fd-9b6d-08da7082ea4e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:21:20.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK5BS8HqUGecU+FTeHMTtgDrt9jr7kAibXrIpWrxZa/+VRpblNI/F/AaI9CNdHhpYHic2bu7lZiqTvDV9m2XlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB4146
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olliver,

On Wed, 27 Jul 2022 10:05:31 +0200
Olliver Schinagl <oliver+list@schinagl.nl> wrote:

> Consitency is absolutly important! Zero argument there. My argument
> is, the consistency should be within the kernel tree, not 'but the
> rest of the world is using style X/Y/Z, lets be consistent with that.
> In an utopia, maybe, but the real world doesn't work that way, sadly.
> So in an attempt to standardize (rustfmt) they just "invented" a new
> standard. Which btw is common, we see this happening every so often,
> right?

Difference languages have different characteristics and I don't think
it's necessarily good (and often isn't) to blindly apply coding style
of one language onto another. So I don't see rustfmt as "inventing yet
another standard" really, because there aren't many conflicting coding
style standards in Rust world; almost everyone just settled on using
rustfmt, mostly using the default, maybe with a few small
project-specific configuration tweaks.

A small example for C and Rust differences:

Rust requires braces around branches of if expression, and C doesn't.
So in kernel coding style you often have:

	if (condition) do_something();

Or

	if (condition)
		do_something();

But in Rust it will be:

	if condition {
	    do_something();
	}

That's just an example of one control flow constructions. There are
differences between Rust match and C switch, etc. Rust's official
coding style takes properties of Rust into consideration, so in many
regards it's a more suitable coding style for Rust code in kernel, then
applying kernel's C coding standard directly on kernel's Rust code.

Your earlier email in the thread also mentions about indentation, and I
have a few things to point out as well.

First, Rust code typically requires more levels of indentation than C
code. For example, many functions might be methods and they are inside
an impl block, which creates one extra level of indentation.
Statements inside match arms' block are two levels more indented than
the match statement itself, as opposed to C's switch (as kernel coding
style doesn't indent the case labels). As a result, 8 spaces for 1 level
can be a bit excessive for Rust code, and thus the 4 space indentation
used in rustfmt default.

Secondly, I don't think the argument about tabs being customisable
holds; in kernel coding style tabs are strictly 8 characters. For line
continuation it's not uncommon to use a series of tabs followed by a
few spaces, e.g.

	int function_name(int first_argument,
	< tab  >< tab  >..int second_argument)

changing tab into 4 spaces will break the layout. (and I'll not go into
well-known reasons about non-4-space-tab messing up code in terminal
etc).

> Copy/pasting is known to cause bugs. There's actually research from
> NASA on that. Code-reuse (libraries/functions) are not bad. But
> (worst kind of example) copy paste from stack-overflow, or
> copy/pasting stuff without actually looking at the content and
> forgetting to rename something, causes bugs. Why is this relevant?
> The whole 'lets be consistent with the rust codebase of the wrold'
> argument. E.g. if everybody uses the same style (which is idealistic
> and great) then copy/pasting becomes consistent. Where I say, try to
> be careful when copy/pasting code.

When we vendor in code as a whole (e.g. like we currently do for
alloc crate), it is proper code reuse. With different coding style the
vendored code either diverges from upstream (which makes upstreaming
much more difficult) or diverge from rest of kernel's Rust code base.

> But if that is the case, why not try to follow the kernels existing 
> code-style as close as possible with the rust-fmt configuration? I
> know code-style has been discussed a few times over the decades; but
> not many changes have been done, surely, if there's some codestyle
> changes that are best for the kernel, they would have been 'advised'?
> '4 space indents are better then 8-size tabs, on new code, try to use
> them' for example :p

You do realize that you are creating a new coding style by doing this,
right? It feels like creating problems rather than solving problems.

My personal feeling is that it's easier for me to adapt to different
coding style when switching between languages, but it's rather awkward
for me when trying to use different coding styles with the same
language. I find myself no problem switching between 2 spaces when
coding JavaScript to 4 spaces when coding Rust to 8 spaces(tab) when
coding C, but it's rather painful to switch between C projects with
different coding styles. I certainly don't want to switch between Rust
projects with vastly different coding styles.

> But why? Why should we not be consistent with the kernels' code-base 
> (while yes, that is not rust, but C, but we can follow the same
> style?)

Difference languages have different characteristics, and one size
doesn't fit them all :)

> Sadly, I've seen so much vendor code (yeah, I know) which doesn't
> even have consistency in their own files ...

That's very true. So when all other Rust code currently follow
(roughly) the same coding style and this situation doesn't currently
exist, let's not make it worse...

Best,
Gary
