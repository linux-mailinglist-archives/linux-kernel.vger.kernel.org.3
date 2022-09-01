Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F85A8AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiIAB3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiIAB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F71153D33;
        Wed, 31 Aug 2022 18:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E195861D22;
        Thu,  1 Sep 2022 01:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45693C433D6;
        Thu,  1 Sep 2022 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661995718;
        bh=GdY+/WhNnxMBxT1u2ZfEAT+m15TaeLBnpOQgS872pOY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GZ+xcwtjRhXnVJ+WjYhwldS8y/NR0xSXsD4LgMhJTLXczvv1OpyttXx1d3GD3X4MS
         OVM1H3zsjsKHwQg6fnXLAIcoYPts527spMxuqe1uaJ/oMLlkzfD/vu5eHoSDLWM3Zw
         W7EQmddsGuGhYt5QDwHWgF3Iezdu7p6cruVSnj/AR12BbHloFbk6kVegMIkZy+YeCr
         Lib0CaowsURlzS6qebrd8oviqiBRlQ1/o13Oi6l3E6NNRyocRu5xhVEjBKWNfzHudL
         Bvs1c90OMswSLmErkFnYyhie7uXuJ+FI/sideAg+C0oL3QYUfsFHqm0WS1NN8mksOV
         WBpOefcfIGn9Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220617122254.738900-1-aidanmacdonald.0x0@gmail.com>
References: <20220617122254.738900-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2] clk: ingenic-tcu: Properly enable registers before accessing timers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     paul@crapouillou.net, paulburton@kernel.org,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com
Date:   Wed, 31 Aug 2022 18:28:35 -0700
User-Agent: alot/0.10
Message-Id: <20220901012838.45693C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-06-17 05:22:54)
> Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
> so the stop bit can be cleared before accessing a timer channel, but
> those functions did not clear the stop bit on SoCs with a global TCU
> clock gate.
>=20
> Testing on the X1000 has revealed that the stop bits must be cleared
> _and_ the global TCU clock must be ungated to access timer registers.
> This appears to be the norm on Ingenic SoCs, and is specified in the
> documentation for the X1000 and numerous JZ47xx SoCs.
>=20
> If the stop bit isn't cleared, register writes don't take effect and
> the system can be left in a broken state, eg. the watchdog timer may
> not run.
>=20
> The bug probably went unnoticed because stop bits are zeroed when
> the SoC is reset, and the kernel does not set them unless a timer
> gets disabled at runtime. However, it is possible that a bootloader
> or a previous kernel (if using kexec) leaves the stop bits set and
> we should not rely on them being cleared.
>=20
> Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
> clear the stop bit, regardless of the presence of a global TCU gate.
>=20
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Fixes: 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Applied to clk-fixes
