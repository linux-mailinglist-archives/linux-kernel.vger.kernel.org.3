Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7249A597456
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiHQQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiHQQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:40:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A87CB74
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD0EB81E25
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2407EC433B5;
        Wed, 17 Aug 2022 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660754400;
        bh=KkrryIdY2Ve2bs/hZ2Z+dNgS3oYZRsAd1ewH2lCViO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccHNnbQFFsiz0tKZO71G5O4EaOl5jPLSluev94WXkiV1n/59tcsJQupsH/KTSIRJx
         bnwZBufeC0bKvFx08encF69lxLVAytblB3TNtZK7gvAxNApy+MF1UJPbxkgiJOeQqJ
         wCN0sGAYyhkIs4xSTl3ysjQt1eR1DWf903lOSNohBl36qv06RN0eAThuJmIE5cxwMz
         riHFym1D7iKGLDCllrDhKlwbS6ymbAAm/mFjOA03Kx5Veh0cS6vgi70bY+OggHk73X
         h0MRrHQ0p6C5Acj31iSLe9QwuXwRAdvmUQCPVzWoRkFs2ft6xwn2JNchlypP2lMOE3
         LpoZi9djjVPdA==
Received: by pali.im (Postfix)
        id C67F42799; Wed, 17 Aug 2022 18:39:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/pci: Enable PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT by default
Date:   Wed, 17 Aug 2022 18:39:27 +0200
Message-Id: <20220817163927.24453-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817163927.24453-1-pali@kernel.org>
References: <20220817163927.24453-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It makes sense to enable CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT by default
(when possible by dependencies) to take advantages of all 256 PCI buses on
each PCI domain, like it is already on all other kernel architectures.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index df2696c406ad..0905e4807815 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -387,6 +387,7 @@ config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	depends on PPC32
 	depends on !PPC_PCI_OF_BUS_MAP_FILL
 	bool "Assign PCI bus numbers from zero individually for each PCI domain"
+	default y
 	help
 	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
 	  So system could have only 256 PCI buses independently of available
-- 
2.20.1

