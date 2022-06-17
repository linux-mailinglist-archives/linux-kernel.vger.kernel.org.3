Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD854F2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380879AbiFQIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380880AbiFQIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04806833F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D01061FC5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB40DC3411C;
        Fri, 17 Jun 2022 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655454097;
        bh=TVBg5TUqmJ3DbwyAKF9/lGS3yxg1EAZzDLwreRtXFR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hClBi+dIgHgInU5OuG2o9R0VySfMitU7OtMISNX58Tg011LM1/7OtL/u79W8VhtSm
         28cfnwF/5QA3ZMDjwCk5Yqo1UnclL4zXkjbPvXI6cS2BVGPTe5AWbaSqTHvyqAGkz2
         yl9Sml25UenvNnq2dl4QQ6VJQdtGJjt3e5LUarBfRAz4KRlOgXkIwx1zZr45BpPpE7
         RsjGWNQ09VUxFwGRqArg9L41CaRM12NMISCb/UoEw60Fh+e5GkzuyM5OcYY1BjyEQd
         ag/H9uxd+tEMq1N2F0H4/SXerY8sKj70fMiBYApZzCUdLhSY1HGc/P4nEvKRb7SlpJ
         hxKUZ6qZlHZug==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o27EU-001F6o-Ig;
        Fri, 17 Jun 2022 09:21:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Quentin Perret <qperret@google.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Date:   Fri, 17 Jun 2022 09:21:31 +0100
Message-Id: <165545408679.771055.5076080259874437048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616161135.3997786-1-qperret@google.com>
References: <20220616161135.3997786-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, qperret@google.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, james.morse@arm.com, will@kernel.org, rppt@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 16:11:34 +0000, Quentin Perret wrote:
> Commit a7259df76702 ("memblock: make memblock_find_in_range method
> private") changed the API using which memory is reserved for the pKVM
> hypervisor. However, it seems that memblock_phys_alloc() differs
> from the original API in terms of kmemleak semantics -- the old one
> excluded the reserved regions from kmemleak scans when the new one
> doesn't seem to. Unfortunately, when protected KVM is enabled, all
> kernel accesses to pKVM-private memory result in a fatal exception,
> which can now happen because of kmemleak scans:
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Prevent kmemleak from accessing pKVM memory
      commit: 9e5afa8a537f742bccc2cd91bc0bef4b6483ee98

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

