Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12C46DA55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhLHRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLHRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:50:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953A9C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:47:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so10884740edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Me5M3lRIZLgtk8qeyGmh+ByAqQiPLn6X05f8coJ3JQ=;
        b=sWzuRg45lJFUhXEf+A00DwWOCnBBM10OiQMRIhD1kuadTvqcEictGw/4EdwTcmNNqT
         i2XfHqiw5ezLQX/sTo6VOq3ssexr5QdfMvbTl9ZJqc1C29dN6rBd5a9pDeIrxjYw0cED
         EFZkYXcM3ig1NnktSq5GKBgc0Oao/DhN6yROA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Me5M3lRIZLgtk8qeyGmh+ByAqQiPLn6X05f8coJ3JQ=;
        b=FeeOsPJqJ+v7dXIE1XhepgTkYdP00yyYJ4n9HnZ3awRr62V3RT7RPRUgGrB4tYhd3x
         6xh8KNgmMMSDLCcpPTYZ9G+FCLQGKD5W3laSZ8FrbzV2HcJ9koc3nR4gmTMEmHyqc0LF
         oDmjxO301leA8DS6P9OU/o5NNIsulluUaZChnyCunGJIJ8nbSzFCqy+056q32yEGU0SA
         2YJ6wTmkhz/QIvkRyOt4Kh83GHvrbje7sse7KIL1qgIXl8+H3rqHIlyXry98yyqgzqDr
         g5Osd7Pt/vwi+VRc/zjiEhqK3qAtpphBtQ1TvFbpG5QGB5fGXcceVD80VMfShPBJdvSV
         pHtg==
X-Gm-Message-State: AOAM533hF3mjPJZAD9duMxjrtGvPKz/7AGl/IdWR7nvRtZ7a7gntBpkG
        IMzc9BwKI1xTrLE23z4164rUcw==
X-Google-Smtp-Source: ABdhPJztgW4iiSaTnuPGMua3NeMaey4mPTWIgLE/A7qMgk6EBKjA7tz2niYFGxdnJ6qWOCFInWfDZg==
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr22018992edw.318.1638985620992;
        Wed, 08 Dec 2021 09:47:00 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:c7b3])
        by smtp.gmail.com with ESMTPSA id y19sm2373320edq.2.2021.12.08.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:47:00 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:47:00 +0000
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
Message-ID: <YbDvlJFlLYF4X7P6@chrisdown.name>
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
 <Yaj0KTp17AaHMQyC@cmpxchg.org>
 <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
 <YbDvMqgRxBe3IPVS@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YbDvMqgRxBe3IPVS@chrisdown.name>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>I'm with Johannes here, I think this would actively make memory 
>pressure monitoring less useful. This is a NAK from my perspective as 
>someone who actually uses these things in production.

s/memory/io/
