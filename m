Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2936544E12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiFINwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiFINwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F707B9D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3277561D65
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45DEC3411B;
        Thu,  9 Jun 2022 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654782717;
        bh=Gc7pkwVKw7goUZjfI06x1B7/bd+4gUEXa31OZI6JBp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rePiUSeVJYQ5OCj/9/lBtjqh9nLQjkfzT/0dIVFI5n/+Z3nr1eXNiYvGaiLixdfln
         KeLXIWKmxyv08MGYCRGb/Sdnjjg0H+V+dY/KfAXXnMAq/K4BGAComEJ/P4owjB6utY
         fm2RoDeALap9ClV/mS/Hv6pWPjz/uKb6JItDxLxy8MLAznyjFkCC/qGjdDBdGm6cm7
         roDonxJ+1ucsMDh+Ond7bUxEW8zP17CTFdCZHVR+M4epOVGtt2gNfEMNEero3T2fn0
         POLEfjv6bnzH3FwsAYXOR8VyQqfd5kCHH2LT7IS/SVcCgol5nKOx7B1u8ohUmVrCMp
         iNnhWVHIri63A==
Date:   Thu, 9 Jun 2022 14:51:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@rivosinc.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, jszhang@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
Subject: Re: [PATCH v2  0/3] Miscellaneous fixes for PMU driver
Message-ID: <20220609135151.GA3064@willie-the-truck>
References: <20220513015522.910856-1-atishp@rivosinc.com>
 <mhng-ba83da39-dadf-4d6e-99be-a1b5fdf9b62c@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-ba83da39-dadf-4d6e-99be-a1b5fdf9b62c@palmer-ri-x1c9>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

On Wed, Jun 01, 2022 at 10:58:08PM -0700, Palmer Dabbelt wrote:
> On Thu, 12 May 2022 18:55:19 PDT (-0700), Atish Patra wrote:
> > This series fixes issues PMU driver code.
> > PATCH 1 & 3 are fixes for rv32 while PATCH 2 fixes a redundant
> > user page update issue during counter start.
> > 
> > Changes from v1->v2:
> > 1. Add proper compile time rv32 checks.
> > 
> > Atish Patra (3):
> > RISC-V: Fix counter restart during overflow for RV32
> > RISC-V: Update user page mapping only once during start
> > RISC-V: Fix SBI PMU calls for RV32
> > 
> > drivers/perf/riscv_pmu.c     |  1 -
> > drivers/perf/riscv_pmu_sbi.c | 16 ++++++++++++++++
> > 2 files changed, 16 insertions(+), 1 deletion(-)
> 
> +Will and Mark.
> 
> Will recently took some stuff for drivers/perf/riscv_* into his
> for-next/perf tree (which I didn't even know about until then, oops), but
> the previous stuff I took through the RISC-V tree.  Always happy to get
> stuff out of my tree, just LMK what you want me to do here.
> 
> I did some minor cleanups to the commit text and put them over at
> palmer/riscv-pmu_fixes, it's all passing my tests.  These generally look
> fine to me and they're all stable backports, so no big rush on the merge
> window (which I still have stuff for).

I don't have any perf driver fixes queued at the moment, so please just
include these changes along with any other riscv fixes you have.

Thanks,

Will
