Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F335AEEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiIFPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiIFPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:25:17 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BEBBE4CE;
        Tue,  6 Sep 2022 07:36:47 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11eab59db71so28535268fac.11;
        Tue, 06 Sep 2022 07:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/kxQ4Wf8GnR3MVwBOujAJ+Hv9NvGQDMILNpayVx9ZUo=;
        b=2SANE9NwV3Yzqba0zwxkhnKlSQahkYqxEAgljBH/INGryEp6ZN/cnszPr1QN0+5qk6
         tW0WO2+y1gipJMk2KuDDL2ShZeX5uVMKP2+UuFxhoMWGkVV+b5SI24SWet1RuF3xuedz
         nDI6wa4iPUVM5jaYmDd3JhhzfDYzWpo9em6eaPYnf9IkIod4893OQTrxSb0GhUzHNgmy
         f+iT3akMa+BTPWBxT/SUQohB9N+npFRmb/47r1ulItomFSChgkX6n1oEs1hT0/HfuB1E
         MBImmrd4juGIjItQ0yuNcUki4GXQMojCsZNMIEPqFtLm8Z0ri2+R+d4ZEt9VquJhILy8
         K4pg==
X-Gm-Message-State: ACgBeo3YvHMWahyN8mwpeqFL2wSvqXn1hL0mY7TMI/7ufmFCjfaBTglf
        jXMxDg/gzKHvvNSVoXcgdQ==
X-Google-Smtp-Source: AA6agR6/8rkfV5hK1hzRmCIqS5PFSgyizUYdaaaJmNYKCFgBxD4OCF+1PwIGz3teG7GN32hHgOxiaw==
X-Received: by 2002:a05:6870:6314:b0:10b:9595:62db with SMTP id s20-20020a056870631400b0010b959562dbmr11632116oao.128.1662474912399;
        Tue, 06 Sep 2022 07:35:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a3-20020a056870a18300b001278a63bfc9sm2169288oaf.1.2022.09.06.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:35:11 -0700 (PDT)
Received: (nullmailer pid 456502 invoked by uid 1000);
        Tue, 06 Sep 2022 14:35:10 -0000
Date:   Tue, 6 Sep 2022 09:35:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Alistair Francis <alistair@alistair23.me>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mfd: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220906143510.GA454672-robh@kernel.org>
References: <20220823145649.3118479-4-robh@kernel.org>
 <YxYH+POIURB9RO7T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYH+POIURB9RO7T@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 03:37:15PM +0100, Lee Jones wrote:
> On Tue, 23 Aug 2022, Rob Herring wrote:
> 
> > In order to ensure only documented properties are present, node schemas
> > must have unevaluatedProperties or additionalProperties set to false
> > (typically).
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../mfd/allwinner,sun6i-a31-prcm.yaml         | 40 +++++++++++++++++++
> >  .../mfd/allwinner,sun8i-a23-prcm.yaml         | 10 +++++
> >  .../bindings/mfd/cirrus,lochnagar.yaml        |  5 +++
> >  .../devicetree/bindings/mfd/dlg,da9063.yaml   |  7 ++--
> >  .../bindings/mfd/gateworks-gsc.yaml           |  5 ++-
> >  .../bindings/mfd/maxim,max14577.yaml          |  1 +
> >  .../bindings/mfd/maxim,max77843.yaml          |  1 +
> >  .../bindings/mfd/rockchip,rk817.yaml          |  2 +
> >  .../bindings/mfd/silergy,sy7636a.yaml         |  1 +
> >  .../bindings/mfd/st,stm32-lptimer.yaml        |  4 ++
> >  .../bindings/mfd/st,stm32-timers.yaml         |  3 ++
> >  .../devicetree/bindings/mfd/st,stmfx.yaml     |  1 +
> >  .../bindings/mfd/stericsson,ab8500.yaml       | 22 ++++++++++
> >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  1 +
> >  .../bindings/mfd/x-powers,axp152.yaml         |  1 +
> >  15 files changed, 100 insertions(+), 4 deletions(-)
> 
> What are your plans for this set?
> 
> Want me to merge it?

Yes, please.

Rob

