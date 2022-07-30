Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6B585BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiG3ShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiG3ShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 14:37:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC462EA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:37:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m13so5490776wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRAXgV5+4KFo44IYj7c1ZkfqvHrarfrCB5sK/JIenvU=;
        b=UPqwM+d5w4Le3G5E+AEXJSI90MPvhs76FZf1qFDxO7qZvDmkRHAjpKh7EawIWlqbGM
         DQCSLMycVYoKeIvA33wp79RyjnRPjICTx9hcyB80W/vvdpNgSznRpeRU7cUqSxLdIM92
         8LP365WKYif8yz60XIJyJIqC8tWDfvcQaZk6O+FHCIpgPa4nOusW/TbicD/lntKttpFt
         65Ozhy2dLvkc9c8hh85BO8PcYp/mT5f1L6S56j7uHxLelSb0ERf+lANDSEfffhmZZe/u
         MfJEajZIIQzCI6CrlYfT31M3tK2QjgQH3m+iAc+aF0F6cIopVhDy97m9U/zB0PcGAwFQ
         zONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRAXgV5+4KFo44IYj7c1ZkfqvHrarfrCB5sK/JIenvU=;
        b=DCfNomX0pmSET7YX54GAH3jD66aO3InvbkdEFnLul0z0IjPC8TJWBJS1S2w+XDSfBX
         Wnolb4oXV4p1I2S96jlKwpqG7DJGMHgbztZ4XchYXYofuIa8XirGa71FErgsC7oDNWKh
         RVjKegxrB3IYVhHS75mgM0s0a5BN3Tq834VZQAjEu+MqoRx7zTjC+hfHCeqetxa0cHPz
         2Xmp/+Ne4RJEP04vvk0RGe9cs4zgjqQcJ68Ap6H4r3YP2z9BX4YubvQeKMfOaNaKehJV
         ENRW5VMEnLWUku3U5/z95p1RgtumNHQMnjRtZNc7IZc2w98YMVFfmpRZk6+574TuV3BD
         Ro4w==
X-Gm-Message-State: ACgBeo1NmQnoBDkYPSp8Cm9wyd6wBOo5X22h7kjvmUY0tKdbFiC2epgA
        IsUL0cqFQE0/np0zYM4XmonpkA==
X-Google-Smtp-Source: AA6agR4M59kJ8HR5FMOzBlEVjI9/veKY7t6DeP4amjMm2D277J07XnvQ/W3llUD989xngZo3JKwl9A==
X-Received: by 2002:adf:f109:0:b0:21f:14df:42d2 with SMTP id r9-20020adff109000000b0021f14df42d2mr4524624wro.45.1659206221120;
        Sat, 30 Jul 2022 11:37:01 -0700 (PDT)
Received: from OEMBP14.local (82-132-226-84.dab.02.net. [82.132.226.84])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003a046549a85sm13621645wmh.37.2022.07.30.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 11:37:00 -0700 (PDT)
Date:   Sat, 30 Jul 2022 19:36:57 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <YuV452xuR1S0WyJi@OEMBP14.local>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
 <20220729064803.GT2338@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729064803.GT2338@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:48:03AM +0300, Dan Carpenter wrote:
> On Fri, Jul 29, 2022 at 12:11:50AM +0100, Phillip Potter wrote:
> > -u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > +int rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> >  {
> >  	int		keyid, res;
> >  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> > -	u8		ret = _SUCCESS;
> > +	int		ret = 0;
> >  
> >  	keyid = wep->KeyIndex & 0x3fffffff;
> >  
> >  	if (keyid >= 4) {
> > -		ret = false;
> > +		ret = -EOPNOTSUPP;
> >  		goto exit;
> >  	}
> >  
> > @@ -424,7 +424,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> >  	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
> >  
> >  	if (res == _FAIL)
> > -		ret = false;
> > +		ret = -ENOMEM;
> >  exit:
> >  
> >  	return ret;
> 
> No, this isn't right.  This now returns 1 on success and negative
> error codes on error.
> 
> There are a couple anti-patterns here:
> 
> 1) Do nothing gotos
> 2) Mixing error paths and success paths.
> 
> If you avoid mixing error paths and success paths then you get a pattern
> called: "Solid return zero."  This is where the end of the function has
> a very chunky "return 0;" to mark that it is successful.  You want that.
> Some people do a "if (ret == 0) return ret;".  Nope.  "return ret;" is
> not chunky.
> 
> regards,
> dan carpenter
> 

Hi Dan,

Thank you for the review firstly, much appreciated.

I'm happy of course to rewrite this to address any concerns, but
I was hoping I could clarify what you've said though? Apologies if I've
missed it, but how is this function now returning 1 on success? It sets
ret to 0 (success) at the start and then sets it to one of two negative
error codes depending on what happens. Am I missing something here?
(Perfectly possible that I am).

In terms of do nothing gotos, do you mean gotos that just set an error
code then jump to the end? If you'd prefer, as the function just returns
right after the exit label, I can just return the codes directly and have
a 'return 0;' like you say above?

Thanks as always for your insight.

Regards,
Phil
