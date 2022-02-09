Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3700E4AF6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiBIQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiBIQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:38:20 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72223C05CB86;
        Wed,  9 Feb 2022 08:38:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id o5so2252614qvm.3;
        Wed, 09 Feb 2022 08:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UiDGjAXge98sndCi//gMspGlqK9CQ0rnW1ogp58x2ps=;
        b=L1pMsspBH0+fY9TcP+mb/z6ZEcA+7PIKwqG39N0YxdzIsvrcZseths0aZYOKQFkr1j
         jRB3Q0GUDIUV8DiSZQNeqJG4ddEkddGBW8z/0McwrDwhIqDgih8Gv7pOH5QWVQkI/Jjm
         CowY5ksaFVghP+u2nt2CtBZJRmGjIpfJaUXGIBIl0UAuQUq0yfP6mzGu1TiTelKE3bzq
         bH3XZPxUWq4eCF05CCdPKgykTteAsqWlJRmgHAnTCtqRGVUQNdYrzOn+6Wrv5QTZaelt
         Vc2eucNmiowalOng2Ixxh7MXuCBAj7aMOa1sVTzcZSQepMxxKrwjKCACrqLsnYj0jrGT
         evrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UiDGjAXge98sndCi//gMspGlqK9CQ0rnW1ogp58x2ps=;
        b=d1Jis4MmOux1y50DfYLB42PPoAN2LFEmxZG6RsG15sniOMk13Arbt6rRwWDHiPpOkk
         RO1MuIPZxCxum6IoQ+47GkIX6gI6bBt1NNgUHlpjkZakClhJg41jfV/WvELf+zSmZmdm
         wQIKr7t/6UAAQZO4PuuXmTWheLmNDay7vrumg6WBuiiqkBACUMtnn1r6RtjykkBG1sTb
         nPcRPFBTccbP/wF1oyxa6Bj8JOpukoZbcKEjkMkAATyctB4vfwMiPR8paGYDN4Rkiztk
         gnLo0ioq2Tr5o7Q1xmJwOj4dpoc/FIspc4APNZ1M95XELaqIXCSrmfTazcy3OB0K+ApR
         9lwg==
X-Gm-Message-State: AOAM533fWDAh9PBwu4/Z24Fw7ZWxv7pjItFrQiUCqS1VtAMdH+8/kxLR
        dj+SmM2imgxiVKJkFv1hyh8=
X-Google-Smtp-Source: ABdhPJwsX0Xi32lBOFhWLJxQrAM1pKPkOdKAQbS+/Ckq/iDNb9C1DsvDa69Nkuq5BlJyRv4A6h3azA==
X-Received: by 2002:a05:6214:5298:: with SMTP id kj24mr2126321qvb.67.1644424702660;
        Wed, 09 Feb 2022 08:38:22 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id w5sm8623401qko.34.2022.02.09.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:38:21 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:38:20 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v14 09/11] iio: afe: rescale: add temperature transducers
Message-ID: <YgPt/Hut4T4C86fX@shaak>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-10-liambeguin@gmail.com>
 <CAHp75Vf+FkofvC3_jvNadGed+eH7mQvVYXTOiWKCzwinJ3-2-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf+FkofvC3_jvNadGed+eH7mQvVYXTOiWKCzwinJ3-2-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Feb 08, 2022 at 03:46:27PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 8, 2022 at 4:04 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > A temperature transducer is a device that converts a thermal quantity
> > into any other physical quantity. This patch adds support for
> > temperature to voltage (like the LTC2997) and temperature to current
> > (like the AD590) linear transducers.
> > In both cases these are assumed to be connected to a voltage ADC.
> 
> ...
> 
> > +       rescale->offset = div_s64((s64)offset * rescale->denominator,
> > +                                 rescale->numerator);
> 
> Wonder if we can use mult_frac() here. Would it require 64-bit division?

Same here, I'd rather keep it as is, especially if you plan on adding
helpers later on for struct u32_fract.

Cheers,
Liam

> -- 
> With Best Regards,
> Andy Shevchenko
