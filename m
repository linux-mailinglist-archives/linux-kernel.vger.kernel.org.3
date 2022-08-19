Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900D59A31C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiHSRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350292AbiHSRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:12:04 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84610BE06
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:31:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j1so3715282qvv.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Xo7su420EVzXp2bxcK091URgsQkLz9vza9IhSFlCxo4=;
        b=hEcl5zBnjJmx73nB7F8amiQFJTnhEGllskdC4rCt8R+FFI8xMct9GPDRLodND29bC7
         lsf0KTa61d8GjQx4nc296wyB0KXIHSwVJ9IpIF3niqo18lrGNzqZRhXnyz4a9vXHcY4I
         f4ahihM+PNwNx1r9ChuJvhsOtEyNcBc3wQcPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xo7su420EVzXp2bxcK091URgsQkLz9vza9IhSFlCxo4=;
        b=oQkWH1GOL3qDG6wFIXztsTjkR8dCIwXPypY+NxD7QGqVxiB/EWtZ21CZqD65Re4Zsc
         Kcne9xnzprjRn+lXWdhwBv89ENZzCd8JXZtm4Lv6bmg1e/e0VYxVubpBXhlrE5x3ymlF
         saqHwWTyM+upNksWEHCRyCZr4nxFJi8s/frYtfRZKbXhbbVZWyxvmyS+pgdMRafQoy/+
         hV0vSyMpr7avb9hby1Yi85BBC+VtBhRz+TK2hbcHaKlNb6U+/a5c6b+ZTlVCZetoMbM9
         nl0kJsqSQOXP9vvquXGQRjshhZjo0+V60eq6Hltdoee8KbaVcA4Rom8xxiJdXxtDd6FE
         r0AQ==
X-Gm-Message-State: ACgBeo3+PmjTbyuc+eQMl3eCfdSRBdNLhSwI00soV9Xtq9mzFYs/awX1
        zuzDM8ABNRWneFLA6k8mFNUdhg==
X-Google-Smtp-Source: AA6agR5CS0PUH2Lp7LFafeq3LRxR5CGf61lfkIbi9nNq2deEXL98Ih0Z5VGaMkq9LyxQSLfegqpCiw==
X-Received: by 2002:a05:6214:5287:b0:476:7938:5b76 with SMTP id kj7-20020a056214528700b0047679385b76mr7114606qvb.131.1660926686112;
        Fri, 19 Aug 2022 09:31:26 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u9-20020a05622a198900b003430cbb0006sm3770646qtc.1.2022.08.19.09.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 09:31:25 -0700 (PDT)
Message-ID: <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
Date:   Fri, 19 Aug 2022 12:30:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
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
 <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
In-Reply-To: <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
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



On 8/18/2022 10:45 PM, Joel Fernandes wrote:
> 
> 
> On 8/18/2022 10:35 PM, Paul E. McKenney wrote:
>> On Thu, Aug 18, 2022 at 09:21:56PM -0400, Joel Fernandes wrote:
>>> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>
>>>> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>>
>>>>> [Sorry, adding back the CC list]
>>>>>
>>>>> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
>>>>> <joel@joelfernandes.org> wrote:
>>>>>>
>>>>>> This is required to prevent callbacks triggering RCU machinery too
>>>>>> quickly and too often, which adds more power to the system.
>>>>>>
>>>>>> When testing, we found that these paths were invoked often when the
>>>>>> system is not doing anything (screen is ON but otherwise idle).
>>>>>
>>>>> Unfortunately, I am seeing a slow down in ChromeOS boot performance
>>>>> after applying this particular patch. It is the first time I could
>>>>> test ChromeOS boot times with the series since it was hard to find a
>>>>> ChromeOS device that runs the upstream kernel.
>>>>>
>>>>> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
>>>>> patch? I wonder if the issue is with wake up interaction with the nocb
>>>>> GP threads.
>>>>>
>>>>> We ought to disable lazy RCU during boot since it would have little
>>>>> benefit anyway. But I am also concerned about some deeper problem I
>>>>> did not catch before.
>>>>>
>>>>> I'll look into tracing the fs paths to see if I can narrow down what's
>>>>> causing it. Will also try a newer kernel, I am currently testing on
>>>>> 5.19-rc4.
>>>>
>>>> I got somewhere with this. It looks like queuing CBs as lazy CBs
>>>> instead of normal CBs, are triggering expedited stalls during the boot
>>>> process:
>>>>
>>>>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
>>>> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
>>>>
>>>> No idea how/why lazy RCU CBs would be related to expedited GP issues,
>>>> but maybe something hangs and causes that side-effect.
>>>>
>>>> initcall_debug did not help, as it seems initcalls all work fine, and
>>>> then 8 seconds after the boot, it starts slowing down a lot, followed
>>>> by the RCU stall messages. As a next step I'll enable ftrace during
>>>> the boot to see if I can get more insight. But I believe, its not the
>>>> FS layer, the FS layer just triggers lazy CBs, but there is something
>>>> wrong with the core lazy-RCU work itself.
>>>>
>>>> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
>>>> recent kernels and debug.
>>>
>>> More digging, thanks to trace_event= boot option , I find that the
>>> boot process does have some synchronous waits, and though these are
>>> "non-lazy", for some reason the lazy CBs that were previously queued
>>> are making them wait for the *full* lazy duration. Which points to a
>>> likely bug in the lazy RCU logic. These synchronous CBs should never
>>> be waiting like the lazy ones:
>>>
>>> [   17.715904]  => trace_dump_stack
>>> [   17.715904]  => __wait_rcu_gp
>>> [   17.715904]  => synchronize_rcu
>>> [   17.715904]  => selinux_netcache_avc_callback
>>> [   17.715904]  => avc_ss_reset
>>> [   17.715904]  => sel_write_enforce
>>> [   17.715904]  => vfs_write
>>> [   17.715904]  => ksys_write
>>> [   17.715904]  => do_syscall_64
>>> [   17.715904]  => entry_SYSCALL_64_after_hwframe
>>>
>>> I'm tired so I'll resume the debug later.
>>
>> At times like this, I often pull the suspect code into userspace and
>> run it through its paces.  In this case, a bunch of call_rcu_lazy()
>> invocations into an empty bypass list, followed by a call_rcu()
>> invocation, then a check to make sure that the bypass list is no longer
>> lazy.
> 
> Thanks a lot for this great debug idea, I will look into it.

It seems to be a subtle issue when a large number of callbacks are
queued trigging the lock-contention code, which happens at boot. It
appears the non-lazy ones and lazy ones collide, so you have the lazy
timer which wins, and then the regular bypass lock-contention timer is
not allowed to do its thing. Due to this, the rcuog thread wakes up much
later than a jiffie.

Things are much better with the following change. However, this brings
me to a question about lock-contention based or any deferring and boot time.

If you have a path like selinux doing a synchronize_rcu(), shouldn't we
skip the jiffie waiting for the bypass timer? Otherwise things
synchronously waiting will slow down more than usual. Maybe bypassing
should not be done for any case until boot up is done. I'm curious to
see if that improves boot time.

@@ -580,7 +585,11 @@ static void __call_rcu_nocb_wake(struct rcu_data
*rdp, bool was_alldone,
        len = rcu_segcblist_n_cbs(&rdp->cblist);
        bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
        lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
-       if (was_alldone) {
+
+       // If we are in lazy-mode, we still need to do a wake up even if
+       // all CBs were previously done. Otherwise the GP thread will
+       // wait for the full lazy duration.
+       if (was_alldone || (READ_ONCE(rdp->nocb_defer_wakeup) ==
RCU_NOCB_WAKE_LAZY)) {
                rdp->qlen_last_fqs_check = len;
                // Only lazy CBs in bypass list
                if (lazy_len && bypass_len == lazy_len) {

---

Thanks,

 - Joel


