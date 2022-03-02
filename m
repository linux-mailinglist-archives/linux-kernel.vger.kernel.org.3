Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E84C9E58
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiCBH2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbiCBH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:28:44 -0500
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC752B0E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 23:27:58 -0800 (PST)
Received: from [192.168.0.150] (84-115-212-199.cable.dynamic.surfer.at [84.115.212.199])
        by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4K7m171FMpz3wVn;
        Wed,  2 Mar 2022 08:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
        s=mailrelay; t=1646206075;
        bh=CSBe8QRZn5GvXNmzs06Yc+jiDmyDjWPUZ9dGv3OVnaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DvqqYEggAgtWgYT0S+1TzzZp9lmGRGxBNBAaf1NBzBH0Gs+/+gaKyAeUwwF+achHs
         P3uktwRlmMueBOdi8II0LQuomPYSMRQ0oZAQNSy3FqFwIx5yyptImm5YnrZPW+yjkO
         0yZ1m9V/ISVXIbrcVTMRXdtGkoxpLdxA6L2vb5iU=
Message-ID: <9472f9dc97beb069e3dbcc0ab6c8e9b5c6976a33.camel@tugraz.at>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
From:   Martin Uecker <uecker@tugraz.at>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Mar 2022 08:27:54 +0100
In-Reply-To: <CAHk-=wi+sjd8FT_FeJ2UOU2Ti7ws1i7hDweAW2gp8a-JpO-Tbg@mail.gmail.com>
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
         <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
         <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
         <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
         <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com>
         <dc52af7ebc044c94337e138f6e1ae807559b4825.camel@tugraz.at>
         <CANiq72mcuXDRM-xMDPuL7uDLUfXDhARTBJJsVj4fnR15T1v=TA@mail.gmail.com>
         <CAHk-=wi+sjd8FT_FeJ2UOU2Ti7ws1i7hDweAW2gp8a-JpO-Tbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: -1.9
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.03.2022, 12:26 -0800 schrieb Linus Torvalds:
> On Mon, Feb 28, 2022 at 5:50 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > But making it non-UB in the standard does not force a project to
> > consider it "not an error", which is what actually matters for being
> > able to use UBSan effectively or not.
> 
> Absolutely.
>
> I think people should treat UBsan and friends a bit like "runtime lint".
> 
> "lint" traditionally doesn't necessarily check for just *incorrect* C.
> 
> It checks for things that can be confusing to humans, even if they are
> 100% completely conforming standard C.
>
> Classic example: indentation. Having the wrong indentation is not in
> any shape of form "undefined behavior" from a C standpoint, but it
> sure is something that makes sense checking for anyway.

You can automatically re-indent code form
other sources without breaking it. Assume you
have code that relis on signed integer wrapping,
but you want to use UBSan to screen for possible
signed arithmetic errors  and/or have it trap
in production to protect against exploits. You
would then have to carefully analyze each
individual case of signed arithmetic whether
it makes sense, and then somehow add an
annotation that it is actually ok (or rewrite
it which introduces new risks). This does not
seem comparable to indentation at all.

On the other hand, if you have a self-contained
code base and like wrapping signed integer, you
can now use a compiler flag and also get what
you want.

So I am still not yet convinced that the
standard was wrong making it undefined. 

Whether it is wise for compilers to use it
aggressively for optimization is a different
question...


Martin

