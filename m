Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152B4F9F56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiDHVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiDHVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:48:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CF149D10;
        Fri,  8 Apr 2022 14:46:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o16so7212847ljp.3;
        Fri, 08 Apr 2022 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXyccekD78c7MBXWhEgfVySSP1whQf6ylCa6PcUISgU=;
        b=fW7TvCUjA7CK8g77sojE8srWCGBf+pIISDWmlBfbNARwtY9a7AiigZlinU5qtL6u4v
         yQjDQ/q1eDlyDr07o3Md92Oaku0HAw1NXqYRjYpe03/J5UQcZ9bjKrKQ9L0+5HNRvkPP
         hMu0YaQsXwPx+R2MbdfnItKsBXiDK90oW7SUoOlMUucDRpklqOBLmEdQjY576YFk1Khc
         cv4takR33WUq46HhH3M8gaFRrhmKpOKup38ROmaWMqwHJNdRe0GKIdy3uSjMWzBXmzgc
         sLQbHrlLFMkUzS8VJy5XnH6AsKU946WOG2w+RNXuNfyER/+nqs6gsH4zo2jdPg4x7YGX
         nxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXyccekD78c7MBXWhEgfVySSP1whQf6ylCa6PcUISgU=;
        b=yNbG1A5r34rwwqqt99tpUFM/dmefa58iSkvkd8kKUkJllbvYnE4JPhwfEGMfTbPXQg
         Ol+NWQCAR9AD1KWXS1LwZcs0SIFsHpJM2IjPOO+b3VKcwNIykC/mm0KQBy3ALd5JxDLG
         TgtBVMP8sc0APJTerAzGettn3SnrhAulw9PzAjsBKOe2YphigOI9sGg1BVagSFjXN3WP
         GcKukCgvEBJtgn+zMxADvKC2oNXv0i9F14H1ef/pAfGUCQJl+5gtUm87q/u1HPwDcPbY
         gUMGf1aboQSZZyPgx8tEjvxf5EjfWnNkTyrhge7i4gyG+n24FmuVBf4aG+baSYUbTmP4
         Z6lw==
X-Gm-Message-State: AOAM531cy577DMKTk5YZhrSSx9A5DuKFtnc1v9rpT2phD5qBLKt74mhr
        YacznEcFzyfGa4ZT+RwOUNw=
X-Google-Smtp-Source: ABdhPJz7eGBmARu/8EmwiwUhDvTqwiOYpjHQoyH1Pg4ALlS5kDq0ACgmMQ+dDIk9Kk3IOpSsU32Fcg==
X-Received: by 2002:a2e:a496:0:b0:24b:56ab:2068 with SMTP id h22-20020a2ea496000000b0024b56ab2068mr716638lji.37.1649454377913;
        Fri, 08 Apr 2022 14:46:17 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea446000000b0024b0abb3984sm2138691ljn.134.2022.04.08.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:46:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 8 Apr 2022 23:46:15 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        frederic@kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <YlCtJzlJDj1DBHQB@pc638.lan>
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Here is what I believe you are proposing:
> 
> 
> 				---	rcu_nocbs	rcu_nocbs=???
> 
> CONFIG_RCU_NOCB_CPU_ALL=n	[1]	[2]		[3]
> 
> CONFIG_RCU_NOCB_CPU_ALL=y	[4]	[4]		[3]
> 
> 
> [1]	No CPUs are offloaded at boot.	CPUs cannot be offloaded at
> 	runtime.
> 
> [2]	No CPUs are offloaded at boot, but any CPU can be offloaded
> 	(and later de-offloaded) at runtime.
> 
> [3]	The set of CPUs that are offloaded at boot are specified by the
> 	mask, represented above with "???".  The CPUs that are offloaded
> 	at boot can be de-offloaded and offloaded at runtime.  The CPUs
> 	not offloaded at boot cannot be offloaded at runtime.
> 
> [4]	All CPUs are offloaded at boot, and any CPU can be de-offloaded
> 	and offloaded at runtime.  This is the same behavior that
> 	you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> 	rcu_nocbs=0-N.
> 
> 
> I am adding Frederic on CC, who will not be shy about correcting any
> confusion I be suffering from have with respect to the current code.
> 
> Either way, if this is not what you had in mind, what are you suggesting
> instead?
> 
> I believe that Steve Rostedt's review would carry weight for ChromeOS,
> however, I am suffering a senior moment on the right person for Android.
> 
We(in Sony) mark all CPUs as offloaded ones because of power reasons. The
energy aware scheduler has a better knowledge where to place an rcuop/x
task to invoke callbacks. The decision is taken based on many reason and
the most important is to drain less power as a result of task placement.
For example, power table, if OPP becomes higher or not, CPU is idle, etc.

What Joel does in this patch sounds natural to me at least from the first
glance. I mean converting the RCU_NOCB_CPU=y to make all CPUs to do offloading.

--
Uladzislau Rezki
