Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD14AF200
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiBIMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiBIMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B35ABC05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644410481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2T/ZX315dLjrEaKbTpQjrwkLEmj/39CedeR+myw2pnM=;
        b=WPoM+LoTGwPb2LY5sFnqhafrZ/+F1+qE354cDBnT+aVHvWJc2HeqHL+1V5dRyg1x71CvLL
        VI8snj5R7lAcTerxYU/iw41M3uUGChGdk3KXNqHk84ss8nP0z85K7JVzDej5hKDstTFtvp
        n3RPZbK4Qd3CIqvXCKhhnvtBn5AFqrw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-bN0312cFPXCIwsoWWALDSA-1; Wed, 09 Feb 2022 07:41:20 -0500
X-MC-Unique: bN0312cFPXCIwsoWWALDSA-1
Received: by mail-wr1-f72.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so1054335wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2T/ZX315dLjrEaKbTpQjrwkLEmj/39CedeR+myw2pnM=;
        b=0tW1rEkG5Rk1gsqA69ATBscAeGQW5onVrk0TQbWTjbIjOblELsraeyslDwtNpVb/kU
         i/ZQhIZSAsaJK04YAOEw8p5EGdCbvvgUEcvtdFMCKKGH4XAWxnJJMf7VcN8ANA+nyu3t
         gU1l6YAzg4XJfPuQUhKgLXz/3iy/jI1r7ppON8Vwi/dnwj4u0l4IWRwUqHcBHCiXwVao
         O7xHIC09CSGYdz0dIeilY84khbCEIqyfcGL+QthK9FtTLVtQZI6CWojHnH82JsbEvAwN
         b+lKagM7r6fsRrEriW+IlnqqiNTAc2aimhfe7J+PnQXXgjBJ4KQk/piL/U7Tzl9BvZTO
         9Zqg==
X-Gm-Message-State: AOAM530zXVPYPGKOOr1dmppwweGqQfOX96h9tnptXcnsP3rRNQVZTmBI
        fLpXIn/nJeLgTilU9RoYufbVecPn/VUKbFNGzy1CJIDoc5qOQoRNAmMyU0NCSuAd24L/sixBeuR
        A9GtT25UcbDFwVugUfxoE7qXo
X-Received: by 2002:a5d:64af:: with SMTP id m15mr1973602wrp.478.1644410479720;
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPYKui1CF0MIpN4jnFuKlY7TO7NxCK4qlra0MJS9GiBFjcirpTBRptBCzbYbNupz5K+sxp5g==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr1973587wrp.478.1644410479500;
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p3sm5299211wmq.40.2022.02.09.04.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
Message-ID: <29312c12-5684-b134-3e0f-e02240c574c6@redhat.com>
Date:   Wed, 9 Feb 2022 13:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/7] drm/solomon: Add SSD130X OLED displays I2C support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-5-javierm@redhat.com>
 <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Thanks for your feedback.

On 2/9/22 13:21, Geert Uytterhoeven wrote:

[snip]

> 
>> +static const struct of_device_id ssd130x_of_match[] = {
>> +       {
>> +               .compatible = "solomon,ssd1305fb-i2c",
>> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,
> 
> The casts are not needed.
> 

Right. I copied the table from the ssd1307fb driver verbatim. I'll clean it up.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

