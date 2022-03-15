Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3D4D9B35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiCOM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348222AbiCOM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 915CB13F92
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647347311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCUHLPHxtaZMWaxTPw6z/f+D0oxFiu0iBaxXSexErqs=;
        b=Lp+isdudoJMVhXXHiVqTL53v4U7TRCKEVu/Dt3mIqIM5w0taaZXKg2sYJsFqekqYVS0SI7
        r39aPfcg5NGwIaWMPP9rGaAuuLZ5Sqn37IGms182wvT+3axWJfduLU7Utz8bYa2x8mxWZt
        NB71n2BWoEjm/Cik3tA+GAUEanrCkk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-gNntNjEWPG-QuJn-92GAjg-1; Tue, 15 Mar 2022 08:28:30 -0400
X-MC-Unique: gNntNjEWPG-QuJn-92GAjg-1
Received: by mail-wm1-f69.google.com with SMTP id l10-20020a05600c27ca00b0038b85cf8a20so864201wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rCUHLPHxtaZMWaxTPw6z/f+D0oxFiu0iBaxXSexErqs=;
        b=zpGRzLNfjQ/QTqCXmABhflLo3AxShYorQzdw8RjEKnWNx4t1OyBbolIjPmO1rcTlge
         K0bmwnKFSvNFVivwT8Q8KjNK3v9lcaqESdvSPlZT2x1L8AktJ2a8S9+o/GnwAeZFd9t1
         7UABHRF1ittDOUzuTKuA1cLx9+v7h5TymiJPrkeXYkfdjbnzJbuT8mL+N+d3hNCJHnd0
         TGYfv7IlRJlReX9AD3OAOP1LUpk61rI3j8A+/I9y0EjH0KPPdZgCZIUMatgMTEqz3FoK
         8u+qyM+CJ3g091AOsiZChkC7YFXavLWO9Z+JKkMvlD08kG7LHNwuoQHrZn531Nhylm/V
         pzHA==
X-Gm-Message-State: AOAM531R5OtM8dhstvMibJjdZg2bPAjHGmWnaVr9XFPBptXDhxBwnr6T
        WcE7o6sHYF99NW6lwUy4lwi0+EMSufA7mmUI+Gy/TBBhnwtG1E8oNlSMNRek4AZLLA92s6zOxCN
        IJzXljKykQgWCDCyGEZ7T1pBQ
X-Received: by 2002:adf:f6d0:0:b0:1f0:7ab4:f905 with SMTP id y16-20020adff6d0000000b001f07ab4f905mr20351578wrp.54.1647347309439;
        Tue, 15 Mar 2022 05:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbsddZ89uZLO7jWyVAF+5O7Ev+loDx2qrY1pk1jcg4dS2xrgd+LAlcmE3FuBvM05QobW9sOQ==
X-Received: by 2002:adf:f6d0:0:b0:1f0:7ab4:f905 with SMTP id y16-20020adff6d0000000b001f07ab4f905mr20351558wrp.54.1647347309175;
        Tue, 15 Mar 2022 05:28:29 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm15815149wrw.70.2022.03.15.05.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:28:28 -0700 (PDT)
Message-ID: <2b735f7b-68df-4a35-466e-e5d8cd2ad36a@redhat.com>
Date:   Tue, 15 Mar 2022 13:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] drm: ssd130x: Fix rectangle updates
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-4-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220315110707.628166-4-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:07, Geert Uytterhoeven wrote:
> The rectangle update functions ssd130x_fb_blit_rect() and
> ssd130x_update_rect() do not behave correctly when x1 != 0 or y1 !=
> 0, or when y1 or y2 are not aligned to display page boundaries.
> E.g. when used as a text console, only the first line of text is shown
> on the display.
> 
>   1. The buffer passed by ssd130x_fb_blit_rect() points to the first
>      byte of monochrome bitmap data, and thus has its origin at (x1,
>      y1), while ssd130x_update_rect() assumes it is at (0, 0).
>      Fix ssd130x_update_rect() by changing the vertical and horizontal
>      loop ranges, and adding the offsets only when needed.
> 
>   2. In ssd130x_fb_blit_rect(), align y1 and y2 to the display page
>      boundaries before doing the color conversion, so the full page
>      is converted and updated.
>      Remove the correction for an unaligned y1 from
>      ssd130x_update_rect(), and add a check to make sure y1 is aligned.
> 
> Fixes: a61732e808672cfa ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Thanks for fixing this too.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

