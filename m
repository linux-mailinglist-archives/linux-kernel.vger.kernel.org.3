Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BB54D774
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352376AbiFPBvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350843AbiFPBve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB258E53;
        Wed, 15 Jun 2022 18:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B1361CED;
        Thu, 16 Jun 2022 01:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5697EC341C0;
        Thu, 16 Jun 2022 01:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344288;
        bh=VHGuD3oUIVDRtnrxF+nkSpDbHsE8XAqaQQ+vQslwz24=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JBkr00yLx65g8QqtPLDb+l0cklP3maYgekq569wr7R3nmYSO1gLOvXunnsrAEZdiH
         AzmlXp/SGpXGfX9MLqakAzE2az8Shk1BGKg+IoPgWR1KQ/wJHjn6LghRyx7lG13EEW
         ZQQdCwGnZJw+HV4l3wOrrCqM10471yTtKQKrzWmvLMq5ZaViqJwMboJdWzZsQ4Ir6C
         G4NZ1CwP2Xz01PHkKO4LdwiMOgSOsLd9q0jV2Lgp+BHgUx76wCsNkE260NyjBZNcbI
         NQ+9itvcbWFDXwBrc60FortDi/gGWjVDgrcbj1fukyxpL2BnhjgpDNhe00HxxAoRC4
         y53lDX23NWIvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-6-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-6-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 05/19] clk: mediatek: reset: Merge and revise reset register function
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
Date:   Wed, 15 Jun 2022 18:51:25 -0700
User-Agent: alot/0.10
Message-Id: <20220616015128.5697EC341C0@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:32)
> There are two versions for clock reset register control for MediaTek
> SoCs. The old hardware is one bit per reset control, and does not
> have separate registers for bit set, clear and read-back operations.
> This matches the scheme supported by the simple reset driver.
>=20
> However, because we need to use different data structure from
> reset_simple_data, we can not use the operation of simple reset
> driver.
> For this reason, we keep the original functions and name this version
> as "MTK_RST_SIMPLE".
>=20
> In this patch:
> - Add a version enumeration to separate different reset hardware.
> - Merge the reset register function of simple and set_clr into one
>   function "mtk_register_reset_controller".
> - Rename input variable "num_regs" to "rst_bank_nr" to avoid
>   confusion. This variable is used to define the quantity of reset bank.
> - Document mtk_reset_version and mtk_register_reset_controller.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
