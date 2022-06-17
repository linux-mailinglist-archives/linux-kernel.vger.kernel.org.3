Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F354FAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383186AbiFQQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiFQQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D68E33A10;
        Fri, 17 Jun 2022 09:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C8761026;
        Fri, 17 Jun 2022 16:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597EC3411F;
        Fri, 17 Jun 2022 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655482151;
        bh=3dpAcESJw5vtLwj0XpoF4BT7WEo88JPPXnfDDRPknfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X0DPpv9AZYnJfNCekqSgFR3Er0Rt0xlBcb2O/m8p61zFLsI8Lk/mx52KThftyP+lb
         eeCLKofOqJZNy2NmxH/Y4QNjmIX1/yAPDC3dvVwSmbaO6sYCp8PZMebzrtNDoB4R1P
         4Ysi/QM6yC+v9I4styMlYK4FSLCoVlCwfaaV0si2edf7ld/Zdqh0ysYUhbk0LRO47U
         o8y/k/0VZIGaO8ONleSVrnhr4dtet82TVAM2XD7LwxVXO1rj8pFEuLkA4V5VjuUCge
         tga7LzRC1OQTXf3DMXn0ceYhRTCMwXBSyqeH7Ildv6yHslRcOJQkejJCHAy/JBmyMX
         dCkEGaLyNhvrQ==
Message-ID: <7a45d9cb-02c0-6139-35e1-7bd6cda6c162@kernel.org>
Date:   Fri, 17 Jun 2022 18:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 13/20] rv/reactor: Add the panic reactor
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
 <3230f073-5228-693e-f7cd-5fc4b7226a66@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <3230f073-5228-693e-f7cd-5fc4b7226a66@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 23:03, Randy Dunlap wrote:
> 
> 
> On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index be8e3dab0a52..91a17b13a080 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -60,4 +60,12 @@ config RV_REACT_PRINTK
>>  	  Enables the printk reactor. The printk reactor emmits a printk()
> 
> 	                                                 emits

oops!
>>  	  message if an exception is found.
>>  
>> +config RV_REACT_PANIC
>> +	bool "Panic reactor"
>> +	depends on RV_REACTORS
>> +	default y if RV_REACTORS
>> +	help
>> +	  Enables the panic reactor. The panic reactor emmits a printk()
> 
> 	                                               emits

and Oops again.

>> +	  message if an exception is found and panic()s the system.
> 

I will fix that, thanks Randy!
-- Daniel
