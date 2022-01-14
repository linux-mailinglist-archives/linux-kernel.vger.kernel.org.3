Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3748E26E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiANCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiANCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:11:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7273C061574;
        Thu, 13 Jan 2022 18:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63204B82356;
        Fri, 14 Jan 2022 02:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C9C36AEA;
        Fri, 14 Jan 2022 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642126291;
        bh=ECoPZQ03l/tvX2xKpinnD5nyg0Av0Lc/GL7f/7msvYk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Euny0s5w8MF1IOzDdgvDtws8Pqxq9Z9km2iYH35+JIrxBIUoP+QgWU55BTQzdOIGR
         k1CG+9aFwEEMfNNBlHiRdXNr24G4aDyHWlpzkch9fsJPJQDI3ByeLYoazcYCKwITOe
         IxhMBZ7K0gg7AEBtuCQIauqreeSahazQMCflyrxMA3HA0Ysum8I6i9oEKzezKtAL6t
         Pt0GSvKpd1VfUc79MrjpibfgbL4OQTykQgJqYuno/ngUwxMtDbHARE/nDAB8Ck8p8Z
         bih9D+qOukKhZTmuxrygKndFVT6rSIpZekXHYYCQafvj8NXHlUxdr0yKwxCWtUyE7l
         Q7/PG/CobVryQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220110171000.24316-4-miles.chen@mediatek.com>
References: <20220110171000.24316-1-miles.chen@mediatek.com> <20220110171000.24316-4-miles.chen@mediatek.com>
Subject: Re: [PATCH 3/3] clk: mediatek: support COMMON_CLK_MT8192 module build
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Thu, 13 Jan 2022 18:11:29 -0800
User-Agent: alot/0.9.1
Message-Id: <20220114021131.1F7C9C36AEA@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2022-01-10 09:09:59)
> To support COMMON_CLK_MT8192* module build,
> add MODULE_LICENSE and include module.h.
>=20
> Cc: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Have you tried removing the modules? And then reloading them? I also see
that mtk_clk_simple_probe() doesn't actually unregister anything, it
just frees some allocations. Please fix this before making these
modules.
