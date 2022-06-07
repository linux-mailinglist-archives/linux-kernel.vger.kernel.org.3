Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0853F357
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiFGBZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGBZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:25:57 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380458FD54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:25:56 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654565154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvSh/lnApLZcKG7ml4gGVvnxWq7dPGi/tcgfunRKmwo=;
        b=JQQ0bahkSHPXrmX6aoCRYarRtCtIBtfwfsaHak+oG8hHOjLO6p2qqFoP8jw+u8sHeQmias
        MVbVi+LeBfhpLU/8gSJb8TIV/xB9a3k6SrbXO7zTOVl3nHI6ghomWmCpIHRPMpJ6P7g2li
        57lq8XmdbG7nX4afMC3uRGSNW8uYZW4=
Date:   Tue, 07 Jun 2022 01:25:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <b4d4313342a10afc7cda2574d37fdb38@linux.dev>
Subject: Re: [PATCH v4] sched/rt: fix the case where sched_rt_period_us is
 negative
To:     "Valentin Schneider" <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <xhsmhh75o16rs.mognet@vschneid.remote.csb>
References: <xhsmhh75o16rs.mognet@vschneid.remote.csb>
 <20220517062918.104482-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.=0A=0A=0A=0AMay 18, 2022 12:08 AM, "Valentin Schneider" <vschneid@re=
dhat.com> wrote:=0A=0A> On 17/05/22 14:29, Yajun Deng wrote:=0A> =0A>> Th=
e proc_dointvec() is for integer, but sysctl_sched_rt_period is a=0A>> un=
signed integer, proc_dointvec() would convert negative number into=0A>> p=
ositive number. So both proc_dointvec() and sched_rt_global_validate()=0A=
>> aren't return error even if we set a negative number.=0A>> =0A>> Use p=
roc_dointvec_minmax() instead of proc_dointvec() and use extra1=0A>> limi=
t the minimum value for sched_rt_period_us/sched_rt_runtime_us.=0A>> =0A>=
> Make sysctl_sched_rt_period integer to match proc_dointvec_minmax().=0A=
> =0A> How about:=0A> =0A> While sysctl_sched_rt_runtime is a signed inte=
ger and=0A> sysctl_sched_rt_period is unsigned, both are handled in sched=
_rt_handler()=0A> via proc_dointvec(), so negative inputs can be fed into=
=0A> sysctl_sched_rt_period. However, per sched-rt-group.rst:=0A> =0A> * =
sched_rt_period_us takes values from 1 to INT_MAX.=0A> * sched_rt_runtime=
_us takes values from -1 to (INT_MAX - 1).=0A> =0A> Use proc_dointvec_min=
max() instead of proc_dointvec() and use the .extra1=0A> parameter to enf=
orce a minimum value.=0A> =0A> Make sysctl_sched_rt_period a signed integ=
er as this matches the expected=0A> upper boundary and the expected type =
of proc_dointvec_minmax().=0A> =0A>> v4:=0A>> - Make sysctl_sched_rt_peri=
od integer (Valentin Schneider)=0A> =0A> Even if v3 was bogus, it's good =
not to skip it in the version log.=0A> Also, the version logs should be a=
fter the "---" marker line:=0A> =0A> Documentation/process/submitting-pat=
ches.rt=0A> """=0A> Please put this information **after** the ``---`` lin=
e which separates=0A> the changelog from the rest of the patch. The versi=
on information is=0A> not part of the changelog which gets committed to t=
he git tree. It is=0A> additional information for the reviewers. If it's =
placed above the=0A> commit tags, it needs manual interaction to remove i=
t. If it is below=0A> the separator line, it gets automatically stripped =
off when applying the=0A> patch=0A> """=0A> =0A>> v2:=0A>> - Remove sched=
_rr_timeslice_ms related changes (Valentin Schneider)=0A>> =0A>> Fixes: d=
0b27fa77854 ("sched: rt-group: synchonised bandwidth period")=0A>> Signed=
-off-by: Yajun Deng <yajun.deng@linux.dev>=0A> =0A> Reviewed-by: Valentin=
 Schneider <vschneid@redhat.com>
