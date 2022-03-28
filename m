Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352FA4E9610
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiC1MBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiC1MBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:01:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C31FD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyQhY95RNsCK4Pvvmfcn6PT7x9nJFEOteS09X0MJ5gc=; b=InedvJYkxngIeEPtMsu0qc2tRm
        V4VMLB5/wuDOLAUFEvYfK9ZL3hrr6Iw3AFTHeBZZyWZfUx6YSRRIkUfBIYWvUPSuN+6d9+g6WB2D2
        16wOx2KwxVH+F1/NS91y4XziCmgGqsL3eaHou4ZO99Da/UN91P8qfChyu/CfzsaudJoDGF4w2Rp2j
        1dVBWWzIePh394HgRA1XA+fi5rTXrdTiYlVXJ62YW0K4GBQNK9QPHxVmJnghZzgsCQb2LhkxdRIFb
        ryVvHt/QEZGtowPPi+xTKq6c5q68waGzcFZkQ2bnY6KcAVauT2O8njz/z8/inqE6AQFnagRLAGrfj
        BKw/6N0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYo1F-005QtX-1J; Mon, 28 Mar 2022 11:58:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A36C39861E7; Mon, 28 Mar 2022 13:58:44 +0200 (CEST)
Date:   Mon, 28 Mar 2022 13:58:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: topology: add input parameter for
 sched_domain_flags_f()
Message-ID: <20220328115844.GC8939@worktop.programming.kicks-ass.net>
References: <1648461219-4333-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648461219-4333-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 02:53:37AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> sched_domain_flags_f() are statically set now, but actually, we can get a
> lot of necessary information based on the cpu_map. e.g. we can know whether
> its cache is shared.
> 
> Allows custom extension without affecting current.

This all still makes absolutely no sense. The architecture builds these
masks, the architecture is in charge of which flags function is called
on which mask.

Passing the mask back in means it lost the plot somewhere and doens't
know wth it's doing anymore.

NAK
