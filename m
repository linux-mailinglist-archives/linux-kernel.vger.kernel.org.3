Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6714B9C92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiBQJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:57:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiBQJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:57:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD2DF01;
        Thu, 17 Feb 2022 01:56:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D0761D48;
        Thu, 17 Feb 2022 09:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F001EC340E8;
        Thu, 17 Feb 2022 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645091806;
        bh=Y6DSt3eMZhMvFqHFms72snpahxDJvYRjgVffayLpLvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPfq2q1N0wBrSByJLPrhR7fIJOiiav9xPzbH7NlKbtFDYZokVO8TNX9YDxOe4WiA2
         v/iX5ew/3wQO1SGhiq+95GXh2xfV1Y0qHioiLNZXD51iOInWNTjlsxL9JR0xU5Fa1M
         aO7sxKJ2R3dLW0w8vS63wl0XPS3R9giII67JqyvM=
Date:   Thu, 17 Feb 2022 10:56:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     daniel.starke@siemens.com
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Message-ID: <Yg4b2hks0/LglHK5@kroah.com>
References: <20220217080555.5387-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217080555.5387-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:05:49AM -0800, daniel.starke@siemens.com wrote:
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.4.6.3.7 describes the encoding of the
> control signal octet used by the MSC (modem status command). The same
> encoding is also used in convergence layer type 2 as described in chapter
> 5.5.2. Table 7 and 24 both require the DV (data valid) bit to be set 1 for
> outgoing control signal octets sent by the DTE (data terminal equipment),
> i.e. for the initiator side.
> Currently, the DV bit is only set if CD (carrier detect) is on, regardless
> of the side.
> 
> This patch fixes this behavior by setting the DV bit on the initiator side
> unconditionally.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 0b1808e3a912..e199315a158e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -439,7 +439,7 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
>  		modembits |= MDM_RTR;
>  	if (dlci->modem_tx & TIOCM_RI)
>  		modembits |= MDM_IC;
> -	if (dlci->modem_tx & TIOCM_CD)
> +	if (dlci->modem_tx & TIOCM_CD || dlci->gsm->initiator)
>  		modembits |= MDM_DV;
>  	return modembits;
>  }
> -- 
> 2.25.1
> 

All of these are patch 1/1, which is odd :(

Please renumber them properly and resend.

thanks,

greg k-h
