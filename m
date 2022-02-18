Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C84BAE37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiBRAO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:14:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBRAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:14:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6338BC;
        Thu, 17 Feb 2022 16:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA5B2B82437;
        Fri, 18 Feb 2022 00:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B6FC340E8;
        Fri, 18 Feb 2022 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645143279;
        bh=TFTlQQPzGmti7KVApu8+s08urpdqXAPiRc7Dxb9Wqsg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tl6VFUE99l05i2vQmdbhEq7Fn1VSl12cry4ydmqQDHqatI3GduWyojNGOkzdWJZa9
         YYfuL4JiWDRrZSsomv/+7cedOxoG5lcoeTdDfCzL0Q7onjUP6L2NG0f+xJxxLYQyMF
         K1+TR6EaGgydXDWTF91Koty5Qfop+2R9H/mdRR4AbAHsqp4c6xvCAfgFi4+bhjDJNn
         vvXJ9oibZ3ZvXoQYLWS1rJAwR9QX8+lrfVPElt1/NzbAvJeEHdHhwoL/VO5cpyj5m0
         ESrXeq7Hislp0cT+PEa1Dn/JmstiD3Y/7TpPtTRk/+lF4v4RnoIt+4rLEqk4v//+Sv
         Ww7/JyyPFlvpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220210173100.505128-1-robimarko@gmail.com>
References: <20220210173100.505128-1-robimarko@gmail.com>
Subject: Re: [PATCH] clk: qcom: ipq8074: Use floor ops for SDCC1 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dirk Buchwalder <buchwalder@posteo.de>,
        Robert Marko <robimarko@gmail.com>
To:     Robert Marko <robimarko@gmail.com>, absahu@codeaurora.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Thu, 17 Feb 2022 16:14:36 -0800
User-Agent: alot/0.10
Message-Id: <20220218001439.57B6FC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Marko (2022-02-10 09:31:00)
> From: Dirk Buchwalder <buchwalder@posteo.de>
>=20
> Use floor ops on SDCC1 APPS clock in order to round down selected clock
> frequency and avoid overclocking SD/eMMC cards.
>=20
> For example, currently HS200 cards were failling tuning as they were
> actually being clocked at 384MHz instead of 192MHz.
> This caused some boards to disable 1.8V I/O and force the eMMC into the
> standard HS mode (50MHz) and that appeared to work despite the eMMC being
> overclocked to 96Mhz in that case.
>=20
> There was a previous commit to use floor ops on SDCC clocks, but it looks
> to have only covered SDCC2 clock.
>=20
> Fixes: 9607f6224b39 ("clk: qcom: ipq8074: add PCIE, USB and SDCC clocks")
>=20
> Signed-off-by: Dirk Buchwalder <buchwalder@posteo.de>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
