Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B71547B55
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiFLRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiFLRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9B94B4F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655056040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VXRX8SXAPpnvu3WCemr/dQD09XERxTPt12qAqIhnI8=;
        b=hGGN/SOZ8382QV0D7XcM7IFx6v+3KTFs91b+vaOTkA+Ts1U/otL4W53cqI1Vfj4gzFnJKF
        OoF8jCF+AmIZ1mFPJ6mONLD9JLlhHuUC56mCWnMcJDY6chsLe9Pp229nsNwqjuWyElwGFV
        6W5CaO84QoZMO7WAZweowfPE7ew33ng=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-XLShiTPMPCKVwKJg9brb4Q-1; Sun, 12 Jun 2022 13:47:18 -0400
X-MC-Unique: XLShiTPMPCKVwKJg9brb4Q-1
Received: by mail-ed1-f69.google.com with SMTP id eh10-20020a0564020f8a00b0042dd9bf7c57so2712281edb.17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3VXRX8SXAPpnvu3WCemr/dQD09XERxTPt12qAqIhnI8=;
        b=nJE7OyUjEGccufOI6UWi1QQZ3Y8yvx5b3bne4nT14V5Tver6m+4zvhWkw5m7thl92r
         hmV2wt1LYX4VCFhzDSz1b3T/0t6qQJkSSVWokhbtls1hHJLOQYqWb1U+xkP4tsrIgC87
         H+YpHYk654pOEH4ulbyWpuV6lFdFVKfW+DgDbekyZs8TZmj6BV/+p9FKU6eGcVQMGJPw
         1/y7MMrtO5Zpd+PMOO5RoKOzG/wsBuT1QPWUD0sNuxK5Cv5mwO7aX0eVCZDQabX18FRN
         XSLhnvJLEd3Cko0DHpTRIXBPxWfAeScJWC/eCOF/p8koMABCHuL2mupAZwpp6NKo7Q0V
         Cd7g==
X-Gm-Message-State: AOAM530OHvEnGYqIZBYrEnG+3EAUZlLAi6agsX9FojMsVbDrKZtC720N
        XZfSIq4adfcLMtTimw1U0/2XEcHf71pfJq+F+fw7Ck0Uw6VKktasdVczJK98hZsHMD7fj1uZYJS
        AjYfKTthPdIXqjV746EsGS/B0
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr5796866ejo.647.1655056037402;
        Sun, 12 Jun 2022 10:47:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbJh21En2BaQQDcC0nMLTz3WkrvC9AwBmQgbS3MF9CQguuvJY2mYJ1KKXwtKdCty9275vmkA==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr5796848ejo.647.1655056037160;
        Sun, 12 Jun 2022 10:47:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o18-20020aa7c7d2000000b004335e08d6c9sm3513595eds.33.2022.06.12.10.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 10:47:16 -0700 (PDT)
Message-ID: <a3de4cf5-d760-1666-6b9c-f620c238453b@redhat.com>
Date:   Sun, 12 Jun 2022 19:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     paulmck@kernel.org,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, mtosatti@redhat.com,
        sheng.yang@intel.com
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
In-Reply-To: <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 19:29, Paolo Bonzini wrote:
> On 6/12/22 18:40, Paul E. McKenney wrote:
>>> Do these reserved memory regions really need to be allocated separately?
>>> (For example, are they really all non-contiguous?  If not, that is, if
>>> there are a lot of contiguous memory regions, could you sort the IORT
>>> by address and do one ioctl() for each set of contiguous memory 
>>> regions?)
>>>
>>> Are all of these reserved memory regions set up before init is spawned?
>>>
>>> Are all of these reserved memory regions set up while there is only a
>>> single vCPU up and running?
>>>
>>> Is the SRCU grace period really needed in this case?  (I freely confess
>>> to not being all that familiar with KVM.)
>>
>> Oh, and there was a similar many-requests problem with networking many
>> years ago.  This was solved by adding a new syscall/ioctl()/whatever
>> that permitted many requests to be presented to the kernel with a single
>> system call.
>>
>> Could a new ioctl() be introduced that requested a large number
>> of these memory regions in one go so as to make each call to
>> synchronize_rcu_expedited() cover a useful fraction of your 9000+
>> requests?  Adding a few of the KVM guys on CC for their thoughts.

Another question: how much can call_srcu() callbacks pile up these days? 
  I've always been a bit wary of letting userspace do an arbitrary 
number of allocations that can only be freed after a grace period, but 
perhaps there's a way to query SRCU and apply some backpressure?

Paolo

