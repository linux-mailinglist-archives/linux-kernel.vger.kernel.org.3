Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D455DBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiF0JHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiF0JG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AAD63A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3FA61170
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D469C341C8;
        Mon, 27 Jun 2022 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656320814;
        bh=1gnVoaGuW6a9eUN1HMGFl1vsiRYSGtGUhkQ+scokzb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGoQlVBNwVHtMmTI89fC8rV1T9cwXGPJ/P/klazH38euiLYM6z22qK3/OVbVxDAqp
         Y26odl5Rm8y3O1pS8bshbWe9p13b5I88nfxKMEtD+C5Ueb9x7XKGd8dUDSh2nwoM/G
         vBlRrVOHWqKTlqWdLvXJ9PWX9OuF7mGutuuIQkd4=
Date:   Mon, 27 Jun 2022 11:06:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: drop return value from
 receive_disconnect
Message-ID: <YrlzLEf1atin6gBd@kroah.com>
References: <20220626180734.287137-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626180734.287137-1-martin@kaiser.cx>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 08:07:34PM +0200, Martin Kaiser wrote:
> The receive_disconnect function always returns _SUCCESS. None of the
> callers checks the return value. We can remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 5 ++---
>  drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index cce0575e93b7..fc6e06d7b5ca 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -6191,14 +6191,14 @@ void start_clnt_assoc(struct adapter *padapter)
>  	set_link_timer(pmlmeext, REASSOC_TO);
>  }
>  
> -unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
> +void receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
>  {
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  
>  	/* check A3 */
>  	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
> -		return _SUCCESS;
> +		return;

Shouldn't this check return an error instead of success?  If not, what
exactly is this checking this for?

thanks,

greg k-h
