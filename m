Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACB48A8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiAKHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:50:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiAKHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:50:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B7C6F1F3B6;
        Tue, 11 Jan 2022 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641887419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3gaq6Fpe5yLaoONtNRasnCAJt2YNbe9vyw0v/wh8RM=;
        b=Cr1hVVSDkKm8OAexg5DDB+dGf2zC7om6VHZeb89mGfgZairV5/zYM6qqomXYu703GAn+c7
        KsXGU7mMbwD8CSnLwifyQrQgR2LHnrd5PcFRQjNN04bq2Ca9tFnDzW3Yitt7jty2FqlJvT
        kKDgGz2RJseZzFFy2+9/pkBFvyKWyFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641887419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3gaq6Fpe5yLaoONtNRasnCAJt2YNbe9vyw0v/wh8RM=;
        b=aM2phZ+2niAVTXvv0kG1thwWspUyZUJkS7JegG6g8PcnsEHUIelzKess/CCVQQbsg57Z0y
        UV7XEbV7GitE6iCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37DC313638;
        Tue, 11 Jan 2022 07:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OXZVCbs23WHEfwAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 11 Jan 2022 07:50:19 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)
In-Reply-To: <Yd0gInht+V+Kcsw2@gondor.apana.org.au> (Herbert Xu's message of
        "Tue, 11 Jan 2022 17:13:54 +1100")
References: <20211209090358.28231-1-nstange@suse.de> <87r1a7thy0.fsf@suse.de>
        <YcvEkfS4cONDXXB9@gondor.apana.org.au>
        <2468270.qO8rWLYou6@tauon.chronox.de>
        <YdepEhTI/LB9wdJr@gondor.apana.org.au>
        <Yd0gInht+V+Kcsw2@gondor.apana.org.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Tue, 11 Jan 2022 08:50:18 +0100
Message-ID: <871r1eyamd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Fri, Jan 07, 2022 at 01:44:34PM +1100, Herbert Xu wrote:
>>
>> I'm already writing this up for sha1 anyway so let me polish it
>> off and I'll post it soon which you can then reuse it for dh.
>
> Here is something that seems to work for sha1/hmac.  Please let
> me know if you see any issues with this approach for dh.
>
> Thanks,
>
> ---8<---
> Currently we do not distinguish between algorithms that fail on
> the self-test vs. those which are disabled in FIPS mode (not allowed).
> Both are marked as having failed the self-test.
>
> As it has been requested that we need to disable sha1 in FIPS
> mode while still allowing hmac(sha1) this approach needs to change.
>
> This patch allows this scenario by adding a new flag FIPS_INTERNAL
> to indicate those algorithms that have passed the self-test and are
> not FIPS-allowed.  They can then be used for the self-testing of
> other algorithms or by those that are explicitly allowed to use them
> (currently just hmac).

I haven't tried, but wouldn't this allow the instantiation of e.g.
hmac(blake2s-256) in FIPS mode?

Thanks,

Nicolai

>
> Note that as a side-effect of this patch algorithms which are not
> FIPS-allowed will now return ENOENT instead of ELIBBAD.  Hopefully
> this is not an issue as some people were relying on this already.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
