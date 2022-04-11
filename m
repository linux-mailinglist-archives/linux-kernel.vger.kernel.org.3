Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59914FC041
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiDKPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347330AbiDKPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:22:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A9065BE;
        Mon, 11 Apr 2022 08:20:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 17so20571160lji.1;
        Mon, 11 Apr 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwRs58ucT9BHBffcnjN/Epz6AjEi7FoOYtFJGRPRifA=;
        b=Q3RSM0usi4SktvlLI8Zt7gDOwQl21dVSI38BL2S1gdbSZQReSFOx/5GL2ZL9ZIsHwf
         JUWFD0EP5M/sQ1tCihLp9cjx8D0EPTGd7cNScXr83W3kKPvDTfZIWQ3iZckaWuMcIvyw
         iF+EeY9xdlcyZkRxBEvdgJKBMQNL4eUfaW/VnxA5oezjE5PdHQQDQNzbG3k/DNJ4K/pn
         9xHPL7yUQw7ukZvbcT0J3uC2k8eT0YtiqzA5mrAY+mNNYEgAyTc7Ej3wsCVLlzjpPC9M
         LRgyUdy6pK6Q6PaNzub0upnexrrRYoj+tI996jCmwwNtEmMdpyiy6HXu8aGfEoEtQP3o
         +3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwRs58ucT9BHBffcnjN/Epz6AjEi7FoOYtFJGRPRifA=;
        b=FQQQSZKhkTkXaGvycXvXpL0u500UNGjHHwmcJ7WTV3Y8VvHb5bj4rfxLV+rAy9UOrc
         p+j932Sk9ZqC21Q5jNDfLVjLRNIWjMiJfcWyi49U9SNSEmZ1CPWg7Mf2o61qFq5gP3OL
         RL70TpsGH97D2ff6WNP6cBBj254lpAHLZbbxLP19+mcX/Z+rV3HACnmMTCK5PX1e7gET
         T3zNTUpEdcqu436ypyQXKjcGIn6pkIh8GVGPkMOb73njipLgIJoU/gz1YX/Xm2dE/a3Y
         lPe+dhiAY3Hqs2HnSNknVfjIPX3OJewfksxEvz5Us90OzoVZ0czrMH21TRnBWTyuUlyv
         YFpw==
X-Gm-Message-State: AOAM5335Orz+q/8QWs1P+JoIf3PWcFCHEfApPrkPaqSEX0dzO7TJSdou
        P76w1cQqusROwIgGfzHziSg=
X-Google-Smtp-Source: ABdhPJzZgEQdQ9LUYDWLUNfekyt+uGoqDblZ5uQZLkrmmOrJMNg+8ntDYpwfvTo2ocv5PDzdr7VGqw==
X-Received: by 2002:a2e:9e02:0:b0:249:7d50:bd8c with SMTP id e2-20020a2e9e02000000b002497d50bd8cmr20061814ljk.327.1649690407456;
        Mon, 11 Apr 2022 08:20:07 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fa6000000b0044313e88020sm3359928lfe.202.2022.04.11.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:20:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 11 Apr 2022 17:20:04 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        frederic@kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <YlRHJK6ldixwm8IR@pc638.lan>
References: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <YlCtJzlJDj1DBHQB@pc638.lan>
 <20220411140846.GA84069@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411140846.GA84069@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 08, 2022 at 11:46:15PM +0200, Uladzislau Rezki wrote:
> > > 
> > > Here is what I believe you are proposing:
> > > 
> > > 
> > > 				---	rcu_nocbs	rcu_nocbs=???
> > > 
> > > CONFIG_RCU_NOCB_CPU_ALL=n	[1]	[2]		[3]
> > > 
> > > CONFIG_RCU_NOCB_CPU_ALL=y	[4]	[4]		[3]
> > > 
> > > 
> > > [1]	No CPUs are offloaded at boot.	CPUs cannot be offloaded at
> > > 	runtime.
> > > 
> > > [2]	No CPUs are offloaded at boot, but any CPU can be offloaded
> > > 	(and later de-offloaded) at runtime.
> > > 
> > > [3]	The set of CPUs that are offloaded at boot are specified by the
> > > 	mask, represented above with "???".  The CPUs that are offloaded
> > > 	at boot can be de-offloaded and offloaded at runtime.  The CPUs
> > > 	not offloaded at boot cannot be offloaded at runtime.
> > > 
> > > [4]	All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > 	and offloaded at runtime.  This is the same behavior that
> > > 	you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > 	rcu_nocbs=0-N.
> > > 
> > > 
> > > I am adding Frederic on CC, who will not be shy about correcting any
> > > confusion I be suffering from have with respect to the current code.
> > > 
> > > Either way, if this is not what you had in mind, what are you suggesting
> > > instead?
> > > 
> > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > however, I am suffering a senior moment on the right person for Android.
> > > 
> > We(in Sony) mark all CPUs as offloaded ones because of power reasons. The
> > energy aware scheduler has a better knowledge where to place an rcuop/x
> > task to invoke callbacks. The decision is taken based on many reason and
> > the most important is to drain less power as a result of task placement.
> > For example, power table, if OPP becomes higher or not, CPU is idle, etc.
> > 
> > What Joel does in this patch sounds natural to me at least from the first
> > glance. I mean converting the RCU_NOCB_CPU=y to make all CPUs to do offloading.
> 
> Just to be very clear, given appropriate acks/reviews, adding something
> like CONFIG_RCU_NOCB_CPU_ALL to get default rcu_nocbs=0-N is fine.
> However, Joel's original patch would not be good for the enterprise
> distros, which rely on the current default.
> 
Absolutely. It would be even easier in terms of changing the current concept
of RCU_NOCB_CPU config. Having an extra CONFIG_RCU_NOCB_CPU_ALL would simplify 
and get rid of a need of modifying the "rcu_nocbs=" boot parameter.

--
Uladzislau Rezki
