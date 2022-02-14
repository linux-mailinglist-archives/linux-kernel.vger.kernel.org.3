Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6854B5DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiBNWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:53:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiBNWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:53:16 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACCC171870;
        Mon, 14 Feb 2022 14:53:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id AF0BF580632;
        Mon, 14 Feb 2022 17:53:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 14 Feb 2022 17:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=e2LfV2BcYFTZ6ZIg8
        FOTVm2MpIs9idDpZ8R+EsQHXrs=; b=SJdNeO/8jyTfLiWOckcAG2OHGKCIILKot
        CoUd+ViU7KAYtLt39PVDcb/IGuv6zV7lLNGGyCe8EGuQ5DurWAtyc+59koNFynFb
        Vax9tANM2zkhCcUoof6TNS/nhOKqyPS+Hw3tsgsfWgJvrvYRq/oTiaPhFIsCZ3gq
        572A76x7uTT/SQOWr2a+qXWcnzfFPlN8I/AlTAP67o6ZCB+w+xPm/B5psHno61aJ
        DCH/hrkY5RKmleyp5ih42WMsScPaotRe9Unr3WD7ZeSnt0m2dNzPfz999KUbozwI
        V020ATKE/pSE4MZC8o1aHNCuKDsllmkkIJSgA7ad0fRyvnrt2DTiw==
X-ME-Sender: <xms:T90KYtUsU1i8H8oKgKHJ6zYGcswaPP0J8WgFAclau0XetWuIQzG0mw>
    <xme:T90KYtmQA6gxwJzCjpgsGZ91IZLbkRkK9l-KZyxb5ryxN91ZuejBSqStpdrtODbHF
    GifMxA7HMTM-t1YzjE>
X-ME-Received: <xmr:T90KYpb6E2tmhE99twMc1QbFpCxPqjw62-HdwNAwXMsB5Z1t4aNo3u9CZxAFYhuTPi2ZXSZxw3FS5jdDrwiRWsSOAlcaid0NeVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:T90KYgXiz-V4ond-i7eX1uAvA0i9WOmsdnB3aAw0H2uwKsVWoxeXRw>
    <xmx:T90KYnl-c428-0I3-b8b87OVnAgj1cO8HsHp8BhvVhhh6vh8QeegDA>
    <xmx:T90KYtcrQAQMyH87a2CMfgA9HSwqEFEk9lDpm9-zJ546bLNuMFdolw>
    <xmx:UN0KYnHmkgdFIoGzRmz69Z6jzOvFrkcKI8C9eYQOxPNBA0jBhzy_3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 17:53:00 -0500 (EST)
Date:   Tue, 15 Feb 2022 09:53:11 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Joshua Kinard <kumba@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
In-Reply-To: <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
Message-ID: <b43cc58-5ace-11e1-1a11-6cca42f65e7@linux-m68k.org>
References: <20220211210757.612595-1-Jason@zx2c4.com> <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org> <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Jason A. Donenfeld wrote:

> 
> So the only systems we're actually talking about without a good cycle 
> counter are non-Amiga m68k? If so, that'd be a pretty terrific finding. 
> It'd mean that this idea can move forward, and we only need to worry 
> about some m68k museum pieces with misconfigured userspaces...
> 

A processor cycle counter is helpful when mounting a timing attack but my 
museum pieces don't suffer from that problem.

Also, they are and always were immune from spectre, meltdown etc.

You misrepresent those secure hardware designs as being problematic, just 
because of some bad advice on some random blogs about RNG API usage.

Do you have a phone that no longer gets updates from its vendor? Have you 
tried patching it?

Your insecure museum pieces are the real problem, not my secure ones.
