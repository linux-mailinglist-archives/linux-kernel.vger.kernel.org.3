Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DF56D31B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGKCxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKCxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A9183A8;
        Sun, 10 Jul 2022 19:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F36E8610A5;
        Mon, 11 Jul 2022 02:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07264C3411E;
        Mon, 11 Jul 2022 02:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657507983;
        bh=PCWoXAlR4NxLTHXg0LrKWX+ks7as6mmpDn6fX/LsNHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hywFkzoAIkBPJDBfXVkvAObcMXd2FqviNCH/dD4P34ClqDPjfWp2U3b4k6HdRaw3P
         Xbc/i/wrzaYBnlKavv9BCRAnZ1NganrvYxGA+mkgP3Ewy6L096MKjQWhO/QLEK8jxn
         4Z/p3VldcMJSjcXWd3LrTbpyop020gD5uIlSSXXnr91QQeU11Y0BIZqIjDEmtcrDKO
         8j9ule6Umk3yel3Le4oYzW6IRgEMq5PZB8NtR9uW8wOyacVgXD4lykuis40gHbaQ6+
         Yb8vX0SzNMhb71rn5VTD3UQsnx5XcexEbDSefXz4DwKe5FYa3l0UT7cYpO6c1m9m4R
         wCokhaeSl4Mgg==
Date:   Mon, 11 Jul 2022 05:52:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] keys/keyring: Fix typo in string
Message-ID: <YsuQihEKR8DC+Pnm@kernel.org>
References: <20220704025610.3834-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704025610.3834-1-zeming@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:56:10AM +0800, Li zeming wrote:
> Remove the repeated ',' from string
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  security/keys/keyring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5e6a90760753..c6c47ca9b57d 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -460,7 +460,7 @@ static int keyring_read_iterator(const void *object, void *data)
>  	struct keyring_read_iterator_context *ctx = data;
>  	const struct key *key = keyring_ptr_to_key(object);
>  
> -	kenter("{%s,%d},,{%zu/%zu}",
> +	kenter("{%s,%d},{%zu/%zu}",
>  	       key->type->name, key->serial, ctx->count, ctx->buflen);
>  
>  	if (ctx->count >= ctx->buflen)
> @@ -484,7 +484,7 @@ static long keyring_read(const struct key *keyring,
>  	struct keyring_read_iterator_context ctx;
>  	long ret;
>  
> -	kenter("{%d},,%zu", key_serial(keyring), buflen);
> +	kenter("{%d},%zu", key_serial(keyring), buflen);
>  
>  	if (buflen & (sizeof(key_serial_t) - 1))
>  		return -EINVAL;
> -- 
> 2.18.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
