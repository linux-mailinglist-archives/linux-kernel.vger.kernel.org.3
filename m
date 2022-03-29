Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C214EB77E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiC3Aog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiC3Aod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:44:33 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B1182ADF;
        Tue, 29 Mar 2022 17:42:49 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id a5so15737300qvx.1;
        Tue, 29 Mar 2022 17:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljnLROlX8bkk5mDzhK5nV3OjB/DTU2scE/dM3AHH1Ak=;
        b=n9CjvIqXb6mNZr9HcdNTSLG6DwCM81A3Btsodrr+DWkUf0FowUUoKvATYfAkfVjxMP
         qiGDk1Bfnmr5MQcUVTb1XM4myoixvI3CFchn8ksG6xajeT338riyQurbpZcez6usf/aV
         cOeyH03WRgVCtRpK7BwQ/EAjT5LK0hOOJJoRB9ZncwVeU7UNUdCZLhLFR72VINt0Pb5h
         svNRbQox+An+lcQ0xL535JPfoP5NgHZolX3wD3vObnepistmyJ1oLEQ2Kb1h5aNLBm/B
         PcUJA2tuD6j+0rrDAlYZvz1b9dr6V7sODG5kh3iyhchHakaM1iG4Ul7q3hQmQ5lmqAtP
         yfTA==
X-Gm-Message-State: AOAM530G8iPFujl66RLxSmZQw+e6l9D0grKwAuLYnRT0dUCofhsOfo0F
        fyRm/fKOZbQM+moKTEMrR/lqQGG7aXBmVQ==
X-Google-Smtp-Source: ABdhPJz3S9XTXygvxMAnxnJDvWXOXF9D6ZGXqqvlPu6t7bXJvXu78nr9GiWJ1fezOaTi9gi23IVp/A==
X-Received: by 2002:ad4:5bc7:0:b0:441:53a2:169c with SMTP id t7-20020ad45bc7000000b0044153a2169cmr29666782qvt.8.1648600968893;
        Tue, 29 Mar 2022 17:42:48 -0700 (PDT)
Received: from user-VirtualBox (c-73-132-53-127.hsd1.va.comcast.net. [73.132.53.127])
        by smtp.gmail.com with ESMTPSA id m3-20020a05622a118300b002e1beed4908sm16740102qtk.3.2022.03.29.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:42:48 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:36:13 -0400
From:   David Vernet <void@manifault.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] rcu_sync: Fix comment to properly reflect
 rcu_sync_exit() behavior
Message-ID: <20220329193613.2a3g3bkxadocirgm@user-VirtualBox>
References: <20220329222612.1001586-1-void@manifault.com>
 <20220329232256.GE4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329232256.GE4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: NeoMutt/20191207
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 04:22:56PM -0700, Paul E. McKenney wrote:
> As usual, I could not resist the urge to wordsmith.  Please take a look
> at the following to see if I messed something up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b89e06a95c05009bcf31949814c42bc420f414a6
> Author: David Vernet <void@manifault.com>
> Date:   Tue Mar 29 15:26:13 2022 -0700
> 
>     rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior
>     
>     The rcu_sync_enter() function is used by updaters to force RCU readers
>     (e.g. percpu-rwsem) to use their slow paths during an update.  This is
>     accomplished by setting the ->gp_state of the rcu_sync structure to
>     GP_ENTER.  In the case of percpu-rwsem, the readers' slow path waits on
>     a semaphore instead of just incrementing a reader count.  Each updater
>     invokes the rcu_sync_exit() function to signal to readers that they
>     may again take their fastpaths.  The rcu_sync_exit() function sets the
>     ->gp_state of the rcu_sync structure to GP_EXIT, and if all goes well,
>     after a grace period the ->gp_state reverts back to GP_IDLE.
>     
>     Unfortunately, the rcu_sync_enter() function currently has a comment
>     incorrectly stating that rcu_sync_exit() (by an updater) will re-enable
>     reader "slowpaths".  This patch changes the comment to state that this
>     function re-enables reader fastpaths.
>     
>     Signed-off-by: David Vernet <void@manifault.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

The word smithing looks like a good improvement to me!

Thanks,
David
