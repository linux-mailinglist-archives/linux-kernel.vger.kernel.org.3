Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2F5A6C96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiH3SxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH3SxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:53:11 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2364A811
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:53:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id jy14so3635304qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HBsYGhZMRgIdA5lBnnjoLpc9bLfQZYRKl7YPPGK3ddA=;
        b=XYz5d/hd5jOPgb3I7CzUIB+zoQ9HjLvebPDsAUKgtWNG+0Dp3jZeCPtQr3mwx+67c+
         3ePVYelD2VtZrK98r6o6PdnhW6jvYF5WTnhxi08YiRfT65osnsAniOUTZW6VaR9xkKor
         CcLXoO8Sa5ctsad9BVmOHpb+Rgwq5GpAY64+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HBsYGhZMRgIdA5lBnnjoLpc9bLfQZYRKl7YPPGK3ddA=;
        b=0Nz5kVgq6+dSlPTY+X900l55J8SSs5GrD6ThcVMxjYMjWtW/Toy0gWOBnzQiK/kHuz
         QQP18tA0CuX+nj/StHwBpZ3D0rTVGE0iSnBBz2v6fAhEureB958aHM0FrZmME23KUBlo
         rchuZqo2FUOTdZWYaz1rCKa+h6/qMCcqcPQM2rGwXBktLYL1P/FFggfxRz00UnjUTpcJ
         1p//KlRLyjHq+AZGS1n/s+UmTsbTID25UmPigS9I7+iJAtKFbWSYECJxkm0XVX+xYcA8
         Apz/PhQAC6U7jEvr/tGZc7ZqtsSxgGdooyIWkFkzvv2oGu+MyKJim7XL5ADtZ/maaka0
         X07w==
X-Gm-Message-State: ACgBeo2Gyr4fsBSpa3wqHs2JI9oMr4bELQZ1ybAZ0Y1kXo7ymDacg1i9
        1jVnoeYtJc5REeC3w7dEjiVUnrRMSLy4rQ==
X-Google-Smtp-Source: AA6agR6gKiPDwJ52i4lQAo1oeeGkp55e0BQYa6XLPS5fQf0KRaP7XvXuESWn5LFdNsUHtNCNvjoeAg==
X-Received: by 2002:ad4:5def:0:b0:476:c97f:e28d with SMTP id jn15-20020ad45def000000b00476c97fe28dmr16915963qvb.42.1661885589438;
        Tue, 30 Aug 2022 11:53:09 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bj33-20020a05620a192100b006b9c6d590fasm8549342qkb.61.2022.08.30.11.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:53:09 -0700 (PDT)
Message-ID: <7c164cfb-534d-e5eb-f326-a37de9268e6e@joelfernandes.org>
Date:   Tue, 30 Aug 2022 14:53:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <Yw4+g/0yEf7fpHrh@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2022 12:44 PM, Uladzislau Rezki wrote:
> Hello, Frederic.
> 
>>
>> Although who knows, may be some periodic file operation while idle are specific
>> to Android. I'll try to trace lazy callbacks while idle and the number of grace
>> periods associated.
>>
>>
> Everything related to lazy call-backs is about not waking "nocb"
> kthreads in order to offload one or i should say few callbacks
> because it is more or less useless. Currently if incoming callback
> is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> to offload.
> 
> In "light" loaded test cases, especially where a power drain is a key
> thing, such light load may lead to some kind of "noise" produced by the
> RCU core, i.e. kicking idle CPUs, thus wasting power. On our ARM devices
> it is not painful, but there is a small power gain and it is visible.
> For other systems, like Joel measures for Intel SoC it is more visible,
> because of a power cost getting in/out of isle states.

Indeed! And Intel (Rushikesh) reminded me today that it has become more
important than before to not disturb idle CPUs, because more and more pieces of
hardware are moving into SoCs. So if the whole SoC cannot go into deeper sleep
state (package C-state) because of the CPU getting disturbed, then that's lesser
power savings than say in the not-so-recent past. Rushikesh could shed more
light on that fact.

Thanks,

 - Joel
