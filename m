Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE14A892A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352463AbiBCQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBCQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:59:00 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC071C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:59:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id d3so2603698ilr.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hnNStLLfw2FHaWSpq9EzzqFXeWS4HqySix/xq3cDScY=;
        b=4j1Iez5JQ1Zsf2GFZrvfuEys0VR/h8RdRwkREyilwcCkxUKp7HB0hPuvVlsqqMLqoX
         zB5NOXdK1Ow5sov9DmbCt05U1OqnOQ+WLPNClqSbb0fEZck+bJYxq0Drp0oZjXIe9mw+
         l/JBPjsfHZKn5biUnP/zrjJ2moSK4/k0TkACb2zIaoeb1tfYyOByrT7bdJzzgmlc4YcC
         e0GCm1vNVQcUtTPTzc1lR2tirQIh/KX21Yl2evZLTqphzEvWHXruLM9jhhQiFI0phlhA
         j01Ay2SXhYkZydTxWWq2F4MFS2mXGfWW505SENj/ZaTWhT63csc0Bnc0bP90luaangHj
         7iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hnNStLLfw2FHaWSpq9EzzqFXeWS4HqySix/xq3cDScY=;
        b=dpyEo1LcIC+rNqnIuDZL78Ble/Sz1FE3/RDuL4fxl8YC3qFAL3Tm8WbVrfTGedvcbL
         rlCKYIvHq8tzwxC59IEWZE5A1g8OvLgE/ew9zSxJ/Ovl0rNy7LFDVjTShJt8sQkeCSBl
         XEPQiGKMBp+1uYh0ZxVzLbtg+YKDynosk2kmY/+swRgGAn+tZxRDHTuFmtKDrZF+Q7mN
         G+YUj3yG7wAuINvoGvVjDrHvLCqimB8LztEhhkybLaxJEK/klICWaOY1P6bOFjewdjn5
         v/RSS6TXEG0gA04A1CquEZPTZVhtlaSkjgFmHi9BSZX0MjGYVjjN0rePbkRlmrYBqrDg
         USDw==
X-Gm-Message-State: AOAM532v71Riw2Fa/tTj66dljWHsOTPOLq4mAvYulNeW8vQ4ngM17nDw
        813LLSmVxZ3arN2iI2wL/Vbcuw==
X-Google-Smtp-Source: ABdhPJzKmxT5Y5LoG8Sy1lHouAvCO5GCoizaJw7fx+OSIxC3Wbyl+G5aCiuv6pFMkg0S0CnrYdJg5A==
X-Received: by 2002:a05:6e02:b46:: with SMTP id f6mr19730584ilu.235.1643907539828;
        Thu, 03 Feb 2022 08:58:59 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11sm22816858iob.23.2022.02.03.08.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:58:59 -0800 (PST)
Subject: Re: [PATCH 1/2] io_uring: avoid ring quiesce while
 registering/unregistering eventfd
To:     Usama Arif <usama.arif@bytedance.com>, io-uring@vger.kernel.org,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com
References: <20220203151153.574032-1-usama.arif@bytedance.com>
 <20220203151153.574032-2-usama.arif@bytedance.com>
 <87fca94e-3378-edbb-a545-a6ed8319a118@kernel.dk>
 <62f59304-1a0e-1047-f474-94097cb8b13e@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da09cb46-9d60-71a3-a758-46d082989bae@kernel.dk>
Date:   Thu, 3 Feb 2022 09:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62f59304-1a0e-1047-f474-94097cb8b13e@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 9:49 AM, Usama Arif wrote:
>> One thing that both mine and your version suffers from is if someone
>> does an eventfd unregister, and then immediately does an eventfd
>> register. If the rcu grace period hasn't passed, we'll get -EBUSY on
>> trying to do that, when I think the right behavior there would be to
>> wait for the grace period to pass.
>>
>> I do think we need to handle that gracefully, spurious -EBUSY is
>> impossible for an application to deal with.
> 
> I don't think my version would suffer from this as its protected by 
> locks? The mutex_unlock on ev_fd_lock in unregister happens only after 
> the call_rcu. And the mutex is locked in io_eventfd_register at the 
> start, so wouldnt get the -EBUSY if there is a register immediately 
> after unregister?

The call_rcu() just registers it for getting the callback when the grace
period has passed, it doesn't mean it's done by the time it returns.
Hence there's definitely a window where you can enter
io_uring_register() with the callback still being pending, and you'd get
-EBUSY from that.

-- 
Jens Axboe

