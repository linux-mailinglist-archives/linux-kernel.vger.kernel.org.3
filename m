Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD17558C58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiFXAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiFXAm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:42:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29B5DC3B;
        Thu, 23 Jun 2022 17:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68E5BB825EC;
        Fri, 24 Jun 2022 00:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4AC3411D;
        Fri, 24 Jun 2022 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656031345;
        bh=BXd6mNuTO38Gr+rR3vLh7boGa3CkYWlAtCfGyiaeWfs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GzMiO62sm6JX8hVZ6E+RNhLXMS9rOyaKKYtC0tlH7M773qBzASfpOMnnJkQTExzLA
         GiHw1Vz21XfkjRKoJBMY+9i/Fy4FFukCTIHKrS2xvxwatDBvLtpTQDzW2FUc5J5Zsv
         8jBrCocyGMFpwXDhhmTCV/T9yrR7+MZr5oC/NPE3cy8rDfqUoGlzdUYz2kN3fOmk0e
         /DYUHGfjxSija3Fn/aJODsJQWA4tjRKO8xsLNJaodEmluPtQwTG/briFcjePUyiQif
         IA5OAMj+pQtC7SstXhlzpUZWb3mGUh8g02hukWg5IfA18K4fi5DHg8qsFNwsLNjiEJ
         /EzdGyICNsv7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220623083217.26433-1-jslaby@suse.cz>
References: <20220623083217.26433-1-jslaby@suse.cz>
Subject: Re: [PATCH 1/2] clk: pistachio: Fix initconst confusion
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, linux-clk@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>, mturquette@baylibre.com
Date:   Thu, 23 Jun 2022 17:42:23 -0700
User-Agent: alot/0.10
Message-Id: <20220624004225.0DE4AC3411D@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiri Slaby (2022-06-23 01:32:16)
> From: Andi Kleen <ak@linux.intel.com>
>=20
> A variable pointing to const isn't const itself. It'd have to contain
> "const" keyword after "*" too. Therefore, PNAME() cannot put the strings
> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>=20
> [js] more explanatory commit message.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/clk/pistachio/clk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
> index f9c31e3a0e47..742e5fab00c0 100644
> --- a/drivers/clk/pistachio/clk.h
> +++ b/drivers/clk/pistachio/clk.h
> @@ -34,7 +34,7 @@ struct pistachio_mux {
>         const char **parents;
>  };
> =20
> -#define PNAME(x) static const char *x[] __initconst
> +#define PNAME(x) static const char *x[] __initdata

Can it be const char * const and left as __initconst?
