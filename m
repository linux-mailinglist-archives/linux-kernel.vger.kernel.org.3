Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136F55D58C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiF1L5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbiF1L5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:57:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76783135A;
        Tue, 28 Jun 2022 04:57:07 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i15so21873948ybp.1;
        Tue, 28 Jun 2022 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meEj07WgP17kCAxmyWFmfPo3EWzRrucLVHloJVwVfzI=;
        b=nUXN4NQbgs8R07Q3F9idMurCvTBqS180V7LUFPW9xG/4GbJsC5G9GMRYWxDvS8vHVU
         uvCdtyI8qAdQ7AhHruDB2L5qNXFrbtfVALrttTGovR2SgBuwdTrwSuYQV74CjQZQgmvj
         HYcyVjkdsYwLaFwO/+1xuqvqjXbzZxRsk5BBAis/bjPxVCPAtt1jJj2humxgQMfU7Bc6
         RCPw+sSoyWikaySEZeRhEcIgtWERGhzHi/IdeEjZfMln1Pt1OEqH9gYt7ZI+8vmUjdIU
         TPb2nvchPVSlB98dyYZaLbunSzSi3Sbx6IlBQ3Qr2V/AmBxO63kGjzEVaml8n/GlNDYj
         HRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meEj07WgP17kCAxmyWFmfPo3EWzRrucLVHloJVwVfzI=;
        b=jBZPTnOJeVAOlBsmnAwYScn9Vt30nryh6o8Ssu2AIevnWkCiKk+IF5wTec5ezpHaj6
         2FJRauyvfdPqLhdCw5C42o0a3DhAthkp+pyXmQMcx+7xsr8ZY/e2BlHpc+o2GgPDwaU5
         zci43d+WTHoGmC5js2TffevvtROXstn5qoJcOZXIyTADholk9rBeOZk22DVSHAJZaKCz
         RVTx4JKLOEZRm4P2Sre/WVqZuSiZe2GNQSp0lCctTnjpAGuVsemLtWEMYfk9EfngijuX
         sxhe2gjOHoXJDxoTT1+HP7s0/T7J4iyR8MsIBB/40hPOxMOMwZbSBkLRgxJoi8cuHYCX
         kzfg==
X-Gm-Message-State: AJIora/NIfvlL/Pi1BnFxyEJ1MLTuapvE0c/aDLTCR1FTDC2h+aMiXjb
        ePhnQ5vttoSqt+nzmE0FuW/pJ4dlZzJYekRbpvw=
X-Google-Smtp-Source: AGRyM1sjBV0Rj4DM5RUFn31/MDXkiMugtgXAowVXxqVxsB0QdtjANkqRI4IWbEW+Ddjy92ex8O5nKKGvNc+S7d7mw34=
X-Received: by 2002:a25:b2a8:0:b0:66c:8110:3331 with SMTP id
 k40-20020a25b2a8000000b0066c81103331mr19815871ybj.460.1656417426922; Tue, 28
 Jun 2022 04:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-6-marcus.folkesson@gmail.com> <CAHp75Ve+gDa46MRhTR-5dOutGhXqakZbSX14TurwnsuT4OeuYQ@mail.gmail.com>
 <YrWpbcjHSY+se1Aj@gmail.com>
In-Reply-To: <YrWpbcjHSY+se1Aj@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:56:30 +0200
Message-ID: <CAHp75VfPMjx8ACN-8xTwJsuYWoM1yHToPGSC=2R8TH5hgR3=-A@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: adc: mcp3911: add support for oversampling ratio
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 2:07 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> On Thu, Jun 23, 2022 at 09:20:01PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 9:08 PM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:

...

> > > +static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
> >
> > Spaces inside {}.
>
> Not sure what you mean?

   int foo = { 1, 2, 3 };

...

> > > +               ret = mcp3911_update(adc, MCP3911_REG_CONFIG,
> > > +                               MCP3911_CONFIG_OSR,
> > > +                               val, 2);
> >
> > sizeof() ?
>
> sizeof() what?

sizeof(val) ?

-- 
With Best Regards,
Andy Shevchenko
