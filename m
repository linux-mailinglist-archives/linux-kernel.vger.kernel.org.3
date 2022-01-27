Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6300E49E310
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiA0NG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiA0NGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:06:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF5C061714;
        Thu, 27 Jan 2022 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y59KjY9VvOsk8lggAEf2yB8MZ9wiTunhxmQnET8roR0=; b=cJs8poyzXrkTreKFxL4Wlg9+Xu
        6Z1+6w3/IolFHJ+98UTtqBcSRvay92+LORQZxilj4H9mjpa9E7micxHv1Ht++A6NwGlVsV9hLedfw
        D5Mas08bxhicLi+ZSPCaVcbEw0Xevdd8zKsFyoSAqTKp9UWKRR3U5kksKOmleXgVVV74SyR5p4Fuf
        E1jO4gitnQuk0mMnUxNRRRZuyCCZp9CaZu+J5xjTU11h4ez6z6j/wGTxZhkHrxUBzoNd/UnOuwRts
        OMDJY5afULgL9th3GIgkQ28p1gyCrVk6+pSITcIVxWO15R8hidwH8E2VXZgFvk/ElBJ9VJ+yphsj7
        jijtywXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD4U7-005FTo-9p; Thu, 27 Jan 2022 13:06:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8958B300268;
        Thu, 27 Jan 2022 14:06:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 686282B52092C; Thu, 27 Jan 2022 14:06:42 +0100 (CET)
Date:   Thu, 27 Jan 2022 14:06:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 08/13] ACPI: add perf low power callback
Message-ID: <YfKY4k+ZO9of3Ipd@hirez.programming.kicks-ass.net>
References: <20220126233454.3362047-1-eranian@google.com>
 <20220126233454.3362047-9-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126233454.3362047-9-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:34:49PM -0800, Stephane Eranian wrote:
> This patch add an optional callback needed by some PMU features, e.g., AMD

"This patch" is a documented fail.

> BRS, to give a chance to the perf_events code to change its state before
> going to low power and after coming back.
> 
> The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
> This flag must be set in arch specific perf_event.h header whenever needed.
> When not set, there is no impact of the ACPI code.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  drivers/acpi/acpi_pad.c       | 6 ++++++
>  drivers/acpi/processor_idle.c | 5 +++++
>  include/linux/perf_event.h    | 6 ++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index f45979aa2d64..a306a07a60b5 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -164,6 +164,9 @@ static int power_saving_thread(void *data)
>  				tsc_marked_unstable = 1;
>  			}
>  			local_irq_disable();
> +
> +			perf_lopwr_cb(true);
> +
>  			tick_broadcast_enable();
>  			tick_broadcast_enter();
>  			stop_critical_timings();
> @@ -172,6 +175,9 @@ static int power_saving_thread(void *data)
>  
>  			start_critical_timings();
>  			tick_broadcast_exit();
> +
> +			perf_lopwr_cb(false);
> +
>  			local_irq_enable();
>  
>  			if (time_before(expire_time, jiffies)) {

You forgot to Cc the maintainers of this stinking pile of poo. Can we
please delete it instead?
