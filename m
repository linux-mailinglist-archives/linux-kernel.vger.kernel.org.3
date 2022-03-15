Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3C4DA20E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350935AbiCOSIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbiCOSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:08:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48659A63;
        Tue, 15 Mar 2022 11:07:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso1667290wms.0;
        Tue, 15 Mar 2022 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhSsINVlwXLLBcp3OnFMhpt1jlfDckhvpgIf2jdcb1o=;
        b=o+wsMnSnL9Nkp2iGsMlj+T3l6jpmFOm5WrJ0IO2VmNpPZmrNyxfUqbQN/vu5/1Lwlx
         Rg2EWB4PPwc8nuh//fsDGctU5E/HrJfh2jjwhyQcSphFBR/sidiRpGYH4qesRfPgdzEH
         C+VWEQdLkceh3TJV/sF0PeU/ec5of3dLGuitfgY8Gqz1o304hJV5uqWSH2oY00zg1n+x
         BCvdFFgnSnukBGPQtBrboTTBGMvJvAUHPV3UPTN1ZqUPBdWbr9NJ/DtSXs9CZucUwCEx
         n8195RC3f2IlwpX5Lx9DkUkLMdce+P8kuSOrqKWybCNpANuK5cMEw9Z+t4HE0ILiWbh8
         6qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhSsINVlwXLLBcp3OnFMhpt1jlfDckhvpgIf2jdcb1o=;
        b=1CoqMjAyN9Psxr5IS6UUzC/PDwjz8QebrEEcMYE25t8ASbnYwWjSEKmbM+IEwA0qJD
         6YdM/MzNHk56sCz0ZPlM6W6MKRSMAspfAXZvYVv6SixwOA0fHKHX+Fyj1SpecN+EeJAD
         7f4HUOYE/Kr7sHYRtCJBsfV5HT5Ykjcn1sSorzpIL4q6R+KT2uwpa1gNmm5VLXfncWuI
         LIGUeyAfeLO96V2sMok3gL2nIgaesMZmqw4BQ7jQl78uptTLxK/2dWp6wPKKNPrI1oEx
         D1WOaeCqcpWtGrVcw/e7dw3NQDWHZF6uArUlgKzkOOweJ8ax2BFT3rwVgzdGyCPLpkVU
         EKvg==
X-Gm-Message-State: AOAM532cJ0unu8vaOeFp0FBgeSOsfOungmE263OupJyLB0M7o4Zwjeao
        OeZAmayh6IKdaKD3HYV0U8I=
X-Google-Smtp-Source: ABdhPJz9D3ZEssyJ14TZeURLGApQMxBxM55YpUAMG4s1K8JyPegFak73PUb0NyPq7dSkksbvXbwCNQ==
X-Received: by 2002:a05:600c:154a:b0:389:d76c:8a07 with SMTP id f10-20020a05600c154a00b00389d76c8a07mr4289616wmg.60.1647367647927;
        Tue, 15 Mar 2022 11:07:27 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm3317197wmb.48.2022.03.15.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:07:27 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:07:26 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/16] clk: permit to define a custom parent for
 clk_hw_get_parent_index
Message-ID: <YjDV3n1Xq/EGWU1E@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
 <20220313190419.2207-2-ansuelsmth@gmail.com>
 <20220315175520.32E1AC340EE@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315175520.32E1AC340EE@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:55:18AM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-13 12:04:04)
> > Clk can have multiple parents. Some clk may require to get the cached
> > index of other parent that are not current associated with the clk.
> > Extend clk_hw_get_parent_index() with an optional parent to permit a
> > driver to get the cached index. If parent is NULL, the parent associated
> > with the provided hw clk is used.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/clk.c                 | 14 +++++++++-----
> >  drivers/clk/tegra/clk-periph.c    |  2 +-
> >  drivers/clk/tegra/clk-sdmmc-mux.c |  2 +-
> >  drivers/clk/tegra/clk-super.c     |  4 ++--
> >  include/linux/clk-provider.h      |  2 +-
> >  5 files changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 8de6a22498e7..fe42f56bfbdf 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1711,15 +1711,19 @@ static int clk_fetch_parent_index(struct clk_core *core,
> >  /**
> >   * clk_hw_get_parent_index - return the index of the parent clock
> >   * @hw: clk_hw associated with the clk being consumed
> > + * @parent: optional clk_hw of the parent to be fetched
> >   *
> > - * Fetches and returns the index of parent clock. Returns -EINVAL if the given
> > - * clock does not have a current parent.
> > + * Fetches and returns the index of parent clock. If parent is not
> > + * provided the parent of hw is used.
> > + * Returns -EINVAL if the given clock does not have a current parent.
> >   */
> > -int clk_hw_get_parent_index(struct clk_hw *hw)
> > +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent)
> 
> Please introduce another API vs. tacking on an "output" argument to this
> API. That makes the patch less invasive. And it can also return a
> pointer instead of an integer in that case.
>

Any suggestion about the name? clk_hw_fetch_parent_index? That would be
a direct access of the internal clk_fetch_parent_index.

The name is already not that intuitive as is. The alternative is to make
it extra long, don't know if that's a problem...
Something like clk_hw_get_parent_index_by_parent? (that is even more
confusing)

> >  {
> > -       struct clk_hw *parent = clk_hw_get_parent(hw);
> > +       /* With parent NULL get the current parent of hw */
> > +       if (!parent)
> > +               parent = clk_hw_get_parent(hw);

-- 
	Ansuel
