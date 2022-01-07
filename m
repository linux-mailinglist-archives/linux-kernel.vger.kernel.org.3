Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7E487326
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiAGGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:37:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiAGGhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:37:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30CE121117;
        Fri,  7 Jan 2022 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641537451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIQjcAIlZIBanVtOIP65zLGslt4nQ94ZBtMBJM1KnBg=;
        b=Nt/gVl/PR8oGMBsVx7ETqvvijQ2sj3ZcUigBVm7c4nDgAonMZPnepg5ZbPBBFutCv+TRb8
        bDvPmWNoMSzvA2wI1kwyY27db7ohXyuBaA0OsRiwyShaiOy7Nwg9ZILhKJhROhmWMfuqy9
        QjaHPPnvWUP/d4gu7cXvfiTz+e5U0BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641537451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIQjcAIlZIBanVtOIP65zLGslt4nQ94ZBtMBJM1KnBg=;
        b=uBWkCLFm1ckuD5XriBHye1lbxZ2qtjiDG0BLtdKG3QM7iNhBFpS9GDJF/I99taQz/u7Bz6
        s7eHIXHUi795HjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A940C13CA2;
        Fri,  7 Jan 2022 06:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p0OoJ6rf12HWEwAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 07 Jan 2022 06:37:30 +0000
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
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
In-Reply-To: <YdepEhTI/LB9wdJr@gondor.apana.org.au> (Herbert Xu's message of
        "Fri, 7 Jan 2022 13:44:34 +1100")
References: <20211209090358.28231-1-nstange@suse.de> <87r1a7thy0.fsf@suse.de>
        <YcvEkfS4cONDXXB9@gondor.apana.org.au>
        <2468270.qO8rWLYou6@tauon.chronox.de>
        <YdepEhTI/LB9wdJr@gondor.apana.org.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Fri, 07 Jan 2022 07:37:30 +0100
Message-ID: <87lezs3vbp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Thu, Jan 06, 2022 at 03:30:04PM +0100, Stephan Mueller wrote:
>>
>> This means in FIPS mode, invoking the algo of "dh" should not be possibl=
e.=20
>> Yet, on the other hand, we cannot mark "dh" as fips_allowed =3D=3D 0 as =
the=20
>> templates would not be able to instantiate them.
>
> Right, we have exactly the same problem with sha1 where sha1
> per se should be not be allowed in FIPS mode but hmac(sha1)
> should be.
>
>> Therefore, I think we should mark "dh" as CRYPTO_ALG_INTERNAL if in FIPS=
 mode.=20
> I think the annotation should be added to testmgr.c.  We could
> mark dh and sha1 as not fips_allowed but allowed as the parameter
> of a template.  This could then be represented in the crypto_alg
> object by a new flag.
>
> This flag could then be set automatically in crypto_grab_* to
> allow them to be picked up automatically for templates.
>
> I'm already writing this up for sha1 anyway so let me polish it
> off and I'll post it soon which you can then reuse it for dh.

Perfect, this will solve my problem with how to handle "dh"
vs. fips_enabled quite nicely.

Many thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
