Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917BA4BD10F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiBTTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:38:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9D525C47
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:38:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so6870544pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hYXdm4FLXtQQQvVkqaWClXrraHlkI/ZTb0d26LpECoY=;
        b=OoqpVpEoAlQHsh85N4Qkgtw4sVt2vFcFjFXXFlofGduXtzuiUBv+xoUTPr6PgOYIg9
         O2g5BemDgJT3QDEKsKzWmJ73c1jL1Z/Oez/AQ+hy3OO7z0/lUX/XA/5QaJwHIAkzaedV
         QF1qXmX0tDCgIrTy/cR5sTJpOiQdZv9oOV/pcI0ZL3kgVE/Jg3hBlB7eWUuJqwc+Weu+
         Trl9yjNRsH1OnxOj4kDmVLEo8Bwt4up+RALrcUzSW1p5G58Y2UHsn87YdjCTyPBLvCsp
         kOyqtNDlxu7lCVUdbQfvziue4Rfc/pib2GErvXiDyopL9e6sxNAFM8TdnTzIcIdqa09A
         Hbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hYXdm4FLXtQQQvVkqaWClXrraHlkI/ZTb0d26LpECoY=;
        b=Ph0jEOmWiCK4JxqAn4v7s7+Un7Z2rMaII8597LIK2t0P2VTOzj4KZ33qs0vLnBjSQ9
         NlsmEgZ0i0dCt8NKlEhtzHz+PperUQHxlTNkkyOhBU8q6NgCyPDPsOGgVzL+89h1fy2a
         hx1YjceOFs3zyrXced8ydToSj6WHxffvFWwbwjzniQuZeQcHmX9ov2on02f903/Z1XH6
         Cx9d6Hq/L4nPrwRahZFWIEfh97BA/DQy7z8cx+MGHiO1oMY3ePztnrjD5EJabdqPBC+x
         fodiQQm2yBnh+74bdJ8+u9c27hM7XErrAmmtbixpP61iX7lEnHDEXqjwbJJBlxCJ8/hm
         Wf8g==
X-Gm-Message-State: AOAM531WCt+sXxWo2i0ilf48LJcIqFnHhReBzoB4aMJqIML103lo+iG3
        /jAr5MSRM2yVGO06OAA+sX64QePJuXJTDA==
X-Google-Smtp-Source: ABdhPJxgxOu7fWdSQ3ndFA6kjArUt93/p3hRE1cC+cOlyj/c8ghSNSWV3D7iec6yTp9NIDXUojhXdQ==
X-Received: by 2002:a63:ef55:0:b0:36c:687d:4140 with SMTP id c21-20020a63ef55000000b0036c687d4140mr13633094pgk.481.1645385905601;
        Sun, 20 Feb 2022 11:38:25 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q2sm10428473pfu.160.2022.02.20.11.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 11:38:25 -0800 (PST)
Message-ID: <76456775-a0c5-7925-0160-9037512e7e4d@kernel.dk>
Date:   Sun, 20 Feb 2022 12:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1] io_uring: Add support for napi_busy_poll
Content-Language: en-US
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Hao Xu <haoxu@linux.alibaba.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d11e31bd59c75b2cce994dd90a07e769d4e039db.1645257310.git.olivier@trillion01.com>
 <cbf791fb3cd495f156eb4aeb4dd01c42fca22cd4.camel@trillion01.com>
 <f070354c-b65b-f8b3-e597-2e756bcfa705@kernel.dk>
 <b674472d8c52a84002908e2248fd81ce11247569.camel@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b674472d8c52a84002908e2248fd81ce11247569.camel@trillion01.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 11:37 AM, Olivier Langlois wrote:
> On Sat, 2022-02-19 at 17:22 -0700, Jens Axboe wrote:
>>
>> Outside of this, I was hoping to see some performance numbers in the
>> main patch. Sounds like you have them, can you share?
>>
> Yes.
> 
> It is not much. Only numbers from my application and it is far from
> being the best benchmark because the result can be influenced by
> multiple external factors.
> 
> Beside addressing the race condition remaining inside io_cqring_wait()
> around napi_list for v2 patch, creating a benchmark program that
> isolate the performance of the new feature is on my todo list.
> 
> I would think that creating a simple UDP ping-pong setup and measure
> RTT with and without busy_polling should be a good enough test.

Yes, a separate targeted test like that would be very useful and
interesting indeed!

> In the meantime, here are the results that I have:
> 
> Without io_uring busy poll:
> reaction time to an update: 17159usec
> reaction time to an update: 19068usec
> reaction time to an update: 23055usec
> reaction time to an update: 16511usec
> reaction time to an update: 17604usec
> 
> With io_uring busy poll:
> reaction time to an update: 15782usec
> reaction time to an update: 15337usec
> reaction time to an update: 15379usec
> reaction time to an update: 15275usec
> reaction time to an update: 15107usec

OK, that's a pretty good improvement in both latency and
deviation/consistency. Is this using SQPOLL, or is it using polling off
cqring_wait from the task itself? Also something to consider for the
test benchmark app, should be able to run both (which is usually just
setting the SETUP_SQPOLL flag or not, if done right).

> Concerning my latency issue with busy polling, I have found this that
> might help me:
> https://lwn.net/ml/netdev/20201002222514.1159492-1-weiwan@google.com/
> 

-- 
Jens Axboe

