Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400050EE04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiDZBTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2EF2A23;
        Mon, 25 Apr 2022 18:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9891616DA;
        Tue, 26 Apr 2022 01:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF77C385A7;
        Tue, 26 Apr 2022 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650935761;
        bh=ou9+D4xM38y3LrtcSIGVGiykcsqxGIu8qkR07Ifu0U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQ9Qd3Xc/YVuUqQ2Jv7tLx9L2Cioz35oU8K0kHw82vf9ilO6zIpr6musdrrDUcrYW
         vLKKEQKP7FPkrylJbgPwiwhrSDAxITcpXB1FT6ijacIQXYbyGp6fpYyZYS79+PTYhq
         U5Cw4ms/xQpns+U/pOIdt0C5skQCL9PYewryxFLcv3mE4w3yJIXMkbPSJLum5iZe8l
         uYNiA7/vRUAqfX/LURTDSapwsEKWxdtD9q+dkkW0WytadTyWPUoRP73Inew6yGy0ok
         J+i3FBqge5L1YoK+ddfrNuWSB+UXcUb1AldYGTc7fZtXEQ77J6hU/+KuwHiqnKIzzh
         veO1Lu5t8Jofg==
Date:   Tue, 26 Apr 2022 09:15:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alison Wang <alison.wang@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the imx-mxs tree
Message-ID: <20220426011555.GA14615@dragon>
References: <20220426100659.0e3f3ca8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426100659.0e3f3ca8@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:06:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> arch/arm/boot/dts/ls1021a-iot.dts:150.3-26: Warning (clocks_property): /soc/i2c@2180000/audio-codec@2a:clocks: cell 1 is not a phandle reference
> arch/arm/boot/dts/ls1021a-iot.dts:144.27-151.4: Warning (clocks_property): /soc/i2c@2180000/audio-codec@2a: Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from clocks[1])
> 
> Introduced by commit
> 
>   23f550d5f7f6 ("ARM: dts: Add initial LS1021A IoT board dts support")

Changming,

I fixed it up with the following change.  Let me know if you disagree.

diff --git a/arch/arm/boot/dts/ls1021a-iot.dts b/arch/arm/boot/dts/ls1021a-iot.dts
index bdb7186f3590..66bcdaf4b6f9 100644
--- a/arch/arm/boot/dts/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/ls1021a-iot.dts
@@ -147,7 +147,7 @@ sgtl5000: audio-codec@2a {
                reg = <0x2a>;
                VDDA-supply = <&reg_3p3v>;
                VDDIO-supply = <&reg_2p5v>;
-               clocks = <&sys_mclk 1>;
+               clocks = <&sys_mclk>;
        };
 
        max1239: adc@35 {
