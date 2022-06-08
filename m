Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09578543DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiFHUz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiFHUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D51E560D;
        Wed,  8 Jun 2022 13:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD4E61D03;
        Wed,  8 Jun 2022 20:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0B0C34116;
        Wed,  8 Jun 2022 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654721651;
        bh=RUk+itwOwVF8l2xCM423N6uM+sqHzQaM+YenpOunTws=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oQowC7y06ysBJNPF2/ETt/N534MFoEExLmnlCm5u4LG/XtICZ2jWGgV25WFPu9MCq
         gvDB1lFP3g6Io3iKbL2nZwTwYTuk8fgJJEAymG6s4OSbz0I4zy4uk1C7n4lz3vX3uo
         DfU0ItZuil3Bwr+i8boIPgTPufnZtGnXmaYY7AnkP5CiXYC7VicIP85oozRC8vUdp8
         ZAFX6BYxbLrVHUC9L9tNnCwGSV4zz6Ms2ISPfhSvQHTKm067UnznvlCKcf3nfCgcl8
         aRjzw1tZNHZYuSNpoitWHU7SztQHk+5ojh1W/ivrOAxJUWyZ5liSgaTL/ar9E7asF4
         iU+CQ05n3OQVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220606212112.3617731-1-bjorn.andersson@linaro.org>
References: <20220606212112.3617731-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 08 Jun 2022 13:54:09 -0700
User-Agent: alot/0.10
Message-Id: <20220608205411.2B0B0C34116@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-06-06 14:21:12)
> When a GDSC is found to be enabled at boot the pm_runtime state will
> be unbalanced as the GDSC is later turned off. Fix this by increasing
> the usage counter on the power-domain, in line with how we handled the
> regulator state.
>=20
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain suppo=
rt")

Is it fixing a regression to the point that I need to merge this on
-fixes? The commit text talks about fixing it but I don't understand the
urgency, i.e. was it discovered recently and this fixes display on some
board or something like that?

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 44520efc6c72..a1fa7c4cff60 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -420,6 +420,9 @@ static int gdsc_init(struct gdsc *sc)
>                                 return ret;
>                 }
> =20
> +               /* ...and the power-domain */
> +               gdsc_pm_runtime_get(sc);

Shouldn't we check for error and bail out if it fails?
