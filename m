Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF057C51F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGUHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGUHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:17:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E87B343;
        Thu, 21 Jul 2022 00:17:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e132so874296pgc.5;
        Thu, 21 Jul 2022 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMrgWXikdhmnULtGMVB6/ctoxfRfcedKdXw/9vM9V9U=;
        b=LlVNNeQcygI8xB5pcV+B99jHiJ+p4dTnESFR47Pq76HCL0Xn2EoX1tSZujfdV0d7l+
         /9BS/qt9QdfJP21DPo3QPRfzj5kEe0EVztmQJyzlDwtTVVr9viZXMDLXBoU5UKcoEViq
         AmW817uZmJd6OpygVldTFyDmliDpP1/Q83aXjG1XXfsXmoA5BhE45PWboe8sb/yHkItz
         ynDxwHRcRsO2ZK2l5N8MhVoIoZUPM3UCIwkKoqGSo/Rxwq0gW+Z4gtmvnM8bGSSQu8Wy
         O6Sl8EG6bfmPSkpBmSHhhlnmPicn3RFtNM9vJFzT42i04469MWIGbz52nFrVAmg7zzis
         gfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMrgWXikdhmnULtGMVB6/ctoxfRfcedKdXw/9vM9V9U=;
        b=4hnFvUr4XdZjWreLZ/Es83Sh3YLU6m6sMJ9xlRh3bpW5DR3cy0ge80Xobiccz0irsC
         ojusVopMuX4Jm+2w+y7g9CPYiFjHXtl5IeJULUR0PpzuUFVZi4vwsAGFNHsOdSAAATUD
         NIuSrRgzLWUIUodd0yqkqZrZI0MMmZ4AQE87NqsQ/myCvzIEniyylDE5gzFb6lOksPDk
         Jp5Cm+pQSNJw3NPeenSeT1YD6Xo74wylu6ze1hr2r2vUxor/4o6ePqEJY3swvXm0ZOTL
         28gRNO6HVRWWgmHoDew7oxp3ffnBisIatZ2LBH6nXV9iuuwtNXLcq39c7LlC2CDmBOJg
         /KIw==
X-Gm-Message-State: AJIora/fUsGopEoEMYQk6q1BFzyD9Ds8BV8R8C5CJx2quKr5xioAok9W
        o44M67b7scCJjKT5cP/KGS+dZa8VU2BL3Dig
X-Google-Smtp-Source: AGRyM1sGm1BCcf+mDJHPRLV+i06dA37dl78TxhNJm/fD3Ce4Bt+9bezlv4gRiKZuaqD6SxGBwuE6Rg==
X-Received: by 2002:a62:b60d:0:b0:528:99aa:da09 with SMTP id j13-20020a62b60d000000b0052899aada09mr42758274pff.86.1658387834246;
        Thu, 21 Jul 2022 00:17:14 -0700 (PDT)
Received: from ubuntu (n058152048107.netvigator.com. [58.152.48.107])
        by smtp.gmail.com with ESMTPSA id 24-20020a630f58000000b00419b66846fcsm720875pgp.91.2022.07.21.00.17.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jul 2022 00:17:13 -0700 (PDT)
Date:   Thu, 21 Jul 2022 00:17:08 -0700
From:   "yuxin.ye" <yeyuxin0925@gmail.com>
To:     Waiman Long <longman@redhat.com>, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rtmutex: Fix BUG_ON at kernel/locking/rtmutex.c:1331!
Message-ID: <20220721071656.GA8109@ubuntu>
References: <20220720072806.43445-1-yeyuxin0925@gmail.com>
 <62de0805-a6ec-f2a1-00f2-1b24a95c72f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62de0805-a6ec-f2a1-00f2-1b24a95c72f0@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:25:17PM -0400, Waiman Long wrote:
> On 7/20/22 03:28, yuxin.ye wrote:
> > before rt_mutex_adjust_prio_chain(),unlock lock->wait_lock will cause
> > BUG_ON at kernel/locking/rtmutex.c:1331:
> 
> The current upstream kernel/locking/rtmutex.c has no BUG_ON() call. Which
> version of the kernel are you using?
> 
> Cheers,
> Longman
> 

The Linux version is 5.10.
The upstream has indeed removed the BUG_ON, But in rt_mutex_adjust_prio_chain()
it is still possible to have a thread is blocked by two locks. Can this situation
be ignored without BUG_ON?

Thanks.
