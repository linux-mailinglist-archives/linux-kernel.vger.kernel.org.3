Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6758266E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiG0M2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiG0M2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01C1839B;
        Wed, 27 Jul 2022 05:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FB961176;
        Wed, 27 Jul 2022 12:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104A3C433C1;
        Wed, 27 Jul 2022 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658924927;
        bh=RJaAfA80CUIV6HwHoyt8PSV+4bUhWByc9hyFUfFCoNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UnxyyQUfVuoTePrKEZxsFizAX9yfr4F2L77siXpAN8nEviN5y9wAxn21A2GMt7GR
         g8YQ1S9RFzc1mAWRZqopgX2vmhxa+5spI/Q4vPxsUklBd5P7Q9r9wibuhjlntqImVc
         eCDjHMRYzdaGfHav/lSWZOGTdz8nxj8mntvIApds=
Date:   Wed, 27 Jul 2022 14:28:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: anx7411: fix passing a valid pointer to
 'PTR_ERR'
Message-ID: <YuEvdKTVNwY3eX4p@kroah.com>
References: <20220722081836.3380885-1-xji@analogixsemi.com>
 <20220722081836.3380885-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722081836.3380885-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:18:35PM +0800, Xin Ji wrote:
> Fix anx7411_typec_register_altmode() warn: passing a valid pointer to
> 'PTR_ERR'.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/usb/typec/anx7411.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 7b45d7440a9d..dc86b6704cbd 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -550,6 +550,7 @@ static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
>  {
>  	struct device *dev = &ctx->spi_client->dev;
>  	struct typec_altmode_desc desc;
> +	struct typec_altmode *alt;
>  	int i;
>  
>  	desc.svid = svid;
> @@ -566,14 +567,14 @@ static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
>  		return -ENOMEM;
>  	}
>  
> -	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
> -							     &desc);
> -	if (IS_ERR(ctx->typec.amode[i])) {
> +	alt = typec_partner_register_altmode(ctx->typec.partner, &desc);
> +	if (IS_ERR(alt)) {
>  		dev_err(dev, "failed to register altmode\n");
> -		ctx->typec.amode[i] = NULL;
> -		return PTR_ERR(ctx->typec.amode);
> +		return PTR_ERR(alt);
>  	}
>  
> +	ctx->typec.amode[i] = alt;
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

Does not apply to my tree :(
