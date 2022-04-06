Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D34F6426
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiDFPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiDFPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:53:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEC58F736;
        Wed,  6 Apr 2022 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=94sQlQmKAhs+bhZl9YeISZUchG1U5ciTRG/I6OMRF+E=; b=2mWpJbh/i+hFie80O/CmsQdpfd
        XAejkE9gd5BDMAg12TWppD0Ul7D43s3rge8vIfIpv8UIH3kcw2A3W0bg+n6YOyG985IhwzfpYNzyU
        scYJqqfIDqGUG/y9WFhaR+94GgCoBNB3OaZa7JZwqGyoBukl8AfnHuQ8qBNMz7fIWuUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nc4ti-00ERc1-7z; Wed, 06 Apr 2022 14:36:30 +0200
Date:   Wed, 6 Apr 2022 14:36:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Message-ID: <Yk2JTo91sZHunEpN@lunn.ch>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
 <20220406032158.1449049-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406032158.1449049-3-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:21:56PM +1200, Chris Packham wrote:
> This pinctrl driver supports the 98DX25xx and 98DX35xx family of chips
> from Marvell. It is based on the Marvell SDK with additions for various
> (non-gpio) pin configurations based on the datasheet.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     Changes in v3:
>     - Use mmio instead of syscon

Hi Chris

syscon is used when the register space is shared with other
devices. Is that not the case here? You can share mmio spaces, but you
have to use the correct call to reserve it, so that the system knows
it is to be shared. Or are all the pinctl registers contiguous and you
are only reserve just the registers you need, leaving other drivers
fee to take what they need?

I'm just trying to ensure you are not going to have trouble later when
you add other drivers.

    Andrew
