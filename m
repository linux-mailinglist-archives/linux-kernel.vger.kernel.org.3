Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F965992A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiHSBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHSBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:38:52 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B767CBF;
        Thu, 18 Aug 2022 18:38:51 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3D7A33F119;
        Fri, 19 Aug 2022 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660873129;
        bh=f2530xu/ZwghAIZ7eHrD4nhXaPxs0D+iScywNNE7e08=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
         In-Reply-To:Content-Type;
        b=c+gYZw5QfyehDzfsz0UhNSYBu0bQWeDcRdidakaJlBub6HaPIU53U/7TYIIe5JO5e
         3+Rg8vsY7VSMDX76Qa2YdZqqoGl++ycyoti1oUjI7mUneGYed+MOAaD4UE3gdFDHmz
         bJCLGVhOTKiPSx1PnEWOirm8eTy+qP4omG3FuMUTYakPKCP1AGp9qgRG2WUDQRXWDy
         CdaobmW2iS0IsaFIRrlq5wMcKEyfv4hMhMGDye3t9J4CT5YQk5SIFtHyB4IdZXB2wd
         +JnYoXiJFBZem4qOGWdw07GoR1ulnX4DWHCoIFwKvOiTDbJj8OdFcVZpQegMV1X3sa
         +V3RtuMCeStXw==
Message-ID: <b107a46a-7f53-0b35-71f4-9a909643c4c1@canonical.com>
Date:   Thu, 18 Aug 2022 21:38:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        bigeasy@linutronix.de, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org,
        Marcelo Cerri <marcelo.cerri@canonical.com>
References: <9e6a7216-9cb9-cba4-f150-1a0eaf56353c@canonical.com>
 <Yv6hl3D2TRL6jzrL@worktop.programming.kicks-ass.net>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [RFC} Commit 8a99b6833c88 Moves Important Real-time Settings To
 DebugFS
In-Reply-To: <Yv6hl3D2TRL6jzrL@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/22 16:31, Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 03:53:28PM -0400, Joseph Salisbury wrote:
>> Hello,
>>
>> Some Ubuntu users are using the tuned package with a 5.15.x based real-time
>> kernel.  Tuned adjusts various sysctl options based on a specified profile.
>> This userspace package has stopped working > 5.13 due to the following
>> commit:
>>
>> 8a99b6833c88 "(sched: Move SCHED_DEBUG sysctl to debugfs)"
>>
>> This commit moved some important real-time sysctl knobs to debugfs in
>> 5.13-rc1.  It also appears some of the sysctl options were not moved,
>> sched_min_granularity_ns, for example.
>>
>> I was hoping to get some feedback on how to approach this.  Would upstream
>> real-time consider accepting a patch to the 5.15 real-time patch set that
>> reverts this commit?  Or a new patch that adds the sysctl settings back?
>> Any other ideas or feedback would be appreciated!
> None of those knobs were available when SCHED_DEBUG=n, so relying on
> them is your error to begin with.
We have had SCHED_DEBUG=y while this kernel is in beta, so you are 
correct.  I need to investigate a different approach.
>
> Secondly, real-time? Which if those values affects anything in
> SCHED_FIFO/RR/DEADLINE ?
I am in the process of understanding how tuned[0] works. Many users have 
reported success using tuned.  One use case for tuned is to assign 
isolated cores to real-time processes and then move managed IRQs out of 
these isolated cores.  This can be done easily with tuned (I will 
research if there are other options to suggest). However, tuned is 
trying to set the affected values when enabling a profile, such as the 
real-time profile (Tuned offers many profiles based on a workload type).

I will investigate further to answer your point of what in 
SCHED_FIFO/RR/DEADLINE those values affect.  It could be those values 
are not needed at all. The dependency on them might be left over from 
some need that no longer exists.

Thank you again for the feedback!

[0] https://tuned-project.org/

