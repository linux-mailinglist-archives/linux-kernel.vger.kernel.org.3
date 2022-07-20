Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C757B455
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiGTKPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGTKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904E64C0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E37361B96
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91CFC3411E;
        Wed, 20 Jul 2022 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658312116;
        bh=97Yj+3BuPeWOs3UOfuprKyTGDQLRwch8W/HAJ7gy9rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUg57HQ94kmU7t3dKGdReyFlaUv/py2WRe2lH4d6p0en5wzjbLDc1Auahx+HzSNU9
         sZfD38V5uPfHxgi11VvFG4gnB5uFqhu6HCkSXgGu4RfA2QJ31vBtA0SRSOrhm193vb
         zNfgMUrEdKVdzanrUpurOj1libVHXSdB2ozpiQWXr/Fx6MHsZxmIxy33rPbSFPrfcn
         0E+U9Xkn3QTMXepJxSOyC59v+ZrP/80pGLxn/CbUi8gAttT/gq/hF9lcFME5YtcqJA
         t1co2uNS8u9Pv1CKSKMhRwuh4m16aAe1e7fqlTSWjUl7okcC4SZ5B0qX5ch0pBPHa/
         DEX8KzQP3PcGw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-mm@kvack.org, steven.price@arm.com,
        anshuman.khandual@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        guojian@oppo.com, ying.huang@intel.com, hughd@google.com,
        hanchuanhua@oppo.com, v-songbaohua@oppo.com, hannes@cmpxchg.org,
        minchan@kernel.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        shy828301@gmail.com
Subject: Re: [PATCH v4] arm64: enable THP_SWAP for arm64
Date:   Wed, 20 Jul 2022 11:15:09 +0100
Message-Id: <165831076076.3414765.4205578904635194044.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220720093737.133375-1-21cnbao@gmail.com>
References: <20220720093737.133375-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 21:37:37 +1200, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> THP_SWAP has been proven to improve the swap throughput significantly
> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> splitting THP after swapped out").
> As long as arm64 uses 4K page size, it is quite similar with x86_64
> by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
> enabling it on arm64 will benefit arm64 as well.
> A corner case is that MTE has an assumption that only base pages
> can be swapped. We won't enable THP_SWAP for ARM64 hardware with
> MTE support until MTE is reworked to coexist with THP_SWAP.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: enable THP_SWAP for arm64
      https://git.kernel.org/arm64/c/d0637c505f8a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
