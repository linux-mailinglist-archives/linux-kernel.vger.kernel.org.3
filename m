Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE48B4686E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385370AbhLDSHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:07:45 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.175]:15439 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345275AbhLDSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:07:44 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 156C34013D514
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 12:04:17 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id tZOTmpDYf0ESotZOTmcnXo; Sat, 04 Dec 2021 12:04:17 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:60004 helo=[10.0.0.166])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mtZOR-001jqO-UU; Sat, 04 Dec 2021 12:04:16 -0600
Message-ID: <6234e96a-3e1f-77fb-8d18-6bff24095f90@kernel.org>
Date:   Sat, 4 Dec 2021 19:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 04/14] rtla/osnoise: Add osnoise top mode
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <cover.1638182284.git.bristot@kernel.org>
 <edbe1a4be48b5fd9d7fd224e819918cdb943db4a.1638182284.git.bristot@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <edbe1a4be48b5fd9d7fd224e819918cdb943db4a.1638182284.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1mtZOR-001jqO-UU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.166]) [79.34.250.122]:60004
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao


On 11/29/21 12:07, Daniel Bristot de Oliveira wrote:
> +int osnoise_top_main(int argc, char **argv)
> +{
> +	struct osnoise_top_params *params;
> +	struct trace_instance *trace;
> +	struct osnoise_tool *record;
> +	struct osnoise_tool *tool;
> +	int return_value = 1;
> +	int retval;
> +
> +	params = osnoise_top_parse_args(argc, argv);
> +	if (!params)
> +		exit(1);
> +
> +	tool = osnoise_init_top(params);
> +	if (!tool) {
> +		err_msg("Could not init osnoise top\n");
> +		goto out_exit;
> +	}
> +
> +	retval = osnoise_top_apply_config(tool, params);
> +	if (retval) {
> +		err_msg("Could not apply config\n");
> +		goto out_top;
> +	}
> +
> +	trace = &tool->trace;
> +
> +	retval = enable_osnoise(trace);
> +	if (retval) {
> +		err_msg("Failed to enable osnoise tracer\n");
> +		goto out_top;
> +	}
> +
> +	if (params->set_sched) {
> +		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
> +		if (retval) 


You hit this case. It is correct to get this error if one sets SCHED_DEADLINE
without disabling the admission control.

However, there is also a problem here. The tracer was not disabled, and the
instance was not removed - so osnoise threads kept running after the error
message and exit().

I will fix this on all tools for v9.

Thanks for testing!
--- Daniel

> +			osnoise_top_usage("Failed to set sched parameters\n");
> +	}
> +

