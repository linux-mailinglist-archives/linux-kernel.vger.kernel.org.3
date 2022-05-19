Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160F52C640
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiERW3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiERW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:29:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF521A961
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:29:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f10so3425354pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GHsUE9N7qwGKPhSfb7FLSZbI7huX80ouMGDrIjhw1Uk=;
        b=tok1tK7PAPs2jl/A5+MZDuzJGG74i7qajPVXyIwM3P53jmWgJKGEW7xAVxKnCBpMuW
         BnKA1MeavVlAHM+qmVYN405lR1GJKzR3fFBXM+n9IgkNThCrONTNOshTDllOgV0aSm2S
         bpSoI4pRydA/Nn0a0wlg8oLEhiZYRUn3g4325mDVoqBkb0dNlvbTWfaHzn7ZNlNUotWk
         lNm6knKRwz6jFbdE+onYhm26Cb5FxhurSbjVKHHpKViUX4kmpXEpRm4R4Hv64WsaZg+D
         s5CpNv4rgXS9RqIgdp3zMSXg1UwgClwDlEWUmWfSEUD++9eq0DBNYmbksnJwUu9qNd6E
         qINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GHsUE9N7qwGKPhSfb7FLSZbI7huX80ouMGDrIjhw1Uk=;
        b=yg0+uzbLo6j+d5qQb1zGBqsZdDltFUriaDgxPFXaU3ZtGFpOdBh4WUaBXWVR0Maxxv
         SvlleOvpWJ8nVz2HCkeVPwSLMoMqtBp1ysYwXUr6lshxyambwhw4zeQJnwS/XQCGvG4w
         s13FPzIl6RWn+1421OGazLOvw9vCM+EtnGtfOZDVLsQIUlbdcxWdrnoApHTk9sTi03fW
         t3+4ogqG2WdI+zjVdj+nVVbf1OGlDEGy0qJIeBqMoZcwj0sMiNf4w6Otdc83m6RmlzcU
         LkSrOuEMdR0h0AZILHlRP6xR/SoPBZ7HxddfnrMhFHMZamJwbeQj/QXSeLcs5huJNF6v
         OBiA==
X-Gm-Message-State: AOAM531PR4jjiWL1V+MRoIYiKOUw5EQGUAlrNbFfHBqqvJYp+lpN8Bfm
        Z8Ur7TeNNvHV6l4y0LWgWgCoIg==
X-Google-Smtp-Source: ABdhPJxPQ+3/S+p5wkyoI6EnBIr0Se7SP74lvulMafErZTqa/eRb6oco6NUfBqYfRV0hsIvy7arjyA==
X-Received: by 2002:a17:90a:3e81:b0:1df:4c26:1786 with SMTP id k1-20020a17090a3e8100b001df4c261786mr1707941pjc.126.1652912977258;
        Wed, 18 May 2022 15:29:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001616723b8ddsm2231887plb.45.2022.05.18.15.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:29:36 -0700 (PDT)
Message-ID: <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
Date:   Wed, 18 May 2022 16:29:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, bh1scw@gmail.com,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220516173930.159535-1-bh1scw@gmail.com>
 <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
 <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 1:28 PM, Marek Szyprowski wrote:
> On 16.05.2022 19:39, bh1scw@gmail.com wrote:
>> From: Fanjun Kong <bh1scw@gmail.com>
>>
>> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
>> Which can serve as RCU read-side critical region, so remove
>> rcu_read_lock/unlock().
>>
>> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
> ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").
> 
> Unfortunately it triggers the following warning on ARM64 based Raspberry 
> Pi 4B board:>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0

Should this use rcu_read_lock_any_held() rather than rcu_read_lock_held()?

-- 
Jens Axboe

