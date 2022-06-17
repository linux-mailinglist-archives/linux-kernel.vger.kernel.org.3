Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522054FAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383137AbiFQQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383129AbiFQQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6037242;
        Fri, 17 Jun 2022 09:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B6CCB82A2B;
        Fri, 17 Jun 2022 16:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D4C3411B;
        Fri, 17 Jun 2022 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655482056;
        bh=WmV1TyCMZ8aLA07+gDIcGVYwWUTFoG4sxaEDzudfgSc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCrrIzkyPzIeFVnLcg5hhzB4uA1X8ZxOfS5HXp1TRrx8Jgzig3O0Wu53O61x3XSzn
         cK6025OGMxVAp7RsCj7YRhTctSHkkn1YhTFDMtx5EpZflegzk8gLVbzSClyZjE2YN+
         fqfaS1an5aWEIWNCA3esVzDBPu6OhKpjGgOubjww9l+fOGZFD7qsuJHZIXVMehGWlM
         XFY6dXu6m0nskgcIp1y2/dzxtX1YKLZwpdxMu0nZfpacT+0CzaQOEKE51ZfqhgAj5K
         ktLbBcUPRh4VUIx1xyunE4gckxrBFYuBtKCCdehSZXH7UMTIQp0Q/sNkRIeCdC88Gb
         F5SDHlLu8YrfQ==
Message-ID: <008fcf02-0713-c43d-6267-4a2ed2eaba75@kernel.org>
Date:   Fri, 17 Jun 2022 18:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 09/20] rv/monitor: wip instrumentation and
 Makefile/Kconfig entries
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
 <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
 <4d975ef5-7e50-9241-1a3e-f0f9bad9c5b5@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <4d975ef5-7e50-9241-1a3e-f0f9bad9c5b5@infradead.org>
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

On 6/16/22 23:00, Randy Dunlap wrote:
> 
> On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index 1eafb5adcfcb..e9246b0bec9d 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -26,6 +26,13 @@ menuconfig RV
>>  	  the system behavior.
>>  
>>  if RV
>> +config RV_MON_WIP
>> +	depends on PREEMPTIRQ_TRACEPOINTS
>> +	select DA_MON_EVENTS_IMPLICIT
>> +	bool "WIP monitor"
> Does WIP mean work-in-progress?  (It does to me.)
> 
> If not, please explain what it means in the help text.
> 

Wakeup in preemptive. I will add it to the description.

Thanks Randy!
-- Daniel
