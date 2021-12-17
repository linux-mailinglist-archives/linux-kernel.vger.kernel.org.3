Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9A478652
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhLQIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:39:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58070 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhLQIjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:39:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my8le-0000vq-Kb; Fri, 17 Dec 2021 19:39:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 19:39:06 +1100
Date:   Fri, 17 Dec 2021 19:39:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Gonda <pgonda@google.com>
Cc:     thomas.lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/5] Add SEV_INIT_EX support
Message-ID: <20211217083906.GB7018@gondor.apana.org.au>
References: <20211207233306.2200118-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207233306.2200118-1-pgonda@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:33:01PM -0800, Peter Gonda wrote:
> SEV_INIT requires users to unlock their SPI bus for the PSP's non
> volatile (NV) storage. Users may wish to lock their SPI bus for numerous
> reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> allows the firmware to use a region of memory for its NV storage leaving
> the kernel responsible for actually storing the data in a persistent
> way. This series adds a new module parameter to ccp allowing users to
> specify a path to a file for use as the PSP's NV storage. The ccp driver
> then reads the file into memory for the PSP to use and is responsible
> for writing the file whenever the PSP modifies the memory region.
> 
> V4-5
> * Fix make C=1 W=1 warnings.
> 
> V3
> * Add another module parameter 'psp_init_on_probe' to allow for skipping
>   PSP init on module init.
> * Fixes review comments from Sean.
> * Fixes missing error checking with file reading.
> * Removed setting 'error' to a set value in patch 1.
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> David Rientjes (1):
>   crypto: ccp - Add SEV_INIT_EX support
> 
> Peter Gonda (4):
>   crypto: ccp - Add SEV_INIT rc error logging on init
>   crypto: ccp - Move SEV_INIT retry for corrupted data
>   crypto: ccp - Refactor out sev_fw_alloc()
>   crypto: ccp - Add psp_init_on_probe module parameter
> 
>  .../virt/kvm/amd-memory-encryption.rst        |   6 +
>  drivers/crypto/ccp/sev-dev.c                  | 259 +++++++++++++++---
>  include/linux/psp-sev.h                       |  21 ++
>  3 files changed, 245 insertions(+), 41 deletions(-)
> 
> -- 
> 2.34.1.400.ga245620fadb-goog

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
