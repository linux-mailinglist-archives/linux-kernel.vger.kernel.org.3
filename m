Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2978D5A9CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiIAQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiIAQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:11:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B052FF4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:11:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b9so13623719qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=//crJhFC2MP6k+HqBJNKrFTDqDx3Mg1jCPzBiBq8JGQ=;
        b=DK8L+9n+n2ETtpIVa2bW5wX4fRT1GikHoburKedmagzhhyxwVaZ4UTYmAk9NhZbNHZ
         eMSwrLbJhT3hR/JaUA3aihvQedzouBDxTUdXpaqQvmdFhM1SLxXQA5AVsejxo2VmwEx9
         n2PI9JHmr49EANJrGwFswqazuWU75iWJapKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=//crJhFC2MP6k+HqBJNKrFTDqDx3Mg1jCPzBiBq8JGQ=;
        b=0b8vBqIWH+sHPSe+Pohe997tqvRLKnPoQBHYcEaC1aaeQg+QYUaZSWx1h/TKWLdQk5
         hIWQdTqbKjC1nrNYG/qAVu4jNQX7W0x41VwDZ87A2vFlmmWYXIJlCx//D2WTJsll4IKt
         uedpmVX7qvQP9QpDvUB9qa1NX1rnwqgWvruEEtLbJ5vq6hrbHJ2uWAwzbFgzupbghLTy
         vLZrW8vQP/p1ZpYdK9DpxhzWIRaYPTQ/0sj2WrFHm+ENe/2BbX9G434Qunfw6XaZF96w
         GJdUV3wGaHoORCucV6w0OeZcI69iQ5jbJ+aRYWmbzk4M8xCANPo7BxsberdGIjWAII89
         +kpg==
X-Gm-Message-State: ACgBeo3sYqa20V73WyTT08uHcKhMm6rOZ4tnCkVbKnv3yjJspnHRrrXc
        3s0zKrwbFMWdd83fwSw3Va9JEQ==
X-Google-Smtp-Source: AA6agR5uFGoSCi5T5ZGXDJDTTEG/opf7vE6mOpV4fQ7WbI4io+T3C6z3skjl/kN8pa8uHldxMPaM5w==
X-Received: by 2002:a37:9a16:0:b0:6ba:f09a:a61b with SMTP id c22-20020a379a16000000b006baf09aa61bmr20312266qke.486.1662048671547;
        Thu, 01 Sep 2022 09:11:11 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006b8f4ade2c9sm12570413qkb.19.2022.09.01.09.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:11:11 -0700 (PDT)
Message-ID: <1a25723e-a7ad-a9f6-bd9f-278b1248d822@joelfernandes.org>
Date:   Thu, 1 Sep 2022 12:11:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636> <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636> <20220901144158.GV6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901153034.GA106955@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220901153034.GA106955@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 11:30 AM, Frederic Weisbecker wrote:
> So I'm not entirely comfortable but I'm going to review the current patchset
> anyway and once it lands -rcu I'll try to hack a quick !NOCB implementation
> for measurements purpose.

Sounds good, arguable the core implementation to use bypass list is not too
complex or anything, and maybe you can generalize the bypass list for !NONCB as
well and re-use most of the code. You will need a per-cpu list anyway (bypass or
some other) to queue the CBs. In v1, we had a separate per-cpu list.

Thanks for offering to review the patches, you guys really motivate me to work
on it (I am currently on leave but still working on it). I'll be looking forward
to getting that out soon. Yesterday was good progress.

 - Joel
