Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6952A7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350799AbiEQQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350676AbiEQQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC5204B1E1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652803708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fm9KzJtFOypKMWXBennsk0UJi6E/shjo2l+eRpawlww=;
        b=dkEDjwcITpi+sAa5ovDE1QCpD7z+S1zy1LCGIs/VWwan+Yjha5cjztNi5wCNP+rTIGptsH
        5c3+h2uDPXdZfdTjBDJzDMPi1JN7foI2UgMzHKXgSH7wEDbNfzjW2+t4E2YwI69cElZh81
        koHzaCquSYGbQGSDkDQX5s3hzP5V/4U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-M018aGQ4OJKvKGEbWhsGLQ-1; Tue, 17 May 2022 12:08:26 -0400
X-MC-Unique: M018aGQ4OJKvKGEbWhsGLQ-1
Received: by mail-wr1-f70.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so4837553wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fm9KzJtFOypKMWXBennsk0UJi6E/shjo2l+eRpawlww=;
        b=ojsApuv1kdhhEyQT50iyTXOtrgvcQBd9D4ZBV+ehXhkGc95ZNxkCir69xbXWN0pLgI
         ec8d3r8DDlOKN6ZTsoTTyZ2AUe3QlEIRvlIFcbkcfQyj32cFSIfoMdK7xSqD8Dk019d4
         lwVHPd4OgnN8NrVSC5qBsW8HkzgxAIBSJgNu8P25/kMafI86VwHzR4Gkr783RqFpVb/X
         JtZs7gVx94y4qujnT84hbITB9MVXHX8MF/voYse9Ouk7mbv4r2FUL8ACd4Td1QHmmur3
         QLIHFEWZQTW+eKFrSAzqQzgMzHZ7JgW/eTlkOEt1EWQHQwrxgMiQm89+8AfoLGFppsok
         fAmQ==
X-Gm-Message-State: AOAM531Bvt/N2T5JhZTCxJXcm/GdnuMf9xBw5WGMFIp4vbOe/8uYFzRQ
        RVG131MDIbCSt08DIMmM4RRlCUcr4GhEMW5AAzb6994LVY8Nu/J3wxhG9wWRO17m4a/uh/9z0Vr
        XYIJMbyiPHVxqaJMviKP8sQJD
X-Received: by 2002:a05:6000:1a8c:b0:20c:bd6b:ecaf with SMTP id f12-20020a0560001a8c00b0020cbd6becafmr19086897wry.341.1652803704901;
        Tue, 17 May 2022 09:08:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoniVwkuFCPzxBwWUvmh+K1sNJ+267X2E62P9r5dU264vr5OUb66aqBuTXsKeaAmCwH5zoAw==
X-Received: by 2002:a05:6000:1a8c:b0:20c:bd6b:ecaf with SMTP id f12-20020a0560001a8c00b0020cbd6becafmr19086882wry.341.1652803704732;
        Tue, 17 May 2022 09:08:24 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8d0sm12686971wra.28.2022.05.17.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 09:08:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH v4] sched/rt: fix the case where sched_rt_period_us is
 negative
In-Reply-To: <20220517062918.104482-1-yajun.deng@linux.dev>
References: <20220517062918.104482-1-yajun.deng@linux.dev>
Date:   Tue, 17 May 2022 17:08:23 +0100
Message-ID: <xhsmhh75o16rs.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/22 14:29, Yajun Deng wrote:
> The proc_dointvec() is for integer, but sysctl_sched_rt_period is a
> unsigned integer, proc_dointvec() would convert negative number into
> positive number. So both proc_dointvec() and sched_rt_global_validate()
> aren't return error even if we set a negative number.
>
> Use proc_dointvec_minmax() instead of proc_dointvec() and use extra1
> limit the minimum value for sched_rt_period_us/sched_rt_runtime_us.
>
> Make sysctl_sched_rt_period integer to match proc_dointvec_minmax().
>

How about:


While sysctl_sched_rt_runtime is a signed integer and
sysctl_sched_rt_period is unsigned, both are handled in sched_rt_handler()
via proc_dointvec(), so negative inputs can be fed into
sysctl_sched_rt_period. However, per sched-rt-group.rst:

  * sched_rt_period_us takes values from 1 to INT_MAX.
  * sched_rt_runtime_us takes values from -1 to (INT_MAX - 1).

Use proc_dointvec_minmax() instead of proc_dointvec() and use the .extra1
parameter to enforce a minimum value.

Make sysctl_sched_rt_period a signed integer as this matches the expected
upper boundary and the expected type of proc_dointvec_minmax().

> v4:
>  - Make sysctl_sched_rt_period integer (Valentin Schneider)

Even if v3 was bogus, it's good not to skip it in the version log.
Also, the version logs should be after the "---" marker line:

Documentation/process/submitting-patches.rt
"""
Please put this information **after** the ``---`` line which separates
the changelog from the rest of the patch. The version information is
not part of the changelog which gets committed to the git tree. It is
additional information for the reviewers. If it's placed above the
commit tags, it needs manual interaction to remove it. If it is below
the separator line, it gets automatically stripped off when applying the
patch
"""

> v2:
>  - Remove sched_rr_timeslice_ms related changes (Valentin Schneider)
>
> Fixes: d0b27fa77854 ("sched: rt-group: synchonised bandwidth period")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

