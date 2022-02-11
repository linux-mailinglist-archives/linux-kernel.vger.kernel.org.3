Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06D4B23CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiBKLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:00:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348486AbiBKLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:00:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B64B8D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34812B8295F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A6BC340E9;
        Fri, 11 Feb 2022 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644577243;
        bh=WZh92pBykqginvZPNJngAk5IQaG4PsTh3eny5HQUrK8=;
        h=From:To:Cc:Subject:Date:From;
        b=IpU7mhq2wn8iKk3WCLhXj5odsr5xWlLEpuw2otHzm60UgIPrwFxuU+AeuPJpRXen0
         V58PorHER+3MWBzY1G2PPUNB8Yhabv38i/mw4tKLazJiL7qO2ajChk2l9SBrF5GzZU
         CtLRAZFXNY2ld+18cxxVPVbNtMNZUWDXu0o8ATwALqr17Pt0HOndEI4B5KY+DZ1U32
         AZ0to3OLliE7LG9wfCv33CvOHA1+bq7hjJpkdd0nP55gOC/TEPk/Pwvr4LaVePut1L
         GS5DGvERe+bTQlL9N/A/pjNHviTrSOCig+rszkVHXwyN9ILpjiy88m8kTgX0m8iKrb
         rndIsF4xBuUEw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nITfN-00794F-1C; Fri, 11 Feb 2022 11:00:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Steev Klimaszewski <steev@kali.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.17, take #2
Date:   Fri, 11 Feb 2022 11:00:38 +0000
Message-Id: <20220211110038.1179155-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, anup@brainfault.org, guoren@linux.alibaba.com, heiko@sntech.de, palmer@dabbelt.com, robh+dt@kernel.org, robh@kernel.org, samuel@sholland.org, steev@kali.org, valentin.schneider@arm.com, linux-kernel@vger.kernel.org, kernel-team@android.com
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

Hi Thomas,

Here's a couple of fixes for 5.17. One is a fix for a missing DT
matching string in the PLIC driver, and the other addresses a minor
regression on observed on some Qualcomm systems.

Please pull,

	M.

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.17-2

for you to fetch changes up to 1d4df649cbb4b26d19bea38ecff4b65b10a1bbca:

  irqchip/sifive-plic: Add missing thead,c900-plic match string (2022-02-02 10:49:29 +0000)

----------------------------------------------------------------
irqchip fixes for 5.17, take #2

- Don't register a hotplug notifier on GICv3 systems that advertise
  LPI support, but have no ITS to make use of it

- Add missing DT matching for the thead,c900-plic variant of the
  SiFive PLIC

----------------------------------------------------------------
Guo Ren (2):
      dt-bindings: update riscv plic compatible string
      irqchip/sifive-plic: Add missing thead,c900-plic match string

Marc Zyngier (1):
      irqchip/gic-v3-its: Skip HP notifier when no ITS is registered

 .../interrupt-controller/sifive,plic-1.0.0.yaml     | 21 +++++++++++++++------
 drivers/irqchip/irq-gic-v3-its.c                    |  3 +++
 drivers/irqchip/irq-sifive-plic.c                   |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)
