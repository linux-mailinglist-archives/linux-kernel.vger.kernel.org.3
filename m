Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08358585762
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiG2Xl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiG2XlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:41:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65474349;
        Fri, 29 Jul 2022 16:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A29B82A07;
        Fri, 29 Jul 2022 23:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1F9C433D7;
        Fri, 29 Jul 2022 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659138081;
        bh=4+EkarCy89gK1+2w7AQftCu8+S5fGMb83z7dEUIiXOE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GOZWVzk7d3J6nYjVSRz85NkTzdsL6jKyMZUilc9VqjdvCxKp2asJ9swXC7v6c2aUG
         TFVUv989BaI2SbUoKdqN1h5Lu4uWz1v2O4UYZyMIj/MkN2ZXQfioqAdQ4YCC3jde7f
         KHmpNY9al8F3CxJtCaNR0gIMxoGgE2D8AgFQmb9RTmT/1SN83FmJwsP7wnIBnQtYcM
         lqIDPSrw5gjsM1wcDf1Qw0WUB2xzKK+JStxtOeMF8oJtBFHGY8BKo9hQtJ8lADzyuJ
         B+fnHDmRi4wCVWQuF1z7Zexou7RWP27IKr8obtOyY7lqF9O/2TcGVOB6ouiAPZoqkt
         QrSOhfsc2LlZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <192c5f16-8415-dfa1-39d2-8b404553ecd7@linaro.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org> <192c5f16-8415-dfa1-39d2-8b404553ecd7@linaro.org>
Subject: Re: [PATCH v3 00/11] drm/msm/dsi_phy: Replace parent names with clk_hw pointers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Date:   Fri, 29 Jul 2022 16:41:19 -0700
User-Agent: alot/0.10
Message-Id: <20220729234121.9F1F9C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-07-14 03:19:12)
> On 30/06/2022 01:53, Marijn Suijten wrote:
> > Marijn Suijten (11):
> >    clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
> >    clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
> >    clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw=
()
>=20
> Stephen, do we stand a chance of landing patches 1-3 into 5.20? We would =

> like to merge the series into 5.21 through the msm-next. Landing clk=20
> patches in 5.20 would save us from using immutable branches, etc.
>=20

Sure I can land the first three patches now for 5.20
