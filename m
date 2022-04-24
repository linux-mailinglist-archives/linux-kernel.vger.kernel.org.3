Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B750D330
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiDXQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiDXQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:15:51 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9114DEB5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:12:49 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id D9323616D1;
        Sun, 24 Apr 2022 16:12:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id CFFCA2000E;
        Sun, 24 Apr 2022 16:12:47 +0000 (UTC)
Message-ID: <71297b444533a2348b8cb211674453bf65848f82.camel@perches.com>
Subject: Re: [PATCH] ring-buffer: simplify if-if to if-else
From:   Joe Perches <joe@perches.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Date:   Sun, 24 Apr 2022 09:12:45 -0700
In-Reply-To: <20220424093442.102230-1-wanjiabing@vivo.com>
References: <20220424093442.102230-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: 3853auiktmgqpcuinyrrephc8oico6ij
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: CFFCA2000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18VJyd+K9LWxPTpmwxX2wTP3N3Bmj7cJMM=
X-HE-Tag: 1650816767-352729
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-24 at 17:34 +0800, Wan Jiabing wrote:
> Use if and else instead of if(A) and if (!A).
[]
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
[]
> @@ -6014,7 +6014,7 @@ static __init int test_ringbuffer(void)
>  		if (total_lost)
>  			pr_info(" With dropped events, record len and size may not match\n"
>  				" alloced and written from above\n");
> -		if (!total_lost) {
> +		else {

please run your proposed patches through checkpatch.

(add braces to the if block)

additionally:

the pr_info on two lines seems pointless and it's probably nicer
just written on a single line.

			pr_info(" With dropped events, recorded len and size may not match alloced and written from above\n");

>  			if (RB_WARN_ON(buffer, total_len != total_alloc ||
>  				       total_size != total_written))
>  				break;


