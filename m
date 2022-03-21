Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D04E30D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352785AbiCUTii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352773AbiCUTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:38:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20175F4D4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53A76B819C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A4CC340E8;
        Mon, 21 Mar 2022 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647891426;
        bh=mdyDFnR87SqdgVH5lS4apNChXRoes9ieiuJHDVbDoys=;
        h=From:To:Cc:Subject:Date:From;
        b=GozDQScCmFdrYD9sTEwf7iLkWtx54elNr3lAMk7fIZnSPjbh4NRWrYhkqATVhX9Uh
         z661dxQtXo8HjcWMkoDjFk35R9RLDDyzkW6fs54n5PFYY93sBRdTNCiirXffbjJiE6
         3xxNVU83OmGrerp51p48+IlzBzgYpnGdllzEFSPRiVwrmKCGCXrVsan5uQDc4MNGMa
         daenQ9mUDoXRUGileMlk4XnEqvLzzd/lPPkG0w9FtcQ3hvKsqargJBeD4qdvOY/qlw
         V8dT+PCg9vQd7AYklmLGKDbN8soDfHrXhWQzYvzce6Znx9gm95GCgPTnHX7U48u22+
         phI2fitVATMmw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWNpw-00G5T9-9s; Mon, 21 Mar 2022 19:37:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v2 0/3] genirq: Managed affinity fixes
Date:   Mon, 21 Mar 2022 19:36:05 +0000
Message-Id: <20220321193608.975495-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John (and later on David) reported[1] a while ago that booting with
maxcpus=1, managed affinity devices would fail to get the interrupts
that were associated with offlined CPUs.

Similarly, Xiongfeng reported[2] that the GICv3 ITS would sometime use
non-housekeeping CPUs instead of the affinity that was passed down as
a parameter.

[1] can be fixed by not trying to activate these interrupts if no CPU
that can satisfy the affinity is present (a patch addressing this was
already posted[3])

[2] is a consequence of affinities containing non-online CPUs being
passed down to the interrupt controller driver and the ITS driver
trying to paper over that by ignoring the affinity parameter and doing
its own (stupid) thing. It would be better to (a) get the core code to
remove the offline CPUs from the affinity mask at all times, and (b)
fix the drivers so that they can trust the core code not to trip them.

This small series, based on 5.17, addresses the above.

Thanks,

	M.

[1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
[2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
[3] https://lore.kernel.org/r/20220307190625.254426-1-maz@kernel.org

Marc Zyngier (3):
  genirq/msi: Shutdown managed interrupts with unsatifiable affinities
  genirq: Always limit the affinity to online CPUs
  irqchip/gic-v3: Always trust the managed affinity provided by the core
    code

 drivers/irqchip/irq-gic-v3-its.c |  2 +-
 kernel/irq/manage.c              | 25 +++++++++++++++++--------
 kernel/irq/msi.c                 | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.34.1

