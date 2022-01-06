Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF4486A42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbiAFTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:03:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46990 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiAFTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:03:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85149B819B4;
        Thu,  6 Jan 2022 19:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B28AC36AEB;
        Thu,  6 Jan 2022 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641495829;
        bh=caIq06vVwJ4QO86Oh793UHoQ2HsFfrAToS2F6AVTWXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fqx14Wn8tzPg6MwqzkQgjq2PzXCNNibNi3DHvECLHhwn6RaTQexfFWI+mpTU8PVsH
         PCItXLJoVpoqQBofotHwOj8Dhae/7HU3k06BAzk91Pv7FpeeYb95WAU7SNrLt7przs
         qQfK8yeDXLulyb4qz9OC8TxcgZR3UBRryweLRRt3EKNbHsl3KBiKtzZ0RLbeGWDu8G
         qG763iK2Tr7bpisUduENY0PX+clUlVj7ylMEtxbLVROVOHQWHLYFkMJ6mls4y/XoFz
         jUq61QM4o277qrMdif1efsnq51L0XltDuYC5BcztmVmFWY6hLWd3Jh74VMK/+pBYIw
         dsYXyJ+xQo+SA==
Date:   Thu, 6 Jan 2022 21:03:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: remove redundant assignment to variable ret
Message-ID: <Ydc9EHZAqSgS4hol@iki.fi>
References: <20211230134557.83633-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230134557.83633-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 01:45:57PM +0000, Colin Ian King wrote:
> Variable ret is being assigned a value that is never read. If the
> for-loop is entered then ret is immediately re-assigned a new
> value. If the for-loop is not executed ret is never read. The
> assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR,
Jarkko

> ---
>  lib/asn1_encoder.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> index 27bbe891714f..0fd3c454a468 100644
> --- a/lib/asn1_encoder.c
> +++ b/lib/asn1_encoder.c
> @@ -164,8 +164,6 @@ asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
>  
>  	data_len -= 3;
>  
> -	ret = 0;
> -
>  	for (i = 2; i < oid_len; i++) {
>  		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
>  		if (ret < 0)
> -- 
> 2.33.1
> 
