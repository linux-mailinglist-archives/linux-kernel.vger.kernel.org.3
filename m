Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8921A5AF6DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIFVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIFVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B49AFF0;
        Tue,  6 Sep 2022 14:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FAC7616C3;
        Tue,  6 Sep 2022 21:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF4FC433C1;
        Tue,  6 Sep 2022 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662499939;
        bh=J7BmvjygBiGVStobKm9U8zrpENawx9NTfs1Ee7DF3lo=;
        h=Date:From:To:Cc:Subject:From;
        b=YfZGMl3m9FXONN+vkHsrX7P88oAInopcLyju2VuOLR61lqEO8Kmq8TusVNZd+49xq
         01r4DQEE33vWzWL6TvYLwailnevAm/s1cpLNLIz9ITeC3/dADIEzihspa1EGkD0lf2
         MeKqVvGyyFnrGYoSqAlLXluLQnwVMswOxpuupaldlqtxX0frAGsEgKqe3jtgnf00S5
         UuSg54Zw0Fd8SI97e8dICq5uN+y5P55rSWTtU20A3lysjyLODdEF4Be6+P9Iv6ZlQc
         8f+h0d3tZ/aST3TnUg2MEBYflsRkAhnOlmfDmGhisha1sv5dSQ2iICKfKPHP5ZXxCV
         snkYhA5fZczoQ==
Date:   Tue, 6 Sep 2022 22:32:13 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] powerpc: Fix fall-through warning for Clang
Message-ID: <Yxe8XTY5C9qJLd0Z@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following fallthrough warning:

arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Link: https://github.com/KSPP/linux/issues/198
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202209061224.KxORRGVg-lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 48f3acfece0b..0b8f2101c5fb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -159,6 +159,7 @@ static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 			else
 				dev->irq = 10;
 			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+			break;
 		default:
 			break;
 		}
-- 
2.34.1

