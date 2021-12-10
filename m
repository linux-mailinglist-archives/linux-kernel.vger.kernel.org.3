Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF2470287
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhLJOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:20:23 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:14071 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbhLJOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639145796;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=w0hmisnmVGY9lmZ3mfuG+ug8gAPJA9hY6p1igaGTfq8=;
    b=pOrRS0pMzopHPLQNnzFrR7O2hPB3kUbKx8RsYz3qA9Uw6IQlJzDBH+vOU+wKXdSRjl
    tG1i1Z1XteIH48NrRVLJbyGSB0U3kr0Vt/y/9lTsHvKJrsouZ18uFbet92kstTV+m+9I
    V+2by9eHtKf7jD77RfgsuYB2KipxbyK/QpdLaMyXKs8QF9dOAnFDe6FIeN2PTgjMWudY
    eUG+0K6hXpTqSS+cUy3UMMB2bNApBAqAeYmxoJ554T6iRm/EWU90jLPQCISWqqn/kA8l
    ChdfCMY4Kbabtn4Mv3LFA4JGwzGxAcVed8hsrA6CpTC/j1mJMHp/7nWom5H/6lFNpiI3
    7WlQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaI/SfwWp+"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id z09342xBAEGZ7lp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 10 Dec 2021 15:16:35 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Yujie Liu <yujie.liu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [security] d3b04a4398: WARNING:at_crypto/kdf_sp800108.c:#crypto_kdf108_init
Date:   Fri, 10 Dec 2021 15:16:34 +0100
Message-ID: <3737408.Lz6Wf2Li4r@tauon.chronox.de>
In-Reply-To: <766e5415-cc94-1b46-2326-d55343a80388@intel.com>
References: <20211130080419.GC29514@xsang-OptiPlex-9020> <3438006.aCxCBeP46V@positron.chronox.de> <766e5415-cc94-1b46-2326-d55343a80388@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 10. Dezember 2021, 03:54:32 CET schrieb Yujie Liu:

Hi Yujie, Herbert,

> This table shows that we have tested commit d3b04a4398("security: DH - use
> KDF implementation from crypto API") for several runs of boot test in qemu
> but got 100% bad result. We have also tested its parent commit (i.e. commit
> d792134423 "security: DH - remove dead code for zero padding") and all the
> runs got 100% good result. So this is not a random issue.
> 
> > I am unable to reproduce it with i386 and clang-13. I can also not
> > reproduce it with GCC.
> 
> We have tested the i386 kernel built by gcc-9 or clang-14, and confirmed
> both of them can reproduce this issue reliably.
> 
> Please be sure to follow the reproduce steps in original report mail. The
> full reproduce log is attached.

Thank you for your response. The key log info is:

alg: self-tests for CTR-KDF (hmac(sha256)) failed (rc=-12)

And I finally see what the problem is: you selected SHA-256 as module but the 
KDF implementation is selected to be statically linked.

So the KDF self test tries to allocate the SHA-256 algorithm and fails which 
causes the ENOMEM error.


Herbert, what is your preference in handling this:

- we could SELECT CRYPTO_SHA256 when the KDF is compiled. This would only be 
necessary to satisfy the self test. Yet, there is no guarantee that SHA-256 
would truly be needed because the DH code that calls the KDF obtains the 
reference to the hash from user space. In the end we could hard compile a 
crypto algorithm into the kernel that may never be used.

- we could relax the KDF self test a bit and could prevent the self test being 
executed if we get an ENOENT back during the algorithm allocation. But that 
would imply that the KDF self test would never be executed. Even when SHA-256 
is compiled as module and insmod'ed at a later time the KDF self test is not 
executed as it is only executed from the __init function.


I would prefer to consider the first option to also statically compile 
SHA-256.

Ciao
Stephan


