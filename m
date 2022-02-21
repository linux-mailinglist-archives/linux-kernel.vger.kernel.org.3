Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745634BE4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377134AbiBUN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiBUN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:56:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79237BF73;
        Mon, 21 Feb 2022 05:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2812AB81188;
        Mon, 21 Feb 2022 13:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921FDC340E9;
        Mon, 21 Feb 2022 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645451756;
        bh=J/e+1VPpw4RIUwxGwSRWfpseVM4XoBE0hkJ8DH/QOys=;
        h=From:To:Cc:Subject:Date:From;
        b=k/960sBhEX2zv1wWstCL1hxofDD0DlV6ErBmh+tTz/cnlE5B+Lw8BbNbhS6wy0PQf
         ig488E8B48wJbIzA3D7zdlQ7TQliGObDZwnGCFUf+AnnbhOWXyJq45e2JAUsuGkUz7
         Sif8G3fIVMiH/bQObraAsGqjRd0ia5O/r34fOPCBB//VojSuTgAzbrN+4ICntvTwMP
         KIjJaGz2jdcgz2dfa8jm+7fON32FlXxelmoaSP3k2d0MFFPoxjbMvhgbqAyzBjOo7B
         D+9tZpcIvbV94xY+VWP0QZrOHSO7Cu+vzgq+eq4/xaZZSypoSakC4/jwXULFrdXwzg
         9WDsx8Ovn3sfw==
From:   broonie@kernel.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nand tree with the mtd tree
Date:   Mon, 21 Feb 2022 13:55:52 +0000
Message-Id: <20220221135552.2196160-1-broonie@kernel.org>
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

Today's linux-next merge of the nand tree got a conflict in:

  Documentation/devicetree/bindings/mtd/nand-controller.yaml

between commit:

  751f204a6fe6f ("dt-bindings: mtd: nand-chip: Create a NAND chip description")

from the mtd tree and commit:

  cb57fae479be4 ("dt-binding: mtd: nand: Document the wp-gpios property")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 33855eb48a795,53b21aed0ac5f..0000000000000
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@@ -116,6 -154,20 +116,13 @@@ patternProperties
            Ready/Busy pins. Active state refers to the NAND ready state and
            should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
  
+       wp-gpios:
+         description:
+           Contains one GPIO descriptor for the Write Protect pin.
+           Active state refers to the NAND Write Protect state and should be
+           set to GPIOD_ACTIVE_LOW unless the signal is inverted.
+         maxItems: 1
+ 
 -      secure-regions:
 -        $ref: /schemas/types.yaml#/definitions/uint64-matrix
 -        description:
 -          Regions in the NAND chip which are protected using a secure element
 -          like Trustzone. This property contains the start address and size of
 -          the secure regions present.
 -
      required:
        - reg
  
