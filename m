Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D37549ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbiFMURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349329AbiFMUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C85C0E37
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655146499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twODBOMo1H0OlE0mw4AXAcH5DtMeaVs68JEX7EwBl18=;
        b=Enfa0fwrrEnDkOPZTankRumB6apKff+xcxvVr4PV5sGnmdGsYyYyvms5sJzsGvCCwLHl4u
        KUwaSXHOZZsZapWUSDWVqVuHfsKtzCjjYUYyJexoE8Kz1eG4TNdvxtjw4lt4r2aFvaEYHY
        QbTRTvCjbR928+FFvgNgqcWTpz2GDck=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-gTFMQczbOi62EkMEe4Lr5Q-1; Mon, 13 Jun 2022 14:54:53 -0400
X-MC-Unique: gTFMQczbOi62EkMEe4Lr5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF19829AA3B0;
        Mon, 13 Jun 2022 18:54:52 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4941D4010E4D;
        Mon, 13 Jun 2022 18:54:52 +0000 (UTC)
Message-ID: <a2b40ed8-54e8-50c8-557e-99fba8d3f270@redhat.com>
Date:   Mon, 13 Jun 2022 14:54:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] rcu-tasks: Delay rcu_tasks_verify_self_tests() to avoid
 missed callbacks
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20220610184212.822113-1-longman@redhat.com>
 <20220610205814.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <5aae210e-2553-57ca-e4d5-0b0f20ec92cd@redhat.com>
 <20220613175600.GG1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220613175600.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 13:56, Paul E. McKenney wrote:
> On Mon, Jun 13, 2022 at 12:01:24PM -0400, Waiman Long wrote:
>> On 6/10/22 16:58, Paul E. McKenney wrote:
>>> On Fri, Jun 10, 2022 at 02:42:12PM -0400, Waiman Long wrote:
>>>> Even though rcu_tasks selftest is initiated early in the boot process,
>>>> the verification done at late initcall time may not be late enough to
>>>> catch all the callbacks especially on systems with just a few cpus and
>>>> small memory.
>>>>
>>>> After 12 bootup's On a s390x system, 1 of them had failed rcu_tasks
>>>> verification test.
>>>>
>>>> [    8.183013] call_rcu_tasks() has been failed.
>>>> [    8.183041] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x64/0xd0
>>>> [    8.203246] Callback from call_rcu_tasks() invoked.
>>>>
>>>> In this particular case, the callback missed the check by about
>>>> 20ms. Similar rcu_tasks selftest failures are also seen in ppc64le
>>>> systems.
>>>>
>>>> [    0.313391] call_rcu_tasks() has been failed.
>>>> [    0.313407] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x5c/0xa0
>>>> [    0.335569] Callback from call_rcu_tasks() invoked.
>>>>
>>>> Avoid this missed callback by delaying the verification using
>>>> delayed_work. The delay is set to be about 0.1s which hopefully will
>>>> be long enough to catch all the callbacks on systems with few cpus and
>>>> small memory.
>>>>
>>>> Fixes: bfba7ed084f8 ("rcu-tasks: Add RCU-tasks self tests")
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Good catch, thank you!
>>>
>>> A few days ago, I queued this:
>>>
>>> 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")
>>>
>>> This is shown in full at the end of this email.  Does this fix this
>>> problem for you?
>> I think your patch should fix the false positive warning and it give plenty
>> of time for this to happen.
>>
>> I do have one question though. rcu_tasks_verify_selft_tests() is called from
>> do_initcalls(). Since it may not be the last late initcall, does that mean
>> other late initcalls queued after that may be delayed by a second or more?
> Indeed.  Which is why I would welcome the workqueues portion of your
> patch on top of the above patch in -rcu.  ;-)

Sure. I will work on such a follow-up patch.

Cheers,
Longman

