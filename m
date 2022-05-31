Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6953895D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 02:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiEaA52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 20:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiEaA5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 20:57:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551E3BF87;
        Mon, 30 May 2022 17:57:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y189so11781144pfy.10;
        Mon, 30 May 2022 17:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKhShsfiT2r28A+fu81TmppkwbIBz2mmfhB9NKRPYFo=;
        b=bZiRP/GtKDRv9+avrEUa1P1Mbcv0KKMQZwjUkS2Vq+nkrWWLots75jlKFStd7Ovv/J
         nscWLYeV+OmOdAkwbyGbBrb6NvLvXQ1GNVR27t8E3q/H4acAtEYK/IOZ1ByR3PeJpoLs
         XbV0W9py7wZPfwfOLABb8ZF1qqsmQ/2aiXImehE7YE1d6Flyb4QUg8V6At31hOqWOHqN
         gcZqjXme2PO7uNtlq8mqRfaLnr93LLlb4hOxnZBLqbfcX4BhgQbs+2zPNBPRQoCKISmS
         oDYx2GGXULX9jBHYbzosLpwXhq9vz5bKYSB2Rts1cgF3Mhr3Sx4jw0BJUIKJFhxtdv/G
         mzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vKhShsfiT2r28A+fu81TmppkwbIBz2mmfhB9NKRPYFo=;
        b=FePRoI56P8BznmNVLCSYSJI23lkfeqIo5zRjOIlzLvHTgwWFZ3q8kzEZNemLhi2pgX
         8LEXU1CQ2Udid1AbAe31jrzdwlAzzm0+jwFPxeQrFnvCUlbGJ24Vl93cIWEHdcPs24p4
         3m3DKmAKiOjvzzdBE93Vps4wGWjNQpVVBEEDrp8/yb7TM/ul2hUajGlAyUc2B8ac97EI
         6ebpzK6Qp6n5hnkrXB0nlS/CSqV7w+RSc5VOPngCxM4C6d6fQ3Sh17k1pmkCnGH0scV/
         HUr/8E7H/q3Hdc2L+pEpl0mEG8BQfV/zccUAcItyMYIcEyQ95KqE/4wydikhfprT7jdY
         ftlg==
X-Gm-Message-State: AOAM532FfbIpmmDxQvilJdG/IFil2iMAr3CJg5sz1/bsFAy48QUNJiHO
        enRlyVmGzF1f4/e8+Ql/AiM=
X-Google-Smtp-Source: ABdhPJwg8wt8ARE9Zr2M6p7VzhpEQskxAq0yxi3eaqnuSRuyzFpcHxXWrmxvwk52NPJv22e0JW7r8g==
X-Received: by 2002:a63:c04a:0:b0:3fa:7277:964c with SMTP id z10-20020a63c04a000000b003fa7277964cmr33359644pgi.499.1653958640158;
        Mon, 30 May 2022 17:57:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a7b8400b001e2fad8373asm306473pjc.36.2022.05.30.17.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 17:57:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 May 2022 14:57:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <YpVn7XXE20vwbS3Q@slm.duckdns.org>
References: <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
 <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
 <20220530213556.GD1257179@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530213556.GD1257179@lothringen>
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

On Mon, May 30, 2022 at 11:35:56PM +0200, Frederic Weisbecker wrote:
> That makes sense. So there would be a simple cpuset.isolation that can
> be either 1 or 0 where 1 has all possible isolation stuff on. Then
> if the need arises we can provide more tuning through a new specific
> cgroup controller, right?

Given that there isn't much that is hierarchical about them, I'm pretty
skeptical about introducing a new controller or fancy hierarchical interface
for it. If isolation is intertwined with cpuset partitioning and a simple
knob for it fits well with the rest of configuration, yeah, but let's please
try to avoid maximizing the interface. We want the interface to encode
users' intentions (e.g., here, I want these cpus isolated) not the
implementation details to make that happen. Of course, there are gradients
but it becomes really ugly when you try to expose low level details on
cgroups because of the implied flexibility (I can organize however I want
hierarchically and the controls must nest and be delegatable properly).

So, If you think isolation feature will need lots of low level knobs
exposed, cgroup isn't the right place. It should be something simpler and
lower level. This probably is a good time to spend some time thinking how
it'd look like, say, five years down the line. If it's gonna be the "I want
isolation" knob + maybe some obscure system wide knobs that most people
don't need to think about, it's gonna be fine. Otherwise, we shouldn't put
this in cgroup until we have better ideas on what the interface should look
like.

Thanks.

-- 
tejun
