Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DC532D00
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiEXPMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiEXPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B98F3D4BB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653405121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofqhF7B0Lhr9XDJpCI5NspBe7jXyy3A5iExBePEO86M=;
        b=hWN9iqCPVXBmCJ0YMMvLsB3VW+sjxTObcrcS642M4fkbZxk1Mhm7HkRuD13H5SUnLZ77EO
        qcIp5IRj0ktw9Jv7FvbtyjKClEt4JRcA4twu6KjY6aQ+UEpSnshUVAntCmJUzvsaB+K0Gm
        iTYop9+vHW+dz9Hh5BpIDEKeM6TEwww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-ORQeLfTsMK6bE3vVpY43bw-1; Tue, 24 May 2022 11:11:54 -0400
X-MC-Unique: ORQeLfTsMK6bE3vVpY43bw-1
Received: by mail-wr1-f69.google.com with SMTP id e17-20020adfe391000000b0020e64e7dd15so4399432wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ofqhF7B0Lhr9XDJpCI5NspBe7jXyy3A5iExBePEO86M=;
        b=RTMX77vBkxYYgKlsGyM8qeVkCpGdkHtFkjlMoTfePhPaZmFxlNUhxeL9p9zb81lGl+
         tIvKkvWEwftZeYqunHJ8AMe2A0EdzcBx8fDAJSIUjEaJG+H40pTeb6XxMowbKTp+8DUB
         X4XAAWQNCF1b5jHmOvyNRnMnyy4RRexM8A3hh2BC2OkWg3okqPCaBaWAV1ehJYjtsHyy
         eOqsz0bEOYHyW78ZsnYdEowDgbxAz9++CgqAfG3XCkm0vOVZ2McCbX5yDNxaQtVXhsNg
         8XBYV6Q5QSLrfig3XxzoiNKMrxzjJRQgw0O/vzEXndBv/YwMrbh1A8peLuecp4HG7FcO
         59eQ==
X-Gm-Message-State: AOAM530ShI+wZ9rka/df3f6ltZRbNR26aZ1q+Mo4k2yGQ22Z0OMthMM1
        tlJnSqz59EIyig6EF9ZLvSqtamQMcA2ZM+i+tcnHkv+wnA82nzzRHjdqL+SVLNzG/YySz0E1X00
        Bdwlp6REB0Rn7rhXb/5Vwg2x+
X-Received: by 2002:a05:600c:354a:b0:394:8fa4:73bc with SMTP id i10-20020a05600c354a00b003948fa473bcmr4204448wmq.37.1653405112862;
        Tue, 24 May 2022 08:11:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN72fmnvYSWbgO8JmvvLE5huJ+2BUFJSTipvlRfySv+pMVULvp/Gj0OiXV+/iI8xQuds0lrA==
X-Received: by 2002:a05:600c:354a:b0:394:8fa4:73bc with SMTP id i10-20020a05600c354a00b003948fa473bcmr4204425wmq.37.1653405112626;
        Tue, 24 May 2022 08:11:52 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m6-20020adfa3c6000000b0020fc4cd81f6sm10619841wrb.60.2022.05.24.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:11:52 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
In-Reply-To: <20220523144728.32414-1-pauld@redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
Date:   Tue, 24 May 2022 16:11:51 +0100
Message-ID: <xhsmh35gzj77s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/22 10:47, Phil Auld wrote:
> writing the current state back into hotplug/target calls cpu_down()
> which will set cpu dying even when it isn't and then nothing will
> ever clear it. A stress test that reads values and writes them back
> for all cpu device files in sysfs will trigger the BUG() in
> select_fallback_rq once all cpus are marked as dying.
>
> kernel/cpu.c::target_store()
> 	...
>         if (st->state < target)
>                 ret = cpu_up(dev->id, target);
>         else
>                 ret = cpu_down(dev->id, target);
>
> cpu_down() -> cpu_set_state()
> 	 bool bringup = st->state < target;
> 	 ...
> 	 if (cpu_dying(cpu) != !bringup)
> 		set_cpu_dying(cpu, !bringup);
>
> Make this safe by catching the case where target == state
> and bailing early.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>
> Yeah, I know... don't do that. But it's still messy.
>
> !< != > 
>
>  kernel/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d0a9aa0b42e8..8a71b1149c60 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2302,6 +2302,9 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  #endif
>  
> +	if (target == st->state)
> +		return count;
> +

The current checks are against static boundaries, this has to compare
against st->state - AFAICT this could race with another hotplug operation
to the same CPU, e.g.

  CPU42.cpuhp_state
    ->state  == CPUHP_AP_SCHED_STARTING
    ->target == CPUHP_ONLINE

  <write CPUHP_ONLINE via sysfs, OK because current state != CPUHP_ONLINE>

  CPU42.cpuhp_state == CPUHP_ONLINE
  
  <issues ensue>


_cpu_up() has:

	/*
	 * The caller of cpu_up() might have raced with another
	 * caller. Nothing to do.
	 */
	if (st->state >= target)
		goto out;

Looks like we want an equivalent in _cpu_down(), what do you think?

>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
>  		return ret;
> -- 
> 2.18.0

