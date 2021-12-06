Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2846A166
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbhLFQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbhLFQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:35:37 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F036C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:32:08 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x6so13510868iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Y4lyaJ5nbN10xflcSf3Q96TrBlRvjDKp8bmE0H7ZD8=;
        b=cstV5U6FB9VcgqZDfsWLYPI+g6MFYsF57ljtuHPM2UZdRTQshW6MRBmf+I13iGstl2
         GerEDP0MTYcYufhvkY12nglK3G/TOnmnxmDPAMpMxvRgdBKtJhf2pdr+TPV1so2di9CR
         2lsqr3Mk27LtA2WRk9XQ2alifjAhRq6c+IAGbVQAJWl03CsXLJ469F5raFLOaDUbtmuu
         niS546AhwL8WKXwOM74+bC1q5Fzm9yoWJNttvu0LDGy9jniByhez3K3RumT+PllLQw+H
         HJ1i+T7VLARNs22VYi0WPwhT6BmNGGnk77yjnVgglHhw+APcCsOECmOrMmRFFGAYW5ON
         GyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Y4lyaJ5nbN10xflcSf3Q96TrBlRvjDKp8bmE0H7ZD8=;
        b=DZg6J8SIE1LSswoHZavSnxQqZ8JE0dlJxjjK6yTfRbfChbtyyV04sQRYljKHV+yqo9
         WZbx6BT9GFA/2YHeEgu4P7FvVrAtrG6YlslEq/YNuZHog5+Z0CNFOubBIz/6FsVktzkl
         YKNOCJQ+WEThUsEztUpuAuCZvUgF0q7vEaxIScVHcu6FikTzPM2ETTb8hCGQNCRE/Qj5
         UuHcwYmqkfc61jTkGM3/6492dzoJVcliyw8xyAn3fr0rwQO8SJSc+PqtoYq4kejho3TI
         nDllAlBJ3Pbb0qfxyT9n+kNQqwcU74Qz66c8rhYa7rFWfMKvWN53aBgBkS1gV2qg0yCu
         M2FQ==
X-Gm-Message-State: AOAM531ykjKhj606ZiX0Hv+f+3ZllD7gmUDBng75PVIdesPe1qhKVuR4
        whqmgOMm+R3mim7fL0WMhsGVUwjPll5A+Wsf
X-Google-Smtp-Source: ABdhPJzSYpew8PAie7r3HH0URoXPsBCTNuQlGQo6oEgGxQG2Fp92tH0Mp3QVQRmQpQ+Ws2s4IqxQlg==
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr34618746iov.32.1638808327752;
        Mon, 06 Dec 2021 08:32:07 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18sm7678292iow.53.2021.12.06.08.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:32:07 -0800 (PST)
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dbe2b14c-5f0a-80dd-b661-d0a7c74ba230@kernel.dk>
Date:   Mon, 6 Dec 2021 09:32:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 1:31 AM, Peter Zijlstra wrote:
> On Sun, Dec 05, 2021 at 10:53:49PM -0800, Christoph Hellwig wrote:
>> On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
>>> refcount_t is not as expensive as it used to be, but it's still more
>>> expensive than the io_uring method of using atomic_t and just checking
>>> for potential over/underflow.
>>>
>>> This borrows that same implementation, which in turn is based on the
>>> mm implementation from Linus.
>>
>> If refcount_t isn't good enough for a normal kernel fast path we have
>> a problem.  Can we discuss that with the maintainers instead of coming
>> up with our home grown schemes again?
> 
> Quite; and for something that pretends to be about performance, it also
> lacks any actual numbers to back that claim.

I can certainly generate that, it was already done for the two previous
similar conversions though.

> The proposed implementation also doesn't do nearly as much as the
> refcount_t one does.
> 
> Anyway refcount_t is just a single "lock xadd" and a few branches, where
> does it go wrong? Do you have perf output to compare between them?

I'll generate that.

-- 
Jens Axboe

