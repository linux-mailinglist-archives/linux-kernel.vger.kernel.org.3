Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B64B31CE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiBLAP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:15:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiBLAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:15:56 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DEE9D41;
        Fri, 11 Feb 2022 16:15:55 -0800 (PST)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CEA920B92C8;
        Fri, 11 Feb 2022 16:15:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CEA920B92C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644624954;
        bh=UDYtHia4Ue2d91o49LLvuQwerdlbSmBiDrISgm+Ptr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckaFWrRj40fP0qKwMg2LQZhpqRnItjvTj2KOZMndZM48SD06TG1meKtqbDEsBhGXq
         5EjwEqUaCIepfZmOFcUk9ugI+pJdy1d1gxINN1zYnAKNHUG3nDN3TmWGTjqJm7HG4d
         0gHS6BYsGZd4gC6wJLtAs+4Bf/hXpVuWZsuH37O0=
Date:   Fri, 11 Feb 2022 16:15:49 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/12] user_events: Enable user processes to create
 and write to trace events
Message-ID: <20220212001549.GA10191@kbox>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
 <20220210230021.3baf81ce@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210230021.3baf81ce@rorschach.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:00:21PM -0500, Steven Rostedt wrote:
> On Tue, 18 Jan 2022 12:43:14 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > User mode processes that wish to use trace events to get data into
> > ftrace, perf, eBPF, etc are limited to uprobes today. The user events
> > features enables an ABI for user mode processes to create and write to
> > trace events that are isolated from kernel level trace events. This
> > enables a faster path for tracing from user mode data as well as opens
> > managed code to participate in trace events, where stub locations are
> > dynamic.
> 
> So I finished my review, and I'm currently added it to my queue that
> I'm running through my tests.
> 
> Before I accept it though, I would really like you to send patches to
> linux-trace-devel@vger.kernel.org that add an API to libtracefs:
> 
>   https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
> 
> Something where users do not need to know about ioctls, or iovecs, etc.
> 
> struct tracefs_user_event *
>      tracefs_user_event_register(const char *name,
> 		enum tracefs_uevent_type type,
> 		char *field, ...);
> 
> Where tracefs_uevent_type can be:
> 
> enum tracefs_uevent_type {
> 	TRACEFS_UEVENT_END,
> 	TRACEFS_UEVENT_u8,
> 	TRACEFS_UEVENT_s8,
> 	TRACEFS_UEVENT_u16,
> 	...
> };
> 
>   uevent = tracefs_user_event_register("test",
> 		TRACEFS_UEVENT_u64, "count",
> 		TRACEFS_UEVENT_string, "name",
> 		TRACEFS_UEVENT_array, 16, "array",
> 		TRACEFS_UEVENT_END);
> 
> and that will do the ioctl to register the event, with the given types
> and fields.
> 
>   struct tracefs_user_event_status *ustatus;
> 
>   ustatus = tracefs_user_event_status();  // does the mmap.
> 
> 
> Then we could also have:
> 
>   if (tracefs_user_event_test(ustatus, uevent))
> 	tracefs_user_event_write(uevent, 64, "string", { 16 byte data });
> 
> The ustatus will be the mmap and the uevent will have the information
> to know where on the mmap to test for the event.
> 
> As for the write, the types are saved, and the write function will have
> variable arguments defined by the tracefs_user_event_register().
> 
> I think having that interface in libtracefs, would make this easy to
> use for everyone.

Agreed, I'll get going on this.

For performance I'm likely going to be play around with the shape of the
API. But it will look similar to the above.

Thanks,
-Beau
