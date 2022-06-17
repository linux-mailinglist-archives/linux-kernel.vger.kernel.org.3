Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94654EE55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379121AbiFQALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQALg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB862215;
        Thu, 16 Jun 2022 17:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 486976182F;
        Fri, 17 Jun 2022 00:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD0CC34114;
        Fri, 17 Jun 2022 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424694;
        bh=uQeVB00AjJrbZT5b4yd3bF+T7xqW+4EKimhddU+zKSc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oJ1o0qOkIqjaahotZjelLA95CRGSCBeyUZCf31ei/1X/0WSeF0ZKdDuayhIRGRJaN
         6j1kQcUVqOjkYoKEw876rX7umHBVYVEBNJwY24iO8e0Yw7YTCBu71WcIRxPo6hldkU
         qpwPiNw/XYPAUnoX6TGRaeru4wkyTjt7Bm+EiSkfrDnqRCAKBKUBY1FPvHtx7X5IYp
         wYKZfsJgBT5LsbGLO5L/VPtlxW2yDXypTR8NjdFK3+9M6mD9Qp7CUE7123WMclPqVx
         /2Zgj0GtMcEnyiA89/ZeAgyCEhZb0S0Ug+cYCSAcgkDaNSwMaJczKIJLGsLfjaIJJ+
         vWXbe0S3qEFfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <88be9f00-2b1a-977d-dadd-95a131bf7f1f@collabora.com>
References: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com> <20220616024442.1337EC3411E@smtp.kernel.org> <88be9f00-2b1a-977d-dadd-95a131bf7f1f@collabora.com>
Subject: Re: [PATCH] clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Thu, 16 Jun 2022 17:11:32 -0700
User-Agent: alot/0.10
Message-Id: <20220617001134.9AD0CC34114@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-06-16 01:48:44)
> Il 16/06/22 04:44, Stephen Boyd ha scritto:
> > Quoting AngeloGioacchino Del Regno (2022-06-14 02:10:20)
> >> Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
> >> clock: this is required to trigger clock source selection on
> >> CLK_TOP_EDP, while avoiding to manage the enablement of the former
> >> separately from the latter in the displayport driver.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >=20
> > Any Fixes tag?
>=20
> Backporting is useless because there's no DisplayPort driver that support=
s MT8195
> in the previous kernel versions, so this clock (and whatever logic behind=
 it) is
> unused.
>=20
> Though, if you think that's going to be useful in any way, I can add one?
>=20

It's always useful. A Fixes tag doesn't mean anything for backporting to
stable kernels.
