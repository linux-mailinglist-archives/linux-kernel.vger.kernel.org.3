Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200124A8C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353675AbiBCTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353659AbiBCTGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:06:42 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:06:42 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y17so2967609ilm.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=isPf5pWODhchjIdDKRlZ9sM1phUTccItVZeEeb/fnXY=;
        b=D7jDz68UbCjuXRZlBndHn5VO13XZykRc3DLEpq1uPy6gQiCKc0jx2Ak5WwcImSAQxt
         LxSkd64B1PHKCYGyZzJgGvupZOLP4cVWmNj994YNRInDu0cgfC2PDhW8aSE6a8hc6oyd
         ocbFLphQiveV+HpIfiprfDGY8bbwZLpkSxA/DL6ePXpx/DYAjc0/tGAbgX1gp9ih+FaB
         1bqnicW2JfvZM9XI61PP1YB0pn+n+Ij6txwcXjDPfpUErnL6PvjUPYbQlJt2RtLbgmHx
         mwVKsUO3Aoz3xmt9ePwbVuR+k4pL0ygM/nqq3RHbzkeG3l7Sh/GCNDAgzyEN4GZ4mx3E
         vagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=isPf5pWODhchjIdDKRlZ9sM1phUTccItVZeEeb/fnXY=;
        b=zt7SmCauqGK6xDVc0KuXs3n+xsMpvnZzT+lDpi44w4p5ufyFvQ+yl10wJvEziZY9Pc
         FvQp7sMqAmcs9pHOCMWToQH8iaW9jbGDKH6iZF8Abison+4thxknZpJGQdizaLKOQnBE
         +pOQhy0/pqgxuXv2X4jjqUnL/7e3sIOce21CmmZvP78awKsKp/BxZDCTIahT9aoT0Tps
         C72f0If/5LL1tIzdlV0EqDjDpS5U2/53BTmVu7TnIk8xveQjvOAaQZYMALRFw3Zmv1io
         U70wCkzotCgXTRjvgFLf1oAK11hlfqLNnAh8mYZB33iYNpLKrqg0nBIQxvP2Gu+Hm7Ho
         Uj3w==
X-Gm-Message-State: AOAM5338E3a3hvRXpIWSA2jQFxfVva3TKjnTDPrp/qgAiWXapV2Vop4/
        s+JGvt1iqtprtO+u02BnlTS3vGfCb8IhZg==
X-Google-Smtp-Source: ABdhPJzwK7K18rnBMFTrICzYlTHZgjYOo2w4VrJC0mzgFJdNByO57nD4PXD/D1VozqVj7WC0X9Ggjg==
X-Received: by 2002:a05:6e02:1887:: with SMTP id o7mr6090806ilu.128.1643915201895;
        Thu, 03 Feb 2022 11:06:41 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f13sm22754536ion.18.2022.02.03.11.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:06:41 -0800 (PST)
Subject: Re: [External] Re: [PATCH v3 2/3] io_uring: avoid ring quiesce while
 registering/unregistering eventfd
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com
References: <20220203174108.668549-1-usama.arif@bytedance.com>
 <20220203174108.668549-3-usama.arif@bytedance.com>
 <ffa271c7-3f49-2b5a-b67e-3bb1b052ee4e@kernel.dk>
 <877d54b9-5baa-f0b5-23fe-25aef78e37c4@bytedance.com>
 <dc6bb53f-19cc-ee23-2137-6e27396f7d57@kernel.dk>
 <ac5f5152-f9e4-8e83-642b-73c2620ce7c0@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5992789-6b0b-f3a8-0a24-e00add2a005a@kernel.dk>
Date:   Thu, 3 Feb 2022 12:06:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ac5f5152-f9e4-8e83-642b-73c2620ce7c0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 12:00 PM, Pavel Begunkov wrote:
> On 2/3/22 18:29, Jens Axboe wrote:
>> On 2/3/22 11:26 AM, Usama Arif wrote:
>>> Hmm, maybe i didn't understand you and Pavel correctly. Are you
>>> suggesting to do the below diff over patch 3? I dont think that would be
>>> correct, as it is possible that just after checking if ctx->io_ev_fd is
>>> present unregister can be called by another thread and set ctx->io_ev_fd
>>> to NULL that would cause a NULL pointer exception later? In the current
>>> patch, the check of whether ev_fd exists happens as the first thing
>>> after rcu_read_lock and the rcu_read_lock are extremely cheap i believe.
>>
>> They are cheap, but they are still noticeable at high requests/sec
>> rates. So would be best to avoid them.
>>
>> And yes it's obviously racy, there's the potential to miss an eventfd
>> notification if it races with registering an eventfd descriptor. But
>> that's not really a concern, as if you register with inflight IO
>> pending, then that always exists just depending on timing. The only
>> thing I care about here is that it's always _safe_. Hence something ala
>> what you did below is totally fine, as we're re-evaluating under rcu
>> protection.
> 
> Indeed, the patch doesn't have any formal guarantees for propagation
> to already inflight requests, so this extra unsynchronised check
> doesn't change anything.
> 
> I'm still more сurious why we need RCU and extra complexity when
> apparently there is no use case for that. If it's only about
> initial initialisation, then as I described there is a much
> simpler approach.

Would be nice if we could get rid of the quiesce code in general, but I
haven't done a check to see what'd be missing after this...

-- 
Jens Axboe

