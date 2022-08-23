Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7459E809
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiHWQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiHWQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839E12A1C5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YP+712EO8yi9wgRvfODGAmrYDSOcaT+a9BpRVZKH65c=;
        b=IP/hva4bjsDwy4zZfTuLEK77LSYMeepNcunhAmqHsmlr4OOKgr4r7kugY2t0XLKRkRXRH0
        NZSDJji7I06vHUJrj5UG8vnitj/rqHN+41VsdRBkqq4nHSVywvtcBNagWevr0ixL/gLP/4
        u2OSf+FtxW6EhKWWLu8WUHfGJXKkiYQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-5K6J7Ea4MT640Z4-IY8NOA-1; Tue, 23 Aug 2022 09:18:37 -0400
X-MC-Unique: 5K6J7Ea4MT640Z4-IY8NOA-1
Received: by mail-qt1-f198.google.com with SMTP id h13-20020ac87d4d000000b00342f6c363afso10495345qtb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=YP+712EO8yi9wgRvfODGAmrYDSOcaT+a9BpRVZKH65c=;
        b=b8rUrm7xIkqJizbaQ1CrS72wBZ2gyUj6h80aGNaqaYmmlncugKuhbCHuuPdhJbcgUE
         BzItCmofgvTsq53V1SAv8VpKObKD8aCwMiXPTgiRXl2NoxydEyMNJiKd1kExgKAMKWYM
         eSopXIs3WXiUgxNSWHIMNIr/EzDroO8dwADNVndlqojuH3V14guQBX4Ga/y76X7EDV2J
         sezg8KWUa1AbWOpinIg8VaCtcDBWPicThcCh33DYu60Cpfx6P0qsdKFKiuF5kEw7ZBxm
         NM3FGbmnmLWTbfFJhPPZ0vXZ9BsPIcLXOviOs7BOepafKWMEg/nNsIUic390k/jjIpFy
         4nbQ==
X-Gm-Message-State: ACgBeo2Dc/Rc9JfDaaRuFgvUHSddldXJRtQYCJx+BSITtidfBZBsOXxr
        J2XnMhEIpF9AADWejo5iWhq5eGfUI+N4xNZX5K9QxK0DGeC0ha1TxrQXAlEdKxRj/gHpUy1Gf7+
        2arTyaviu3VWiSWOOeORlCR7c
X-Received: by 2002:ac8:5a14:0:b0:344:5660:6530 with SMTP id n20-20020ac85a14000000b0034456606530mr19425725qta.12.1661260716089;
        Tue, 23 Aug 2022 06:18:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6hwSQGeIZ9queTWLty8Bh40ABYaAKoYdFJ7Gn3EzseAexOMiQQFmESLu7m7qzBuysV+lq6xQ==
X-Received: by 2002:ac8:5a14:0:b0:344:5660:6530 with SMTP id n20-20020ac85a14000000b0034456606530mr19425692qta.12.1661260715820;
        Tue, 23 Aug 2022 06:18:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006bb53282393sm13806625qkp.81.2022.08.23.06.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:18:35 -0700 (PDT)
Message-ID: <efd1c89e3bbd7364ef381292c9ceff430cbeda8d.camel@redhat.com>
Subject: Re: [PATCH 2/4] net: mediatek: sgmii: ensure the SGMII PHY is
 powered down on configuration
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alexander Couzens <lynxis@fe80.eu>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Golle <daniel@makrotopia.org>
Date:   Tue, 23 Aug 2022 15:18:31 +0200
In-Reply-To: <20220820224538.59489-3-lynxis@fe80.eu>
References: <20220820224538.59489-1-lynxis@fe80.eu>
         <20220820224538.59489-3-lynxis@fe80.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-21 at 00:45 +0200, Alexander Couzens wrote:
> The code expect the PHY to be in power down which is only true after reset.
> Allow changes of the SGMII parameters more than once.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> ---
>  drivers/net/ethernet/mediatek/mtk_sgmii.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_sgmii.c b/drivers/net/ethernet/mediatek/mtk_sgmii.c
> index a01bb20ea957..782812434367 100644
> --- a/drivers/net/ethernet/mediatek/mtk_sgmii.c
> +++ b/drivers/net/ethernet/mediatek/mtk_sgmii.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/phylink.h>
> @@ -24,6 +25,9 @@ static int mtk_pcs_setup_mode_an(struct mtk_pcs *mpcs)
>  {
>  	unsigned int val;
>  
> +	/* PHYA power down */
> +	regmap_write(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, SGMII_PHYA_PWD);

in mtk_pcs_setup_mode_an() and in mtk_pcs_setup_mode_force() the code
carefully flips only the SGMII_PHYA_PWD bit. Is it safe to overwrite
the full register contents?

> +
>  	/* Setup the link timer and QPHY power up inside SGMIISYS */
>  	regmap_write(mpcs->regmap, SGMSYS_PCS_LINK_TIMER,
>  		     SGMII_LINK_TIMER_DEFAULT);
> @@ -36,6 +40,10 @@ static int mtk_pcs_setup_mode_an(struct mtk_pcs *mpcs)
>  	val |= SGMII_AN_RESTART;
>  	regmap_write(mpcs->regmap, SGMSYS_PCS_CONTROL_1, val);
>  
> +	/* Release PHYA power down state
> +	 * unknown how much the QPHY needs but it is racy without a sleep
> +	 */
> +	usleep_range(50, 100);

Ouch, this looks fragile, without any related H/W specification. 

>  	regmap_write(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, 0);
>  
>  	return 0;
> @@ -50,6 +58,9 @@ static int mtk_pcs_setup_mode_force(struct mtk_pcs *mpcs,
>  {
>  	unsigned int val;
>  
> +	/* PHYA power down */
> +	regmap_write(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, SGMII_PHYA_PWD);
> +
>  	regmap_read(mpcs->regmap, mpcs->ana_rgc3, &val);
>  	val &= ~RG_PHY_SPEED_MASK;
>  	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> @@ -67,7 +78,10 @@ static int mtk_pcs_setup_mode_force(struct mtk_pcs *mpcs,
>  	val |= SGMII_SPEED_1000;
>  	regmap_write(mpcs->regmap, SGMSYS_SGMII_MODE, val);
>  
> -	/* Release PHYA power down state */
> +	/* Release PHYA power down state
> +	 * unknown how much the QPHY needs but it is racy without a sleep
> +	 */
> +	usleep_range(50, 100);

Same here.

Thanks!

Paolo

