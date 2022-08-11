Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67458F9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiHKJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiHKJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:02:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC677167E1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:02:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j8so32360947ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=pPnoh77QEcb+sKjdUBUVtHO5SMPJaPgXOLcl+ed6QOk=;
        b=IXX6jMMZyMHVMk0TiNF4dt/q+pPM6XZ8yg81aYk029NESvkf12Emw9btUPkil0WEsR
         1PMsQYO3PUCDYDfz81FzleYvJu9C3c03jCBPzl1ijNceaeE6bJX3o0Hca9Jxiw8yEQbx
         h2UPY1i+ss4F9YZlzZB/qlZmF5zfClDJqZl1RVycUixhb5d57s5YhFIyuVntEeoHTy1c
         jvokit9Y2qe1qFgn6RkshFkMYyAwBtSTaNO2JYG5eCad4tafI3zXVnlW3EBU+qOAQdSy
         ZJIPxKeLkt2QIZCy/ieehi0trHlCci1uPzvqgvgoRFF00YWE2cg/M+l/viKARC3jLOpT
         oWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pPnoh77QEcb+sKjdUBUVtHO5SMPJaPgXOLcl+ed6QOk=;
        b=27yb1ielbK31U7XPVk4ZCMCMrRYSAIp5hGVYe3RGqUdiLMRNmwcjUSaxEw9f8WiDYa
         NK9r6KZKQXDOcH7zEPN7QiZKx4h+3lxQjSGoc0Bc44BscgUnU8tdRwzZz/t4YV71l3Td
         ipYdgbxDPQG+65LfqmRhg9oGf77UVvUdw/zxJYQ/dEgoQtFP3cybMzZv56xNW4CG1Otb
         mZze66+6Iodf3q+XIOERH77qyXllFE+b6d1ceuGFjI5yKO8B6LBY3DirkWQmQDKsvgbp
         3u4kdyPEFHtCYFotQBnmI6cqtRsiqU6d3ufgYYrw5b7xuy8saXVS40aSZ9IBSqSVCWOk
         k94g==
X-Gm-Message-State: ACgBeo1pFXV6cm6nDIRccQ89HkxQRZEyVjGj77h4StissehDnEA0AcK9
        hkqscgaMDGPBna+DXp9EZyeVZQ==
X-Google-Smtp-Source: AA6agR6sVb8BEuxDhpl4+d5fPlqr2RhhkvOY8mq+n60l4jTmNyzMGtr3zfbk0tsLoxqb7bKLwfs+2w==
X-Received: by 2002:a17:907:7292:b0:733:1965:3176 with SMTP id dt18-20020a170907729200b0073319653176mr3867288ejc.318.1660208570424;
        Thu, 11 Aug 2022 02:02:50 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:8036:200c:a862:4253:884])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b0043a554818afsm8782252eds.42.2022.08.11.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:02:49 -0700 (PDT)
Date:   Thu, 11 Aug 2022 11:02:49 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: mediatek: add bindings for
 MT8365 SoC
Message-ID: <20220811090249.ymetmw5xacc2dhin@blmsp>
References: <20220811084433.2598575-1-msp@baylibre.com>
 <20220811084433.2598575-2-msp@baylibre.com>
 <efe20cbf-485c-548c-933c-ffddb6c81d02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efe20cbf-485c-548c-933c-ffddb6c81d02@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 11, 2022 at 11:50:05AM +0300, Krzysztof Kozlowski wrote:
> On 11/08/2022 11:44, Markus Schneider-Pargmann wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add the clock bindings for the MediaTek MT8365 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  .../bindings/clock/mediatek,mt8365-clock.yaml |  42 ++
> >  .../clock/mediatek,mt8365-sys-clock.yaml      |  47 +++
> >  .../dt-bindings/clock/mediatek,mt8365-clk.h   | 374 ++++++++++++++++++
> >  3 files changed, 463 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8365-clock.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml
> >  create mode 100644 include/dt-bindings/clock/mediatek,mt8365-clk.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8365-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8365-clock.yaml
> > new file mode 100644
> > index 000000000000..31cd248e772b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8365-clock.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/clock/mediatek,mt8365-clock.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> No quotes needed in both lines.
> 
> > +
> > +title: MediaTek Functional Clock Controller for MT8365
> > +
> > +maintainers:
> > +  - Fabien Parent <fparent@baylibre.com>
> 
> Are you sure this is correct and working email? Let's try not to add
> non-existing emails to Git maintainers. It's a bit of pain to fix it
> later. :/

thank you, good point. I will fix everything you mentioned here and
above and below for v4.

Best,
Markus

