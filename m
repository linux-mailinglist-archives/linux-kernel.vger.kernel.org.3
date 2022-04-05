Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E217E4F4D37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581749AbiDEXkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573310AbiDESwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F1B1AA2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C0C618DC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DE4C385A1;
        Tue,  5 Apr 2022 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184645;
        bh=wfdn8JQeJkR1VmLPe/pOEuD35DFwF3moRXVsCAPHYSc=;
        h=From:To:Cc:Subject:Date:From;
        b=U0XCcVDv1W/UIY9AS6DYtzLOt4gs8yfdz96UGfn3mVF9k7UQ7U/LXON14mQz5kwZJ
         miuBobg7fJEM1DaZqAwHIPHJltYW5+01gQi7HLKOrDE4MzEP42W2DaoacF1EvU6Eit
         8+AC22BHEu6gxrcQD38J4DM4vRy3mgNoz7zHTLG9QPhHYuCzkMTawUkKtTTBvbmkK7
         HdTQCObrjlUeVDZzBAyH3vYtMQIXjAWo50pVtlXUhYNFyLFFm3qf9b8B6lZ0J8ve3G
         vflYuku3kQRlosWS3tT0TY2nVIB9bIBirbc55Xf/sODZ3O6LSb/YALR7jOoJKTTvQS
         BK/CQR6wb7+rw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nboGI-001tpg-Un; Tue, 05 Apr 2022 19:50:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v3 0/3] genirq: Managed affinity fixes
Date:   Tue,  5 Apr 2022 19:50:37 +0100
Message-Id: <20220405185040.206297-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This small series, based on 5.18-rc1, addresses the above.

Thanks,

	M.

From v2 [4]:
  - Rebased on 5.18-rc1

[1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
[2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
[3] https://lore.kernel.org/r/20220307190625.254426-1-maz@kernel.org
[4] https://lore.kernel.org/r/20220321193608.975495-1-maz@kernel.org

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

