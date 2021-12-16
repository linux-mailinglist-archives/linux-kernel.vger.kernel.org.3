Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033F4477C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhLPTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhLPTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F5A61F46
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1A5C36AE3;
        Thu, 16 Dec 2021 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681693;
        bh=7u5ZXp0SxICy+XRCd6bWm1fsZtpAqJvtYeNFfSxCKcU=;
        h=From:To:Cc:Subject:Date:From;
        b=gSHDE3257w7gEgqwIP5iVpFLfnkuvjL5Wsvn2B6eDeufgfoUr3FnPYhdNYhBLwCsT
         4iqXP4eRg/NcbvlNrPTOIe/My4VXCt7fNSLldW5v8VfSn/+bASQyP2yEI68XkB+lmw
         WvVR3EZT1sXY+Yx8SXxYfpFUdUxH8pNwVg9+bZzZGRgdTl5timDD19BJmUKIDyplkz
         lwmInwdZuiFx2LxUna+f8rdnBaPY2WUEdPRxiQPvtaPMStENtRykKs/71DkjWYUixs
         FchAogxP9cEsNa3AbVQN9kIo8AyMeMIodAiAgA9VgKSQbvUB6hPKs+qG2pvtSY9EfF
         tY1aALcfKDZEQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] spmi patches for the next merge window
Date:   Thu, 16 Dec 2021 11:08:06 -0800
Message-Id: <20211216190812.1574801-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a collection of SPMI patches that are ready for the next merge
window. This is mainly support for a Mediatek SPMI driver and then
a race condition fix and a patch to make the error message a little more
helpful for the Qualcomm PMIC arbiter.

David Collins (1):
  spmi: spmi-pmic-arb: fix irq_set_type race condition

James Lo (4):
  dt-bindings: spmi: remove the constraint of reg property
  dt-bindings: spmi: document binding for the Mediatek SPMI controller
  spmi: mediatek: Add support for MT6873/8192
  spmi: mediatek: Add support for MT8195

Stephen Boyd (1):
  spmi: pmic-arb: Add sid and address to error messages

 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  76 +++
 .../devicetree/bindings/spmi/spmi.yaml        |   3 -
 drivers/spmi/Kconfig                          |  11 +
 drivers/spmi/Makefile                         |   1 +
 drivers/spmi/spmi-mtk-pmif.c                  | 542 ++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                  | 193 +++++--
 6 files changed, 779 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

