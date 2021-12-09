Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23E746E428
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhLII3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:29:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54450 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhLII3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:29:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DCC97CE2504;
        Thu,  9 Dec 2021 08:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06929C004DD;
        Thu,  9 Dec 2021 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038367;
        bh=ZON+4u+q2F+Fa8whstAYeDuG7BMfCupQp2IyL4eIE6A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pn439sS9qvx5uBNoFPe9ptDWRL8pbZ9zvyijRzF+POy3u8NrZfMEzY0g3PG6e1iXA
         VchtdngaJspHdM8nElC8WqGELW0HpONMxF5mXylhM7ODCpex5Jr/09MMUgg3fhkvOp
         n7yqsceIAFbue9Oi0MbqLCTogu5JFdJrPlYGrOcCj2k4SLIzP2Z7IFYijQd1vCKUB6
         Etx0kQO21ym622ju5mVusSSGFZEmbOjmPssjC0fCLL4ATL2DYZE4UzajaLJ8gnfYXP
         L211Z3/ZfZZnCPWo/d6nycJW7yjvSIDMvstqS3zsFcqmrXGwQVDVxS628d5eTed8Tx
         noCcJjRkYq/ew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211207114003.100693-3-vkoul@kernel.org>
References: <20211207114003.100693-1-vkoul@kernel.org> <20211207114003.100693-3-vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date:   Thu, 09 Dec 2021 00:26:05 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209082607.06929C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-07 03:40:03)
> diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> new file mode 100644
> index 000000000000..82ac419718d7
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sm8450.c
> @@ -0,0 +1,3303 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>

BTW, clk providers need to include clk-provider.h
