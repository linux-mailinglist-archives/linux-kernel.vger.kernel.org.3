Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A7501BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiDNTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbiDNTWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958B8B644D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a5so4834801qvx.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AmOv5rtWsBjN+AH3Yiwh3/xuZYgmQM8D4+J7GjX0x60=;
        b=HopD3qrAEWycdOfimAP39aurNTsYZT/k4CNX23xV4pYQRBDzfqGfZmdo/hskHJEDDq
         eyI7fHLthCq8riD92+r3ERUkkLegaIc7DSazq9AJIS8DoBLzFSQgQzsCppKaIZUwmt+O
         unHHUfKfCq1xHxSOf03GpNReZrzdcEKaUdHv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmOv5rtWsBjN+AH3Yiwh3/xuZYgmQM8D4+J7GjX0x60=;
        b=dv35Y1z9ewCuZCibU5MY86Kapu2eIz116r6d4EZrLyfzbJwVRUpyHBbhERn+yVbGWJ
         XTj0KMb5Q1oq6d9pxfkZxxDK1T2HhbBx+JlmbUXPi05iociacR6JddcdCAy3425xVBuA
         CvWCX5BaByX+HDy3IV9ZXSxNXdqKlLdmZebSvgjUAqG8sMI9HY2D28Ccba7Sbim7ie6V
         PqwISLdZ5MaQOVH8D9Bk3FcmgMNwUUPa8jEmfbFDC2j3igixoWi5YxHBiZNaj10HZRw6
         WY/iNXui5CsidwHpfvQ/JLXyPAFoA0jvJfi2vYZth1eQoH6EZkSuEYuPYubBkq0sVFhG
         AkVg==
X-Gm-Message-State: AOAM5302i+HmQORMVHVAKg7Yp0mcx4vpcCXLw0Wtb1hnzx83le5TmpNL
        ARWwhldrURNkWZfTHDjAzO9C2w==
X-Google-Smtp-Source: ABdhPJyga0NX+wOgXs9y23L4yB3ht5AzMjEnNjGwPgsAEO1IpewiA3RRQlb9oQk0hYxufs1bdCeEmw==
X-Received: by 2002:a05:6214:19c8:b0:444:32f0:2351 with SMTP id j8-20020a05621419c800b0044432f02351mr14188611qvc.109.1649963989216;
        Thu, 14 Apr 2022 12:19:49 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w17-20020a05622a135100b002ef480d2559sm1718617qtk.34.2022.04.14.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:19:48 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:19:48 +0000
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
Message-ID: <Ylhz1LOIf+JyjH7n@google.com>
References: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
[..]
> > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > >         and offloaded at runtime.  This is the same behavior that
> > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > >         rcu_nocbs=0-N.
> > 
> > Yes, this is the behavior I intend. So then there would not be a need
> > to pass a mask (and I suspect for a large number of users, it
> > simplifies boot params).
> 
> Very good, and from what I can see, this should work for everyone.

Just to clarify, what I am going to do is, if this new option =y, then
rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
Let me know if we are not on the same page about it though. I do feel that is
a sensible choice given =y. If we are on same page, please ignore my comment.

> > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > however, I am suffering a senior moment on the right person for Android.
> > 
> > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > is the performance lead. They could appropriately represent their RCU
> > needs.
> 
> Sounds good!  Please collect a Reviewed-by from one or both of them.

Ok.

thanks,

 - Joel

