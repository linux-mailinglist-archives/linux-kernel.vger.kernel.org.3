Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9D4BEB06
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiBUTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:22:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBUTWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:22:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA71A38C;
        Mon, 21 Feb 2022 11:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633B660C92;
        Mon, 21 Feb 2022 19:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5EDC340E9;
        Mon, 21 Feb 2022 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471307;
        bh=xSWpEwDybfYAh05pjuUF2t9kyf2Kg4owDWECjFNX7fM=;
        h=From:To:Cc:Subject:Date:From;
        b=tuz6cAh2R5epfpgw7bSpEBaUbVxeL35Q10C0/0+3M8KPrREmEseS+JvKLl92kFHbh
         ray3bQQEGn+89CRBcHUWBtic36HA8TZCfY8A61oouEdl9DNBSkGO469AR8xqwOvplX
         CZCY7amAvEY3l1wa7XGq+5107zrNBtlYyKBRpKQdaI372A6kkRI1hUZq+YyJBUdGFX
         nB2/PxhJGfNRt/qwCFsy/hMdysqA82PnDsgrU1pJP6FbrEw2/0Zc4h/onb6mQrsipJ
         bOaYO0Qd0NNgKsAXYLmzS2f8effOEKOfM6XqIj+DAYLxXaG/OHsTFcFrRy6rFhunY9
         T0ZjOIpBZ/8cA==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: linux-next: manual merge of the usb tree with the xilinx tree
Date:   Mon, 21 Feb 2022 19:21:43 +0000
Message-Id: <20220221192143.1661784-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/boot/dts/xilinx/zynqmp.dtsi

between commit:

  eceb6f8677d31 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")

from the xilinx tree and commit:

  d8b1c3d0d700f ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 056761c974fda,ba68fb8529ee0..0000000000000
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@@ -823,6 -824,8 +822,7 @@@
  				interrupt-parent = <&gic>;
  				interrupt-names = "dwc_usb3", "otg";
  				interrupts = <0 65 4>, <0 69 4>;
+ 				clock-names = "bus_early", "ref";
 -				#stream-id-cells = <1>;
  				iommus = <&smmu 0x860>;
  				snps,quirk-frame-length-adjustment = <0x20>;
  				/* dma-coherent; */
@@@ -849,6 -851,8 +848,7 @@@
  				interrupt-parent = <&gic>;
  				interrupt-names = "dwc_usb3", "otg";
  				interrupts = <0 70 4>, <0 74 4>;
+ 				clock-names = "bus_early", "ref";
 -				#stream-id-cells = <1>;
  				iommus = <&smmu 0x861>;
  				snps,quirk-frame-length-adjustment = <0x20>;
  				/* dma-coherent; */
