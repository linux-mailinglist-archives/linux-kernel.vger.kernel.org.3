Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2674B269B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350334AbiBKM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:58:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbiBKM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:58:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C34DC7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:58:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 88CA221138;
        Fri, 11 Feb 2022 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644584334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBJzK3Xs58/dlpJBfGVQOczArNiv86+UHyJMSbBZyMM=;
        b=QUCYi7YabQyrGnLS1xAh+c0yPGGr1mNCY3Ifdqs9DohNrGH0s2/1g6dyylorGOlfGTdmmA
        HzsJNN0YU/DVCl9BL1J/aQSp2sPxRx/n2vrnjm15VMCJQDT0QWrWhLTeOgFrgDEuADFjJm
        J561b4rmtrIUTVFGWRVDGmb8AoxvdQg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 69B78A3B83;
        Fri, 11 Feb 2022 12:58:54 +0000 (UTC)
Date:   Fri, 11 Feb 2022 13:58:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/13] printk: cpu sync always disable
 interrupts
Message-ID: <YgZdjl0C4tPaZJkH@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:12, John Ogness wrote:
> The CPU sync functions are a NOP for !CONFIG_SMP. But for
> !CONFIG_SMP they still need to disable interrupts in order to
> preserve context within the CPU sync sections.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Good catch!

It is interesting that the original code did not disable interrupts
around __dump_stack() on non-SMP, see the commit 766c268bc6d39b8124
("lib/dump_stack: move cpu lock to printk.c"). But it was rather
a bug. The patch makes perfect sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
