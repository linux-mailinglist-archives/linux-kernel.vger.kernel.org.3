Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21A46A5F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348702AbhLFTwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348036AbhLFTwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:52:15 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AEEC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:48:46 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w4so11369714ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ywinYb56QHh87QcHVGWwF3m7yXk5Dis0ajMhWVoqPOs=;
        b=4wzrpr3l2kbKa7j3eM0hMiY07XZRSyQV3PR8RrWCQPGw0Z8ACFAMIGanIyMpGtehdX
         O/2JhPOZtur8S/10yRSZ1MOIpisaB3ULalbsI9xJMd0BglXD5e1eJnCosPmRQGNGgPcT
         vuITjDa9daUiaVxAS77y4dxpZ1fcpy6ESbdGZb13SSoM6jmjMj9LtPUIa6wTpMeMgukK
         ZwcRxUSXvb7ysbo2kkl6QkYnRwZksiAdrwzH+0UlM0RUORlLV/lGQ9QTYEQnS8esbFFc
         pyCQsVC9vtrvQPyDMu8QhcsvEofEzTVzCj2PSwubRoXM3pFNMgWxWWhr466JmBJ9Y5Xb
         JykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywinYb56QHh87QcHVGWwF3m7yXk5Dis0ajMhWVoqPOs=;
        b=ykb+vhFFSoNwKw3k2ZEsFdex7c1i30NhFaKxOhcLZhHFUlwAPF+rYfHXuCNk4l7bNV
         hT4ejNevBXlsJ7Gvs9lIv2f+6gMmmH2+IW1R03Bn/HxqwDEwHhmDMwjZ+tUQZ/Kq7pRy
         afH1exrp259eTv7G7tmeUJnuO1sTF/mEatf1WmlKazsKKk23PSd2m7oqdBSzoHi8R4eA
         i8mE2Q6rjlve/p+f4mRZSft6LibtdzO20dH9s94CPL3GJ2ZJ3PSN11eiQdY9VCwiHS6s
         5wFblwsgKE3uEgJGtmM6yLyEwi5nW7ohF7PqVksFqOCGdINhoO+PVlV03BVZdepjunwP
         d7nw==
X-Gm-Message-State: AOAM531w4Wq50eqVfzSGNjjhaTK58xArHLH+S2h12jh5JMEThlXCzcMD
        sm8/ZhGUO3XDyhZud6jDFYlY0g==
X-Google-Smtp-Source: ABdhPJwGK1xF8N9yJ3v2/8CP+QCO89vFFWnVpXn+1CrsnlWq21GnkenP55mvb+5cxLf+GccJNuqvSQ==
X-Received: by 2002:a05:6e02:1845:: with SMTP id b5mr32363264ilv.168.1638820125399;
        Mon, 06 Dec 2021 11:48:45 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s8sm7079486ilt.49.2021.12.06.11.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:48:45 -0800 (PST)
Subject: Re: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, kashyap.desai@broadcom.com, hare@suse.de
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
 <67feacc8-3da7-90de-cc0c-f8b529f84297@kernel.dk>
 <544f60f5-a367-a1a0-5a21-9708a7e8d2e1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <930e8d6b-1e5a-fc06-47de-9ea9fee9fcc0@kernel.dk>
Date:   Mon, 6 Dec 2021 12:48:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <544f60f5-a367-a1a0-5a21-9708a7e8d2e1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 12:34 PM, John Garry wrote:
> On 06/12/2021 19:07, Jens Axboe wrote:
>> On 12/6/21 5:49 AM, John Garry wrote:
>>> In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
>>> and callees for shared tags.
>>>
>>> Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
>>> shared tags, but it was not optimum previously.
>>>
>>> This series optimises by having only a single iter (per regular and resv
>>> tags) for the shared tags, instead of an iter per HW queue.
>>>
>>> [0]https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/
> 
> Hi Jens,
> 
>> The patch(es) are missing Fixes tags.
> 
> The first two patches aren't fixes, but are general dev. As for the 
> last, it prob should go as a fix for 5.16, but I was not sure how you 
> would feel about that - it's not a trivial change, we're late in the 
> cycle, and Kashyap was happy for 5.17 .
> 
> Let me know if the last could be accepted as a fix and I'll re-send 
> separately with a fixes tag.

Regardless of whether it's going into 5.16 or 5.17 it should have a
fixes tag.

-- 
Jens Axboe

