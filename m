Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3694BFE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiBVQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBVQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:06:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718210C50E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DC97B81B54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4298C340E8;
        Tue, 22 Feb 2022 16:05:48 +0000 (UTC)
Date:   Tue, 22 Feb 2022 11:05:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ftrace: Make function graph use ftrace directly
Message-ID: <20220222110547.5c5435a5@gandalf.local.home>
In-Reply-To: <YhUHRIDaLqhAz0SV@lakrids>
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
        <YhUHRIDaLqhAz0SV@lakrids>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 15:54:44 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +int ftrace_enable_ftrace_graph_caller(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +int ftrace_disable_ftrace_graph_caller(void)
> > +{
> > +	return 0;
> > +}  
> 
> It's a shame the core code doesn't provide this if we provide an
> implementation of ftrace_graph_func.

As it was only x86_64 that took it out, I wasn't about to remove it. But
now other archs are implementing it, I'm fine with making these weak
functions in the core code.

-- Steve
