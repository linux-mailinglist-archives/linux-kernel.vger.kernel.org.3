Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5550CE16
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiDWXuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 19:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiDWXui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 19:50:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29622BF1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 16:47:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so22925706ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4As9YzHRBrrZ1C0yo3XEDo6BKzSgfNCpKjF9OwCZh0=;
        b=iM2mIyLEiD1wFXjGNEI3QW7B+C7ZMY0mpFrDiymtfImyzMtP79nNX/vbweJ1UVr/Jz
         YQUAlLR5mb6a1nMgQFDtqYobanGVN0A6hZbGpt2veilypsnkC9fkK5DWpPyFmlgNMWAa
         6jQfOJuFahUv4yDJXkmOPprBJ8R305LthfKe9d0HbKWsrh7O6iV/iqx+EZxo/8Jj0mPc
         Cy2ZrW73Z9pz6Rx63l/N7MbLYVaMOEyI/Pvp+xL2Eyb2TDPr0Ez7My6LioUbw9ElgMpe
         B7rGdflQo7QOVVIYOscJmd6y6KblJq9aetAige64PcFCuonjL5iQyRY7pdWh2LhEEkRR
         /rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4As9YzHRBrrZ1C0yo3XEDo6BKzSgfNCpKjF9OwCZh0=;
        b=XPfbjJRQozYpP0rtzm+NEOaRkiFoLALIyIN62daaBFWjf2aQX6pv5U0m4Dq2uZ3PhX
         fQNNK7zqBlQdg6oJg34xTuStydA09bhENAHwt9cOfV6rZMmTtD3++FFCNgTJQjajmLaD
         ulzV0ja0ZDAKV7kH5KucpT6zyXh65yH8fYjP9D/kxA/8vcd/XjGy+ARAIsM+XAEizfPt
         rjRFA9h1bZ9xaD1EglhzxLOv2J9UVGDJIUlYAx9c6pOQBOW6GU78tQ1XqwuubjnIOCAN
         sTbJxGcuj/qmvDZir4B7XAaitvJyzcBKHCeKncousEiSZq1UCKNui+crebS6jMdzY0KF
         G6kA==
X-Gm-Message-State: AOAM532yNJAXTuL/xqVGWi1tPmNORckYZBGWw/fLrxeEp3pBv584KKIp
        IR2d98B5r8uGNs1xtLAayCQ=
X-Google-Smtp-Source: ABdhPJxa7ryau6Xp1HxNg5EMWfbttV2me1SLWRyisMp8p6lvvVhTU2suzZzNksPN5Az+hAU0X9y2lg==
X-Received: by 2002:a17:907:86a8:b0:6f0:1f97:d7da with SMTP id qa40-20020a17090786a800b006f01f97d7damr10174693ejc.663.1650757658401;
        Sat, 23 Apr 2022 16:47:38 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm2104425ejk.41.2022.04.23.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 16:47:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: fix a potential NULL pointer dereference
Date:   Sun, 24 Apr 2022 01:47:35 +0200
Message-ID: <3607997.MHq7AAxBmi@leap>
In-Reply-To: <20220423184745.21134-1-makvihas@gmail.com>
References: <20220423184745.21134-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 23 aprile 2022 20:47:48 CEST Vihas Makwana wrote:
> recvframe_chk_defrag() performs a NULL check on psta, but if that check
> fails then it dereferences it, which it shouldn't do as psta is NULL.
> 
> Set pdefrag_q to NULL if above check fails and let the code after it 
handle
> that case.
> 
> Fixes: 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part 
5")
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/
r8188eu/core/rtw_recv.c
> index c1005ddaa..db54bceff 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1244,7 +1244,7 @@ struct recv_frame *recvframe_chk_defrag(struct 
adapter *padapter, struct recv_fr
>  			pdefrag_q = NULL;
>  		}
>  	} else {
> -		pdefrag_q = &psta->sta_recvpriv.defrag_q;
> +		pdefrag_q = NULL;

Hi Vihas,

To me the code looks like this...

	struct sta_info *psta;
	...
	psta = rtw_get_stainfo(pstapriv, psta_addr);
	/* The code is about to test if "psta" is a valid pointer */
	if (!psta) {
		/* "psta" is NULL */		
		...
	} else {
		/* "psta" is not NULL */
		...

>  	}
>  

Also, even if "psta" were NULL (but it isn't), your change would still be 
no good.

Please be very careful with these types of changes next time :)

Thanks,

Fabio M. De Francesco

>  	if ((ismfrag == 0) && (fragnum == 0))
> -- 
> 2.30.2
>  



