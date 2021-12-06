Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB646A163
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhLFQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhLFQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:34:56 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A9C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:31:27 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w4so10760945ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N140yqlCXidc3VjcyOFJMQBhCYsW1xvd6Xas/IARoW4=;
        b=Apsp2Dqa5vAUCdii9wA214WnRlQ0AkZOzUXILsoNq+/PYt0N+OjuL6oPkTabsn3XQL
         1qlIktr5Zl5Md+US13x7o+dQLsH8clUkQaxC+anl61HQ6N8yjSPOF+PgNrL2UPU4i4YR
         nMN5qs888T2hSm0yWOWb0Z2kaxaIV6Ck0xsmqYG28EOeMeM6XbgTO6Ev9WivejUjc5Od
         QsK8hx33OjnT3/pv4peEzWUE4RsRg8j7XsHKKtArR71Nhh6EZ9SyLRebQjwziszq8vxO
         JE+QiOeQfjMA6MkZs/+2tISGVa2s758/T5dwwgCE0F1g94EGhZ0+6ZZpcWX4XYNJsCkq
         Fq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N140yqlCXidc3VjcyOFJMQBhCYsW1xvd6Xas/IARoW4=;
        b=jS8skoG6Pz73U9l3T9V7jrOpCRRvz4FyFu6b9olcaw7GRF5zVcDX6pK7CVpqTKCXzR
         JzJG6tN54nhFfpEn1y46KrAcZHJjBYpAsxdGxgtk7NsEKxvoOgDKliia7VxLMQ0mbF0z
         QqsPwKuLjbZ02lQRvlqNTQsTumsqWV2aYGuXiEVwiDjyWWlm7gzuEinfBp20ipBfVbPN
         +OWBR5MwxCsOC6eHLHnnblb+3ps2g8s1ECxe2e40s1f4tODvI/RSnjscJPk8bJ7yPOnu
         D7VPbC8mWZopNeNpb5zpRabGXvumDEOMtLzGcLf0uCYT+1bcr+P6ZgpUkygEm2NN5yz/
         oVxQ==
X-Gm-Message-State: AOAM532cTJF0lZveAS+HNWfVyqPNGk4dYPaVrwOfe4xLqOGSUh/RXeN2
        YUYKkF9VxYjFDZinW0uyEB/ZuXfA7bHOVyAK
X-Google-Smtp-Source: ABdhPJzyqNshToUEecgEowcEsGVXNEsNW1PkUdUONg0lNpuCeOqv/mGaaS7Yeeat1AAvl6xJf3t4iw==
X-Received: by 2002:a05:6e02:1845:: with SMTP id b5mr33633465ilv.266.1638808286522;
        Mon, 06 Dec 2021 08:31:26 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i1sm7855297ilm.5.2021.12.06.08.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:31:26 -0800 (PST)
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17e7fcdc-4450-771a-a84b-b2a15b37c122@kernel.dk>
Date:   Mon, 6 Dec 2021 09:31:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya2zfVAwh4aQ7KVd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 11:53 PM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
>> refcount_t is not as expensive as it used to be, but it's still more
>> expensive than the io_uring method of using atomic_t and just checking
>> for potential over/underflow.
>>
>> This borrows that same implementation, which in turn is based on the
>> mm implementation from Linus.
> 
> If refcount_t isn't good enough for a normal kernel fast path we have
> a problem.  Can we discuss that with the maintainers instead of coming
> up with our home grown schemes again?

I think what needs to happen next here is that the code is put into a
separate header so that the vm, io_uring, and block can all use it.
refcount_t is better than it used to be, but there's a difference
between fast path and tens of millions of inc/decs per second.

-- 
Jens Axboe

