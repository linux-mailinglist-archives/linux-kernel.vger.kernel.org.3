Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA744F1701
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiDDOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377491AbiDDOcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:32:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D132ECB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0ABFB8172B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C47C2BBE4;
        Mon,  4 Apr 2022 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649082620;
        bh=IcyeBgAAHvxYwTuDheUzskHb8csMKwWLHu5b7gmdrPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsTHmvgfz6NoHTcPiSkjvpj1w8YRqu+NyMyFORt01iwcWnSjP52tpYcBJcznduvEx
         SCTXFaChc89lRt6EoZJAaQ1apaHvnHqX6QlieQR3l1CfIh9jMs5yjNfGR7DHU/p17s
         sk+WrsCppy8BXrs0P4eYX/lbJc8C8viaEHTnVARs=
Date:   Mon, 4 Apr 2022 16:30:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8712: change the type of
 _r8712_init_recv_priv()
Message-ID: <YksA+X5ip+sdrDjV@kroah.com>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:06:35AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> There is a memory allocation in _r8712_init_recv_priv(). Since the
> original type of this function is void, now it is changed to int to
> make the error of allocation failures propagate to its caller easily.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/rtl8712/recv_osdep.h   | 2 +-
>  drivers/staging/rtl8712/rtl871x_recv.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
> index d8c1fa7..f5b97c5 100644
> --- a/drivers/staging/rtl8712/recv_osdep.h
> +++ b/drivers/staging/rtl8712/recv_osdep.h
> @@ -18,7 +18,7 @@
>  #include "drv_types.h"
>  #include <linux/skbuff.h>
>  
> -void _r8712_init_recv_priv(struct recv_priv *precvpriv,
> +int _r8712_init_recv_priv(struct recv_priv *precvpriv,
>  			   struct _adapter *padapter);
>  void _r8712_free_recv_priv(struct recv_priv *precvpriv);
>  void r8712_recv_entry(union recv_frame *precv_frame);
> diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
> index c23f6b3..dd8cb07 100644
> --- a/drivers/staging/rtl8712/rtl871x_recv.c
> +++ b/drivers/staging/rtl8712/rtl871x_recv.c
> @@ -44,7 +44,7 @@ void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
>  	_init_queue(&psta_recvpriv->defrag_q);
>  }
>  
> -void _r8712_init_recv_priv(struct recv_priv *precvpriv,
> +int _r8712_init_recv_priv(struct recv_priv *precvpriv,
>  			   struct _adapter *padapter)
>  {
>  	sint i;
> @@ -60,7 +60,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
>  				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
>  				GFP_ATOMIC);
>  	if (!precvpriv->pallocated_frame_buf)
> -		return;
> +		return -ENOMEM;
>  	kmemleak_not_leak(precvpriv->pallocated_frame_buf);

Why are you still telling kmemleak that this was not a leak if you
properly handle it?

thanks,

greg k-h
