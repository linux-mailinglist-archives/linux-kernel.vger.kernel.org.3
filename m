Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE220523512
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiEKOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbiEKOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08E6669CC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652278207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ev676VUr9wmt9ONW4BmfvB1amD9N31g0cQC0WiK8AG8=;
        b=W8RPjYSi2d0RfdXpcJfYuQm9VaL8QA6perUv4Jl9JkEmRg2IoDXcR6Z4kV09vboIBpJhLR
        lUeM3P3RUlnKstojXUhktjIDZe69UE82jz81TdXXH5YoCodXXu4zyjD2CerembeVm4MVM6
        0h2xyjxySd1wk+zrub60caKQOzwaE60=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-YbrC7e3iORe7v3UcqloEiw-1; Wed, 11 May 2022 10:10:06 -0400
X-MC-Unique: YbrC7e3iORe7v3UcqloEiw-1
Received: by mail-wr1-f70.google.com with SMTP id v16-20020adfd190000000b0020c8fb5106dso882400wrc.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ev676VUr9wmt9ONW4BmfvB1amD9N31g0cQC0WiK8AG8=;
        b=mS08NcP+1beI4cZ47IftyJp5DdbMzZuc5AThq9uKYMQxeDH0wMqBDRFDop/Y5qlK/5
         l6LYTCU2rqS9gsfPSu0rjy7Fx1Suo+++a5QBLd1Gh4HeZTH3TCiWZ1HYB89re/bJ6m/3
         C+jIrgAmgDBjaor7VdDjIwY6bsAQfGw7ktjgwFnkpKcjcO8DgcUKfo+WLtY/UGOuFyX0
         6l1x3o6R7VTk+1zZNyvtr3r+v0A/fZobqMy4BIhiCb/mLeaLLE5JFQDkqin9QgWyzQcA
         YW1nUeCVt3a8Fp0GEa0tlOTAVJYXZAAhWnj0u+IxKoZvfxbx96MIiBRhQDYhVCs1ziro
         ksuA==
X-Gm-Message-State: AOAM532TaJY11YKJuWhHJVT+lEy5jYPIoU3gCW0CYqU1dv5Vw0Wj6JHU
        EvDoDIYvxnXWF8lFNTdCy7TqMQNavfmayh/QDwFY8jyHiMJUs7/eHvbXl4Y0odnYrJpiyLvWu+E
        vmTFZlW7WtjMqA6hilkI7TJkM
X-Received: by 2002:a5d:58e3:0:b0:20c:d508:43d4 with SMTP id f3-20020a5d58e3000000b0020cd50843d4mr8019625wrd.51.1652278204612;
        Wed, 11 May 2022 07:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5vDyAabZnjYe0byGB1ke4GqIFdgws2r135MZoMpimSnI+mAcz55IM3J9Sdt+pmYfr4ruCAQ==
X-Received: by 2002:a5d:58e3:0:b0:20c:d508:43d4 with SMTP id f3-20020a5d58e3000000b0020cd50843d4mr8019609wrd.51.1652278204393;
        Wed, 11 May 2022 07:10:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05600c1e0700b003945781b725sm5894140wmb.37.2022.05.11.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:10:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] sched/rt: fix the case where sched_rt_period_us is
 non-positive
In-Reply-To: <xhsmhsfpg1b9s.mognet@vschneid.remote.csb>
References: <20220511112140.103579-1-yajun.deng@linux.dev>
 <xhsmhsfpg1b9s.mognet@vschneid.remote.csb>
Date:   Wed, 11 May 2022 15:10:03 +0100
Message-ID: <xhsmhpmkk17pg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/22 13:53, Valentin Schneider wrote:
> On 11/05/22 19:21, Yajun Deng wrote:
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index b491a0f8c25d..f20389aa6731 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -37,6 +37,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>>               .maxlen         = sizeof(unsigned int),
>>               .mode           = 0644,
>>               .proc_handler   = sched_rt_handler,
>> +		.extra1		= SYSCTL_ONE,
>>       },
>
> Err, what kernel is this based on? AFAICT those have always lived in
> kernel/sysctl.c, not kernel/sched/rt.c
>

Nevermind, Peter pointed out this has recently been changed and is apparent
in linux-next.

