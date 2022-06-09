Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20E1544A50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiFILfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiFILdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D103D99EB;
        Thu,  9 Jun 2022 04:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 704D461E3E;
        Thu,  9 Jun 2022 11:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81810C34114;
        Thu,  9 Jun 2022 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654774354;
        bh=KrCsS5l82GZCvOtjV+ccEYhWmRYIStLBFNTaPu6W0wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcILwukIegunEGj6vknqW1TFQuzHnca9cROZL6SEvL9xaU0xgRVK3GgB577VtZUym
         eKYP2GHVAaU0U8hYDdpaOLFO2bYr+L1Z96Nbk548oDef1BRph5j8kxKVMMgEl5C9ps
         OdROfGRpbpU0Us7+u7Xwo2fE+kaxgYxUYvMOa1hnrO+oascfJUxOE/HTZpfqJZjXuo
         8mRk3HTeK0l79rq2BblGMGI10Oum0Lu5Dy7ivj2BBy9/ayA6iJMljU4YvV9ugahcoI
         VMhf6GKnDpPr2W8NnL4Wn94OryXOXH0+xvaHG4ciktsn5nI78H7MTsBUdo1jdmS8kl
         oOut3UHKnlDYw==
Date:   Thu, 9 Jun 2022 12:32:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Message-ID: <20220609113225.GA2326@willie-the-truck>
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220609100247.GA2187@willie-the-truck>
 <4f5dbc00-e25b-f6ff-8585-31fc50f48a21@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5dbc00-e25b-f6ff-8585-31fc50f48a21@quicinc.com>
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

[Please don't top-post]

On Thu, Jun 09, 2022 at 04:05:20PM +0530, Srinivasarao Pathipati wrote:
> On 6/9/2022 3:32 PM, Will Deacon wrote:
> > On Mon, May 23, 2022 at 05:19:34PM +0530, Srinivasarao Pathipati wrote:
> > > The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
> > > Make is configurable using sysctls to enable/disable at runtime.
> > > It can also be enabled at early bootup with kernel arguments.
> > > 
> > > Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> > > ---
> > > Changes since V4:
> > > 	- Registering sysctls dynamically for only arm64 as suggested by Will
> > > 	- Not removed the code to configure with kernel parameters
> > > 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
> > > 	  is not working at early bootup. pmu_reset() getting called before
> > > 	  sysctl's kernel parameter is set.
> > Why do you need this during early bootup? Perf won't program any events
> > until much later and if somebody else is configuring the PMU before
> > entering Linux then they can also set that X bit in the PMCR.
>
> On our Qualcomm platforms, The X bit is getting set by firmware at early
> bootup for Qualcomm use cases
> and non-secure world is resetting it, that causing issue.

What "Qualcomm use cases" and why should we care about them upstream?

Will
