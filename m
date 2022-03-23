Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C74E524F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiCWMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiCWMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:39:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C17B54D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=0tIk9V8VD5AtRCLLGr16uC8J1QyfJRaMrHIoDCtvAUw=; b=JxM+pbxpDceF19qUldOyoUWeHw
        TaMtGKOhzOL44VRCWkFKHRC6Xehodn1mGuNkRrfLBxi0rUESofO540+bJOJvnaErIgvwQLad1QHFY
        4YpZUOenCF3xgdzkAa44Nswj++HFg72J1WmbwcTtrPxiSlS3Pv1s30Ix1/Sa/eweyunY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nX0F2-00CHHR-PF; Wed, 23 Mar 2022 13:37:32 +0100
Date:   Wed, 23 Mar 2022 13:37:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     ryan_chen <ryan_chen@aspeedtech.com>
Cc:     BMC-SW@aspeedtech.com, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
Message-ID: <YjsUjB7vr1scHPVy@lunn.ch>
References: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
 <20220323004009.943298-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:40:09AM +0800, ryan_chen wrote:
> Add i2c new register mode driver to support AST2600 i2c
> new register set. AST2600 i2c controller have legacy and
> new register mode. The new register mode have global register
> support 4 base clock for scl clock selection, and new clock
> divider mode. And i2c new register mode have separate register
> set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/i2c/busses/Kconfig                 |   11 +
>  drivers/i2c/busses/Makefile                |    1 +
>  drivers/i2c/busses/aspeed-i2c-new-global.c |   91 ++
>  drivers/i2c/busses/aspeed-i2c-new-global.h |   19 +
>  drivers/i2c/busses/i2c-new-aspeed.c        | 1698 ++++++++++++++++++++

I always find it funny when somebody uses 'new'. What is the next
version going to be called? 'even-newer', and the version after that
'really-really-new'?

> +static const struct of_device_id aspeed_new_i2c_bus_of_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-i2c-bus",
> +	},

Given this compatible string, why not call it i2c-aspeed-2600.c, and
remove 'new' everywhere.

       Andrew
