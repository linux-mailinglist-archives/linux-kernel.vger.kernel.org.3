Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7A4689AD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 07:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhLEGKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 01:10:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:30394 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhLEGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 01:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638684433;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X1QJjnxt7d9VY4UsePDANXe2aTti1wuY2g8kgKEwXdo=;
    b=K0bBXk4I231XuXWMoFJfKfSSAhPJ3fA2NsfKrmNgziZOhGH27hIzcRPhJJnIMfNSBY
    WsYhX+1/ge6X5+725GPmAAzp7zAQ3FKoIsW4WsYeDSn06PNEt61LFfiVyGF26xjPUSro
    3p18lxsP/9UyeBpY1pQz4/C1wuB6d+JTveGh+xmpMVXFvVg+LYcjN7yznxfs05gIpiC5
    IOMURNGIHA5FyKPDe6AwF5N7v1MSDGNJAXNWC4GeQW7nvM6uglJnP+p2NnbWtJbwIyGf
    +QW8DD7zU9hNysetce32LqrSM74RG300QqbiLNTEwHa3YJlym5tCitb6mPCBHrGV88mV
    5Ulg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSf8vUi"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xB567BtvE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 5 Dec 2021 07:07:11 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 16/18] crypto: dh - calculate Q from P for the full public key verification
Date:   Sun, 05 Dec 2021 07:07:11 +0100
Message-ID: <4182894.UPlyArG6xL@positron.chronox.de>
In-Reply-To: <20211201004858.19831-17-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de> <20211201004858.19831-17-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Dezember 2021, 01:48:56 CET schrieb Nicolai Stange:

Hi Nicolai,

> As the ->q in struct dh_ctx gets never set anywhere, the code
> in dh_is_pubkey_valid() for doing the full public key validation in
> accordance to SP800-56Arev3 is effectively dead.
> 
> However, for safe-prime groups, Q = (P - 1)/2 by definition and this
> enables dh_is_pubkey_valid() to calculate Q on the fly for these groups.
> Implement this.
> 
> With this change, the last code accessing struct dh_ctx's ->q is now gone.
> Remove this member from struct dh_ctx.

Isn't it expensive to always calculate Q for a-priori known values? Why not 
add Q to the safe-prime definitions and do not do this operation here?

If you need Q for all of those safe-primes, you may get them from [1] and 
following lines.

[1] https://github.com/smuellerDD/acvpparser/blob/master/parser/
safeprimes.h#L346

Ciao
Stephan


