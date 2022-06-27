Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722B55B488
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiF0ABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0ABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 20:01:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DC2AFC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:01:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so15659648ejb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7B1AcQA6Gzc0Yr5M2dpDTXBq84XMlsgT/yjld4pTYc=;
        b=cb4WKkeMDBPiIKfycaoOb+moATBFwsgREGqiyUaKJuQAP3qpALLueIMe8jY6bCV9wC
         qqBCLzm7RFi01kbt5s8ksRZMDBE9Mo+bvzpaKZ0fb/xFfjAIboiaOfWRKJCX+d/udhlO
         OtVSKapPspVk5YqgZQvJCO5tLALJ4yizrj4DJoF4/XmcRAugwMedIL0M0ITdzdT4fiYS
         wRPoMkHxJkZ1OXFv7NXt7/U9siqzofkhgxCsRLDzzQSl/wn7KaOIzUwzz0mmvvbGHCvi
         GSGJK4B2L+EzGEPSqmsB+0Sxi2SKuPbeQrjRYADQCbpU61CQuoApnooF4yKtU0LaMZte
         d4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7B1AcQA6Gzc0Yr5M2dpDTXBq84XMlsgT/yjld4pTYc=;
        b=2NFu8beJP+qHED3GLJ0MivYbJmyJHAXk8RgXs/h06GOlv/+pHcJQUzSv2IuW7QBlUz
         Cw+mxstU7pv8XZXiL8vLjF2xzt53y2vpiznPt9K9l5uOEjtA19Qah1WMemIcPM+2OlyO
         fWagVc3sNU1k0QVO68TLU3jyRg3szNFr7NMdblQ+2YOjsbru4tjbVhyxfi1O62bfrcZ2
         8E6BaBJvkYISgRoM4CFX9l/e1dZM+MxatjACkFCBEe6FJmCLcy+gGUy4bfnebbyoohRK
         wVaDduWoEiin91ygeNcoY73zNSJUrpTipYK1nY5/l68Je1yMXM6o9ZSAe5zxEQ0sGsvm
         DtmA==
X-Gm-Message-State: AJIora8GI/eViWUTJIKHRPfgrrHdl1i9lxk9pybo1NRAekAINJsYy5lj
        osPfXvqHtXwXs66CsD7AlEBO
X-Google-Smtp-Source: AGRyM1vEqy2OuipXzgZujiYs2E96gYzqUQGlRQbR6EeR/ZxO1lvhOg3UwNQAgmWuiJazyYk8Xuiz3g==
X-Received: by 2002:a17:906:f51:b0:6fe:cf1c:cdbf with SMTP id h17-20020a1709060f5100b006fecf1ccdbfmr9681843ejj.695.1656288069663;
        Sun, 26 Jun 2022 17:01:09 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b00435bfcad6d1sm6658462edz.74.2022.06.26.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 17:01:08 -0700 (PDT)
Date:   Mon, 27 Jun 2022 00:01:04 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrjxcR2M6AD6S9dW@google.com>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
X-Mutt-References: <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
X-Mutt-Fcc: ~/sent
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2022 at 07:19:27PM -0500, Eric W. Biederman wrote:
> 
> Further it is necessary for Peter Zijlstra's rewrite of the kernel
> freezer.   As anything that isn't a special stop state (which
> TASK_UNINTERRUPTIBLE is not) will receive a spurious wake up on when
> thawed out.

Do you know if the current (i.e., prior to the rewrite) kernel freezer
also sends spurious wakeups when thawing tasks?

I'm trying to understand if this source of spurious wakeups will be a
new one or already exists (and might therefore explain what's described
in the original email).

