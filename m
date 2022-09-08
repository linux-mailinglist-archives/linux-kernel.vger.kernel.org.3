Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FB5B15CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiIHHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIHHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204ACCAC55;
        Thu,  8 Sep 2022 00:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8DD61B53;
        Thu,  8 Sep 2022 07:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3CCC433C1;
        Thu,  8 Sep 2022 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662622709;
        bh=i5qqhT/s9Ggk4p3fn8CnlYBsV57UeiidnrYGpDC1bVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZUo61+XZEoxCjzVZHFuDXKFMQhDPaPJV4nMVyAsk5Kaa0/sPg2a4MB0fP7JB7T4J
         WejwW86nj9GMB3lnuAio/ASaS8fr5a4M/Rfsg3cFpSmwKgkNU6W7bLAEWtIXrJnRI7
         hJPn5yxm49BzwJ0Ofnzo+CRuksh4rpgdhCKWGI4eR3IWU1+j4zUgwv2HALejbGd5hb
         Qk+akS/oTtpedMgAwJs1r+d1eXS0UruUANBN6axsWG+Cy3jSJ1O97GIzMMn1YcYi+6
         H8mooIGtSKrlyF6E0Zym+xpNHU4wrX6kMEAb6z44jeBFNTeH9erMsKddkCk08eJzQK
         B48fmWAtltqxg==
Date:   Thu, 8 Sep 2022 08:38:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Martin Kaiser <martin@kaiser.cx>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: fsl-imx25: fix check for platform_get_irq() errors
Message-ID: <Yxmb7wTBRnRuasxI@google.com>
References: <YvTfkbVQWYKMKS/t@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvTfkbVQWYKMKS/t@kili>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022, Dan Carpenter wrote:

> The mx25_tsadc_remove() function assumes all non-zero returns are success
> but the platform_get_irq() function returns negative on error and
> positive non-zero values on success.  It never returns zero, but if it
> did then treat that as a success.
> 
> Fixes: 18f773937968 ("mfd: fsl-imx25: Clean up irq settings during removal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mfd/fsl-imx25-tsadc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
