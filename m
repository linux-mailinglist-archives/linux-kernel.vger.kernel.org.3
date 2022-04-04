Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE54F0D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376945AbiDDCto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354115AbiDDCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:49:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEF344D5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:47:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h196so6613733qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wsLsGGE6HZAHiQo4OADVHc+WEijVYyrts9GPXNxbj+Q=;
        b=nVEdY9wTdUl2M5C0fwaRvMdn8h0o+pbl2zp8lwgOZR1TDX7QgQOIxfoMPWtm11f34e
         kYRaVkwW+mUexHIJYZv3aofkqyIXaBSeyDa043A+f0XzGna93/SdyIMo78ZheATCZC6b
         FBIA2YUOijW2SdmMpRssDvOmVv9c+A2oGkxtNAtHZmF07psOZVIrNQWJW6MXODKSRfS9
         RJJPEdbyUObh9e7p3Lf57zOHBWMT5gAGKptTqIxC2r7+q7r+hE3pkQp9wygl9baOagvY
         n40ZZMmzDdmcG3/E+Ox73dOKItrvwmKnJPZ+xxoZ3C+llWOHkiwocqNVEUkZCcinNvbf
         45Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wsLsGGE6HZAHiQo4OADVHc+WEijVYyrts9GPXNxbj+Q=;
        b=0YV2/nuHIRJkAOiDoYRcUjOU3rILZYbydnwPfXzLqLJqa+P7eHXeQIFmEkYtKT+XLv
         6GWsVRr7aMz413gnfNRzZcAhdSaVLKPYCuZpA0rIjPIsCshRJC+SEmRKLevIbAypqyte
         dyq/8p/+Qrhr/0sI6JoEm1rUNYgvYODPL8+ynTTRqDZXyJjiIrH9J4dyAkEg7LAGB0PT
         67wcrkog3WKjWed2wKjIDkgAE/GuK3dTFCZKioxwhyfMMZeVdvONuMpIpaW9Gpv0sqAC
         yBMpi8e7aqrMTOuhBqxRjZurlv9fKBRg9JcCzcVoGNDlJ9pqFR/7Z/0+G6dNPix/DIVX
         iYbQ==
X-Gm-Message-State: AOAM533EJQtUebD84WSbQv8q38sIR1JgQWxjjcEYni76DOi19V2sj/3u
        eBY6RiIEGCd823f6XfwK/wCsPpJQjLTwrbJN
X-Google-Smtp-Source: ABdhPJxVkXfOkHGI9Sya0dmnZfZSb5+tRDyXe/3ht8pXZtffS2Ni+rJlITNG2SP4KZW6ML2v7jUTlw==
X-Received: by 2002:a05:620a:40d5:b0:67d:f2cb:a38c with SMTP id g21-20020a05620a40d500b0067df2cba38cmr12643183qko.197.1649040465623;
        Sun, 03 Apr 2022 19:47:45 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b002e1c508ba41sm7326067qtk.19.2022.04.03.19.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:47:45 -0700 (PDT)
Date:   Sun, 3 Apr 2022 22:47:38 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>
Subject: Re: [PATCH] staging: rtl8712: simplify control flow
Message-ID: <20220404024738.GB410484@euclid>
References: <20220403165325.GA374638@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403165325.GA374638@euclid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for forgetting to Cc the maintainers! Adding them now.

On Sun, Apr 03, 2022 at 12:53:25PM -0400, Sevinj Aghayeva wrote:
> The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> the first index for which the condition is true. If no such index is
> found, the function returns -1. Current code has a complex control
> flow that obfuscates this simple task. Replace it with a loop.
> 
> Also, given the shortened function body, replace the long variable
> name psecuritypriv with a short variable name p.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_mlme.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
> index 92b7c9c07df6..b93b33092932 100644
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ b/drivers/staging/rtl8712/rtl871x_mlme.c
> @@ -1284,26 +1284,13 @@ int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
>   */
>  static int SecIsInPMKIDList(struct _adapter *Adapter, u8 *bssid)
>  {
> -	struct security_priv *psecuritypriv = &Adapter->securitypriv;
> -	int i = 0;
> -
> -	do {
> -		if (psecuritypriv->PMKIDList[i].bUsed &&
> -		   (!memcmp(psecuritypriv->PMKIDList[i].Bssid,
> -			    bssid, ETH_ALEN)))
> -			break;
> -		i++;
> -
> -	} while (i < NUM_PMKID_CACHE);
> +	struct security_priv *p = &Adapter->securitypriv;
> +	int i;
>  
> -	if (i == NUM_PMKID_CACHE) {
> -		i = -1; /* Could not find. */
> -	} else {
> -		; /* There is one Pre-Authentication Key for the
> -		   * specific BSSID.
> -		   */
> -	}
> -	return i;
> +	for (i = 0; i < NUM_PMKID_CACHE; i++)
> +		if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
> +			return i;
> +	return -1;
>  }
>  
>  sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
> -- 
> 2.25.1
> 
