Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5A553F60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiFVAQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiFVAQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1819F88
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3191617B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D927C3411C;
        Wed, 22 Jun 2022 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655856976;
        bh=PgcuBqHZZbQa503bM4Scmsi3N1vfutVANcvd63kNuss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YHoqI6jQZ9n64iK1Jnv8hF/5uCm+hiv+wdBc20tt7b8V8OZ7QWtrkQlxj2VNsvJKj
         7sskAV1Hp8mo7yYAlK6aUvFLWEPI43CTBovgt3bBjIIDNbIE+3D/VqolRzlITy0Lzw
         qUEUuqLFPqy0DqUx5v/1U2vrl5kwVd0WsTTagsTM=
Date:   Tue, 21 Jun 2022 17:15:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Michael Larabel <Michael@MichaelLarabel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-Id: <20220621171554.7ad01842c933b3049afeb3b6@linux-foundation.org>
In-Reply-To: <67d39f78-8eed-f49a-b3b0-18f77f9821cd@leemhuis.info>
References: <YhUI1wUtV8yguijO@fuller.cnet>
        <YhUKRzEKxMvlGQ5n@fuller.cnet>
        <YiI+a9gTr/UBCf0X@fuller.cnet>
        <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
        <Yin7hDxdt0s/x+fp@fuller.cnet>
        <YkWyLaom/r7jXgbA@zn.tnic>
        <YmrWK/KoU1zrAxPI@fuller.cnet>
        <20220528141809.732788db257253396462c79e@linux-foundation.org>
        <134065a4-0446-bbbc-fca8-59f32798cf08@MichaelLarabel.com>
        <0ce05ce7-1a00-82df-f37a-bf7f9e216504@MichaelLarabel.com>
        <67d39f78-8eed-f49a-b3b0-18f77f9821cd@leemhuis.info>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 14:14:03 +0200 Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> Andrew, is there a reason why this patch afaics isn't mainlined yet and
> lingering in linux-next for so long? 

I didn't bother doing a hotfixes merge last week because there wasn't anything
very urgent-looking in there.  I'll be putting together a pull request later this week.
