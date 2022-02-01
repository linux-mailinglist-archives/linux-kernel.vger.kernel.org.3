Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A94A578A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiBAHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiBAHMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:12:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E605FC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:12:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q127so22788603ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVW92HDoC/XVNlQ/sBgLb71ANKolpSb9a+lR1z7DyS0=;
        b=CPLDx7KNeK82j2UI56J1LCuggSFeS3B2lH5X9mR4iWGhggCJZ7rZFSdvibZncDYfeL
         3aGqJjr05O4+vnzjbsQBaM8wljY2rHeBMdnMAjqAfYWCw9vb8EqAzVHJ+/2/S2VQDaA7
         Up2Jqz0gcUyuHx7md+lYW8pzmwH4plPXMFItE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVW92HDoC/XVNlQ/sBgLb71ANKolpSb9a+lR1z7DyS0=;
        b=R+zIEvEJb132RNmjuWOVkxwWRjdOuYtit0KXXolXO85s2EdF2GKFwQ6uUG8BG5TjVo
         OdJJE0FiImjJ9z1fghuBqRi1s6ysX7uNtL/nGmMEzCBeapU1JgJOsENomQBR4LeOwfeq
         hmUQmcHGKkcTxchiEnOH01qyOe6Pj17PQRIqHwzNcs3FghC30LQOAS2oEuFSLCD+fPf3
         oV8COTezZRjlvFsJaDF46AD1+wxry/iDDw4weJpybsnxciuKkin/54Qr/9mjNNgyeolA
         sEoXiEn5RZPLk+KXlEUCTXe6nVQ10s6Yxgx0RZCqMrcK6PsjBHS6YwJIxxuZ7xTdev9c
         FKCw==
X-Gm-Message-State: AOAM530MCMUjhBj5Hv17hXZOasu7AjvVankvwFz/Aqs16fRTexTosv3c
        or8qVkAeiZ01+jo/rP9uOm45wg==
X-Google-Smtp-Source: ABdhPJyAdQ4Gv3Z2Qodv0TvVsi1PTC193vemFm9wBX541IgG+fveE5li4PdKDLfvw6DSY9tWIOAXzg==
X-Received: by 2002:a2e:890a:: with SMTP id d10mr6847738lji.29.1643699563231;
        Mon, 31 Jan 2022 23:12:43 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j18sm749488lfr.253.2022.01.31.23.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 23:12:42 -0800 (PST)
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
To:     Waiman Long <longman@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
 <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com> <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
 <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
 <c33b6435-1b27-32af-b14c-0f3a0318dcca@redhat.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f3bcf541-e77b-ca93-ef5c-862f4de99366@rasmusvillemoes.dk>
Date:   Tue, 1 Feb 2022 08:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c33b6435-1b27-32af-b14c-0f3a0318dcca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 19.48, Waiman Long wrote:
> On 1/31/22 05:34, Andy Shevchenko wrote:

>> Also it seems currently the kernel documentation is not aligned with
>> the code
>>
>>    "If @size is == 0 the function returns 0."
>>
>> It should mention the (theoretical?) possibility of getting negative
>> value,
>> if vsnprintf() returns negative value.
> 
> AFAICS, the kernel's vsnprintf() function will not return -1.

Even if it did, the "i < size" comparison in vscnprintf() is "int v
size_t", so integer promotion says that even if i were negative, that
comparison would be false, so we wouldn't forward that negative value
anyway.

> So in that
> sense it is not fully POSIX compliant. 

Of course it's not, but not because it doesn't return -1. POSIX just
says to return that in case of an error, and as a matter of QoI, the
kernel's implementation simply can't (and must not) fail. There are
other cases where we don't follow POSIX/C, e.g. in some corner cases
around field length and precision (documented in test_printf.c), and the
non-support of %n (and floating point and handling of wchar_t*), and the
whole %p<> extension etc.

Rasmus
