Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDCE470036
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhLJLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:42:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbhLJLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:42:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C62CB210FE;
        Fri, 10 Dec 2021 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT1IPygTfLcSdf/S3UzlR3XyAhpLtShiK2l6TIU5LMo=;
        b=fJBdq08nMTbxukq6CZdUY/8iQcx25/uQmANNP0Sow8GsZIg1E9zUGlgwc4eodlTtGmiP1H
        5i3wf+ntW/Z5uPQ0Whl+XjiTSCoEeG6xkEigmL6AFkU/igrBU/FSrIXGDrKlF1QJt+pVsn
        T+cCcSGW2YfEXhgHL0IFt6xcmtBJyOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT1IPygTfLcSdf/S3UzlR3XyAhpLtShiK2l6TIU5LMo=;
        b=kJhajqgJYCKpyDt8LLNSLqVU5XrKcxl6DeS6ii1qHaRR13Cfl+q5jvoEJDk32nw+8in3Xc
        gLn7TmsVtQw25eAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B9413DDE;
        Fri, 10 Dec 2021 11:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yrMnKDc8s2FqcQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:38:31 +0000
Subject: Re: [PATCH v2 00/18] crypto: dh - infrastructure for NVM in-band auth
 and FIPS conformance
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
References: <20211209090358.28231-1-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <aabe44df-0b6c-8550-0138-b08f90ef9233@suse.de>
Date:   Fri, 10 Dec 2021 12:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> Hi all,
> 
> first of all, to the people primarily interested in security/keys/, there's
> a rather trivial change to security/keys/dh.c in patch 2/18. It would be
> great to get ACKs for that...
> 
> This is v2, v1 can be found at
> 
>   https://lore.kernel.org/r/20211201004858.19831-1-nstange@suse.de
> 
> For a list of changes, see below.
> 
> Quote from v1's cover letter:
> ===
> Hannes' recent work on NVME in-band authentication ([1]) needs access to
> the RFC 7919 DH group parameters and also some means to generate ephemeral
> keys. He currently implements both as part of his patchset (patches 3/12
> and 8/12). After some internal discussion, we decided to split off the bits
> needed from crypto/dh into a separate series, i.e. this one here:
>  - for the RFC 7919 DH group parameters, it's undesirable from a
>    performance POV to serialize the well-known domain parameters via
>    crypto_dh_encode_key() just to deserialize them shortly after again,
>  - from an architectural POV, it would be preferrable to have the key
>    generation code in crypto/dh.c rather than in drivers/nvme/,
>    just in analogy to how key generation is supported by crypto/ecdh.c
>    already.
> 
> Patches 1-13/18 implement all that is needed for the NVME in-band
> authentication support. 
> 
> Unfortunately, due to the lack of HW, I have not been able to test
> the changes to the QAT or HPRE drivers (other than mere compile tests).
> Yet I figured it would be a good idea to have them behave consistently with
> dh_generic, and so I chose to introduce support for privkey generation to
> these as well.
> 
> 
> By coincidence, NIST SP800-56Arev3 compliance effectively requires that
> the domain parameters are checked against an approved set, which happens
> to consists of those safe-prime group parameters specified in RFC 7919,
> among others. Thus, introducing the RFC 7919 parameters to the kernel
> allows for making the DH implementation to conform to SP800-56Arev3 with
> only little effort. I used the opportunity to work crypto/dh towards
> SP800-56Arev3 conformance with the rest of this patch series, i.e.
> patches 14-18/18. I can split these into another series on its own, if you
> like. But as they depend on the earlier patches 1-13/18, I sent them
> alongside for now.
> ===
> 
> This patchset has been tested with and without fips_enabled on x86_64,
> ppc64le and s390x, the latter being big endian.
> 
> 
> Changes v1 -> v2:
> - Throughout the patchset:
>   - Upcase enum group_id members and strip superfluous _RFCXYZ_ parts from
>     the names.
>   - Carry Hannes' Reviewed-bys from v1 over for those patches which
>     have not changed (except for that group_id member renaming)
> - [03/18] ("crypto: dh - optimize domain parameter serialization for
>             well-known groups"):
>   - For better portability, don't serialize/deserialize directly from/to
>     an enum group_id, but use an intermediate int for that.
> - [05/18] ("crypto: testmgr - add DH RFC 7919 ffdhe2048 test vector")
>   - Use ffdhe3072 TVs rather than ones for ffdhe2048. Requested by Hannes,
>     because "the NVMe spec mandates for its TLS profile the ffdhe3072
>     group".
> - [13/18] ("crypto: testmgr - add DH test vectors for key generation")
>   - Use ffdhe3072 in place of ffdhe2048 here as well.
>   - Rather than introducing completely new keypairs, reuse the ones
>     from the known answer test introduced previously in this patchset.
> 
> Thanks,
> 
> Nicolai
> 
> [1] https://lkml.kernel.org/r/20211123123801.73197-1-hare@suse.de
> 
> 
> Nicolai Stange (18):
>   crypto: dh - remove struct dh's ->q member
>   crypto: dh - constify struct dh's pointer members
>   crypto: dh - optimize domain parameter serialization for well-known
>     groups
>   crypto: dh - introduce RFC 7919 safe-prime groups
>   crypto: testmgr - add DH RFC 7919 ffdhe3072 test vector
>   crypto: dh - introduce RFC 3526 safe-prime groups
>   crypto: testmgr - add DH RFC 3526 modp2048 test vector
>   crypto: testmgr - run only subset of DH vectors based on config
>   crypto: dh - implement private key generation primitive
>   crypto: dh - introduce support for ephemeral key generation to
>     dh-generic
>   crypto: dh - introduce support for ephemeral key generation to hpre
>     driver
>   crypto: dh - introduce support for ephemeral key generation to qat
>     driver
>   crypto: testmgr - add DH test vectors for key generation
>   lib/mpi: export mpi_rshift
>   crypto: dh - store group id in dh-generic's dh_ctx
>   crypto: dh - calculate Q from P for the full public key verification
>   crypto: dh - try to match domain parameters to a known safe-prime
>     group
>   crypto: dh - accept only approved safe-prime groups in FIPS mode
> 
>  crypto/Kconfig                                |  20 +-
>  crypto/dh.c                                   |  73 +-
>  crypto/dh_helper.c                            | 691 +++++++++++++++++-
>  crypto/testmgr.h                              | 388 +++++++++-
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c   |  11 +
>  drivers/crypto/qat/qat_common/qat_asym_algs.c |   9 +
>  include/crypto/dh.h                           |  52 +-
>  lib/mpi/mpi-bit.c                             |   1 +
>  security/keys/dh.c                            |   2 +-
>  9 files changed, 1189 insertions(+), 58 deletions(-)
> 
I have run this implementation against my NVMe In-band authentication
test suite and have found no issues.

Tested-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
