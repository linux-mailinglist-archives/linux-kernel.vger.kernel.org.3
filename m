Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E222C489504
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiAJJQY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 04:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbiAJJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:14:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D1C03327B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:13:29 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6qjz-0003vJ-SF; Mon, 10 Jan 2022 10:13:23 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6qjx-0005OS-Hr; Mon, 10 Jan 2022 10:13:21 +0100
Message-ID: <5368e89c391e1329ed2be6496655f1bb50acfd19.camel@pengutronix.de>
Subject: Re: [PATCH v6 3/4] clk: ralink: make system controller node a reset
 provider
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Date:   Mon, 10 Jan 2022 10:13:21 +0100
In-Reply-To: <20220110083910.1351020-4-sergio.paracuellos@gmail.com>
References: <20220110083910.1351020-1-sergio.paracuellos@gmail.com>
         <20220110083910.1351020-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio,

On Mon, 2022-01-10 at 09:39 +0100, Sergio Paracuellos wrote:
> +static int mt7621_assert_device(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct mt7621_rst *data = to_mt7621_rst(rcdev);
> +	struct regmap *sysc = data->sysc;
> +
> +	if (id == MT7621_RST_SYS)
> +		return -EINVAL;

Better implement the .of_xlate callback and check there instead.

That way it would fail on reset_control_get() rather than handing out a
valid reset controller that just doesn't work.

> +
> +	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
> +}
> +
> +static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct mt7621_rst *data = to_mt7621_rst(rcdev);
> +	struct regmap *sysc = data->sysc;
> +
> +	if (id == MT7621_RST_SYS)
> +		return -EINVAL;

Same as above.

> +	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
> +}
> +
> +static int mt7621_reset_device(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	int ret;
> +
> +	ret = mt7621_assert_device(rcdev, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mt7621_deassert_device(rcdev, id);
> +}

Is this known to work for all possible users, without delay between
assert and deassert?

Are there any users of the reset_control_reset() API at all? This API
was added for self-clearing reset bits, so if there are no users that
need to pretend this is a reset pulse at the hardware level (there may
be), I'd prefer if this was just left out.

Apart from this, this looks good to me.

regards
Philipp
