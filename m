Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D224870B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiAGCo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:44:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59070 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344689AbiAGCo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:44:57 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n5fF4-0006RF-Jm; Fri, 07 Jan 2022 13:44:35 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jan 2022 13:44:34 +1100
Date:   Fri, 7 Jan 2022 13:44:34 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter
 serialization for well-known groups
Message-ID: <YdepEhTI/LB9wdJr@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de>
 <87r1a7thy0.fsf@suse.de>
 <YcvEkfS4cONDXXB9@gondor.apana.org.au>
 <2468270.qO8rWLYou6@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2468270.qO8rWLYou6@tauon.chronox.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 03:30:04PM +0100, Stephan Mueller wrote:
>
> This means in FIPS mode, invoking the algo of "dh" should not be possible. 
> Yet, on the other hand, we cannot mark "dh" as fips_allowed == 0 as the 
> templates would not be able to instantiate them.

Right, we have exactly the same problem with sha1 where sha1
per se should be not be allowed in FIPS mode but hmac(sha1)
should be.

> Therefore, I think we should mark "dh" as CRYPTO_ALG_INTERNAL if in FIPS mode. 
I think the annotation should be added to testmgr.c.  We could
mark dh and sha1 as not fips_allowed but allowed as the parameter
of a template.  This could then be represented in the crypto_alg
object by a new flag.

This flag could then be set automatically in crypto_grab_* to
allow them to be picked up automatically for templates.

I'm already writing this up for sha1 anyway so let me polish it
off and I'll post it soon which you can then reuse it for dh.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
