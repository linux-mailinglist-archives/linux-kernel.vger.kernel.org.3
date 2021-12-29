Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6B480ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhL2CPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:15:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58690 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhL2CPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:15:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n2OUD-0006Gl-J6; Wed, 29 Dec 2021 13:14:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 29 Dec 2021 13:14:41 +1100
Date:   Wed, 29 Dec 2021 13:14:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter
 serialization for well-known groups
Message-ID: <YcvEkfS4cONDXXB9@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-4-nstange@suse.de>
 <20211217055227.GA20698@gondor.apana.org.au>
 <87r1a7thy0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1a7thy0.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:27:35PM +0100, Nicolai Stange wrote:
> 
> Just for my understanding: the problem here is having a (single) enum
> for the representation of all the possible "known" groups in the first
> place or more that the individual group id enum members have hard-coded
> values assigned to them each?

Yes the fact that you need to have a list of all "known" groups is
the issue.

> However, after some back and forth, I opted against doing something
> similar for dh at the time, because there are quite some more possible
> parameter sets than there are for ecdh, namely ten vs. three. If we were

I don't understand why we can't support ten or an even larger
number of parameter sets.

If you are concerned about code duplication then there are ways
around that.  Or do you have another specific concern in mind
with respect to a large number of parameter sets under this scheme?
 
> Anyway, just to make sure I'm getting it right: when you're saying
> "template", you mean to implement a crypto_template for instantiating
> patterns like "dh(ffdhe2048)", "dh(ffdhe3072)" and so on? The dh(...)
> template instantiations would keep a crypto_spawn for referring to the
> underlying, non-template "dh" kpp_alg so that "dh" implementations of
> higher priority (hpre + qat) would take over once they'd become
> available, correct?

The template would work in the other dirirection.  It would look
like ffdhe2048(dh) with dh being implemented in either software or
hardware.

The template wrapper would simply supply the relevant parameters.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
