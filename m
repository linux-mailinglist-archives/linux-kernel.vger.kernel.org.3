Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FCC5675DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGERhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGERhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:37:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEB1F2D4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1dPV8s9V/nXkihecezo4qXiu3xvYdE5MGUb7XFcFFzg=; b=ZHrAEYvzChYWbgnmtlDKgF/G8w
        CwWkso3uBV3ByZWVCwHQCjND6AAssmF1SPrIVbTKnCUEBpcBNxYWtjp3iQpO8SvXkHlKNQesZiDwX
        hDlWl0GwFgrkQTx/n2NEZepuozGlUhHIUcrRAdwwUmgv2jHuAKqVrdhTJzmB6xnfC4Q+UW9Y+Qmre
        OHNTgnFLnnpKR6gOGFVluKjpLqfnF4uoYSANZ+j03hgGdKUBTE5rLt0qQ0zGqTie1/Q3MNOsqsOUF
        Mt5qpGP1Hx4BnVYHIHJYpN/7VqQf69lTL4cKpYpVfqOfJjbTskj1m+6dt9dMjxOHyoLWGwNGIzVQD
        yyc787wA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mTm-0004pG-G6; Tue, 05 Jul 2022 17:36:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AAA0980059; Tue,  5 Jul 2022 19:36:54 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:36:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] locking/qspinlock: merge qspinlock_paravirt.h into
 qspinlock.c
Message-ID: <YsR2tlnJZ3c0ZeaP@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-7-npiggin@gmail.com>
 <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:20:37PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 05, 2022 at 12:38:13AM +1000, Nicholas Piggin wrote:
> > There isn't much reason to keep these separate.
> 
> The reason was so that other paravirt implementations could be added.
> 
> The CNA thing was also implemented this way...

Also, (TIL) s390 seems to have a copy of all this:

  b96f7d881ad9 ("s390/spinlock: introduce spinlock wait queueing")

it might be nice if it were possible to fold that back into this with a
different paravirt implementation; but I've not looked at it in any
great detail yet.
