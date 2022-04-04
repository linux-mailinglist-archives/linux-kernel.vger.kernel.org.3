Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3C14F1EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382147AbiDDVup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380443AbiDDUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686013FAC;
        Mon,  4 Apr 2022 13:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C00BB819E1;
        Mon,  4 Apr 2022 20:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F406C340F3;
        Mon,  4 Apr 2022 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649102730;
        bh=WPYWTY5BYrb49/S6MqrWmKHCLgSFZHgeBgSL+0PtGSY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ErB1Qr8fVgbsn6iyOwokf1BAc9rTXHYwHULQPZFGssew2MFFqylx36cJGPl+45os8
         8l0CFtMv9Gq/K8f4/V/vYTWFHcmmK/zaUichl8aPoub/wrbyntaUYqfhtW2/zwYwPh
         CWmoYnddJDNdiZ+/dhSsBZ4QvgZiasBy6QtCjnUIoBq1WasTyXpWv+4IXimoGYEvIF
         t/6Wp31teXOeK2wNr1ODHmJ8n7sJS1avcT9bsJbyuRaz+SqkVi+P+G1aN4Moj1gVJt
         iQ+HLX02qKK2K7WXXlqqA7/yxSSD9EfU/7OdrtYfOsjrIKhjdTca5JWTZBL0CJ76+q
         XvSMLe/rDTdQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220404072900.35jca2o26gopi2qb@houat>
References: <20220403022818.39572-1-sboyd@kernel.org> <20220404072900.35jca2o26gopi2qb@houat>
Subject: Re: [PATCH] Revert "clk: Drop the rate range on clk_put()"
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Mon, 04 Apr 2022 13:05:28 -0700
User-Agent: alot/0.10
Message-Id: <20220404200530.0F406C340F3@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-04-04 00:29:00)
> On Sat, Apr 02, 2022 at 07:28:18PM -0700, Stephen Boyd wrote:
> > This reverts commit 7dabfa2bc4803eed83d6f22bd6f045495f40636b. There are
> > multiple reports that this breaks boot on various systems. The common
> > theme is that orphan clks are having rates set on them when that isn't
> > expected. Let's revert it out for now so that -rc1 boots.
> >=20
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Link: https://lore.kernel.org/r/366a0232-bb4a-c357-6aa8-636e398e05eb@sa=
msung.com
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> I really like the attention it's getting now that it's broken, we can
> fix a lot of things :)

Sure! Except that can quickly turn into other attention.

>=20
> It doesn't seem to be restricted to orphan clocks though :/

Oof ok. I was busy last week so couldn't pay much attention.

>=20
> But obviously,
> Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks. Looks like it just made -rc1 so we can work through the fix at a
more leisurely pace now.
