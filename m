Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22052D232
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiESMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiESMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:13:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE07A835
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:13:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x12so4884215pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GmxU/O4H+JSo5ZKNu9jJfb7kEf/L0HWTXfgb5nJEI4A=;
        b=sz+8NS0oKVCMtxCEB3zMr4WcExVRYRwmes1vCmNLo9ZcKbhNqkegnftUzYTbRPn+hQ
         sorenMoirs599Jk0WnvsEDRa0zgWwPIe/9Rhr7UwsDYJKUDxIOXbvVv6walL4+keACp2
         U82Fwu6X5fgbHr5b5gmOUv71jOPQng438qqeST8POgtp/8L+qUxKAsPQMZj5i3VBtnLo
         rqKMyOFiryvHj3CX9iMUNEuRTm6ReaTUVmZ7Kyh144qxazmqpXed64CkyihgPSEFecP1
         v5iHpWVwPG5Okt2vlfeMmpu3Nxmh/kPmWFBke9dgcD5Q0Pxhn23F9wZ7RI3fL7n4SA0m
         YWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GmxU/O4H+JSo5ZKNu9jJfb7kEf/L0HWTXfgb5nJEI4A=;
        b=MF7AXsMekpFdLkA+GU8STRUpPdYYFN4rPCQ80MNIdDdRbqLrPCMWN5r4f9H9pBzJR+
         WC2xXRYbSu9GARSS1Tss+q8GlR98MjuQh0CL4jEbW9B1zE4aOJK4/JGMMhZtNEM4Lf+L
         xmD8c4OtuMAG77wBEjJkXA42kVb1e/p7okfuLyJS514367Xw/4kGh6oE6UKS/s88YhPi
         BxBLzlxH3xzCgZ8u43Z6+ipF96vtziytpaVP9nBUNec97BX+ad1s/TZdySISQqwArJEM
         qeAHv3yDZPirC87EHOPcT9H/pJJ4RP2LK5LNbnicR6dlUq5L3hPC3QnKKxcLHWw1EUIx
         Tlmg==
X-Gm-Message-State: AOAM530HlkYBDZGRzg2mW0cyn2cunbsGMukUafiaDQVAvzcGUd3yhWct
        UhD9YZNIrCYwnhGQEwDMXZmsBQ==
X-Google-Smtp-Source: ABdhPJz8koyl6XwSJRRbtRGGZWml3c3PXKgPxSUA2t3E7U720nQRtSKdiKOubbLtMZSQNzbv9qvhpQ==
X-Received: by 2002:a65:4904:0:b0:3c6:86c7:317b with SMTP id p4-20020a654904000000b003c686c7317bmr3663485pgs.39.1652962418776;
        Thu, 19 May 2022 05:13:38 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b0016173113c50sm3524333plc.92.2022.05.19.05.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:13:38 -0700 (PDT)
Message-ID: <2eb22fb3-40cc-48f6-8ba9-5faeae0b43ff@kernel.dk>
Date:   Thu, 19 May 2022 06:13:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] io_uring: fix sparce warnings about __kernel_rwf_t
 casts
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, io-uring@vger.kernel.org
References: <YoHu+HvaDcIpC7gI@infradead.org>
 <7de7721b-d090-6400-9a74-30ecb696761b@openvz.org>
 <YoXrq23tjl1v3YD0@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoXrq23tjl1v3YD0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 1:03 AM, Christoph Hellwig wrote:
>> index cddf5b6fbeb4..34839f30caee 100644
>> --- a/include/trace/events/io_uring.h
>> +++ b/include/trace/events/io_uring.h
>> @@ -520,7 +520,7 @@ TRACE_EVENT(io_uring_req_failed,
>>  		__entry->off		= sqe->off;
>>  		__entry->addr		= sqe->addr;
>>  		__entry->len		= sqe->len;
>> -		__entry->op_flags	= sqe->rw_flags;
>> +		__entry->op_flags	= sqe->poll32_events;
>>  		__entry->buf_index	= sqe->buf_index;
>>  		__entry->personality	= sqe->personality;
>>  		__entry->file_index	= sqe->file_index;
> 
> For which I did not see a warning even if it looks real to me.
> But this union with basically a lot of __u32s here looks pretty
> strange to start with to me.

Vasily, if this is still causing unnecessary sparse spews, please send a
revised one against the current branch.

The union is the per-op flags. The requests that use them have a member
in there, either one can be used for printing it obviously.

-- 
Jens Axboe

