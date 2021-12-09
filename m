Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5146ECEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhLIQXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhLIQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:23:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30ABC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:20:01 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g16so5540637pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f8hGB5K46jwmmjk1vocAq85D3TsLo6SGhUQ80nQQ9g8=;
        b=0M29xfc+ksnPcLbZmJM1vTEK+3hDNs9w1eTA4fXY6XOhrbgfUqEm3LA7M53s3R/mfC
         mIleihMpxMWJ5h8Ye6is8LjhYOi9MG4qI5PZ7pPM0qOMppElCMX4nOG8xyXUBruui4qg
         35zT9yuqLibnmgomKYY8toUU2XhkulR+CMV04tv1/Jjell6SPnFREPqlBQ5c+ism4xJr
         1SHjaf+IPIPQf0TwIShJ/mmxB5xsm2OZXInmuNwSjHTpzzJHCuYNzIDIdORyYV07uFCT
         wIs2BvCIfgaXHFYDrDcmqSnSwi+qq40f4q3IK136rUs6BHYYj9WZlFOgrELQ37Pz6gYG
         9k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f8hGB5K46jwmmjk1vocAq85D3TsLo6SGhUQ80nQQ9g8=;
        b=z6PLhShjC/3gvSeKNkObIxpGoGfCO0ZdaNNJhV4Mj4q+suSfYo7aeAWvcNEemk7ckI
         0xbvddxumqyIPv+boJdvHma8YHAcUljpjDKcbKlWxRf0VOdzgwCH461Rdv7wvy1ZICx/
         q5TdGNyMBDOwRoWJwaJ9w7M4SClrOTWrxw2wvl3QNnOaLGh/PWsm+yqUQj1VXOlK91Ed
         rerg0wCL569Le4jAsARXNGzYbcI8ICjeAV/xkoebjv/26Dpj/k5wWPC7F3jFHmCDNVjV
         LghTD81PZuKSJwRZ1hyRMWasee7kJOhcSXNmn57jLre4K9gdjSPAxrai78ngxx0TlhNf
         jL4A==
X-Gm-Message-State: AOAM531KbskapcEXjMgs61wFwpQj2bwGglC6Q9WmhwGqE2Q6LhZMoN8z
        o/LX61eJuVeNEe3AfkBqySKvBg==
X-Google-Smtp-Source: ABdhPJwWGi/u+ISQXg4PbRC6U53g8Bvbh2IAvu2YpTm7af+o5DTB/UuNNVFlm751fFbRRP/nyZpDmQ==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr34508013pgc.327.1639066801488;
        Thu, 09 Dec 2021 08:20:01 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id p15sm187914pjh.1.2021.12.09.08.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:20:01 -0800 (PST)
Subject: Re: [RFC][PATCH 0/5] refcount: Improve code-gen
To:     Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
References: <20211208183655.251963904@infradead.org>
 <20211209082533.GE16608@worktop.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e62f9cd-514f-578b-79cb-180c283f5482@kernel.dk>
Date:   Thu, 9 Dec 2021 09:19:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211209082533.GE16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 1:25 AM, Peter Zijlstra wrote:
> On Wed, Dec 08, 2021 at 07:36:55PM +0100, Peter Zijlstra wrote:
>> Hi,
>>
>> Improves the refcount_t code-gen; I've still got to go through the latest thing
>> Linus suggested, but figured I should get these patches out to see if there's
>> other concerns etc..
>>
> 
> Bah, I forgot to Cc Jens, let me bounce him the lot.

Traveling the next few days, just put me on v2 and I should have time to
look at this start next week. Bouncing only helps for initial messages,
I'll have to do dig for followups :-)

-- 
Jens Axboe

