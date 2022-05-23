Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A65531F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiEWXmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiEWXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:42:05 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2094.outbound.protection.outlook.com [40.107.10.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85427703C2;
        Mon, 23 May 2022 16:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiJXfvVYDC9ea2rOOG7Il5iooUryIW44GK5lkb8JXCWdkU1+sB07i0RxOmavh+kWUQyroH9jaesI0YFXXX0n3DOTYgSzkKQvfUbQY//S53jGFbuDzaDABQQXuV3kAtObhQTBUH1k0mnesDFg4Y45voA0B43vxz4IamEnkTYyj+qjgS7NlNdVaPv6HMnc87UPaScDAYmmNfMC1d/LrtWF/4+gLfI+wEPgD04ycbkP62CHp6XZC6H591B6Fl5YhEo7aUZ2mzsUDGKQezVK/CUnjR52+0YZ9WQdsqJkAAc266mNcfXP7p8KxX5v6DhfAtXxJ49jjeQvAnqgnIlrWQTAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXmKovj/VB4v6+eMFI4TPzPnc3tppZSlUq4d5FHwvt4=;
 b=ih31DCtAfNjDEnvgAFekrZ6kH1WnqdET2Zoa0dDLYRX6PqG6AsUVEcwluJlUCCbAu6k2tOTScBerTfb8TcngTW5G8H+INXb25wnB04yqIGVZiINqDRfuAcve6i+2IRKqHvlTu8EDZwZFK6CJJA7XPgAC8rejRsFRCJ/M0GIurdjazMsc6WzREg3iCAkXrhDuNE7LXyGG4ZQXZsc0PQVz/U0p598KrQ5gi9yAbwKUkk89MelPNxRjCcjRPx4tHFTq0RQJ8ng+/J7WgZr6bCidvNFoDkBw8qjQ3QsPvOswEXp0RSBYR/pRuyQLJ1r3pmY0KnFBne0JB3x3O01GnJCeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXmKovj/VB4v6+eMFI4TPzPnc3tppZSlUq4d5FHwvt4=;
 b=JTRL/G5Z2BppUiqdvlDofu9xniBlOhb05sQMqRL3a2mnFCfkPJaFKNy/sx5g8ycZAIq0kqKxI+izqhIFp57/hZI6mD7pgjhkxrjHKgUsvoCk15WhFpVjauYeDU+M7WKTx67O68sk7fdPkG/4VOnOrWNw3ILKWhDl/Sz9oOGuoTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5774.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 23:42:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a866:74b0:f977:2f63]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a866:74b0:f977:2f63%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 23:42:02 +0000
Date:   Tue, 24 May 2022 00:41:56 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v7 06/25] rust: add `compiler_builtins` crate
Message-ID: <20220524004156.0000790e@garyguo.net>
In-Reply-To: <CAKwvOd=mFhxjKRP_qt3Yu69dj_P6VUMSUSQm7fY6yS2bsO8Y2w@mail.gmail.com>
References: <20220523020209.11810-1-ojeda@kernel.org>
        <20220523020209.11810-7-ojeda@kernel.org>
        <CAKwvOd=mFhxjKRP_qt3Yu69dj_P6VUMSUSQm7fY6yS2bsO8Y2w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce8d2d1-dfd0-4a54-ec82-08da3d15d603
X-MS-TrafficTypeDiagnostic: LO2P265MB5774:EE_
X-Microsoft-Antispam-PRVS: <LO2P265MB5774D3EDB05DE76A8DF21017D6D49@LO2P265MB5774.GBRP265.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyu53Qu/w9HhFH9rMdgif3+AMe4KMLP8NDj6jDajnnSBaZjOZ95qO1nJZilLSQnzssywAy0whCSEX/S4WEjatlH20z1sDSLDyTryvKM9bRFhk5PgvK04lPg3alLTGcepEAEFh3mRcVqEXXhLcjeMG29wFBzGxvOMFUvbdsdiANwLiB1wA+yb7uYhFUbRxTuDfYwHlx+NJIn+oHVZLzDcjNs7+ZxVYg/OXQYBuf5kUnjUuAdPo6nJh5x1ugPzl6rvg2IUcTYhdhaZWgw8WfXW9slnLNb/PiL6FpqudIdkSlKfd/Snde2qqU5pgLJ1k0ksRff2PBzaOxFjLk/AKLRKP70eN9cfE1PqHqGlG/kZU+xvXPgl4qB858f99u2sIiRDqj2AuwXjNV4s5E0RsGbEDQJnp2a64/PPXYqHn5iGQW21tvlz7SYH4Kby+vv67l5QwALjUAUrQlCXY9omDKh6Er0bT9R/h23pD0yUVF5mrPncPb65dfPiUjudxp5kAuKDboHyQh3mR01yB+fhhh2zyfYKwkFAJyU5ceLaRGLsx5wfpA+IyzjJEQeqWGsQ1VXT5ASuEBM2Am1QtHOvCa6MqftkQ3n7MsMp1lne754DHfqhaO7lHgM0+smuGetX6mv4J8h7VQHcoCPC19Rv2jAx4U6W/v//wjZO2uQKC7jnenZ+DzY5mOojVOX3/5OB5IZyCINmXoIGvXT1NOIFqk9TU9sqna4qTQrlUV1sojACbgxk9ib2lIyNoOrnHcAxl1Bx4/8KNm8TJ/EH2HJPXeFklQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(346002)(396003)(136003)(39830400003)(966005)(316002)(508600001)(186003)(6512007)(86362001)(6486002)(41300700001)(2616005)(52116002)(83380400001)(36756003)(6666004)(1076003)(6506007)(66946007)(8676002)(66476007)(66556008)(4326008)(38100700002)(5660300002)(54906003)(6916009)(7416002)(8936002)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qovqBb3RwSBCPMu/TfVg7wJ2LPtAGkiLorTUCRR292Rdb8r5j42RrvW8mwBE?=
 =?us-ascii?Q?r2mA/P/VWL0yH8szLKD6VhRU7szrID2XsPO088ecbCSpPKsyOH4XbSSIxcnx?=
 =?us-ascii?Q?qauohg6a7CYP/seA6s+YdLWx5MCsBhDq4ZqBw10aoHzieZb3fbLU3/9YwfhK?=
 =?us-ascii?Q?jUp9S45zRQ2jiBEmlsg5XmWRJsqj2ei9jiiOIXVxKRjWLeF2xnIzX6lJ7XZt?=
 =?us-ascii?Q?jwclpn3MGW+vGxukWfLlC5oYOcNLveaQshRvfczJrue3KeGTRFZWK8BovBSH?=
 =?us-ascii?Q?lhLdVPs0kFnHLVUrDC9DUwz0G3LVuz35YAtW4RllVx7svba0TwzQKqS8PPZs?=
 =?us-ascii?Q?3A20HIAfqkqdoB/hU8HipiqO8FKhQ2kJmVsv5mRWfN+v8E26AriayJjIYR6/?=
 =?us-ascii?Q?e3f7F9P32IfPOjCJtqmc5dHR4sZR/nWxA+yTeNv0YFINvNRei4/pXNTHAvpu?=
 =?us-ascii?Q?umeV+Q6j6bZ7N/un1fY+tihOM5EXwg28jdpUNu2MVYCIvGGKLuRrI0Yr9CyY?=
 =?us-ascii?Q?a2mB550x/TfgasKHVaTA5nBw2hRdd7xafadxEBRClOo3QohqDZa9OvQ53rlF?=
 =?us-ascii?Q?i8+g9Hhjdixjw2Z9j5JtykzQeN+9zkqsgfr7duqBOIWdjw83ANy4gGnLP/id?=
 =?us-ascii?Q?qXG+hFAA7vC8rqNXc2X6L1j7zLk121LTMRKtCFSeqe3q8HCHxHucBEhSLVai?=
 =?us-ascii?Q?BDJwwQbXo80piUuL4OIi+1IDNBQUIagUyyAbLBMnEDg40mhDZ/vFigjdnnCJ?=
 =?us-ascii?Q?2DY5PLByw9peV2UUo0wLXHtZ3iRRB/2PbEkxRmskT5JKxaW7cMNmZ25lr/cp?=
 =?us-ascii?Q?GQL1lP6fP9XNpd0/MpienfHA3lX2sQXdUKOBG57o/srwMXK0U8fHFhNX6VCo?=
 =?us-ascii?Q?Md8T7jZQLLujTCGJVSTPvXpnN5mEJVdEsBzPSFYtwEMpMYdsAyOOxfMnIS61?=
 =?us-ascii?Q?rW6x9UKya0dvfH+sQlMCRyE6dkK8CCygvvCi6x6LlVk6wZdV/brCxO2u6514?=
 =?us-ascii?Q?RdxSYll03i/qQ9RSeGSON2F59KqumJJBA6gUTGyKgyqCm5hIs1uEKtQ13Whh?=
 =?us-ascii?Q?4QDnnWFVocOFD4hC2haZYZ7NzAqWyOPv5707MaHDZk01/wLvAguBLAuQG845?=
 =?us-ascii?Q?9t0oDNDDOhhUgbzGLNP3dGjINc/8fHakRzpmkvmwZj24u53qvHSGKZltsRQU?=
 =?us-ascii?Q?x14SyQNF/RIEJ43lyeWsFQ5qzIGa6RwE5pyv2fGDGo7+TOd8Hl62NEFkIpgL?=
 =?us-ascii?Q?40QbKf35aB8gIwMjmmVfqwsjl1kAiIN+lq1NsfSKUadEFcbI9wP21HmS/QRo?=
 =?us-ascii?Q?itfegVu7eZ8PSPkMWOxEd8MBakqLzoAUiXlYUY1s5DpcwJ8BB8v+77WBEXU2?=
 =?us-ascii?Q?PdNRT73LJLVRz2/F2ol7CWSiA1ctdXwt23xEhYd475jhMxU83PU1vNoMkVJ8?=
 =?us-ascii?Q?IP2nMgkXE1Awp//U839xUjAwmPwngQkOw+fIlJtN2NBmwny//4gZKBkwijBP?=
 =?us-ascii?Q?r76jYgQ/L9vpqu43IYe1KCeMRZsdELlx70dvcEaOH/sYlRbPEx31SDbjqCZy?=
 =?us-ascii?Q?XcYYmZtiLUvGsJRvARcvF6QeYVRw+nDm1iTN0m4Uo0GNp3ASuVDN1bfYzoNR?=
 =?us-ascii?Q?glV/W4w24cQgEz1q90JcL9FD7KTd96BSoqa322WKPQ/1tdgA0P1RsfYs2iWV?=
 =?us-ascii?Q?RQYncSd6yzt02CtK6K0hl3NHA9bbkx+V4+NaHUfhcSPGRjWJ5/uPwsYHXXUl?=
 =?us-ascii?Q?DYgo5jCzszztFj75fvK0q8xEdRbG9/bazefPDR2PyNHAUhtMrKwAEV29NPmx?=
X-MS-Exchange-AntiSpam-MessageData-1: pDGCgwcn7ZXY4A==
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cce8d2d1-dfd0-4a54-ec82-08da3d15d603
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 23:42:02.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0bz3L9BwWO6xjxdXa+3yVm2AjgGRWfPqx7sSLeGic4UGbcPWPO38krKhBmHWhdadhANMJ7nImdbvaWz7osZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 11:37:16 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> Also, I'm not sure my concern about explicit build failures for C code
> was ever addressed?  We have a constant problem with `long long`
> division on ARCH=arm32 and ARCH=i386 in C code.
> https://lore.kernel.org/lkml/CAKwvOdk+A2PBdjSFVUhj4xyCGCKujtej1uPgywQgrKPiK2ksPw@mail.gmail.com/
>
> > +#[cfg(target_arch = "arm")]
> > +define_panicking_intrinsics!("`u64` division/modulo should not be
> > used", {
> > +    __aeabi_uldivmod,
> > +    __mulodi4,
> > +});

Starting in LLVM 14 (used in Rust 1.60+), __mulodi4 will no longer be
generated. So that can be removed.

As for __aeabi_uldivmod, is there any reason that it can't just be
defined in arch/arm/lib? There are quite a few __aeabi functions already
defined there.

The source of __aeabi_uldivmod in compiler-rt seems quite simple, just
delegating to __uldivmoddi4. I think just changing that to
div64_u64_rem should do the job?

https://android.googlesource.com/toolchain/compiler-rt/+/release_32/lib/arm/aeabi_uldivmod.S

- Gary
