Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474C4B1E88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiBKG10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:27:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbiBKG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:27:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B6B1030
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:27:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c8-20020a17090a674800b001b91184b732so8516011pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JhnvwkrC36+ZtBCSmsX8E71vUbd01PT5UHf/8Lx3bYI=;
        b=PhKG9VFn/JmTyURd15Sm5JvSvvHeDltFHCnOaYECW9yQEcKi7QXtGCXEjjcrWiaM+V
         St3/XiNEFe8yGswKO4+6+jemFpF28TMNolHqtVhi/zNuu1HMKrZUkbpdXnRIkd9LotAY
         OGj5EppaCiBgFVN+OJdqIxuwLEsVNYY4dsgu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JhnvwkrC36+ZtBCSmsX8E71vUbd01PT5UHf/8Lx3bYI=;
        b=EIb13kac8wEqnoO7uBElhFK2qbJg/fDsc+vfDajaxHOxOgaTbin7Irsfp6I7hG6S4N
         UO4Ersr9QkzUcqPjs+mMOfClDCqApazGXOki564Uzg3y9okPt73OTGaNC6yw0o7wuEtR
         U17ZWFTdJXdPO1zEr/KSJw+06n9tRMfZnB58QH83fYZhSPYpXIZcdj/lfrdFwWJiV26Z
         u4HLDGFq0tKxAcTdjkQSGGKO9OkTN/p/0eB/CC+POfBITIhA/nU0Z2XbjXIj52N0CIPP
         qB+tsY/GaPGGjXlY4ysj15ip6FQp5o8FmLxUN1xINDu2EYXoHyBHLgwdRmv6DawjubGe
         JWvQ==
X-Gm-Message-State: AOAM532/aS4TRMbbtrgw++evp94ODfz8TecS8pEjDooLisMbhHfbfJ0Z
        ZfIR+P4h9pgO4jnYNQIJ9kRwkA==
X-Google-Smtp-Source: ABdhPJz5ANcTe3+INLtHZyy5LDDfipqUtY9os4gw6Lm8N3C26gsFfqTBRgoChXV9aGU8ErX1TizrTQ==
X-Received: by 2002:a17:90b:380f:: with SMTP id mq15mr300828pjb.84.1644560842505;
        Thu, 10 Feb 2022 22:27:22 -0800 (PST)
Received: from localhost ([2001:4479:e300:600:d3de:3045:38b4:5296])
        by smtp.gmail.com with ESMTPSA id u33sm25826267pfg.195.2022.02.10.22.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 22:27:22 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto/nx: Constify static attribute_group structs
In-Reply-To: <20220210202805.7750-4-rikard.falkeborn@gmail.com>
References: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
 <20220210202805.7750-4-rikard.falkeborn@gmail.com>
Date:   Fri, 11 Feb 2022 17:27:19 +1100
Message-ID: <87tud5rk8o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard,

> The only usage of these is to pass their address to
> sysfs_{create,remove}_group(), which takes pointers to const struct
> attribute_group. Make them const to allow the compiler to put them in
> read-only memory.

I checked the file. Indeed, those structs are only used in
sysfs_{create,remove}_group. So I agree that they can be constified.

They also pass all the automated tests:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220210202805.7750-4-rikard.falkeborn@gmail.com/

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/crypto/nx/nx-common-pseries.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
> index 4e304f6081e4..7584a34ba88c 100644
> --- a/drivers/crypto/nx/nx-common-pseries.c
> +++ b/drivers/crypto/nx/nx-common-pseries.c
> @@ -962,7 +962,7 @@ static struct attribute *nx842_sysfs_entries[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group nx842_attribute_group = {
> +static const struct attribute_group nx842_attribute_group = {
>  	.name = NULL,		/* put in device directory */
>  	.attrs = nx842_sysfs_entries,
>  };
> @@ -992,7 +992,7 @@ static struct attribute *nxcop_caps_sysfs_entries[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group nxcop_caps_attr_group = {
> +static const struct attribute_group nxcop_caps_attr_group = {
>  	.name	=	"nx_gzip_caps",
>  	.attrs	=	nxcop_caps_sysfs_entries,
>  };
> -- 
> 2.35.1
