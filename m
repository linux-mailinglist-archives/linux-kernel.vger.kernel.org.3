Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7650C64E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiDWCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiDWCFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA09BB9;
        Fri, 22 Apr 2022 19:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC058B8321B;
        Sat, 23 Apr 2022 02:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCE5C385A0;
        Sat, 23 Apr 2022 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679338;
        bh=fXgFLAhzN5Q2JTBE1pkW4tLPG1dPXt9eK/EpN+mHbbA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=S5RTchA+DHkFfl58qbTiHwUByXGgnq6Wa5EAIGROkk/bupzj5Tny5lVMvncPDhtP6
         AExYXaDZwjZWgc1e+6vh+dUMFWvo/l6X03XEwnpOpHexiyelokt9W+h6ul7SbemnOE
         1d65O58+LZQfbrjN5BNjPXzQcs4zetl8jBsYl/6k5CSv9qaUCo27tel5qohNI3hT7s
         9Y+6gNt/TexCDz76qSV5b1iPkpEq8HnoVVgqf203AOWYRi/bG4uWIjCD8Ote74hGWL
         J1uI1xFPpBEtDxqB9fEt6ndCcE0jz0XLFz7FkUuVuSOH00JyRsqoj5CYRto4ECS50C
         6pph+X8jqMNgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220418110455.2559264-1-chi.minghao@zte.com.cn>
References: <20220418110455.2559264-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] clk: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Fri, 22 Apr 2022 19:02:16 -0700
User-Agent: alot/0.10
Message-Id: <20220423020218.8DCE5C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-04-18 04:04:55)
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/clk/clk.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed119182aa1b..544e940bf40b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -113,12 +113,8 @@ static int clk_pm_runtime_get(struct clk_core *core)
>         if (!core->rpm_enabled)
>                 return 0;
> =20
> -       ret =3D pm_runtime_get_sync(core->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(core->dev);
> -               return ret;
> -       }
> -       return 0;
> +       ret =3D pm_runtime_resume_and_get(core->dev);
> +       return ret;

	return pm_runtime_resume_and_get()

? I got it.
