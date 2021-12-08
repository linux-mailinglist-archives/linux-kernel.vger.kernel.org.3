Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDB46DA4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhLHRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLHRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:48:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777FC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:45:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so10693088eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxcdhkn8MQwqsKhhsktfOoJBZWiG64ZAMlkAvsTSfVM=;
        b=bklVbzkbUGBwjDoMWCU9oCeiQU/fml9+ixZOPvoWGSvUOg21/WdR/YzOcdNu5tfd8U
         L02k0yYpHQXnIdwVoiqmEfhQfktTepwBShNNLOWmmdsSehBnhWHjAeHnamQ/t0nTjAb4
         wtsARPLOcpjoSP6WSRHnXqwXoG9iEKWkB2cSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxcdhkn8MQwqsKhhsktfOoJBZWiG64ZAMlkAvsTSfVM=;
        b=dpyKWP4Is4HIeC59Olw7Qud8G8YoIijzqQHAH3rpzHfvbzf4xzpKnQs3CsJM2BvXiR
         S790csEkStvrQThz2w/shhI7Rwimnf8x2ZA68u3mfyrZh3NGPL88zRwzJ1r3qSXZsgHQ
         skA4Kj/cY54hIr2f+zGDs/7+eMeqdgNn22Ps17RBFs+OPSVajVEs8Qgnowcd3rHd1Gkn
         JYweNPqPhWRa4NgNYUafy5eojmFr4WfaMU8heBqapm4UpFGUFxEEmc7C8cgpvvfTN1o2
         6bvuiefzQDGRsBDnmBJWRQBsCUNwId0yQajQgSIlUCmCqWi0ubQM92APeo7mPQeeVLIX
         0GEA==
X-Gm-Message-State: AOAM531AxVu+NhTXQRVOMi0djBwHrdv4Z4wCtUsJa41Z6+hg1Ww0b7wW
        RPxafLc/gTZje85/0w2A3ibjvQ==
X-Google-Smtp-Source: ABdhPJzJBM98HPC9I/dyQUGgvQpo8g8Rx5F5FXP/fYY5//OaIshH7PydXpRqRfGELJe7tqQGqAexeg==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr9100912ejr.360.1638985523255;
        Wed, 08 Dec 2021 09:45:23 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:c7b3])
        by smtp.gmail.com with ESMTPSA id ga26sm1749285ejc.11.2021.12.08.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:45:22 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:45:22 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
Message-ID: <YbDvMqgRxBe3IPVS@chrisdown.name>
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
 <Yaj0KTp17AaHMQyC@cmpxchg.org>
 <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoyang Huang writes:
>No. Block device related D-state will be counted in via
>psi_dequeue(io_wait). What I am proposing here is do NOT ignore the
>influence on non-productive time by huge numbers of in-context swap
>in/out (zram like). This can help to make IO pressure more accurate
>and coordinate with the number of PSWPIN/OUT. It is like counting the
>IO time within filemap_fault->wait_on_page_bit_common into
>psi_mem_stall, which introduces memory pressure high by IO.

I think part of the confusion here is that the name "io" doesn't really just 
mean "io", it means "disk I/O". As in, we are targeting real, physical or 
network disk I/O. Of course, we can only do what's reasonable if the device 
we're accounting for is layers upon layers eventually leading to a 
memory-backed device, but _intentionally_ polluting that with more memory-bound 
accesses doesn't make any sense when we already have separate accounting for 
memory. Why would anyone want that?

I'm with Johannes here, I think this would actively make memory pressure 
monitoring less useful. This is a NAK from my perspective as someone who 
actually uses these things in production.
