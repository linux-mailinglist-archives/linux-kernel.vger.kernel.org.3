Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF24CE51F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiCEOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiCEOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:06:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD241B8BE7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s2gzJ3YeAP3zh2Og5Gzof5objO1x4T+HW0ztLcuRCwU=; b=iagpeSWZ+NE5ScPFnF+QMtbuTZ
        jpxKZIo7WZqp0ONC4eBDlXTNpRFnyFhtnQFZWwq//qKHKQ1Ge7vcdkt0DyfHFCJy9zAEGM6Qyoits
        M2H5GaDYwdr/yhEQQ2IaMQHXvKlpHgZ0OQvbA7M0fmnY5mxRjT2bWyct2Jj/H/9njxVcolHxSBtVF
        Uk1UWJsYrgUC1MVfWwGiRTs0Jcji53TTrDH2wL/PFW0GwEkxL7nyu3ceNjV3m+FXnMgLAWbssCgtz
        Bqf55yHP80Fqgwq3H5WrQwQP6vN0em1x6jV/AzyE8nQX5l48EwqMpPO7LKJ8WoD+rTWVFTyBHMZYV
        4IRnQxWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQV2G-00Dcyf-4U; Sat, 05 Mar 2022 14:05:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76CF998685B; Sat,  5 Mar 2022 15:05:26 +0100 (CET)
Date:   Sat, 5 Mar 2022 15:05:26 +0100
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
Subject: Re: [PATCH 06/19] context_tracking: Take idle eqs entrypoints over
 RCU
Message-ID: <20220305140526.GX11184@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-7-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:47:57PM +0100, Frederic Weisbecker wrote:
> The RCU dynticks counter is going to be merged into the context tracking
> subsystem. Start with moving the idle extended quiescent states
> entrypoints to RCU. For now those are dumb redirection to existing RCU
> calls.

s/to/from/ right? You're taking them away from RCU and moving them to
ct.
