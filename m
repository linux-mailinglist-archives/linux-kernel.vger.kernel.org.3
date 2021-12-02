Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C85466D20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377470AbhLBWqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:46:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbhLBWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:46:36 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C263CB8250C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 22:43:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4B560E0B;
        Thu,  2 Dec 2021 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638484991;
        bh=k9q7ViPxqGsRhU9ucgzZ8DuwjgjWkF5tqE/Eml14C5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fJQbMN7UDZaYYrs3CDMZWO2EefiNjfcctXKtViaTTslAYcqcHk1SPnBYIUPO7s0k8
         l3f4dXDU9iCS5p3D1X89vNDwtkN0rlc5ZdlUD6o8Iig33Uw//iVu5HjzUqfpmBTwTV
         Eg+FQzgcUQdN5XhAmoOymkQTiiFXUprqITzOjF68=
Date:   Thu, 2 Dec 2021 14:43:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] panic: Remove oops_id.
Message-Id: <20211202144308.70fd454883c1d1e643491471@linux-foundation.org>
In-Reply-To: <20211202142713.ofadr43tawengfw4@linutronix.de>
References: <20211202142713.ofadr43tawengfw4@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 15:27:13 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The oops id has been added as part of the end of trace marker for the
> kerneloops.org project. The id is used to automatically identify duplicate
> submissions of the same report. Identical looking reports with different
> a id can be considered as the same oops occurred again.
> 
> The early initialisation of the oops_id can create a warning if the
> random core is not yet fully initialized. On PREEMPT_RT it is
> problematic if the id is initialized on demand from non preemptible
> context.

"problematic" isn't very useful :(

What exactly goes wrong under -rt?

> The kernel oops project is not available since 2017.
> Remove the oops_id.

(googles "linux oops_id")

https://wiki.ubuntu.com/UbuntuWeeklyNewsletter/Issue565#What.2BIBk-s_the_OOPS_ID.3F

Seems someone was using it in 2019.  My search was very brief.

The world wouldn't end if we removed this.  But perhaps it would be better
to replace the oops id with "0" to avoid breaking parsers.

It's just a fairly unique number.  We could use anything.  Simply
jiffies or ktime_get() would suffice?
