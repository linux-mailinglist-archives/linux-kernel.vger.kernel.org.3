Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9571D58F65F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiHKDWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiHKDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:22:16 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E75FAFE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:22:15 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h8so12472443qvs.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yQeSFuwRNx/XUOvkvBrIVANL8bg0Wi76GWQ4ipQxxE4=;
        b=H85S/aViirD2EdGz/vhs1/Z6OHXJpkhKChMSll8sDvGgIjShMn5WADjt8BwETG5NKP
         ax3nwDkwTLkr7y4ij9PhjWC6b/LIyG7HF06rKt4XF1+MfKzmdNLoN1J6X+Npe++Cynj3
         j9MLYU9U33oNHb2Td0DzWDejz1EEVsUyexrD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yQeSFuwRNx/XUOvkvBrIVANL8bg0Wi76GWQ4ipQxxE4=;
        b=6FG5XrDHmDM6Pfvl+ERTQpyNTv5mCUNb3maobNUerav/g8HFSDvSP2Mp1x39plLHYt
         /8RB2Z/qFTbQzoClmGUp5iiiT7JyG72ymfi/7lTANUWIqg2FntT9K8CYqoBsgWk5133H
         cYn9ExWfpmkC36Y9xh0DmhQ2nQ77JXoPuNlltFoguVgQ0ewEUXG54Hnz5i0Jo/8QbX10
         LqEmwqasxdad2G7ekSNju4bzw1xG++msius0PcVn5TnuzY9lY0a3itindgzWDa9QrDxo
         wBqqqnwaaHna4sGNcQNBmSRE6bZhE/PKRyvVnSZCsDXGYxxBidlqogwOekJvhPsnS2G2
         HhRQ==
X-Gm-Message-State: ACgBeo20cxhI7xm82RF6gS9UBilRSjrAiXFBcyJvr0s3yQCJHaci4pnW
        Oez29KyBt4hOcIx4vqNHHKNuYQ==
X-Google-Smtp-Source: AA6agR4oXGE4epLMRDzhckn5cjWFv8x0xqLQZK+6tHSYzUYfAEUqJtEcgAQpUNW6SJfyWEnTHFY6Eg==
X-Received: by 2002:a0c:a95d:0:b0:474:6f43:7ed8 with SMTP id z29-20020a0ca95d000000b004746f437ed8mr26305162qva.31.1660188134658;
        Wed, 10 Aug 2022 20:22:14 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a268200b006b58d8f6181sm1343786qkp.72.2022.08.10.20.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 20:22:14 -0700 (PDT)
Message-ID: <07976e09-214d-0d1b-6803-23754a9f3d8a@joelfernandes.org>
Date:   Wed, 10 Aug 2022 23:22:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
 <87663566-ed67-fee8-4598-13591f2f072b@joelfernandes.org>
 <20220811025152.GW2125313@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220811025152.GW2125313@paulmck-ThinkPad-P17-Gen-1>
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



On 8/10/2022 10:51 PM, Paul E. McKenney wrote:
> On Wed, Aug 10, 2022 at 10:31:56PM -0400, Joel Fernandes wrote:
>>
>>
>> On 8/10/2022 10:23 PM, Joel Fernandes wrote:
>>>
>>>
>>> On 8/8/2022 11:45 PM, Joel Fernandes (Google) wrote:
>>>> Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
>>>>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
>>>>
>>>> I just started working on this again while I have some time during paternity
>>>> leave ;-) So I thought I'll just send it out again. No other changes other
>>>> than that 1 debug patch I added on the top.
>>>>
>>>> Next I am going to go refine the power results as mentioned in Paul's comments
>>>> on the last cover letter.
>>>
>>> Side note: Here is another big selling point for call_rcu_lazy().
>>> Instead of _lazy(), if you just increased jiffies_till_first_fqs, and
>>> slowed *all* call_rcu() down to achieve the same effect, that would
>>> affect percpu refcounters switching to atomic-mode, for example.
>>>
>>> They switch to atomic mode by calling __percpu_ref_switch_mode() which
>>> is called by percpu_ref_switch_to_atomic_sync().>
>>> This will slow this call down for the full lazy duration which will slow
>>> down suspend in blk_pre_runtime_suspend().
>>
>> Correction while I am going on the record (got to be careful these
>> days). It *might* slow down RCU for the full lazy duration, unless of
>> course a fly-by rescue call_rcu() comes in.
> 
> Just unload a module, which if I remember correctly invokes rcu_barrier().
> Lots of rescue callbacks.  ;-)

Haha. Yes I suppose the per-cpu atomic switch paths can also invoke
rcu_barrier() but I suspect somebody might complain about IPIs :-P

Thanks,

 - Joel
