Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43758A10E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiHDTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDTFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:05:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C716D56D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:05:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w3so856477edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jo5NQB6xPqgedkHZirFBS/fgCmZvf+9kpp4HNcb1rhA=;
        b=l/FvIuvVpjnsaGJIH3/3P4y6n0zu1kWqmLWcRMWluzgd/yiI8O1RgBAEsRKgIWS5j/
         XuAEF48zGkshpjcggZ8eaOjc1X3UTcuBWNZGbxqeeuiUu7p0aSS7q5YbqRFCzyiDprtJ
         2T1KUTDfC8pnAyPXZ7RdwWhg1z5OztcTi92SVzPqcQlYO5L8ndlM8HZr0Lw7POifWA52
         NmUILWvNI4eHwzEH9rxrk6Pyx1+ttnXrbRad7KivU1eVYaEwl3s1NfmuCd+y8JYyVbXy
         GsUwXInhf+yMFwUivAgCFYw2JB/rI0LkeLZy4dJe+fw/CucLJ3yMKZKgmRn6SpevKWX4
         pC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jo5NQB6xPqgedkHZirFBS/fgCmZvf+9kpp4HNcb1rhA=;
        b=hYsqIV1HYVuJ5wwOl23SqDDSQ65CPXk70WwB8ghR+C5qXadvezzlYTdRLgM6f3xV5X
         xVYc6VKdutDUXKeJ5DTu4AIWFSV7o1W3Gj+ofeQ9ccBLPobQD5Tqze1GIuSQGsC3nEv2
         fnhX6PFpD3DA6MP5wM3C1CRhgE2vJoC3EtvxPa1r4vbfjGTy96QvsSja6okqWR+HygzA
         o7/0czJSTfVPiIPKMCWWBlPEJi4DbkyNsA4UrEcNLnjdHSeJA1emBW2DNlgdwChKb9bH
         JyAerdBQI6kCQx1eukjUWpfsE9vQzGQDnbrEav7mcLnNuP1cmK04HecyQyTLvEOlYQZK
         mLjw==
X-Gm-Message-State: ACgBeo21spWvCU8F7j626yxvzV3gxR4pnNOr6vdM4RnKxf8NKn3QgqXb
        02o3AsES/xhhbKybnL04zxY=
X-Google-Smtp-Source: AA6agR7ryCIvXOqGa2mqceYBxgos1LIVq1vMRi3TsrqqulFkJjfxQ/2fNkd+X7/ScEikZof1P3Zsmg==
X-Received: by 2002:a05:6402:51d4:b0:43d:9c8e:2617 with SMTP id r20-20020a05640251d400b0043d9c8e2617mr3539374edd.146.1659639908352;
        Thu, 04 Aug 2022 12:05:08 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b00705cdfec71esm642088eja.7.2022.08.04.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:05:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 21:05:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] sched/fair: Remove unused parameter idle of
 _nohz_idle_balance()
Message-ID: <YuwYYZWKc/KXVDy7@gmail.com>
References: <20220803130223.70419-1-jiahao.os@bytedance.com>
 <20220804114128.GH3493@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804114128.GH3493@suse.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@suse.de> wrote:

> On Wed, Aug 03, 2022 at 09:02:23PM +0800, Hao Jia wrote:
> > Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> > has been merged. The parameter idle of _nohz_idle_balance()
> > is not used anymore so we can remove it.
> > 
> > Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Just note that with the merge window open, this may not be picked up
> quickly and you may need to send a v3 when the merge window closes.

It's already in tip:sched/core. :-)

Thanks,

	Ingo
