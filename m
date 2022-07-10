Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9556CF03
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGJMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGJMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:24:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E1AE72
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:24:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r129-20020a1c4487000000b003a2d053adcbso3534460wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxOkn1vwX9dqKUp3G2I8LNC1XE4U19u+v+L3wlSmuxI=;
        b=Bfgz0OTaMImDBu8kZTcjdGpuIySXuzcmI6udZ1QhNw6HwuI6vRhhoWNQJr3feyHZBE
         detEpvcvERHjkzcGqKkKumCWUxg8mv1Eln9FoGuQUeJREtV2n09rUXi4tNi38KWa78B3
         ZgkV521pMMV10x2JlIkNi4TXQGLlSXipf1/nRFW0YRlgFRY3C2n+Ei57lM72Gbl7nTDT
         hZ3OI6CacBzZh6jQxYcZxNc3XNiY9GjERcv1/C0SxSqFpDeUv8QjiBpuOPFVeYQ75I8s
         IO3cOYAokzy0VEucHr7NNfnrHxxqsWSlQOobSMV31RfEg7UnfDwpD3be2iC+YwcIG/jk
         Wbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxOkn1vwX9dqKUp3G2I8LNC1XE4U19u+v+L3wlSmuxI=;
        b=LhHirgX2aUc53i6lN2+GKFU7WHK8nfecQTvUp50dR0qkbjiyfxDQ9Fnp3J6FDDCpe8
         QbBWSCHT0nCidylU26F5oErCZI0qTMHXqcJ4m8exILbH5Xe66zxIbU44ZxQegQ6e0P0A
         RPWNO8glqXQYeN9XLK3uxpyXSpecoOckkiRVrdQ4gwL5iJt4Vhf1gxmfactsl8ob5B/5
         ceNPmiqh5L8rfUNO5L6cl41VOMm8XyzhKdrsiu64i+us/NmUiNS9SLOzYvlUrG5dzcRR
         gLfSkauTI+Q/v/Frpmn5Dy/fYcG5FW8oAS9MeUrVehsBQchJBNssQL3AiQ0RXdeRifdo
         J9VA==
X-Gm-Message-State: AJIora+SgUqNDjPYdsu0ioweyi4rhNRur7Faa6//9Npt2JkOHOCE44AQ
        ZHt7hb3hLvh6pvrLQGE+6EM=
X-Google-Smtp-Source: AGRyM1tdJnOEAAG2MU/50+XLvXjJ0VrPiRGMUh3gxfKfO3XvIoKtcrohgEKtRakgcRXOUomIffPrrw==
X-Received: by 2002:a05:600c:285:b0:3a2:e5fd:84eb with SMTP id 5-20020a05600c028500b003a2e5fd84ebmr1745132wmk.151.1657455843866;
        Sun, 10 Jul 2022 05:24:03 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003a199ed4f44sm8983738wms.27.2022.07.10.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:24:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Sun, 10 Jul 2022 14:24:01 +0200
Message-ID: <2135356.irdbgypaU6@opensuse>
In-Reply-To: <Ysq+rpkTU1/nquHo@kroah.com>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com> <1891319.taCxCBeP46@opensuse> <Ysq+rpkTU1/nquHo@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 10 luglio 2022 13:57:34 CEST Greg Kroah-Hartman wrote:
> On Sun, Jul 10, 2022 at 01:18:16PM +0200, Fabio M. De Francesco wrote:
> > On domenica 10 luglio 2022 12:24:41 CEST Greg Kroah-Hartman wrote:
> > > On Sun, Jul 10, 2022 at 12:11:56PM +0200, Fabio M. De Francesco=20
wrote:
> > > > The use of kmap() is being deprecated in favor of=20
kmap_local_page().
> > > >=20
> > > > With kmap_local_page() the mappings are per thread, CPU local, can=
=20
take
> > > > page faults, and can be called from any context (including=20
interrupts).
> > >=20
> > > But that is not the case here for this kmap() instance?
> >=20
> > I'm not 100% sure to get what you are asking here :-)
> > Probably you mean that kmap() can work here and you don't see reason=20
for=20
> > converting? Am I understanding correctly?
>=20
> Yes, that is what I am saying, why is this conversion needed here?  A
> justification would be nice.
>=20
> > OK, then...
> >=20
> > kmap() is being deprecated in favor of kmap_local_page(). Please see=20
> > highmem.rst which I have updated weeks ago (https://docs.kernel.org/vm/
> > highmem.html).
> >=20
> > Two main problems with kmap(): (1) It comes with an overhead as mapping=
=20
> > space is restricted and protected by a global lock for synchronization=
=20
and=20
> > (2) kmap() also requires global TLB invalidation when the kmap=E2=80=99=
s pool=20
wraps=20
> > and it might block when the mapping space is fully utilized until a=20
slot=20
> > becomes available.
> >=20
> > kmap_local_page() should be preferred, where feasible, over all the=20
others.
>=20
> Ok, that is good to know, thanks for the pointer,

No problem. You've been very helpful when I used to work with drivers/
staging. I'm glad to give back some information you have not yet had time=20
to find out yourself.

> you should put this in
> the changelog text for maintainers who did not know this (like myself)
> as it makes it easier to review.

This sounds a very good idea. I'll do as you suggest for this and also for=
=20
the next (too many) conversions in my queue.

> > > If this is a
> > > simple search/replace, why is this not just done once and be done=20
with
> > > it?
> >=20
> > No, this job needs code inspection. After more than 25 conversions I=20
can=20
> > say that no more than 30% have been simple search and replace.
> >=20
> > > > Call kmap_local_page() in firmware_loader wherever kmap() is=20
currently
> > > > used. In firmware_rw() use the copy_{from,to}_page() helpers=20
instead of
> > > > open coding the local mappings plus memcpy().
> > >=20
> > > Isn't that just a different cleanup than the kmap() change?  Or is=20
that
> > > tied to the fact that the other buffer is now allocated with
> > > kmap_local_page() instead of kmap()?
> >=20
> > This kinds of changes have never been considered clean-ups by other=20
> > maintainers (for an example please see commit e88a6a8fece9 ("binder:=20
Use=20
> > memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()").=20
> >=20
> > Using helpers has always been considered part of the conversions=20
themselves=20
> > and nobody has ever requested further patches for these.
> >=20
> > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >  drivers/base/firmware_loader/main.c  | 4 ++--
> > > >  drivers/base/firmware_loader/sysfs.c | 9 ++++-----
> > > >  2 files changed, 6 insertions(+), 7 deletions(-)
> > >=20
> > > Did you run this through the firmware test framework?
> >=20
> > No, sorry. I assumed (wrongly?) that this is one of those cases which=20
don't=20
> > need any tests. However I have nothing against testing. I've done them=
=20
> > where they were absolutely needed for Btrfs conversions and kexec.
>=20
> Running the kernel selftests for firmware would be great, please do so
> for your next version of this patch that fixes the
> ktest-robot-found-issues.

I'll do the kernel self-tests. Thanks for pointing me to the right tools.

Again thanks,

=46abio



