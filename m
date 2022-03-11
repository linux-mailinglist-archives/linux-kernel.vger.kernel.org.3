Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5E4D6087
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiCKL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiCKL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:26:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF36FD30
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZE/E1yBtweQiBf4QxRUsUJDn0xX2Xkh/fwqViDIbpI=; b=Av4soCHNkoKtyXt0Z3LEdsRAMP
        yXb+QGl7U3nz8nVP8zK9a4Jnd4CSf5TDrlASKTvWJuSSddWB/mXTxDa5WacCsiMjreVbdJE8/ZRvu
        QjyG28IeentB/04NBMCn1PwV8aO4am2cua8jHb/rxAloUBukMuPssudFU6dZWQRLZiff8xoG8lad5
        O24CCz/aVUx66GSwLjYg7xhaLJSvHDO2/nID7EA3V5o+XnAY1bJ18mejQ2HSIFaiAojKMJ13XZAIY
        JZHhwNvpGTIxI1iA6FFFQzkRFI/txOOoF8Rc1Pojh3KrcdbCbr7NmwwHXwfUdQHBF3nZJL3a4qOZU
        uUTPXcbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSdOA-00HQPJ-2t; Fri, 11 Mar 2022 11:24:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 165EE3001C0;
        Fri, 11 Mar 2022 12:24:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCA812C5BAC25; Fri, 11 Mar 2022 12:24:51 +0100 (CET)
Date:   Fri, 11 Mar 2022 12:24:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Message-ID: <Yisxg3izMrGVahOQ@hirez.programming.kicks-ass.net>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 04:58:44AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Some architectures(e.g. ARM64), caches are implemented below:
> cluster:              ****** cluster 0 *****      ****** cluster 1 *****
> core:                 0      1      2      3      4      5      6      7
> cache(Leveln):        **cache0**   **cache1**	 **cache2**   **cache3**
> sd_llc_id(current):   0      0      0      0      4      4      4      4
> sd_llc_id(should be): 0      0      2      2      4      4      6      6
> 
> Caches and cpus have different topology, this causes cpus_share_cache()
> return the wrong value, which will affect the CPU load balance.
> 
> Cache topology should be separated with CPU topology, it can be obtained
> from "next-level-cache" in DTS preferentially.

If your clusters do not have cache, then you're currently setting
SD_SHARE_PKG_RESOURCES wrong, if they do, things are correct.

If you want to represent L2, use the new fangled cluster level or
something, that's what it's there for.

That is, you can represent the above like:

	DIE:	0-7
	MC:	0-3,		4-7
	CLS:	0-1,1-2,	4-5,6-7

But if there is cache at MC, LLC is what it is.
