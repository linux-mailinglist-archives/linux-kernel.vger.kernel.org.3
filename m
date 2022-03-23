Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F74E5481
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbiCWOro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbiCWOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:47:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78E532F4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:46:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v22so2476851wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=osLyPR/OysO0/n11H7AyANhO10/CTJLTc9ULyTX82oc=;
        b=cZaXEPpaknkOxaMXvhQ/HgoGQQU3YKPajtONR43xfSdCDY5mvCG32dpUXAP33seVEl
         8OQt1m76wmS6muVA1bUZgRX7CYPa81owPkhrk1JN3JJncVVzoJ3cyuwt1UTA+SDxmey+
         WTqvzy3ih5pu4sfTv70YVhN7Bb4aVO7vgCL4G5X+1TX/MUreaM/8g1gM4fUuLYzxOuEB
         mA6gW2VhEHSQ1fN1mbUWmirYp9sVNGx64gLIy5Z3WmDPFxvN/ed3jkl6dRZQQuqAuOp+
         5ALQyjz5TFBOMZfrqoye9rXuhCf2tIx0g73qNocysYPw9WZSCFQprDGeszbnJ0+24PeW
         OEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=osLyPR/OysO0/n11H7AyANhO10/CTJLTc9ULyTX82oc=;
        b=gnjf7bYtL3m/+IdHiYNN/8W45OmFjsLehGcnse2veiR68r1aA6V3qWUScmUV8YWyaN
         uwLS3dpFqZ2hnoWStrGbrKxvZBKt/8n19HGA+hYE1F5H9LdyMKNzTfF+jGKrHkw9Lar+
         lrURFXi5XmoOkFbp7fpEmJpJds9KawMJ0BB0dEWyWRLepA9S8B8hr0OEyErf9OjvLCU1
         t9BcPfvPkqI6O3gfRoXWTaDgyvtsuqpsBGIdjDypUpnFWYXKAAVWrXW8Wt29n7qHxhaa
         TrM1gTKmuPzdIS6hijc4wcqNaFYCkRT7PDFqNB8gR19ix1MudJvzjGvV/LI3CeBgFM1F
         MNKA==
X-Gm-Message-State: AOAM531c++v2KJ9QR+SifYO9uIOyFe+D3gWRp/5nFBa1llZTKHPXBcA7
        ajKW8AXwRZiSNAKiT1XQHsjr0z6kdjyaSQ==
X-Google-Smtp-Source: ABdhPJwTcfLiKGZ11ta0GNYR4Mm2J9YZsnvUd4S4bvVfvkGomvEYYHwOhL03vKx+NQVzEU+Tkz2XiQ==
X-Received: by 2002:adf:9794:0:b0:203:e074:1497 with SMTP id s20-20020adf9794000000b00203e0741497mr127921wrb.75.1648046770723;
        Wed, 23 Mar 2022 07:46:10 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm4213009wms.30.2022.03.23.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:46:10 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:46:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: Fix pinctrl node name warnings
Message-ID: <YjsyryNcGm9ku/kF@google.com>
References: <20220303232350.2591143-1-robh@kernel.org>
 <Yjl6fP2Bylv6ud8W@google.com>
 <CAL_Jsq+5GkEaE9sf5HJMaNQLkZUB_q2Qyv2rzADVD7if1MNvqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+5GkEaE9sf5HJMaNQLkZUB_q2Qyv2rzADVD7if1MNvqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022, Rob Herring wrote:

> On Tue, Mar 22, 2022 at 2:28 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 03 Mar 2022, Rob Herring wrote:
> >
> > > The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
> > > pinctrl: use pinctrl.yaml") resulted in some node name warnings:
> > >
> > > Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: \
> > >  lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > > Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
> > >  codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > > Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
> > >  pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > >
> > > Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
> > > nothing from pinctrl.yaml schema is used, so just drop the reference.
> > >
> > > Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
> > > Cc: Rafał Miłecki <rafal@milecki.pl>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > >  - Fix lochnagar-pinctrl nodename in example
> > > v3:
> > >  - And fix lochnagar-pinctrl nodename in 'required'. Sigh...
> > > ---
> > >  Documentation/devicetree/bindings/mfd/brcm,cru.yaml         | 4 ++--
> > >  Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
> > >  .../devicetree/bindings/pinctrl/cirrus,madera.yaml          | 3 ---
> > >  3 files changed, 5 insertions(+), 8 deletions(-)
> >
> > Requires rebase.  Doesn't presently apply.
> 
> It's already in 5.17.

Oh, I see what's happened.

I provided my Ack on v2 *after* this was posted.

Makes sense, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
