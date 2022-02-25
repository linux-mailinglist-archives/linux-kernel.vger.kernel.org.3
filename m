Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88A4C3E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiBYGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiBYGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:46:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548952763F1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:46:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i21so3890624pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zk9ju3IwH90PgmNQ/LV04l8j72tFlZyGQOmOzfhIN8Y=;
        b=DNbvqQi3bNkqD6OmYy6vwEwPxOOenY2ZwlWsXadaqpdZPrtlkh4UVpZbAGRrdWZS6E
         E2SCDcxIAdfAdZFE5wUTILR+yMWQzUPod1ndTJDBiQzxUeH/g4mDxZUxSReEYkevNLnY
         9PY1MuWtEZHPa9kaxPfnrfrJ5aFWWBm1tcbfftImjCWfuArxgopTI5GvP9BVQoQX6uSe
         PwrqXfYopkBX000+olDcW6aQIbeUhkRZveE84FOOGp087xzeirAMu6NMEGBRkA1AeMOH
         XgIT3RAud3r+vWm9RmxKLjKWyd45AxthZCtACzB0Zvv3KjA30vwOHfVZ9SoZVlt6OdHG
         wg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zk9ju3IwH90PgmNQ/LV04l8j72tFlZyGQOmOzfhIN8Y=;
        b=HRjyrmZtR4pUBgyjqRwwogT9P5Hpt5S5fBgVz07XweMZZXQAqqFxVOQWK6brfzH47s
         IEtVJZSAc1HfhvS//t4DCy75ut4EDaQN9PiwgOdIV20MjRNUB0d6RXOkCjm6T2/I1orv
         7jWszXfaHuLXIDsxW/82Nvj5WhWysxCfzZkOIk7vugW9/lHSjsGlnxlhHnXnx1W1Ruej
         EkpgGm9nsc/lNangRnBCDTOqW+pSk4GUSbTqyTVBRFya+l9me7vLdEEQSfHjn2aIeZ5f
         rcVEU+BxI62ngnfbycu693CEsexf4obRS2ni1AgW/9mkPlLVZSMYL1H6mwIw+z1a0J7X
         y8JQ==
X-Gm-Message-State: AOAM533fu6ce68LmHu/i3w1ecwk9Sl/Umx+O7bEYKtcDkBsLiP+khcnk
        /8MFyGrknp+RmK5PnFgyQ07/jA==
X-Google-Smtp-Source: ABdhPJy2bM/hH+lF4+dzeBwVF9FpJUEBjaNyPQrf61Sfmy89MUf9APGNUQ33YZWWh2CNqDP8c3J5NA==
X-Received: by 2002:a63:fb44:0:b0:372:9ec8:745a with SMTP id w4-20020a63fb44000000b003729ec8745amr5083383pgj.551.1645771581797;
        Thu, 24 Feb 2022 22:46:21 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id lr11-20020a17090b4b8b00b001bc4098fa78sm1270055pjb.24.2022.02.24.22.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 22:46:21 -0800 (PST)
Message-ID: <9fe00f72-4e2e-38ff-d64a-4ae41e683316@bytedance.com>
Date:   Fri, 25 Feb 2022 14:46:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/24/22 11:20 PM, Peter Zijlstra Wrote:
> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
>> Current load balancing is mainly based on cpu capacity
>> and task util, which makes sense in the POV of overall
>> throughput. While there still might be some improvement
>> can be done by reducing number of overloaded cfs rqs if
>> sched-idle or idle rq exists.
> 
> I'm much confused, there is an explicit new-idle balancer and a periodic
> idle balancer already there.

The two balancers are triggered on the rqs that have no tasks on them,
and load_balance() seems don't show a preference for non-idle tasks so
there might be possibility that only idle tasks are pulled during load
balance while overloaded rqs (rq->cfs.h_nr_running > 1) exist. As a
result the normal tasks, mostly latency-critical ones in our case, on
that overloaded rq still suffer waiting for each other. I observed this
through perf sched.

IOW the main difference from the POV of load_balance() between the
latency-critical tasks and the idle ones is load.

The sched-idle balancer is triggered on the sched-idle rqs periodically
and the newly-idle ones. It does a 'fast' pull of non-idle tasks from
the overloaded rqs to the sched-idle/idle ones to let the non-idle tasks
make full use of cpu resources.

The sched-idle balancer only focuses on non-idle tasks' performance, so
it can introduce overall load imbalance, and that's why I put it before
load_balance().

Best Regards,
	Abel
