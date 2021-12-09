Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22346EE98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhLIRBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhLIRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:01:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385CC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:57:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so10758055wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLgzkNLdP0hBHm9M7yVr2EdeEPKtr0Oh3MhzIx/J05k=;
        b=i424fe3oOnDoHtXyxoekgtT9PBOJfOz0KXkBkZRXGJgREeCFtbSYNpYdi7d/eKs9oe
         R9UBSp/1d8SpaXymxJ/YxybDBHNPMR/ByV/dbHO7NaHHcvZOFxWzJbV7qhhsHAHAKM5w
         jXkG1VX5ce4xN6LIjfi5lNsveGY/sUObHpsW47PDQCQfO5ElcRa0hFrE8n3UKrGsI6mb
         coiayG2o/F5bcWkFgS/l2lXW9I8vM5SfVm3YALW3HRk/5XFZ/yQ2cb3O+hv9L4zAv6K/
         WcjPlBbg3N7oy7PapwKj3zjMlgsEQ3Es11XTDZbE91sPJrm6ipWi6dSd6s/jYPcgUBHo
         cLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLgzkNLdP0hBHm9M7yVr2EdeEPKtr0Oh3MhzIx/J05k=;
        b=BMan9pJq3PCg3oi2b4vsokTywiyhTMhTxtnF2XoucnIFKNaKIYJ40FZPJ2rG6WMw/d
         EB4nHDaH9rrRMis1fxrYVaPNwIofkw9QtDaFjbhTvwOY9iJkY0Hfo53PeFhkOFM7pV+k
         N8aioSLw+h+Zeq4aZ3Amk8rdfv1357rcYNuYRZ3HfVeMd9XCcSRep7TNV8Q7uVktRCRF
         RbGg2hFxTl80dZ648vI7bKLuL2biIdXep0Fclj9bIHujZN1XVi22INeMAJYiDfO4mQp6
         M8Thd+vOmeH6dFsgdr0HHdlz+40X0XowU3fnPru5cb/Gk1dA0bgVYtzJ5qGY9pE2Su3S
         O43Q==
X-Gm-Message-State: AOAM5330F/uMY/eaDlPW095QVP7nJakNWq3hWXA5+GAa3hhJfRv+wLLx
        m9ujWfh9gWpjMK3ixfjeCbovhPZQpYBEPQ==
X-Google-Smtp-Source: ABdhPJwNBwGM40TCoCApO72UMpQb+PxPDHZcJNjQTE2TceCARrvthLTcEnDiZfGFj69nsIRhX2FSWw==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr8318291wrs.291.1639069057343;
        Thu, 09 Dec 2021 08:57:37 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7191:566f:2b5:22f1? ([2a01:e34:ed2f:f020:7191:566f:2b5:22f1])
        by smtp.googlemail.com with ESMTPSA id n7sm245151wro.68.2021.12.09.08.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:57:36 -0800 (PST)
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
 <b51c9b2a-40d2-6575-7746-3059eec53519@linaro.org>
 <20211209160346.GA7692@ranerica-svr.sc.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f31278f5-7d23-b213-0b5b-321a0d7a048a@linaro.org>
Date:   Thu, 9 Dec 2021 17:57:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209160346.GA7692@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 17:03, Ricardo Neri wrote:
> On Tue, Nov 30, 2021 at 10:29:46AM +0100, Daniel Lezcano wrote:
>> On 06/11/2021 02:33, Ricardo Neri wrote:
>>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>
>>> Add a new netlink event to notify change in CPU capabilities in terms of
>>> performance and efficiency.
>>>
>>> Firmware may change CPU capabilities as a result of thermal events in the
>>> system or to account for changes in the TDP (thermal design power) level.
>>>
>>> This notification type will allow user space to avoid running workloads
>>> on certain CPUs or proactively adjust power limits to avoid future events.
>>>
>>
>> [ ... ]
>>
>>> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]	= { .type = NLA_U32 },
>>> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERF]	= { .type = NLA_U32 },
>>> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFF]	= { .type = NLA_U32 },
>>>  };
>>
>> AFAIU, 0 <= perf < 256 and 0 <= eff < 256, right?
>>
>> Is the following true?
>>
>> 	0 <= perf + eff < 256
> 
> No, they are not. They are set independently.

I understand they can be set independently but is the constraint above
correct? For example, can the system send perf=255 and eff=255 or perf=0
and eff=0 ?

May be I misunderstood but I was expecting at least some kind of
connection between perf and eff (when eff is high, perf is low and the
opposite).


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
