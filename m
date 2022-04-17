Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CA504973
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiDQUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiDQUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:32:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3036E0A;
        Sun, 17 Apr 2022 13:29:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so913924pji.4;
        Sun, 17 Apr 2022 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJh/I41oC1sPYyv29N/Oqp9ZK6umpr2JJwjxPWBjuug=;
        b=IgvFyg7sqUe4mAc1souN04YLHOSpdGF50CS2XgotrbQfGU9qIlpFjPLRJDiYWgRUsX
         fxjE4ao0J5zsWeZGCYpUYH7HmvuFJzljgNLN6+wYGXEExCaxSRD163L1vX+7pwcxCpdH
         3Z7/9BkOlTbk3xzOa8qmVFvrUbZabTvF8ivwm5gkOyEUan72xo16lPPfMtYQBIeOPMOc
         cIgHTcjSf/Jl2ir6hozC5FdXuvkTiv+VqisqZe2DgSK0cZqUm9v9tjisO4zR6ZCrVAjp
         JubD6cx9st/PQI4mbVCTOxI7ZohSV9rB71DRZ+YaPOSeT4HJBkND2JIyef1GIpesWRF+
         eCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJh/I41oC1sPYyv29N/Oqp9ZK6umpr2JJwjxPWBjuug=;
        b=A8WwrO5jOR0Sia0LCjksHXT8dMSXMAsiCANd8qAJHGGe58rbopG2FIMkXaRoVlr88c
         6T0FmlhLpx/Qh1lMex7Dl7ZXWg/iEAjMKBYneBf7s5dcFiDl8JXDxtbQMedzi/5njyXP
         3wHipTkvhVGJ/e2zbjMuGMQrhEOMkAyUwk+CWuiqeNjjEVA3TnvvAWjxCZH9PYcpOcwy
         QgYEZeGL/regxsYBVylVej6qIaVSd6C0vSftjYf2/+5XiYAoomihD9VOYtSUc0YRU4re
         b8eMTU3ohmikejRixyRy12g28CC5LdoA8zmMw9IUKhAJME/kF5jNfFCjDGV0FjU5EAXe
         PIGA==
X-Gm-Message-State: AOAM532q5o0s0e3zi/ONFxrMU6XHN208MksXhrmJB+gHhaZJaXikahEf
        Vwf7zzHMKOginUjy+oS14SY=
X-Google-Smtp-Source: ABdhPJyRj1C6d8NmhymU/Uz462KMfFXui1ULPma/+ozW3GYTjdrhQmssroTQIlP8U8WblyWNeNH/7Q==
X-Received: by 2002:a17:902:ab58:b0:158:f2e1:8c4c with SMTP id ij24-20020a170902ab5800b00158f2e18c4cmr5478286plb.154.1650227363274;
        Sun, 17 Apr 2022 13:29:23 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1752:34a6:ebd3:cc40])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm10213054pfu.202.2022.04.17.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:29:22 -0700 (PDT)
Date:   Sun, 17 Apr 2022 13:29:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Julian Schulte <schu.ju@gmx.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     hadess@hadess.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix Touchscreen X Axis inversion on Trekstor Surftab W1
Message-ID: <Ylx4n/hqBhD+PAxX@google.com>
References: <20210626065417.8818-1-schu.ju@gmx.net>
 <Ylx3vduFGFlCEY0F@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylx3vduFGFlCEY0F@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 01:25:33PM -0700, Dmitry Torokhov wrote:
> On Sat, Jun 26, 2021 at 08:54:17AM +0200, Julian Schulte wrote:
> 
> Just found it in my inbox. Adding Hans...

For real this time...

> 
> > Signed-off-by: Julian Schulte <schu.ju@gmx.net>
> > ---
> >  drivers/input/touchscreen/goodix.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index c682b028f..cec5f7bdc 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -248,6 +248,13 @@ static const struct dmi_system_id inverted_x_screen[] = {
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "I15-TC")
> >  		},
> >  	},
> > +	{
> > +		.ident = "TrekStor SurfTab duo W1 10.1 (VT4)",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab duo W1 10.1 (VT4)")
> > +		},
> > +	},
> >  #endif
> >  	{}
> >  };
> > --
> > 2.30.2
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
