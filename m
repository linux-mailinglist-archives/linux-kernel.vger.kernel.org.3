Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E848DCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiAMR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:26:18 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.82]:33216 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232267AbiAMR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:26:17 -0500
X-Greylist: delayed 1381 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 12:26:17 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0FC68416AB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:03:15 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 83VLnVEn1b6UB83VLni59g; Thu, 13 Jan 2022 11:03:15 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:49966 helo=[10.0.0.101])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n83VK-003z8s-Ny; Thu, 13 Jan 2022 11:03:15 -0600
Message-ID: <388b9922-4231-6e34-1305-f0b439d9d07c@kernel.org>
Date:   Thu, 13 Jan 2022 18:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [for-next][PATCH 05/31] tracing: Have existing
 event_command.parse() implementations use helpers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220111173030.999527342@goodmis.org>
 <20220111173114.155260134@goodmis.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220111173114.155260134@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.47.126.144
X-Source-L: No
X-Exim-ID: 1n83VK-003z8s-Ny
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.101]) [79.47.126.144]:49966
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/11/22 18:30, Steven Rostedt wrote:
> From: Tom Zanussi <zanussi@kernel.org>
> 
> Simplify the existing event_command.parse() implementations by having
> them make use of the helper functions previously introduced.

While testing rtla with all for-next changes, I noticed this patch breaks:

# rtla osnoise hist -d 5

Before this patch, osnoise hist is able to enable histograms and collect data.
After this patch it does not work.

The event I am creating the histogram is osnoise:sample_threshold, and the
trigger command is:

hist:keys=duration.buckets=1000,common_cpu:vals=hitcount:sort=hitcount:size=2048

I did some debug, and found that the histogram is working. The problem is that,
to read the histogram I pause it to have consistent data:

in tools/tracing/rtla/osnoise_hist.c:
osnoise_read_trace_hist() {
 [...]
        tracefs_hist_pause(tool->trace.inst, data->trace_hist);

        content = tracefs_event_file_read(tool->trace.inst, "osnoise",
                                          "sample_threshold",
                                          "hist", NULL);
 [...]
}

and, as far as I got, after this patch, pausing the histogram makes it to clear
up. If I comment the "tracefs_hist_pause" line, "rtla osnoise hist" start
working back again.

Thoughts?

-- Daniel
