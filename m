Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F15A961E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiIAL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiIAL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:59:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F710DB;
        Thu,  1 Sep 2022 04:59:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j14so13707237lfu.4;
        Thu, 01 Sep 2022 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=40zYa817WiYSxmkmnaNfAHCBlLNPSiOlFf7sX4yoJeY=;
        b=T/EwlpB3rUFtrQv+/vpPYHHm7dpjqJzOF6Z6f4Gv5jqeXBxbp4M+HCCYHQ6OYmYtMR
         wM7S6P/Tb3AgWTYWxpNFSkEEzdDRt3KWZr1H+dhcnsIao96u9ICE0u8Q8KCDE5oT5z6c
         uylDs6v4/OCsUvrIhDuRWTsLstEUydlLXAGQxaaz1P+qb+h6PyCw23U1iPlWMaHZSCWd
         cZ1unMz/5re6lMtOr68EqCj61XlzG24baRrjJemgEvTwWK8mv5uaR+18ybepEy8xw0Uw
         xmsh4EXw/PlbNxA5OyK2Ye02K+4bmiVFAhmbB7EkpAwpBQNa/FQPGE7ZuDuYBBeOGU/n
         i2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=40zYa817WiYSxmkmnaNfAHCBlLNPSiOlFf7sX4yoJeY=;
        b=UgaMudbhhjxjs3xFeNkN7+TNbaygd5iJZRsedmkXUfknQ5HCF8dEP4ceLtTBJ686IR
         onIQEqiuypqoqQs08pzU4jmzemTgZ3nEDVIMw5LYnoZooJhUWysc5+74SDlKgamdFnjU
         nXAQqgCcfiExEKqBM7LO+5z1gGqIeek1nO2qlvPzeH5/54zhl1g3p/R3EBYVE7kEqNla
         OZD91tgYwdKEGtrkej3cXPXc/HrmpbhH8eg+yq3m+LLHrXj8hSNzKZ8KvEUnTLaAI5LG
         anGxAEgzAxawkIPUAqMJMsKbiqf4FjECWuMjMjPI8Q0VsgpYQIuYc82+RWTyu6P8NoUG
         sLxQ==
X-Gm-Message-State: ACgBeo2R8vPoMp+sOoVQPQs8D1BVm9aSj8mu2ZIetVMUp9oWl4E8pIHM
        jaOn47Dj0qXDBDkZk+Qtuss=
X-Google-Smtp-Source: AA6agR4iR/Yl/YnCJelF2gPpHtDHWFrtwzT65hUeeSTtAjxHpwt5arYO7w0vJ0s5ETpDRvEMMmifcg==
X-Received: by 2002:a05:6512:1524:b0:485:b21c:6015 with SMTP id bq36-20020a056512152400b00485b21c6015mr11381879lfb.611.1662033554181;
        Thu, 01 Sep 2022 04:59:14 -0700 (PDT)
Received: from pc636 (host-217-213-139-238.mobileonline.telia.com. [217.213.139.238])
        by smtp.gmail.com with ESMTPSA id p5-20020a2e9a85000000b0025e4c49969fsm1577526lji.98.2022.09.01.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 04:59:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 1 Sep 2022 13:59:10 +0200
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <YxCejoKH8dGIeW22@pc636>
References: <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
 <20220901112947.GA105556@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901112947.GA105556@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> > Hello, Frederic.
> > 
> > > 
> > > Although who knows, may be some periodic file operation while idle are specific
> > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > periods associated.
> > > 
> > > 
> > Everything related to lazy call-backs is about not waking "nocb"
> > kthreads in order to offload one or i should say few callbacks
> > because it is more or less useless. Currently if incoming callback
> > is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> > to offload.
> 
> Not sure this is only about not waking "nocb" kthreads. The grace period
> kthread is also awaken in !NOCB and has quite some work to do. And there,
> having a server expands the issue because you may have a lot of CPUs's extended
> quiescent states to check.
> 
I mean here the following combination: NOCB + call_rcu_lazy() tandem.
The !NOCB is not about power save, IMHO. Because it implies callbacks
to be processed on CPUs they are landed.

In this scenario you can not let the EAS scheduler to find a more
efficient CPU for further handling.

>
> Also in !NOCB, pending callbacks retain the timer tick of a CPU (see
> rcu_needs_cpu()), and cpuidle relies on the tick to be stopped before
> allowing the CPU into low power mode. So a lazy callback may delay a CPU from
> entering into low power mode for a few milliseconds.
> 
> And I can observe those retained ticks on my idle box.
>
Maybe !NOCB is more about performance. But i have no clue about
workloads and if such workloads exist nowadays.

--
Uladzislau Rezki
