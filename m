Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22C5451AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiFIQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiFIQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:12:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6C3167DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:12:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o8so5232785wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChRG0KIYJMedQ4f2yC6bVNs8GdwBtDapUrzg7nKkys0=;
        b=CKmrwiUrOU9h70UP2P7kjzM9gYsPPlap/tfoIFKC4YLIKDPUcdy6FrZfRNxmtRhHF9
         rjWpQSJbVXpwnHLlHB66DK0zxkohNjpoHKB0MgKQdcVyFUwDclHUFH3uHgVy8H/rm0NV
         9SklHSST56yPstDrNS7fR98++/43tpAZHdA5nOuuqAjGwiiUsYZqvfNgsmpyXxc89BfL
         TROcQk9KRgq1kuEBNmIK0tzum9TJSdfoNaAkkWOhxHmhJlNp/ux0SPoYbuZx6lGrYPB9
         r9u0bu+kVxn/zUtd8ETpXDkrfzmf0BHiqjiQ3yook620V2wUNPkUSwvZdV4/v8vsi0uW
         +cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChRG0KIYJMedQ4f2yC6bVNs8GdwBtDapUrzg7nKkys0=;
        b=zDZeOIJdbCI9ixMXBthQoj2u5hq5p1w7zfSXEc52Hn6ko3iZQ2wRSqFAljHjtrWNEo
         8XoNbVJlGPmJEercOMvV93pd4nROJKG4Az5P9DrqNEWSmthrMiWD3lYw3eCGD0EWpdw8
         4TDPnodcb0oF8kTRaGeQ89DvH9z6Pfc22li0gJgObpSmYIWKtbhdl//bIu2OVCzxkFKD
         4irM96q1ltyJtZ5a9/OSrenkHNz4qgMnnLyIhWwFy0VURfyAsG1Pm24UsJLQRN6EBY76
         1BySC03IDUC75soP4wfrOTLgvD8jydk01n13hXqsCYlsxNVYNC8P60+FQUoe7lM9vpcE
         vKRw==
X-Gm-Message-State: AOAM530xw14UD6q0m+IutnSYkeCvvg9xRVGgnt1wvEpP6G9uKMyWxc1W
        7JPP1mdcW+9hI21viMookZkfgQ==
X-Google-Smtp-Source: ABdhPJyN0EMGgDYiCDR0QuKsfGPudsUAuMjjiZvGNSnBJHONwJ3trgJHUZ2xULhavI+BcDBHI9HhqA==
X-Received: by 2002:adf:d1c4:0:b0:210:1935:3dd8 with SMTP id b4-20020adfd1c4000000b0021019353dd8mr39406969wrd.229.1654791158912;
        Thu, 09 Jun 2022 09:12:38 -0700 (PDT)
Received: from blmsp (dynamic-046-114-004-246.46.114.pool.telefonica.de. [46.114.4.246])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b002103a7c5c91sm24014567wrs.43.2022.06.09.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 09:12:38 -0700 (PDT)
Date:   Thu, 9 Jun 2022 18:12:36 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: power: Add MT8365 power domains
Message-ID: <20220609161236.b72x5hkvd5do6o2d@blmsp>
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220605212200.GA3539140-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220605212200.GA3539140-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 04:22:00PM -0500, Rob Herring wrote:
> On Mon, May 30, 2022 at 10:42:11PM +0200, Fabien Parent wrote:
> > Add power domains dt-bindings for MT8365.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  .../power/mediatek,power-controller.yaml      |  2 ++
> >  include/dt-bindings/power/mt8365-power.h      | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >  create mode 100644 include/dt-bindings/power/mt8365-power.h
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 135c6f722091..2c6d3e4246b2 100644
> > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -29,6 +29,7 @@ properties:
> >        - mediatek,mt8186-power-controller
> >        - mediatek,mt8192-power-controller
> >        - mediatek,mt8195-power-controller
> > +      - mediatek,mt8365-power-controller
> >  
> >    '#power-domain-cells':
> >      const: 1
> > @@ -67,6 +68,7 @@ patternProperties:
> >                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
> >                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> >                "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
> > +              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
> >          maxItems: 1
> >  
> >        clocks:
> > diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
> > new file mode 100644
> > index 000000000000..4f50997a13b4
> > --- /dev/null
> > +++ b/include/dt-bindings/power/mt8365-power.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Dual license please.

Thanks Rob, fixed for v2.
> 
> Rob
