Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72650533191
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiEXTI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiEXTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:08:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0E21E03
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:08:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ck4so32988386ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OulZq3Irlc58uEaDk3npzMcuhHJigRPmtDLvl24/rI=;
        b=WyOcrh4LJIMo3HCPOQWirbN/TJkvHif36lLojpxyJDhYud5TualgotcCkgcTvRO/pq
         fX1q0MxY4T7EUloEsrlNE/ubBG25fPlKLtE+zICmsYR9xVa8f0DZQ/3XC/00d/ZrfBj5
         7mjAAMXBwdKl4PzJmzUoqmFmmnuKiU6taXgjxER0By1YWVzrnw9+cfXMG3kuX9fW9+nZ
         H/pGzVoOP6cLrBSqzgjj71UYdJ5pstv9aa7alosWyvC1UzTvPQLrZD3+9UR+e6ggOa9h
         OeHRY9LY3AgoQUPrh4lnsrQwSO4hGnqeyP2gbTb7soQ6ieftA61Nf93Eig9+zZEDAu+H
         nTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OulZq3Irlc58uEaDk3npzMcuhHJigRPmtDLvl24/rI=;
        b=CBQDdLmMAsfh0a6Ao8uoNK+PtjNbr0w4lzirBOLjCmpnYpYx98dqVH9EY46s/snR1G
         MPrT3sZySvCF9yyOgn58oIIhaR8pqSF9GSpHVyOzA8bS6rZbpCF4pQUUo9kB3aiGt734
         6asuI8gocGJUENtVfJaNbRdU2GbLvs5wbGY/Fdr0yFdDoTftc0jv8IW/1XVEqXTyzmyR
         +2njhq9Zpb/Y8cGJcH6dmx55EQzXEZS6uoF6jDMssTEppkdtcIsjgXZl1XJQszPSPNje
         /kn706BJd0UkcypWM6a44c4eZiOokqOkKwCkK57Y+kY8tQIqIlLLw3qoJ+Z73TiljwRr
         l1Zw==
X-Gm-Message-State: AOAM531Bb/KNvjCcs5/gEyP8Jyx7Ipg6Bd1TUdDLyyVfAECIO81gegfw
        VHYR0eytgaqRoopFS97Gzk4=
X-Google-Smtp-Source: ABdhPJy6tiBlS7Y9PEG2y6NKd0gtJct5hHGBgdFkw2WWZBgKIw/lQUaM7aC1rncE2M7LApgGvxxnRQ==
X-Received: by 2002:a17:906:4787:b0:6f4:2f25:f9ff with SMTP id cw7-20020a170906478700b006f42f25f9ffmr27258921ejc.116.1653419334498;
        Tue, 24 May 2022 12:08:54 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709064a0900b006fed85c1a8fsm2777972eju.202.2022.05.24.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:08:54 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard <mripard@kernel.org>, wens <wens@csie.org>,
        "benlypan@gmail.com" <benlypan@gmail.com>
Cc:     airlied <airlied@linux.ie>, daniel <daniel@ffwll.ch>,
        samuel <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] drm/sun4i: mixer: fix scanline for V3s and D1
Date:   Tue, 24 May 2022 21:08:53 +0200
Message-ID: <4711779.GXAFRqVoOG@kista>
In-Reply-To: <202205221848264427024@gmail.com>
References: <20220521133443.1114749-1-benlypan@gmail.com> <3173956.44csPzL39Z@jernej-laptop> <202205221848264427024@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 22. maj 2022 ob 12:48:27 CEST je benlypan@gmail.com napisal(a):
> Hi Jernej!
> 
> > Which SDK? All SDKs that I have or found on internet don't mention YUV nor 
RGB
> > scanline limit. That doesn't mean there is none, I'm just unable to verify
> > your claim. Did you test this by yourself? Also, please make YUV scanline
> > change separate patch with fixes tag.
> 
> Here is the code about scanline config for V3s:
> https://github.com/Tina-Linux/tina-v3s-linux-4.9/blob/master/drivers/video/
fbdev/sunxi/disp2/disp/de/lowlevel_sun8iw8/de_feat.c#L55
> https://github.com/Tina-Linux/tina-v3s-linux-4.9/blob/master/drivers/video/
fbdev/sunxi/disp2/disp/de/lowlevel_sun8iw8/de_rtmx.c#L1212
> 
> And here is for D1:
> https://gitlab.com/weidongshan/tina-d1-h/-/blob/main/lichee/linux-5.4/
drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v2x/de_feat.c#L182
> https://gitlab.com/weidongshan/tina-d1-h/-/blob/main/lichee/linux-5.4/
drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v2x/de_rtmx.c#L1588

Thanks for the links!

> 
> I was tested it on V3s. Without this patch, the plane will not display
> correctly if src_w large than 1024, for both YUV and RGB. I don't have a
> device with D1, so D1 is not tested. But according to the SDK code of D1,
> the scanline value of mixer1 is 1024.
> 
> I'm new to submitting patches, So may I ask a question? If there is no
> problem with this patch, what I need to do is to send new patches as you
> suggested?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

I already requested changes, so you need to send v2. But wait until discussion 
is finished.

Best regards,
Jernej

> 
> Best regards,
> Genfu Pan
> 
> 


