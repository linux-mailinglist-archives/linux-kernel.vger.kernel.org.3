Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A015775CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGQKqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:46:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498013D5F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9581BB80DA1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECBFC3411E;
        Sun, 17 Jul 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658054805;
        bh=QNZQ2MZGQpxSYRr7TfR+EAN42ddO5VU2MTMf/qjwilQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJWIR1yGZWYGsqQM1lyLeN5MS7r/pKyJtHbApPHuamPyCo2gLPQw02jGyIQQUVtQ3
         4M+7+jEqRF15IbwPRW+inPL9/pWIhFU9tASwyZCMG7LcYvgACn0gsKu0Mz8HavlgT4
         4DLpOq5rW8jxMaAUmUTeRPRMFkEpk1L08jAel81Mrj66x6LD4uKByD4p/RyrlHloQM
         rB4Ep6kjYRSCDhTOK/dl1V/bU2Kxv7L9aZ8ZzNHt0pR4JWNL5GCU0rQdEpAvYRxrSA
         /T1kKzq6x/QjpalenOb6ELyfoXYsCKrnGdmgVohZq1oGx1c+VwgehYFlmYPGGfK3M+
         7cEVq8pud+Nwg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oD1nP-007zrB-5U;
        Sun, 17 Jul 2022 11:46:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     mark.rutland@arm.com, broonie@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>, tabba@google.com,
        madvenka@linux.microsoft.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, will@kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        qperret@google.com, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: Fix hypervisor address symbolization
Date:   Sun, 17 Jul 2022 11:46:39 +0100
Message-Id: <165805475449.3537183.8979480362090216052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715235824.2549012-1-kaleshsingh@google.com>
References: <20220715235824.2549012-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, broonie@kernel.org, kaleshsingh@google.com, tabba@google.com, madvenka@linux.microsoft.com, linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com, james.morse@arm.com, will@kernel.org, alexandru.elisei@arm.com, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, qperret@google.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:58:24 -0700, Kalesh Singh wrote:
> With CONFIG_RANDOMIZE_BASE=y vmlinux addresses will resolve correctly
> from kallsyms. Fix this by adding the KASLR offset before printing the
> symbols.
> 
> Based on arm64 for-next/stacktrace.

Applied to next, thanks!

[1/1] KVM: arm64: Fix hypervisor address symbolization
      commit: ed6313a93fd11d2015ad17046f3c418bf6a8dab1

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

