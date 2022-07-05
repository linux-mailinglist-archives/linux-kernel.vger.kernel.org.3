Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA59E56753C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiGERJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiGERJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:09:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4F1F2C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LRxepLtU3tlx+iQf/9hQqxrfajocnvVd/JJZgo+pBRQ=; b=wRtNMblBRkQjskTja0WzTeVuaA
        tcinC5+573x/fQ1Of7EKeDKarHeuz6CdN/44SF7h8II/kjpIFMnq2FsJ4j5whtzxWIKEhI8LILBcd
        DJh+XzPtyVcEPOaQiUjNPa0VPpZwyxhtjlvSj89vRIeAYJM8RLz6HdeMn5h0zwLunsd1KS1B6dYIj
        KBu8Grxi45JPQrhm2W+/Q+3mszgefv+0yXMml47u3P9t8BkVeHvchKfBi8qXQPzRndUvq6dMnMgBk
        H0Sc1o/LsWuY5RlnbGZyFv8iyNsPBFNL5euZc9gY+iIGUmuR4/BDobGzb9a5n25/7AtFzUcWI6M7G
        I6QBShtw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8m2f-000lWR-Ki; Tue, 05 Jul 2022 17:08:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35777980059; Tue,  5 Jul 2022 19:08:53 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:08:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] locking/qspinlock: be less clever with the
 preprocessor
Message-ID: <YsRwJdjJqpXEFTnO@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-6-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:12AM +1000, Nicholas Piggin wrote:
> Stop qspinlock.c including itself and avoid most of the function
> renaming with the preprocessor.
> 
> This is mostly done by having the common slowpath code take a 'bool
> paravirt' argument and adjusting code based on that.

What does code-gen do? Is it clever enough to constant fold the lot?

Should we be using __always_inline to ensure the compiler doesn't decide
against inlining because $raisin and then emitting extra condtionals?
