Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8ED544D92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbiFINZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiFINZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:25:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBF4F9F2;
        Thu,  9 Jun 2022 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDnJZHWmp+ysb0h5kWT0rkgoVabhczhnKUMjH+r+EEo=; b=ZTuTdisB3u3GkBMB77eCqdbWc9
        jJwUF3E2AQOHtgrIGRBaWTeBCUxmIl+lpTEnfIJT0qWeI+nHi82g2bLqQg3/i1ScT9/dGn68T6+Gk
        4ATEfi1FcP5b1jSoPwi2aTPnD4MjbxOfvNFqWajswCCdaDsF/KMBMH/Q1gcXXT5R7zd1a5dVxK1/S
        81AMFfHWq68ZGRrYsEZkmFsL8HreTNO88cox0geSEr2XtHRkxQLBDlru+VbstBq10bGeHdVbstIxI
        ns+uXQwcqnlSYsaXEB5HUc0oRHcjd67oTmT4AWTk4Tb3N7qaizDsHMAIYOUc1e4Ltl3awT2358oiF
        XjOPqY2Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzI9u-00DZzb-Gd; Thu, 09 Jun 2022 13:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3096930017D;
        Thu,  9 Jun 2022 15:25:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16C59200ECBB2; Thu,  9 Jun 2022 15:25:08 +0200 (CEST)
Date:   Thu, 9 Jun 2022 15:25:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight()
 inlinable
Message-ID: <YqH0tAT2kboGG8FZ@hirez.programming.kicks-ass.net>
References: <20220609113046.780504-1-elver@google.com>
 <20220609113046.780504-5-elver@google.com>
 <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:03:12PM +0200, Dmitry Vyukov wrote:

> > -__weak int hw_breakpoint_weight(struct perf_event *bp)
> 
> Humm... this was added in 2010 and never actually used to return
> anything other than 1 since then (?). Looks like over-design. Maybe we
> drop "#ifndef" and add a comment instead?

Frederic, you have any recollection what this was supposed to go do?
