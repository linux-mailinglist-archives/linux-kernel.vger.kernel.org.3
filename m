Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832B44C4ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiBYTdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiBYTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:33:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B920F55;
        Fri, 25 Feb 2022 11:32:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CECC8B832FA;
        Fri, 25 Feb 2022 19:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57001C340E7;
        Fri, 25 Feb 2022 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645817553;
        bh=GI40B6hRPOX7dQ8lCayKwuLySe70APW9z+nvx2bNfTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T09cAwPjKegRFhRCC62PlqzAm+6ToWcb+iCAft0L11ACrwMmPajuxjcjQyW+W39U4
         xH/3f9KfHTh4ufi2z+7MiBQLUxPGsxFub5nroychbDhglXreSsLwvLrBldnYSoOhmb
         BnKc37PH633qEugSXqvFTuMNT6xhJJ77D3TPkVIC01fR55phkn0mueGXsrsu316E6q
         NrFl08Jior7gcVVuNkeODldX5bNvRwiXJ7RrHt1s3x4MLoh2t6gXHcS5g1mQLyqte0
         mEFBcO3w0LWJHUbeCjIWBxPsHrvFci4McxxmtbfMlNTTuIIQK2wtb1LEjbc1S/rhBO
         VsTUnxGHgZyxg==
Received: by pali.im (Postfix)
        id 186D17EF; Fri, 25 Feb 2022 20:32:30 +0100 (CET)
Date:   Fri, 25 Feb 2022 20:32:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220225193229.f7uiv4o6br5xmyis@pali>
References: <20220219152818.4319-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220219152818.4319-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2022 16:28:12 Marek Behún wrote:
> Pali Rohár (6):
>   math64: New DIV_U64_ROUND_CLOSEST helper
>   dt-bindings: mvebu-uart: document DT bindings for
>     marvell,armada-3700-uart-clock
>   serial: mvebu-uart: implement UART clock driver for configuring UART
>     base clock
>   dt-bindings: mvebu-uart: update information about UART clock
>   serial: mvebu-uart: implement support for baudrates higher than 230400
>     Bd
>   arm64: dts: marvell: armada-37xx: add device node for UART clock and
>     use it
> 
>  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/mvebu-uart.c               | 596 +++++++++++++++++-
>  include/linux/math64.h                        |  13 +
>  6 files changed, 671 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

Hello Greg! I think that this patch series has now all reviews.
Could you look at it if you can finally take it? Or is there still
something missing?
