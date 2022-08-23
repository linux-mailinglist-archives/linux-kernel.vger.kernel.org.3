Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F9C59EF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiHWWwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiHWWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF178C457;
        Tue, 23 Aug 2022 15:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC798B821EA;
        Tue, 23 Aug 2022 22:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B6DC433D6;
        Tue, 23 Aug 2022 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661295123;
        bh=ypcp98VMiz7kBu3cGUG6LeZApIJKQVW/y2vnoL910eE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DZr0NmbKznJeIxoMhkhF17OzDK9v7sRfbGjSpGHBhpuFXyaHu8pNRwi/f4WhYs1gu
         fekrHQ9D3yzuX7WWC9la2iCPghUT/3qpBnlV2W+ecrQekSCy1AuZS+x0Q9ITg7vxwq
         kqDbik3OjleTwSvxURbUmFKUVr9Qlj3oR+nuq1v0HACDIpkYN1ZVMQP1vxVdvfFL28
         daUG1+gDBGClvtNGSaBHq3pBpfmKnHGbiEb1tWlquRDv1zfMlpceI2OWt+kdXL2L+8
         QmiOq4fP2jZetKEMikK6z3hOqwNJhTGV8qPoOaI2pC/d5yPnDvrHSX7VAXOb2o/Xyg
         ULw0dMO4rLqNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220713154953.3336-2-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com> <20220713154953.3336-2-stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/3] clk: bcm: rpi: Prevent out-of-bounds access
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Phil Elwell <phil@raspberrypi.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Tue, 23 Aug 2022 15:52:01 -0700
User-Agent: alot/0.10
Message-Id: <20220823225203.92B6DC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-07-13 08:49:51)
> The while loop in raspberrypi_discover_clocks() relies on the assumption
> that the id of the last clock element is zero. Because this data comes
> from the Videocore firmware and it doesn't guarantuee such a behavior
> this could lead to out-of-bounds access. So fix this by providing
> a sentinel element.
>=20
> Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
> Link: https://github.com/raspberrypi/firmware/issues/1688
> Suggested-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-fixes
