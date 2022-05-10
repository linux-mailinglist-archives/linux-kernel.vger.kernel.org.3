Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1045210E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiEJJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiEJJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F328D4F5;
        Tue, 10 May 2022 02:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE3BC611C1;
        Tue, 10 May 2022 09:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF8DC385C9;
        Tue, 10 May 2022 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652174931;
        bh=e453tsqNEiBTDG4J5o9LjYD7il3/hz8Pgpd2NEFg2So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3U5w4CpPkiUi5qAbhUDdydANAnIQusOm8Snz2IVg+gHBZAMP/Wo/c/n4o4JKX2XG
         BTSjr2n00ge84L22bFjEIM013CmRh/xeJU0KaRL2tcL1Qb2Ijl9aZvN9DYlDyOeCAs
         oPejToArvVU8FLb/NKuQeI6fQ2y7r0tqr4dLjX/nn7w4F+WllpV9HelOR2rZ8XJGqn
         IZDaLecUSt1vVWVHQQLJIAgFZt0mHhC77Fb4cJnjQaQ7frTGjNYCXATwC8+mxW3Zrf
         +sm3QMrW2e8gQSQuA/RChF1DQF4ivIMqN8eZrivGqcOVWMHNZdG2FDI/xjojZLVU40
         2wBDnR8TzTIwQ==
Date:   Tue, 10 May 2022 10:28:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Message-ID: <20220510092843.GB27219@willie-the-truck>
References: <1652117330-21976-1-git-send-email-quic_c_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652117330-21976-1-git-send-email-quic_c_spathi@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:58:50PM +0530, Srinivasarao Pathipati wrote:
> Preserve the bit PMCR.X of PMCR_EL0 during PMU reset to export
> PMU events. as it could be set before PMU initialization.
> 
> Exporting events could result in additional power consumption
> so making it configurable.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V2:
> 	Done below changes as per Will's comments
> 	- enabling pmcr_x now configurable with kernel parameters and
> 	  by default it is disabled.
> 	
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment.
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/arm64/kernel/perf_event.c                  | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index de3da15..cf3410e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5150,6 +5150,10 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	retain_pmcr_x
> +			[KNL] Retain export bit of PMCR_EL0 that is getting reset
> +			during pmu reset.

I think it would be better to build this as a sysctl so that it can be
toggled at runtime as well.

Will
