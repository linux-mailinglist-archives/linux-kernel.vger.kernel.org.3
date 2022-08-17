Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C8596BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiHQJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:05:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72061719;
        Wed, 17 Aug 2022 02:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6719DB81C65;
        Wed, 17 Aug 2022 09:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D7C433D7;
        Wed, 17 Aug 2022 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660727139;
        bh=AdrtSs51sExh6zWewEg6hsDl4RiKlBISaAKANDbD3Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX2zsE5APNQq0k7AzTvFBHsPpa8pPF4pInuFXpdvKdITBtpXWptbxA9AAVoea9cYU
         tnR8J5TA/GGPUI8SpUOSVLdf+Q7PWzFWTVMWUt4GbDznsWTi0EEMDwfIw1wuaYBSlj
         RwlBO59C7G1+yshqFRvyL5RLpc5VadX8nBs1jMlDMb2GDSB5p5TJ59FcY8QhFBASuS
         3X7OaslPU+C3Wx4camNY4EocZljXGe7RH8Lu12dbtw9GkP2aYEGU2lQjbE1yD4N9bm
         NMgJDxuOB86E3xeLdA11CMV5HteXJ7sF59CrGfu2WP2LfNt9d2cN52BpNXqCo3HkRc
         /hlyoJohMmOXA==
Date:   Wed, 17 Aug 2022 17:05:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
Message-ID: <20220817090530.GB149610@dragon>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:56:25PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>  Because the header is not included when adding NoC node, the fsl,imx8mp.h
>  needs be included in this patchset. So include it in patch 6
> 
> V3:
>  Move adding NoC node patch to i.MX8MP ICC driver patchset
>  Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> 
> V2:
>  Use a low bandwidth value instead INT_MAX
>  Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
>  Add A-b tag from DT maintainer
> 
> i.MX8MP NoC settings is invalid after related power domain up. So
> need to set valid values after power domain up.
> 
> This patchset is to bind interconnect for each entry in blk ctrl.
> 
> This patchset is not include DVFS DDRC feature.
> 
> Peng Fan (7):
>   dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
>     ctrl
>   dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
>     ctrl
>   dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
>     ctrl
>   soc: imx: add icc paths for i.MX8MP media blk ctrl
>   soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
>   arm64: dts: imx8mp: add interconnects for media blk ctrl
>   arm64: dts: imx8mp: add interconnect for hsio blk ctrl

Applied all, thanks!
