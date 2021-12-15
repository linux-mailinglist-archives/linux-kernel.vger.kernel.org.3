Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEA4759E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhLONtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:49:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36960 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhLONtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:49:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA2BB81E3B;
        Wed, 15 Dec 2021 13:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F46BC34604;
        Wed, 15 Dec 2021 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639576159;
        bh=MHb2RVE2XhMhLizrM9DPGP4G+eHIf59bdEW2yRL97O0=;
        h=From:To:Cc:Subject:Date:From;
        b=YW7Yv/a/OxGN8cjnMVgDaZK5bJxOX3A4i9YJzvhNtnPLW4avUSoyWhzZQeHs9oN0h
         IWHhtZU445W4LNo6VIpHVtFHk8ID0ZsYqko1ox4Ti0J7PwAheG3B63/2glLB0D5SjR
         uCE7Phm218dVQi+nbBhTp6yQpR6k33QaufcQQLDslKhazuU/5St+YefNq2ZNThTeqs
         twDxBDrWz57ZyDG6VjVTLSxyvDGx+6aU0B8S/R3gEGPreEVCp+YSwFxh9EzDpFyyWq
         RTGMwikNhbQCb6yQmx7KEb1VcXIB5RfQmVeRZEqu07Wl2gHRMyqPpimwO2DveGesD9
         fbTwf6hB5GuHA==
From:   broonie@kernel.org
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the phy-next tree
Date:   Wed, 15 Dec 2021 13:49:15 +0000
Message-Id: <20211215134915.3622957-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the phy-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c: In function 'imx8_pcie_phy_init':
/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
   41 | #define IMX8MM_GPR_PCIE_REF_CLK_EXT FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
      |                                     ^~~~~~~~~~
/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:85:7: note: in expansion of macro 'IMX8MM_GPR_PCIE_REF_CLK_EXT'
   85 |       IMX8MM_GPR_PCIE_REF_CLK_EXT :
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  1aa97b002258a190d77 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")

I have used the phy-next tree from yesterday.
