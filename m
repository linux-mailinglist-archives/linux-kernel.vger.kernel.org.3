Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A395462C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhK3GKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:10:19 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:22086 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhK3GKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638252373;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2RIhm/dShy6WZjwxsEwHtpgbqOF3MrvG4TIkwd5vDtI=;
    b=h+35u+sPPmPO1XWqT73m/IA3wz0antfovrCf4aSPVCBlSGncDjnrIW41U/6UyCx6jC
    TiEvi0TirCskKCwhR3YS9/O8ZFRihjLCK98Sx2i9Ns1APhtqALwuIysrrOeGY+fWT21M
    0jBEp6m6+0usyTrj4O+It4p7PJggR+sUKczfsvikNQk4+IcexuDbVAJ5qZ7cGKrCF3v5
    nbreyQqkvtzxUr9N8FvxGwNprR5JiXUU9ZAlB0vv33hxUX4FYjl/ahPwigpjrj1OCowV
    VHTmWnMxz9xGIRvB8PPlKmEU281HRr6J6pgcXW4NIwHlP9WrR6PLKnDNaN4+H2r0xf/O
    Nq6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeuWroQ="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xAU66CTnL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 07:06:12 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Sandy Harris <sandyinchina@gmail.com>
Cc:     Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v43 01/15] Linux Random Number Generator
Date:   Tue, 30 Nov 2021 07:06:11 +0100
Message-ID: <4491190.vXUDI8C0e8@positron.chronox.de>
In-Reply-To: <CACXcFmmtdQLCusKu1NHq4JjiKAjCpCPj0aYBR-wxO3tEz_-nQA@mail.gmail.com>
References: <4641592.OV4Wx5bFTl@positron.chronox.de> <7ee4a94e-496e-67a0-897a-0dd84bbce72f@intel.com> <CACXcFmmtdQLCusKu1NHq4JjiKAjCpCPj0aYBR-wxO3tEz_-nQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 03:55:12 CET schrieb Sandy Harris:

Hi Sandy,

> Chen, Rong A <rong.a.chen@intel.com> wrote:
> > On 11/22/2021 7:47 PM, Stephan Mueller wrote:
> > > Thanks for the notification.
> > > 
> > > I think this is a false-positive discussed before. __latent_entropy is
> > > seemingly allowed for an entire linear buffer as seen in the declaration
> > > of
> > > the variable input_pool_data in driver/char/random.c which is an array
> > > of u32.
> > > 
> > > The struct chacha20_state is a linear buffer of u32 words.
> > > 
> > > struct chacha20_block {
> > > 
> > >          u32 constants[4];
> > >          union {
> > >          
> > >                  u32 u[CHACHA_KEY_SIZE_WORDS];
> > >                  u8  b[CHACHA_KEY_SIZE];
> > >          
> > >          } key;
> > >          u32 counter;
> > >          u32 nonce[3];
> > > 
> > > };
> > > 
> > > Therefore it should be identical to the aforementioned example.
> 
> No. It is a struct & there's no guarantee all compilers will lay
> it out as you  expect. There might even be a gap in the layout
> since nonce[] has an odd number of elements.
> 
> >> The __latent_entropy marker therefore seems to be appropriate for this
> >> structure.
> First, this is completely unnecessary since the input pool is marked for
> latent entropy & changes there will affect the chacha context.
> 
> Also, if I'm reading the docs right, the __latent_entropy attribute
> on a data structure only gets it initialised somewhat randomly.
> If you want a continuous effect at runtime, then you need to
> make the code mix the latent_entropy global variable into the
> data structure.

Thank you very much for your explanation. I will change my code accordingly.

Note, the LRNG does not have an input_pool.

Ciao
Stephan


