Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97E52E141
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbiETAhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344047AbiETAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF3C5F8C5;
        Thu, 19 May 2022 17:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E0E3B82954;
        Fri, 20 May 2022 00:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B84C385AA;
        Fri, 20 May 2022 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653007032;
        bh=0bY4PP/8AE23cA6dggmSHDxNih0qmDn74hKayz9cuko=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U1ES1eNvNfodef0NPGGoxZi7d1qTexNseH49e3rlgRQh5jtEJjftmwG7JB9Lb6YQQ
         LbxArY6creVNgumubdeL3PZQunKY5oKiFJF8UNGF8bMZytfLketZNj7Rxx7XTnjiKB
         jUAyVyw9/ukrKyLWydEnpZjXyhs3hI+IDqoUC9r9mrmRHVmjHR7K7p+oyPnqKpF+tM
         kmvHuZfWdrLaduvcLAoRfhgPgRdHMoFiV7M6YWusylTzEVq2GONB6iuVecTeKTUIGw
         1vHDEtUqPzjC8Uw5PHywUAbqx4HFq8xqKBlaHgn7MG1pIFYhvlFY4mKS5ugWccvRO7
         mbcyAcCg4/S1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519071610.423372-3-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org> <20220519071610.423372-3-wenst@chromium.org>
Subject: Re: [PATCH v3 2/5] clk: mediatek: apmixed: Drop error message from clk_register() failure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 19 May 2022 17:37:09 -0700
User-Agent: alot/0.10
Message-Id: <20220520003712.13B84C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-19 00:16:07)
> mtk_clk_register_ref2usb_tx() prints an error message if clk_register()
> fails. It doesn't if kzalloc() fails though. The caller would then tack
> on its own error message to handle this.
>=20
> Also, All other clk registration functions in the MediaTek clk library
> leave the error message printing to the bulk registration functions,
> while the helpers that register individual clks just return error codes.
>=20
> Drop the error message that is printed when clk_register() fails in
> mtk_clk_register_ref2usb_tx() to make its behavior consistent both
> across its failure modes, and with the rest of the driver library.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
