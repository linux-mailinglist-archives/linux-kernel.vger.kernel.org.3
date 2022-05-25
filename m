Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44EC533A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiEYJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiEYJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1723A1A81B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653472139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cmn5Dd9D3LZtVWPiUVFI46RQ0E8Or8cYY9mPhGTiFco=;
        b=GZJ9e2JUt3fhX5pPLXyYgU1ar10fNkS1jo1TFJKv+5EVJMxZrimz8PFH+fMr0yhG54eB/u
        +l/qIuLjE1a6G/+T0ZAMsH48oSre5eXGIzDecq9ktEo9e67Gn+bR2ajUaJ9k2GYphmIEeZ
        rSO1iSKOirkxYcIdyYnaUwl7hab92eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-t_vpgfTvN-KcvAipYS_QjQ-1; Wed, 25 May 2022 05:48:57 -0400
X-MC-Unique: t_vpgfTvN-KcvAipYS_QjQ-1
Received: by mail-wm1-f71.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so4261013wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Cmn5Dd9D3LZtVWPiUVFI46RQ0E8Or8cYY9mPhGTiFco=;
        b=grtaMplx1BFpK1yc7GGjHMGMBLwcwpPTf7y0MZNsVyngEzpIVGqXdqaGIh6uyehjg3
         yI0SjsPkKpyRJcZVg/A4zx+MvkzeQXxqFXZgGquUY0V+F8PZmDVnVH0h5DEhmHWvYUkE
         1IWkVMsbw05CJQMadnYH+mhRtwj6tjfg4s8EvCy62NsxTiORys7Yh2N2qQo6oLN/QM6D
         ZUxUqw3gz8/MWIK6Y6tLG1DEIcVwIY8Gngl/XdU1SNvzuyPx9J5hZ7VifMHMJij9gbZv
         Xx9/m0P+bH7m4R+Gu+/N3yVJu0uKvgrcNbH5MVvnTxJ6dG/SWIaks34q6O/0XtTx/D/R
         U4iQ==
X-Gm-Message-State: AOAM531OM4x3GUFq+Qr31dQ6t9E70RXfCtIkMdFK3qdBmrPPM7fqxFWB
        zkwsQAJx/fTvXCHTFuqSHrH5UTSnKqVn7uroj59gNO3m1+ooRybKDwWmWwPVITZrHtaEttE9fEk
        eFqGmQFMBuc9IOha495rfz8F3
X-Received: by 2002:a5d:6daf:0:b0:20f:f1e7:c720 with SMTP id u15-20020a5d6daf000000b0020ff1e7c720mr5782467wrs.584.1653472136653;
        Wed, 25 May 2022 02:48:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBfd9tvURlfA43DeSy5H19Fjt9Zo4QuazYxO0ljHjPHfpeDz0gznsyGMUWJdSN/hXe6N+p9g==
X-Received: by 2002:a5d:6daf:0:b0:20f:f1e7:c720 with SMTP id u15-20020a5d6daf000000b0020ff1e7c720mr5782459wrs.584.1653472136507;
        Wed, 25 May 2022 02:48:56 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h15-20020adf9ccf000000b0020e58b3e064sm1630696wre.74.2022.05.25.02.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:48:56 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
In-Reply-To: <Yo0z56Fqgj3gqYlG@lorien.usersys.redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
 <Yo0z56Fqgj3gqYlG@lorien.usersys.redhat.com>
Date:   Wed, 25 May 2022 10:48:55 +0100
Message-ID: <xhsmhwneahri0.mognet@vschneid.remote.csb>
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

On 24/05/22 15:37, Phil Auld wrote:
> Hi Valentin,
>
> I did it like this (shown below) and from my test it also works for
> this case.
>
> I could move it below the lock and goto out;  instead if you think
> that is better.

I *think* the cpu_add_remove_lock mutex should be sufficient here.

> It still seems better to me to stop this higher up
> because there's work being done in the out path too.  We're not
> actually doing any hot(un)plug so doing post unplug cleanup seems
> iffy.
>

I think so too; I now realize _cpu_up() and _cpu_down() have slightly
different prologues: _cpu_up() does its hotplug states / cpu_present_mask
checks *after* grabbing the cpu_hotplug_lock, _cpu_down() does that *before*...

So I believe what you have below is fine, modulo whether we want to align
the prologue of these two functions or not :-)

> _cpu_down()
> ...
> out:
>         cpus_write_unlock();
>         /*
>          * Do post unplug cleanup. This is still protected against
>          * concurrent CPU hotplug via cpu_add_remove_lock.
>          */
>         lockup_detector_cleanup();
>         arch_smt_update();
>         cpu_up_down_serialize_trainwrecks(tasks_frozen);
>       return ret;
> }
>
> ----------
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8a71b1149c60..e36788742d18 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1130,6 +1130,13 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>       if (!cpu_present(cpu))
>               return -EINVAL;
>
> +	/*
> +	 * The caller of cpu_down() might have raced with another
> +	 * caller. Nothing to do.
> +	 */
> +	if (st->state <= target)
> +		return 0;
> +
>       cpus_write_lock();
>
>       cpuhp_tasks_frozen = tasks_frozen;
>
>
>
>
> Cheers,
> Phil
>
> --

