Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B16471421
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhLKOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 09:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbhLKOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 09:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639231519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKf/L2gDTAfMvTP+/UBDkgpyq8OohMS2d9tzBGN6AKo=;
        b=OHBGDrcsex39q4SYsAnRIWWReCH5v3U/ANraaSYMxtX40KJuPgdNNIBq+sFXaPweFmVwfJ
        8dY2Sj8T1pmqB0+/0HiSI01L76nbPMsWQL31eST9/l6egdHM9DeeRGK4GxaavcbJp79R/2
        f1eg/sVJmG62MaJ+9KsIN05S+SBx5v0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-U5YVaFB0Op6q39PFTj7x4g-1; Sat, 11 Dec 2021 09:05:17 -0500
X-MC-Unique: U5YVaFB0Op6q39PFTj7x4g-1
Received: by mail-oi1-f199.google.com with SMTP id k124-20020acaba82000000b002a7401b177cso8083069oif.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AKf/L2gDTAfMvTP+/UBDkgpyq8OohMS2d9tzBGN6AKo=;
        b=49m1I68Emi91anEsPzMx7ezwhLgX0jocS2+WmespV5XaKBiM7Yy3Lnidrd+PqbmKWD
         LBxIWU4TlBuyNXnSgJB9YvpnfFiOTK9tpypue8sotwWiEG5WCZkqm2MWRr1pe+qQ1Daz
         /DT6UVrQWxxx03Wu0pgLKnJgTj/48Msl9zvbVcPPLjIm5hsWNrY3Ob62MqmNDWaWOz0M
         hvbQXCt4fzUZjUeuf68jtyvCvyuQfJQ752Rlirx/ImkKwaR2cS6o6tOmlBZqRhaS+y9M
         hJDLKhvia2wkHP+PrnT0/iq3J0PQB46fNw/IbZvcRHrItPw5bMvUE6yuSKByEWX+gHD9
         38Zg==
X-Gm-Message-State: AOAM5326CJi14Vzjfj8MMEBGaeobZPQvf7thmMdVb4P4oJzmTg0bo3BS
        ImPo1s2xCjmtCogKVk4ZXjP3JxgoAS9SxftB43AspWci7ATADSX8WPHQh1FMRZ6dHGXmkxjgf5I
        nVs3ZlEqy0LX9blBZMfaXh7dYi5fcPoTRLd8vUpWQEtWtP28b6RWalIEiFCZ0A3UhrON7OGo=
X-Received: by 2002:a05:6830:439f:: with SMTP id s31mr15827688otv.272.1639231516847;
        Sat, 11 Dec 2021 06:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuSXd4gwU+8NKkxyrWrzi0Hmq4atZk5+FQbBVaF/rv+mAOEkuPJ2yob/NojBdQUz2546xwCA==
X-Received: by 2002:a05:6830:439f:: with SMTP id s31mr15827658otv.272.1639231516486;
        Sat, 11 Dec 2021 06:05:16 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bj8sm1531957oib.51.2021.12.11.06.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:05:15 -0800 (PST)
Subject: Re: [PATCH] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211211134332.21679-1-linmq006@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
Date:   Sat, 11 Dec 2021 06:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211211134332.21679-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/21 5:43 AM, Miaoqian Lin wrote:
> The stratix10_svc_allocate_memory function does not return NULL. It
> returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/fpga/stratix10-soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 047fd7f23706..2d2687a90ae6 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -213,7 +213,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	/* Allocate buffers from the service layer's pool. */
>   	for (i = 0; i < NUM_SVC_BUFS; i++) {
>   		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> -		if (!kbuf) {
> +		if (IS_ERR(kbuf)) {
>   			s10_free_buffers(mgr);
>   			ret = -ENOMEM;

This should also change to

ret = PTR_ERR(kbuf)

Tom

>   			goto init_done;

