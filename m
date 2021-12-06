Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49924468FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhLFDnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:43:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34804 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbhLFDnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:43:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1418CB80EDC;
        Mon,  6 Dec 2021 03:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03079C341C2;
        Mon,  6 Dec 2021 03:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638761975;
        bh=G8Er7UOQoTAf/H/O3gl71+y4wSaffr2EuuVEvSRewdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0FIcZA5rfeNKZ0OzkNcymRCpG1v5ULYXD+U1qXTtjVGgAtju5XGwltIT3v8S6hJY
         YCi9tve1Z4kXFr6M4o5xjF4cPQhDo/4k0VTHzpFIiShkDGq+3R0PMoO5K1KMY1nutF
         Ilzo8rdsCqZy7wvL1LNIOvJYW3Q7Lxsbb3qw4tkVRJDdTovBdLiLh96dZ42rfsTspg
         YkfMWl0Rm/4jB3ORSu5vpAl5Z2cRsrMGA9k4qwwbs1vpLNEvY6/JVO9a3GVSS6b9cX
         ou3JTxgJGfwGzuRGBybPw5DLSsP0UFaN+Txb63UVupWSBFR7IlzUyGNoBOsnuXBXZk
         1yvKIhGgysFRg==
Date:   Mon, 6 Dec 2021 11:39:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] Support for some TQMa8M* boards
Message-ID: <20211206033921.GF4216@dragon>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 08:29:41AM +0100, Alexander Stein wrote:
> Thanks for the review on v2!
> 
> Changes in v3:
> * Rebased to next-20211129
> * Adjusted commit subjects (tree -> device tree)
> * Use hyphen in node names instead of underscore
> * Removed bootargs from DT
> * Fixed audio-codec node name and handle name
> * Property 'enet-phy-lane-no-swap' was already documented, but got accidently
>   removed during YAML conversion. Fix is pending at at [2]
> * Use matrix instead of array for 'fsl,pins' as required by pinctrl bindings.
>   This reduces the lines in stderr from dtbs_check for these DT files from 475
>   down to 191
> * Removed TODO regarding unsupported USB over-current polarity
> 
> Changes in v2:
> * Rebased to next-20211101
> * Added Rob's Acked-By on Patch for DT bindings
> * for other changes please refer to individual patches
> 
> Note on TQMa8Mx:
> Due to CPU errata cpuidle is broken and needs to be disabled, see [1] for
> pending patch.
> 
> This patch set adds support for the following modules:
> * TQMa8Mx
> * TQMa8MxML
> * TQMa8MxNL
> 
> Each of the modules is available with different i.MX8M variants, the
> bootloader modifies the device tree and disabled paripherals which
> are not available on the actual hardware.
> 
> All of them can be attached to the same mainboard MBa8Mx, although
> TQMa8MxML & TQMa8MxNL need an adapter. For that reason there is a single
> mainboard .dtsi file named mba8mx.dtsi.
> 
> There is a .dtsi file for each module named imx8m?-tmqa8m*.dts.
> 
> Finally there is the final .dts file which includes the mainboard and
> the attached module and contains the missing connection, prominently clk
> and pinctrl defines.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211105095535.3920998-1-alexander.stein@ew.tq-group.com/
> [2] https://www.spinics.net/lists/devicetree/msg460023.html
> 
> Alexander Stein (7):
>   dt-bindings: arm: fsl: add TQMa8MxML boards
>   arm64: dts: freescale: add initial device tree for TQMa8MQML with
>     i.MX8MM
>   arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
>   dt-bindings: arm: fsl: add TQMa8MxNL boards
>   arm64: dts: freescale: add initial device tree for TQMa8MQNL with
>     i.MX8MN
>   dt-bindings: arm: fsl: add TQMa8Mx boards
>   arm64: dts: freescale: add initial device tree for TQMa8Mx with i.MX8M

Applied all, thanks!
