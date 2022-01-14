Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3BF48EA00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiANMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:38:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:36567 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642163714;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MVCvrZ0qGCj7cjjsy9nHGn6+Uf8Jvh4gB/rTb3Zx58g=;
    b=GLqvNwS8sx2IgnDr1NV+of4whcVgYUV4hmtHLDlb51qDBaTRLB8sZ3W63MOr7alBt3
    0vzrvMM9GS751bybgNyCnxQ9sdZsAxf8QbbK5OyLlLgpXIRGIh0zC8ZVEsusLVzWyu8h
    ZJG0SgafDI2fwr5NM7NOJ0QjguTEwwu030J/+RM3c82+Qry3I9Kp4Q0q/Ls9+Oetvwe+
    342tdS5baH7DDH87cfkztcBE0xAe3s4H2PPuve6nd9k0Y7G2l7zT9V/kgGySkYHLYIfR
    dS16rBXjTWaB/VJoVkG8tC5VbReK0etf3Ihm067OPDZL0L5O7ToBfVfLyT5mWi29OhE1
    4wAw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbL/ScDv37"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id t60e2cy0ECZDZEJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 14 Jan 2022 13:35:13 +0100 (CET)
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
Date:   Fri, 14 Jan 2022 13:35:12 +0100
Message-ID: <1765621.jvH33SIsIh@tauon.chronox.de>
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

> > On an unrelated note, this will break trusted_key_tpm_ops->init() in
> > FIPS mode, because trusted_shash_alloc() would fail to get a hold of
> > sha1. AFAICT, this could potentially make the init_trusted() module_init
> > to fail, and, as encrypted-keys.ko imports key_type_trusted, prevent the
> > loading of that one as well. Not sure that's desired...
> 
> Well if sha1 is supposed to be forbidden in FIPS mode why should

SHA-1 is approved in all use cases except signatures.

Ciao
Stephan


