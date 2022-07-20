Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715357B908
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiGTO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGTO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:59:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08A459A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a4AGlHbwXylaUo7fQTX9NYJuzUjf8GRAjeABelBwsxc=; b=hsboakFNYhUM3kF6t7Ugr4FERb
        ZicmZn13k5DZcWQMJOE8dPUKZdwWfBaIBUOMlhKvupwdyXKRE+i+DNHYyqlx0Yk1AtAitAQk3q11l
        MtuBPJ5ZwibdJLmyILV68piNUwLQr3r2kXEhigJMpBkzSnbI4FcS2M4qP5S7NauJBStwZRSkqDZEj
        FD0tPg8Sd47UEHvQNNvJcm7teoKrzzdPo5cJIIejgm01rogZLwtWang4bWTzWzt0p5GS8lYEmSQbZ
        GPXrPilRU+clOeqC+YgeshfiRC1gdCkV7eWmVQx8I2050RqJHn0JexiFl/gGnRLY5vsz2iQwVyKH+
        FJ1pwY3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEBAH-00EYVm-HZ; Wed, 20 Jul 2022 14:59:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC7EE980BBE; Wed, 20 Jul 2022 16:59:03 +0200 (CEST)
Date:   Wed, 20 Jul 2022 16:59:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: use pr_warn_once for reporting that
 lockdep is turned off
Message-ID: <YtgYNzrLuHIcz6R5@worktop.programming.kicks-ass.net>
References: <6acb20ea-7f9c-120a-c8c5-9ee5d511d766@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acb20ea-7f9c-120a-c8c5-9ee5d511d766@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:01:36PM +0900, Tetsuo Handa wrote:
> debug_show_all_locks() can be called for multiple times if
> hung_task_call_panic = 0. No need to repeat this message.

That one extra line is really a problem?
