Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBC4B72FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiBOPmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:42:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiBOPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:41:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD91C0879
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGdco0upSenQ58aPKdUhFiDya/+9i1TLJILSogM9sLc=; b=H0oJ2SkQ0SKuzB5BB9LaNB+l2s
        fnpbknaTsYEpjx6P5bth8l2QbzmiUuzxp/zRycqyzv2sf48v+Q8woTblfvmDxOIFuZJpmcBd1WE8v
        O2MFd1mTVzmQbkWgMCKpOWWaU2Z6yguNyY9YmXENpjZlYYEjkE1ASQbggZAKBGpIUwUzs2aDa8fPZ
        I3DyHVY49Y7kg639rwzPd2Ms6VCctTkgnYTmVpLuox9usd9j1IeARoR9AJlswcytkvAHzyO8jAdZB
        KTENZlavLu9WfM1aWGkYo3x3v0G+XpPM6AdmTaLvFx84oL0ndks2YzeMnVr8gTytIgfrFHZTRc9jj
        /WmLaldg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJzr6-00A8gN-TI; Tue, 15 Feb 2022 15:35:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 068C93001F3;
        Tue, 15 Feb 2022 16:35:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E60542D7640CD; Tue, 15 Feb 2022 16:35:02 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:35:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
Message-ID: <YgvIJop34KuyUIx6@hirez.programming.kicks-ass.net>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126104815.2807416-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:48:13PM +0200, Adrian Hunter wrote:
> Hi
> 
> As of Intel SDM (https://www.intel.com/sdm) version 076, there are 2 new
> Intel PT features called Event Trace and TNT-Disable.
> 
> Event Trace exposes details about asynchronous events such as interrupts
> and VM-Entry/Exit.
> 
> TNT-Disable disables TNT packets to reduce the tracing overhead, but with
> the result that exact control flow information is lost.

What's a TNT?
