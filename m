Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D149FD37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349741AbiA1P4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:56:02 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:40303 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349718AbiA1P4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643384996;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FbbK5BCqwc+LVSOODivmoMY7VA5yrwUnCl/SUOH2vUk=;
    b=FYm+mIGjvMuxIoWGb4E8SJnLihAlEBBxtcdxXp55elBwEY4A6sAolUt+rDPK9UxlCo
    ZI11nop0nQwfkl5DlPVitY6M/5DeCYyItwF6OO95XAHZto1BAhWqdstwYaUjTaJ3Vn+C
    QEF2k3EEC6S8iPAFs2J4vwosklPuPQr/4EpfEneRBxDI3VEDqNXIa8xvWON4rCzNUN+I
    vtDQ45hu2wc4zeLpdHFdfShijxwvmRw16WKBifpC8St7Xg6/cmxumj0pV4vOP3J4Tu3x
    uzCgMCZLaMYaaQn+w2hs1QgjcnpHWOcw/99WZ478v+JUNe06qEsvOgTBP7cudrgaapgg
    hBXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvSOeuZzLM="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id v5f65ay0SFntwxY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 28 Jan 2022 16:49:55 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolai Stange <nstange@suse.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)
Date:   Fri, 28 Jan 2022 16:49:54 +0100
Message-ID: <1738803.My4pmAdfGn@tauon.chronox.de>
In-Reply-To: <87v8y4dk1c.fsf@suse.de>
References: <20211209090358.28231-1-nstange@suse.de> <YeFWnscvXtv73KBl@gondor.apana.org.au> <87v8y4dk1c.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Januar 2022, 15:14:39 CET schrieb Nicolai Stange:

Hi Nicolai,

> Herbert Xu <herbert@gondor.apana.org.au> writes:
> > On Fri, Jan 14, 2022 at 10:09:02AM +0100, Nicolai Stange wrote:
> >> This looks all good to me, but as !->fips_allowed tests aren't skipped
> >> over anymore now, it would perhaps make sense to make their failure
> >> non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
> >> panic and some of the existing TVs might not pass because of e.g. some
> >> key length checks or so active only for fips_enabled...
> > 
> > You mean a buggy non-FIPS algorithm that fails when tested in
> > FIPS mode?  I guess we could skip the panic in that case if
> > everyone is happy with that.  Stephan?
> 
> One more thing I just realized: dracut's fips module ([1]) modprobes
> tcrypt (*) and failure is considered fatal, i.e. the system would not
> boot up.
> 
> First of all this would mean that tcrypt_test() needs to ignore
> -ECANCELED return values from alg_test() in FIPS mode, in addition to
> the -EINVAL it is already prepared for.
> 
> However, chances are that some of the !fips_allowed algorithms looped
> over by tcrypt are not available (i.e. not enabled at build time) and as
> this change here makes alg_test() to unconditionally attempt a test
> execution now, this would fail with -ENOENT AFAICS.
> 
> One way to work around this is to make tcrypt_test() to ignore -ENOENT
> in addition to -EINVAL and -ECANCELED.
> 
> It might be undesirable though that the test executions triggered from
> tcrypt would still instantiate/load a ton of !fips_allowed algorithms at
> boot, most of which will effectively be inaccessible (because they're
> not used as FIPS_INTERNAL arguments to fips_allowed == 1 template
> instances).
> 
> So how about making alg_test() to skip the !fips_allowed tests in FIPS
> mode as before, but to return -ECANCELED and eventually set
> FIPS_INTERNAL as implemented with this patch here.
> 
> This would imply that FIPS_INTERNAL algorithms by themselves remain
> untested, but I think this might be Ok as they would be usable only as
> template arguments in fips_allowed instantiations. That is, they will
> still receive some form of testing when the larger construction they're
> part of gets tested.
> 
> For example, going with the "dh" example, where "dh" and "ffdhe3072(dh)"
> would have fips_allowed unset and set respecively, ffdhe3072(dh) as
> a whole would get tested, but not the "dh" argument individually.
> 
> Stephan, would this approach work from a FIPS 140-3 perspective?

Are we sure that we always will have power-up tests of the compound algorithms 
when we disable the lower-level algorithm testing?

For example, consider the DH work you are preparing: we currently have a self 
test for dh - which then will be marked as FIPS_INTERNAL and not executed. 
Would we now have self tests for modpXXX(dh) or ffdheXXX(dh)? If not, how 
would it be guaranteed that DH is tested?

The important part is that the algorithm testing is guaranteed. I see a number 
of alg_test_null in testmgr.c. I see the potential that some algorithms do not 
get tested at all when we skip FIPS_INTERNAL algorithms.

From a FIPS perspective it is permissible that compound algo power up tests 
are claimed to cover respective lower-level algos.

> 
> Thanks!
> 
> Nicolai
> 
> [1]
> https://git.kernel.org/pub/scm/boot/dracut/dracut.git/tree/modules.d/01fips
> /fips.sh#n106 (*) I'm not sure why this is being done, but it is what it is.


Ciao
Stephan


