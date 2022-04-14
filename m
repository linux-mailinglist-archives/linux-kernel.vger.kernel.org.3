Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424AB501D37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbiDNVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiDNVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:16:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E1D64DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:14:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a11so4792171qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uKVGoGbrYEyx0k0CgPBfM6msY5l8yZ5p4Lnz2+Cc2cQ=;
        b=DABf8MAEYkJJzsAYNNXHuzixYW/Fr8D2oycj5oA/SFoVD9byDD6rPX8GszkCthofMf
         jfeIpswuW6KCZ4D7K06NHctGis3ItS0pW3Q70M4yZVkao52NTuCP561ozdv/uEu2W+PF
         MweF+VAwWzO6AOoaZnzPieoJs6Q15/llDNcPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKVGoGbrYEyx0k0CgPBfM6msY5l8yZ5p4Lnz2+Cc2cQ=;
        b=fjIojsgBGczsma/+hww4E4keyGPcjcxvyS8HPhtCe92JFro4wDt9FVDK0NqddlX3Le
         hEGdq6lT8XMT0UGCufZgXscNiTWe02uMqtw/9gyE7Mmnocbak3NeGMptI4WOZuytfEf3
         348jqCRyMe+YPP8em7JVVGB0CxsIwnch/eW8kqrgqKEw19uvDhxngs9LsZ6F/ozvEpNw
         UJwLuUyQPPdkkV3x4p8qkr0mNgHV3sKkftwQVGKxKaBtf4Ib0Jsi4xpwYb+7kRtHflI3
         ytdjR+sYidAExsX+r0kfyH7rEWedPakAK+rEwdXbrMqwmPLKAtz2QIS3nyJ9Y0j3VvTE
         Sxdw==
X-Gm-Message-State: AOAM530507uW/ZeLxyAns4nj34lo1ZYQCPBNvcqmzu+IxY1Ra/9UZ2o9
        oe4d7dy3OLVJcVldkeQb/1EGEQ==
X-Google-Smtp-Source: ABdhPJx1tNCMWhjWY+hhHDbkYJYxh1X6Fc13wV9da89uHjZElQ08EW1QmpdXf6UabPq1F0Ycdc4/rA==
X-Received: by 2002:a05:622a:3c7:b0:2e1:d537:a15a with SMTP id k7-20020a05622a03c700b002e1d537a15amr3398221qtx.522.1649970846282;
        Thu, 14 Apr 2022 14:14:06 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a270300b0069c5f9304e6sm1432563qkp.48.2022.04.14.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:14:05 -0700 (PDT)
Date:   Thu, 14 Apr 2022 21:14:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <YliOnZC6gva5WZrG@google.com>
References: <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
 <20220414210933.GW4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414210933.GW4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:09:33PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 14, 2022 at 03:49:16PM -0400, Joel Fernandes wrote:
> > On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > > > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > > > [..]
> > > > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > > > >         and offloaded at runtime.  This is the same behavior that
> > > > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > > > >         rcu_nocbs=0-N.
> > > > > >
> > > > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > > > to pass a mask (and I suspect for a large number of users, it
> > > > > > simplifies boot params).
> > > > >
> > > > > Very good, and from what I can see, this should work for everyone.
> > > >
> > > > Just to clarify, what I am going to do is, if this new option =y, then
> > > > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > > > Let me know if we are not on the same page about it though. I do feel that is
> > > > a sensible choice given =y. If we are on same page, please ignore my comment.
> > >
> > > I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> > > the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> > > you at least issue some sort of diagnostic?  After all, the sysadmin
> > > gave a kernel-boot parameter asking the code to do something and the
> > > code is choosing not to do that something.
> > >
> > > Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> > > Kconfig option to affect only the default, that is, when no rcu_nocbs
> > > kernel boot parameter is specified.  This would change the second "[4]"
> > > in my original table to "[2]".
> > >
> > > Thoughts?
> > 
> > I thought about that. I feel that since we are defaulting the new
> > config option to =n , it is a conscious choice by the distro to set it
> > to =y.  In such a case, they should be Ok with offloading all CPUs. If
> > they decide to selectively offload some CPUs in the future, then they
> > could revisit the config option at that time.
> > 
> > I feel the kernel config should override the boot parameter behavior.
> > It is the same effect as a sysadmin passing kernel parameter X
> > assuming the kernel does something but the CONFIG option might not
> > even build code corresponding to X.
> > 
> > I feel to address your concern, we can document in kernel command line
> > documentation that rcu_nocbs= does not have an effect if
> > CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?
> 
> Not me so much, because I would just set CONFIG_RCU_NOCB_CPU_ALL=n so
> as to not worry about it.
> 
> But I am not at all looking forward to complaints about rcu_nocbs not
> working the way people expect.  So let's take some time to think more
> carefully about this.

That's a fair concern. But we are defaulting it to 'n' so I think if it is
unconsciously enabled without someone reading documentation, then that's a
slightly different issue.

On the other hand, I can also make it such that if rcu_nocbs= is passed, then
the CONFIG does not take effect. That's quite a bit weird/quirky IMHO.

thanks,

 - Joel



> 							Thanx, Paul
> 
> > Thanks,
> > 
> > - Joel
> > 
> > >
> > > > > > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > > > > > however, I am suffering a senior moment on the right person for Android.
> > > > > >
> > > > > > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > > > > > is the performance lead. They could appropriately represent their RCU
> > > > > > needs.
> > > > >
> > > > > Sounds good!  Please collect a Reviewed-by from one or both of them.
> > > >
> > > > Ok.
> > >
> > >                                                         Thanx, Paul
