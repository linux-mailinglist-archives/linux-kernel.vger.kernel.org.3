Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7699849B35E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382461AbiAYL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:56:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58802 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386228AbiAYLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:48:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 86C02212C7;
        Tue, 25 Jan 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643111303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoCmbL6yF8nAeIRzqFCzh43LMHBbGGNszo61Ae1SiqY=;
        b=g8O6QNd7mPHllF8xeb65UeuukiV1733Krha7YsYyqa/OErZgYtNRtqcRIWolUqs3g7nlYv
        cQ5KZnilrRbk4tVuzmF+ko+wUFV9aUSOBBgIwc9R6ySgJ56s9vi2csE3U0oE9HjktEY30e
        WC7pgjwpVB0ZEzIaJ9XDCavCkVaxUcQ=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 34836A3B81;
        Tue, 25 Jan 2022 11:48:23 +0000 (UTC)
Date:   Tue, 25 Jan 2022 12:48:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] panic: Add panic_in_progress helper
Message-ID: <Ye/jhjBaN35L76BF@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-2-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121190222.572694-2-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-21 11:02:19, Stephen Brennan wrote:

Please, add explanation why the new helper is added. It will be
used in printk code to reduce risk of deadlocks during panic().

> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> We cannot define a static inline without including linux/atomic.h, so
> I just added a macro for convenience in later patches. Since macros were
> the only option, I didn't include a helper for
> panic_in_progress_different_cpu().

What is the exact problem with including atomic.h and using static
inline, please?

IMHO, the define is not a real solution. The macro won't be usable
without including atomic.h. So, it would work only by chance.

But it is possible that I miss something.

Best Regards,
Petr
