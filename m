Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15F050AD50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443137AbiDVBnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443125AbiDVBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:43:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326D49C9E;
        Thu, 21 Apr 2022 18:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C836B821CA;
        Fri, 22 Apr 2022 01:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16530C385A7;
        Fri, 22 Apr 2022 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650591644;
        bh=84SSLoGtlEVQaRfEjpYyO2p8fJDHeUxLXOIa3sUjotE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m0XkKPNl8K7JR+f5fsbqjqiWh8SAu1HAp1/nxMkmWCOPNIetM2rqmlFauWr4gZOYw
         GGovyd5wEEhKxEcsb4EUxugGFwQleEX17IMpWLlmoZv1ybuNo+T5q+p28+IkFr5YT9
         1FfWZ6sGbl1tdOO2oAoyHt4nVObY7Rn/noYEderABHAP3RMKkz6Zp4SgNdb10UI6ug
         P8ANMklg/ayhENT5ChqyJDZkOi5x0MqS5HVp32/7+0CbaCPMmCgwIFHL4oLhfmqlzC
         2SgDFiI49v7XAsRRwf21N5PecBu4ik/lxox+VROAoN0nBttQZEHNdywDB4Qdg1ecOi
         6I7IcfWeiuYdA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGXv+5G2Uyq5fdMUnhr5wOm6O8M3dHNKGaSP2L_Vv1o28mXmOQ@mail.gmail.com>
References: <20220419081246.2546159-1-wenst@chromium.org> <3591fcc1-d34a-b40a-4e78-edcf9d2ddf08@collabora.com> <CAGXv+5HhcQbdGLQFtgPnvzVbSKaQ5GQGvmjwPVOVxjrYnMh1dg@mail.gmail.com> <ca8048f4-2e75-a49b-6c54-9f6abba6ead3@collabora.com> <CAGXv+5G2Uyq5fdMUnhr5wOm6O8M3dHNKGaSP2L_Vv1o28mXmOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Apr 2022 18:40:42 -0700
User-Agent: alot/0.10
Message-Id: <20220422014044.16530C385A7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-04-20 23:05:10)
>=20
> Not exactly. All the clocks in the MTK drivers are allocated at runtime,
> so we can't use clk_parent_data to point to not-yet-allocated clk_hw-s.
> Instead we'll need to have
>=20
>     struct mtk_clk_parent_data {
>         unsigned int clk_id; /* Match CLK_XXX_YYY from dt-binding headers=
 */
>         ... /* remaining fields same as mtk_clk_parent_data */
>     };
>=20
> and create the actual clk_parent_data at runtime by looking up clk_id in
> the set of already registered clks:
>=20
>     int mtk_clk_register_XXX(..., struct mtk_clk_parent_data *pdata,
>                              struct clk_hw_onecell_data *clk_data) {
>         struct clk_parent_data data =3D {
>             .hw =3D clk_data[pdata->clk_id],
>             /* copy other fields verbatim */
>         };
>         ...
>     }
>=20
> Obviously this forces some ordering of how the clks are registered.
> I believe the order is already correct, and if it isn't, it would be
> easy to detect, and we can reorder things to fix it.

If this is a common problem, we may need to come up with a generic
solution that either adds a new clk registration API that fills in the
clk_parent_data hw pointer or add another member to struct
clk_parent_data that says "index into this other array of clk_hw
pointers".
