Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE98477C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLPTVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbhLPTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:21:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A8C061574;
        Thu, 16 Dec 2021 11:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6046AB8260C;
        Thu, 16 Dec 2021 19:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6F5C36AE3;
        Thu, 16 Dec 2021 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639682509;
        bh=5lqcgPEUv2bDEZ10XR9wxs6gujz97M097z6MeyDr1dE=;
        h=From:To:Cc:Subject:Date:From;
        b=V/DTJl/sg7zz7ScHp1AmvFSeXbUdtfK4MygxEYhwc5Ik87zJ3MJMpyy+pfllqFrgC
         CiGiRBo4wwQNJ3/etIXCBKk83XLSIDYv7wp8il254UDX+jOFdj0lAXp78rRhD9KEYb
         JyT4u7gy4W9VdQ/usPhNAs/6/xCgvye7ViP3iOOTnZRJzTbtr998UugbE3Z9LIdNBY
         etSad1uCpF5ZwIgGZ/OgjxTsx/ZptDSMWrr3gjVcytPUYyunYh06tfpGpS5DiBUrS9
         sLwLIdSdxpSISbjGH336ruQxNt0k8BgTAmgtwGYCAqcIH86gp9SXIPpQltNjGxFnUT
         OiG8B8dai1xUA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.16-rc5
Date:   Thu, 16 Dec 2021 11:21:48 -0800
Message-Id: <20211216192148.1577380-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2d4fcc5ab35fac2e995f497d62439dcbb416babc:

  clk: versatile: clk-icst: use after free on error path (2021-12-07 12:25:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 54baf56eaa40aa5cdcd02b3c20d593e4e1211220:

  clk: Don't parent clks until the parent is fully registered (2021-12-07 19:20:35 -0800)

----------------------------------------------------------------
A single fix for the clk framework that needed some more bake time in
linux-next. The problem is that two clks being registered at the same
time can lead to a busted clk tree if the parent isn't fully registered
by the time the child finds the parent. We rejigger the place where we
mark the parent as fully registered so that the child can't find the
parent until things are proper.

----------------------------------------------------------------
Mike Tipton (1):
      clk: Don't parent clks until the parent is fully registered

 drivers/clk/clk.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
