Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84C599329
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbiHSCpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiHSCpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:45:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C195AC7C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:45:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w28so2513124qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=R1Nex1dRhqgA1BqvYMjnNRmSClR3k11xE4UGyWNn60Q=;
        b=Ok012zWfPIvabs2S1CBCGnYTewq8E8mj9YgLWiYgQDPjkQNRZq5nWVnIei1cFuroJ7
         +1DXtuzBRVj9hlJwEu4L5PQfTIJqaX168fJMehooRDG2PL8BOy9OGONeNiyxfWMiEMaz
         14oL+wgqSc7THLVk7fGQDl2ynU3GmmTMyzSPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R1Nex1dRhqgA1BqvYMjnNRmSClR3k11xE4UGyWNn60Q=;
        b=sVd+LAFN5M14YfOl/XJ+OMV0NHj3MTGCz+7r3zzviJwnHPNg/+cpWr2LUCRaNJGiZE
         m8MlIxDGdtLIW2tzCcBOePeXsYzyXf4Q0/37J8+9+p1vaGBnHT60hfz1iYXxY3VcfWCF
         MmwBf1P7bS+gLDvwOdcRv9ib9Zq8OddU72xBxF6YCd8BMLsHJIO/uUduJDMstuLw+2ZF
         UPb0/sF25x6zRkJJvnbt/fvNOmMgLBfiJPtdJUCaH9A7WFQWaCwlVYZ0+fdUrI/AlGv4
         1dzrbh24hdUEI5CrX16YcI+iCfi4VZ/6fWcwG0IOU7kemuphOTaNE3sa7fB0diGXkf+l
         x4gw==
X-Gm-Message-State: ACgBeo25FYV9R0roeKWQHRagcKW5nM1D7q9syhTZS79bSOc+WB8+JGI1
        p6VWzAApw2ftVNqD5XgENJFyRg==
X-Google-Smtp-Source: AA6agR6eDfn8hvm4pO7LcZECxnyoEvfMsXNaLritry7g8G9XfKNTM+77uXybpHLmFiuK0ZXvTiW7Ig==
X-Received: by 2002:a05:622a:d1:b0:344:9490:148a with SMTP id p17-20020a05622a00d100b003449490148amr3947146qtw.211.1660877120490;
        Thu, 18 Aug 2022 19:45:20 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id y12-20020a05620a25cc00b006bb78d095c5sm2649392qko.79.2022.08.18.19.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 19:45:20 -0700 (PDT)
Message-ID: <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
Date:   Thu, 18 Aug 2022 22:45:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>
>>>> [Sorry, adding back the CC list]
>>>>
>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
>>>> <joel@joelfernandes.org> wrote:
>>>>>
>>>>> This is required to prevent callbacks triggering RCU machinery too
>>>>> quickly and too often, which adds more power to the system.
>>>>>
>>>>> When testing, we found that these paths were invoked often when the
>>>>> system is not doing anything (screen is ON but otherwise idle).
>>>>
>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
>>>> after applying this particular patch. It is the first time I could
>>>> test ChromeOS boot times with the series since it was hard to find a
>>>> ChromeOS device that runs the upstream kernel.
>>>>
>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
>>>> patch? I wonder if the issue is with wake up interaction with the nocb
>>>> GP threads.
>>>>
>>>> We ought to disable lazy RCU during boot since it would have little
>>>> benefit anyway. But I am also concerned about some deeper problem I
>>>> did not catch before.
>>>>
>>>> I'll look into tracing the fs paths to see if I can narrow down what's
>>>> causing it. Will also try a newer kernel, I am currently testing on
>>>> 5.19-rc4.
>>>
>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
>>> instead of normal CBs, are triggering expedited stalls during the boot
>>> process:
>>>
>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
>>>
>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
>>> but maybe something hangs and causes that side-effect.
>>>
>>> initcall_debug did not help, as it seems initcalls all work fine, and
>>> then 8 seconds after the boot, it starts slowing down a lot, followed
>>> by the RCU stall messages. As a next step I'll enable ftrace during
>>> the boot to see if I can get more insight. But I believe, its not the
>>> FS layer, the FS layer just triggers lazy CBs, but there is something
>>> wrong with the core lazy-RCU work itself.
>>>
>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
>>> recent kernels and debug.
>>
>> More digging, thanks to trace_event= boot option , I find that the
>> boot process does have some synchronous waits, and though these are
>> "non-lazy", for some reason the lazy CBs that were previously queued
>> are making them wait for the *full* lazy duration. Which points to a
>> likely bug in the lazy RCU logic. These synchronous CBs should never
>> be waiting like the lazy ones:
>>
>> [   17.715904]  => trace_dump_stack
>> [   17.715904]  => __wait_rcu_gp
>> [   17.715904]  => synchronize_rcu
>> [   17.715904]  => selinux_netcache_avc_callback
>> [   17.715904]  => avc_ss_reset
>> [   17.715904]  => sel_write_enforce
>> [   17.715904]  => vfs_write
>> [   17.715904]  => ksys_write
>> [   17.715904]  => do_syscall_64
>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
>>
>> I'm tired so I'll resume the debug later.
> 
> At times like this, I often pull the suspect code into userspace and
> run it through its paces.  In this case, a bunch of call_rcu_lazy()
> invocations into an empty bypass list, followed by a call_rcu()
> invocation, then a check to make sure that the bypass list is no longer
> lazy.

Thanks a lot for this great debug idea, I will look into it.

Thanks,

 - Joel
