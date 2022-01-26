Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAF49C5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiAZJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:01:28 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:46263 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiAZJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643187679;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bEkghuCjX1cE+0Md8pTK57v3o8W2gb012RZrKU1aDPg=;
    b=Al2PI6CbIhniAgVw8riXxxpW31+Zpj2mtAgbMKXt6XSrnhkqj9YPubRBr7iXQjRDxV
    HwCdhir+Kv5ODvUwkBHMZw/EBduUzd1s0TuIxZH8CUtheMwBK5U/QlduBw6HjNGsyvct
    Z9ZOtTkhS5skymFyI16P0vTiJ2zGlzZpzxIXy9nO15u913K0Bgmb83M1J4JEk4OJBiRV
    p6Cx1NHV6/qelCKl726YyVezrWrO8qTFfUjf7lhFg56E7GVLrT13nAv1/0qL860o3jsf
    0O3jjjv1XTAJ+HbzMQiDGIvz1loZ4GStVMasQD6B2L1BOs84nlhsNSYOorAvknTseoVF
    EOIg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJvScdWrN"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id v5f65ay0Q91IjYG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jan 2022 10:01:18 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)
Date:   Wed, 26 Jan 2022 10:01:17 +0100
Message-ID: <3615781.PPvlf9ziaL@tauon.chronox.de>
In-Reply-To: <YeFWnscvXtv73KBl@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de> <87k0f2hefl.fsf@suse.de> <YeFWnscvXtv73KBl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. Januar 2022, 11:55:26 CET schrieb Herbert Xu:

Hi Herbert,

> 
> > This looks all good to me, but as !->fips_allowed tests aren't skipped
> > over anymore now, it would perhaps make sense to make their failure
> > non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
> > panic and some of the existing TVs might not pass because of e.g. some
> > key length checks or so active only for fips_enabled...
> 
> You mean a buggy non-FIPS algorithm that fails when tested in
> FIPS mode?  I guess we could skip the panic in that case if
> everyone is happy with that.  Stephan?

As we consider FIPS 140-3, we can allow a "degrated mode of operation". A 
degraded mode of operation disables only the algorithm that caused the 
failure. With a failing self test and not having a panic(), the offending 
algorithm implementation will not be available to the kernel crypto API and 
thus to a user.

In this case, we can replace the panic with a graceful error.

If that change is applied, I would like to mention to anybody that wants to 
backport the change: this change is not appropriate for FIPS 140-2.

Ciao
Stephan


