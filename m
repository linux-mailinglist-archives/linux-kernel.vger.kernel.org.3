Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA64E9076
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiC1Iua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiC1Iu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024447066
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276D360BA4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C539C340ED;
        Mon, 28 Mar 2022 08:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648457328;
        bh=/4P1QfEXx+SD//zNcIF3is1gtUA9WvLmCRu3ZiwpImw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZXuWiX+XBnsODPJEifNUSRoLRiF2ocznQyjwsPL8f8hIjcfdn9TXedvbFpT6mwMv
         SrdM6eW6UgOeZY5WbzlT5lbe8UQdQMgKB+18DxeqzaRzAHOcInJy5nMlIeL7kS2CBq
         L7CxBpjlaNlV8D2M5PFx+6sW9zsvaIyrqLWffE5E=
Date:   Mon, 28 Mar 2022 10:48:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: r8188eu: Directly return _FAIL instead of
 using local ret variable
Message-ID: <YkF2bU7lAn91n9Ch@kroah.com>
References: <1648457022-4076-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648457022-4076-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 04:43:42PM +0800, Haowen Bai wrote:
> fixes coccinelle warning:
> ./drivers/staging/r8188eu/core/rtw_mlme_ext.c:1518:14-17: Unneeded variable: "ret".
>  Return "_FAIL" on line 1549
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: split into two patches.
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 10d5f12..931e6f2 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -1515,7 +1515,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
>  
>  unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
>  {
> -	unsigned int ret = _FAIL;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	u8 *pframe = precv_frame->rx_data;
> @@ -1546,7 +1545,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
>  	}
>  
>  exit:
> -	return ret;
> +	return _FAIL;

Something is wrong here, why would this function always fail?  Are you
sure that this is working properly?

thanks,

greg k-h
