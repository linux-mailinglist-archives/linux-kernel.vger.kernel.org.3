Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270DF57A7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiGST5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiGST5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C445E81C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EEC2B81D0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF7C341CF;
        Tue, 19 Jul 2022 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658260621;
        bh=d3UO8A4Osw7v+rR7PgV0CGrWVyZjgw1MjlOFFhVucLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvKz8uGGt2ad7+wPgEt2eHqxI8OIF8E+bkV6WrO3ndfWFUADZYG3YIJD4xhwAGrUG
         hMTxPv8P6HT5kh0LZE9r5SR59Be806q79/yFdTckuRTAozFcujFWiYjgE8GDGJ6/Pl
         0uzfA3V6+UZR4FvhPIz6zHhGEbTX8TXIdCgupqmLt14INLKvvX/5iVT5CbYhXRr489
         RtKLr7pR38IGvRVPpKFgVRpZiWN3mVUL7MG6sLmDvU30LuATZ6kklt5sRJTNmbJbb3
         bgM/JVQobS1b4FEOQNcPbDzXdk8ayJ4+5Fe0qXzMEdbzpNMWKfO2Jj2B0C42VFbOrk
         ynlFM2ok9cyhg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        suzuki.poulose@arm.com, Mark Rutland <mark.rutland@arm.com>,
        german.gomez@arm.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com
Subject: Re: [PATCH v3] drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX
Date:   Tue, 19 Jul 2022 20:56:49 +0100
Message-Id: <165825301043.2954553.8589641722040434945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220714061302.2715102-1-anshuman.khandual@arm.com>
References: <20220714061302.2715102-1-anshuman.khandual@arm.com>
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

On Thu, 14 Jul 2022 11:43:02 +0530, Anshuman Khandual wrote:
> The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT
> packets into the traces, if the owner of the perf event runs with required
> capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.
> 
> The value of this bit is computed in the arm_spe_event_to_pmscr() function
> but the check for capabilities happens in the pmu event init callback i.e
> arm_spe_pmu_event_init(). This suggests that the value of the CX bit should
> remain consistent for the duration of the perf session.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX
      https://git.kernel.org/will/c/92f2b8bafa3d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
