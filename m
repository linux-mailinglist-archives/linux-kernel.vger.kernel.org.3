Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734BA5AF631
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiIFUiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiIFUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:38:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2B876AC;
        Tue,  6 Sep 2022 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DmGvl3uZQB8/M8fW3mjXEVral7dNpov0geEOt0uqNnA=; b=jPxkDIeusjNzbIYNQI1gH+MPWw
        iptDBqorWRN298K3hEbKBLsGbuVfGBAqKQKk3tFj5nryUmK4f7y0dqQiltgRjfg+WktHaUJxYmCnK
        hvV9E/qPf8FSGDDqFvNL+KuVkMfTIQ8wzFfe5QyTqRVX8UneXmDCDfDM7zdEioHiFaktmV01RqHfy
        MmEM64l1Zmi8jBUIA0CvNApfss0x/JkLDlit3Zmu6C8fZ/g/5B/QxPfptpL/aTrK6e99G8/QiaQtj
        4WxVTPHG06Sxcz/5tMrjfIc8UkRoPG8cczT3TXEhL/0KXSMyL/fSvavQOR404DLlbCZAGzBeY+x5q
        JXpPVR1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVfKd-00AkKB-AJ; Tue, 06 Sep 2022 20:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61BB4300244;
        Tue,  6 Sep 2022 22:38:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D7AB2B929A27; Tue,  6 Sep 2022 22:38:00 +0200 (CEST)
Date:   Tue, 6 Sep 2022 22:38:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user
 addresses
Message-ID: <YxevqB2OpJ9BLE+s@hirez.programming.kicks-ass.net>
References: <20220902100057.404817-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902100057.404817-1-elver@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:00:57PM +0200, Marco Elver wrote:
> Allow the creation of restricted breakpoint perf events that also fire
> in the kernel (!exclude_kernel), if:
> 
>   1. No sample information is requested; samples may contain IPs,
>      registers, or other information that may disclose kernel addresses.
> 
>   2. The breakpoint (viz. data watchpoint) is on a user address.
> 
> The rules constrain the allowable perf events such that no sensitive
> kernel information can be disclosed.
> 
> Despite no explicit kernel information disclosure, the following
> questions may need answers:
> 
>  1. Is obtaining information that the kernel accessed a particular
>     user's known memory location revealing new information?
>     Given the kernel's user space ABI, there should be no "surprise
>     accesses" to user space memory in the first place.
> 
>  2. Does causing breakpoints on user memory accesses by the kernel
>     potentially impact timing in a sensitive way?
>     Since hardware breakpoints trigger regardless of the state of
>     perf_event_attr::exclude_kernel, but are filtered in the perf
>     subsystem, this possibility already exists independent of the
>     proposed change.
> 

Changelog forgot to tell us why you want this :-)

I don't see any immediate concerns, but it's late so who knows..
