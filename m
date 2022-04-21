Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53402509F03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382512AbiDULyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382319AbiDULyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:54:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC52A265;
        Thu, 21 Apr 2022 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZHbzQMu8uYjFrthvRXYK9IV2thwt/HDx1K+L+tY5GI=; b=NG+UAvEABaHJ2j50viDG+b1G6o
        lC5Onb/goJrpHXhWUAFyb0/mF3qZngbv2pz0ZkYB6mbSti6dc4un0MhYyzZ7hx5Diyyruljjvs3zf
        1z4BcBa6xGcdQcA79av1TpLUtMUhxE0/2GQdC0V+VoYxQwlJKc/duufKdIALVOeVJh0mIddZO3Ba0
        bZGaycSiuRzgjh54ko3Y0RjMJgdP5JABVb0CL+rxevge4FsucATLLWzC1HOiHxSN3+aB9qNIYLxl/
        qsZ8O92+Y2nidEVXqC05TNi+5AsUQCeIWNC7+y2PjqYzpjen5SajuvUOYgQGIUeY2l8nsnFEbc90i
        FCvqJa2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhVKu-00530f-A0; Thu, 21 Apr 2022 11:51:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A8D09861C1; Thu, 21 Apr 2022 13:50:58 +0200 (CEST)
Date:   Thu, 21 Apr 2022 13:50:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
Message-ID: <20220421115058.GN2731@worktop.programming.kicks-ass.net>
References: <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
 <20220420180323.GA14947@redhat.com>
 <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
 <20220421072138.GI2731@worktop.programming.kicks-ass.net>
 <20220421102631.GE2762@worktop.programming.kicks-ass.net>
 <20220421104914.GA20402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421104914.GA20402@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:49:43PM +0200, Oleg Nesterov wrote:
> On 04/21, Peter Zijlstra wrote:
> >
> > As such, I've taken the liberty of munging yours and Oleg's approach
> > together. I've yet to actually test this but it looks feasible.
> 
> Agreed, but I am a but confused. Is it on top of 1/5? Doesn't look so,
> and I can't apply it with or without 1/5. So I am not sure I understand
> what exactly it does.

Yes, it is on top of a modified 1, I mean to post an updated and tested
series later today.

Basically it does the TRACED_QUIESCE thing from your patch, and then
does the DELAY_WAKEKILL thing from Eric's patch.

