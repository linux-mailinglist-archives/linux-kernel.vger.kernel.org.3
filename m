Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79CA4C1974
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiBWRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBWRH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:07:26 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0931D4;
        Wed, 23 Feb 2022 09:06:57 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id E28681C000B;
        Wed, 23 Feb 2022 17:06:54 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:06:53 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 05/13] media: atmel: atmel-sama5d2-isc: fix wrong mask
 in YUYV format check
Message-ID: <20220223170653.z5frqap4wsvi3lsu@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-6-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-6-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:37PM +0200, Eugen Hristev wrote:
> While this does not happen in production, this check should be done
> versus the mask, as checking with the YCYC value may not include
> some bits that may be set.
> Is it correct and safe to check the whole mask.
>
> Fixes: 123aaf816b95 ("media: atmel: atmel-sama5d2-isc: fix YUYV format")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

I trust this
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j
> ---
>  drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> index c244682ea22f..025c3e8a7e95 100644
> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> @@ -291,7 +291,7 @@ static void isc_sama5d2_config_rlp(struct isc_device *isc)
>  	 * Thus, if the YCYC mode is selected, replace it with the
>  	 * sama5d2-compliant mode which is YYCC .
>  	 */
> -	if ((rlp_mode & ISC_RLP_CFG_MODE_YCYC) == ISC_RLP_CFG_MODE_YCYC) {
> +	if ((rlp_mode & ISC_RLP_CFG_MODE_MASK) == ISC_RLP_CFG_MODE_YCYC) {
>  		rlp_mode &= ~ISC_RLP_CFG_MODE_MASK;
>  		rlp_mode |= ISC_RLP_CFG_MODE_YYCC;
>  	}
> --
> 2.25.1
>
