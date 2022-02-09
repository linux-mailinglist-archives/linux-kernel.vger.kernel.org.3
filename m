Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F399F4AF5A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiBIPoN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiBIPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:44:10 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD40C05CB8F;
        Wed,  9 Feb 2022 07:44:13 -0800 (PST)
Date:   Wed, 09 Feb 2022 15:44:02 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/3] Clock fixes for Ingenic SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <EPN17R.TB21BVY3XDUH1@crapouillou.net>
In-Reply-To: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
References: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mar., févr. 8 2022 at 01:00:45 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> I ran across a problem trying to get Linux running on an Ingenic 
> X1000 SoC:
> since the memory clock isn't referenced by any driver, it appears 
> unused and
> gets disabled automatically. After that, the system hangs on any RAM 
> access.
> 
> There is a hack in board-ingenic.c to forcibly enable the CPU clock, 
> but this
> is insufficient for the X1000 since the memory clock has its own gate 
> and mux
> that isn't tied to the CPU.
> 
> This patch series fixes the bug by adding CLK_IS_CRITICAL flags to 
> important
> clocks, which seems to be the approach used in many other SoC clock 
> drivers.
> 
> It's my first time submitting patches to the kernel so let me know if 
> I
> messed anything up.

You did everything good.

I think the CI20 suffered from the same problem, it would only boot as 
long as the "clk_ignore_unused" flag was added on the command line. I 
will need to try it there to see if it improved the situation.

I tested the patchset on JZ4770 and it works fine. So:

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

@Stephen: I don't see any changes pending on board-ingenic.c so it 
should be safe for you to also take [PATCH 3/3] in the clk tree.

Cheers,
-Paul

> Aidan MacDonald (3):
>   clk: ingenic: Allow specifying common clock flags
>   clk: ingenic: Mark critical clocks in Ingenic SoCs
>   mips: ingenic: Do not manually reference the CPU clock
> 
>  arch/mips/generic/board-ingenic.c | 26 --------------------------
>  drivers/clk/ingenic/cgu.c         |  2 +-
>  drivers/clk/ingenic/cgu.h         |  3 +++
>  drivers/clk/ingenic/jz4725b-cgu.c |  2 ++
>  drivers/clk/ingenic/jz4740-cgu.c  |  2 ++
>  drivers/clk/ingenic/jz4760-cgu.c  |  2 ++
>  drivers/clk/ingenic/jz4770-cgu.c  |  1 +
>  drivers/clk/ingenic/jz4780-cgu.c  |  3 +++
>  drivers/clk/ingenic/x1000-cgu.c   |  3 +++
>  drivers/clk/ingenic/x1830-cgu.c   |  3 +++
>  10 files changed, 20 insertions(+), 27 deletions(-)
> 
> --
> 2.34.1
> 


