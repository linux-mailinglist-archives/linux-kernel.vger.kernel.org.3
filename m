Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55115827C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiG0NdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiG0Nc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:32:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DE37F97;
        Wed, 27 Jul 2022 06:32:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6A7A143E90;
        Wed, 27 Jul 2022 09:32:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=hYGcEqXMoE7YuRbz2nqgGqP2jqxHEnASS/bBzS
        kbW2E=; b=alU5UUps47goAM5SMBuyh6KZWnF/IzJaCRTkvwHY9g7ubeMziltikU
        7vViC25PioyUaC6qvNrWgnMEZZejU7zW1rfvaOdqt0jLPsCQ/fcKSVHr0CuyGM4K
        wt9Fmw/hNtF0K1sf7SWjYqCu8So274NSeTZChigyCUiWt0TzJkngA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E27D143E8F;
        Wed, 27 Jul 2022 09:32:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=hYGcEqXMoE7YuRbz2nqgGqP2jqxHEnASS/bBzSkbW2E=; b=Y7BdnpufVgUhwyYf1xd2NSE40g4zoZTmmpLMJZ819RqkNBGbHxs/mjVNSq5IVAAqBdAKt2ucAcmhX/9DbqgmlyQtP5BiBsrWnnfSeBMJ/xLxXXFYtwHdH95JMF2jbM8ayf28Zejtw37AEisP+z9pnEgauBI7Tj+5WvsHNHitSXs=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DF35143E8E;
        Wed, 27 Jul 2022 09:32:54 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 23574386C75;
        Wed, 27 Jul 2022 09:32:53 -0400 (EDT)
Date:   Wed, 27 Jul 2022 09:32:52 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Olliver Schinagl <oliver+list@schinagl.nl>
cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
In-Reply-To: <f77a82ec-e970-d8d6-5196-6253bc72bdc2@schinagl.nl>
Message-ID: <n87r7173-n782-6p12-4768-723qp8ppno4@syhkavp.arg>
References: <20210414184604.23473-1-ojeda@kernel.org> <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl> <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com> <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com> <1163467-64s-p66r-r077-35s058258150@syhkavp.arg> <f77a82ec-e970-d8d6-5196-6253bc72bdc2@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 9E693B92-0DB0-11ED-909A-5E84C8D8090B-78420484!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022, Olliver Schinagl wrote:

> Hey Nicolas,
> 
> On 20-07-2022 22:21, Nicolas Pitre wrote:
> > On Wed, 20 Jul 2022, Miguel Ojeda wrote:
> > 
> >> On Mon, Jul 18, 2022 at 8:56 AM Olliver Schinagl
> >> <oliver+list@schinagl.nl> wrote:
> >>
> >>> Secondly, and more importantly so; you argue 'who cares about people
> >>> with disablements, atleast its equally hard to read everywhere' which is
> >>> a very poor argument :p
> >>
> >> No, and I want to be __very__ clear about this: at no point I have
> >> argued "who cares about people with disabilities" or anything like it.
> >> It is insulting that you even suggest it.
> > 
> > What "people with disablements" have to do with this anyway?
> > I don't get it.
> If you are talking to me; simple, reading disabilities (dyslexia being the
> most common one) are real :) and code-style heavily impacts those.
> 
> For example, I have a really really hard time reading 2 space indent,
> especially in larger code bases. Also, CamelCase is very very hard for me to
> read also, as is statements without spaces `if((x<y&0xf)||z>a)` for example.

OK, that's a good point.

I asked because such arguments are often brought up in the context of 
sight impairment by people who are not affected, and in this regard I'm 
well positioned to call those arguments unfounded.

> So codestyle affects those with reading disabilities, but not well known to
> the people without these, which is why I was raising awareness.


Nicolas
