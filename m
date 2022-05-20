Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8B52EB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbiETMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiETMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982ED1498C3;
        Fri, 20 May 2022 05:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C24161DFA;
        Fri, 20 May 2022 12:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A87DC385A9;
        Fri, 20 May 2022 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653048198;
        bh=387K16xk7F07P+mVdomJn7VVO3JUePVAb1FehJf0grw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWXK27ij1Y5VZ732mGSwahDUXfniztdn3J0KVqAlHnkGLAcyA9wBVpOy6fQb1nBG1
         YkGbRDDCWYteE3/r1E4dDZ5wGckxtj89PGm0Fy5Hi05swie5t3XCH5mlNi0sV3kqI5
         ASAPPCvENsVvF7TDYl7WlVnoGaH7JKYFsPauJWSwq8voFzDByrsDtN1E8HeHY94o37
         S96JwGiBItKQ8erAfGAhXXXzcAWd/oEaSfPKJCz7CCUyIqdj/+AGXHISgmiha+AIHa
         T3RKj8aShzUYXckY9TbuEtGAcGh3pDTGMzhz486ikm6GjzaZaqmMZT6FNi2drRnBJk
         qtMmXytMDOvPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns1Li-0005yv-8Z; Fri, 20 May 2022 14:03:18 +0200
Date:   Fri, 20 May 2022 14:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: gdsc: add collapse-bit helper
Message-ID: <YoeDhpCzV2sR7+Y1@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
 <20220520100948.19622-2-johan+linaro@kernel.org>
 <CAA8EJpr3_+iS_ntG0pgfG647Ou4Q60sk+-Roc9GJ-0qM5W710g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr3_+iS_ntG0pgfG647Ou4Q60sk+-Roc9GJ-0qM5W710g@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:50:17PM +0300, Dmitry Baryshkov wrote:
> On Fri, 20 May 2022 at 13:10, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Add a helper for updating the SW_COLLAPSE bit during initialisation and
> > state updates.
> >
> 
> 
> > Note that the update during initialisation was relying on the
> > SW_COLLAPSE bit not having been set earlier rather than passing in zero
> > explicitly to clear the collapse vote.
> 
> I think this part deserves a separate commit with proper Fixes: tag.

No, it's not a bug. The value passed in is explicitly set a bit higher
up in the same function so that the SW_COLLAPSE bit is (currently) never
set.

It mostly just looks weird and probably wasn't intentional.

> > @@ -425,8 +437,7 @@ static int gdsc_init(struct gdsc *sc)
> >                  * If a Votable GDSC is ON, make sure we have a Vote.
> >                  */
> >                 if (sc->flags & VOTABLE) {
> > -                       ret = regmap_update_bits(sc->regmap, sc->gdscr,
> > -                                                SW_COLLAPSE_MASK, val);
> > +                       ret = gdsc_update_collapse_bit(sc, false);
> >                         if (ret)
> >                                 return ret;
> >                 }

Johan
