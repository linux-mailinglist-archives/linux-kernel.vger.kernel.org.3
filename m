Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D64BC911
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiBSP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:26:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBSP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209553739;
        Sat, 19 Feb 2022 07:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40E31B80B0A;
        Sat, 19 Feb 2022 15:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0396C004E1;
        Sat, 19 Feb 2022 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284384;
        bh=6wMy5c40MoeMrkiAC6rmbWKQvU4M2MsxaJOM4WVGgnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7zxe6Y1JLH95rcf53kDPoMdpw63zTnIYT280c6n1kibcw4f9if2UA9HaAH59XpdR
         LctZvLoBDQQtRvmkYMIV3j1Nzn1Tdtsj7WGwFV8NCNLLP+eP+9EorXTbuMN3K4s97+
         toFAJ4OBGuqBlqFdHBjmaak2kUS+PxX1EcDlxf6Iknxn92bzxM8A7+iUSv/QaMW/Vr
         o7E219fJW2AbeScZhpo8d0UFpPV107X4fN956XGjuRWcwSCPvmFfID+uzwKjPRC3u2
         O27OgJTugIQqTpMSnqeScZQFmpzhcLhxooVUyd0oZUZRgV/u5iHQhuuTJYlkJGDuPj
         m4VZCgyBTdKgg==
Received: by pali.im (Postfix)
        id 65F962B70; Sat, 19 Feb 2022 16:26:22 +0100 (CET)
Date:   Sat, 19 Feb 2022 16:26:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220219152622.mykr2zl5cl3rgsgx@pali>
References: <20220211191238.2142-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211191238.2142-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen!

On Friday 11 February 2022 20:12:32 Marek Behún wrote:
> Hello Greg, Stephen, Gregory,
> 
> at Pali's request I have reviewed, updated and tested his series adding
> support for higher baudrates on Marvell Armada A37xx boards.
> 
> I have updated commit messages, some comments and indentation at some
> places. As per Stephen Boyd's request, commit message of patch 3 now
> contains more information about why we need to have UART
> clock-controller binding defined in such a way (due to backwards
> compatibility).

Are updated commit messages better now?

> Marek
> 
> Changes in v7:
> * fixed lint errors in yaml binding file
> * added Reviewed-by tags
> * changed commit messages and comments a little
> * fixed indentation at some places
> * swapped patch 2 and 3 (dt-binding defining new binding should go
>   before the driver adding usage of that new binding)
> 
> Changes in v6:
> * fixed yaml binding file and dts files
> 
> Changes in v5:
> * fixed yaml binding file
> 
> Changes in v4:
> * converted armada3700-uart-clock documentation to YAML
> * split documentation changes into two commits:
>   - first which adds clock documentation
>   - second which updates UART documentation
> 
> Changes in v3:
> v3 is rebased on top of Linus master branch and all already applied patches
> were dropped. There are no changes in patches itself since v2.
> 
> Pali Rohár (6):
>   math64: New DIV_U64_ROUND_CLOSEST helper
>   dt-bindings: mvebu-uart: document DT bindings for
>     marvell,armada-3700-uart-clock
>   serial: mvebu-uart: implement UART clock driver for configuring UART
>     base clock
>   dt-bindings: mvebu-uart: update information about UART clock
>   arm64: dts: marvell: armada-37xx: add device node for UART clock and
>     use it
>   serial: mvebu-uart: implement support for baudrates higher than 230400
>     Bd
> 
>  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/mvebu-uart.c               | 596 +++++++++++++++++-
>  include/linux/math64.h                        |  13 +
>  6 files changed, 671 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> 
> -- 
> 2.34.1
> 
