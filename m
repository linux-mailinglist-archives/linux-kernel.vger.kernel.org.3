Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58245141F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354244AbiD2FwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354219AbiD2FwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:52:07 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB1B18AB;
        Thu, 28 Apr 2022 22:48:49 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nkJUf-00890j-CP; Fri, 29 Apr 2022 15:48:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Apr 2022 13:48:41 +0800
Date:   Fri, 29 Apr 2022 13:48:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jacky Li <jackyli@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
Message-ID: <Ymt8OSqkna177KCB@gondor.apana.org.au>
References: <20220414162325.1830014-1-jackyli@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414162325.1830014-1-jackyli@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:23:25PM +0000, Jacky Li wrote:
> There are 2 common cases when INIT_EX data file might not be
> opened successfully and fail the sev initialization:
> 
> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>    current->fs->root to point to arbitrary directories. While
>    init_ex_path is provided as a module param related to root file
>    system. Solution: use the root directory of init_task to avoid
>    accessing the wrong file.
> 
> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>    the INIT_EX data file. Solution: open the file as root and
>    restore permissions immediately.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Signed-off-by: Jacky Li <jackyli@google.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>
> ---
> Changelog since v1:
> - Added Fixes tag and Reviewed-By tag.
> 
>  drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
