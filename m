Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAB48A559
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbiAKBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbiAKBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:53:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4674C06173F;
        Mon, 10 Jan 2022 17:53:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so2115954pja.1;
        Mon, 10 Jan 2022 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fC1ynA2u4tRiqaNY787Vx3CQu3oVC9Esks+wHoCfs3c=;
        b=bcIfx1r8Ter1bbkChuxqNTV8CFWNomxYGXj0/9w+BOXPVPyV4FsH8uq+S62rHI8ete
         aWsctPNDKpafHK2k+/NKEghTZmjXklcS9bWPRREOb9TzkAh8K17gIP1iefnqQ1KCcl8/
         u0CefFFzG1RtmJc0wloxw3Nc72ECOqxzWsC6DhCA+BL7mNDN8PU2JNttGI8dpgInUS7p
         umfD9XaXxpV5fD9RqFI2donO4WTCT6PeDFvL4V1QYpPEP3ZQqM7dmrNb/4G6n2vwQMHw
         5mT4t0UF6pGBguKBtTGgle211AEoyZirqlZLGEEa48cFwUfnoUtwsdeOObzz/Hl+SLj7
         ABHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fC1ynA2u4tRiqaNY787Vx3CQu3oVC9Esks+wHoCfs3c=;
        b=wVdPa0/0Nf2GtqW37ypsq+uVoKPSFdZG55k4qpAeNoBwv59EnwKj2stG335kV+omU1
         hTQ1q5N63Vh2wZWWMK1ncs6BvEaafai+lC78IJxf24nuVyBB4JRbGG1MkrcTje5k5yBN
         Gv1PUyvt0jqOqHh+3OrwxC1/SGWTkq/UgpLLQ/kn8DUG4csG2pfrvksnNHiID83Q1Tnh
         Sx3D3YTbcxeuYwuRYYmy7Om2a2ubi4lM0nhG14Jso3HYoYIFKceRIzOzEkHEIUf+DssL
         XVWfeFPZ0faXYDubdZW61cmxHByqneObG4o/Bx9Ktx+RcsdLjhdresZDLnlfyee6+MVH
         2QsQ==
X-Gm-Message-State: AOAM531V0zQdkqZqz3LtPgE5jHjueKPssOYj4GuNkfUnjGh6Jg/tZMAO
        4TysRYSUpZVw7sBDbtpsAPo=
X-Google-Smtp-Source: ABdhPJy8Q4oqX52Fg+EVLq3363cNp3+i0TlppCcuKki5fKvVmIf78IUpjo1oZwCNTAwPJeBHwNbHlA==
X-Received: by 2002:a63:f244:: with SMTP id d4mr2162298pgk.65.1641866021330;
        Mon, 10 Jan 2022 17:53:41 -0800 (PST)
Received: from [172.20.120.1] ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id b21sm8093487pfv.74.2022.01.10.17.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 17:53:41 -0800 (PST)
Message-ID: <2017d0ad-9e76-d1d9-666a-5f2cd7632b31@gmail.com>
Date:   Tue, 11 Jan 2022 09:53:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/13] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
 <Ydxum/2iwp6hDw68@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Ydxum/2iwp6hDw68@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/11 1:36 上午, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 05:10:33PM +0800, Wang Jianchao wrote:
>> This patchset attempts to make blk-rq-qos framework pluggable and modular.
> 
> I really don't think making them policies modular is a good thing, and
> your new exports/APIs are a very good sign for why it is not a good
> idea.

Actually, before sent out this version,  I didn't make them modular but just
pluggable, and yes, it was because I had to export those interfaces. However,
when I made the patch to introduce a policy which support cgroup and had to
increase the BLKCG_MAX_POLS, it seemed worthy to make the previous policies
modular as we can release the blkcg slot when policy module is not installed.

In addition, our own kernel uses the policies as module. When we recommend iocost
to our customer, they love to see we needn't to reboot machine and even needn't to
stop the IO workload if upgrading of iocost is needed

Thanks
Jianchao
