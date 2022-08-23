Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774859E59E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbiHWPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbiHWPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:04:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2E120165
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0860B81CEF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDBDC43140;
        Tue, 23 Aug 2022 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254470;
        bh=bZrwY3nZFbVIYroEmLfhzzZZkooyqoBVrygLJyPh+bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVh7JOHxG/01ZdnyQ+PiCQWQ7i2NaJKkm7dBJ2vaG2we5aq14DS6x+GczwSUjuXWw
         ThdBM8HOwWH7Y6zpyshZyfigh/YTRrKbWUjI8ZlBT1Jpuvp07pxfoXPorU7CRLMvZr
         DkWSeFyEUWvEnu4alnC7EUcyyz6O1jwGmnKfWotsonniFzH4qnQ4Cfq2w/I289ncQl
         HuWIvCovbKsxhHHS+bXapDYb9MqwrqT4ysHlLJPA8eSEZqXnws6Qq7MTApA6YkYmVK
         Lnz25RYoQ/v+Erw/YnHmoX9SW3kUBgOKb3CaVZsYyi/fV4wdHsyj4FkuISA4PWkoTP
         ZqJv6jySKeXIg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly
Date:   Tue, 23 Aug 2022 12:34:18 +0100
Message-Id: <166124920909.3125510.14641802856541265933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819103050.24211-1-ionela.voinescu@arm.com>
References: <20220819103050.24211-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:30:50 +0100, Ionela Voinescu wrote:
> The AMU counter AMEVCNTR01 (constant counter) should increment at the same
> rate as the system counter. On affected Cortex-A510 cores, AMEVCNTR01
> increments incorrectly giving a significantly higher output value. This
> results in inaccurate task scheduler utilization tracking and incorrect
> feedback on CPU frequency.
> 
> Work around this problem by returning 0 when reading the affected counter
> in key locations that results in disabling all users of this counter from
> using it either for frequency invariance or as FFH reference counter. This
> effect is the same to firmware disabling affected counters.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly
      https://git.kernel.org/arm64/c/e89d120c4b72

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
