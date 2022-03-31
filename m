Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483604ED999
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiCaM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCaM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:27:37 -0400
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110A20C1A1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:25:50 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 0057E83680
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:25:49 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Zts5nhvgkb6UBZts5nkMZY; Thu, 31 Mar 2022 07:25:49 -0500
X-Authority-Reason: nr=8
Received: from host-79-43-204-123.retail.telecomitalia.it ([79.43.204.123]:33842 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nZts5-003e8f-63; Thu, 31 Mar 2022 07:25:49 -0500
Message-ID: <2afd6cba-1a01-0c32-eae8-c4f9f7e76732@kernel.org>
Date:   Thu, 31 Mar 2022 14:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtla/osnoise: fix NULL but dereferenced coccicheck errors
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     kael_w@qq.com, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322113253.57390-1-wanjiabing@vivo.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220322113253.57390-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.43.204.123
X-Source-L: No
X-Exim-ID: 1nZts5-003e8f-63
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-43-204-123.retail.telecomitalia.it ([10.0.0.45]) [79.43.204.123]:33842
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan

On 3/22/22 12:32, Wan Jiabing wrote:
> Fix the following coccicheck errors:
> ./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
> ./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.
> 
> "record" is NULL before calling osnoise_init_trace_tool.
> Add a tag "out_free" to avoid dereferring a NULL pointer.

Yes, I see the problem.

Please, change the Subject to something with better information about the
problem, instead of the way you fund it.


> Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c | 5 +++--
>  tools/tracing/rtla/src/osnoise_top.c  | 9 +++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)

Please, also add the version of coccicheck you are using, because it seems that
there is a problem with it. There is a similar problem with timerlat, added by
the same patch, but it seems that coccicheck did not find it.

Would you mind to check coccicheck, and also add the fix for timerlat?

Thanks.
-- Daniel

