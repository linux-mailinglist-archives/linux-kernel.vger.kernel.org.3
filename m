Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703004DCF01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiCQTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiCQTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25F24373E;
        Thu, 17 Mar 2022 12:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A771F618E3;
        Thu, 17 Mar 2022 19:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0947EC340E9;
        Thu, 17 Mar 2022 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647546442;
        bh=8O4xojYXJ2O3v1mIxSIElqegPelL1l70GLiAdhxHFp8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rmu3sp6XO5V4kWS5PcgJND2BvL8Zt+ZoZ/h6/YTsa+Gsi0WP0VcCeafoeVI9xysMJ
         3Fk+E4MkYkXAwPq0/dqnpnJz2ZNW8d4H0fzj4VXImoNH7r6ooHGxGFooyXBlPvUCfl
         Cd9SbHehrGuLEkkeAtWreQ5kY+7NGagrsfsJ1MVdShXOeMvQ/Xnya4ULh0qo6GebZk
         zy/ZMWD3O9HXaGMeh2qJl6Id4LbsNkuL2gHE4tj9iaRJ3Gzgs2N0DhYDYmtKMRpPoV
         PRYoSS+vnkfhdghGIqbwqarAmP9hQSXKAe7AEsXXbgNKMfjsmHDtRIlDnDOAYjp09K
         T6rxMLrZvALmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220311114229.32504-3-chun-jie.chen@mediatek.com>
References: <20220311114229.32504-1-chun-jie.chen@mediatek.com> <20220311114229.32504-3-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v3 02/15] clk: mediatek: Add MT8186 mcusys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Mar 2022 12:47:20 -0700
User-Agent: alot/0.10
Message-Id: <20220317194722.0947EC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-03-11 03:42:16)
> diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek=
/clk-mt8186-mcu.c
> new file mode 100644
> index 000000000000..6d82c5de16c1
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mt8186-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>

Order should be

	<linux/*>
	<dt-bindings/*>

	"local.h"
