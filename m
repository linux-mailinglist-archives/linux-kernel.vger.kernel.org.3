Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DBD4D0A77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiCGWE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiCGWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525B3EBB1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B1160E86
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A11FC340F4;
        Mon,  7 Mar 2022 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690641;
        bh=eML+mXbrz8NqDLgzfhQWImuhtIydF79CzMrKHyuarBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKw1hmd2i4Hy/pKIAWmbC3480zZj4YrqS2hm2Tc4yB1Od+q549vbL71GCwQTcEJjW
         FBF9H1O8OFL+rIcE7sa408ICMJQM/3VH1NOPqxGmfu8Q4xcQY+9LnTEEBOI8K+jwJS
         OsZmnOiJ9sqHIhzenth4Be8iKCeTY1chCfXUatH4jtvy9r75tQ/74/1VAdfzv/E0uX
         jQgjRUwDbFHPQabaV1O1VKgbO35fIh7xdCZ2JRsX7zsAVf+cAgUVzA+HUVTXkYU/mp
         UdGlU1IjtDxJs6N2EFzWaKWPtyD1cmld+5FijS5uOiX/m81yKqGNTejlY/BEJBiK0S
         jJwRoNccbOf+A==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, Linu Cherian <lcherian@marvell.com>,
        maz@kernel.org, tglx@linutronix.de
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linuc.decode@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
Date:   Mon,  7 Mar 2022 22:03:32 +0000
Message-Id: <164668950224.3277206.2552145973830842260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220307143014.22758-1-lcherian@marvell.com>
References: <20220307143014.22758-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 20:00:14 +0530, Linu Cherian wrote:
> When a IAR register read races with a GIC interrupt RELEASE event,
> GIC-CPU interface could wrongly return a valid INTID to the CPU
> for an interrupt that is already released(non activated) instead of 0x3ff.
> 
> As a side effect, an interrupt handler could run twice, once with
> interrupt priority and then with idle priority.
> 
> [...]

Applied to arm64 (for-next/errata), thanks!

[1/1] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
      https://git.kernel.org/arm64/c/24a147bcef8c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
