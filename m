Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7852AAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352151AbiEQSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiEQSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194D10CF;
        Tue, 17 May 2022 11:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2149615BA;
        Tue, 17 May 2022 18:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA95C385B8;
        Tue, 17 May 2022 18:30:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hr9cMRTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652812239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxU/j9KrVUnS0O3XL8Kj//mFihemMHHqa/qTY52eUz8=;
        b=Hr9cMRTLFy06aTtObh6pJ9SPlMptOzKdMLLjKvO3aPaLHwXldwr96xYEYabcZ3wv8oLTo6
        wBdYPWmlA0sophhq0JQUiqv2w8e4ZEQJ1A65V6DVFqOhgt0Ay4RSGAEi1QNNFkr6TIZyD6
        S0AQ5ENm0f/XaojHv35QpB9Sac9ttBg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1d50687 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 18:30:38 +0000 (UTC)
Date:   Tue, 17 May 2022 20:30:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Message-ID: <YoPpyDjn61AFqcZp@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
 <YoPdfjswwA2wKinr@zx2c4.com>
 <4fe5564e860eb3093a88528ba1d30364d57723e0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fe5564e860eb3093a88528ba1d30364d57723e0.camel@linux.ibm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Tue, May 17, 2022 at 02:21:08PM -0400, Mimi Zohar wrote:
> On Tue, 2022-05-17 at 19:38 +0200, Jason A. Donenfeld wrote:
> > On Tue, May 17, 2022 at 11:52:55AM -0400, Mimi Zohar wrote:
> > > On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
> > > >  static int __init init_trusted(void)
> > > >  {
> > > > +       int (*get_random)(unsigned char *key, size_t key_len);
> > > >         int i, ret = 0;
> > > >  
> > > >         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > > @@ -322,6 +333,28 @@ static int __init init_trusted(void)
> > > >                             strlen(trusted_key_sources[i].name)))
> > > >                         continue;
> > > >  
> > > > +               /*
> > > > +                * We always support trusted.rng="kernel" and "default" as
> > > > +                * well as trusted.rng=$trusted.source if the trust source
> > > > +                * defines its own get_random callback.
> > > > +                */
> > >  
> > > While TEE trusted keys support was upstreamed, there was a lot of
> > > discussion about using kernel RNG.  One of the concerns was lack of or
> > > insuffiencent entropy during early boot on embedded devices.  This
> > > concern needs to be clearly documented in both Documentation/admin-
> > > guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> > > encrypted.rst.
> > 
> > Sounds like FUD. Use `get_random_bytes_wait()`, and you'll be fine.
> 
> As per the original discussion, there's also certification requirements
> [1].

As per countless conversations on this mailing list -- which I really
really really hope you will not attempt to drown me in again -- I'm not
too keen on the certification requirements. Let's just leave that
conversation there.

There *is* a cryptographic design reason why you might want certain keys
generated on a TPM rather than in the kernel though: so that the keys
can be marked as unexportable and never leave the hardware. In that case
-- I assume -- the kernel just operates on a handle to the key, rather
than possessing the key material itself. And this is probably a good
thing. (On the other hand, people who think the TPM might be backdoored
may prefer the kernel's open source RNG, which in theory is in a
position to aggregate entropy from many sources, so that one being
backdoored isn't a problem. So maybe that's the purpose of having this
switch?)

So to the extent that this driver (I haven't looked deeply at it) is
doing the thing where a TPM generates the key and just returns a
handle to it, that sounds good. But if actually you're implementing some
wrapper around a hardware rng, it'd be convenient if there was instead a
hw_random driver for this, so it can be one of the many sources that the
kernel rng aggregates.

Apologies in advance if I've missed the mark here; I'm not very familiar
with this thread or what it's driving at. If the simple question was
just "is get_random_bytes_wait() good to use?" the answer is just "yes"
and I can disappear and stop confusing things. :)

Jason
