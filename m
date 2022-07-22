Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511757D9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiGVEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:48:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF693638;
        Thu, 21 Jul 2022 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9kQnWAcSF9Yzs1kL6Yq0lTdcDF4ILi/uKX3XcZK1Lc=; b=DKol8CNimLCjlsLlkrpqMcvesu
        UwIgNox3kdcPY+7ays69SEIGRmBcI5N2qad6gRCnCB+VZrPiFBKTQRXPkt1xfl5ZI7lMp1xZNjmEM
        m/gqB9HHcxf+LUt6OZWGePzTlOZ3+CCbrG8ngtLNoGAnlipFmod0wmqGGy3IoCl41V6VFiDJdhXk0
        18ZUDNQwSTwqkJ48xsApRFd++ILTC4kny7GXZ5FJCr9waGOGH0xyYsPdoVPzeNCh4mmqQmr539zsN
        h+LY74d9D+IDr2SijGiBZH3bb4Yp3qajQ08liXyXNP113h8wtsPiomJJYDWqq3aPCOOPlb8JB7imj
        ZD5LDKfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEkal-00HYNi-8O; Fri, 22 Jul 2022 04:48:47 +0000
Date:   Thu, 21 Jul 2022 21:48:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-auth: Fix off by one checks
Message-ID: <YtosL0gGow56siA5@infradead.org>
References: <YtU/bFMYRCrx6tgp@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes, can you review these please?

On Mon, Jul 18, 2022 at 02:09:32PM +0300, Dan Carpenter wrote:
> The > ARRAY_SIZE() checks need to be >= ARRAY_SIZE() to prevent reading
> one element beyond the end of the arrays.
> 
> Fixes: a476416bb57b ("nvme: implement In-Band authentication")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The MAINTAINERS file needs to be updated for this new code.
> 
>  drivers/nvme/common/auth.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 0c86ebce59d2..bfb16fec0aed 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -55,7 +55,7 @@ static struct nvme_auth_dhgroup_map {
>  
>  const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
>  {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>  	    !dhgroup_map[dhgroup_id].name ||
>  	    !strlen(dhgroup_map[dhgroup_id].name))
>  		return NULL;
> @@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
>  
>  const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
>  {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>  	    !dhgroup_map[dhgroup_id].kpp ||
>  	    !strlen(dhgroup_map[dhgroup_id].kpp))
>  		return NULL;
> @@ -113,7 +113,7 @@ static struct nvme_dhchap_hash_map {
>  
>  const char *nvme_auth_hmac_name(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].hmac ||
>  	    !strlen(hash_map[hmac_id].hmac))
>  		return NULL;
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
>  
>  const char *nvme_auth_digest_name(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].digest ||
>  	    !strlen(hash_map[hmac_id].digest))
>  		return NULL;
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
>  
>  size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].hmac ||
>  	    !strlen(hash_map[hmac_id].hmac))
>  		return 0;
> -- 
> 2.35.1
> 
> 
---end quoted text---
