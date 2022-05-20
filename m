Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE152E6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346767AbiETIBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbiETIB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:01:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487B192A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:01:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 31so7099308pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4jOBgoCIuufL2fmUxuaX4Kx9ZFLT1aVrxdM4anPKWNs=;
        b=m1Nlvcn2IuEUWzBWUWJFzDVxmJvy7P4aU4vT8suamJr2Vnfb3ImW+88kgdzI/VzNuv
         fBhFH1AZXpqgmxPfrQsU9gPk6dXM3vtWVRUoVyoPl0nkkfW2FSHn4fpms9P9Yp9JdbLo
         2PO1dO+lXDtkJTU3vYhXj2/upN35dBk+aNnHXIeIppiZnfJrnmMEe++0O0KGWTDhl1ui
         5DL5SjYA7viNPGTn3b0U8XVXH2Bglr8ljucVX/XV8FrJtwbq5LGOJN/P0rG3mLp0IWPC
         MVERG6jUUuUkoQUCgDuhVjU71udd94YjxzsFmj0TrDESot+2x1dNWtLOb/O1EtgzEVuN
         bmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4jOBgoCIuufL2fmUxuaX4Kx9ZFLT1aVrxdM4anPKWNs=;
        b=wZaUmDo7bP+5PGUA3iU9YGDrUnI+ZI5AFcES/5lHVRpwQ035LWwSguOImPRVfuNl7O
         BU/lm+cK9WWe+f7oXQ1MsXMTqQbJKO/zbCaTxdsV0LzsdF3jumbrDGO1Tohqku2nDO3/
         cLlfIdzkOUx6tzOGYlZHeKmBh5LsWttOe/zLmdvJ5wOGqvElehm4EQgRyzW2Ie7nqihv
         jdMqrPC9UDZCyofhErbhQxXxBW0Mi69CgTpwMXgV90aXnumiFz7rPVvWbMR7s7qf0n+h
         cosCpLOFHVCHVXqM0CQlzoA4obyj2yAR6tO6CkKW2pOSLpesjrfVy1ZTqVJYkJXvnSSl
         SJ+A==
X-Gm-Message-State: AOAM5308vPG8s/zz886o53Vqq+gLkx4WLV+lYU2fyTbKyjdnVNCf88Mi
        aSFpK2h4kiJmcgtshwxU2BTLjdyGKYk=
X-Google-Smtp-Source: ABdhPJxM9CZc6sD2YS0pcbrCemhwqlpq9pXIhVvDfU1vLHXfVtjOMmWTMY42OhitxbxmMX2Mi2B4fg==
X-Received: by 2002:a63:8349:0:b0:3f7:4cb2:686c with SMTP id h70-20020a638349000000b003f74cb2686cmr1672543pge.493.1653033687242;
        Fri, 20 May 2022 01:01:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id a24-20020a62d418000000b005184031963bsm1071789pfh.85.2022.05.20.01.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:01:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 May 2022 22:01:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <YodK1czmhZtGmJ8E@slm.duckdns.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
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

On Mon, May 16, 2022 at 02:00:37PM +0900, Tetsuo Handa wrote:
> This patch is expected to be sent to linux.git immediately before the merge
> window for 5.19 closes, for we need to wait until patches for removing
> flush_workqueue(system_*_wq) calls reached linux.git during the merge window
> for 5.19. Due to this ordering dependency, the kernel build bots complain like
> https://lkml.kernel.org/r/202205021448.6SzhD1Cz-lkp@intel.com , but it seems
> that simply ignoring these reports is the best choice.
> 
> If it is inconvenient for you to send pull request twice from your wq.git tree
> (once for immediately after 5.18 is released, the other for immediately before
> the merge window for 5.19 closes), I can send pull request for this patch from
> my tree. In that case, please give me Acked-by: or Reviewed-by: response regarding
> this patch.

What we can do is sending the patch to Andrew. The akpm patches float above
-next and get applied the last. I won't need any special treatment.

> +/*
> + * Detect attempt to flush system-wide workqueues at compile time when possible.
> + * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
> + * reasons and steps for converting system-wide workqueues into local workqueues.
> + */
> +#define flush_workqueue(wq)						\
> +({									\
> +	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_wq) &&	\
> +			 &(wq) == &system_wq,				\
> +			 "Please avoid flushing system_wq.");		\

It kinda bothers me that this causes a build failure. It'd be better if we
can trigger #warning instead. I'm not sure whether there'd be a clean way to
do it tho. Maybe just textual matching would provide similar coverage? How
did you test this?

>  #endif
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0d2514b4ff0d..08255c332e4b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2794,6 +2794,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
>   * This function sleeps until all work items which were queued on entry
>   * have finished execution, but it is not livelocked by new incoming ones.
>   */
> +#undef flush_workqueue
>  void flush_workqueue(struct workqueue_struct *wq)

Maybe rename the function to __flush_workqueue() instead of undef'ing the
macro?

Thanks.

-- 
tejun
