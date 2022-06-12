Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E0547BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiFLTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiFLTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AAE72E68A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655061833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpxOZFertIo+s0I5XgGbGkAyy7Nk6JqrUzhDIWvRevY=;
        b=IjbdcC+yZ/dZbgt9c/LCqJNwHFB1WiF5eH1BNP+zOt2p9aGMQ3EqMa6wn3b+pSjAJ9KWxE
        sWSDBUgeK4DouTDpUwXyFciSnImMCAGgxOs+Im2z+bNC3FfZepm2fg4cohbTKScezvNmlr
        5QFeKJi8OlEK1Vsj/bai3J4XrFJgKNI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444--wZE1wTSOk2H6g6_qgI64A-1; Sun, 12 Jun 2022 15:23:52 -0400
X-MC-Unique: -wZE1wTSOk2H6g6_qgI64A-1
Received: by mail-ed1-f71.google.com with SMTP id co13-20020a0564020c0d00b0042dc9ef4f01so2800689edb.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=cpxOZFertIo+s0I5XgGbGkAyy7Nk6JqrUzhDIWvRevY=;
        b=5ukjFBuOtMts5r3x75XO9XVc0gDUpz/ubluGvr2PTFNtsn11WHHQXhvcX783XLIFX2
         5hwgQyCrXzVH8eSLSA5S+H7uRe7FEFtaI/gR1DGQc9CKlSE//kVkCripoLIEtOw3xxkg
         ByzE+NhS5JOl8eHrN7dLUKofT9ffp1XcK1yyJ8hYdZFFjB+CcBwubHDAMWFuFpNG2D88
         4P2/MFeaDnn7zfcTZF8M7l6y1MAreNQh5KuryDxOsMQQvaOsbM1jD2pen4kM4O6WhfXl
         WKa30J4E5e7oTs0UkNJyBJxR3T1WCTmQKML243xjZWGmgPRV1LiFYH+Q7GSlRPbHGR9P
         RpOw==
X-Gm-Message-State: AOAM533+LyWx66gfHq7WkMXm239zujcDzuu9weMCWZfsSr0p0CA/QjuI
        w4NiYgAIp++oc8aQmRAEWbXzWNmVvjgU4kR3DqqytY8yj0yezwrr0U2lvJOTJnzF6zqVi64hN4q
        8AebYpbNf9jRD/W57+WjsVuAl
X-Received: by 2002:a05:6402:195:b0:431:5499:35eb with SMTP id r21-20020a056402019500b00431549935ebmr43334289edv.346.1655061831526;
        Sun, 12 Jun 2022 12:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9gB6ulRmuQas9m8xFYmrSPlhBoCP4K8sA3j1Uuz81qOYO0PgE41FThFEWzZasHL/2IAvgOg==
X-Received: by 2002:a05:6402:195:b0:431:5499:35eb with SMTP id r21-20020a056402019500b00431549935ebmr43334272edv.346.1655061831322;
        Sun, 12 Jun 2022 12:23:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m17-20020a170906849100b007105a157706sm2792823ejx.82.2022.06.12.12.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 12:23:31 -0700 (PDT)
Message-ID: <bfdc80bd-0be6-f591-e998-c3ad65283404@redhat.com>
Date:   Sun, 12 Jun 2022 21:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
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
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
In-Reply-To: <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 20:49, Paul E. McKenney wrote:
>>
>> 1) kvm->irq_srcu is hardly relying on the "sleepable" part; it has readers
>> that are very very small, but it needs extremely fast detection of grace
>> periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up
>> KVM_SET_GSI_ROUTING", 2014-05-05) which split it off kvm->srcu.  Readers are
>> not so frequent.
>>
>> 2) kvm->srcu is nastier because there are readers all the time.  The
>> read-side critical section are still short-ish, but they need the sleepable
>> part because they access user memory.
> 
> Which one of these two is in play in this case?

The latter, kvm->srcu; though at boot time both are hammered on quite a 
bit (and then essentially not at all).

For the one involved it's still pretty rare for readers to sleep, but it 
cannot be excluded.  Most critical sections are short, I'd guess in the 
thousands of clock cycles but I can add some instrumentation tomorrow 
(or anyway before Tuesday).

> The problem was not internal to SRCU, but rather due to the fact
> that kernel live patching (KLP) had problems with the CPU-bound tasks
> resulting from repeated synchronize_rcu_expedited() invocations.

I see.  Perhaps only add to the back-to-back counter if the 
synchronize_srcu_expedited() takes longer than a jiffy? This would 
indirectly check if syncronize_srcu_expedited() readers are actually 
blocking.  KVM uses syncronize_srcu_expedited() because it expects it to 
take very little (again I'll get hard numbers asap).

Paolo

