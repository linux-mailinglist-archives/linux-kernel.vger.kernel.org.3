Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110E4F0D98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376939AbiDDCsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376936AbiDDCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:48:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18C0387A7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:46:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id jo24so6508840qvb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/81xVbmtDHf2WP/8R42ewco+CVAZUSyt+UDb78zyCNY=;
        b=WaOiAQ9HUXu2dOsc71oDP61MKAQzGHcuv5C4UTqGyUnJupaRgsFAy47D3pKUuRBbxG
         c3G87jn1HfDnnGdGswOb53F2E8S0Tp9IAqATQN9hBsu4bJX3b79ZX1oJ5p4fm8mfj1bO
         ArAjJDXnGRWi5x96GFpZmSdbssHeDhHMz6JFfzdnUP06beIBV+lDCk8QpCsHvKxKn5ty
         9H9/KV6kum8IVy+U+0FY/CAiCrrsnNDui7FqdHpvtjuSMuKOXNgj7gXyy2eoWFRVH0Us
         fM2PVIhsBvN2kxpA2/cbVgguAnRTlIZcuA/f09bV46s6fokwMULxsvfmIObSJ2AoRgZv
         gmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/81xVbmtDHf2WP/8R42ewco+CVAZUSyt+UDb78zyCNY=;
        b=RYeKGgM3+SgA4ILYFUfMzd0rjp43TkTfxuYc7QOopAgnBzTMRy9TqQU0zx8Zf1+pqf
         dd6tpTZpdlWE7sT8jjMiEH6nerd/XaFQbILYsYEdbigQmxUcP3FHiqZahYa9glaX8Sms
         m4UANBtzsPRTtKQNnOjpdI3H0p1RgS1QCvI/1bRrVES9tBLmb85juD+QQnqcpE1OlMSI
         htzgO+/USekvRprLwPsn3uzxuVrjFKZWIOMNM+qHHDy/52KMUVgcFyBOQoQ1sKgPjp6H
         +QYHmP9ihd8Ixzr01YlEcWPoRAICvhq/P8CoMb5usqQ2a8M0Vww1KW0nz4soKcKAmJ3K
         TG5g==
X-Gm-Message-State: AOAM532Xwml6GJh4PjzFWxlczdx1Zp+ucRED844s8BCE1e7sFZMLR1RE
        XOz4XVM2hBunLLxyMXE5Xwla2ampl3B/WAVZ
X-Google-Smtp-Source: ABdhPJypTgjTr0aY3ypx41+nz0v0Jzf8hsPx6PwC0VJDwsUaS/jO0ZAEvoZ6QO3Z+Bk3TgZDO6AWNw==
X-Received: by 2002:ad4:5bc2:0:b0:443:901b:39a with SMTP id t2-20020ad45bc2000000b00443901b039amr17615989qvt.78.1649040384788;
        Sun, 03 Apr 2022 19:46:24 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002e06856b04fsm7728729qtb.51.2022.04.03.19.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:46:24 -0700 (PDT)
Date:   Sun, 3 Apr 2022 22:46:15 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH v2] staging: r8188eu: simplify control flow
Message-ID: <20220404024615.GA410484@euclid>
References: <20220403164250.GA371601@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403164250.GA371601@euclid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for forgetting to Cc the maintainers! Added them now.

On Sun, Apr 03, 2022 at 12:42:50PM -0400, Sevinj Aghayeva wrote:
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
> 
> v1 -> v2: Put the conditional in a single line to avoid checkpatch
> complaint.
> 
>  drivers/staging/r8188eu/core/rtw_mlme.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index f94b1536a177..cddd8ab80236 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1637,26 +1637,13 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>  
>  static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
>  {
> -	struct security_priv *psecuritypriv = &Adapter->securitypriv;
> -	int i = 0;
> -
> -	do {
> -		if ((psecuritypriv->PMKIDList[i].bUsed) &&
> -		    (!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN))) {
> -			break;
> -		} else {
> -			i++;
> -			/* continue; */
> -		}
> -
> -	} while (i < NUM_PMKID_CACHE);
> +	struct security_priv *p = &Adapter->securitypriv;
> +	int i;
>  
> -	if (i == NUM_PMKID_CACHE) {
> -		i = -1;/*  Could not find. */
> -	} else {
> -		/*  There is one Pre-Authentication Key for the specific BSSID. */
> -	}
> -	return i;
> +	for (i = 0; i < NUM_PMKID_CACHE; i++)
> +		if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
> +			return i;
> +	return -1;
>  }
>  
>  /*  */
> -- 
> 2.25.1
> 
