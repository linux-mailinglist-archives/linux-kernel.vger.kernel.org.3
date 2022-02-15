Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AE4B7268
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiBOPwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:52:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiBOPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:52:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8219BBB8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KbE1laj8zmpkZqMq0pcAt0X3XPM/5mSQfNe+PyZG60c=; b=oU4Q9WfHkNwHfdUH9FLPEWmrwP
        IJYlAljLn/AZx4lvXXy4pAhu6o52vD8PFuj7y/J9qiEEzzQxcMqpFtl7E8oZGFd101HOw8v96HY6u
        RTUUXsJYPuGoPJoeBUJV2NVgqLcolbHhILuX69HMzWdLnqW8p7iq34LXLvb/vUyynsISMMI2mM/TM
        FWZrHeUgPimbDIgH+d7QWOhaZIZ3i+AmHvJ0bvA6O13puvSlwZMsI+DVlLwlQuEOivedXzRSVbjQ6
        YnyZiZlPISsQKoKvqIWf+abcoi+N9Hewfxs6eRb5FuwxYOMe/CnAPIX5oIJO1C2ie5zX2PK9oJ8Nu
        WXgiXCiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK079-00DyBd-50; Tue, 15 Feb 2022 15:51:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B39F63001C0;
        Tue, 15 Feb 2022 16:51:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94170201E7FC2; Tue, 15 Feb 2022 16:51:37 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:51:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
Message-ID: <YgvMCYtt14EQgySP@hirez.programming.kicks-ass.net>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
 <YgvIJop34KuyUIx6@hirez.programming.kicks-ass.net>
 <f2c2389e-db62-c307-b5d7-6a8d9df70b7e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c2389e-db62-c307-b5d7-6a8d9df70b7e@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:40:45PM +0200, Adrian Hunter wrote:
> On 15/02/2022 17:35, Peter Zijlstra wrote:
> > On Wed, Jan 26, 2022 at 12:48:13PM +0200, Adrian Hunter wrote:
> >> Hi
> >>
> >> As of Intel SDM (https://www.intel.com/sdm) version 076, there are 2 new
> >> Intel PT features called Event Trace and TNT-Disable.
> >>
> >> Event Trace exposes details about asynchronous events such as interrupts
> >> and VM-Entry/Exit.
> >>
> >> TNT-Disable disables TNT packets to reduce the tracing overhead, but with
> >> the result that exact control flow information is lost.
> > 
> > What's a TNT?
> 
> The TNT packet indicates whether conditional branches were taken
> or not taken.

Thanks, updated that Changelog.
