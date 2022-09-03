Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785F5ABC49
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiICCR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiICCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F166E01F5;
        Fri,  2 Sep 2022 19:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB1D3B82D0E;
        Sat,  3 Sep 2022 02:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3071C433D6;
        Sat,  3 Sep 2022 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662171441;
        bh=eioRvOtIHJKvIPDEtWmHeI3UQjUk/+sTTkBT+LYyiFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSJAbsR9gPX6GlfA+hpa7+Eo8ghjuUjJU/RoNjAUt5zjW/NTFJzFAHIzvHH+TQv+V
         ErPSN/Tx4xYcum2g4HxsMC3/KF4bn/y40gMevIM6k29fGfFqiH6XHdQ8oVIOU2O4Y/
         Dru/wF/Go1dIXBzURbTjqL0I9dl5sdwmfzjq9WN2WE9f02j1hul0wVYTwXbHXKRYwC
         FQWiwxmHdOtjzcJzEy3tRqeyt9AZXwXhszoxj+47XUgcjWJUQ0uLrpxfROPuXDPip5
         OPcJWvjk/r3o0z3AYCivJAI+H3HpI8GUQwNEcjXO2+6y5FgXNTusaOCuEMrvAjGzxr
         HhJ7IvC6oEeNA==
Date:   Sat, 3 Sep 2022 10:17:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu
 blk ctrl
Message-ID: <20220903021714.GC1728671@dragon>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:45:28PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V5:
>  Add R-b for dt-bindings
>  Tune order of vpu blk ctrl node per unit address
>  Update commit log of patch 5.
>    - Per HRV, this should be detailed explained in HDMI HRV driver, so here
>    I only say HRV_MWR(HDMI RX Video Memory Write Master for RX validation).
> 
> V4:
>  Add R-b for patch 2
>  Add a new patch 3 to introduce interconnect property for i.MX8MM VPU blk ctrl,
>  same to other properties, i.MX8MM/P could use their own names in patch 4
> 
> V3:
>  Per DT maitainer, add a new patch to clean up minItems, see patch 2
> 
> V2:
>  - Add A-b from DT maintainer for patch 1
>  - Per DT maintainer, I added description for items. To
>  make it consistent, I also added description to i.MX8MM.
>  - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.
> 
> This patchset is to add more blk ctrl support for i.MX8MP
>  - Add HDMI HDCP/HRV BLK CTRL support
>  - Add VPU BLK CTRL support
>  - Add PGC VPU node which supplies power domain for VPU BLK
> 
> Peng Fan (8):
>   dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
>   dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
>   dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk
>     ctrl
>   dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
>   soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
>   soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
>   arm64: dts: imx8mp: add vpu pgc nodes
>   arm64: dts: imx8mp: add VPU blk ctrl node

Applied all, thanks!
