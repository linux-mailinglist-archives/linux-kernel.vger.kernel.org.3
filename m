Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A464718F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhLLHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLLHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:02:20 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A8C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:02:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4D6E642598;
        Sun, 12 Dec 2021 07:02:15 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Hi folks,
Date:   Sun, 12 Dec 2021 16:02:08 +0900
Message-Id: <20211212070210.141664-1-marcan@marcan.st>
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

The second patch works around an issue with 8/16-bit MMIO reads that
only affects these platforms, for some reason.

Changes since v1:

- Also applied workaround to GL9750
- Fixed checkpatch warnings

Hector Martin (2):
  mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
    platforms
  mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
    reads.

 drivers/mmc/host/sdhci-pci-gli.c | 42 ++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

-- 
2.33.0

