Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1DD5B058B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIGNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIGNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:44:06 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17216A48D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:44:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i15so2014616qvp.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PdMQhpcTbD1G+Urg/7Rf9Goe0ki5ggzyPYxY1wYW3Co=;
        b=O6pdoQyoF4NfKAYob1VkudqvdEfOH2WO42ooEQvg8JNO4xxlHSDW4HRR767yOfblnF
         nbECkVWAh4qGQMUo5WftGpkmv00zeCQq72tBHAMp/8BGuHKrn3VZNxTJ9ZiDUjtRmKlg
         QsIASSEj6zzwVhX46eHBoiW5AQ5DdxT1Lmkuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PdMQhpcTbD1G+Urg/7Rf9Goe0ki5ggzyPYxY1wYW3Co=;
        b=XaHKEVg6UXqdLdI2JLjEKkAUuIx44QotXE3u5NtyFAeCRreQzt/Wjlvpl1rdawVGkO
         I6xLbv7jhjeIxE3OQoBWxe79auJct6PQvSBDFl2u+hFKnbYzx1PP0qkAyEpYts/CIfcv
         uMUTIXGiq2pEfUFrtEZ8ExKsugLHDdsESZIvNH2NDIrgcvZSFb0PCTRmSh6fr21Ej9gx
         9FgiHqrbuw1UA80BNuJCPcHsjAb47a2sS+0cSlJjRRmo51yVfAJ1nlkbgc/AAe1Fc7jL
         yzAM1XmVSwY23UFUi7jecyzLq86Cct+tvqm1bnsZRLE6AMsBnp3lScbTQleoiSfl8m3j
         fd6Q==
X-Gm-Message-State: ACgBeo2u4V7G6dpHFQKzt5CF1mgWLUPerF0LYpeuNdaM0XMmaGwYv1KV
        Erj5rvaBAgB8149cbG9e6lEurQ==
X-Google-Smtp-Source: AA6agR7HYzJTT/pCpZHOrquRVb9EEjTAcWITRqoEI2oz5RpSnu/JcII8O70y9NblInhRGKPzSNt6+Q==
X-Received: by 2002:a05:6214:550a:b0:47c:ba64:ec74 with SMTP id mb10-20020a056214550a00b0047cba64ec74mr3113716qvb.117.1662558243397;
        Wed, 07 Sep 2022 06:44:03 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id j7-20020a05620a410700b006bc68cfcdf7sm14981187qko.13.2022.09.07.06.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 06:44:03 -0700 (PDT)
Message-ID: <07215af0-4164-efb6-4ba8-63d33fe8664e@joelfernandes.org>
Date:   Wed, 7 Sep 2022 09:44:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen> <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220907094014.GA193994@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On 9/7/2022 5:40 AM, Frederic Weisbecker wrote:
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index bd8f39ee2cd0..e3344c262672 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>  				  unsigned long j, unsigned long flush_flags)
>>  {
>>  	bool ret;
>> +	bool was_alldone;
>>  
>>  	if (!rcu_rdp_is_offloaded(rdp))
>>  		return true;
>>  	rcu_lockdep_assert_cblist_protected(rdp);
>>  	rcu_nocb_bypass_lock(rdp);
>> +	if (flush_flags & FLUSH_BP_WAKE)
>> +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>> +
> You can check that outside bypass lock (but you still need nocb_lock).

Right, ok. I can make it outside the bypass lock, and the nocb_lock is implied
by rcu_lockdep_assert_cblist_protected().

> 
>>  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>>  
>> -	if (flush_flags & FLUSH_BP_WAKE)
>> -		wake_nocb_gp(rdp, true);
>> +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
>> +		wake_nocb_gp(rdp, false);
> That doesn't check if the bypass list was empty.

thanks, will add your suggested optimization, however I have a general question:

For the case where the bypass list is empty, where does rcu_barrier() do a wake
up of the nocb GP thread after entrain()?

I don't see a call to __call_rcu_nocb_wake() like rcutree_migrate_callbacks()
does. Is the wake up done in some other path?

thanks,

 - Joel
