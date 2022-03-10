Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F624D4467
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiCJKWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCJKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ED13DE15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A95A60B98
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C750C340E8;
        Thu, 10 Mar 2022 10:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646907691;
        bh=wLgF2q2FHKkdCuQlc013xZj5LEG8U5jgFQSDjeZp89k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLu+RpE9XzmM9+WiDldKDVnlcj0zXaK6H4lLPv8hqzSKXJ0qMgoq8/RW5iUT30kE9
         KU6KexdtcFIj8KdI1WhaZztc3nUBNt5kDsQSQo+ggR25aQV7z5ht/cQgXr96n34MSp
         xIyieG7vmj5Ro8mnadU27Rh9EiPvvGDixJRWF7qCFr4Isg0iHuwKnx/lsNzGgjNr97
         egT0xWl1UDjbRyySdyDkdpuAlsontUgWhofOnP6R23pk6YHOwyw5SAhxLajIJe3cmf
         VuQac4Uvp7MgoZh9FEdodQ2jNKkAP7LmxPmSzmBrl05ZWK/DA9JzYDlLR6QbvYlnPB
         2BhLQYYfwjMeA==
Date:   Thu, 10 Mar 2022 10:21:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] perf/marvell: cn10k Fix build error without
 CONFIG_OF
Message-ID: <20220310102125.GA1883@willie-the-truck>
References: <20220310065045.24772-1-yuehaibing@huawei.com>
 <20220310095852.GA1699@willie-the-truck>
 <CAK8P3a2=iRLqM36wwxtQRrCwrZ2-tkBZPZCqqba-4kmk9GxcCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2=iRLqM36wwxtQRrCwrZ2-tkBZPZCqqba-4kmk9GxcCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:04:21AM +0100, Arnd Bergmann wrote:
> On Thu, Mar 10, 2022 at 10:58 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Mar 10, 2022 at 02:50:45PM +0800, YueHaibing wrote:
> >
> > Ah, sorry, I already fixed this when the conflict was first reported:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=6676a42f1e4f1b8ec166b723a3801b7113c25a0e
> >
> > However, I thought this driver could be compile-tested on architectures
> > without OF and then we'd get some report from that? At least, I'm certain
> > I've _added_ these ifdefs to other PMU drivers in the past.
> 
> The #ifdefs are never really needed, the only reason to have them is
> to save a few bytes on architectures that don't normally use DT,
> at the expense of making it slightly less readable.
> 
> For compile-testing purposes we don't care about the size of the module,
> and compiling in the table unconditionally is easier.

I think the problem is when the #ifdefs are removed but the use of
of_match_ptr() remains, leading to reports from the robot:

https://lore.kernel.org/r/202201041700.01KZEzhb-lkp@intel.com

Should we therefore remove of_match_ptr() altogether? It seems like it's
leading people in the wrong direction here.

Will
