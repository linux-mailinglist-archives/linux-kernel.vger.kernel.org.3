Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4C4CE51D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiCEOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiCEOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:05:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836F1E6964
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NydjA5kv8ZCf0kRVe5emvW4OhDq/FOKXK8BMQgNvh20=; b=j6e82fnSkEmL4g50pNhxbOStmJ
        B2mtQnd0KrzoSnEUcDYH8Pv0KiPFuSm7E2ewr9IyYloWN+N0UwXJdYgp7sGSsO7owD3X6wBzqtbw/
        gpiqJ1SMihN7JPloFTneeItVUT07J3FvPMPOl3Yb40BWiqvRJuDWgFlynKHLwMu+Pco+rK8vZxTkv
        STb6OG4tW363WoN2ReeO2rrRW2OZYzq7U2+nIx38ipbC+S8bAjWipLprJ25DwPB5C1NElbBlq0fNq
        ZIFpJ6MPTHLxYQMvjCbOrwhPN5dknQulfqlmXlkQSFT7cjKTO/ByB0WXA6rWnxVNL9BzfXc15mvbX
        jL8RJMKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQV0x-00FX7Y-5G; Sat, 05 Mar 2022 14:04:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EC4B98685B; Sat,  5 Mar 2022 15:03:21 +0100 (CET)
Date:   Sat, 5 Mar 2022 15:03:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 04/19] context_tracking: Rename
 context_tracking_cpu_set() to context_tracking_cpu_track_user()
Message-ID: <20220305140321.GW11184@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-5-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:47:55PM +0100, Frederic Weisbecker wrote:
> context_tracking_cpu_set() is called in order to tell a CPU to track
> user/kernel transitions. Since context tracking is going to expand in
> to also track transitions from/to idle/IRQ/NMIs, the scope
> of this function name becomes too broad and needs to be made more
> specific.

The previous patches did: s/context_tracking_/ct_/ on these names, and
this one makes it longer still?
