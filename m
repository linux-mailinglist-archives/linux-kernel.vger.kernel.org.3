Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AC536774
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354324AbiE0T0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353610AbiE0T0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15907B6;
        Fri, 27 May 2022 12:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 652D3B8263B;
        Fri, 27 May 2022 19:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F47C385A9;
        Fri, 27 May 2022 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653679568;
        bh=QTp+HRY7uWp0xK4NOF5Eq/gZEEbNWKsVVhpDfbo/kHc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cYyI6pGKt+SSQ8xT3jTUIBCP0R1/RIwThJcz/WBm9rekTzzZvQwpHC/AAMdCpL7TN
         ysBgMcBUagpBWTLu2AR4BVUxT+1DWn1YntVy4wV0F4vF9lKrlvrd2GxItp/xTjwWXS
         6I6fQyu6njIRq25VoGXcHHIsmTXd5pw2sTeBJzZI55APsBWK5d3SdCIrvLTerdsQEZ
         RkEw/dwjZ85tMqAN9yYng4xkeGLhoCO9ChY/DP9fLT6JZtd7pnd7BvwsQelyOnSMfx
         0MmxdHZAOwDaDHTmLfGSDSIfysRW0MklYmJGH2T1NqgH69tsTj7Bds8A2V5NGehvRK
         rhBPpvperSPXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <31b7293f-662d-4a94-1717-9c76d7f33840@microchip.com>
References: <31b7293f-662d-4a94-1717-9c76d7f33840@microchip.com>
Subject: Re: Reset controller within a clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Daire.McNamara@microchip.com, geert@linux-m68k.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de
To:     Conor.Dooley@microchip.com
Date:   Fri, 27 May 2022 12:26:06 -0700
User-Agent: alot/0.10
Message-Id: <20220527192608.25F47C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor.Dooley@microchip.com (2022-05-27 11:40:59)
> Hi Stephen,
>=20
> After I sent the fix for the broken resets in clk/microchip/clk-mpfs.c,
> [0] I started looking at making a proper reset controller driver a la
> clk/renesas/{renesas-cpg-mssr,rzgl2l-cpg}.c where the reset controller
> is part of the clock driver file.
>=20
> I did it that way b/c the reset controller is just a single reg,
> surrounded by registers used by clocks. It's roughly a +130,-10 line
> change to the existing driver. A /very/ rough version that will not
> apply without other cleanup is appended for context.
>=20
> Before I got around to testing properly and cleaning it up for
> submission, I saw a mail you had sent and wondered if I'd gone for the
> wrong approach [1].
>=20
> Should I instead have my clock driver create a device for the reset
> controller to bind to, or is that overkill for a single register &
> Serge's situation is different b/c he'd created a file purely for
> a reset controller?
>=20

It's really up to you. It may be better to use auxiliary bus to split
the logic out to different subsystems. I can review the reset code but
I'm not the reset maintainer. Historically we've just accepted that
sometimes SoCs combine the clk and reset controls together into a "clock
and reset controller" and so we have the driver register clks and
resets. Using the bus to split up the device will help move these
registration calls to the appropriate subsystem so that the
reviewer/maintainer load is spread around.
