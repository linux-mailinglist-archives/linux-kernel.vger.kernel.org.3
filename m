Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6A513387
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346170AbiD1MYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbiD1MYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:24:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA922BD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:21:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u7so4177713plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FYZIx8jx1aR4gkAh2iYCCe3e4rrFimknaCGTXZU7TLQ=;
        b=SGZ9G+mVx+3OeBOmcJVrBIPLpvhoEzYioP5xhDpHnyMYkaLHqDHkGXt2/9kAG7bohP
         FVAw83Bks+bpNOWDCBtVKmPZ98d5g5+IJJwg7inGHVXMVAhBgQdONDasJj/H5+4dhv8u
         SKHWu+jlPHn/qyM7etNkS1oRndnBnmsCVwlhQnzydEgJ2gvxUf2ynTwRtBRmj8nmemJT
         Jp6lXbZpOyG/scO0NoP6+IRTpDMgTowIfxS9DhVx8WvRjyVygZHVutqC1dX05fP7e8lS
         P7I6Lg76svCIWzaQtS62p+V1Z0If9mLSrLPcFmnuxxmOaqVgUi8691UNL8ku5jB1fu4U
         mguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FYZIx8jx1aR4gkAh2iYCCe3e4rrFimknaCGTXZU7TLQ=;
        b=xOvInoQBbSMTr1nPVpv8u/bTvQUcTNqLfyOQmVSim1Ouh6Y/PsN88vSq3DQJUJZZ2N
         JlQVU8yhTtjlMZD7LyIywoMzffr52RsCtJFHdCqhEGxJXd4mK3MCGACVCTMbr7nkAAgr
         PNvSa2k/4WwWNdEjdzVltOWZPwMNaU56kYjCrjka+5880eQybHsS8Xlf5pW5eciOc1sc
         f8Yta0hQIHklpcjo2TPxlbufSCv1KL+kBWUz88cmy8Vjdo5cIu7qWd2bJA9Ezix59YLv
         oprp6g4SsiO1B4CPOb32I+y881Mr/yDi6vpfX8W75JGFLB0Hlzblt4H0qm/m0xdpTgvQ
         a9tA==
X-Gm-Message-State: AOAM531RM6MGQw+aRwtPFtBBHmMYZeJ4DnlOUz/h0uZr/b1IsDzio4Hg
        GXdEUvHZ97zJaibzLkx592nseQ==
X-Google-Smtp-Source: ABdhPJy9Gq80uE74g7KKn6dTwlEbtGnMILmES5WTq/CXby4Jo4kJEzUvxJwMEzXUEAPKjrbUKo6C0w==
X-Received: by 2002:a17:90b:4a08:b0:1db:cbc5:d9b8 with SMTP id kk8-20020a17090b4a0800b001dbcbc5d9b8mr4356166pjb.176.1651148487462;
        Thu, 28 Apr 2022 05:21:27 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b001d29a04d665sm10282656pjb.11.2022.04.28.05.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 05:21:26 -0700 (PDT)
Message-ID: <bf6cc541-4de7-3258-ebb8-caa3a8249bc7@kernel.dk>
Date:   Thu, 28 Apr 2022 06:21:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de
References: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
 <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
 <20220428090836.GQ2731@worktop.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220428090836.GQ2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 3:08 AM, Peter Zijlstra wrote:
> On Mon, Apr 25, 2022 at 07:52:31PM -0600, Jens Axboe wrote:
>> On 4/22/22 8:34 AM, Jens Axboe wrote:
>>> Some use cases don't always need an IPI when sending a TWA_SIGNAL
>>> notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
>>> except it doesn't send an IPI to the target task. It merely sets
>>> TIF_NOTIFY_SIGNAL and wakes up the task.
> 
> Could you perphaps elaborate on those use-cases? How do they guarantee
> the task_work is ran before userspace?

The task is still marked as having task_work, so there should be no
differences in how it's run before returning to userspace. That would
not have delivered an IPI before, if it was in the kernel.

The difference would be in the task currently running in userspace, and
whether we force a reschedule to ensure the task_work gets run now.
Without the forced reschedule, running of the task_work (from io_uring)
becomes more cooperative - it'll happen when the task transitions to the
kernel anyway (eg to wait for events).

-- 
Jens Axboe

