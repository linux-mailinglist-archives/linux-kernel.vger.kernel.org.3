Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA75443CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiFIG3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiFIG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24208FD38
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654756140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YS2i7Iwmt6bjy2CZg6saJgLmibzQmK3qHVln4Hin7so=;
        b=aAmj7NnNxS/El++S4RptIK0V296N/OzoppNrjlRXbqYUJP5hcnFis9VQNXep0BeWMUdzot
        PIYyF5/lC9nwoxz/hiTMFuX3YYZSFGWwXxC6dSKF15Wq0oeFRRsSE9Strryttq/PDM6xaf
        1m7yAmP8lvl6U8pifb+4reDIo0m2UPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-eUOpVjpfMGuIHV8AKBHRtg-1; Thu, 09 Jun 2022 02:28:58 -0400
X-MC-Unique: eUOpVjpfMGuIHV8AKBHRtg-1
Received: by mail-wm1-f71.google.com with SMTP id p18-20020a05600c23d200b0039c40c05687so4773431wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 23:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YS2i7Iwmt6bjy2CZg6saJgLmibzQmK3qHVln4Hin7so=;
        b=FCfieUA3JLTKv7u+hTyrNfuXFQvx/VnEvPP/2LLvvhhh1SqRf3sss17iV7Q57acV9l
         ujV44UKYQcqDfXpca3RM4eSm36rDhlmtE9FQx0M82qSNb/i733LWGKnkKUafAmZarH4S
         yZrlmF3d4Ac4h0WgXkOdXkVtTmtIl1cWOn2Wyb/nSTUq4WmkJXpkCtY0ABM5rPEycLvx
         APfpInLRsow0QBsbMydvHu1I3hrpY7EQATl1qmTrrYmLfqQHOTxlfL1cGLm5r4LU7Dxm
         T6MMFZ/X/ljANGwgKUg0o92wzNpZhUcsbi6qz/3JC732h8ba8YmVzlX/RKCSUEXb1b65
         JcEg==
X-Gm-Message-State: AOAM532T4+1/qFIwkC4WqAhICjOYCtfIF2bYR1phZ8bPCZQeQDNpmPzd
        GFLC366I79czLggYlmANWM5588dLPio3Jt0/CAvIII4UKWu7bdtAtUduVQpYhRU8VYqF5AO11wO
        bDrfwDrQJPIZ2xBzQa06xT/cY
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr37377349wrp.264.1654756137227;
        Wed, 08 Jun 2022 23:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzecbO5zVFAIzNwHW+UCEg1EecuV1PIp+mTHxvXC3ys8cb6pnjAk9ScxTq5zZjkPX6JKYHqsw==
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr37377324wrp.264.1654756136871;
        Wed, 08 Jun 2022 23:28:56 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0039c4ba160absm2530749wmq.2.2022.06.08.23.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 23:28:56 -0700 (PDT)
Date:   Thu, 9 Jun 2022 08:28:54 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
Message-ID: <YqGTJsf2R9hBz2bi@localhost.localdomain>
References: <20220607101807.249965-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607101807.249965-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/06/22 18:18, Yajun Deng wrote:
> sysctl_sched_dl_period_max and sysctl_sched_dl_period_min are unsigned
> integer, but proc_dointvec() wouldn't return error even if we set a
> negative number.
> 
> Use proc_douintvec_minmax() instead of proc_dointvec(). Add extra1 for
> sysctl_sched_dl_period_max and extra2 for sysctl_sched_dl_period_min.
> 
> It's just an optimization for match data and proc_handler in struct
> ctl_table. The 'if (period < min || period > max)' in __checkparam_dl()
> will work fine even if there hasn't this patch.
> 
> v2:
>  - update the log message.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

Guess I'm not opposed to the change, even if, as the changelog also
says, we should be already checking for sane values.

That said,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

