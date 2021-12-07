Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F87646B229
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhLGFY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:24:28 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57508 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhLGFY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:24:27 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1muStx-00086p-Q6; Tue, 07 Dec 2021 16:20:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Dec 2021 16:20:29 +1100
Date:   Tue, 7 Dec 2021 16:20:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
Message-ID: <20211207052029.GA12141@gondor.apana.org.au>
References: <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
 <202112012304.973C04859C@keescook>
 <20211203022821.GA16082@gondor.apana.org.au>
 <YaqC1mkcyzO2WrI/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaqC1mkcyzO2WrI/@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:49:26PM -0800, Dmitry Torokhov wrote:
>
> I must be getting lost in terminology, and it feels to me that what is
> discussed here is most likely of no interest to a lot of potential
> users, especially ones that do compression/decompression. In majority of
> cases they want to simply compress or decompress data, and they just
> want to do it quickly and with minimal amount of memory consumed. They
> do not particularly care if the task is being offloaded or executed on
> the main CPU, either on separate thread or on the same thread, so the
> discussion about scomp/acomp/etc is of no interest to them. From their
> perspective they'd be totally fine with a wrapper that would do:
> 
> int decompress(...) {
> 	prepare_request()
> 	send_request()
> 	wait_for_request()
> }
> 
> and from their perspective this would be a synchronous API they are
> happy with.

You can certainly do that as a Crypto API user.  And we do have
some users who do exactly this (for example, testmgr does that
when testing async algorithms).  However, this can't be a part of
the API itself since many of our users execute in atomic contexts.

> So from POV of such users what is actually missing is streaming mode of
> compressing/decompressing where core would allow supplying additonal
> data on demand and allow consuming output as it is being produced, and I
> do not see anything like that in either scomp or acomp.

That is indeed a very crucial part of the compression API that is
missing.  And I would love someone to donate some time to addressing
this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
