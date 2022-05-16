Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA035287EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiEPPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiEPPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC22B3B3FD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652713495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAHdacegfEOL4lBtXElR1uIRPn39S9+UDm9yw8+jU9U=;
        b=jDJVYYTSq5ojnYyW5AA0wcg+WxW4wSelzUm79N78tSIlT8BsOG/QDPRAU36HyHJcMspOvS
        W0rZ1+ViL7eYDkbgHWu0R5H1a8yol+kkZNpeEQF2mpVjEEg4xQOETQqh9Guu75OvX+spJJ
        HucG/aP82qzpAYw4n2R+gmzBvz6LGpc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-X5yIEfFKMJCqr-ZzQrIn3w-1; Mon, 16 May 2022 11:04:54 -0400
X-MC-Unique: X5yIEfFKMJCqr-ZzQrIn3w-1
Received: by mail-wr1-f71.google.com with SMTP id a18-20020adffb92000000b0020cff565b91so673007wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rAHdacegfEOL4lBtXElR1uIRPn39S9+UDm9yw8+jU9U=;
        b=4V9dZv3sNQ/yaNTdUwoDZwhqQ/Wz04mFOT7XROMej5WKbhgRsfxNwadgH/8wmoucsV
         SlC1dYsbWFQ7L+CO6d0v2B/t+mTGdpbTUpxxkDK6HCe9G5sjSiS4ODSY+WmMKYBesop0
         nvSB9nPRKnrw9dchgIsMWoH1cxfnIM7oxM+B2krmMRw6o2Via4/XjC6X4Q4IVN5zYb1/
         i4uT0Y4C9VlxfdFAFoB4V6evpFcy5r0b51rbMeCDHBZpR8EBHWUdbB6bmkbyg248Ksj1
         E/IhdiaZFMjYcfo8bbRglWg5F6gqL4T20eHSIabIyqgTgI/Ikx1tzBa22voCa9tS0lq+
         QjeA==
X-Gm-Message-State: AOAM531iGiCAbBXMSM9gGj4nIAkdsyvxQjDj5D0cdWWvud8+NXrKuqIN
        uY808FCv4Qa0xhDZzLL/H0W0UwZLRG/2sfDrtP/XdHN2sCSJNhSmhGgS+d4xv78q87URyzG0XJ0
        91Eap0F9JtzUa6K9qWTXEuROy
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr27348401wmi.106.1652713489890;
        Mon, 16 May 2022 08:04:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfhRh+VL84XP+iZc48jECR0in5U4KHH7e9V8C1KlWDlIb8MkOFgiAq1e/aqzgX7RC3jZGlVQ==
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr27348381wmi.106.1652713489702;
        Mon, 16 May 2022 08:04:49 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o17-20020adfca11000000b0020c5253d8ddsm10586060wrh.41.2022.05.16.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:04:49 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH v2] sched/rt: fix the case where sched_rt_period_us is
 negative
In-Reply-To: <20220512003945.610093-1-yajun.deng@linux.dev>
References: <20220512003945.610093-1-yajun.deng@linux.dev>
Date:   Mon, 16 May 2022 16:04:48 +0100
Message-ID: <xhsmhmtfh1ptb.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 08:39, Yajun Deng wrote:
> The proc_dointvec() is for integer, but sysctl_sched_rt_period is a
> unsigned integer, proc_dointvec() would convert negative number into
> positive number. So both proc_dointvec() and sched_rt_global_validate()
> aren't return error even if we set a negative number.
>
> Use proc_dointvec_minmax() instead of proc_dointvec() and use extra1
> limit the minimum value for sched_rt_period_us/sched_rt_runtime_us.
>
> Fixes: 391e43da797a ("sched: Move all scheduler bits into kernel/sched/")

That's just the last apparent change of the incriminated variable. AFAICT
the issue stems from:

- sysctl_sched_rt_period being unsigned int
- the ctl entry using proc_dointvec()
- the bounds check on sysctl_sched_rt_period being just <= 0 which doesn't
  actually respect the [1, INT_MAX] stated in
  Documentation/scheduler/sched-rt-group.rst

The <= thing was added by:

  ec5d498991e8 ("sched: fix deadlock in setting scheduler parameter to zero")

but AFAICT the unsigned int vs proc_dointvec() thing dates back to:

  d0b27fa77854 ("sched: rt-group: synchonised bandwidth period")

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

In the absence of a cover letter (e.g. single-patch submission), this is
where you should write patch version changelogs (see
Documentation/process).

>  kernel/sched/rt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b491a0f8c25d..3add32679885 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -37,6 +37,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>               .maxlen         = sizeof(unsigned int),
>               .mode           = 0644,
>               .proc_handler   = sched_rt_handler,
> +		.extra1		= SYSCTL_ONE,

Per earlier comment, the Documentation says that this needs to be within
[1, INT_MAX], which you do get by excluding negative values when casting to
int...

How about we make sysctl_sched_rt_period int on top of this, then all variables
modified by the sched_rt_handler() proc_dointvec() are *actually* int, and
the upper bound requires less mental gymnastics to be figured out?

>       },
>       {
>               .procname       = "sched_rt_runtime_us",
> @@ -44,6 +45,8 @@ static struct ctl_table sched_rt_sysctls[] = {
>               .maxlen         = sizeof(int),
>               .mode           = 0644,
>               .proc_handler   = sched_rt_handler,
> +		.extra1		= SYSCTL_NEG_ONE,
> +		.extra2		= (void *)&sysctl_sched_rt_period,

Per this, you could also remove the

                ((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||

from sched_rt_global_validate(), no?

>       },
>       {
>               .procname       = "sched_rr_timeslice_ms",
> @@ -2959,9 +2962,6 @@ static int sched_rt_global_constraints(void)
>  #ifdef CONFIG_SYSCTL
>  static int sched_rt_global_validate(void)
>  {
> -	if (sysctl_sched_rt_period <= 0)
> -		return -EINVAL;
> -
>       if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
>               ((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
>                ((u64)sysctl_sched_rt_runtime *
> @@ -2992,7 +2992,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>       old_period = sysctl_sched_rt_period;
>       old_runtime = sysctl_sched_rt_runtime;
>
> -	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>
>       if (!ret && write) {
>               ret = sched_rt_global_validate();
> --
> 2.25.1

