Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45102475AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbhLOOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhLOOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:30:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A2D4B81F4D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFDC34604;
        Wed, 15 Dec 2021 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639578624;
        bh=euW7M7PGgHg0TTWjhkTrtfp9cJF+WeHRjrk4IVhmJM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICVKieu4pR1N/KC3YyEyZqs5w4/kbm7qGVVLbF8/rRGj8LE1F6a8XLi0Y3uwR+E+k
         xYvJ4JVWsr5doXI3OdUQ5XVX94PB7WUl+quh9g01lCXoE7+zZAWOq+nTHiy4Po2n+e
         z9k2OBiw9fRQU1p9AAGMt2VaEecvF0UCY6SfBiywIkw1va4UBNFpstvK9j3IRHykmX
         vQXOZ0nwhUyFLtBwDuoXmY4PxE4e/z7bVI/Y24iLLnpLAu6ZBxTnQuc+UHMI0jyCj6
         ShPTLOzcgynDDOAwEOdXrYk6FQbGHSeSCCNYVsBVWbvUQFaGOIZbiS1+8Xrp6+giKn
         ZAdTl38B788og==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxVIU-00CIR5-GN; Wed, 15 Dec 2021 14:30:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/6] KVM: arm64: Miscellaneous pkvm fixes
Date:   Wed, 15 Dec 2021 14:30:19 +0000
Message-Id: <163957861285.209889.493127869759455971.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
References: <20211208152300.2478542-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, will@kernel.org, qperret@google.com, james.morse@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 15:22:53 +0000, Quentin Perret wrote:
> This series is a collection of various fixes and cleanups for KVM/arm64
> when running in nVHE protected mode. The first two patches are real
> fixes/improvements, the following two are minor cleanups, and the last
> two help satisfy my paranoia so they're certainly optional.
> 
> Cheers!
> Quentin
> 
> [...]

Applied to next, thanks!

[1/6] KVM: arm64: pkvm: Fix hyp_pool max order
      commit: 34b43a8849229e8363c19236ecdf463b7a89d085
[2/6] KVM: arm64: pkvm: Disable GICv2 support
      commit: a770ee80e66270a7df183dda5ad6df4e8c8ab615
[3/6] KVM: arm64: Make the hyp memory pool static
      commit: 53a563b01fa2ae2376a0b7d547f26a0ae9c78b5c
[4/6] KVM: arm64: Make __io_map_base static
      commit: 473a3efbafaa9ffd06c8b8f653f24c97b5ac3ff0
[5/6] KVM: arm64: pkvm: Stub io map functions
      commit: bff01cb6b1bf68052739eb6155132f7d6d974208
[6/6] KVM: arm64: pkvm: Make kvm_host_owns_hyp_mappings() robust to VHE
      commit: 64a1fbda59f4b14adde7f21cda687e2b9703b7bb

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


