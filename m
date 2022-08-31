Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9742D5A7A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiHaJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiHaJX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B961134
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661937835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9MBC0+HRTTRIrHOS8VrK5mulNhNcGXVJqHWWS9TPvA=;
        b=R6BTpMFxDWW0tmP2/jFAluJE4z9j/A6LIBNvZ+IrDegoOKKvsnfV5FSzvUrMlo9bRYuPOZ
        u4PQ6aqj72Zw+MM+AigIFisUShoY7P1DK55lEu7Ll8YlI/7TU42+JG1qujje9OKWJ47IkE
        00ybKeeOi2aNvDz05oikouVjMn1oD8E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-zQIDFSfzN4yuLRfsj82NLw-1; Wed, 31 Aug 2022 05:23:53 -0400
X-MC-Unique: zQIDFSfzN4yuLRfsj82NLw-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso9159729edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=v9MBC0+HRTTRIrHOS8VrK5mulNhNcGXVJqHWWS9TPvA=;
        b=RRQEF5dct3x04ZnUfT6KFmdN5hMWmLEu8vqcmjjMsMDeF+YTYOoL9H7HdvKgekF/L/
         doW8najUKln7Iw0PpT9YIiONylPs3XfO/913UvZmyZ0gEuEqB4+G+dOLB4V2A5Rv0eQw
         Vdq40OQkfv3GSzD0HuACW/69dM8px0ue66Qz5RufJCmc/ewDVlJ2+ICTuD0NtXZwM4tx
         Qw6970ib5n2ObeuWouUq1GQqT+06xJmZeQNv2u8MGaouVToD6wFtskH4gNBpK1ZEJTTr
         wSbzJX/a2P9tBfljM9AVrJJBr1+IS2pXgjv+SrobzUOhEYVD6P23PunNXjNEj+X+Cf9l
         ap4g==
X-Gm-Message-State: ACgBeo0yCJ39bNa2i8h9Sgp1/4+kAB4saIWmH3oFXQBakcjv41Ifgmnc
        Up3f4Hu3HnmeUGzF72Lf+/0hCD3g+Y4/biv8gLcRis302uZto7NTT6/BbBCzqFl/S/8VAcOoNWv
        mdqPBq3Ca+XtMZqcNMtjWdmAa
X-Received: by 2002:a05:6402:14c6:b0:448:e27:5974 with SMTP id f6-20020a05640214c600b004480e275974mr17524101edx.53.1661937832793;
        Wed, 31 Aug 2022 02:23:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7M10atCkawoz+1c+roQ5xwuTbIzFrhGmsKOV4BuPlYOMza0LHC5T9uy+haK+SWO+gUym+XaQ==
X-Received: by 2002:a05:6402:14c6:b0:448:e27:5974 with SMTP id f6-20020a05640214c600b004480e275974mr17524082edx.53.1661937832550;
        Wed, 31 Aug 2022 02:23:52 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0073dcdf9b0bcsm7073059ejb.17.2022.08.31.02.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:23:52 -0700 (PDT)
Message-ID: <95f8c01c-12b2-5f2e-bc8f-288f16bfa5d3@redhat.com>
Date:   Wed, 31 Aug 2022 11:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] sched/deadline: Add should_push_task_away helper
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220829100533.19153-1-shangxiaojing@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220829100533.19153-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 12:05, Shang XiaoJing wrote:
> +static inline bool should_push_task_away(struct task_struct *a,
> +					  struct task_struct *b)

static inline bool should_push_task_dl(struct task_struct *curr, struct task_struct *p)

a and b are not good variable names, and add the _dl suffix (instead of away).

> +{
> +	return unlikely(dl_task(a)) &&
> +	       (a->nr_cpus_allowed < 2 ||
> +		!dl_entity_preempt(&b->dl, &a->dl)) &&
> +	       b->nr_cpus_allowed > 1;
> +}
> +

-- Daniel

