Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D786476A90
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhLPGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:45:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33726 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:45:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A55C61C4A;
        Thu, 16 Dec 2021 06:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50385C36AE2;
        Thu, 16 Dec 2021 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637156;
        bh=DAHiQZ/A9fSoAedgWlGLb4HM/aUKVwB/P8OFL5cQTpE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uzi1gsDjoSzvtQLPxTsFIOiMBj4s//5SeulcHvdqPHR9atceMdIJLt8sxPvBf24j1
         VLfOnw13I3CdNY9dT47QSX8zknqH0AEosCTpB7XAeVB5+XRMjtbRZZb4oS0vBml4U2
         2SzgVz0cm4QtDnDQliCeTk8oB3cNq27VqNilQCXwbYEAfCDrbDdqnZGqzhLH9COBhc
         yjTzT8VMeUQHyzu6wjpc6BMSga04o+zs/1+dlqNs67kMyByakhDU/y5bXCUx1uwhNn
         DbCXaobSA9y81til1dzqnK76XTqlp2hO6fz9q+BTjADqpPfOXsffUpX3238d/H8sTc
         qsHS6pzIfOhZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1635232282-3992-10-git-send-email-dillon.minfei@gmail.com>
References: <1635232282-3992-1-git-send-email-dillon.minfei@gmail.com> <1635232282-3992-10-git-send-email-dillon.minfei@gmail.com>
Subject: Re: [PATCH v7 09/10] clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after system enter shell
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     patrice.chotard@foss.st.com, hugues.fruchet@foss.st.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, lkp@intel.com, kbuild-all@lists.01.org,
        llvm@lists.linux.dev
To:     Dillon Min <dillon.minfei@gmail.com>, alexandre.torgue@foss.st.com,
        ezequiel@collabora.com, gabriel.fernandez@foss.st.com,
        gabriel.fernandez@st.com, gnurou@gmail.com,
        hverkuil-cisco@xs4all.nl, mchehab+huawei@kernel.org,
        mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        mturquette@baylibre.com, pihsun@chromium.org, robh+dt@kernel.org
Date:   Wed, 15 Dec 2021 22:45:55 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216064556.50385C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dillon Min (2021-10-26 00:11:21)
> stm32's clk driver register two ltdc gate clk to clk core by
> clk_hw_register_gate() and clk_hw_register_composite()
>=20
> first: 'stm32f429_gates[]', clk name is 'ltdc', which no user to use.
> second: 'stm32f429_aux_clk[]', clk name is 'lcd-tft', used by ltdc driver
>=20
> both of them point to the same offset of stm32's RCC register. after
> kernel enter console, clk core turn off ltdc's clk as 'stm32f429_gates[]'
> is no one to use. but, actually 'stm32f429_aux_clk[]' is in use.
>=20
> stm32f469/746/769 have the same issue, fix it.
>=20
> Fixes: daf2d117cbca ("clk: stm32f4: Add lcd-tft clock")
> Link: https://lore.kernel.org/linux-arm-kernel/1590564453-24499-7-git-sen=
d-email-dillon.minfei@gmail.com/
> Link: https://lore.kernel.org/lkml/CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDU=
jqFFwkOeQeFDg@mail.gmail.com/
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Acked-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
