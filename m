Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1A4AFD0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiBITOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:14:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiBITOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:14:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104EC0DE7C7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:14:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i34so6149848lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZqCsdtECQHXTZr8IpF8umy+6Cux+k4bWSLZZ1TOrY2Q=;
        b=IKDerEohVoRWS2zeh1Y+i/Y+oGfN/IIFKarRBaZ8JIubn4k6oVNLzPazkiW0fwezsf
         YxdtZPi0pw6Ij6mW7ItW3Vu5BrLzjD+LRKptIqk7vpZCndqBNDg4TNKyAxLECgzKxWh+
         +EHkydPog7Qvffd6Q0vrtErsXbnjvk60VQKwnagxLJoXh0SHAw5lbolnlCfSliKBdCwJ
         j8lF22zTpYNrWaDlsk0VQiQlgzS35UoMx9OeFTL2Esv4YFAiXkfnnpGzIVZ+yJMrT75i
         TzrEaR1OlxYBKfqDgtHCj+/6OzYw8fAuAxpstNl2j2awsd7nHBl/HOHk3cA3onHVIDZi
         BLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZqCsdtECQHXTZr8IpF8umy+6Cux+k4bWSLZZ1TOrY2Q=;
        b=1Wj4KAMcRDYjZY2a8WHrl0zT7V1ah1UB4K+gx3IrYBWcJmA8I0uzuFxF6nEkXbFzvh
         3XkFl3tsVO+gicbXgHsyrTQWeBOWYfBaFpmHEC6/cUTI0Qu/+e2IEDAF63WOcOUazABu
         2d/Zw3SH2ezntmy9OYppuzGT54RAriNoXmCi85sHx/8J8p8fG5fGEq/3chYz8xcTsgvm
         DopL/u6wKNf4MGCDuoc/d39b2m37JwIEn3Qyw/JqU8EpAWsE+NcmIJiiiSCx+62dixRL
         inRLdRBD5Y418dep06DWbUY55r9VeNcJfwsm7q+YHWOI/ww4fxpbDDBKMDh9x1KzR0Js
         pCxQ==
X-Gm-Message-State: AOAM5335qVgHe88SO0sZuCwoU45b5GIzkb5gnEOK7B/gOWdwxxSffMAb
        WpYJC+UiTCBvxq6Kw99dQRSPJ4we6Dm98Q==
X-Google-Smtp-Source: ABdhPJy2qb10/B3KYND0/XbklU+DF93Riccx+K8hpY8eKGvHyAvHrLZ+V/+7irT5D4ivxTQ3OQ448Q==
X-Received: by 2002:a05:6512:3c96:: with SMTP id h22mr2539605lfv.262.1644434024921;
        Wed, 09 Feb 2022 11:13:44 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.154])
        by smtp.gmail.com with ESMTPSA id bt24sm285368lfb.246.2022.02.09.11.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 11:13:44 -0800 (PST)
Message-ID: <a67d6a88-491c-a393-6157-7de31375325d@gmail.com>
Date:   Wed, 9 Feb 2022 22:13:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] staging: r8188eu: keep the success path and error path
 separate
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220209190752.7232-1-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220209190752.7232-1-makvihas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vihas,

On 2/9/22 22:07, Vihas Makwana wrote:
> Keep the success path and error path separate in rtw_usb_if1_init() and
> drop the "status" variable.
> Also, remove do-nothing gotos.
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---

Looks good, thanks

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>

> v1->v2:
>      Just `return NULL` instead of `padapter=NULL/return padapter`
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 30 +++++++++--------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 10c33e2ae..668e79a3c 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -336,13 +336,13 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   {
>   	struct adapter *padapter = NULL;
>   	struct net_device *pnetdev = NULL;
> -	int status = _FAIL;
>   	struct io_priv *piopriv;
>   	struct intf_hdl *pintf;
>   
>   	padapter = vzalloc(sizeof(*padapter));
>   	if (!padapter)
> -		goto exit;
> +		return NULL;
> +
>   	padapter->dvobj = dvobj;
>   	dvobj->if1 = padapter;
>   
> @@ -421,26 +421,20 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   		, padapter->hw_init_completed
>   	);
>   
> -	status = _SUCCESS;
> +	return padapter;
>   
>   free_drv_sw:
> -	if (status != _SUCCESS) {
> -		rtw_cancel_all_timer(padapter);
> -		rtw_free_drv_sw(padapter);
> -	}
> +	rtw_cancel_all_timer(padapter);
> +	rtw_free_drv_sw(padapter);
>   handle_dualmac:
> -	if (status != _SUCCESS)
> -		rtw_handle_dualmac(padapter, 0);
> +	rtw_handle_dualmac(padapter, 0);
>   free_adapter:
> -	if (status != _SUCCESS) {
> -		if (pnetdev)
> -			rtw_free_netdev(pnetdev);
> -		else if (padapter)
> -			vfree(padapter);
> -		padapter = NULL;
> -	}
> -exit:
> -	return padapter;
> +	if (pnetdev)
> +		rtw_free_netdev(pnetdev);
> +	else if (padapter)
> +		vfree(padapter);
> +
> +	return NULL;
>   }
>   
>   static void rtw_usb_if1_deinit(struct adapter *if1)


With regards,
Pavel Skripkin
