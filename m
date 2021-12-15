Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD38D4753D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhLOHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbhLOHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE381C061574;
        Tue, 14 Dec 2021 23:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B133617DE;
        Wed, 15 Dec 2021 07:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B015BC34605;
        Wed, 15 Dec 2021 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639553800;
        bh=2eI6exSN0FUaIEOk/+PWQb13t4mMcNpEbG4tBXpXW20=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GJtAajHT++olYZTMCJyu0CSCpjQk5zQ6r+b6ZlJUYZzhoJmER5BgU9qx0Te16loCd
         yBoJST5sR/FQiVmCv5vym8DKgallGkphuE4CUs+FlDG3kwNXyWok9fnI+xxUs5Egdd
         DpyeFTBYXv2uuYipjOuhtwFoAVC14vJoUl1av7f73xXQTkGG2HwDB/W5eaWLyT544F
         zi5awz4rDGvTVvQVja7kbMIcaFnkNtt9gGmFwo8uuJulw63bLTwr2Yac/KME64+gJN
         DDFigMZAAcUKHkVbN2+u/KXvpdr+TzkPhr463srApXq+7GoHndTsnPYzh4/CJmnNc5
         RJmn8VNc7ffYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ybgs+zet4EVGMa2a@matsya>
References: <20211207114003.100693-1-vkoul@kernel.org> <20211207114003.100693-3-vkoul@kernel.org> <20211209082607.06929C004DD@smtp.kernel.org> <Ybgs+zet4EVGMa2a@matsya>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
Date:   Tue, 14 Dec 2021 23:36:39 -0800
User-Agent: alot/0.9.1
Message-Id: <20211215073640.B015BC34605@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-13 21:34:51)
> On 09-12-21, 00:26, Stephen Boyd wrote:
> > Quoting Vinod Koul (2021-12-07 03:40:03)
> > > diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8=
450.c
> > > new file mode 100644
> > > index 000000000000..82ac419718d7
> > > --- /dev/null
> > > +++ b/drivers/clk/qcom/gcc-sm8450.c
> > > @@ -0,0 +1,3303 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserve=
d.
> > > + * Copyright (c) 2021, Linaro Limited
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/regmap.h>
> >=20
> > BTW, clk providers need to include clk-provider.h
>=20
> It is included but indirectly thru clk-alpha-pll.h.. I think this should
> be fine.

No
