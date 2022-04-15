Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50CF5025A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbiDOGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC5AAC84;
        Thu, 14 Apr 2022 23:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D9361F1B;
        Fri, 15 Apr 2022 06:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57619C385A6;
        Fri, 15 Apr 2022 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650004415;
        bh=fOgAfgrKdUuMZkHmUofQmp1biP5AT8t3U9G32nyK0xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERCXPrpaVVW32BZP7aoI3Sng4UJy35O7LuK7xhegvTKBdERLeT4PrSQnDfOiPe7Mi
         a4dtoFLa2TQ6fFOat59dlUragtmaQvo5z7maA3JhjDusKVfBaspWj5NRD6WkOHdvJ7
         N3SA2VE7wUaoGlDo9QYjUgUp6PC4h2l+b1AF71DU=
Date:   Fri, 15 Apr 2022 08:33:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/20] tty: n_gsm: fix implicit CR bit encoding in
 address field
Message-ID: <YlkRvMhDfwgNZptV@kroah.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
 <20220414094225.4527-18-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414094225.4527-18-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:42:23AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
> address field within the frame header. It is made up of the DLCI address,
> command/response (CR) bit and EA bit.
> Use the predefined CR value instead of a plain 2 in alignment to the
> remaining code and to make the encoding obvious.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org

This does not change any functionality, so how is this a "fix" or
relevant for stable backporting?


> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 1e135a71860f..ecd2ecc61b14 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -754,7 +754,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>  
>  	*--dp = msg->ctrl;
>  	if (gsm->initiator)
> -		*--dp = (msg->addr << 2) | 2 | EA;
> +		*--dp = (msg->addr << 2) | CR | EA;

This is a nice cleanup only.

thanks,

greg k-h
