Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A165462C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbiFJJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiFJJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:50:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860D6F493
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:50:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so41734291ejg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GM7d3E0tduZqRYf2e+s3dbuLzIr4Mw1YJSMLDAOVaMI=;
        b=mPsDPC8Jc7T4BUqovcJHh9X9aOrAhrclaAa/mhdil1CMSWhn30imVTqNFRV+0HRuZR
         9clubq9kS7nPcWWq0+jUK/ZXeKuiFGzZDvtFDwXEp2uxKkZ+j2tw+p6oTgwkJY+ubiyC
         fNpq3+oeKLsbInyhxMt0RU7rnoLmgsm+qFbiG6K8ZL9ftfWRVogRMaCLYG0PEmOcWyxi
         Ej/gBPv4wGEs//8C5AqndzktP0qrzc314Ie0fAKrmlRueinVOKmVaBBtnVyEHYDDTkgY
         p8yH/z6bfp1mBhN+ixEyIEW0HoPZyP6dMU1cLXojoX9F8XKV/BwCrjhvbDch3r8LG4uz
         wQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GM7d3E0tduZqRYf2e+s3dbuLzIr4Mw1YJSMLDAOVaMI=;
        b=70Rxl24CxuPXejr2QFHmcdTb5zO8l1UzIEHyCBIasAhYUJaHAoaymHCiN/w9j6a+el
         qtm1dtse0ppMkw3Yf9qgFpktCQKJlsF+/W1bSOz2G+yCqgPPSM73o5cOhWUyOrSEKGhm
         pNnGs00WiqelemboNGzhhGfXVLVJWFiGOUbTztsFVoCqHi/rVrTFgzN/oljiLZmPTRle
         Lf1ZAz4l7uWeLE5mEEErOSglIXrBRtfd7BrPl2wUB6G/zzXxIoJ92R8eBabVw6vbvMPw
         tjbX40fD1Z48wJ36+joSO6uQ+60jfTMHJma61o2Qsg9+OTHDRRxVOa38ped3oj2e4vct
         jKDw==
X-Gm-Message-State: AOAM530+NOEyX9L7ICxnWcFlDOppy8FCBTAQ7AwKbVheqTgf1QbljOfq
        Hd94D23qDViehgUkZlzOcgOYxe4Pt9CENw==
X-Google-Smtp-Source: ABdhPJyCD/klApB8VX8jrzmpF60V4CVF43i+O2miGAxeX9trvWXvTRU8uZ81PMBn+YHe3kzoGb0iXQ==
X-Received: by 2002:a17:907:3f08:b0:711:d61d:e10 with SMTP id hq8-20020a1709073f0800b00711d61d0e10mr21666615ejc.11.1654854598989;
        Fri, 10 Jun 2022 02:49:58 -0700 (PDT)
Received: from ash.lan (82-132-215-210.dab.02.net. [82.132.215.210])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090608cd00b006fedcb78854sm11931009eje.164.2022.06.10.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:49:58 -0700 (PDT)
Date:   Fri, 10 Jun 2022 10:49:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Helge Deller <deller@gmx.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fbdev: atmel_lcdfb: Rework backlight status updates
Message-ID: <20220610094955.cy53ujicaplr7aw7@ash.lan>
References: <20220608205623.2106113-1-steve@sk2.org>
 <20220609095412.fccofr2e2kpzhw4t@maple.lan>
 <YqIuUYUXzxeSgZ/o@ravnborg.org>
 <20220609194511.4e0bc3e6@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609194511.4e0bc3e6@heffalump.sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 07:45:11PM +0200, Stephen Kitt wrote:
> Hi Sam, Daniel,
>
> On Thu, 9 Jun 2022 19:30:57 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > thanks for taking care of all these backlight simplifications - this
> > really helps to make the code simpler and more readable.
>
> You’re welcome! I noticed fb_blank was deprecated and near enough unused, and
> started digging...

I saw Sam's comment and kinda wished I'd thought to say that... definitely
good to see these things being tidied up.


Daniel.
