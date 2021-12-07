Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603C46B316
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhLGGoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:44:21 -0500
Received: from marcansoft.com ([212.63.210.85]:51218 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhLGGoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:44:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5F23E41E96;
        Tue,  7 Dec 2021 06:40:47 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM platforms
Date:   Tue,  7 Dec 2021 15:40:17 +0900
Message-Id: <20211207064019.61444-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This short series adds a few quirks needed to make the card readers in
Apple M1 Pro/Max MacBook laptops work properly.

The first patch should be straightforward; it just allows configuring
the CD/WP polarity based on device tree settings. There is already a
standard DT binding for this.

The second patch bugs me. I don't understand why this problem happens
on these machines, and not on e.g. x86 laptops (which presumably work
with this driver). 8/16-bit MMIO reads work fine on other PCIe devices
on these machines, so it is not a generalized problem with the PCIe
controller in these SoCs. The problem also happens when running macOS
(it also uses 32-bit reads). Ben, is there any chance you might know
of some vendor-specific knob somewhere that can fix this issue without
requiring the MMIO read workaround? Interestingly, 8/16-bit writes
work perfectly fine.

Hector Martin (2):
  mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
    platforms
  mmc: sdhci-pci-gli: GL9755: Issue 8/16-bit MMIO reads as 32-bit reads.

 drivers/mmc/host/sdhci-pci-gli.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

-- 
2.33.0

