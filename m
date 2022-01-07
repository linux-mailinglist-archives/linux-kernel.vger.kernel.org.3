Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7D48733D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiAGHBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:01:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiAGHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:01:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD48B21110;
        Fri,  7 Jan 2022 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641538866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C+FOPOAlJErWFC/CZxgo1BoC+YGMpjmEjNtbMN44+M=;
        b=utyw9gMiU2bGyYmvN6Ae8LkMV0GQP5wVM/VEANIrJu3UfiQAjgd4G8OlvLIaasuPcTffHN
        rtb2cU1PcZu9LCYPXYriCszszNqRpBz64dUixvSckenAvmdEduH6YXVL6iLymVZ2fVfRtN
        BlcUW15Nnqo+bG7Wu3D6i1cHfFjmPnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641538866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C+FOPOAlJErWFC/CZxgo1BoC+YGMpjmEjNtbMN44+M=;
        b=u8WdzK0XZuYwh/NYEgeFRuNfi9yiPpT42fQ3UI7kH9gS75Wvvk0VDKTDeWwbrZuX6G/3/L
        rNxcG9AEciy2TIAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5225713CA1;
        Fri,  7 Jan 2022 07:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2m2pEjLl12GJGgAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 07 Jan 2022 07:01:06 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
In-Reply-To: <YcvEkfS4cONDXXB9@gondor.apana.org.au> (Herbert Xu's message of
        "Wed, 29 Dec 2021 13:14:41 +1100")
References: <20211209090358.28231-1-nstange@suse.de>
        <20211209090358.28231-4-nstange@suse.de>
        <20211217055227.GA20698@gondor.apana.org.au> <87r1a7thy0.fsf@suse.de>
        <YcvEkfS4cONDXXB9@gondor.apana.org.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Fri, 07 Jan 2022 08:01:05 +0100
Message-ID: <87ee5k3u8e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Mon, Dec 20, 2021 at 04:27:35PM +0100, Nicolai Stange wrote:
>>=20
>> Just for my understanding: the problem here is having a (single) enum
>> for the representation of all the possible "known" groups in the first
>> place or more that the individual group id enum members have hard-coded
>> values assigned to them each?
>
> Yes the fact that you need to have a list of all "known" groups is
> the issue.

Ok, understood. Thanks for the clarification.


>> However, after some back and forth, I opted against doing something
>> similar for dh at the time, because there are quite some more possible
>> parameter sets than there are for ecdh, namely ten vs. three. If we were
>
> I don't understand why we can't support ten or an even larger
> number of parameter sets.

There's no real reason. I just didn't dare to promote what I considered
mere input parameter sets to full-fledged crypto_alg instances with
their associated overhead each:
- the global crypto_alg_list will get longer, which might have an
  impact on the lookup searches,
- every ffdheXYZ(dh) template instance will need to have individual
  TVs associated with it.

However, I take it as that's fine and I'd be more than happy to
implement the ffhdheXYZ(dh) template approach you suggested in a v3.


>
> If you are concerned about code duplication then there are ways
> around that.  Or do you have another specific concern in mind
> with respect to a large number of parameter sets under this scheme?
>=20=20
>> Anyway, just to make sure I'm getting it right: when you're saying
>> "template", you mean to implement a crypto_template for instantiating
>> patterns like "dh(ffdhe2048)", "dh(ffdhe3072)" and so on? The dh(...)
>> template instantiations would keep a crypto_spawn for referring to the
>> underlying, non-template "dh" kpp_alg so that "dh" implementations of
>> higher priority (hpre + qat) would take over once they'd become
>> available, correct?
>
> The template would work in the other dirirection.  It would look
> like ffdhe2048(dh) with dh being implemented in either software or
> hardware.
>
> The template wrapper would simply supply the relevant parameters.

Makes sense.

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
