Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44EF46DE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbhLHWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:17:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40000 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLHWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:17:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B3C9B82312;
        Wed,  8 Dec 2021 22:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC9AC00446;
        Wed,  8 Dec 2021 22:14:07 +0000 (UTC)
Date:   Wed, 8 Dec 2021 17:14:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 03/14] rtla: Add osnoise tool
Message-ID: <20211208171406.353bc200@gandalf.local.home>
In-Reply-To: <9944378d-456f-79a5-2dbf-30dbbbc94522@kernel.org>
References: <cover.1638182284.git.bristot@kernel.org>
        <ffb7f1b1e8cc42fc8ec52f1a89fdd2ca0d70c36e.1638182284.git.bristot@kernel.org>
        <YaZEzvzp5jkRyLEJ@geo.homenetwork>
        <9944378d-456f-79a5-2dbf-30dbbbc94522@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 16:18:53 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> >> +	if (!strcmp(context->orig_cpus, context->curr_cpus))
> >> +		goto out_done;
> >> +
> >> +	retval = write(context->cpus_fd, context->orig_cpus, strlen(context->orig_cpus));  
> > 
> > 'strlen(context->orig_cpus) + 1' for write size;
> >   
> >> +	if (retval < strlen(context->orig_cpus))  
> > 
> > Same here. Check 'strlen(context->orig_cpus) + 1'  
> 
> Fixed in v9.

And if you used the tracefs_instance_file_write() function, you would not
have had his bug ;-)

-- Steve
