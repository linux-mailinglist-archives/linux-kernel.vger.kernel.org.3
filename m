Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164B24F931E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiDHKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiDHKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA7B31C41F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649414207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F28wkZSv5A1NMfrHvZh1ec20dPy/XDhI8frJaxMcDE4=;
        b=Zv2Fz3wFV3Igaq36M9mEk6vA3F/iy6GTVbSQBil+Y/Upx+0ZgfD6a6RCGcEHuo3Y4a46Og
        6qX0AKXqTtFAS0D2TbQfyCJoGzsOxEFX6+HJkf/Yehvc8M2um17qbZem8rmuSPXYihe+/b
        KADWVlomVdTtom/rii8e6s1UVpKK9OU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-0rryqG5-P5CaMvelP4YtAw-1; Fri, 08 Apr 2022 06:36:43 -0400
X-MC-Unique: 0rryqG5-P5CaMvelP4YtAw-1
Received: by mail-qt1-f197.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso7440195qtj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F28wkZSv5A1NMfrHvZh1ec20dPy/XDhI8frJaxMcDE4=;
        b=nBELeUBqFOH53WNa12S4pi5cTn/b1Nlrf36+v+mUhjsOmRTpFtIae70aUmi3Jt3qGy
         frT833PKKapGXVnQZ34BLUmuB3mKqp+KVPYXLTOEFN7bgwbJ+FO7mORGOvBHY1JHZjqP
         DNBXDR/GlCXEM1/h9TF6bFKrneEQVH0pDSjQFWrEfCe9JzdxcX2vNTvLHV012R1TczlN
         6KXIEs/w7eUtp6GJWiqgl0B2//DvVt1h/K+9uwTbwkTgYhbNKJUqqOcYg0MjuURtyCGP
         bfApTqtDpVX1BfG9ru8Am9I1u3s9j580F6BS7yDDIRmqURj3Yzel2bdI1PvHXkjcae1T
         d6PA==
X-Gm-Message-State: AOAM531dYFodhCqzf4RnNs21ALZ+s1UQLUgbXPZg8Yh3AD2UNjwCDCfs
        J2ZvbeeH7/fwAh3alTiE/MSGB/kRh1VHe9nec1ou/RP2WlJVkOqFG+502tM/qXooIVB9BTgN1DR
        CjTPdhMuqME6umSGRBtJlenXD
X-Received: by 2002:ac8:130c:0:b0:2e2:3919:d62f with SMTP id e12-20020ac8130c000000b002e23919d62fmr15511844qtj.206.1649414203172;
        Fri, 08 Apr 2022 03:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymKdCMVYacKzzkoZ3u3HDIG1VcbL28nI/RY3Mv66Wp0IoR8Cy7tXMDu7Wqj6ip9Sf4VgNQuw==
X-Received: by 2002:ac8:130c:0:b0:2e2:3919:d62f with SMTP id e12-20020ac8130c000000b002e23919d62fmr15511826qtj.206.1649414202954;
        Fri, 08 Apr 2022 03:36:42 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm13187004qki.28.2022.04.08.03.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 03:36:42 -0700 (PDT)
Message-ID: <2293c547-3878-435a-ec1c-854c3181ad14@redhat.com>
Date:   Fri, 8 Apr 2022 06:36:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx> <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
 <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
 <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
 <YlAHfU7VEI0wYAb/@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YlAHfU7VEI0wYAb/@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 05:59, Michal Hocko wrote:
> On Fri 08-04-22 05:40:09, Nico Pache wrote:
>>
>>
>> On 4/8/22 05:36, Michal Hocko wrote:
>>> On Fri 08-04-22 04:52:33, Nico Pache wrote:
>>> [...]
>>>> In a heavily contended CPU with high memory pressure the delay may also
>>>> lead to other processes unnecessarily OOMing.
>>>
>>> Let me just comment on this part because there is likely a confusion
>>> inlved. Delaying the oom_reaper _cannot_ lead to additional OOM killing
>>> because the the oom killing is throttled by existence of a preexisting
>>> OOM victim. In other words as long as there is an alive victim no
>>> further victims are not selected and the oom killer backs off. The
>>> oom_repaer will hide the alive oom victim after it is processed.
>>> The longer the delay will be the longer an oom victim can block a
>>> further progress but it cannot really cause unnecessary OOMing.
>> Is it not the case that if we delay an OOM, the amount of available memory stays
>> limited and other processes that are allocating memory can become OOM candidates?
> 
> No. Have a look at oom_evaluate_task (tsk_is_oom_victim check).
Ok I see.

Doesnt the delay then allow the system to run into the following case more easily?:
pr_warn("Out of memory and no killable processes...\n");
panic("System is deadlocked on memory\n");

If the system cant select another OOM candidate, the oom_reaper is delayed, and
the exit is blocked, then we panic.

-- Nico

