Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2144FADEB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiDJMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiDJMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:46:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B411A380;
        Sun, 10 Apr 2022 05:44:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649594645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jupJYF+Zhy8Z0j1aiZqE1QaJR/Yec+7rIcNnDHtn/hA=;
        b=szSevsxWHh1OkYXwDgmZGH28YrhD2WGnHx+NYJvX7WEYMThcMPeDRoWRZxOs9ri2KKwu5J
        DqmgjNrXUL5SW7gsLrrt98U+T3nFBcnW1zMldd9m8iHp0Ew7TsSmLVeVbNfkVGiqOvg7g+
        sLteFtuGskBFV6kxrExjetAI92mHSRvQOrnf/tUDKa//g0txyTY6mZ55KGWIg0drWXn4K/
        wykHrBnWJLj8+8d3cL8VBJbzGBv2a0NBkgz1wdvnkUmV/2mmLrZaPwA+0uM1iDneSpScqk
        ydamC1Xv/ctZFuvGEndbn7ZLKatfVZ4XHPeVDbReRVbEUNVm79B5gUkjW1ypYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649594645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jupJYF+Zhy8Z0j1aiZqE1QaJR/Yec+7rIcNnDHtn/hA=;
        b=5P7i7gS57kJRa2/4tl0OHX9nfYMTpBnPji1hicsoUyD64NeODIs/+5PEb/PxSfRVsyTBrv
        /kw1bkRmPKRI21CQ==
To:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH REPOST] irq_poll: Add local_bh_disable() in cpu_dead
 notifier
In-Reply-To: <YgYDePJLsVLXKqEP@infradead.org>
References: <YgJ/XWVxxWDVBBVA@linutronix.de>
 <YgNzsnIE9bwQZ1Zg@infradead.org> <YgUGI9qAKUh4AOUY@linutronix.de>
 <YgYDePJLsVLXKqEP@infradead.org>
Date:   Sun, 10 Apr 2022 14:44:04 +0200
Message-ID: <87o819glbf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10 2022 at 22:34, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 01:33:39PM +0100, Sebastian Andrzej Siewior wrote:
>> You need to handle the pending softirqs. If you don't handle them
>> immediately or in a deterministic say (like on IRQ exit) then they will
>> be handled at a random point.
>
> Yes.  Just like regular interrupts.

But interrupts make sure they are handled. This code does not and as
Sebastian pointed out:

  "If you don't handle them at all, the CPU will go idle and at least
   the NO_HZ will complain about pending softirqs (can_stop_idle_tick())."

That's clearly a bug, but this should be part of the changelog.

Thanks,

        tglx

