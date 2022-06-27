Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6762655C47C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiF0LBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiF0LBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:01:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860B6470;
        Mon, 27 Jun 2022 04:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3302CB810A3;
        Mon, 27 Jun 2022 11:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5391C3411D;
        Mon, 27 Jun 2022 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656327672;
        bh=dnVo2kKU4XfL2p5JbW7BGQOVgWSy6yL9g0TtFxZ2uJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOuDenptTw43xrEUM45YSwOY3l2Z1fhndBUy9ZoEFd/dGBAYgGa3Fwak2NmUv4VOG
         lprN6GaJghhxI+q0fwCIO+Ih1+XH3IsopttRnP05SwWVIPQPqQFeqr/cjG7gvUs10d
         198E9elLVuW2OCv24ftya9bTi4Ykchgv9MHsLUxWv9xp0fZ+2RvlFDje1iPuJFfFH0
         bKt2L2EAyj5TCGjEegZWLxZEtr5/2NkqzBPL1TL0mosGkgNrrzj85owf5HKD3wS/QL
         V91ir/tEEy3VVpUTyH2BItNhLruqJBbktbJByhsAv2laT40rCTxWoQCBwRWSZttkYu
         wrj9OQ/pzYGZw==
Date:   Mon, 27 Jun 2022 12:01:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64/perf: Enable branch stack sampling
Message-ID: <20220627110105.GF22095@willie-the-truck>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613100119.684673-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 03:31:11PM +0530, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v5.19-rc2 after the BRBE related perf ABI changes series
> (V6) that was posted earlier.
> 
> https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
> 
> Following issues remain inconclusive
> 
> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()

afaict, the capability stuff remains unresolved with the SPE driver, so I'd
really like to see it fixed there first before we add more broken drivers.

https://lore.kernel.org/r/20220118100702.GB16547@willie-the-truck

Will
