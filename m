Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F54DD59C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiCRHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCRHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:53:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E232C80AE;
        Fri, 18 Mar 2022 00:52:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so15325230ejc.12;
        Fri, 18 Mar 2022 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A3PDqBaBritnZnP7hEtDx3b+3Mek9k1rJJXE3rj2Zy4=;
        b=ZhK7KU7qoYASv+l399eftSrF3wUXJ5oaN/qiNPQfLwsgtl9bq6qAPmuIwnb6gPn0ZB
         Qka724KGz5X2BfT0CpVuVLiUFF6ErQL4S44sSA2EAHDb58EiOtR+X0JhcrDOIOXDr7gZ
         24X0jJU6Yly36s/6hxxD/++HUaP3eTkFSPpOuS6E98ndLpNpbRxSjVUp4DiS19ZWMUMu
         GEZLON/wlJbHOJMBnDmO0miYuxztYiWcHQnwY9dXE4YRoHuXNZcfcHE6q90S0W4vd2s/
         E5402c4bkMQiR9GoAj6vmeD+s0x6iiyOSxfREREz7Q0DFX+fA5A5h/8+7LQmFhYyPip0
         XHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3PDqBaBritnZnP7hEtDx3b+3Mek9k1rJJXE3rj2Zy4=;
        b=HTbPdfVxetH/hc+154Zin+tBBX0PxOFfOrIXQJ58YaEU2nu4quEdl5tTkVZQDW/+LA
         mmVy1EBPGdSO64opkZOfJ5FwnU78ry6OGrA38S1zDq0d7YAYjbOfwXwHsgil6KT/dx/K
         QmFKuf5TDj151sWQGsah6ieqpppif7WZCHblXgBnzN4UscQ2lZT8TbmcWhIEULrpAgPv
         SElhUmzRcNbPsYG7dvepsISCcKG09pMtfC+nFsTyGo0em3/MKvffIkinAwTaXsdu5F43
         pH/cGGI/cwzlTmElQLzFOaX4w5YGDSoR8javkRvFMffdcfIi43RkINf8GWHowXlKONak
         I8ag==
X-Gm-Message-State: AOAM5308zdxQJxXrsRotPhMg5DLdo9dLYGDWlZ58lW1TfFYd0ynVYEWF
        mUxKCpHpca4hoMFQRXL7jlU=
X-Google-Smtp-Source: ABdhPJxVj9syTlN4gCx31UjIIGZaW675Iq81FFnD2LS0OTRzGHNcwcEKjUsDvxcdNAmVAaJyTmZAmA==
X-Received: by 2002:a17:906:4fd2:b0:6db:21ba:e434 with SMTP id i18-20020a1709064fd200b006db21bae434mr8090239ejw.714.1647589957791;
        Fri, 18 Mar 2022 00:52:37 -0700 (PDT)
Received: from ubuntu2004 ([188.24.153.122])
        by smtp.gmail.com with ESMTPSA id qw7-20020a1709066a0700b006dfa04dc2a4sm1534847ejc.56.2022.03.18.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:52:36 -0700 (PDT)
Date:   Fri, 18 Mar 2022 09:52:30 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Subject: Re: [PATCH 04/18] dt-bindings: irqchip: actions,owl-sirq: include
 generic schema
Message-ID: <20220318075230.GA15068@ubuntu2004>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
 <20220317115705.450427-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115705.450427-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:56:51PM +0100, Krzysztof Kozlowski wrote:
> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Thanks.

> ---
>  .../bindings/interrupt-controller/actions,owl-sirq.yaml      | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> index 5da333c644c9..c058810cf475 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> @@ -14,6 +14,9 @@ description: |
>    This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
>    and S900) and provides support for handling up to 3 external interrupt lines.
>  
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
>  properties:
>    compatible:
>      enum:
> @@ -46,7 +49,7 @@ required:
>    - '#interrupt-cells'
>    - 'interrupts'
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.32.0
> 
