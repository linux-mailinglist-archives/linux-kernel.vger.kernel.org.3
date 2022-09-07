Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BEC5AFA0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIGCn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIGCnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:43:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E097B28F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:43:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c20so9483011qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HV15brfmijT3wQpdJQzUr20Idn6RQgfVceZTRDNZ2RA=;
        b=xSduQWMCYeluZayNSc/ZHmsirDlb9V9NS3hqmtpoPmuCjOI6hsnymMlm4dMQTQDGPD
         J4T0+VqM2skudfqpfnDEGffA6LwWX9ZtfksqaBf8mewmSP1nOEi35pcZO/f3PgmlKhHl
         hw2/IvrXMUi65QTYz6e377fymvUm0PBmBkNQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HV15brfmijT3wQpdJQzUr20Idn6RQgfVceZTRDNZ2RA=;
        b=FHp577SCLQvBpirtENWtTN687ytqFmVOz83t/YaaBz3/+rzADpRY7P8lKyUFTkVL8l
         7x/9NOPkmcfM9AiUFsbV9cJyI1XefCZqBQOaG2HBBSpJRTlUe9JUuDpyhPella5gVTD1
         AY6ha9++7G24/0vMSksgeSYKb0Tez66MASdOvIpcddknYDvN9h8Mf0oVfzoBwIu38qe/
         Fpy/3ppAL004db7PQT19X26/WQyXFW2b9cd4QZwuS9FGmwBcYhlK0e6PJleGR2+rZIvF
         YhRc+OtDxminFJFcNq0yObH5F6FpijtqS37LgXdwEhaT9KkLjCsqCVm4zbo2o94UM5QN
         pkgA==
X-Gm-Message-State: ACgBeo2IMCJjbmfzJBgglC8ufrQZ7UpL5ndE/MBGt6RzPmq/5w3ZSEVB
        59ogdKPC0z4Bs2AAWALOP4je/Q==
X-Google-Smtp-Source: AA6agR4g8U9tCuV/rPUVPEgqT2qIUDioJHoiieKqfwpb7oxjTNDvFQ9Y6HTa+FzF7YlFKwIwyKTxpQ==
X-Received: by 2002:ac8:5a0d:0:b0:344:de4f:b187 with SMTP id n13-20020ac85a0d000000b00344de4fb187mr1431577qta.136.1662518604011;
        Tue, 06 Sep 2022 19:43:24 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bb9-20020a05622a1b0900b00354e5b8bba3sm6629847qtb.29.2022.09.06.19.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:43:23 -0700 (PDT)
Message-ID: <a99c817f-4b0f-ad50-db38-8a55029d6ecc@joelfernandes.org>
Date:   Tue, 6 Sep 2022 22:43:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist
 happens
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <Yxa5WVwwcDmCL9Dw@google.com> <20220906094852.GA174244@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906094852.GA174244@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 5:48 AM, Frederic Weisbecker wrote:
>>  		}
>> -		rcu_nocb_unlock_irqrestore(rdp, flags);
>> +
>> +		// The flush succeeded and we moved CBs into the ->cblist.
>> +		// However, the bypass timer might still be running. Wakeup the
> That part of the comment mentioning the bypass timer looks strange...
> 
> 
>> +		// GP thread by calling a helper with was_all_done set so that
>> +		// wake up happens (needed if main CB list was empty before).
> How about:
> 
>                 // The flush succeeded and we moved CBs into the regular list.
> 		// Don't wait for the wake up timer as it may be too far ahead.
> 		// Wake up now GP thread instead if the cblist was empty
> 
> Thanks.
> 
> Other than that the patch looks good, thanks!
> 

I updated it accordingly and will send it for next revision, thank you!

 - Joel
