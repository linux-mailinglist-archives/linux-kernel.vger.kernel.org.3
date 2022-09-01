Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E335A9C95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiIAQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiIAQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB290195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:08:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so13642752qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fbLPgUKDeEmpi5XNyJeAxZHlZZP3Z6lE/BSo3Y5wwyI=;
        b=lWVe/bC+Si53mXtJ+1IDEDdGyGm3oRk86702du2JvUscb7XiaS7mWPQMaTMn7Pfc7s
         LIlnolzJYkptY9UJvY2auBeUQINWeq9mnqFDF5MlGRhF/DTTZv8Cp2Eaw+VrCjpQrXYX
         1bS9uaKIXTDMSzc5zYhoSKTMJIOQeC9jm863Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fbLPgUKDeEmpi5XNyJeAxZHlZZP3Z6lE/BSo3Y5wwyI=;
        b=RVqEzZBEDvghR7vsyHilXWTu90wE/fNnsME9SfbYmO4RXF7bLsIR8HXBjnHYpxssUW
         j/pLl+F9y3EbsAXIl8uiVcq8V9tHm8fuB/VFn1M7HEM9PIyGPfotZd37W7/SvWuoD4Gw
         ++3pBENhoNCDhZBm701j4lfZXj2EjgIDYH5Wc9i8yrCGcE4u/law/CnliyA+CctkqSe6
         jeDSxYwLthlk8q6BjpUI2i6mM1egcU5sLvFmvxoP412hoIaeTnL4mSJ/yKP5QPUEfO/J
         YC/4XsoPjXPk4JKa59rwuNYlJBgYrOwsH92yd4tbaNBU6rpWMYPGoa66FA0dpFL6XHfQ
         9sFA==
X-Gm-Message-State: ACgBeo0MrYdXWcS15/VKkhGPgvQSZlnWbd+bpg2KfUCaNup1dbvsz//G
        DIV3aF7NkhNkmttjGeh94AlDcg==
X-Google-Smtp-Source: AA6agR5OPsi7Ca+K/UzjkYkdBBG/PAq+Osq2CCbPnnpQEyFSe99xEPcD+vKp81LxZCGQqL6K43h9OQ==
X-Received: by 2002:a37:b702:0:b0:6b8:d9ec:3196 with SMTP id h2-20020a37b702000000b006b8d9ec3196mr19729545qkf.660.1662048480173;
        Thu, 01 Sep 2022 09:08:00 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006b97151d2b3sm12547778qkp.67.2022.09.01.09.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:07:59 -0700 (PDT)
Message-ID: <0e8687de-bf45-5de6-c2f1-be6084991921@joelfernandes.org>
Date:   Thu, 1 Sep 2022 12:07:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
 <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220831152658.GA89704@lothringen>
 <20220901143907.GU6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901145819.GB105556@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220901145819.GB105556@lothringen>
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



On 9/1/2022 10:58 AM, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 07:39:07AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 31, 2022 at 05:26:58PM +0200, Frederic Weisbecker wrote:
>>> On Tue, Aug 30, 2022 at 09:46:34AM -0700, Paul E. McKenney wrote:
>>>>> Although who knows, may be some periodic file operation while idle are specific
>>>>> to Android. I'll try to trace lazy callbacks while idle and the number of grace
>>>>> periods associated.
>>>>
>>>> Sounds like a good start.
>>>>
>>>> And yes, we don't need to show that the whole !NOCB world needs this,
>>>> just some significant portion of it.  But we do need some decent evidence.
>>>> After all, it is all too easy to do a whole lot of work and find that
>>>> the expected benefits fail to materialize.
>>>
>>> So here is some quick test. I made a patch that replaces Joel's 1st patch
>>> with an implementation of call_rcu_lazy() that queues lazy callbacks
>>> through the regular call_rcu() way but it counts them in a lazy_count.
>>>
>>> Upon idle entry it reports whether the tick is retained solely by lazy
>>> callbacks or not.
>>>
>>> I get periodic and frequent results on my idle test box, something must be
>>> opening/closing some file periodically perhaps.
>>>
>>> Anyway the thing can be tested with this branch:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>> 	rcu/lazy-trace
>>>
>>> Excerpt:
>>>
>>>           <idle>-0       [007] d..1.   414.226966: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.228271: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.232269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.236269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>
>> Just to make sure that I understand, at this point, there is only the
>> one lazy callback (and no non-lazy callbacks) on this CPU, and that
>> CPU is therefore keeping the tick on only for the benefit of that one
>> lazy callback.  And for the above four traces, this is likely the same
>> lazy callback.
>>
>> Did I get it right, or is there something else going on?
> 
> Exactly that!

Interesting!

 - Joel

