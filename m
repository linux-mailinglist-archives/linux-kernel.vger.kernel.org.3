Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE25482B95
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiABOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiABOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 09:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C6C061761;
        Sun,  2 Jan 2022 06:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BAFE60DEA;
        Sun,  2 Jan 2022 14:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EFFC36AE7;
        Sun,  2 Jan 2022 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641134066;
        bh=N2+7OPMEa1mXGoMs4YPWxkILdq5aKPiBQVJHo5HIWxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+24Xf7z+FoS8s+pL/jZQuXCK/tY20biTnl3tX+dUqG4Eybvni/tR4jHdHVJa/uVE
         0SyIBHZdHGGIsQDVAf/hZfAEhWL83XCHbY/k3MD56TaM31oTMK3P2hNGY0f7mMJpvM
         wAQbTyCoJ5b8yCFdgz53SbR/Pm0GOR3VkfN5y3sdn97L9dMPS2FJzSIzre35aXjlTQ
         izQBFFXZXl7EBnmEVtCA1AMuBMEvYvhkGu/wE5+1tsQ1FCZwpSaQsjoXPz8ZuLfRWo
         n3aOL5xl4gkaEYmV9zwpEpf3xcxv+fM2vLYzx8gTrq5vfR/b662yqeU7wd1jCXP+mK
         ovRCALXyyNexQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D71C040B92; Sun,  2 Jan 2022 11:34:23 -0300 (-03)
Date:   Sun, 2 Jan 2022 11:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengjun.xing@linux.intel.com
Subject: Re: [PATCH v2] perf pmu: Fix alias events list
Message-ID: <YdG378o4kx4zbRSo@kernel.org>
References: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
 <05dcd009-084c-b8ee-c4a5-35c0862ee26d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dcd009-084c-b8ee-c4a5-35c0862ee26d@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 28, 2021 at 09:00:18PM +0000, John Garry escreveu:
> On 21/12/2021 16:11, John Garry wrote:
> > Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> > changes the event list for uncore PMUs or arm64 heterogeneous CPU systems,
> > such that duplicate aliases are incorrectly listed per PMU (which they
> > should not be), like:
> > 
> > ./perf list
> > ...
> > unc_cbo_cache_lookup.any_es
> > [Unit: uncore_cbox L3 Lookup any request that access cache and found
> > line in E or S-state]
> > unc_cbo_cache_lookup.any_es
> > [Unit: uncore_cbox L3 Lookup any request that access cache and found
> > line in E or S-state]
> > unc_cbo_cache_lookup.any_i
> > [Unit: uncore_cbox L3 Lookup any request that access cache and found
> > line in I-state]
> > unc_cbo_cache_lookup.any_i
> > [Unit: uncore_cbox L3 Lookup any request that access cache and found
> > line in I-state]
> > ...
> > 
> > Notice how the events are listed twice.
> 
> 
> Hi Arnaldo,
> 
> Can you kindly consider picking up this change for v5.16?

Applied, will send a pull req to Linus soon.

- Arnaldo
