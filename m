Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651BB49973B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447718AbiAXVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358210AbiAXUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:43:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E270EC04188A;
        Mon, 24 Jan 2022 11:53:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA40CB810BD;
        Mon, 24 Jan 2022 19:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C97C340E5;
        Mon, 24 Jan 2022 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643054021;
        bh=yLbz/AC2wjap7OdNsxdmDXBEPOrm5DJ62HNkpKHDaRE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YqP+5Pu8CLPGLQYonv8c5mI2Wp6Turrr2DjU4sM5owJF/mETT2Y3RvkrrfSMAhUK3
         QcCdA7tDxRBj6ZBuxFD315wp5Hsv+1lPeSvDH2xoHVGtOXwFhpFEyjMZbLWr3TX+gZ
         AaJ+6bctkogAfKT2Q4HXAnzAdbeRHEA9uZ+hnt163ovtT2IwYFCruVHwMq59L4WYst
         vEos8xNT4eX7/HE8IHVMQFU7TKiZyHTWc82s4kIRkIeyTiSe49MaLVqLwM7BOm69Nb
         5MmcjYS6JFe3icdc9Lvanvyju1XBpw15/OZX/HNxXMCphCIVSb6yuT2RkhoFUE9/0P
         u3vWaw7IKw94A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220124165316.55449-1-zhou1615@umn.edu>
References: <20220124165316.55449-1-zhou1615@umn.edu>
Subject: Re: [PATCH] clk: socfpga: Fix a memory leak bug in socfpga_gate_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kjlu@umn.edu, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     zhou1615@umn.edu
Date:   Mon, 24 Jan 2022 11:53:39 -0800
User-Agent: alot/0.10
Message-Id: <20220124195341.50C97C340E5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Qingyang (2022-01-24 08:53:16)
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gat=
e.c
> index 53d6e3ec4309..0ca5e0000925 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -188,8 +188,10 @@ void __init socfpga_gate_init(struct device_node *no=
de)
>                 return;
> =20
>         ops =3D kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
> -       if (WARN_ON(!ops))
> +       if (WARN_ON(!ops)) {

A WARN_ON() after an allocation failure will lead to double stacktraces.
Can you remove the WARN_ON()?

Furthermore, it looks like 'ops' is never freed on failure in this
function. Did the SA tool figure that out? There are more problems with
this function and error paths. Seems like nobody cares.

> +               kfree(socfpga_clk);
>                 return;
> +       }
>
