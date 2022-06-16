Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6FD54D763
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbiFPBvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350856AbiFPBui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA2583AB;
        Wed, 15 Jun 2022 18:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E942F61CF6;
        Thu, 16 Jun 2022 01:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC31C3411E;
        Thu, 16 Jun 2022 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344231;
        bh=mF0NndCR6m2d49GRqn5l9HYgTOrCNWb0rl8SH0KCYY4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=opLJdMyu8LUgCovtfIzecb3R3SgxjUiw3Rv1gfluPdDdXn1T+IVznD78Vg1Jq/O7h
         v5MKxaYs96WBoPOLxfwEmZgPmb2X2dSmCeh79wkVLGWvNBy5GYe8e2j0ivltoCNlZm
         iBAJmRdSGtO4tg4BmQ5gOpTBhOUsBFx/7hpXhj8f+HO0Kc2HORVRvIh4ycwklkVpp2
         DWECHtysvSumzPdhLruMeOYXYo4DDcfbQoDARgW8YVnAPNCPpWGTV1D7Z+0WMyntD2
         FImowNT/ADNvC2zdFJg8sq4Qtva9qfQVPtHLW2YLhqFNcWVJVHtBOANargIEElDbzh
         I+BS2zylGFcQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-3-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-3-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 02/19] clk: mediatek: reset: Fix written reset bit offset
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:50:28 -0700
User-Agent: alot/0.10
Message-Id: <20220616015031.4CC31C3411E@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:29)
> Original assert/deassert bit is BIT(0), but it's more resonable to modify
> them to BIT(id % 32) which is based on id.
>=20
> This patch will not influence any previous driver because the reset is
> only used for thermal. The id (MT8183_INFRACFG_AO_THERM_SW_RST) is 0.
>=20
> Fixes: 64ebb57a3df6 ("clk: reset: Modify reset-controller driver")
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
