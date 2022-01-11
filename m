Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816C948AB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiAKKex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:34:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59324 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349054AbiAKKep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:34:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n7ETr-0003IF-Gs; Tue, 11 Jan 2022 21:34:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Jan 2022 21:34:19 +1100
Date:   Tue, 11 Jan 2022 21:34:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing
 hmac(sha1)
Message-ID: <Yd1dK//76455cHdz@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de>
 <87r1a7thy0.fsf@suse.de>
 <YcvEkfS4cONDXXB9@gondor.apana.org.au>
 <2468270.qO8rWLYou6@tauon.chronox.de>
 <YdepEhTI/LB9wdJr@gondor.apana.org.au>
 <Yd0gInht+V+Kcsw2@gondor.apana.org.au>
 <871r1eyamd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r1eyamd.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 08:50:18AM +0100, Nicolai Stange wrote:
>
> I haven't tried, but wouldn't this allow the instantiation of e.g.
> hmac(blake2s-256) in FIPS mode?

You're right.  The real issue is that any algorithm with no tests
at all is allowed in FIPS mode.  That's clearly suboptimal.  But we
can't just ban every unknown algorithm because we rely on that
to let things like echainiv through.

Let me figure out a way to differentiate these two cases.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
