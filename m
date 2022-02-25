Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992994C3A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiBYAVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiBYAVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:21:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD7270240;
        Thu, 24 Feb 2022 16:21:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C4E4B829CD;
        Fri, 25 Feb 2022 00:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A56C340E9;
        Fri, 25 Feb 2022 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645748478;
        bh=aFczwIve2g4Y6kndzCwNFPRGf+RFQpDkAXPjlti1cEQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OgIHKV9PuFdJDHhqegY2dEz/xKqT8rgVbPVmE/d5yoB7ly2qwwMZnboeJ+qanH2vu
         Nv/JvUnGthouMDnm/a7VN3FBOmdDydmCX055Z1LmGCyFf1JBvQ5DctFEaCY+u3reTi
         6tJhiF+WT7Xu15rivSrV+mSMviN2j8rLZEl1Ttw3422Kjg8GatHoYOpxbg59toleI4
         18JhdtQwa3LMIHYx7adjGlMkoBdge0Q3LZlV3CjWsE0tUqFXHafwV8t8gumPHHt++q
         ShbllJX+Dg0wioC6ggiOLAuZJZmFU3U88mxkVxHcnVAVLZXSZxW268aRBdo9s1q9+O
         cU+toKWrBFcbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223185606.3941-1-tdas@codeaurora.org>
References: <20220223185606.3941-1-tdas@codeaurora.org>
Subject: Re: [v2 1/2] clk: qcom: gdsc: Add support to update GDSC transition delay
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 24 Feb 2022 16:21:16 -0800
User-Agent: alot/0.10
Message-Id: <20220225002118.C1A56C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-23 10:56:05)
> GDSCs have multiple transition delays which are used for the GDSC FSM
> states. Older targets/designs required these values to be updated from
> gdsc code to certain default values for the FSM state to work as
> expected. But on the newer targets/designs the values updated from the
> GDSC driver can hamper the FSM state to not work as expected.
>=20
> On SC7180 we observe black screens because the gdsc is being
> enabled/disabled very rapidly and the GDSC FSM state does not work as
> expected. This is due to the fact that the GDSC reset value is being
> updated from SW.
>=20
> Thus add support to update the transition delay from the clock
> controller gdscs as required.
>=20
> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

Applied to clk-fixes with Bjorn's reviewed-by. One note below, please
make this improvement.

> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index d7cc4c21a9d4..ad313d7210bd 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2015, 2017-2018, The Linux Foundation. All rights reser=
ved.
> + * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights=
 reserved.
>   */
>=20
>  #ifndef __QCOM_GDSC_H__
> @@ -22,6 +22,9 @@ struct reset_controller_dev;
>   * @cxcs: offsets of branch registers to toggle mem/periph bits in
>   * @cxc_count: number of @cxcs
>   * @pwrsts: Possible powerdomain power states
> + * @en_rest_wait_val: transition delay value for receiving enr ack signal
> + * @en_few_wait_val: transition delay value for receiving enf ack signal
> + * @clk_dis_wait_val: transition delay value for halting clock
>   * @resets: ids of resets associated with this gdsc
>   * @reset_count: number of @resets
>   * @rcdev: reset controller
> @@ -36,6 +39,9 @@ struct gdsc {
>         unsigned int                    clamp_io_ctrl;
>         unsigned int                    *cxcs;
>         unsigned int                    cxc_count;
> +       unsigned int                    en_rest_wait_val;
> +       unsigned int                    en_few_wait_val;
> +       unsigned int                    clk_dis_wait_val;

Bjorn pointed out the usage of unsigned int is too big. These are 4-bits
wide fields in the hardware.

We should pack these into a u16 and then shift it and write it into
place if it is non-zero. That means the driver author has to know all
the values, but that sounds OK to me given that they're already changing
something from the hardware defaults. This will save space in the
vmlinux for however many gdscs there are declared. We should have a
macro for this too so we can pack all the values together and then just
write it out directly without having to know the shifts and stuff.

#define GDSC_WAIT_VALS(en_rest, en_few, clk_dis)
