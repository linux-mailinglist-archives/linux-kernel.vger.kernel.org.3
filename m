Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC144544845
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiFIKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiFIKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C77BF6F;
        Thu,  9 Jun 2022 03:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A445561D18;
        Thu,  9 Jun 2022 10:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C715FC34114;
        Thu,  9 Jun 2022 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654768974;
        bh=fy3sOySJYMqPfYsXKFz0lzwOIVOW00fot8ATyI+aFKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7NAOLOMyNEMKzhUAG39/2KJRmzAenVdUfRcoNkvJLwRmDgK0oSRozlHKQKJVxLfH
         BjxbJ1/nI0+tTnmwNFKk1BN4ghei6IQ9HYFL5zIiPeB5bCOR6Zabd3ty0JFRSvsKxs
         AHsyhvhhhBY2IjQqc3wgeTWxVAtvDK6ibpElPPIfJb4lbH8GRNjqwaCYmiO9v9dfYc
         s5vJSAZ89CQTmo4WqSSDdfCzXXAPffcS9YjDf11xeRiQpyVg7KLHqD7rqZQds8oVga
         olqTGldbPuyIhpPSVUlnGMFD5KRNXkd4916syxyeGO0cr75fU1UGVf49uL/J3OoAOm
         csoBUD6dQxBOA==
Date:   Thu, 9 Jun 2022 11:02:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Message-ID: <20220609100247.GA2187@willie-the-truck>
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
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

On Mon, May 23, 2022 at 05:19:34PM +0530, Srinivasarao Pathipati wrote:
> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
> Make is configurable using sysctls to enable/disable at runtime.
> It can also be enabled at early bootup with kernel arguments.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V4:
> 	- Registering sysctls dynamically for only arm64 as suggested by Will
> 	- Not removed the code to configure with kernel parameters 
> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
> 	  is not working at early bootup. pmu_reset() getting called before 
> 	  sysctl's kernel parameter is set.

Why do you need this during early bootup? Perf won't program any events
until much later and if somebody else is configuring the PMU before
entering Linux then they can also set that X bit in the PMCR.

Will
