Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1904C1E72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiBWW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBWW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:29:33 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249E40A16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:29:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d187so180337pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pw8TvNgVlmBgIO6YzpKLPyWHQoVH27zBH28hkdeGag0=;
        b=b9LdrnU6kfLF2sK90sOS6OzKcOThXn0v0jgQIIuKOIbQqhDSBIOFj4bY+5DEoKiHGB
         Wp9z9Muzp8OQcbiuxOYa1jxPhTXMyK8ooFvPXmlcLuKU50Ect7n06wRM+POVS3QojYV6
         S6Q3VmYFzPydMkG30X9Rr55m+2WYui7pJwwLqGPMEAhRtG/ZzTzNTlSb0o4CA7+jHkHB
         lZWXQoB8To3G0frEyWeoa7dzUehJvkK1xCezs5UYTfxCrU2SjN2T3LL6C37iWoX+qzhK
         PTH6DYeO6+4SLWXxgMOTQS4HMy1GdO5JSDGulAbxIP1YbWypdQJMaVNJNGuU3rqHT+1Z
         5wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pw8TvNgVlmBgIO6YzpKLPyWHQoVH27zBH28hkdeGag0=;
        b=z9DJiTTy1pU3A+C72ZER1AxgtpEILpFfQ6wzqct9eiSDNG4dCKPNhT3TyhkDyUSXUO
         DaiMMm/mBy3C/jweALL3p14KB63quHfce7hTmjycUPlAEbl2W9N1rgAfo/9xyNTRo2cC
         tpkD2hMO7JRUqQI/enWZWVcFLKj/8YxyE0E+7rSWxp7kfjEW4hRzoikKxP5ZYISE/Y5c
         AyAr8Ya+jlbYvK4mDMUPCLHT/uQjXEMH5Mb9pSxLvBKCbZQHPNRS3APwovf8YdJhRxkM
         EWyCy+j3Caa34KJy1/WpVAMZpS4/ZdltGWo//OSA9Xi8DbcHZF66Vuv59VPSpWLOP/a1
         zCTw==
X-Gm-Message-State: AOAM531fhu4i7lu3gRJxx5ZyBmZ9wmEhmp886cvzxh6LX/D1jYD79fnO
        VID8mt8gSSSeG+kRy32v9qmIsBLJJeg=
X-Google-Smtp-Source: ABdhPJyGHqmZKFXh00p1Cd7gLdMDjPzhD5klBY28QmO30FPwowF/q6+Rl1jnZVrxswb3yitJqpfDUw==
X-Received: by 2002:a63:707:0:b0:373:9e4f:f56b with SMTP id 7-20020a630707000000b003739e4ff56bmr1327606pgh.565.1645655343865;
        Wed, 23 Feb 2022 14:29:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i11sm467292pgs.58.2022.02.23.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:29:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Feb 2022 12:29:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: Use private WQ for schedule_on_each_cpu() API
Message-ID: <Yha1LeX4OK3cLCV5@slm.duckdns.org>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
 <YhUdjip4VSWe4zDO@slm.duckdns.org>
 <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
 <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
 <9a883d72-ea7d-1936-93e6-5c2a290509d4@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a883d72-ea7d-1936-93e6-5c2a290509d4@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:26:30AM +0900, Tetsuo Handa wrote:
> > The patch seems pretty wrong. What's problematic is system workqueue flushes
> > (which flushes the entire workqueue), not work item flushes.
> 
> Why? My understanding is that
> 
>   flushing a workqueue waits for completion of all work items in that workqueue
> 
>   flushing a work item waits for for completion of that work item using
>   a workqueue specified as of queue_work()
> 
> and
> 
>   if a work item in some workqueue is blocked by other work in that workqueue
>   (e.g. max_active limit, work items on that workqueue and locks they need),
>   it has a risk of deadlock
> 
> . Then, how can flushing a work item using system-wide workqueues be free of deadlock risk?
> Isn't it just "unlikely to deadlock" rather than "impossible to deadlock"?

If we're jamming system_wq with a combination of work items which need more
than max_active to make forward progress, we're stuck regardless of flushes.
What's needed at that point is increasing max_active (or something along
that line).

Thanks.

-- 
tejun
