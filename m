Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C054F12D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356527AbiDDKN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356609AbiDDKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2F2611E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF53614D4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19250C340EE;
        Mon,  4 Apr 2022 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649067064;
        bh=X9CFGsdVTVc+q9NDBZl8mnzms1gfRIEFsm6e10Y/2cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1FpmJaPAyqfOkCOYLlXRUmfZFt2I+LfEoTWFKplC3gStvMaYD/kPA9fG357xMJJ9
         dKnARxcz6aAYVm6nhzY2ly76sH9OWJQ1n/sABgwDOSdmSSbGcFE7ho3DrzUNDZVa4f
         czlB1sJiGL4/tJCRmGZShKLjeDeli3sc4kypryL3PjD5lMArEwQJ+tyo7TAyEWDiZH
         b/KC0cPz1P2VxPLdLg0tWNMqzOQ6GSPCxLwP7t2tSe8l3byPuT+VGlkG7mo+BpPjN5
         bl9hgyTfa9xmtQqJTjm9ir5LyTOAoqcLPgLiWxDL80a06/uUKXtRiFFNkGLp9E1rBh
         2e9BZLOqRmv2A==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arch/arm64: Fix topology initialization for core scheduling
Date:   Mon,  4 Apr 2022 11:10:48 +0100
Message-Id: <164906426317.23108.12415745228600027656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220331153926.25742-1-pauld@redhat.com>
References: <20220331153926.25742-1-pauld@redhat.com>
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

On Thu, 31 Mar 2022 11:39:26 -0400, Phil Auld wrote:
> Arm64 systems rely on store_cpu_topology() to call update_siblings_masks()
> to transfer the toplogy to the various cpu masks. This needs to be done
> before the call to notify_cpu_starting() which tells the scheduler about
> each cpu found, otherwise the core scheduling data structures are setup
> in a way that does not match the actual topology.
> 
> With smt_mask not setup correctly we bail on `cpumask_weight(smt_mask) == 1`
> for !leaders in:
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arch/arm64: Fix topology initialization for core scheduling
      https://git.kernel.org/arm64/c/5524cbb1bfcd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
