Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09054D778
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351111AbiFPBwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiFPBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E615839D;
        Wed, 15 Jun 2022 18:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA0061CE2;
        Thu, 16 Jun 2022 01:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D848C3411A;
        Thu, 16 Jun 2022 01:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344321;
        bh=ZQlXfWBwZAIW0M0J/Ta2fa4yf9T1gSiqLgOx2grAz5o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YAp1KkJmSKaUZOIEvme9BA/aSAJknRdJKEeYLm3Rm/0qsS4dz8OA3s3VxVfvi5rta
         jfchTVu/QjmG2Gm56h3pw1LsaL86NzySYW98iuy429HMv/IT4ppzfg3icoWjkQl/tS
         rnjmQl634ql39EoMFIwWAnu7s5lL/mc9ZocP2jexk1VAs4A1Fw57UyVX+rfzX0a4sE
         Pgouatq20eiKsWvb2+MC26JBI1XBKQDp96852ukkGiyGmVAPPzJXH7JHibr2vwcuRx
         a/nF3CMpz3+dHMIf4sg1G6bw6WP2V/Lsj9n/17w0m73UyBXTg0EGeI+ViqCF1CD7UM
         YBAatEb9mdGDg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-9-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-9-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 08/19] clk: mediatek: reset: Support inuput argument index mode
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
Date:   Wed, 15 Jun 2022 18:51:59 -0700
User-Agent: alot/0.10
Message-Id: <20220616015201.6D848C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:35)
> There is a large number of mediatek infra reset bits, but we do not use
> all of them. In addition, the proper input argement of reset controller
> soulde be index.
> Therefore, to be compatible with previous drivers and usage, we add
> description variables to store the ids which can mapping to index.
>=20
> To use this mode, we need to put the id in rst_idx_map to map from
> index to ids. For example, if we want to input index 1 (this index
> is used to set bank 1 bit 14) for svs, we need to declare the reset
> controller like this:
>=20
> In drivers:
> static u16 rst_ofs[] =3D {
>         0x120, 0x130, 0x140, 0x150, 0x730,
> };
>=20
> static u16 rst_idx_map[] =3D {
>         0 * 32 + 0,
>         1 * 32 + 14,
>         ....
> };
>=20
> static const struct mtk_clk_rst_desc clk_rst_desc =3D {
>         .version =3D MTK_RST_SET_CLR,
>         .rst_bank_ofs =3D rst_ofs,
>         .rst_bank_nr =3D ARRAY_SIZE(rst_ofs),
>         .rst_idx_map =3D rst_idx_map,
>         .rst_idx_map_nr =3D ARRAY_SIZE(rst_idx_map),
> };
>=20
> In dts:
> svs: {
>         ...
>         resets =3D <&infra 1>;
>         ...
> };
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
