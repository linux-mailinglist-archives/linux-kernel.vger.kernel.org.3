Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8558E4FFBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiDMRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiDMRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:02:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F91BEA7;
        Wed, 13 Apr 2022 10:00:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so3207479edv.1;
        Wed, 13 Apr 2022 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlQ+pyRwe7qHszIiHVeIqVG2GBzeusjMOdi25t/1dbg=;
        b=BDvmBiS2gYedfQA2KXmxPJAL1lMWmhK6f8oQN6Kz/fvX4fDJSe5yGvVMvDjhKRjV31
         QHnRJ96yYht1eMZIw87RIcDWQnRtH1paF67z7mYeyQyINTEtxPMvDmoqbZSpH3C1tnLx
         qmw1tKv7O4cnKoD2+oSgIPgu+GDmoGoXB8SAQosGbT0nt9vTmctp/gPpahD4PUt/CarL
         L0EDaKyBTvIpTM9Ja2exmQsDC2o7n65ZcrKCWQ56Z3uBmhL2gSf7SmdZhGFGhHLV1JFw
         POgmf6NIs+6BQvgAQDCN8nVGJBn2so7VEJ7nShnBq1YYUzLKB69+z3f59N8MyVZGhx1K
         1sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlQ+pyRwe7qHszIiHVeIqVG2GBzeusjMOdi25t/1dbg=;
        b=f5gQdh/AF/8GNVeqMyjDzzKbCuAe1TMzoQf5n+9svW8wdABpg71w9wrq2x+KOx85h9
         AdzHCfgYoU3owiezNw0eG8QvoSllerqHsOm8NYNyuUYelzi2H0co/8CQEiGV5MzLrg7m
         vxajaICQKkBx9qe9szeHsF7rDMuIHDeNQMLGEJ6KPE5OrPAsoAf0ybLnoM+ZCKmOtmGW
         dj+8OqbRgwycGWKKn8zZzjgMnIhvZi5CC0cGDvX0NwuQ/Vb+ai+u60SS46USKkCwdPbX
         5E3fHsAcsHpibZDNFz1wYM53riGoT5I1bk2joBszdBvEbtdVoF6YR2TpY2Z2qRYyjJi0
         7TtA==
X-Gm-Message-State: AOAM533ZkowOc2BfHno64c75AdYxkgk65ElO8kN2QrK6WxEB+gm9lsOG
        laaRlAVDQRKtQlxLM1DHAos=
X-Google-Smtp-Source: ABdhPJwy+Dys3iMoOhXVWrnmlUQTYocjmBYLYWmiTaWOy2UFycV6wC/zhJ6z3ewvvfPNHNXno43nAQ==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr44262449edt.62.1649869208260;
        Wed, 13 Apr 2022 10:00:08 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.retail.telecomitalia.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm1425800edz.35.2022.04.13.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:00:07 -0700 (PDT)
Message-ID: <62570197.1c69fb81.c3de2.7b70@mx.google.com>
X-Google-Original-Message-ID: <YlcBlmQHjwylg8XX@Ansuel-xps.>
Date:   Wed, 13 Apr 2022 19:00:06 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-4-ansuelsmth@gmail.com>
 <20220325011037.03173C340EC@smtp.kernel.org>
 <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
 <20220325012231.899FBC340EC@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325012231.899FBC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:22:29PM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-24 18:13:49)
> > On Thu, Mar 24, 2022 at 06:10:35PM -0700, Stephen Boyd wrote:
> > > Quoting Ansuel Smith (2022-03-21 16:15:33)
> > > > PXO_SRC is currently defined in the gcc include and referenced in the
> > > > ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
> > > > panic if a driver starts to actually use it.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > 
> > > What is this patch about? clk providers shouldn't be calling clk_get().
> > >
> > 
> > If pxo is passed as a clock in dts and defined as a fixed clock, what
> > should be used? 
> 
> clk_parent_data

Sorry but I'm not following you. No idea if you missed the cover letter
where i describe the problem with PXO_SRC.

The problem here is that
- In DTS we have node that reference <&gcc PXO_SRC>
But
- gcc driver NEVER defined PXO_SRC
As
- PXO_SRC is actually pxo_board that should be defined as a fixed-clock
  in dts or is defined using qcom_cc_register_board_clk.

So in theory we should just put in PXO_SRC the clk hw of the
fixed-clock. That is why I'm using clk_get(). I can use __clk_lookup()
as an alternative but I really can't find a way to get the clock defined
from DTS or qcom_cc_register_board_clk.

(I have the same exact problem with the cpu qsb clock where is defined
using fixed-clock API but can also defined directly in DTS and I have to
use clk_get())

I'm totally missing something so I would love some hint on how to solve
this.

-- 
	Ansuel
