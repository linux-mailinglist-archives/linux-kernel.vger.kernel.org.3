Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22BC54BF43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiFOBaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:30:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796A2FFDD;
        Tue, 14 Jun 2022 18:29:58 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655256596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lY2dF29RfMCDJraWHniXeH1mqvCo+dEuz2ZfjUE/Dcg=;
        b=MXK61xNGGQMAFxUfmB3NYrHxRlNudq9bfJtI9vOj/CkKRvBdsNSpALpFiNLhqtm2qOl45X
        Y0U9PKV/5pakKkgGRKJm5LVsZbXpDqk9PpOpJ0fZZST/ROKr0sBM4EqFW9tsXi7BLhiXYM
        ftUDHugZqh5L+QM5Zsk747Y00bgLBPU=
Date:   Wed, 15 Jun 2022 01:29:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <f1cdd17717cef7ec33af096e104db03c@linux.dev>
Subject: Re: [PATCH] perf/core: fix perf_event_mux_interval_ms when set
 zero
To:     "Namhyung Kim" <namhyung@kernel.org>
Cc:     "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Stephane Eranian" <eranian@google.com>,
        "linux-perf-users" <linux-perf-users@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <CAM9d7cj4=3DNz=kKhVbx0uKYwbbaQF6ZdjkezKPdT67j8rcEMg@mail.gmail.com>
References: <CAM9d7cj4=3DNz=kKhVbx0uKYwbbaQF6ZdjkezKPdT67j8rcEMg@mail.gmail.com>
 <20220614103751.1395645-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 15, 2022 6:08 AM, "Namhyung Kim" <namhyung@kernel.org> wrote:=0A=0A>=
 Hello,=0A> =0A> On Tue, Jun 14, 2022 at 3:38 AM Yajun Deng <yajun.deng@l=
inux.dev> wrote:=0A> =0A>> The perf_event_mux_interval_ms is set to zero =
or one by default.=0A> =0A> I see that __perf_mux_hrtimer_init() sets it =
to PERF_CPU_HRTIMER=0A> if it's less than 1.=0A> =0AYes, pmu->hrtimer_int=
erval_ms was set to PERF_CPU_HRTIMER, but perf_event_mux_interval_ms didn=
't.=0AWe can execute 'cat /sys/devices/intel_pt/perf_event_mux_interval_m=
s' see that.=0A=0A> Thanks,=0A> Namhyung=0A> =0A>> It can't change back w=
hen someone changes it from zero to another=0A>> value.=0A>> =0A>> Make p=
erf_event_mux_interval_ms to PERF_CPU_HRTIMER when set zero.=0A>> =0A>> F=
ixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interva=
l per PMU")=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>> --=
-=0A>> kernel/events/core.c | 5 ++++-=0A>> 1 file changed, 4 insertions(+=
), 1 deletion(-)=0A>> =0A>> diff --git a/kernel/events/core.c b/kernel/ev=
ents/core.c=0A>> index 61ad10862c21..73c8c7462bbf 100644=0A>> --- a/kerne=
l/events/core.c=0A>> +++ b/kernel/events/core.c=0A>> @@ -10954,9 +10954,1=
2 @@ perf_event_mux_interval_ms_store(struct device *dev,=0A>> if (ret)=
=0A>> return ret;=0A>> =0A>> - if (timer < 1)=0A>> + if (timer < 0)=0A>> =
return -EINVAL;=0A>> =0A>> + if (timer < 1)=0A>> + timer =3D PERF_CPU_HRT=
IMER;=0A>> +=0A>> /* same value, noting to do */=0A>> if (timer =3D=3D pm=
u->hrtimer_interval_ms)=0A>> return count;=0A>> --=0A>> 2.25.1
