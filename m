Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47054DA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358877AbiFPGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358520AbiFPGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:02:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768522B18;
        Wed, 15 Jun 2022 23:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C1FB82187;
        Thu, 16 Jun 2022 06:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3495EC34114;
        Thu, 16 Jun 2022 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655359345;
        bh=00EAwW//1VscB61KDtwzGbrMMRpyOV8rVPd5uHAJUSA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tI85vWgmxeOMOoAPo5FAcGbqauBSBfgd14PfKH3PIR7TrCMBhslJaYLlxM11nbVrg
         atFiqPwBpUrkz5PiOqYmk2ZF+Bs8l2q7UxeKXPgEc7Uy79jDFqlhyDMa06X0+fUdKX
         a5xwnpEvTcAW950UHhjt5lkEhMFLsmAbwKYTZWQzWip0l4vK6ZTK7GAFLqCbQvfm6k
         IY9nmh9YrZL/rS8F4xzRsR3qv+YE+0q7O1NGce93BEPD1jj9+r6vubJuVinmSzYe/p
         V1nOjN126xvsY2wJB9wAqVGmyNsyC97jw09jgTrCu6VzdXEYox0+gBjcCKfhp/U57p
         h+C5FPqXXYLwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220616032448.3974916-1-windhl@126.com>
References: <20220616032448.3974916-1-windhl@126.com>
Subject: Re: [PATCH v2] drivers: clk: (clk-nomadik) Add missing of_node_put()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
To:     Liang He <windhl@126.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Wed, 15 Jun 2022 23:02:23 -0700
User-Agent: alot/0.10
Message-Id: <20220616060225.3495EC34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same subject line comment applies here. Look at previous patches to the
file.

Quoting Liang He (2022-06-15 20:24:48)
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index bad2677e11ae..48d5772b36a5 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -99,7 +99,7 @@ static void __init nomadik_src_init(void)
>         if (!src_base) {
>                 pr_err("%s: must have src parent node with REGS (%pOFn)\n=
",
>                        __func__, np);
> -               return;
> +               goto out_put;
>         }
> =20
>         /* Set all timers to use the 2.4 MHz TIMCLK */
> @@ -132,6 +132,9 @@ static void __init nomadik_src_init(void)
>         }
>         writel(val, src_base + SRC_XTALCR);
>         register_reboot_notifier(&nomadik_clk_reboot_notifier);
> +      =20
> +output:
> +    of_node_put(np);  =20

tabbed incorrectly?
