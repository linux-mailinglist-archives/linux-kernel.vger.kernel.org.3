Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA24747F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhLNQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:26:46 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42741 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhLNQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:26:35 -0500
Received: by mail-oi1-f169.google.com with SMTP id n66so27783257oia.9;
        Tue, 14 Dec 2021 08:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ecdypzCN+U6v6zglYX7zDMYbOxt+qYg8f/j8Yv3wCxY=;
        b=bZxrep6ngD/i1owByFMTEi6DxrQ2TsUSApU1h6zDyEj3mvjqzA4oLU5yqR4yTmPEJ6
         Rfp19eqzpAqolUQyXbT7lgdgDeU3rthfEYM9SsB/8u8FEZG2VxQv2GGeXQh62/gqZtod
         JA/5n+GacWNoI4533+13fxSRwFo+VRZ03JhhjObfojlsgSdNsYpik+uNyjBtPTtYiZio
         6OltZJpmtjVVl9nwUyILS4sCzSwGRM4US60IevxXoLEpF735oQBmRmWcfdYi0gDNqhmQ
         RLq6thHmfepajWO0Vq996v/cM9BhMyFKjnxrqSfEVM3x57NRocQsIWR0NsLPtVYuoTLY
         HNNg==
X-Gm-Message-State: AOAM532rGPgX3K/rwL4RIU3ALqdLmK/Cszi7XMw/6pOfwS7WzgZ2VcLr
        bfJde4l/V4ChP/ER8ARb6w==
X-Google-Smtp-Source: ABdhPJyGSv7DXMKuwKAuUktDv2PCkL1nzWMMyeVxqFI6hpsoBQPH6hLLO1tq01FrxwqqJFeG4ib/gw==
X-Received: by 2002:a54:4701:: with SMTP id k1mr34049401oik.37.1639499194932;
        Tue, 14 Dec 2021 08:26:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm48314otj.24.2021.12.14.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:26:34 -0800 (PST)
Received: (nullmailer pid 3502704 invoked by uid 1000);
        Tue, 14 Dec 2021 16:26:33 -0000
Date:   Tue, 14 Dec 2021 10:26:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 2/4] dt-bindings: spi: add new clock name 'axi' for
 spi nor
Message-ID: <YbjFuQxL+Wp8tU6r@robh.at.kernel.org>
References: <20211211204014.8014-1-tinghan.shen@mediatek.com>
 <20211211204014.8014-3-tinghan.shen@mediatek.com>
 <YbdvIPq1hKPmKXXs@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbdvIPq1hKPmKXXs@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:04:48PM +0000, Mark Brown wrote:
> On Sun, Dec 12, 2021 at 04:40:12AM +0800, Tinghan Shen wrote:
> 
> > Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
> > for spi nor dma bus clock.
> 
> >    clock-names:
> > +    minItems: 2
> >      items:
> >        - const: spi
> >        - const: sf
> > +      - const: axi
> 
> This will cause any existing DTs that don't have both spi and sf clocks
> defined to fail to validate which doesn't seem great.

That was true before this. The default for 'minItems' is the number of 
entries in 'items' (this is not the default for json-schema, but default 
for DT bindings as that's the common case).

> Given that your
> commit message says this is only required for some SoCs shouldn't the
> minimum clocks requirement depend on which particular SoC/IP version is
> being used?  Not exactly sure how one specifies that in the YAML format.

With an if/then schema adding maxItems/minItems constraints (e.g. 
'maxItems: 2' for existing compatibles). There are many examples in the 
tree.

Rob
