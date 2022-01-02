Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79194482B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiABO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 09:56:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58734 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiABO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 09:56:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FDB60E96;
        Sun,  2 Jan 2022 14:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256DDC36AE7;
        Sun,  2 Jan 2022 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641135372;
        bh=ak0IIoVK9/CDZ36U9L9K0FJoC+zkQLSSj6iZfLnnwXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kalsn5HMf+Dbxv+KjJ6XNC6jSiYpVCnDXFLYOvGUAf4Ijf6bFHUTRADiSdZboZC9y
         +xC/PiQAx0cn3Qvkbw991fpDlAeAVTOJGslz8S6VhL52Y7ogB4b9fttDLcQ6VlFa0L
         VsTtp+kxHEcvIyJG9qj8DGv5YLenTIk1n1UdmFHlndfR8HG9SIh3oIIL8wFujAyAN3
         hjyq/mpSijfqTJ1UD72jxl6HkV4PzKzGv4yZf+R2ZWaWeh2o1oUeTMaElGTOebyxPf
         HVwFHfqvr/aP1y56k1+GXK/75P/hT43Yf5rol0YghhTMP8gSZ183vzVFzUQmRXyNVK
         ViGPrOvEjed6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A89540B92; Sun,  2 Jan 2022 11:56:09 -0300 (-03)
Date:   Sun, 2 Jan 2022 11:56:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zechuan Chen <chenzechuan1@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Jianlin.Lv@arm.com,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        yangjihong1@huawei.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed
Message-ID: <YdG9CSk9ayoVmBhz@kernel.org>
References: <20211228111338.218602-1-chenzechuan1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228111338.218602-1-chenzechuan1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 28, 2021 at 07:13:38PM +0800, Zechuan Chen escreveu:
> Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
> across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
> eliminates the need to use the prefix "." at the symbol name. But when
> the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
> obtains two symbol address information through /proc/kallsyms, for example:
> 
> cat /proc/kallsyms | grep -w schedule
> c000000000657020 T .schedule
> c000000000d4fdb8 D schedule
> 
> The symbol "D schedule" is not a function symbol, and perf will print:
> "p:probe/schedule _text+13958584"Failed to write event: Invalid argument
> 
> Therefore, when searching symbols from map and adding probe point for
> them, a symbol type check is added. If the type of symbol is not a
> function, skip it.
> 
> Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2")
> 
> Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
> ---
>  tools/perf/util/probe-event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index b2a02c9ab8ea..a834918a0a0d 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -3083,6 +3083,9 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  	for (j = 0; j < num_matched_functions; j++) {
>  		sym = syms[j];
>  
> +		if (sym->type != STT_FUNC)
> +			continue;
> +

Humm, shouldn't this be handled by find_probe_functions(), i.e. it
shoudn't return data symbols, right? Otherwise other places using this
function may malfunction as well?

Naveen? Masami?

- Arnaldo

>  		/* There can be duplicated symbols in the map */
>  		for (i = 0; i < j; i++)
>  			if (sym->start == syms[i]->start) {
> -- 
> 2.12.3
