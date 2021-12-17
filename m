Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D39478451
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhLQEwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:52:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58058 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhLQEwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:52:08 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my5Di-0006xU-Io; Fri, 17 Dec 2021 15:51:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 15:51:50 +1100
Date:   Fri, 17 Dec 2021 15:51:50 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Suheil Chandran <schandran@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx2 - Avoid stack variable overflow
Message-ID: <20211217045150.GA20345@gondor.apana.org.au>
References: <20211215225558.1995027-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215225558.1995027-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 02:55:58PM -0800, Kees Cook wrote:
>> @@ -1762,7 +1762,7 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf)
>  	char engs_info[2 * OTX2_CPT_NAME_LENGTH];
>  	struct otx2_cpt_eng_grp_info *grp;
>  	struct otx2_cpt_engs_rsvd *engs;
> -	u32 mask[4];
> +	u32 mask[5];

Are you sure 144 bits will overflow u32[4]? If not then shouldn't
the fix be to remove the bogus print on mask[4]?

On another note, the debug code looks like crap if engs_num is
less than the maximum of 144 as it will print random data from
the kernel stack.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
