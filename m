Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BC74FE16F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350263AbiDLM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354806AbiDLM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4004969B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECA46152A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2091C385A9;
        Tue, 12 Apr 2022 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649766617;
        bh=y09qGgSfZHH++MJGmH/EkBz5py9CFxNAIo8FN2xFVTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8qxtKRam3NtVJa3mj2VLoOZln/oJEwuSDOuIRLMBjEyJ3+Pja0DvUEAqD7f3LOee
         CnvtfKJ0kuMz5K5nYcQ1j57SHs2dEB2kWn9UF+0LNWXU4jITmd2yAY+dSWkissgpK5
         zpUa0CbLNrOzS+EciE6Ci7w39GDBJgoiZiVWcxjigrLE2utZ3Ckw+rgeNIkYJKLuxn
         IchBbLVrj4+p4ME30RX0zlo/zJADcKJ8OMsflr/KrsFmbqX7Vigqk89EAL+rI6cq6b
         4qtdAa/PNCmq46RnCWhe7/YzglHoh//3OID4GgPzZtSrEE7pybu7pjGoWuxFHhkxHn
         XcdzyVt0IM8mw==
Date:   Tue, 12 Apr 2022 13:30:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: make range check functions static
Message-ID: <YlVw0ikabCNhlKBB@sirena.org.uk>
References: <20220328225628.3012397-1-linux@rasmusvillemoes.dk>
 <YkRPOM9GKo3tlxUh@sirena.org.uk>
 <CAHp75VdiBqJ_+1eewmgrdGpsYUr=+xLpeH+4B_rS4nDtc-fMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="shtyL6OGlWw7Wn2n"
Content-Disposition: inline
In-Reply-To: <CAHp75VdiBqJ_+1eewmgrdGpsYUr=+xLpeH+4B_rS4nDtc-fMYA@mail.gmail.com>
X-Cookie: Approved for veterans.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--shtyL6OGlWw7Wn2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 11, 2022 at 05:59:33PM +0300, Andy Shevchenko wrote:
> On Wed, Mar 30, 2022 at 11:17 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Mar 29, 2022 at 12:56:28AM +0200, Rasmus Villemoes wrote:

> > > regmap_reg_in_ranges() and regmap_check_range_table() have no callers
> > > outside regmap.c, so they have no reason to be exported nor have
> > > external linkage.

> > These are intentional API in case someone needs them, no need to
> > encourage open coding.

> But currently it's not used and simply consumes namespace resources.
> Isn't it our practice not to add dead code / etc?

> In practice I assume that one will grep before implementing, or at
> least at review stage it may be pointed out for a helper, that might
> be exported when needed, no?

Or they'll just look at it and think there must be some good reason
they're missing, or that having to deal with cross tree issues is too
much pain and just open code stuff.  It's not insurmountable but there
is a clarity and usability benefit here.

--shtyL6OGlWw7Wn2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVcNEACgkQJNaLcl1U
h9BvmQf/YvnphxulfbspZ25ZWsO9BPIjLvEKL4QZ9QIFHO1FJADQ+FeXJPs46Awt
7rRCNwsehqnIEItQ6m5r5dK6O4tcLF6fiPD76QRuxh4ylULP+WMnUInLOWJmDWLn
ibfrbTIpRH6mowpkByDhjrZ/cMH+Z3NQMdJkSJ7sDujql7I89wXXMU2ctoMLrLB+
05c0JbZFsYbUOLTIYXokuKuWEBfnubNMZVTIMZ/8mx31LGLBbthhw8itD4rtGOuH
Bfg/PpMwfJ4DvkrIaQSN74Yw2W2A9WZqHmhQ2nI0teZsaLhOjyfbPefgUz/eya/Q
t3sMlkoDQkP0N+yXpFYtN6xkZo4F+g==
=Ve6R
-----END PGP SIGNATURE-----

--shtyL6OGlWw7Wn2n--
