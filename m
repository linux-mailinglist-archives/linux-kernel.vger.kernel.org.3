Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6ED4E906E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiC1Itc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiC1Ita (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:49:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BA53B56
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4EF6B80FBC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C96C340ED;
        Mon, 28 Mar 2022 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648457267;
        bh=aCy1183IFeSJEQ/PvYRHTMEfAcgEEitlYrwCkkKgiSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MX3gCVLJyItskiLMyOpDpXgDdaC2i9inH9p+RNcDTUqYTphF66BnOK1B/otYzGxUK
         2TraMoHCww74EnS9ZquMBxPHBsFGqCZIPgfSVK3kKVklcTZkLw+ATny7mKTujwe+nX
         6qSaISaGLQyfGIE+sdXdVYkRjXMMKF2Y+tOWhmbE=
Date:   Mon, 28 Mar 2022 10:47:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
Message-ID: <YkF2MRdxlUWow0UC@kroah.com>
References: <1648457028-4226-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648457028-4226-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 04:43:48PM +0800, Haowen Bai wrote:
> fixes coccinelle warning:
> ./drivers/staging/r8188eu/core/rtw_mlme_ext.c:357:5-8: Unneeded variable: "res".
>  Return "_SUCCESS" on line 380
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: split into two patches.
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 931e6f2..4b7b0ee 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -354,7 +354,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
>  
>  int	init_mlme_ext_priv(struct adapter *padapter)
>  {
> -	int	res = _SUCCESS;
>  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> @@ -377,7 +376,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
>  
>  	pmlmeext->active_keep_alive_check = true;
>  
> -	return res;
> +	return _SUCCESS;

If a function can only ever succeed, why return anything?  Please make
this a function return void.

thanks,

greg k-h
