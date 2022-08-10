Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0858EF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiHJPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiHJPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:12:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8876475
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:12:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b7so11190544qvq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zqE5QN7RKVmk2YHbTtyYtC+MguIgPZjXxkethl6ctgA=;
        b=sggmuVXorSSo9shp6QsXUreE1xDk5KtYpauYKQXUtGisH07SF+R5xGI65lfFkLctGy
         bt3BcXRSsi1e2RXviS85X4IeT4d+wYfhp6xZFiBuI7IBlttyKeBN5hBfUDOZ/5NgqowX
         p/4KUnv1tbqfFwP6WVHtvYrTiz2bibd8rVMzSEaqNZmf6nVSQOOJf+R9R5fMu/X2v6Qm
         4XIWf+166lpi+jTjMGXOa+6wNppXqjCYXGqneFDX/H/q0HmMO146FoxkOaVVeIcZrgmi
         BWWQ50nsE6ZyNzK2mllp2HjNoIvAYL8tSYE7tJNU/A4knHfAVWP5e40UQMW26Oj7FjJd
         u+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zqE5QN7RKVmk2YHbTtyYtC+MguIgPZjXxkethl6ctgA=;
        b=Yjg6BIxNu0iKa0RNaJWx8So3lzJuQn83WNIL317Hf3wNmSbe65/cxn5n/NgvM+SOPp
         /GuGM17WLZ9k+h4sSrdyZlncQKzzNm7ZF57Csn9TZ+6O8ELNUePpQCBEqNQa9Evt61uK
         nFUFmX2v5veyC5f9THbtrFzHtzgpBF1U6G0R9dc/nT4Z4l3dHSU5kV1TR/89iCmASoDL
         Vu8qRfz0fT37o3zTb3Ls5+CVBCTWdSwS/SFW4bh6Ij4qPk9fvlT+zeFZvQH5Qh9mNjwD
         lo4Pgfi6l7dAcKrh7mO3mu39xVZIsnmqAd7Gtl4oQgY7keP23KPn/k5CNy3ofWpRMPKS
         xjEg==
X-Gm-Message-State: ACgBeo2lLkFsiIcDRs/oV/32LvckEZCOpdyGNeUS0ZKow79SkOQ4IN2M
        tb3yVwjR5jfaNVeDx9Oj2fmn/w==
X-Google-Smtp-Source: AA6agR4qTmm/zrOkxHqZHOYcoeR40BWzgDnbvDsif1k9rxoVboWqicTi7xt85310ZhaWIRVjyoYFYQ==
X-Received: by 2002:a05:6214:21af:b0:47b:53e7:9f6 with SMTP id t15-20020a05621421af00b0047b53e709f6mr11360332qvc.109.1660144356292;
        Wed, 10 Aug 2022 08:12:36 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id 12-20020a370a0c000000b006b95f832aebsm5640143qkk.96.2022.08.10.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:12:36 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:12:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/psi: Remove unused parameter nbytes of
 psi_trigger_create()
Message-ID: <YvPK49ywg5wr/bOl@cmpxchg.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
 <20220806120510.96131-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-3-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:05:09PM +0800, Hao Jia wrote:
> psi_trigger_create()'s 'nbytes' parameter is not used, so we can remove it.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Right, it relies on \0-termination which the callers psi_write() and
kernfs_fop_write_iter() guarantee.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
