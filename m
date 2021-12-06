Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0846978B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbhLFN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:58:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60350 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbhLFN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:58:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0826E2114D;
        Mon,  6 Dec 2021 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638798874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0PP/ew4eD5JtQTB1B/GJfuv0NkZ4eoY7t2JZ/8CzHQ=;
        b=id+NWxwLWxMQbAg76PUn+9nRVVLEyM08l9UFr2nuyOb++LTVJuXYF5WCpl1O+VOvtWSS4G
        pNlB7ddZ/K7W0aZ6TVWHIP+zmW1PZmbTm1Hoy9Jrtky86fcpEFnySwEIen1VARQJifKzTz
        yvjeb/nyLMcPHkKyXA7TwE4Aoi4ImTg=
Received: from suse.cz (unknown [10.163.24.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ADC56A3B81;
        Mon,  6 Dec 2021 13:54:33 +0000 (UTC)
Date:   Mon, 6 Dec 2021 14:54:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] printk/console: Registration code cleanup - part 1
Message-ID: <Ya4WGZT0emR96h0B@alley>
References: <20211122132649.12737-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122132649.12737-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-11-22 14:26:44, Petr Mladek wrote:
> The console registration code has several twists that are hard to follow.
> It is result of various features added over the last few decades.
> 
> I have already spent many days to understand all the effects and
> the desired behavior. I am always scared to touch the console registration
> code even after years working as printk maintainer.
> 
> There were several changes in the code that had to be reverted because
> they caused regression, for example:
> 
>    + commit dac8bbbae1d0ccba96402 ("Revert "printk: fix double printing
>      with earlycon")
> 
>    + commit c6c7d83b9c9e6a8b3e6d ("Revert "console: don't prefer first
>      registered if DT specifies stdout-path")
> 
> 
> This patchset removes the most tricky twists from my POV. I have worked
> on it when time permitted since January. I have spent most of the time
> writing the commit message, understanding, and explaining the effects.
> I am not sure if I succeeded but it is time to send this.
> 
> 
> Behavior change:
> 
> There is one behavior change caused by 4th patch. I consider it bug fix.
> It should be acceptable. See the commit message for more details.

I am afraid that the patchset is not easy to review. I decided to help
a bit and give it a spin in linux-next.

The patchset has been committed into printk/linux.git, branch
console-registration-cleanup. It should appear in linux-next
during the next respin.

I am going to take it back when anyone reports any problem that
can't be fixed easily.

Any feedback is still appreciated.

Best Regards,
Petr
