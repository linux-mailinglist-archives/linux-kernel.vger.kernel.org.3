Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C84F16FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbiDDObv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377434AbiDDObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:31:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5522B3B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EEA4B81722
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DEBC2BBE4;
        Mon,  4 Apr 2022 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649082576;
        bh=aT8e3BlBfNipB4O093d7n5Op1VJKa4RJFODCpYYoFsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hx6l2VVUpYnQOFTg6KmsjgZgEOjYARG7zUVdOY+6HXouOH7JSXoeRR3ZCcPm4fI1A
         gVmDDfxhmRkKO8FzUeus9PzqkUQFSbMftgH1JrPxn9zGjBssGxkSIULTsHybgnfqxA
         kg0HAuuvy56dEjOdoGDw33MvkEFbz891ehoXLHlw=
Date:   Mon, 4 Apr 2022 16:29:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8712: add two validation check in
 r8712_init_drv_sw()
Message-ID: <YksAzXHif7Usdfv9@kroah.com>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
 <tencent_3096E1464A73FF232014CC40B9001C551408@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3096E1464A73FF232014CC40B9001C551408@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:07:45AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> _r8712_init_xmit_priv() or _r8712_init_recv_priv() returns -ENOMEM
> when some allocations inside it failed.
> So it is better to check the return status of them.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/rtl8712/os_intfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index 9502f6a..163baaa 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -308,8 +308,12 @@ int r8712_init_drv_sw(struct _adapter *padapter)
>  	ret = r8712_init_mlme_priv(padapter);
>  	if (ret)
>  		return ret;
> -	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
> -	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
> +	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
> +	if (ret)
> +		return ret;
> +	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
> +	if (ret)
> +		return ret;

You just leaked memory :(

please please please test these types of "fix up error handling"
changes, as there are lots and lots of ways to get these wrong.

If you can not test them, provide some sort of proof that the change is
correct please.

thanks,

greg k-h
