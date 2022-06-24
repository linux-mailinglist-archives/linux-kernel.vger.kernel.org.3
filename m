Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F02559EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFXQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182E4739D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735BC6231F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79927C3411C;
        Fri, 24 Jun 2022 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089618;
        bh=oOY756ivqAWkyi0wZqS905zKFdWvBVlqssZgNz5e0mY=;
        h=From:To:Cc:Subject:Date:From;
        b=TpSZ9hJ7QVa4bdxBmwtw5WqBn81AiCZscDsQBYgk14IaXGr2BIzdcmhUmexcNa6Ku
         RztNIcaNl9ijSbLHVsVGrMNsAUk45Ak4zs1/S7oe1pOVKScxN6IgRTlTHjtFr8Izhd
         WC7BwVKwAKaNuTAAx1fiLSUx8ar4zc/4hfPlA3HC4UWRnDzwcai+492UuHsYKnAblD
         F8TzTSRmbgbKJQMpNPspG3S8WaNnuZ5L7Gb7gWtVBn/vLfk06WNODOQUIWOn5oosGc
         1rWMg+1//yEYJHS/qMHLKEHsMa4P7ps97W6WWnlPRT2SMZ0ZswzqFsw51XdIy2OJLO
         J12HPNlkHDybA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.19-rc3
Date:   Fri, 24 Jun 2022 17:53:28 +0100
Message-Id: <20220624165338.79927C3411C@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.19-rc3

for you to fetch changes up to 3f05010f243be06478a9b11cfce0ce994f5a0890:

  regmap-irq: Fix offset/index mismatch in read_sub_irq_data() (2022-06-22 11:59:52 +0100)

----------------------------------------------------------------
regmap: Fixes for v5.19

Two sets of fixes - one for things that were missed with the support for
custom bulk I/O operations introduced in the last merge window, and
another for some long standing issues with regmap-irq which affect a
fairly small subset of devices.

----------------------------------------------------------------
Aidan MacDonald (2):
      regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
      regmap-irq: Fix offset/index mismatch in read_sub_irq_data()

Javier Martinez Canillas (3):
      regmap: Re-introduce bulk read support check in regmap_bulk_read()
      regmap: Make regmap_noinc_read() return -ENOTSUPP if map->read isn't set
      regmap: Wire up regmap_config provided bulk write in missed functions

 drivers/base/regmap/regmap-irq.c |  8 +++++---
 drivers/base/regmap/regmap.c     | 15 ++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)
