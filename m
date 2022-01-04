Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141D34839D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiADBbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiADBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:31:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE44C061761;
        Mon,  3 Jan 2022 17:31:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w20so63943762wra.9;
        Mon, 03 Jan 2022 17:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8RP2kK8mapgiU76wbNQ3ZzyNp6SxXEgsjV0c/YCw1uI=;
        b=BzsjoeWUpRtaow9lliq1z5o0NSx/KUJZhMrWzA7WV9G0k/wHDbGy7mJfgMHJ0dEreS
         owAD6keYzzRBaUxrc8JkT0DhY1llK+YHOpHADfYot1Rjjsi4WP+SXIFeoNdqcIIB4t0o
         UhIa2KDl4D1F6qhkzFVHr/Yge9UGZavDH7Ya9xrQeqGArYZyMfDF+uxevZk4l0Ou9xhb
         v9oobErj6QIRTJJ6jt2gCEvUjccfle3ocxD/hQ709un/aHn62iL5vZfAsEvWOnfgTXfu
         M/bROZCwh8uFNHzASafE+Vqw4A6XEI/K0mAKt95mkws2seCVlxMUrTMqAMWfZT/5mJCJ
         nNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8RP2kK8mapgiU76wbNQ3ZzyNp6SxXEgsjV0c/YCw1uI=;
        b=R8BWuYQHot9Q6wv/mz+dRgG0cHca3EJfiwKwOQmgoC76e/dCvcgCDsFTPSV8wLtwZE
         HLKD/o+l/QW+4TYd9l6NzvNPZEBeWsi4VPhBywciuXkagKIRjpI6GiMRxQRP37fBq6kP
         aRlXY7AYRXXMJYRlGQC1AbiqsC68IpZQgc430df3Em7OFrsSj9eTL9uCBLjoWOLKzsO2
         PBr4DpNPrtMmvtUOhwSrZLou2ZOmy7RZVT9xe2/2XWRbqlxGXwitnmO0odGHZk7dEkNp
         Wyi4oQ/umPboCxPUJLXsY5uhUXtavK7cHH5r+cNaZMbJvQQfoXvkOvIGDY8cg+kdQXIR
         Rw6g==
X-Gm-Message-State: AOAM532qSyLKpGTUSs8IvhBfgoXj7g3wNdrLztCs3XXAYb87Xc34DTdc
        SzFz58qeyAzL2vwbcpf5vSo=
X-Google-Smtp-Source: ABdhPJxTdhXdLdajpyQarHz4T17XD/qWUXBHu90i572ts9V4z3pQq0i4Iw6rDc4/I+4sQ/D9J7oNnw==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr39755747wrv.91.1641259897334;
        Mon, 03 Jan 2022 17:31:37 -0800 (PST)
Received: from [192.168.254.53] ([103.105.48.220])
        by smtp.gmail.com with ESMTPSA id u14sm35694797wrf.39.2022.01.03.17.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 17:31:36 -0800 (PST)
Message-ID: <59c748b5-245a-c2d0-0b9f-d412687c72ab@gmail.com>
Date:   Tue, 4 Jan 2022 09:31:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH RESEND] dma-buf: heaps: Fix mutex lock area and generalize
 struct dma_heap_attachment
Content-Language: en-US
To:     John Stultz <john.stultz@linaro.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20211229070713.218548-1-o451686892@gmail.com>
 <CALAqxLXtUcign2gETHg=z24qYOFSALRjWNnJqqY6rk=gsfVwaw@mail.gmail.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
In-Reply-To: <CALAqxLXtUcign2gETHg=z24qYOFSALRjWNnJqqY6rk=gsfVwaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reply.

On 2022/1/4 02:45, John Stultz wrote:
> On Tue, Dec 28, 2021 at 11:09 PM Weizhao Ouyang <o451686892@gmail.com> wrote:
>> Fix cma_heap_buffer mutex lock area to protect vmap_cnt and vaddr. And
>> move struct dma_heap_attachment to dma-heap.h so that vendor dma heaps
>> can use it, the same behaviour as struct dma_buf_attachment.
>>
> Hey!
>   Thanks for submitting this patch! Apologies for the slow reply (was
> out for the holidays).
>
> This patch is combining two changes in one patch, so they need to be
> split up. The locking change looks sane, but moving the
> dma_heap_attachment may need some extra justification as changing
> upstream code just to support out of tree code isn't usually done (if
> there was some benefit to the in-tree code, that would be fine
> though).
>
> I'd also be eager to try to get the vendor heap to be merged, assuming
> we can also merge an upstream user for it.
Yeap moving the dma_heap_attachment need more sufficient reason, and
it should add a private area to adapt vendor heap change if we move it
to in-tree code. So just drop the idea now :)

I will send a new patch to clarify the locking change later.

Thanks,
Weizhao

