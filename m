Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3853F891
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiFGIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiFGIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A979B5EBD6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:47:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so9143087wmz.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MFCxeSf/EI5ZrX4R5qxvpJ37Tlo/SuICopwlGAHaFwE=;
        b=bDploY5B3xBytVkq1rdRy+lrn32shBl/P2hkOTVQh3dcylWijC4lyD2bWmLV9xKwzf
         JX0jg0O3pybEr4levP17Ht7by8CFIkQqyoGATsFUreLKycM7Mcr+GL54Ha4JE1m2ZyfI
         7EUIx7UAzFiHz5HKjgrw3SwDSBGpOHX1wGiNUi+uZGA1ctYA1Q6mDE3bGLNzD2OQr4GA
         wvVBl3etYgF2OPwlqkFb+HdzFu/2B4yeflAr4KHCvFGjMbchBMW9+UHeros848e44WXY
         FwidfYO+xjGo0ngdl/Mmi5KjFry0qZQQCf5ZwQ55Kw54+vfAYLYbPyWJU+pEerhfOmxN
         fNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MFCxeSf/EI5ZrX4R5qxvpJ37Tlo/SuICopwlGAHaFwE=;
        b=CORcgHiGwU9WkY4MonrjxUoXBpbVdp6Y9npTRNDx+9vRftEP5Cr79mmf/98ymvk0hZ
         TSsOUl89tjPQcNIRQdWioX8bUFd8P0zylo+yhj5WVR8F6oNrIo4Co+DX2KRQQFduc5+z
         JkaoRzj6YAHeS7mUi/Lby/tKjOV9P4Ck55FwdfaM2npVbABKiwVJK9p8ukjddGtXEN/u
         38t/aVPzxeLmV8Za46ekK4h8B8pk6k2ZNBDQeDIiVfMp0X7ATMK2ZuzNhYf5rduiRxzc
         Tyg1CCJAT053O6q/Q4Z2+GfB9szj4i+IfjtJSYor/ezD3XraLnYzn+1DG5Drmm2H1WcY
         kCyw==
X-Gm-Message-State: AOAM531kkoIqvQZjy7GZw5It5nMlL/NPfZT9QUXjZu2Ol862PCVqrN3g
        GL6h6kZ8mxFOpCmGceL6JAL3SA==
X-Google-Smtp-Source: ABdhPJzo6LgEelS2to40eNga34wnnBZLzGy8JBIEX1HRc0xHXr8jch8S7jhEVpEaPjVg5m/6vlRGkA==
X-Received: by 2002:a7b:ce98:0:b0:39c:4dc7:6707 with SMTP id q24-20020a7bce98000000b0039c4dc76707mr11384598wmj.51.1654591671135;
        Tue, 07 Jun 2022 01:47:51 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0039c3056c3dfsm1727181wms.27.2022.06.07.01.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:47:50 -0700 (PDT)
Date:   Tue, 7 Jun 2022 09:47:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
Subject: Re: Question about SPIs' interrupt trigger type restrictions
Message-ID: <20220607084748.45bc7qzxjjinb7mm@maple.lan>
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
 <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org>
 <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
 <20220530084039.7rjjbm4gkplg5747@maple.lan>
 <CAJNi4rNBXs4mwv2dsR+DrV9Of6_eb3Wm3FAJxZsWv5LHnVmVxQ@mail.gmail.com>
 <20220606100848.ir4bkj5qsskxe6in@maple.lan>
 <CAJNi4rPKbkqws6FvB66SaOR82LVHJo3F9DA6Q8SX4D2waiaieg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rPKbkqws6FvB66SaOR82LVHJo3F9DA6Q8SX4D2waiaieg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:29:06AM +0800, richard clark wrote:
> On Mon, Jun 6, 2022 at 6:08 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > There is a secondary interrupt
> > controller between the SoC pin and the GIC which inverts the logic (and
> > also obviates any need to deploy the GIC's edge detection features at
> > all... IMHO the GIC trigger mode should be active high).
>
> I don't think there's a interrupt controller between SOC WKPU and GIC,
> all the WKPU interrupt related does is to *detect* the external
> signal(falling/rising) and route to the GIC

See below.


> > Instead, I think the reason your code is weird is because the irqchip
> > driver for the WKPU is missing or broken. A secondary interrupt
> > controller requires an irqchip driver or you will end up with pieces of
> > the interrupt controller management code (e.g. weird pokes to the WKPU
> > to acknowledge things) appearing in all manner of inappropriate places.
>
> Again, no so-called second irq-chip except the GIC within the SOC.

Yes there is.

The WKPU is an interrupt controller and it sits between the SoC pin and
the GIC. To avoid weird code then you need a WKPU driver. Drivers for
interrupt controllers normally belong in drivers/irqchip.

I believe, in your case, this driver is either missing or broken. This
belief is based on evidence that you provided. You code appears to
attach an ISR directly to a GIC SPI irqno: if an irqchip driver for
the WKPU was present and working then I think you would be unable to
do this (because it would be busy).


> For me, the most important thing is WHY the GIC only support the
> rising edge just as its document said.

I can't help you with that. Sure, it might be interesting to know more
but I'm a pragmatist: I simply not that invested in revisiting a fifteen
year old design decision that can no longer be changed.


Daniel.
