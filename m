Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294CF49BB55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiAYSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiAYSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:30:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D0C06176E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:30:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z5so6281801plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eO8s9hLwvlJikQeaCFAseyCvqgT6glPinZZVsLgmEJ4=;
        b=LTWIcnLPrfXn5U+QfEuIuT1peV6PBIumjl2Cbu8KOQP1cCt4nj3H0R3sTk13y/okh4
         QpuKIN2pWtYQKfhf2OnIy+6LSSwLFbYrH68BCajh/QODUERa5bQ3p14H0DJdXdd3oWve
         mYr0kiUadFKm7vTuZNqAL0ZsDnnBMKB1fGBabKMIhddsDDxqdjZ/50VQ7Bx9jPfwp3gg
         3QEkHBG1ZdFxvddC2qjkTreF/VXz/tTcmvFWNDCN/NPtzx0m2vxAs+Wj+FogV4MjMzu7
         ElFs3c3545NWIYS/faJaP5vdOe8+t3/bjdZcwR7Rwirz3/WduKqpbVv0b8wB4u7VPhcD
         0IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eO8s9hLwvlJikQeaCFAseyCvqgT6glPinZZVsLgmEJ4=;
        b=AU9oDpOJFFOQCF5TVY2Z5DGinvLvm6beJVmFEuMyUANvLqS0oOUdCO8FFhfkJ+S17Q
         T9av7QkHGsxTM50QcG6dFZV2nbIH8uX71EWu4EfMzfDQMfpOLc4w9XAJ+gQoI1vtvLUR
         2hakUnMhjr2SMhbtmwxkCp0g4RO0vMFlVeh9QGoK223b46bMyhpz9cwBUZq0WxhysunK
         4iCf1pXJpD8Pels/KhTaoChegBme3FCqiED5SWM6m6oblA8834m+nqS2lJT+7rDYqzIn
         1OxRhf4c2F2S5Jgf9aNdyyZZZ7Wa0XRFJvtIkkD1/HBLJ5tRRYf0fV+WLXZtifCf8RWP
         xUoQ==
X-Gm-Message-State: AOAM532nwOOqEqwklub7nB7vW1RQfSW0wiNMgt5Gw5FYeYhUJTobc2Xk
        i4j9aUiRjxHlp1JpXUVlbTtspw==
X-Google-Smtp-Source: ABdhPJyonBUrisE+StCuHL1cAmqPKeo62DpRUoacVUkai5sip9Owqzt4TRWKVqC8kPm0saNKv+Pb2Q==
X-Received: by 2002:a17:902:ba81:b0:14b:75c1:573f with SMTP id k1-20020a170902ba8100b0014b75c1573fmr3877179pls.128.1643135430210;
        Tue, 25 Jan 2022 10:30:30 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id h6sm9565861pfc.35.2022.01.25.10.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:30:29 -0800 (PST)
Message-ID: <8eaaffe1-f6aa-4d8f-bbc7-0a57002d1729@linaro.org>
Date:   Tue, 25 Jan 2022 10:30:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] sched/fair: Fix fault in reweight_entity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+af7a719bc92395ee41b3@syzkaller.appspotmail.com
References: <20220120200139.118978-1-tadeusz.struk@linaro.org>
 <20220125011804.mhlhdenbjluzqkgf@oracle.com>
 <CAKfTPtB7UvUG3C_xiHL-V6eDfDOAkpzFWa0_QQeeRAQG7PovXQ@mail.gmail.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <CAKfTPtB7UvUG3C_xiHL-V6eDfDOAkpzFWa0_QQeeRAQG7PovXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 01:14, Vincent Guittot wrote:
> Could we use :
> set_load_weight(p, !(p->__state & TASK_NEW));
> instead of
> set_load_weight(p, true);
> in set_user_nice and __setscheduler_params.

Wouldn't that require READ_ONCE() and rmb() after the read?

-- 
Thanks,
Tadeusz
