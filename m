Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF644D8044
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiCNK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiCNK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:56:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02FD43EE9;
        Mon, 14 Mar 2022 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uaaiBGW4jge4EZ1U6h8ArDMiqt/yHKf7XttgFGtE2/M=; b=hoV+/hsARD+41GgJwPvHacyLqV
        bVpCtL4H1CPrNZz3bd6ZYDLBjpcZRM43Q+B26oUSATlXgsTklsu6EWEvcUs4KnboJ01k8Td2AwuGp
        CbBQdHbag1H3ZmCQV27TtnY0rfcwjSDD31TGYWtjZfCtW+JJ2NK0eoX/PmrNQTqhowHISFjSbgSPy
        MwLjHMQjlW+6HsCTpU3ldYWhlszVKCioOP3u4jag11rcMNVf8lIlp0b9yECC33BLaVdkQyy5JqgNc
        n3wcG3PczcL5tEtzf7ROiXQMROV1hpvJDPHCm7DHOgoMp8p+71zQD8zElL3ZSg8zZ6IJ28EWbztou
        assNBj4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTiM7-000oKu-07; Mon, 14 Mar 2022 10:55:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66297300325;
        Mon, 14 Mar 2022 11:55:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23FB9284B4209; Mon, 14 Mar 2022 11:55:12 +0100 (CET)
Date:   Mon, 14 Mar 2022 11:55:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
Message-ID: <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
 <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
 <YidREXNn2AtI3V1c@hirez.programming.kicks-ass.net>
 <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:50:33AM +0800, Wen Yang wrote:

> As you pointed out, some non-compliant rdpmc can cause problems. But you
> also know that linux is the foundation of cloud servers, and many
> third-party programs run on it (we don't have any code for it), and we can
> only observe that the monitoring data will jitter abnormally (the
> probability of this issue is not high, about dozens of tens of thousands of
> machines).

This might be a novel insight, but I *really* don't give a crap about
any of that. If they're not using it right, they get to keep the pieces.

I'd almost make it reschedule more to force them to fix their stuff.
