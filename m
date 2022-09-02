Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A815AA659
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiIBD2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiIBD22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:28:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD808B2C8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:28:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x23so643975pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GFQY0YKLoXtjJUiJG5Fqkj40S/j1pTR0BA9ddLQmSRY=;
        b=ZgvPnWX/oPWp8lgiTy/gR1/l9XJxrRLjooP4OnGdpdVDsFHE8dUE1MsWoyrmjlHZw3
         cmlhUhMyeWBpbX78ycD6vbCH8gh9AA2sPkkD+t0kdVAdc2b1bhs/pabQYXw94JJXQCOB
         1dj11T5S06kDSPJYX+ahh0YQm8VBD6dBK0QTu2HKjU275S7VxA+rRWOjcU8QsTGAp5Em
         AE3L1dGGMY3p2g0C6b7WTtEXFOzIe6xEQvT828e3z9d4EJcVpyuYlVJZSI+vM4SmodhA
         9xtDgqlCA06oyZC/6oA+QwA/f1tBGCVHZoK2SSiGnkGO2LG5qAGckOvYuQAjngfh7TZd
         3xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFQY0YKLoXtjJUiJG5Fqkj40S/j1pTR0BA9ddLQmSRY=;
        b=mbD5LCOG9N0IQd2jJn8mwFcjKPdmtx8JEBV7ehEKFcCtzlX6YdZ0dmtUmLGWkVrzYc
         oBRbl5TfHRkbxIjqSk9JR5GZx5jdL7T5m+MfYZsQWiR0uWiQ7c9g0hN5fOqhopbzrNU/
         5HsyW8LjBL9NL8DdY/5LxkaC42he1V9OJTRovx/nUER3K6OllDK9NSI6TEcWZar/XvG6
         7r8SxJHcr2het8Xz8V2bDFZtkY6rAenMO83HYBKPNXoZ9Hws/fxG4bkyMHsHg+VTdERS
         BZzZ6lh+i+lahjwiFVWOMUUD39QPXuN4SoEHqD8tP+f1oUSKaNQDt1Mv4+hgzmBNLr3k
         3djQ==
X-Gm-Message-State: ACgBeo2Ok8kOeqSaf8LXUPqtXLM5AiknL6bW9TUruODjlnLA28dUEkWc
        wP+ojA8wZ4yCgcgd2WE7d8YzvQ==
X-Google-Smtp-Source: AA6agR4jSP++v3AnFbkC5c2Lx7gnO/dlBYEL3J0diQzRUqXBn1s6uYHo8piOi+/kh2oofB9IXimn1Q==
X-Received: by 2002:a17:90b:46c4:b0:1fe:4d96:f6df with SMTP id jx4-20020a17090b46c400b001fe4d96f6dfmr2478149pjb.219.1662089306340;
        Thu, 01 Sep 2022 20:28:26 -0700 (PDT)
Received: from [10.254.35.190] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id i194-20020a6287cb000000b0053788e9f865sm410062pfe.21.2022.09.01.20.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:28:26 -0700 (PDT)
Message-ID: <ea3a4260-6fd1-032d-d84a-2973886fcda4@bytedance.com>
Date:   Fri, 2 Sep 2022 11:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: Re: [PATCH v2 5/5] sched/fair: cleanup for SIS_PROP
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
 <20220901131107.71785-5-wuyun.abel@bytedance.com>
 <20220901140311.xi3y72uxdwbpxzrq@suse.de>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220901140311.xi3y72uxdwbpxzrq@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 10:03 PM, Mel Gorman Wrote:
> On Thu, Sep 01, 2022 at 09:11:07PM +0800, Abel Wu wrote:
>> The sched-domain of this cpu is only used when SIS_PROP is enabled,
>> and it should be irrelevant whether the local sd_llc is valid or
>> not, since all we care about is target sd_llc if !SIS_PROP.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> This could conceivably result in an uninitialised memory access if
> SIS_PROP was enabled while select_idle_cpu is running. I'm not sure if
> it can happen when jump labels are in use but I think it could happen
> for !CONFIG_JUMP_LABEL updating the sysctl_sched_features bitmap updated
> via sysctl.

Nice catch!

> 
> The patch is still a good idea because it moves an unlikely rcu_deference
> out of the default path for sched features but either this_sd needs to
> be initialised to NULL and checked or the this_sd lookup needs to happen
> twice at a slight additional cost to the default-disabled SIS_PROP path.
> 

I'd prefer the former.

Thanks & BR,
Abel
