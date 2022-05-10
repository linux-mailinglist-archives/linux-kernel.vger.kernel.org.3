Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C524520FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiEJIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEJIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B829ED09
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TTENNFCykIlGX5I1SANVsjlmSxazMvN7qT6l0FxP4zo=; b=DkfMt6y3V2vQFrYxlPhKFbAvFz
        yRr78p2FfXgWB1MJHE4KL+foutcIZdrEyQY8rOFY2Zly5l/jArg9sH0VIXijWWqXfUBID8NVi+ZZF
        EgdqGpdsexbK6gBevXYRPB6yA5CBFD60yYGW+6+2HkLt/rZe6JDXmWbNSXVAfOmT57BIipUTb4kFB
        DJb4uwiTFKSDngoCs9DrHnpJ7zWq0y6cpp4MkhWWA6cOiuLS2aHFkPG1AMasvETQ61lTB1chXF910
        a+IRA0JllXg1nEmEWPWNOSt43qfzt0OhTaAKYyQimKMUUGSRFGzXA5HVHs7H1DbxzwLfzcC/Ab6p8
        gxmG4inw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noLFW-004FIj-UF; Tue, 10 May 2022 08:29:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB882981011; Tue, 10 May 2022 10:29:40 +0200 (CEST)
Date:   Tue, 10 May 2022 10:29:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
Message-ID: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
References: <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
 <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net>
 <20220426140959.op6u5m7id57aq7yc@wubuntu>
 <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
 <20220427103458.ecnqtaj3af63625h@wubuntu>
 <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
 <20220428100235.sqoxunbylqk2surk@wubuntu>
 <CAEf4BzaEo+dxSRJZHQiXYrj-a3_B-eODZUxGh3HrnPjquMYFXQ@mail.gmail.com>
 <20220510070122.GJ76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510070122.GJ76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:01:22AM +0200, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 12:32:31PM -0700, Andrii Nakryiko wrote:
> > So can this patch be applied, please, or it's a hard no?
> 
> Sorry; I got distracted with other work. I'll grudingly apply the patch.

  gcc-11-i386-allmodconfig [15:35]  FAILED
  | In file included from ../include/trace/define_custom_trace.h:55,
  |                  from ../samples/trace_events/trace_custom_sched.h:96,
  |                  from ../samples/trace_events/trace_custom_sched.c:24:
  | ../samples/trace_events/./trace_custom_sched.h: In function ‘ftrace_test_custom_probe_sched_switch’:
  | ../include/trace/trace_custom_events.h:178:42: error: passing argument 1 of ‘check_trace_callback_type_sched_switch’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  |   178 |         check_trace_callback_type_##call(trace_custom_event_raw_event_##template); \
  |       |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  |       |                                          |
  |       |                                          void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)}
  | ../include/trace/trace_custom_events.h:34:9: note: in expansion of macro ‘DEFINE_CUSTOM_EVENT’
  |    34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args));
  |       |         ^~~~~~~~~~~~~~~~~~~
  | ../samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of macro ‘TRACE_CUSTOM_EVENT’
  |    21 | TRACE_CUSTOM_EVENT(sched_switch,
  |       | ^~~~~~~~~~~~~~~~~~
  | In file included from ../include/linux/trace_events.h:11,
  |                  from ../samples/trace_events/trace_custom_sched.c:10:
  | ../include/linux/tracepoint.h:279:49: note: expected ‘void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int)’ {aka ‘void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)’} but argument is of type ‘void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *)’ {aka ‘void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)’}
  |   279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \
  |       |                                          ~~~~~~~^~~~~~~~~~~~~~~
  | ../include/linux/tracepoint.h:419:9: note: in expansion of macro ‘__DECLARE_TRACE’
  |   419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
  |       |         ^~~~~~~~~~~~~~~
  | ../include/linux/tracepoint.h:553:9: note: in expansion of macro ‘DECLARE_TRACE’
  |   553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  |       |         ^~~~~~~~~~~~~
  | ../include/trace/events/sched.h:222:1: note: in expansion of macro ‘TRACE_EVENT’
  |   222 | TRACE_EVENT(sched_switch,
  |       | ^~~~~~~~~~~
  | cc1: some warnings being treated as errors
  | make[3]: *** [../scripts/Makefile.build:292: samples/trace_events/trace_custom_sched.o] Error 1
  | make[3]: *** Waiting for unfinished jobs....
  | make[2]: *** [../scripts/Makefile.build:555: samples/trace_events] Error 2
  | make[1]: *** [/opt/buildbot/linux-2.6/Makefile:1834: samples] Error 2
  | make[1]: *** Waiting for unfinished jobs....
  | make: *** [Makefile:219: __sub-make] Error 2
  `----

