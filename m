Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD348660F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiAFOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:30:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:42391 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiAFOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641479406;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=q7zQEgFCyNrP1/WsBjYgn8NhfBxY2IjADh9cYkfHaYk=;
    b=C6ck0JLX7gFz8GLblqQUXl3XiIm77zSdfr3zhI5WrGDSrHWof+WOa/dnGb1Sz7GxBL
    MRvxdzU22jfBRvHh3E9AtS+0sHlUGFQCgztsyzsfIh+P0PP7CuSpMeuwvrAJbZSCTgJJ
    xO2j6ajTO2LR6mDHNN/W0C515zgJSHS9H6JfXxrU7vcNZ14pYaEHhiUHncjy06WoojH6
    e9DKx5YMeAsUbjAZBdUBYDXTuqZwSXMrkC5xrSw1R4aXfMCPg5cuLVpbXFo8jiTvK7hm
    Q+rAH9oKt6M6cc3C9j70UBgfKT7DsMSdAfRsQMwtRaH4AMUAJe/N4mmLT4PdD5L1nS52
    agiw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaL/ScjzBA"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.37.4 DYNA|AUTH)
    with ESMTPSA id e23dc6y06EU50ST
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jan 2022 15:30:05 +0100 (CET)
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
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
Date:   Thu, 06 Jan 2022 15:30:04 +0100
Message-ID: <2468270.qO8rWLYou6@tauon.chronox.de>
In-Reply-To: <YcvEkfS4cONDXXB9@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de> <87r1a7thy0.fsf@suse.de> <YcvEkfS4cONDXXB9@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Dezember 2021, 03:14:41 CET schrieb Herbert Xu:

Hi Herbert,

> On Mon, Dec 20, 2021 at 04:27:35PM +0100, Nicolai Stange wrote:
> > Just for my understanding: the problem here is having a (single) enum
> > for the representation of all the possible "known" groups in the first
> > place or more that the individual group id enum members have hard-coded
> > values assigned to them each?
> 
> Yes the fact that you need to have a list of all "known" groups is
> the issue.
> 
> > However, after some back and forth, I opted against doing something
> > similar for dh at the time, because there are quite some more possible
> > parameter sets than there are for ecdh, namely ten vs. three. If we were
> 
> I don't understand why we can't support ten or an even larger
> number of parameter sets.
> 
> If you are concerned about code duplication then there are ways
> around that.  Or do you have another specific concern in mind
> with respect to a large number of parameter sets under this scheme?
> 
> > Anyway, just to make sure I'm getting it right: when you're saying
> > "template", you mean to implement a crypto_template for instantiating
> > patterns like "dh(ffdhe2048)", "dh(ffdhe3072)" and so on? The dh(...)
> > template instantiations would keep a crypto_spawn for referring to the
> > underlying, non-template "dh" kpp_alg so that "dh" implementations of
> > higher priority (hpre + qat) would take over once they'd become
> > available, correct?
> 
> The template would work in the other dirirection.  It would look
> like ffdhe2048(dh) with dh being implemented in either software or
> hardware.
> 
> The template wrapper would simply supply the relevant parameters.

I fully agree with you. However, there is a small wrinkle we should consider. 
In FIPS mode, we must only allow DH together with the safe primes provided by 
the templates of ffdheXX and modpXX.

This means in FIPS mode, invoking the algo of "dh" should not be possible. 
Yet, on the other hand, we cannot mark "dh" as fips_allowed == 0 as the 
templates would not be able to instantiate them.

Therefore, I think we should mark "dh" as CRYPTO_ALG_INTERNAL if in FIPS mode. 
To do so, I would think that dh_init should contain something like:

if (fips_enabled)
	dh.base.cra_flags |= CRYPTO_ALG_INTERNAL;

When encapsulating this small flag setting code into a helper function (just 
like xts_check_key or xts_verify_key) this helper can be added to other / new 
DH implementations QAT to make them FIPS-compliant. This would be the same 
approach as we currently take for XTS where each XTS implementation must have 
a callback to xts_check_key.

Marking "dh" as INTERNAL implies it cannot be allocated in FIPS mode. Some may 
think this is a small inconsistency as this algo is marked fips_allowed == 1. 
I personally think there is no inconsistency because DH *is* allowed, however 
with a small policy caveat (the requirement to use it with safe-primes). So, 
having "dh" with fips_allowed == 1 but marking it as INTERNAL should be also 
consistent.

Yes, it is a small misuse of the INTERNAL flag. But the alternative would be 
to create a "__dh" implementation that is wrapped by "dh". In turn this 
implies a big churn as we would need to touch all drivers implementing "dh".

> 
> Cheers,


Ciao
Stephan


