Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA84AA316
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349060AbiBDWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:21:45 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:38488 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348884AbiBDWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:21:44 -0500
Received: by mail-oo1-f48.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso6235636oon.5;
        Fri, 04 Feb 2022 14:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSSqlk1OwbpfMCFflvyzMx5ImvnYHmqQIDxXeCyLZws=;
        b=ih4pQoNFT9Q6Rsqbz7fay34HBoHssB7nOSF9OoueXB5jHmy5TMxNnO9z3FZ8IOdb11
         wbYj75HozNp15KEB8XwXTPst5+D1YcOqaD6NTqxiurmK/XvBkQh8IbNTtIkK4zPUDrVx
         G4KABHxDNt0DqleFAFqA+aP00G3+N/6FhRxgNGKuFz71PMrz79VO3+9+HxMWZ2JpZk8l
         1qrS8C/JMfTfBLEz/O8nxHx+6Cq5Hxyz2B2Sz29AgKoahN0J68o+Mk7JhztAw/ytJWcz
         irKdHhC4l3NYWmo08ftIBASb5nlK3BVVkiS7V+laWcki0xhPZsJAFvCYylVt6IuiYMJI
         f8Pw==
X-Gm-Message-State: AOAM533zEND7xMcCOEomcJCBM6576kHnRO0wlWN4A2o/OcxfUddgKG7K
        ajcR3XCl3VHxeyDDkAlxYw==
X-Google-Smtp-Source: ABdhPJzBiBKs5CGPfpkFRLuyyWzKtB05ObCQJbQKHDPTM77tzihcGsXN38Eqvb7S3cWiaJbAXwJdoQ==
X-Received: by 2002:a05:6870:a242:: with SMTP id g2mr1230497oai.305.1644013303426;
        Fri, 04 Feb 2022 14:21:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm1023373oan.11.2022.02.04.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:21:42 -0800 (PST)
Received: (nullmailer pid 3287001 invoked by uid 1000);
        Fri, 04 Feb 2022 22:21:41 -0000
Date:   Fri, 4 Feb 2022 16:21:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Lucas Stach <dev@lynxeye.de>, Yue Hu <huyue2@yulong.com>,
        angelogioacchino.delregno@collabora.com,
        Satya Tangirala <satyat@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: add cap-sdio-async-irq flag
Message-ID: <Yf2m9Y0DAo3rVlyR@robh.at.kernel.org>
References: <20220121071942.11601-1-axe.yang@mediatek.com>
 <20220121071942.11601-2-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121071942.11601-2-axe.yang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 15:19:40 +0800, Axe Yang wrote:
> Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> interrupt when host stop providing clock to card. Add a DT flag to
> enable this feature if it is supported by SDIO card.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
