Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387CE46850B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhLDN2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLDN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:28:51 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB6C061751;
        Sat,  4 Dec 2021 05:25:25 -0800 (PST)
Date:   Sat, 4 Dec 2021 21:25:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638624322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTsR7EARnIwZiWANDy8dCEHN3NQ0iA14jJz5uV9apYw=;
        b=n9tmpC5Cl0QXbiAoq2SvwX8X6DWANPbTwVehyegld5v8aHmTWVEFcncrpfos8TN210vWff
        70CRMqBypYKc95yzdHjO6Qn5T+WSRnEysneFV1ERqfkETElQUTMW8BZndYwvbLyVGSfXzU
        W182ebsUeO7k1IfoyVH+09J6nrD61qs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tao Zhou <tao.zhou@linux.dev>, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 00/14] RTLA: An interface for osnoise/timerlat tracers
Message-ID: <YatsNcmqxnMZ5ONS@geo.homenetwork>
References: <cover.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638182284.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:07:38PM +0100, Daniel Bristot de Oliveira wrote:

> The rtla(1) is a meta-tool that includes a set of commands that
> aims to analyze the real-time properties of Linux. But instead of
> testing Linux as a black box, rtla leverages kernel tracing
> capabilities to provide precise information about the properties
> and root causes of unexpected results.
> 
> To start, it presents an interface to the osnoise and timerlat tracers.
> In the future, it will also serve as home to the rtsl [1] and other
> latency/noise tracers.
> 
> If you just want to run it, you can download the tarball here:
>   - https://bristot.me/files/rtla/tarball/rtla-0.4.tar.bz2
> 
> To compile rtla on fedora you need:
>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
>   $ cd libtraceevent/
>   $ make
>   $ sudo make install
>   $ cd ..
>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
>   $ cd libtracefs/
>   $ make
>   $ sudo make install
>   $ cd ..
>   $ sudo dnf install python3-docutils procps-devel
>   $ cd $rtla_src
>   $ make
>   $ sudo make install

Set osnoise/x to DEADLINE, the return is not success. see:

tao@geo ~/opensource/rtla-0.4 $ sudo rtla osnoise top -P d:100us:1ms -c 0-3 -r 900000 -d 1M -q
boost_with_deadline failed to boost pid 4766: Operation not permitted
Failed to set sched parameters

top shows:

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND         
 4773 root      20   0       0      0      0 R  89.4   0.0   2:06.88 osnoise/0       
 4776 root      20   0       0      0      0 R  89.4   0.0   2:06.88 osnoise/3       
 4774 root      20   0       0      0      0 R  89.0   0.0   2:06.88 osnoise/1       
 4775 root      20   0       0      0      0 R  88.7   0.0   2:06.69 osnoise/2       

 t
