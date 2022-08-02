Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF55884BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiHBX05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:26:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8BE1D0D5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:26:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so104168wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 16:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=divMaYp2PwR7JKyePBzyLwdm77q7QESrQS5SQdU2768=;
        b=293P7jJiu86NDCa+tmiUQK8W1ZJSGPVvUc7YdqlyiQBKfErsQpFp/4F1mhIiGlk6y+
         vzg4yMfQRpqYCBVoV2rgZLYpW/mUrJqz0IN3KvPkbBGs0v/8mZ1r4XHASuclhqrk/3J5
         pmmp+v+W+d9XE7F+dikIauMKExqAQGw7FgFxAPoJMfKZ5omUAOilm/nE1CcfAp8QQBP6
         o4577B9emtYOiElZieytwZSqRYZKRU/IoV1HvHimIKRtYuhlhtxmsvfJLPXZabfbMacg
         F4A4/bssBif1uV0oGBPTQgAa+YDuuKnCoX+9j4ECI/+QoSukAqqLNNAjQ4ZdzPWZIea7
         I+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=divMaYp2PwR7JKyePBzyLwdm77q7QESrQS5SQdU2768=;
        b=cyPWcUud2ZseaNdj6FVFnN2f7oOWbicw33A8ON/gEnOuuRIEjqNCL8Itrx5bRPvyqN
         8Lw8RRZ5AAYUqsN/cOQ73yPsqCDe/cWfs/Lc2kAmTzhgwDlKjBpJJ5BA0+Sf+BvAER5x
         6SDBfMAi0YFoGM1SdBpQD6qwFzo8AS/NLU8I1oAse+MJ3Rbvzxr/50yDSRBpIIC+S/UF
         gep0vaeHpGct0K7RD8b3ADjmpiK3cJfV3a2X4vbbjI8yroT/Lrv0vYUtXlmBSP2laMnY
         ZILd2oigsX2kiDteOUp3/I2uJIL2bRwLTPx9E8yENLV+69I52K0NUKDvJ4jYYSzetmI2
         08Hw==
X-Gm-Message-State: ACgBeo1RKGScMdJMKSMiVUEPvmRy1/RCyOxcivEQb/MCCTnV6s3ySSRv
        mmzw0nJKLNwZtDA4NuDyvrIuqg==
X-Google-Smtp-Source: AA6agR6eRRe7dr5Pt7IVvjpo8FAR5/78P4XvVusd73d1w9D1yltC5MQAitx9PCRMlKGObWVtCubIBg==
X-Received: by 2002:a7b:cb44:0:b0:3a4:e8c7:59a2 with SMTP id v4-20020a7bcb44000000b003a4e8c759a2mr967273wmj.67.1659482812897;
        Tue, 02 Aug 2022 16:26:52 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g16-20020a5d5410000000b00220633d96f2sm9364835wrv.72.2022.08.02.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 16:26:52 -0700 (PDT)
Date:   Wed, 3 Aug 2022 00:26:50 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <YumyulRRT4gXNuNh@equinox>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
 <20220729064803.GT2338@kadam>
 <YuV452xuR1S0WyJi@OEMBP14.local>
 <f93d3ea32ac04a5edd8159abcb0504f71fe7aee4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93d3ea32ac04a5edd8159abcb0504f71fe7aee4.camel@perches.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 10:12:56AM -0700, Joe Perches wrote:
> Yes, you've got it right.
> 
> I think Dan is suggesting something like the below, but
> not necessarily in a single patch:
> ---
>  drivers/staging/r8188eu/core/rtw_ioctl_set.c | 38 ++++++++++++----------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 17f6bcbeebf42..2736bbce83b5b 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -390,44 +390,38 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
>  	return ret;
>  }
>  
> -u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> +int rtw_set_802_11_add_wep(struct adapter *padapter,
> +			   struct ndis_802_11_wep *wep)
>  {
> -	int		keyid, res;
> -	struct security_priv *psecuritypriv = &padapter->securitypriv;
> -	u8		ret = _SUCCESS;
> +	int keyid;
> +	struct security_priv *secpriv = &padapter->securitypriv;
>  
>  	keyid = wep->KeyIndex & 0x3fffffff;
> -
> -	if (keyid >= 4) {
> -		ret = false;
> -		goto exit;
> -	}
> +	if (keyid >= 4)
> +		return -EOPNOTSUPP;
>  
>  	switch (wep->KeyLength) {
>  	case 5:
> -		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +		secpriv->dot11PrivacyAlgrthm = _WEP40_;
>  		break;
>  	case 13:
> -		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +		secpriv->dot11PrivacyAlgrthm = _WEP104_;
>  		break;
>  	default:
> -		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +		secpriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
>  		break;
>  	}
>  
> -	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0], &wep->KeyMaterial, wep->KeyLength);
> +	memcpy(secpriv->dot11DefKey[keyid].skey, &wep->KeyMaterial,
> +	       wep->KeyLength);
>  
> -	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
> +	secpriv->dot11DefKeylen[keyid] = wep->KeyLength;
> +	secpriv->dot11PrivacyKeyIndex = keyid;
>  
> -	psecuritypriv->dot11PrivacyKeyIndex = keyid;
> +	if (rtw_set_key(padapter, secpriv, keyid, 1) == _FAIL)
> +		return -ENOMEM;
>  
> -	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
> -
> -	if (res == _FAIL)
> -		ret = false;
> -exit:
> -
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> 

Hi Joe,

Thanks for the suggestion, this is pretty much what I'd interpreted from
Dan's advice in the meantime. I will prepare a V2 tomorrow.

Regards,
Phil
