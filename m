Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5236F486FC8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbiAGBq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbiAGBqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80180C061245;
        Thu,  6 Jan 2022 17:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C5F61EA5;
        Fri,  7 Jan 2022 01:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB7C36AE0;
        Fri,  7 Jan 2022 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520013;
        bh=9Kg5n4ZOUJTxXcMjPnNz9VtaD4O7j1UtUbFnhINlySU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tx/K4xmqIjfZ3ybLw+8BpMjCt7U5jESX2rHUxQUkarENciQQIsHcbVhjkWPHFz2Yk
         wlgWWP7sBSDlAtlqEcXKvs5HcyIUKsdGbE0G0QhSfEF0PLkL2UL5+vXMsXke1DmW4E
         ofMB/B5ZTxgrUvjkcMy6Ni4BZwWwfBeUwiRCf7LC1pQT/OM4TpBnvCFAmDi9/RnLby
         Z72ycqtIvIXwTIqz4zYkZzNAK9B55LisSeQBJOw4ZM7HHejrxPFivXRHD1GogoTqkO
         mhUgedK+FZmGKeax+hxXTCAPeAUvxrEEg9sSiqkE2SEeAVrY0fFVqTL8/+qa4Sb/tK
         dGLfGWICYuXmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211223154244.1024062-1-conor.dooley@microchip.com>
References: <20211223154244.1024062-1-conor.dooley@microchip.com>
Subject: Re: [PATCH] clk: bm1880: remove kfrees on static allocations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daire.mcnamara@microchip.com, mail@conchuod.ie,
        Conor Dooley <conor.dooley@microchip.com>
To:     Mmturquette@baylibre.com, conor.dooley@microchip.com,
        linux-clk@vger.kernel.org, mani@kernel.org
Date:   Thu, 06 Jan 2022 17:46:51 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107014652.E7FB7C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting conor.dooley@microchip.com (2021-12-23 07:42:44)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> bm1880_clk_unregister_pll & bm1880_clk_unregister_div both try to
> free statically allocated variables, so remove those kfrees.
>=20
> For example, if we take L703 kfree(div_hw):
> - div_hw is a bm1880_div_hw_clock pointer
> - in bm1880_clk_register_plls this is pointed to an element of arg1:
>   struct bm1880_div_hw_clock *clks
> - in the probe, where bm1880_clk_register_plls is called arg1 is
>   bm1880_div_clks, defined on L371:
>   static struct bm1880_div_hw_clock bm1880_div_clks[]
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next
