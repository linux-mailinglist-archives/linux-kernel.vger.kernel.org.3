Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0434A48EA27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiANMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:54:28 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36394 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbiANMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642164866;
        bh=VlYopUlU/dZusNNzCQzVaUstqWWXqVs4HkuRAe/MRr0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ES1hfZSWAA9TfB2Zuf0ErUKoh0yEgCd34zGF1Tj2ylHhAXSQ6QWqo2SHjJmg8jDeK
         zaVe2V/meQXJWPJlppkJm+DQ9HRxlQMPFHxuk02zJupGHURHvniLSn7vE1cTaRSA8l
         MkrlInbBPDEdBg51ipiMmQuMyQSiRbDnP6CO1l2o=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D37E31281205;
        Fri, 14 Jan 2022 07:54:26 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SFhWcQRURlwj; Fri, 14 Jan 2022 07:54:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642164866;
        bh=VlYopUlU/dZusNNzCQzVaUstqWWXqVs4HkuRAe/MRr0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ES1hfZSWAA9TfB2Zuf0ErUKoh0yEgCd34zGF1Tj2ylHhAXSQ6QWqo2SHjJmg8jDeK
         zaVe2V/meQXJWPJlppkJm+DQ9HRxlQMPFHxuk02zJupGHURHvniLSn7vE1cTaRSA8l
         MkrlInbBPDEdBg51ipiMmQuMyQSiRbDnP6CO1l2o=
Received: from [IPv6:2601:5c4:4300:c551::c447] (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3DD4A12811C5;
        Fri, 14 Jan 2022 07:54:25 -0500 (EST)
Message-ID: <9153507bd837a774ac76dafc23ca9a56451ef91e.camel@HansenPartnership.com>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while
 allowing hmac(sha1)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephan Mueller <smueller@chronox.de>,
        Nicolai Stange <nstange@suse.de>,
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
Date:   Fri, 14 Jan 2022 07:54:23 -0500
In-Reply-To: <1765621.jvH33SIsIh@tauon.chronox.de>
References: <20211209090358.28231-1-nstange@suse.de>
         <87k0f2hefl.fsf@suse.de> <YeFWnscvXtv73KBl@gondor.apana.org.au>
         <1765621.jvH33SIsIh@tauon.chronox.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-14 at 13:35 +0100, Stephan Mueller wrote:
> Am Freitag, 14. Januar 2022, 11:55:26 CET schrieb Herbert Xu:
> 
> Hi Herbert,
> 
> > > On an unrelated note, this will break trusted_key_tpm_ops->init() 
> > > in FIPS mode, because trusted_shash_alloc() would fail to get a
> > > hold of sha1. AFAICT, this could potentially make the
> > > init_trusted() module_init to fail, and, as encrypted-keys.ko
> > > imports key_type_trusted, prevent the loading of that one as
> > > well. Not sure that's desired...
> > 
> > Well if sha1 is supposed to be forbidden in FIPS mode why should
> 
> SHA-1 is approved in all use cases except signatures.

Actually, even that's not quite true: you can't use it in a FIPS
compliant system to *generate* signatures, but you can still use it in
a FIPS compliant system to verify legacy signatures (signatures created
before sha-1 was deprecated).  It's still also completely acceptable as
a hash for HMAC.

The supporting document is this one:

https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-131Ar1.pdf

The bottom line is removing SHA-1 to achieve "FIPS compliance" is the
wrong approach.  You just have to make sure you can never use it to
generate signatures.

James


