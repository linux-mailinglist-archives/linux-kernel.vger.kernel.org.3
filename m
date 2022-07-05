Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24760566CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiGEMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiGEMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC7183BC;
        Tue,  5 Jul 2022 05:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28367B817CC;
        Tue,  5 Jul 2022 12:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A71C341C7;
        Tue,  5 Jul 2022 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657022953;
        bh=gMe2Ijaw82c09SO8FL5eAqBwiWmmaGC/sirYUVrjV4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yyp5yggKgTaqkE3lKk9P7EyIRKmhnydHYGEKpT+MqyxZJQ/CDFnMtAOjK8Nhd68pB
         Np0ekJIh+/4WXcKN6nhGefi7JeHoKEtjvP60/xM75utygTBLSRiz1jf0pNXmwOdvl/
         lT/rN4D0Mdj8g4d0nHX8jUd4P8ruSZaE9RUBQm9u563I2RBWey14BmVcLMifixTjUe
         kf6XI33rwEobfKyAK/ZaxoJVByJdldyFyDIYsmCO3SWt55taFfWUphpDdxa4Vlx9Yg
         8w+MKa+jqvZKSe5jJnZ8QVLL422psnJki1MBMMcFNyfSPOkr2Y0da8WUwRzWLHW7Rh
         nUeAmjNMkuaTQ==
Date:   Tue, 5 Jul 2022 13:09:07 +0100
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
Message-ID: <20220705120907.GA1012@willie-the-truck>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
 <20220627110105.GF22095@willie-the-truck>
 <967c0a4f-c864-21ec-33f1-5e3943a42409@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967c0a4f-c864-21ec-33f1-5e3943a42409@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:10:05PM +0530, Anshuman Khandual wrote:
> 
> 
> On 6/27/22 16:31, Will Deacon wrote:
> > On Mon, Jun 13, 2022 at 03:31:11PM +0530, Anshuman Khandual wrote:
> >> This series enables perf branch stack sampling support on arm64 platform
> >> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> >> relevant register definitions could be accessed here.
> >>
> >> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> >>
> >> This series applies on v5.19-rc2 after the BRBE related perf ABI changes series
> >> (V6) that was posted earlier.
> >>
> >> https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
> >>
> >> Following issues remain inconclusive
> >>
> >> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
> >> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()
> > 
> > afaict, the capability stuff remains unresolved with the SPE driver, so I'd
> > really like to see it fixed there first before we add more broken drivers.
> > 
> > https://lore.kernel.org/r/20220118100702.GB16547@willie-the-truck
> 
> Hello Will,
> 
> I did go through the above mentioned thread, but could not understand (clear
> enough) - what needs to be done. Could you please help summerize the problem
> and possible solutions which I can start looking into. Thank you.

I don't recall any details beyond what was discussed in the thread. Your
best bet is probably to talk to James (Clark) and German, as they reported
the issue initially and you all work for the same company...

Will
