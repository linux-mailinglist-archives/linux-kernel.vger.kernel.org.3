Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86158EB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiHJLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D4326C5;
        Wed, 10 Aug 2022 04:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394E16126D;
        Wed, 10 Aug 2022 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE2C433C1;
        Wed, 10 Aug 2022 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660130072;
        bh=fyh9Bh9bmCgOy+/VP4kXHpr57H4RuMtY6Hs0NyHqLSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJNPNe+7uX12c2FU6lGS5y3G33+MvpzrxwZqNjL11mn0aeHEDBf+6sPsrgvQ1DGS+
         GbkykfAsDj5ZxL6iyya3G/AiNTKjHTvQsbhSgNAZC5UGHJP6kJghHRTvhpRmuTFm4k
         4BbRnp+abhEitVbVF14lbhEbRHdlBNUVNIhHXr4LP+VgL8OKi9vsSWi3TqSZ4134E1
         FzQvE5MTCDxakTKDhajC0ZX971gR3Y7Kjl6sz4mHVSbL7s7ui2lmirSpZPAffeOv5m
         jib+/Hx6EAXjxeMc9ICm0gVpIMU37KqSRhl1ca/7HCYNVHv+LWpTRrm6OecSK+pD+w
         oJ8WP9q4UphyA==
Date:   Wed, 10 Aug 2022 12:14:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: fsl-imx25: Fix an error handling path in
 mx25_tsadc_setup_irq()
Message-ID: <YvOTEtEK5Urn+rvz@google.com>
References: <d404e04828fc06bcfddf81f9f3e9b4babbe35415.1659269156.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d404e04828fc06bcfddf81f9f3e9b4babbe35415.1659269156.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022, Christophe JAILLET wrote:

> If devm_of_platform_populate() fails, some resources need to be
> released.
> 
> Introduce a mx25_tsadc_unset_irq() function that undoes
> mx25_tsadc_setup_irq() and call it both from the new error handling path
> of the probe and in the remove function.
> 
> Fixes: a55196eff6d6 ("mfd: fsl-imx25: Use devm_of_platform_populate()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> mx25_tsadc_setup_irq() and mx25_tsadc_unset_irq() are not symetrical.
> One tests for "(irq <= 0)" while the other one tests for "(irq)".
> 
> If <0 the probe will fails, so that is fine.
> If ==0, according to doc platform_get_irq() can't return 0, so that should
> be fine as well.
> 
> 
> That said, I think that the "if (irq)" in mx25_tsadc_unset_irq() can be
> removed.
> ---
>  drivers/mfd/fsl-imx25-tsadc.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
