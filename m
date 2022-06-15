Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA454D4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiFOXJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbiFOXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:09:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA082A95E;
        Wed, 15 Jun 2022 16:09:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNgxX0GKbz4xXj;
        Thu, 16 Jun 2022 09:09:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655334592;
        bh=EVxR2J81ilaDwpyXIWH6IEIolXowPFYXdyTYaBs9sHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYU/23Ah/nNXU+n0nW3/fhmVeII0whPnfrkXcbUy9NXYaQQpHjU4NSFBgQ5Y7m6xu
         WkWO8BM8RBnlYcEhbNyjMDe6fWDpSABOqMZ5WucVMSWCnCxA8+f+udjPRmLtJB0Sfs
         SlyBCmWWvwsnDGKACth1oqbqwFTSRaSZ/EANTvpeyQLSKxHjVn2VuFfKd0ZY68yPg+
         SK2aCzboZ8m4TEqB06FAyI07EKJR53QMbr26DaNTCh5rLRjrX6VZazLaTO/nKDdT/L
         tW/4mtCxQhMmnCnJBP+fx/LncaxLgbyvzLFe33oWkOsc5s5FE2tmWpqrlTbubm2SiW
         WHdHPlHdljnhg==
Date:   Thu, 16 Jun 2022 09:09:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220616090951.6db6a36f@canb.auug.org.au>
In-Reply-To: <20220615211220.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
        <202206151326.E34CDE453@keescook>
        <YqpCkAVTwpNn+6p9@dev-arch.thelio-3990X>
        <20220615211220.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ym87/RxWZO0REqS4MS/BmLz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ym87/RxWZO0REqS4MS/BmLz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 15 Jun 2022 14:12:20 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> On Wed, Jun 15, 2022 at 01:35:28PM -0700, Nathan Chancellor wrote:
> > On Wed, Jun 15, 2022 at 01:28:00PM -0700, Kees Cook wrote: =20
> > > On Wed, Jun 15, 2022 at 12:55:53PM -0700, Nathan Chancellor wrote: =20
> > > > Per the above RCU commit and commit 6c5218715286 ("context_tracking:
> > > > Take IRQ eqs entrypoints over RCU"), it appears that the following =
diff
> > > > is the proper fix up. Would you mind applying it to the merge of
> > > > whichever tree comes second if possible? I did build and boot test =
it
> > > > but it would not be a bad idea for Sami and Frederic to verify that=
 it
> > > > is correct so that Kees/Paul can mention it to Linus :) =20
> > >=20
> > > Actually, the CFI fix (and a few others) are meant to be sent for
> > > -rc3, so if the ct_irq_enter() change is in -next, this can maybe get
> > > sorted out? =20
> >=20
> > Ah, I had assumed that branch was destined for the next release. If it
> > is for 5.19 and they make -rc3 then it should be trivial for Paul to
> > either rebase the changes on -rc3 and apply that diff as part of
> > "context_tracking: Take IRQ eqs entrypoints over RCU" (if his tree is
> > mutable) or just merge -rc3 and apply that diff as part of the merge. I
> > don't really care how it gets resolved, just so long as it does :) =20
>=20
> My tree will remain mutable for a few more weeks, so we should be
> good.  ;-)

The CFI fix is in Linus' tree today.

Paul, you could just merge commit 1dfbe9fcda4a ("usercopy: Make
usercopy resilient against ridiculously large copies") from Linus' tree
(or rebase on top of that or 30306f6194ca "Merge tag
"hardening-v5.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/kees=
/linux"
since it is based on -rc2).
--=20
Cheers,
Stephen Rothwell

--Sig_/ym87/RxWZO0REqS4MS/BmLz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKqZr8ACgkQAVBC80lX
0Gw7egf/bLTeP0zJ0wTcxbtxYY58bGgOo1TmzQoMVhzMfRVlBCc3r2/ErQn4x15Z
cV2DRq4fS8RHLdF09GDJV8pWT7Dq+rwiuVLudlc0nAaJTNc6b1ZJM1elGk9j8moJ
hlXuGJ0w+7cW2aQlHDSGONTWBiIU0Ev47vSWb7s6VgfOldHilCFvbL4pi1gzItkD
fn8BQCBEmq7fzI7VNeaMNJXjfuW/GyBqh3NzTpIEOotTQUWMFeCZ8IBKnKugh2G/
WObBzbcdv9ffAvZVZ/9hJ+hIp60cj7n2nttkbfCL1zXMrrNK999IozTxGu53rNmX
MdtB/OuDDZAh6Vdn8fSLZYwRjlGxKw==
=w+wS
-----END PGP SIGNATURE-----

--Sig_/ym87/RxWZO0REqS4MS/BmLz--
