Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA584F99DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiDHPvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiDHPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:51:19 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 08:49:13 PDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.184.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7F3669B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:49:13 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id CEDCE7DE4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:03:29 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id cq93npFGmdx86cq93nA6d8; Fri, 08 Apr 2022 10:03:29 -0500
X-Authority-Reason: nr=8
Received: from host-95-245-33-130.retail.telecomitalia.it ([95.245.33.130]:42398 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1ncq92-0032ym-QE; Fri, 08 Apr 2022 10:03:28 -0500
Message-ID: <1a9ca671-8578-6352-09b1-ac4c546f4e16@kernel.org>
Date:   Fri, 8 Apr 2022 17:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] rtla: add a tag to avoid dereferring a NULL pointer
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     kael_w@yeah.net, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20220401123948.69312-1-wanjiabing@vivo.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220401123948.69312-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.245.33.130
X-Source-L: No
X-Exim-ID: 1ncq92-0032ym-QE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-245-33-130.retail.telecomitalia.it ([10.0.0.45]) [95.245.33.130]:42398
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan

There is a typo in the subject, and it needs a capital letter after the ':'.

I suggest using something like:

rtla: Avoid record NULL pointer dereference

Do you mind sending a v3?

On 4/1/22 14:39, Wan Jiabing wrote:
> Fix the following null/deref_null.cocci errors:
> ./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
> ./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.
> ./tools/tracing/rtla/src/timerlat_hist.c:905:31-36: ERROR: record is NULL but dereferenced.
> ./tools/tracing/rtla/src/timerlat_top.c:700:31-36: ERROR: record is NULL but dereferenced.
> 
> "record" is NULL before calling osnoise_init_trace_tool.
> Add a tag "out_free" to avoid dereferring a NULL pointer.
> 
> Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Also adding:

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks,
-- Daniel
