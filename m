Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A94897A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiAJLib convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 06:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244758AbiAJLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:37:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC30C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:37:30 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6szN-0007la-8z; Mon, 10 Jan 2022 12:37:25 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6szM-000B2v-AF; Mon, 10 Jan 2022 12:37:24 +0100
Message-ID: <c88e81067826f04e2301b52eddb84ec84bbd1c9d.camel@pengutronix.de>
Subject: Re: [PATCH v7 3/4] clk: ralink: make system controller node a reset
 provider
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Date:   Mon, 10 Jan 2022 12:37:24 +0100
In-Reply-To: <20220110111036.1380288-4-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
         <20220110111036.1380288-4-sergio.paracuellos@gmail.com>
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

On Mon, 2022-01-10 at 12:10 +0100, Sergio Paracuellos wrote:
[...]
> +static int mt7621_rst_xlate(struct reset_controller_dev *rcdev,
> +			    const struct of_phandle_args *reset_spec)
> +{
> +	unsigned long id = reset_spec->args[0];
> +
> +	if (id == MT7621_RST_SYS)

	if (id == MT7621_RST_SYS || id >= rcdev->nr_resets)

I forgot to mention that with .of_xlate set, the driver needs to check
whether id < nr_resets on its own.

regards
Philipp
